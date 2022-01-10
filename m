Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE44896AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 11:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbiAJKrE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 05:47:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38536 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbiAJKrD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 05:47:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C30E1F393;
        Mon, 10 Jan 2022 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641811622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy6axLnT/6KcJnJVVDywk3fTGZaTYflgEiVm6FMJFx0=;
        b=SJo5mkMvODkDcoZ4GyPpzn9h4L5ohITltimE90pKDRzmJSwP4CQG4mm+D97O5uCFF14HQt
        fQs3dILopAxylT3oCeebteeMxJ0b/clm9J029MPssuyZxOj/W5oWrz8Zwew2QhxKbJXi0a
        tuD9KJBQtI9k0BOOOiNmoQT+Y8cVx0o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57CF413A98;
        Mon, 10 Jan 2022 10:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pN/UEaYO3GHbWQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 10:47:02 +0000
Subject: Re: btrfs send/receive segfault
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f2e28c18-b5c0-d6cc-3f20-6ab7fcfb3c0d@suse.com>
Date:   Mon, 10 Jan 2022 12:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.01.22 г. 4:45, Chris Murphy wrote:
> kernel-5.16.0-0.rc8.20220106git75acfdb6fd92.56.fc36.x86_64
> btrfs-progs-5.15.1-1.fc35.x86_64
> 
> I'm seeing a crash during send/receive. The destination does have the
> source subvol, but it lacks received UUID for some reason, so this
> might be the instigating cause of the segmentation fault.

Right, so subvol_uuid_search returns an error which makes 'si' be the
errval, yet when "goto out" is executed the following code is executed:

if (si) {
        free(si->path);

        free(si);

    }


this of course fails since 'si' has a bogus value.

> 
> $ sudo btrfs send -p debris.20190114 debris.20220109 | sudo btrfs
> receive /mnt/tsrif/
> At subvol debris.20220109
> At snapshot debris.20220109
> ERROR: clone: did not find source subvol
> Segmentation fault
> $ sudo btrfs sub show /mnt/tsrif/debris.20190114/
> debris.20190114
>         Name:                   debris.20190114
>         UUID:                   872216a7-658e-444b-9583-11378eea6703
>         Parent UUID:            11cbf558-b602-6e4c-852f-6eb5efb672f1
>         Received UUID:          -
>         Creation time:          2019-01-14 12:24:11 -0700
>         Subvolume ID:           3091
>         Generation:             41292
>         Gen at creation:        25612
>         Parent ID:              5
>         Top level ID:           5
>         Flags:                  readonly
>         Send transid:           0
>         Send time:              2019-01-14 12:24:11 -0700
>         Receive transid:        0
>         Receive time:           -
>         Snapshot(s):
>                                 debris.20220109
> $ sudo btrfs sub show /mnt/first/debris.20190114/
> debris.20190114
>         Name:                   debris.20190114
>         UUID:                   482659cd-c93a-5a4b-954d-6bee2fc7ce7e
>         Parent UUID:            -
>         Received UUID:          872216a7-658e-444b-9583-11378eea6703
>         Creation time:          2020-05-06 12:19:55 -0600
>         Subvolume ID:           422
>         Generation:             5916
>         Gen at creation:        462
>         Parent ID:              5
>         Top level ID:           5
>         Flags:                  readonly
>         Send transid:           564
>         Send time:              2020-05-06 12:19:55 -0600
>         Receive transid:        540
>         Receive time:           2020-05-06 13:03:27 -0600
>         Snapshot(s):
> 
> 
> Jan 09 18:51:21 fnuc.local sudo[5393]:    chris : TTY=pts/1 ;
> PWD=/mnt/first ; USER=root ; COMMAND=/usr/sbin/btrfs send -p
> debris.20190114 debris.20220109
> Jan 09 18:51:21 fnuc.local sudo[5394]:    chris : TTY=pts/1 ;
> PWD=/mnt/first ; USER=root ; COMMAND=/usr/sbin/btrfs receive
> /mnt/tsrif/
> Jan 09 18:51:21 fnuc.local sudo[5394]: pam_unix(sudo:session): session
> opened for user root(uid=0) by (uid=1000)
> Jan 09 18:51:21 fnuc.local sudo[5393]: pam_unix(sudo:session): session
> opened for user root(uid=0) by (uid=1000)
> Jan 09 18:51:48 fnuc.local kernel: show_signal_msg: 4 callbacks suppressed
> Jan 09 18:51:48 fnuc.local kernel: btrfs[5395]: segfault at 56 ip
> 000055939d4efc6d sp 00007ffeb50978a0 error 4 in
> btrfs[55939d497000+9b000]
> Jan 09 18:51:48 fnuc.local kernel: Code: 58 5a e9 4e fe ff ff 66 0f 1f
> 44 00 00 41 bd fe ff ff ff 48 8d 3d 33 82 06 00 31 c0 e8 bc bd fd ff
> 4d 85 ff 0f 84 96 fe ff ff <49> 8b 7f 58 e8 ba 81 fa ff 4c 89 ff e8 b2
> 81 fa ff e9 80 fe ff ff
> Jan 09 18:51:48 fnuc.local audit[5395]: ANOM_ABEND auid=1000 uid=0
> gid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> pid=5395 comm="btrfs" exe="/usr/sbin/btrfs" sig=11 res=1
> Jan 09 18:51:50 fnuc.local systemd[1]: Created slice Slice
> /system/systemd-coredump.
> Jan 09 18:51:50 fnuc.local audit: BPF prog-id=68 op=LOAD
> Jan 09 18:51:50 fnuc.local audit: BPF prog-id=69 op=LOAD
> Jan 09 18:51:50 fnuc.local audit: BPF prog-id=70 op=LOAD
> Jan 09 18:51:50 fnuc.local systemd[1]: Started Process Core Dump (PID
> 5398/UID 0).
> Jan 09 18:51:50 fnuc.local audit[1]: SERVICE_START pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> msg='unit=systemd-coredump@0-5398-0 comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> Jan 09 18:51:51 fnuc.local systemd-coredump[5399]: [🡕] Process 5395
> (btrfs) of user 0 dumped core.
> 
>                                                    Found module
> linux-vdso.so.1 with build-id:
> 34559f148f176282c9dee6b448c7dbb357a60316
>                                                    Found module
> libgcc_s.so.1 with build-id: 88564abce789aa42536da1247a57ff6062d61dcb
>                                                    Found module
> ld-linux-x86-64.so.2 with build-id:
> b43118df1fdb4c0aff150b6f8f926bccdec2a7f0
>                                                    Found module
> libc.so.6 with build-id: 644dac2c66a6e0b32674f0ec71e7431bd0c06a63
>                                                    Found module
> libzstd.so.1 with build-id: 0f6e793c8bbdb5bb5683c5b9e61aadfcb7a7454a
>                                                    Found module
> liblzo2.so.2 with build-id: c83f77cc751de75374d5763f4f3a6c483fb2f738
>                                                    Found module
> libz.so.1 with build-id: 5903f5c355c264403e4e7cdc66779584425ca3b8
>                                                    Found module
> libudev.so.1 with build-id: 7422938010fad35c79a9a6cb017799a1cc575e7f
>                                                    Found module
> libblkid.so.1 with build-id: 96be27216d8d6d7ba3694ca503cd1b07f60fa539
>                                                    Found module
> libuuid.so.1 with build-id: 2dee14d2566e86111e3f0a235ad58a0f27b8f826
>                                                    Found module btrfs
> with build-id: 92f57ed8ec33cf3c8979c29ccfe55cd3a6e19996
>                                                    Stack trace of thread 5395:
>                                                    #0
> 0x000055939d4efc6d process_clone (btrfs + 0x6ec6d)
>                                                    #1
> 0x000055939d4d2d4c btrfs_read_and_process_send_stream (btrfs +
> 0x51d4c)
>                                                    #2
> 0x000055939d4f0e41 cmd_receive.lto_priv.0 (btrfs + 0x6fe41)
>                                                    #3
> 0x000055939d498c9d main (btrfs + 0x17c9d)
>                                                    #4
> 0x00007fc3eb8f8560 __libc_start_call_main (libc.so.6 + 0x2d560)
>                                                    #5
> 0x00007fc3eb8f860c __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x2d60c)
>                                                    #6
> 0x000055939d498ff5 _start (btrfs + 0x17ff5)
> 
> 
> result from coredumpctl gdb, thread apply all bt full
> https://drive.google.com/file/d/1exrFFYEtgDs8BEkt1JWbNWUaQOSDRolc/view?usp=sharing
> 
> 
