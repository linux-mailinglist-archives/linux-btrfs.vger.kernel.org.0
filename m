Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E44453E8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 03:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhKQCvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 21:51:53 -0500
Received: from trent.utfs.org ([94.185.90.103]:39784 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhKQCvw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 21:51:52 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 21:51:52 EST
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1637116872; h=date : from : to : subject : message-id : mime-version
 : content-type : from;
 bh=CniObYlK7tmUy+S12Lo8qW9CN9kb1hPmT98ZTF/rjXc=;
 b=lZtUR5uM2wva+9O4wp+gTDB/MVYAngGtBiipHHL3G2p21QHTc+Ld/7T3AXA7rGm+fKanZ
 hIVK8iRPUGd5kOTBA==
Authentication-Results: mail.nerdbynature.de; dmarc=fail (p=none dis=none) header.from=nerdbynature.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1637116872; h=date : from :
 to : subject : message-id : mime-version : content-type : from;
 bh=CniObYlK7tmUy+S12Lo8qW9CN9kb1hPmT98ZTF/rjXc=;
 b=hTThKmqlUlKCxRgp2JbEV4rX9ym21e9UeJv62BIwMBRI7zYqpexSYwKg9IYuy2p2k0gGX
 RbOAUqvR1j5kJ2T40oBrAeZQrWONVIHXceQoSwMZr8Si/3A4Kmjq4On3t97Bo+CoGxNhnxg
 d6WQkY15/DKCfj+qtHpuNGfn7rAsDH64spZNQne3gS2O6GVF+cKYaa98P3GBRcQ90uLX/i9
 coPV5NheuW3FC2ndkn/EQLgoMk14ePY0c0EM7zro40x4OwffJkrY6RAoN2mX24s35giVdLg
 ftDWq2A10synZaZD6TAg31RHImkIgAMm4bnufkvBFjjEniZWmG1vApatkUtg==
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 1D7C561F5B
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 03:41:12 +0100 (CET)
Date:   Wed, 17 Nov 2021 03:41:12 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-btrfs@vger.kernel.org
Subject: failed to load free space cache for block group
Message-ID: <9aaa22f5-3fe-19ff-ff8f-318d6ba78313@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On fairly freshly installed Fedora 34 system (just upgraded to F35 with 
5.14.17-301.fc35.x86_64 running) the following messages started to appear 
during bootup, about ~1 week after the file system had been created by the 
installer:

 BTRFS warning (device dm-0): block group 49414144000 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 49414144000, rebuilding it now

There are a few more block groups affected now (see below), and it's 
always the same block groups being reported.

The btrfs file system resides on a LUKS encrypted device, on an NVMe disk 
inside a Lenovo T470 laptop. The device appears to be fine, no hardware 
related errors have been logged here. Maybe (!) the laptop has not been 
shutdown properly but I don't remember if that really happened.

A (readonly) btrfs scrub found no errors here. All files on the file 
system can be read, so there is no real problem here. I just want to 
understand if that's something to worry about. The messages can be found 
on the interwebs, but mostly in (very) old postings and w/o the message 
being explained.

So, let me ask here - is this something to worry about? How to get rid of 
those messages? And: how to prevent those in the future? :-)

Thanks,
Christian.

$ mount | grep btrfs
/dev/mapper/luks-root on / type btrfs (rw,relatime,seclabel,compress=zstd:3,ssd,discard,space_cache,subvolid=5,subvol=/)

$ btrfs inspect-internal dump-super /dev/mapper/luks-root 
superblock: bytenr=65536, device=/dev/mapper/luks-root
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xb15c2efc [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			f1093dd0-ba7e-47c7-98de-e0ac85a34972
metadata_uuid		f1093dd0-ba7e-47c7-98de-e0ac85a34972
label			
generation		44115
root			136606744576
sys_array_size		97
chunk_root_generation	43990
root_level		1
chunk_root		1048576
chunk_root_level	0
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		268418678784
bytes_used		109501288448
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x171
			( MIXED_BACKREF |
			  COMPRESS_ZSTD |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
[...]

$ journalctl -b | grep BTRFS | cut -c30-
 BTRFS: device fsid f1093dd0-ba7e-47c7-98de-e0ac85a34972 devid 1 transid 44043 /dev/dm-0 scanned by systemd-udevd (715)
 BTRFS info (device dm-0): flagging fs with big metadata feature
 BTRFS info (device dm-0): disk space caching is enabled
 BTRFS info (device dm-0): has skinny extents
 BTRFS info (device dm-0): enabling ssd optimizations
 BTRFS info (device dm-0): turning on sync discard
 BTRFS info (device dm-0): use zstd compression, level 3
 BTRFS info (device dm-0): disk space caching is enabled
 BTRFS info (device dm-0): devid 1 device path /dev/mapper/luks-root changed to /dev/dm-0 scanned by systemd-udevd (895)
 BTRFS info (device dm-0): devid 1 device path /dev/dm-0 changed to /dev/mapper/luks-root scanned by systemd-udevd (895)
 BTRFS warning (device dm-0): block group 11833180160 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 11833180160, rebuilding it now
 BTRFS warning (device dm-0): block group 16128147456 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 16128147456, rebuilding it now
 BTRFS warning (device dm-0): block group 20423114752 has wrong amount of free space
 BTRFS warning (device dm-0): block group 21496856576 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 20423114752, rebuilding it now
 BTRFS warning (device dm-0): failed to load free space cache for block group 21496856576, rebuilding it now
 BTRFS warning (device dm-0): block group 22570598400 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 22570598400, rebuilding it now
 BTRFS warning (device dm-0): block group 45119176704 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 45119176704, rebuilding it now
 BTRFS warning (device dm-0): block group 48340402176 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 48340402176, rebuilding it now
 BTRFS warning (device dm-0): block group 126684758016 has wrong amount of free space
 BTRFS warning (device dm-0): failed to load free space cache for block group 126684758016, rebuilding it now

 BTRFS info (device dm-0): scrub: started on devid 1
 BTRFS info (device dm-0): scrub: finished on devid 1 with status: 0

-- 
BOFH excuse #450:

Terrorists crashed an airplane into the server room, have to remove /bin/laden. (rm -rf /bin/laden)
