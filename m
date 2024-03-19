Return-Path: <linux-btrfs+bounces-3388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD287FA3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 10:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB642282395
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB57BB17;
	Tue, 19 Mar 2024 09:03:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxout1-he-de.apache.org (mxout1-he-de.apache.org [95.216.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67154BE2
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.194.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839004; cv=none; b=Yduu92SxXPUYRYq1bzdICmpnoH4JHPQlo//MTKWWNUhgDxGDCi9kJTPU31a3hwJ3RnCbZ4PTrK5oqwp3zxvMH9YDkdXGoG+pB8Z4nL8LG/0/GZK0S6QJtxChXVYYpzNKaV83whsCJAe3GsfBdgWBLqf2RO9cG3nPYMb39QU1h3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839004; c=relaxed/simple;
	bh=ctoUnKYNC/mSy6y5As+uh+SEgfu/RIB3GAN0fHMy17o=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=RPG/FzOeHoIchbwumL1fj64IUWh/VHKIikO2X9dV9ZaDkfrV9dI9d0wmADlVP5ojug/UMvRwjwSUsHN66eQ0mRD5yMcXozVHLK/VUS396ZHgExFDdll2dPH56yokG3+9fFHZRNI9+CIXJrWKde7FaBQy/DwQtRKPP7qWjPKo42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apache.org; spf=pass smtp.mailfrom=apache.org; arc=none smtp.client-ip=95.216.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apache.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apache.org
Received: from mail.apache.org (mailgw-he-de.apache.org [IPv6:2a01:4f8:c2c:d4aa::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mxout1-he-de.apache.org (ASF Mail Server at mxout1-he-de.apache.org) with ESMTPS id 666946FCB2
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 08:52:46 +0000 (UTC)
Received: (qmail 627573 invoked by uid 116); 19 Mar 2024 08:52:46 -0000
Received: from mailrelay1-he-de.apache.org (HELO mailrelay1-he-de.apache.org) (116.203.21.61)
 by apache.org (qpsmtpd/0.94) with ESMTP; Tue, 19 Mar 2024 08:52:46 +0000
Authentication-Results: apache.org; auth=none
Received: from [10.23.2.214] (unknown [51.154.28.112])
	by mailrelay1-he-de.apache.org (ASF Mail Server at mailrelay1-he-de.apache.org) with ESMTPSA id EC4873E897
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 08:52:45 +0000 (UTC)
Message-ID: <f3ec0b8237094b06375dc1b82a70964c2a8c10db.camel@apache.org>
Subject: parent transid verify failed after SATA cable partially unplugged
From: Robert Munteanu <rombert@apache.org>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date: Tue, 19 Mar 2024 09:52:45 +0100
Autocrypt: addr=rombert@apache.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

(I am not subscribed to the list, please CC me on replies)

After a bit of hardware maintenance I have very likely unseated one of
the SATA cables. The machine still booted, but I noticed various errors
related to SATA communications (did not save them unfortunately).

After reseating the cables these are gone but BTRFS complains in
various forms, mostly

[   10.771222] BTRFS error (device sdb1): parent transid verify failed
on 407076864 wanted 888537 found 887627

[   98.418587] BTRFS error (device sdb1): space cache generation
(887711) does not match inode (888531)

[   98.484961] BTRFS error (device sdb1): csum mismatch on free space
cache

[   98.489141] BTRFS error (device sdb1): csum mismatch on free space
cache

All errors indicate device sdb1, which is

$ btrfs filesystem show /dev/sdb1
Label: none  uuid: d0e910df-7a34-4cc9-a67f-f28ceb455022
	Total devices 2 FS bytes used 47.82GiB
	devid    1 size 512.00GiB used 49.01GiB path /dev/sdb1
	devid    2 size 512.00GiB used 49.01GiB path /dev/sdd1

That device is mounted at /mnt/fast001, in a RAID 1 setup

$ btrfs filesystem usage /mnt/fast001=20
Overall:
    Device size:		   1.00TiB
    Device allocated:		  98.02GiB
    Device unallocated:		 925.98GiB
    Device missing:		     0.00B
    Used:			  95.64GiB
    Free (estimated):		 463.21GiB	(min: 463.21GiB)
    Free (statfs, df):		 463.20GiB
    Data ratio:			      2.00
    Metadata ratio:		      2.00
    Global reserve:		  17.89MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,RAID1: Size:48.00GiB, Used:47.79GiB (99.56%)
   /dev/sdb1	  48.00GiB
   /dev/sdd1	  48.00GiB

Metadata,RAID1: Size:1.00GiB, Used:33.31MiB (3.25%)
   /dev/sdb1	   1.00GiB
   /dev/sdd1	   1.00GiB

System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
   /dev/sdb1	   8.00MiB
   /dev/sdd1	   8.00MiB

Unallocated:
   /dev/sdb1	 462.99GiB
   /dev/sdd1	 462.99GiB

What is the recommended way of repairing the device? This is not a root
device so I can play around with it.

Thanks,
Robert

