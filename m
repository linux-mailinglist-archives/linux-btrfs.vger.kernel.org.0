Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A7B2EBB10
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 09:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbhAFIZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 03:25:45 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:43928 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jan 2021 03:25:44 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 03:25:43 EST
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 307113F414;
        Wed,  6 Jan 2021 09:18:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.148
X-Spam-Level: 
X-Spam-Status: No, score=-2.148 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.249, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j8T0BWZZknxa; Wed,  6 Jan 2021 09:18:31 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id C1C903F3A4;
        Wed,  6 Jan 2021 09:18:30 +0100 (CET)
Received: from [192.168.0.10] (port=59580)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1kx41V-0006vd-MX; Wed, 06 Jan 2021 09:18:29 +0100
From:   Forza <forza@tnonline.net>
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Cedric.dewijs@eclipso.eu, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
 <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
 <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
 <CAN4oSBcL7ae_qwKDDoP=sbjkR4gcweTO8otEQv1Zh0YhStWZsw@mail.gmail.com>
Message-ID: <b9662cf1-e45f-5113-5b23-bf1aaa73cb97@tnonline.net>
Date:   Wed, 6 Jan 2021 09:18:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAN4oSBcL7ae_qwKDDoP=sbjkR4gcweTO8otEQv1Zh0YhStWZsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-01-05 13:24, Cerem Cem ASLAN wrote:
> I also thought about a different approach in the past:
> 
> 1. Take a snapshot and rsync it to the server.
> 2. When it succeeds, make it readonly and take a note on the remote
> site that indicates the Received_UUID and checksum of entire
> subvolume.
> 3. When you want to send your diff, run `btrfs send -p ./first
> ./second | list-file-changes -o my-diff-for-second.txt` if that
> Received_UUID on the remote site matches with ./first. (Otherwise, you
> should run rsync without taking advantage of
> `my-diff-for-second.txt`.)

You can use `btrbk diff old-snap new-snap` to list changes between 
snapshots.

Example:
------------------------------------------------------------------------------
#btrbk diff /mnt/systemRoot/snapshots/root.20210101T0001/ 
/mnt/systemRoot/snapshots/root.20210102T0001/

Subvolume Diff (btrbk command line client, version 0.30.0)

     Date:   Wed Jan  6 09:06:37 2021

Showing changed files for subvolume:
   /mnt/systemRoot/snapshots/root.20210102T0001  (gen=6050233)

Starting at generation after subvolume:
   /mnt/systemRoot/snapshots/root.20210101T0001  (gen=6046626)

This will show all files modified within generation range: 
[6046627..6050233]
Newest file generation (transid marker) was: 6050233

Legend:
     +..     file accessed at offset 0 (at least once)
     .c.     flags COMPRESS or COMPRESS|INLINE set (at least once)
     ..i     flags INLINE or COMPRESS|INLINE set (at least once)
     <count> file was modified in <count> generations
     <size>  file was modified for a total of <size> bytes
------------------------------------------------------------------------------
+ci   1       1318  etc/csh.env
+ci   1       2116  etc/dispatch-conf.conf
+ci   1       1111  etc/environment.d/10-gentoo-env.conf
+ci   1       2000  etc/etc-update.conf
+c.   1      94208  etc/ld.so.cache
...
------------------------------------------------------------------------------

You can also use `btrfs find-new` to list filesystem changes, but the 
output is much more verbose than that of btrbk, and you need to figure 
out the generation id's first. I also think that some things like 
deleted files and renamed files do not get listed? [*]

Example:
------------------------------------------------------------------------------
# btrfs subvolume find-new /mnt/systemRoot/snapshots/root.20210102T0001/ 
6046626

inode 3054490 file offset 0 len 8192 disk start 239676399616 offset 0 
gen 6048209 flags COMPRESS etc/passwd-
inode 9527306 file offset 0 len 4096 disk start 239792578560 offset 0 
gen 6049979 flags COMPRESS var/lib/dhcp/dhclient.leases
inode 9527306 file offset 4096 len 4096 disk start 239437688832 offset 0 
gen 6050179 flags COMPRESS var/lib/dhcp/dhclient.leases
inode 9527306 file offset 8192 len 4096 disk start 241226248192 offset 0 
gen 6050220 flags NONE var/lib/dhcp/dhclient.leases
inode 9527438 file offset 0 len 4096 disk start 244439986176 offset 0 
gen 6049681 flags NONE var/lib/samba/wins.tdb
inode 9527438 file offset 4096 len 4096 disk start 244569776128 offset 0 
gen 6050217 flags NONE var/lib/samba/wins.tdb
inode 9527438 file offset 8192 len 4096 disk start 243901612032 offset 0 
gen 6049543 flags NONE var/lib/samba/wins.tdb
inode 9527438 file offset 12288 len 8192 disk start 242191458304 offset 
4096 gen 6048901 flags PREALLOC var/lib/samba/wins.tdb
inode 9527438 file offset 20480 len 4096 disk start 244319576064 offset 
0 gen 6049691 flags NONE var/lib/samba/wins.tdb
------------------------------------------------------------------------------

> 4. Use rsync to send the changed files listed in `my-diff-for-second.txt`.
> 5. Verify by using a rolling hash, create a second snapshot and so on.
> 
> That approach will use all advantages of rsync and adds the "change
> detection" benefit from BTRFS. The problem is, I don't know how to
> implement the `list-file-changes` tool.
> 
> By the way, why wouldn't BTRFS keep a CHECKSUM field on readonly
> subvolumes and simply use that field for diff and patch operations?
> Calculating incremental checksums on every new readonly snapshot seems
> like a computationally cheap operation. We could then transfer our
> snapshots whatever method/tool we like (even we could create the
> /home/foo/hello.txt file with "hello world" content manually and then
> create another snapshot that will automatically match with our new
> local snapshot).
> 
[*]http://marc.merlins.org/perso/btrfs/post_2014-05-19_Btrfs-diff-Between-Snapshots.html
