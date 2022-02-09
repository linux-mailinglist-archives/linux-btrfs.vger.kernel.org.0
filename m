Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB834AF10C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 13:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiBIMJ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 9 Feb 2022 07:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiBIMIw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 07:08:52 -0500
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 03:08:38 PST
Received: from mail.hemeria-group.com (mail.hemeria-group.com [151.80.188.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64BC03FEDE
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 03:08:38 -0800 (PST)
Received: from S268944.EX268944.lan (2001:41d0:129:b800::9750:bc68) by
 S268944.EX268944.lan (2001:41d0:129:b800::9750:bc68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id
 15.1.2375.18; Wed, 9 Feb 2022 11:53:32 +0100
Received: from S268944.EX268944.lan ([fe80::2962:a023:c804:11a4]) by
 S268944.EX268944.lan ([fe80::2962:a023:c804:11a4%12]) with mapi id
 15.01.2375.018; Wed, 9 Feb 2022 11:53:32 +0100
From:   BERGUE Kevin <kevin.bergue-externe@hemeria-group.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Root level mismatch after sudden shutdown
Thread-Topic: Root level mismatch after sudden shutdown
Thread-Index: AQHYHZ4Qv30Xx5vHf0mg7XPLwKTleg==
Date:   Wed, 9 Feb 2022 10:53:32 +0000
Message-ID: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
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

Hello everyone.


After a sudden shutdown my btrfs partition seems to be corrupted. After a few hours of reading documentation and trying various repair methods I found an error message I can't find anywhere so I'm sending it your way hoping you can at least explain what the issue is. The disk was running with linux 5.16.5 at the moment of the crash, my recovery environnement is a linux 5.15.16 machine with btrfs-progs v5.16.


To retrace my steps a bit:

- I tried to mount my partition normally:
# mount /dev/mapper/SSD-Root /mnt/broken/
mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/mapper/SSD-Root, missing codepage or helper program, or other error.

- I then looked at the relevant logs from dmesg:
# dmesg
[ 2118.381387] BTRFS info (device dm-1): flagging fs with big metadata feature
[ 2118.381394] BTRFS info (device dm-1): disk space caching is enabled
[ 2118.381395] BTRFS info (device dm-1): has skinny extents
[ 2118.384626] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
[ 2118.384900] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
[ 2118.384905] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
[ 2118.385304] BTRFS error (device dm-1): open_ctree failed

- After some reading about the "parent transid verify failed" errors I tried to mount the volume with the usebackuproot flag:
# mount -t btrfs -o ro,rescue=usebackuproot /dev/mapper/SSD-Root /mnt/broken/
mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/mapper/SSD-Root, missing codepage or helper program, or other error.
And the dmesg content:
[ 2442.117867] BTRFS info (device dm-1): flagging fs with big metadata feature
[ 2442.117871] BTRFS info (device dm-1): trying to use backup root at mount time
[ 2442.117872] BTRFS info (device dm-1): disk space caching is enabled
[ 2442.117873] BTRFS info (device dm-1): has skinny extents
[ 2442.123056] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
[ 2442.123344] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
[ 2442.123348] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
[ 2442.124743] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
[ 2442.124939] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
[ 2442.124942] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
[ 2442.125196] BTRFS critical (device dm-1): corrupt leaf: block=1869863370752 slot=97 extent bytenr=920192651264 len=4096 invalid generation, have 527002 expect (0, 527001]
[ 2442.125201] BTRFS error (device dm-1): block=1869863370752 read time tree block corruption detected
[ 2442.125500] BTRFS critical (device dm-1): corrupt leaf: block=1869863370752 slot=97 extent bytenr=920192651264 len=4096 invalid generation, have 527002 expect (0, 527001]
[ 2442.125502] BTRFS error (device dm-1): block=1869863370752 read time tree block corruption detected
[ 2442.125508] BTRFS warning (device dm-1): couldn't read tree root
[ 2442.125806] BTRFS critical (device dm-1): corrupt leaf: block=1869866401792 slot=117 extent bytenr=906206486528 len=4096 invalid generation, have 527003 expect (0, 527002]
[ 2442.125808] BTRFS error (device dm-1): block=1869866401792 read time tree block corruption detected
[ 2442.126174] BTRFS critical (device dm-1): corrupt leaf: block=1869866401792 slot=117 extent bytenr=906206486528 len=4096 invalid generation, have 527003 expect (0, 527002]
[ 2442.126175] BTRFS error (device dm-1): block=1869866401792 read time tree block corruption detected
[ 2442.126184] BTRFS warning (device dm-1): couldn't read tree root
[ 2442.126599] BTRFS error (device dm-1): open_ctree failed

- I then tried a check:
# btrfs check /dev/mapper/SSD-Root
Opening filesystem to check...
parent transid verify failed on 1869491683328 wanted 526959 found 526999
parent transid verify failed on 1869491683328 wanted 526959 found 526999
parent transid verify failed on 1869491683328 wanted 526959 found 526999
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
ERROR: cannot open file system


I think the "root [4 0] level 0 does not match 1" error is the real cuprit but I can't seem to find any info on this message anywhere. I tried a bunch of other commands including:
- btrfs rescue zero-log
- btrfs rescue chunk-recover
- btrfs check --repair
- btrfs rescue super-recover
- btrfs check --repair with the tree root found by btrfs-find-root
- btrfs check --repair --init-csum-tree --init-extent-tree
- btrfs restore

I'm aware I probably executed some commands that don't make a lot of sense in my context but all of them failed with either the "root [4 0] level 0 does not match 1" message or a more generic "could not open ctree" or equivalent.
