Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E614B08CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 09:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiBJIsp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 10 Feb 2022 03:48:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiBJIso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 03:48:44 -0500
Received: from mail.hemeria-group.com (mail.hemeria-group.com [151.80.188.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5079C2A
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 00:48:45 -0800 (PST)
Received: from S268944.EX268944.lan (2001:41d0:129:b800::9750:bc68) by
 S268944.EX268944.lan (2001:41d0:129:b800::9750:bc68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id
 15.1.2375.18; Thu, 10 Feb 2022 09:48:43 +0100
Received: from S268944.EX268944.lan ([fe80::2962:a023:c804:11a4]) by
 S268944.EX268944.lan ([fe80::2962:a023:c804:11a4%12]) with mapi id
 15.01.2375.018; Thu, 10 Feb 2022 09:48:43 +0100
From:   BERGUE Kevin <kevin.bergue-externe@hemeria-group.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Root level mismatch after sudden shutdown
Thread-Topic: Root level mismatch after sudden shutdown
Thread-Index: AQHYHZ4Qv30Xx5vHf0mg7XPLwKTleqyL8HyAgACKILw=
Date:   Thu, 10 Feb 2022 08:48:43 +0000
Message-ID: <1d68c14001434e9b9ccbb808a9eaad6c@hemeria-group.com>
References: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>,<51b5c958-1df6-e95e-d394-c95a0863ea0f@gmx.com>
In-Reply-To: <51b5c958-1df6-e95e-d394-c95a0863ea0f@gmx.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:e0a:281:c9c0:440e:8bb8:d354:b8c0]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> Hello everyone.
>>
>>
>> After a sudden shutdown my btrfs partition seems to be corrupted. After a few hours of reading documentation and trying various repair methods I found an error message I can't find anywhere so I'm sending it your way hoping you can at least explain what the issue is. The disk was running with linux 5.16.5 at the moment of the crash, my recovery environnement is a linux 5.15.16 machine with btrfs-progs v5.16.
>>
>>
>> To retrace my steps a bit:
>>
>> - I tried to mount my partition normally:
>> # mount /dev/mapper/SSD-Root /mnt/broken/
>> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/mapper/SSD-Root, missing codepage or helper program, or other error.
>>
>> - I then looked at the relevant logs from dmesg:
>> # dmesg
>> [ 2118.381387] BTRFS info (device dm-1): flagging fs with big metadata feature
>> [ 2118.381394] BTRFS info (device dm-1): disk space caching is enabled
>> [ 2118.381395] BTRFS info (device dm-1): has skinny extents
>> [ 2118.384626] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> [ 2118.384900] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
>
>Transid mismatch, and it's newer tree blocks overwriting old tree blocks.
>
>This means two possible situations:
>
>- The SSD is lying about its flush/fua opeartions
>   This means, the SSD firmware doesn't really write all its data back to
>   its NAND when it reports flush/fua operations are finished.
>   This mostly means the SSD is not reliable for any filesystems.
>
>   Although traditional journal based filesystems may have a better
>   chance to survive.
>
>- Some corrupted v1 cache makes btrfs to break its CoW checks
>   This can only happen for v1 space cache, and is pretty tricky to
>   happen, as v1 cache has its own checksum.
>
>   And now v2 cache is the default for newly created btrfs.
>
>- Corrupted extent tree screwing up metadata CoW
>   Normally it would cause transaction abort in the first place though.
>
>- Complex storage stack added extra points to cause FLUSH/FUA problem
>   If you're using things like LVM/LUKS/Bcache, it's more complex and
>   any stack in the middle can cause FLUSH/FUA problem if there is some
>   bugs.
>
>Mind to share the following info?
>
>- Storage stack
>   From hardware disk to the top level btrfs, all things like LVM/LUKS
>   /Bcache would help us to understand the situation.

The btrfs volume is on a LVM lv which itself is on a single SATA ssd. According to SMART the disk is healthy.

>
>- SSD model
>   To see if it's some known one to have FLUSH/FUA problems.

The SSD reports itself as an INTEL SSDSC2KG960G8.

>
>Thanks,
>Qu
>
>
>> [ 2118.384905] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
>> [ 2118.385304] BTRFS error (device dm-1): open_ctree failed
>>
>> - After some reading about the "parent transid verify failed" errors I tried to mount the volume with the usebackuproot flag:
>> # mount -t btrfs -o ro,rescue=usebackuproot /dev/mapper/SSD-Root /mnt/broken/
>> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/mapper/SSD-Root, missing codepage or helper program, or other error.
>> And the dmesg content:
>> [ 2442.117867] BTRFS info (device dm-1): flagging fs with big metadata feature
>> [ 2442.117871] BTRFS info (device dm-1): trying to use backup root at mount time
>> [ 2442.117872] BTRFS info (device dm-1): disk space caching is enabled
>> [ 2442.117873] BTRFS info (device dm-1): has skinny extents
>> [ 2442.123056] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> [ 2442.123344] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> [ 2442.123348] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
>> [ 2442.124743] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> [ 2442.124939] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> [ 2442.124942] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
>> [ 2442.125196] BTRFS critical (device dm-1): corrupt leaf: block=1869863370752 slot=97 extent bytenr=920192651264 len=4096 invalid generation, have 527002 expect (0, 527001]
>> [ 2442.125201] BTRFS error (device dm-1): block=1869863370752 read time tree block corruption detected
>> [ 2442.125500] BTRFS critical (device dm-1): corrupt leaf: block=1869863370752 slot=97 extent bytenr=920192651264 len=4096 invalid generation, have 527002 expect (0, 527001]
>> [ 2442.125502] BTRFS error (device dm-1): block=1869863370752 read time tree block corruption detected
>> [ 2442.125508] BTRFS warning (device dm-1): couldn't read tree root
>> [ 2442.125806] BTRFS critical (device dm-1): corrupt leaf: block=1869866401792 slot=117 extent bytenr=906206486528 len=4096 invalid generation, have 527003 expect (0, 527002]
>> [ 2442.125808] BTRFS error (device dm-1): block=1869866401792 read time tree block corruption detected
>> [ 2442.126174] BTRFS critical (device dm-1): corrupt leaf: block=1869866401792 slot=117 extent bytenr=906206486528 len=4096 invalid generation, have 527003 expect (0, 527002]
>> [ 2442.126175] BTRFS error (device dm-1): block=1869866401792 read time tree block corruption detected
>> [ 2442.126184] BTRFS warning (device dm-1): couldn't read tree root
>> [ 2442.126599] BTRFS error (device dm-1): open_ctree failed
>>
>> - I then tried a check:
>> # btrfs check /dev/mapper/SSD-Root
>> Opening filesystem to check...
>> parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> parent transid verify failed on 1869491683328 wanted 526959 found 526999
>> Ignoring transid failure
>> ERROR: root [4 0] level 0 does not match 1
>>
>> Couldn't setup device tree
>> ERROR: cannot open file system
>>
>>
>> I think the "root [4 0] level 0 does not match 1" error is the real cuprit but I can't seem to find any info on this message anywhere. I tried a bunch of other commands including:
>> - btrfs rescue zero-log
>> - btrfs rescue chunk-recover
>> - btrfs check --repair
>> - btrfs rescue super-recover
>> - btrfs check --repair with the tree root found by btrfs-find-root
>> - btrfs check --repair --init-csum-tree --init-extent-tree
>> - btrfs restore
>>
>> I'm aware I probably executed some commands that don't make a lot of sense in my context but all of them failed with either the "root [4 0] level 0 does not match 1" message or a more generic "could not open ctree" or equivalent.
