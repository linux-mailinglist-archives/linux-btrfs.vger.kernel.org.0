Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34DD5B529E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 03:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiILByp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 21:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILByo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 21:54:44 -0400
Received: from out20-145.mail.aliyun.com (out20-145.mail.aliyun.com [115.124.20.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DAC65D7
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 18:54:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436316|-1;BR=01201311R561S54rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00425851-0.00028118-0.99546;FP=15474400971615456443|3|1|4|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.PDRv0Co_1662947678;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PDRv0Co_1662947678)
          by smtp.aliyun-inc.com;
          Mon, 12 Sep 2022 09:54:38 +0800
Date:   Mon, 12 Sep 2022 09:54:47 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: core dump in btrfs receive (while handling a clone command?)
In-Reply-To: <f3eee248-fd90-4048-8ae0-536997b4c273@inwind.it>
References: <f3eee248-fd90-4048-8ae0-536997b4c273@inwind.it>
Message-Id: <20220912095444.B342.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> Hi everyone,
> 
> I am experiencing a segmentation fault in "btrfs receive" and I would
> really appreciate any help the developers could give me.
> 
> The error happens when performing an incremental send from an external
> drive back to my main btrfs RAID-1 data store. Both the source and
> destination file systems contain the same base read-only snapshot.
> 
> The file that causes the problem is a bit "special": it is a sqlite3
> database which is written by a batch process. Before each run, I do a
> cp --reflink to a backup file, and then set the immutable flag on the
> reflinked copy. The source file is then modified by my batch process and
> eventually sent/received in snapshots that contain both the modified
> file and its reflinked copy. The source btrfs snapshot is not
> necessarily taken right after the cp --reflink / chattr +i.
> 
> Let's be general and say that the operation order is (fictional path
> names):
> 
> On the "main" datastore:
>    # cp --reflink /main/live/db.sqlite3 /main/live/db.backup
>    # chattr +i /main/live/db.backup
>    [do something to /main/live/db.sqlite3 modifying some parts of it]
>    # btrfs snapshot -r /main/live /main/backup-before
>    [this snapshot was sent to an external drive. Everything went ok, no problems here]
> 
> On the "external" drive (omitting a snapshotting pass to make the
> /backup-before snapshot writable again):
> 
>    [do something to db.sqlite3 modifying some parts of it]
>    # btrfs snapshot -r /external/live /external/backup-after
> 
> The crash happens when trying to send an incremental stream from the
> external drive back to my main datastore (commands simplified once
> again):
> 
>    # btrfs send -p /external/backup-before /external/backup-after | btrfs receive /main
>    At subvol /external/backup-after
>    Segmentation fault (core dumped)
> 
> I am on Fedora 36 with its current distro packages:
> kernel 5.19.8-200.fc36.x86_64, btrfs-progs v5.18.
> 
> This is the maximum level of detail I could achieve:
> 
> 
> 
> 
> # coredumpctl info
>             PID: 3152 (btrfs)
>             UID: 0 (root)
>             GID: 0 (root)
>          Signal: 11 (SEGV)
>       Timestamp: Mon 2022-09-12 02:21:52 CEST (29s ago)
>    Command Line: btrfs --verbose receive --max-errors 0 /main
>      Executable: /usr/sbin/btrfs
>   Control Group: /user.slice/user-1000.slice/user@1000.service/app.slice/app-org.kde.konsole-3174091612104ca498465f6bcf3fb1ca.scope
>            Unit: user@1000.service
>       User Unit: app-org.kde.konsole-3174091612104ca498465f6bcf3fb1ca.scope
>           Slice: user-1000.slice
>       Owner UID: 1000 (ant)
>         Boot ID: 2799d9eb6dbd423aa57676cad3e64ee7
>      Machine ID: 21b44b8aef264e2181bdb4c7c9beca87
>        Hostname: cuben.lan
>         Storage: /var/lib/systemd/coredump/core.btrfs.0.2799d9eb6dbd423aa57676cad3e64ee7.3152.1662942112000000.zst (present)
>       Disk Size: 58.2K
>         Message: Process 3152 (btrfs) of user 0 dumped core.
> 
>                  Module linux-vdso.so.1 with build-id ef533bb262f1a045f813981c3d60075160f0756a
>                  Module libgcc_s.so.1 with build-id ba60d61c81d3c90075c6a172f22972d643a41cc9
>                  Module ld-linux-x86-64.so.2 with build-id 1eacb7c50f7ed20ef1fefda3aa9c67377686acf5
>                  Module libc.so.6 with build-id 9c5863396a11aab52ae8918ae01a362cefa855fe
>                  Module libzstd.so.1 with build-id e9ef04083d00304da3a4e6638d4d21cf65518077
>                  Metadata for module libzstd.so.1 owned by FDO found: {
>                          "type" : "rpm",
>                          "name" : "zstd",
>                          "version" : "1.5.2-2.fc36",
>                          "architecture" : "x86_64",
>                          "osCpe" : "cpe:/o:fedoraproject:fedora:36"
>                  }
> 
>                  Module liblzo2.so.2 with build-id cfe9fae541ae0995689232b4bafe60ee4b99fd30
>                  Stack trace of thread 3152:
>                  #0  0x0000560c9a53ce91 process_clone (btrfs + 0x70e91)
>                  #1  0x0000560c9a51eb0c btrfs_read_and_process_send_stream (btrfs + 0x52b0c)
>                  #2  0x0000560c9a53e0c9 cmd_receive.lto_priv.0 (btrfs + 0x720c9)
>                  #3  0x0000560c9a4e3cae main (btrfs + 0x17cae)
>                  #4  0x00007f960a0df550 __libc_start_call_main (libc.so.6 + 0x29550)
>                  #5  0x00007f960a0df609 __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x29609)
>                  #6  0x0000560c9a4e3ff5 _start (btrfs + 0x17ff5)
>                  ELF object binary architecture: AMD x86-64
> 
> 
> 
> # dmesg --human
> btrfs[3152]: segfault at 56 ip 0000560c9a53ce91 sp 00007ffdd23940a0 error 4 in btrfs[560c9a4e2000+9f000]
> Code: 31 c0 41 bc fe ff ff ff e8 7c aa fd ff e9 97 fe ff ff 0f 1f 80 00 00 00 00 41 89 c4 48 8d 3d be a7 06 00 31 c0 e8 5f aa fd ff <49> 8b 7f 58 e8 86 5f fa ff 4c 89 ff e8 7e 5f fa ff e9 69 fe ff ff
> 
> Installing debug symbols and looking at the backtrace it seems that the
> error is caused by a "free(si->path)" in cmds/receive.c:793 (I think
> this might be
> https://github.com/kdave/btrfs-progs/blob/v5.18.1/cmds/receive.c#L793):
> 
> 
> 
> # gdb btrfs core.btrfs.0.2799d9eb6dbd423aa57676cad3e64ee7.3152.1662942112000000
> GNU gdb (GDB) Fedora 12.1-1.fc36
> [...]
> Core was generated by `btrfs --verbose receive --max-errors 0 /main'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  process_clone (path=0x560c9bd24a80 "db.sqlite3", offset=1045131264, len=10760192, clone_uuid=<optimized out>, clone_ctransid=440,
>      clone_path=0x560c9bd24b40 "db.sqlite3", clone_offset=1045131264, user=0x7ffdd23aa3f0) at cmds/receive.c:793
> 793                     free(si->path);
> (gdb) bt
> #0  process_clone (path=0x560c9bd24a80 "db.sqlite3", offset=1045131264, len=10760192, clone_uuid=<optimized out>, clone_ctransid=440,
>      clone_path=0x560c9bd24b40 "db.sqlite3", clone_offset=1045131264, user=0x7ffdd23aa3f0) at cmds/receive.c:793
> #1  0x0000560c9a51eb0c in read_and_process_cmd (sctx=0x7ffdd2396200) at common/send-stream.c:422
> #2  btrfs_read_and_process_send_stream (fd=<optimized out>, ops=<optimized out>, user=<optimized out>, honor_end_cmd=<optimized out>, max_errors=<optimized out>) at common/send-stream.c:525
> #3  0x0000560c9a53e0c9 in do_receive (max_errors=<optimized out>, r_fd=0, realmnt=0x7ffdd23a63f0 "", tomnt=<optimized out>, rctx=0x7ffdd23aa3f0) at cmds/receive.c:1111
> #4  cmd_receive (cmd=0x560c9a5c9c40 <cmd_struct_receive>, argc=<optimized out>, argv=<optimized out>) at cmds/receive.c:1314
> #5  0x0000560c9a4e3cae in cmd_execute (argv=0x7ffdd23ad638, argc=4, cmd=0x560c9a5c9c40 <cmd_struct_receive>) at cmds/commands.h:125
> #6  main (argc=4, argv=0x7ffdd23ad638) at /usr/src/debug/btrfs-progs-5.18-1.fc36.x86_64/btrfs.c:405


It seems the bug fixed in
https://github.com/kdave/btrfs-progs/commit/5163a36c5dea13fe69134ec1975849820aba089b

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/12

