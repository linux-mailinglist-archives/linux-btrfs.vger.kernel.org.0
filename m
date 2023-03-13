Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94396B781A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 13:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCMMzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMMzN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 08:55:13 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 05:55:11 PDT
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4162B53
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 05:55:11 -0700 (PDT)
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
        by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4PZxJS0QzJz7xsN
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:47:36 +0100 (CET)
Authentication-Results: mors-relay-8404.netcup.net; dkim=permerror (bad message/signature format)
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4PZxJS02xgz4xWC
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:47:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy02-mors.netcup.net
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from mxe217.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4PZxJR33wqz8sv3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:47:35 +0100 (CET)
Received: from [10.0.77.4] (wireguard.unfug.hs-furtwangen.de [141.28.77.251])
        by mxe217.netcup.net (Postfix) with ESMTPSA id 1A79780957
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:47:31 +0100 (CET)
Message-ID: <c8ac72b2-3d3c-0c5c-fe8b-e81043d9c469@business-insulting.de>
Date:   Mon, 13 Mar 2023 13:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   4censord <mail@4censord.de>
Subject: Corruption with hibernation and other file system access.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1A79780957
X-Spamd-Result: default: False [-5.60 / 15.00];
        BAYES_HAM(-5.50)[100.00%];
        MIME_GOOD(-0.10)[text/plain];
        RCVD_COUNT_ZERO(0.00)[0];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+];
        ASN(0.00)[asn:553, ipnet:141.28.0.0/16, country:DE];
        RCPT_COUNT_ONE(0.00)[1];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        TO_DN_NONE(0.00)[];
        FROM_HAS_DN(0.00)[];
        ARC_NA(0.00)[]
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: Uz+FT/HlkpHujlEQ+/yihCXoOpRmXpiME3Z/ajZqqpQnPXPcGtD9JGsX
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Let me preface this:

I will not be losing any data if this isn't fixable. My backups are
up-to-date and working, its just inconvenient having to restore.

I am currently working on a binary copy of the file system, as the
original is in a laptop and that is inconvenient.

How the corruption manifests:

$ sudo mount /dev/sdc /media/

mount: /media: wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.
        dmesg(1) may have more information after failed mount system call.

With matching errors in dmesg:

[47452.600340] BTRFS: device fsid 53eff9ed-54e8-47c1-8a3f-19ca7da3b2d0 devid 1 transid 1891513 /dev/sdc scanned by mount (33256)
[47453.654256] BTRFS info (device sdc): using crc32c (crc32c-intel) checksum algorithm
[47453.654268] BTRFS info (device sdc): disk space caching is enabled
[47453.702383] BTRFS error (device sdc): level verify failed on logical 2436053762048 mirror 1 wanted 1 found 0
[47453.702399] BTRFS warning (device sdc): failed to read root (objectid=4): -5
[47453.704273] BTRFS error (device sdc): open_ctree failed


$ btrfs check /dev/sdc

Opening filesystem to check...
parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
ERROR: cannot open file system


$ btrfs restore /dev/sdc $path

parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super


$ btrfs-find-root /dev/sdc

parent transid verify failed on 2436053762048 wanted 1891115 found 1891465
Couldn't setup device tree
Superblock thinks the generation is 1891513
Superblock thinks the level is 1
Found tree root at 2436805836800 gen 1891513 level 1
Well block 2436776198144(gen: 1891512 level: 1) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436753555456(gen: 1891511 level: 1) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436722769920(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436722753536(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436722737152(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436718247936(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436718231552(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436717297664(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436713775104(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436713496576(gen: 1891510 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436481499136(gen: 1891508 level: 1) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436062281728(gen: 1891507 level: 1) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436097032192(gen: 1891506 level: 1) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436081926144(gen: 1891505 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436063903744(gen: 1891505 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2436062691328(gen: 1891505 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2435973431296(gen: 1891503 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2435973382144(gen: 1891503 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2435973365760(gen: 1891503 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2435973316608(gen: 1891503 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2435973070848(gen: 1891503 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1
Well block 2435972907008(gen: 1891503 level: 0) seems good, but generation/level doesn't match, want gen: 1891513 level: 1


As for how i think the corruption happened:

This is the rootfs from a laptop. Btrfs in a luks container on a normal partition.
Only other thing on this disk is a efi partition.

The system was in hibernation while some maintenance took place.

The system was booted via an external medium to make some changes to the
bootloader. For this, the rootfs had been mounted rw, but no mayor
changes took place. Most writes should have been on a separate EFI partition.

After this was completed the system was rebooted and resumed from hibernation.

I assume that at this point the corruption happened, when either
* some write that was still in memory was committed to disk
* The system continued working with some index/metadata that no longer
   matched what was present on disk


I there may be some logs about this on the broken filesystem.

I have done basic check for disk health, and neither 'smartctl' nor
`nvme error-log` show signs of disk failure.


Version information as requested on the wiki:

This is my current system, not the broken one. Versions should have been
similar, within at most 2 Weeks of deviation.

$ uname -a

Linux thearch 6.2.2-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 03 Mar 2023 15:58:31 +0000 x86_64 GNU/Linux


$ btrfs --version

btrfs-progs v6.1.3


$ btrfs fi show

Label: 'nvme-1tb-01'  uuid: 22333bf7-c907-4caf-9c6f-52c9c2c645b3
     Total devices 1 FS bytes used 387.85GiB
     devid    1 size 931.51GiB used 394.03GiB path /dev/nvme0n1p1

Label: 'exos-18tb-01'  uuid: 6b8bb698-df2a-4f25-8411-2ffa3ff39cc7
     Total devices 2 FS bytes used 11.31TiB
     devid    1 size 16.37TiB used 11.38TiB path /dev/sdb
     devid    2 size 16.37TiB used 11.38TiB path /dev/sda

Label: 'cryptroot'  uuid: bd69b6e6-0426-4834-9f49-23a80e7609c7
     Total devices 1 FS bytes used 1.14TiB
     devid    1 size 1.75TiB used 1.55TiB path /dev/mapper/cryptroot

Label: none  uuid: 53eff9ed-54e8-47c1-8a3f-19ca7da3b2d0
     Total devices 1 FS bytes used 1.24TiB
     devid    1 size 1.75TiB used 1.30TiB path /dev/sdc

The filesystem this is about is at /dev/sdc, uuid: 53eff9ed-54e8-47c1-8a3f-19ca7da3b2d0


$ btrfs fi df # Replace /home with the mount point of your btrfs-filesystem

Filesystem is not mountable.

$ dmesg > dmesg.log

Logs from the event itself are on the broken filesystem.
As for the current device, I have included excerpts as appropriate

