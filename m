Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2154E45E97F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Nov 2021 09:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353255AbhKZIlh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 26 Nov 2021 03:41:37 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:23436 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347737AbhKZIjg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Nov 2021 03:39:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E5CC34092F;
        Fri, 26 Nov 2021 09:36:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vWqLUq8ExoQ5; Fri, 26 Nov 2021 09:36:21 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 3B6464092A;
        Fri, 26 Nov 2021 09:36:21 +0100 (CET)
Received: from [8.43.224.52] (port=60526 helo=[100.95.114.229])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mqWiS-0008nR-9I; Fri, 26 Nov 2021 09:36:20 +0100
Date:   Fri, 26 Nov 2021 09:36:19 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Egor Konstantinov <egorks@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <94a1a1e.faa9ddbb.17d5b636231@tnonline.net>
In-Reply-To: <7c367beb-f2ab-19cc-9a44-e1a64dfaabb0@gmail.com>
References: <7c367beb-f2ab-19cc-9a44-e1a64dfaabb0@gmail.com>
Subject: Re: Btrfs disk issues - please advise on repair
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Egor Konstantinov <egorks@gmail.com> -- Sent: 2021-11-24 - 17:42 ----

> hi all
> 
> i have a single /dev/sdc as a btrfs volume. recently the volume got corrupted 
> and i cannot seem to find a way to restore its functionality by using any of 
> internet howtos.
> i tried standard ‘safe’ options and still did not run --repair option in fear of 
> killing the data completely.
> also if i check with btrfs tools v4 and v5 (from tumbleweed live usb) i get 
> totally different results.
> with v4 i ger simply:
> 
> and with v5 i get a log file of 32Mb with over 500k lines stating following:
> 
> Code:
> --------------------------------------------------------------------------------
> |parent transid verify failed on 3646998413312 wanted 3065 found 2747
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> Ignoring transid failure
> Opening filesystem to check...
> Checking filesystem on /dev/sdc
> UUID: bc677067-effd-430a-90fa-ab1c6cd51de1
> [1/7] checking root items                      (0:00:00 elapsed, 144 items checked)
> [1/7] checking root items                      (0:00:01 elapsed, 51113 items 
> checked)
> [1/7] checking root items                      (0:00:02 elapsed, 132156 items 
> checked)
> [1/7] checking root items                      (0:00:03 elapsed, 201203 items 
> checked)
> [1/7] checking root items                      (0:00:04 elapsed, 317426 items 
> checked)
> [2/7] checking extents                        (0:00:00 elapsed)
> [2/7] checking extents                        (0:00:01 elapsed, 1940 items checked)
> [2/7] checking extents                        (0:00:02 elapsed, 2355 items checked)
> parent transid verify failed on 3646998642688 wanted 3065 found 2747
> parent transid verify failed on 3646998642688 wanted 3065 found 2747
> parent transid verify failed on 3646998642688 wanted 3065 found 2747
> Ignoring transid failure
> [2/7] checking extents                        (0:00:03 elapsed, 9973 items checked)
> [2/7] checking extents                        (0:00:04 elapsed, 25702 items checked)
> [2/7] checking extents                        (0:00:05 elapsed, 39437 items checked)
> [2/7] checking extents                        (0:00:06 elapsed, 56114 items checked)
> [2/7] checking extents                        (0:00:07 elapsed, 71956 items checked)
> [2/7] checking extents                        (0:00:08 elapsed, 87850 items checked)
> [2/7] checking extents                        (0:00:09 elapsed, 103417 items 
> checked)
> [2/7] checking extents                        (0:00:10 elapsed, 118146 items 
> checked)
> [2/7] checking extents                        (0:00:11 elapsed, 133337 items 
> checked)
> [2/7] checking extents                        (0:00:12 elapsed, 148490 items 
> checked)
> [2/7] checking extents                        (0:00:13 elapsed, 163390 items 
> checked)
> [2/7] checking extents                        (0:00:14 elapsed, 177768 items 
> checked)
> [2/7] checking extents                        (0:00:15 elapsed, 192416 items 
> checked)
> [2/7] checking extents                        (0:00:16 elapsed, 202829 items 
> checked)
> [2/7] checking extents                        (0:00:17 elapsed, 212968 items 
> checked)
> [2/7] checking extents                        (0:00:18 elapsed, 219076 items 
> checked)
> ref mismatch on [13631488 16384] extent item 1, found 0
> incorrect local backref count on 13631488 root 5 owner 36919 offset 0 found 0 
> wanted 1 back 0x55c1895eaca0
> backref disk bytenr does not match extent record, bytenr=13631488, ref bytenr=0
> backpointer mismatch on [13631488 16384]
> owner ref check failed [13631488 16384]
> ref mismatch on [13647872 4096] extent item 1, found 0
> incorrect local backref count on 13647872 root 5 owner 37225 offset 0 found 0 
> wanted 1 back 0x55c1895eae50
> backref disk bytenr does not match extent record, bytenr=13647872, ref bytenr=0
> backpointer mismatch on [13647872 4096]
> owner ref check failed [13647872 4096]
> 
> ...skipped many many lines
> 
> ref mismatch on [61423616 16384] extent item 1, found 0
> backref 61423616 root 5 not referenced back 0x55c186e74550
> incorrect global backref count on 61423616 found 1 wanted 0
> backpointer mismatch on [61423616 16384]
> owner ref check failed [61423616 16384]
> ref mismatch on [268746752 16384] extent item 1, found 0
> backref 268746752 root 5 not referenced back 0x55c1875bcd10
> incorrect global backref count on 268746752 found 1 wanted 0
> backpointer mismatch on [268746752 16384]
> owner ref check failed [268746752 16384]
> ref mismatch on [284639232 16384] extent item 1, found 0
> backref 284639232 root 7 not referenced back 0x55c186ff9130
> incorrect global backref count on 284639232 found 1 wanted 0
> backpointer mismatch on [284639232 16384]
> owner ref check failed [284639232 16384]
> 
> ...skipping again many many lines
> 
> ref mismatch on [1104150528 134217728] extent item 1, found 0
> incorrect local backref count on 1104150528 root 5 owner 260 offset 0 found 0 
> wanted 1 back 0x55c187a09e30
> backref disk bytenr does not match extent record, bytenr=1104150528, ref bytenr=0
> backpointer mismatch on [1104150528 134217728]
> owner ref check failed [1104150528 134217728]
> ref mismatch on [1238368256 134217728] extent item 1, found 0
> incorrect local backref count on 1238368256 root 5 owner 260 offset 134217728 
> found 0 wanted 1 back 0x55c187a09fe0
> backref disk bytenr does not match extent record, bytenr=1238368256, ref bytenr=0
> backpointer mismatch on [1238368256 134217728]
> owner ref check failed [1238368256 134217728]
> ref mismatch on [1372585984 134217728] extent item 1, found 0
> incorrect local backref count on 1372585984 root 5 owner 260 offset 268435456 
> found 0 wanted 1 back 0x55c187a0a110
> backref disk bytenr does not match extent record, bytenr=1372585984, ref bytenr=0
> backpointer mismatch on [1372585984 134217728]
> owner ref check failed [1372585984 134217728]
> 
> ...skipping again bundle
> 
> ref mismatch on [3671060365312 15777792] extent item 1, found 0
> incorrect local backref count on 3671060365312 root 5 owner 37267 offset 
> 18724372480 found 0 wanted 1 back 0x55c1895ea950
> backref disk bytenr does not match extent record, bytenr=3671060365312, ref bytenr=0
> backpointer mismatch on [3671060365312 15777792]
> owner ref check failed [3671060365312 15777792]
> ref mismatch on [3671076143104 16777216] extent item 1, found 0
> incorrect local backref count on 3671076143104 root 5 owner 37267 offset 
> 19730006016 found 0 wanted 1 back 0x55c1895eaa80
> backref disk bytenr does not match extent record, bytenr=3671076143104, ref bytenr=0
> backpointer mismatch on [3671076143104 16777216]
> owner ref check failed [3671076143104 16777216]
> [2/7] checking extents                        (0:00:20 elapsed, 220934 items 
> checked)
> ERROR: errors found in extent allocation tree or chunk allocation
> cache and super generation don't match, space cache will be invalidated
> [3/7] checking free space cache                (0:00:00 elapsed)
> [3/7] checking free space cache                (0:00:00 elapsed)
> [4/7] checking fs roots                        (0:00:00 elapsed)
> root 5 root dir 256 not found
> [4/7] checking fs roots                        (0:00:00 elapsed, 2 items checked)
> ERROR: errors found in fs roots
> found 3508584407040 bytes used, error(s) found
> total csum bytes: 3417906432
> total tree bytes: 3619651584
> total fs tree bytes: 16384
> total extent tree bytes: 26083328
> btree space waste bytes: 135962918
> file data blocks allocated: 880803840
>   referenced 880803840|
> --------------------------------------------------------------------------------
> i can attach a full log if needed, but generally it comes down to types of 
> errors above.
> 
> can this disk still be repaired or should i just reformat it and be done with it?
> i did chunk scan (took over 10h) which came up with nothing.
> zero-logs and other options result in abort; i cannot do btrfs-image (it appears 
> to be much much smaller then i would expect).
> volume info:
> Code:
> --------------------------------------------------------------------------------
> |
>   Label: 'sum5'  uuid: xxx
>          Total devices 1 FS bytes used 3.19TiB
>          devid    1 size 7.28TiB used 3.30TiB path /dev/sdc|
> --------------------------------------------------------------------------------
> image dumped is just a couple of gigs, and -d says that data dump is not supported.
> 
> some other output of ‘safe’ commands i ran based on internet feedback:
> 
> 
> Code:
> --------------------------------------------------------------------------------
> |thumlivex:~ # btrfs scrub start /dev/sdc ERROR: '/dev/sdc' is not a mounted 
> btrfs device
> thumlivex:~ # btrfs scrub start /dev/sdc
> ERROR: '/dev/sdc' is not a mounted btrfs device
> thumlivex:~ # btrfs fi sh
> Label: 'sum5'  uuid: bc677067-effd-430a-90fa-ab1c6cd51de1
>          Total devices 1 FS bytes used 3.19TiB
>          devid    1 size 7.28TiB used 3.30TiB path /dev/sdc
> 
> thumlivex:~ # mount -o ro,usebackuproot /dev/sdc /mnt/3/
> mount: /mnt/3: can't read superblock on /dev/sdc.
> thumlivex:~ # btrfs restore /dev/sdc /mnt/1/temp/00/
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> Ignoring transid failure
> thumlivex:~ # btrfs rescue super-recover /dev/sdc
> All supers are valid, no need to recover
> thumlivex:~ # btrfs rescue zero-log /dev/sdc
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> ERROR: could not open ctree
> thumlivex:~ # btrfs rescue fix-device-size /dev/sdc
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> parent transid verify failed on 3646998413312 wanted 3065 found 2747
> ERROR: could not open btrfs
> thumlivex:~ #|
> --------------------------------------------------------------------------------
> i also ran chunk-recover with no result.
> any ideas would be welcome, it would be a pity to lose 3.3T of data because of a 
> power outage… never had this kind of issues with ext4.
> 
> would be thankful for any insights on how to investigate more or fix partially 
> as well.
> 
> thanks in advance!
> -- 
> Sincerely,
> Egor Konstantinov


Hi,

As far as I know, it is not possible to repair "parent transid failed" errors. It means you have a serious damage to your filesystem.

There is some background on why this can happen on the Btrfs wiki. https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_.22parent_transid_verify_failed.22_error.3F

It generally comes down to a situation where the storage system did not honour barriers and you lost writes after write reordering happened.

Btrfs updates the reference to data extents on its leaves first, the it updates the reference to the leaves, the root references and last the super blocks. 

The parent transid failed means that you have lost updated references in the middle. This should normally not be possible. Ram corruption could also lead to a problem like this. 

You should see if you can mount the filesystem read-only and copy as much data as possible. It is important that you fi out why it happened. It is possible that the corruption happened a while ago, but only manifested now after the last power outage. 



