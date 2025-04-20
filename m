Return-Path: <linux-btrfs+bounces-13182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFCBA949BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 23:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE093AF226
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592291D86E8;
	Sun, 20 Apr 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlC+R6n4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56BE1A23AF
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Apr 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745185553; cv=none; b=vEID4GlQVEXbBTKID2XQBSArxVgbJUX34SZ1MDgxbjOspZBSy6NqlwNB9U7vYt9jus6XR+HvX03pfyFjQ564ysB83yf6SDf4R9nezf1E/+cJfPLjSnvsKh407i5qvNSgLDKsfv1+otLwgEJ4FYbewLPwevEeFziWuDVGig6S7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745185553; c=relaxed/simple;
	bh=Uc9Q0cAfj6iJvFzBvKtP4wk+lx5h3ywqCX+aTbIvqi4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=q1+H9/DTBMldJlaAQ36aRqRX+C4dqlT1xJOyDzz5eg6pqw2bkWL9UP0Wtc6CT0A9cVmnAnH8wx8ky4xQjVHYWK96hHQ74CNSPbx3G6uT/sODtStkEKVkFMeLiafnXoKuQCpMVs1V0pWE73Xuy0HxKdvz5FyJQHD8XIa/ZZSvTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlC+R6n4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaecf50578eso519467666b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Apr 2025 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745185550; x=1745790350; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqIdb6QBcj9LHoO4IpJCQtusRUAC9L2d/BK02Bac0lk=;
        b=LlC+R6n4rn3ygos7uAKMEG1i3XzfiA0E5grqIDvGoeMMpbg//f9BM7hs1+8Tv4VVsd
         g31/ym7j35HdIvWezd53wMn4OpG8a1Ik6CUcAVW+MdOIrlEpGOKZmBoe1hLBvm85CWaj
         JXzwr1VkgJ5Q1hwASrvg17DMmZ4Sfx6Y/V4phB2pjekNFWf50kOrcWr3ZdcGyNZBcDBY
         o7q04FJBrAP085r0VknTwxfb3p0RF4GIBjQwigXZqKybBYH3Rk3IXBJ1pvrLga+dqjRZ
         GLNWErLjX4zeutHl95XlUCAtIbqcLp1cfxa3nHcbiiQrfh+TCSS45zbHjdq8koxCRyWG
         UBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745185550; x=1745790350;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqIdb6QBcj9LHoO4IpJCQtusRUAC9L2d/BK02Bac0lk=;
        b=TJylbmVSD1elGdaBsDsPQzC66+Khi4Rwlpf6wQ/gxLJVCvOsrtGvO9ieifNahN5ST3
         XicJ/jycwnlWTCtuecw+wdagNvF0VcS83CKhfj7zXQjapRzDNIVmyEjytqgDgCBWHYSM
         IFWETx8UJ0zXlJ90LkOkBS04Q/Hyu7P66FzRWxVbSacPFtGtWdl+oio0omnXgk4yOkVD
         Flxg3dBnV/swzTviLtDM38hhOufOjxBKKRS9dzRZggEvNnbtVjqc5S7SmHzPl5J2IkDn
         XzAEUcvE+L8GpM8Gjo1939IyEi8avDRZ8ROu8v9lVsn/NC4w6fqJY3OZZLSQ+T/7R47U
         HJiQ==
X-Gm-Message-State: AOJu0YwatG0OFtyi21C0ohjIzN3WK0XWryTq70D3gZGKwDaJe2aJm5iy
	m0qY5z6ZeOxcygDSQzUpRH7kZo2tcvpvvwuoGXS3YlCNJyH7f9CSke8aF0iU
X-Gm-Gg: ASbGncsrh3/AY8XaXAeqCKZKjfDLjyCgtApw6EWDzoVR1fg6foLDWE1WcrtLBkCJUiq
	gtB1U5UwhJY3vIw/+MAG/R2vae2VIBC5m97C7BD5bBqq/NZG66Th5suoXY+qBNlKW3pfOoKLbtQ
	SQHPaiPcOztL8zmeEr4eyoGF+xZ1ELvBYlyTjhsuKdtkEim2EBhdAVBPmJfF23UVR2wNQFCyz4X
	nZTybKNhj79Rrq8pXh0EE2INS41HPy2FY02CdUlZkTpIZif0vokfcPRIpdpWlyhAuAaf+e09jDk
	tgsZal/XJ6dl7zVx9TH0UIq/ymB7xezxJ7zTIE9qprJB08KtmqPLgZcyWHYyCOhE3Meqdq/JP5I
	M3/G3u92Eq2r40jLBjk5pkyuKjy1zr4FBPbpLxigoGy2/BE2r8Bn1khwGcw==
X-Google-Smtp-Source: AGHT+IFUPufLjxRp6pyODqRNj9QIbaPrCAOp0ixJJBNHEQJ7emmUNomDN+gYVYHnm0+l7bldXmf5AQ==
X-Received: by 2002:a17:907:2d0d:b0:acb:4f46:9d18 with SMTP id a640c23a62f3a-acb74af251dmr878562366b.3.1745185549603;
        Sun, 20 Apr 2025 14:45:49 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:7713:a41a:3b55:383? (2a02-a466-68ed-1-7713-a41a-3b55-383.fixed6.kpn.net. [2a02:a466:68ed:1:7713:a41a:3b55:383])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec424f1sm429179666b.38.2025.04.20.14.45.49
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 14:45:49 -0700 (PDT)
Message-ID: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
Date: Sun, 20 Apr 2025 23:45:54 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Ferry Toth <fntoth@gmail.com>
Subject: Errors on newly created file system
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The following is originally done by Yocto's bitbake, but when I try 
manually it reproduces.

I create a new fs on  a file using -r as ordinary user, then btrfs check 
the file (before or after mounting makes no difference), also as an 
ordinary user.

The fs has 1000's of errors, I cut most because it seems the same type 
of errors. The files system is unrepaired bootable, but can be repaired 
using --repair, in which 1000's of files are moved to lost+found.

The below was mkfs on a non-existing file, but writing to 16GB dduped 
file (rootfs is 1.4GB) makes no difference. Neither does dropping 
--shrink, -m or -n.

Also, writing the file to an actual disk and then check the disk gives 
the same errors.

What could this be?

ferry@delfion:~/tmp/edison/edison-scarthgap$ mkfs.btrfs -n 4096 --shrink 
-M -v -r 
/home/ferry/tmp/edison-intel/my/edison-morty/out/linux64/build/tmp/work/edison-poky-linux/edison-image/1.0/rootfs 
edison-image-edison.rootfs.btrfs
btrfs-progs v6.6.3
See https://btrfs.readthedocs.io for more information.

ERROR: zoned: unable to stat edison-image-edison.rootfs.btrfs
NOTE: several default settings have changed in version 5.15, please make 
sure
       this does not affect your deployments:
       - DUP for metadata (-m dup)
       - enabled no-holes (-O no-holes)
       - enabled free-space-tree (-R free-space-tree)

Rootdir from: 
/home/ferry/tmp/edison-intel/my/edison-morty/out/linux64/build/tmp/work/edison-poky-linux/edison-image/1.0/rootfs
   Shrink:           yes
Label:              (null)
UUID:               c2ecfaca-168a-401b-a12a-e73694d7485a
Node size:          4096
Sector size:        4096
Filesystem size:    1.43GiB
Block group profiles:
   Data+Metadata:    single            1.42GiB
   System:           single            4.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  mixed-bg, extref, skinny-metadata, no-holes, 
free-space-tree
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
    ID        SIZE  PATH
     1     1.43GiB  edison-image-edison.rootfs.btrfs

ferry@delfion:~/tmp/edison/edison-scarthgap$ btrfs check 
edison-image-edison.rootfs.btrfs
Opening filesystem to check...
Checking filesystem on edison-image-edison.rootfs.btrfs
UUID: c2ecfaca-168a-401b-a12a-e73694d7485a
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
root 5 inode 252551099 errors 2000, link count wrong
         unresolved ref dir 260778488 index 2 namelen 11 name 
COPYING.MIT filetype 1 errors 0
root 5 inode 252551611 errors 2000, link count wrong
         unresolved ref dir 260775820 index 79 namelen 18 name 
generic_Apache-2.0 filetype 1 errors 0
root 5 inode 252575069 errors 2000, link count wrong
         unresolved ref dir 260777976 index 3 namelen 10 name recipeinfo 
filetype 1 errors 0
root 5 inode 252575538 errors 2000, link count wrong
         unresolved ref dir 260778506 index 3 namelen 10 name recipeinfo 
filetype 1 errors 0
root 5 inode 252577241 errors 2000, link count wrong
         unresolved ref dir 260777972 index 3 namelen 10 name recipeinfo 
filetype 1 errors 0
root 5 inode 256713617 errors 2000, link count wrong
         unresolved ref dir 260776096 index 3 namelen 12 name 
GPL-2.0-only filetype 1 errors 0
root 5 inode 256713619 errors 2000, link count wrong
         unresolved ref dir 260776096 index 5 namelen 13 name 
LGPL-2.1-only filetype 1 errors 0
root 5 inode 256713620 errors 2000, link count wrong
         unresolved ref dir 260776096 index 6 namelen 10 name recipeinfo 
filetype 1 errors 0
root 5 inode 256730804 errors 2000, link count wrong
         unresolved ref dir 260777541 index 3 namelen 7 name COPYING 
filetype 1 errors 0
         unresolved ref dir 260777543 index 3 namelen 7 name COPYING 
filetype 1 errors 0
root 5 inode 256730805 errors 2000, link count wrong
         unresolved ref dir 260777541 index 4 namelen 11 name 
COPYING.LIB filetype 1 errors 0
         unresolved ref dir 260777543 index 4 namelen 11 name 
COPYING.LIB filetype 1 errors 0
root 5 inode 256730806 errors 2000, link count wrong
         unresolved ref dir 260777541 index 5 namelen 15 name 
COPYING.RUNTIME filetype 1 errors 0
         unresolved ref dir 260777543 index 5 namelen 15 name 
COPYING.RUNTIME filetype 1 errors 0
root 5 inode 256730807 errors 2000, link count wrong
         unresolved ref dir 260777541 index 6 namelen 8 name COPYING3 
filetype 1 errors 0
         unresolved ref dir 260777543 index 6 namelen 8 name COPYING3 
filetype 1 errors 0
root 5 inode 256730808 errors 2000, link count wrong
         unresolved ref dir 260777541 index 7 namelen 12 name 
COPYING3.LIB filetype 1 errors 0
         unresolved ref dir 260777543 index 7 namelen 12 name 
COPYING3.LIB filetype 1 errors 0

...

         unresolved ref dir 260777434 index 4 namelen 10 name recipeinfo 
filetype 1 errors 0
         unresolved ref dir 260777436 index 4 namelen 10 name recipeinfo 
filetype 1 errors 0
         unresolved ref dir 260777438 index 4 namelen 10 name recipeinfo 
filetype 1 errors 0
root 5 inode 260775819 errors 2000, link count wrong
         unresolved ref dir 260775820 index 2 namelen 16 name 
license.manifest filetype 1 errors 0
ERROR: errors found in fs roots
found 1061572608 bytes used, error(s) found
total csum bytes: 990472
total tree bytes: 47329280
total fs tree bytes: 44457984
total extent tree bytes: 1511424
btree space waste bytes: 11573386
file data blocks allocated: 1014243328
  referenced 1014243328


