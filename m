Return-Path: <linux-btrfs+bounces-3390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69787FADF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C746F1F21C42
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59B7D071;
	Tue, 19 Mar 2024 09:37:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxout1-he-de.apache.org (mxout1-he-de.apache.org [95.216.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30D51C28
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.194.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841029; cv=none; b=H07CJlSX3rV1qSLeCXIrVvl+uKT8Yv4kQHnS3zmom7q8G7gWb44MAJ0y97izc2f4zW+NO7tN+w8RRuVR3YevZ+MjAmeSk1GszlIJKihNKG2KZCm2Bd3WR07i4tmDgfD6ACGVGiwzm2XR6+aKW+0Eib8xefIrDtQkp90YqAB2e+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841029; c=relaxed/simple;
	bh=ukyr+/rJxe+iSrQICGR09/fZLZht+6uWhh9VtNv7QNI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ud3gW8IqnQ6YUOnk2/Cbi+AZ/dp0y1YY8EhsUICqHwl309rtxClin8m14ViJt6lBOk2w/MbrrlO+nfLPefrQmNKG9KSFIfYWQcJVz/sNg/9gXDF8nTshV8YK0Zko7eft6tTeuBPcHrUgQ9RFU14hPsB2OGIRChfsuCE/84OSKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apache.org; spf=pass smtp.mailfrom=apache.org; arc=none smtp.client-ip=95.216.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apache.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apache.org
Received: from mail.apache.org (mailgw-he-de.apache.org [IPv6:2a01:4f8:c2c:d4aa::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mxout1-he-de.apache.org (ASF Mail Server at mxout1-he-de.apache.org) with ESMTPS id BE83367A43
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:36:35 +0000 (UTC)
Received: (qmail 754174 invoked by uid 116); 19 Mar 2024 09:36:35 -0000
Received: from ec2-52-204-25-47.compute-1.amazonaws.com (HELO mailrelay1-ec2-va.apache.org) (52.204.25.47)
 by apache.org (qpsmtpd/0.94) with ESMTP; Tue, 19 Mar 2024 09:36:35 +0000
Authentication-Results: apache.org; auth=none
Received: from [10.24.7.3] (unknown [130.248.54.10])
	by mailrelay1-ec2-va.apache.org (ASF Mail Server at mailrelay1-ec2-va.apache.org) with ESMTPSA id 0C2EF3EB88;
	Tue, 19 Mar 2024 09:36:33 +0000 (UTC)
Message-ID: <cff511401c4cbddeba45ddae60a968516ab5817a.camel@apache.org>
Subject: Re: parent transid verify failed after SATA cable partially
 unplugged
From: Robert Munteanu <rombert@apache.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Btrfs BTRFS
	 <linux-btrfs@vger.kernel.org>
Date: Tue, 19 Mar 2024 10:36:32 +0100
In-Reply-To: <24749be2-64fb-4b1a-9fd5-9d27437dd47c@gmx.com>
References: <f3ec0b8237094b06375dc1b82a70964c2a8c10db.camel@apache.org>
	 <24749be2-64fb-4b1a-9fd5-9d27437dd47c@gmx.com>
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

Hi Qu,

On Tue, 2024-03-19 at 20:00 +1030, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2024/3/19 19:22, Robert Munteanu =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > (I am not subscribed to the list, please CC me on replies)
> >=20
> > After a bit of hardware maintenance I have very likely unseated one
> > of
> > the SATA cables. The machine still booted, but I noticed various
> > errors
> > related to SATA communications (did not save them unfortunately).
> >=20
> > After reseating the cables these are gone but BTRFS complains in
> > various forms, mostly
> >=20
> > [=C2=A0=C2=A0 10.771222] BTRFS error (device sdb1): parent transid veri=
fy
> > failed
> > on 407076864 wanted 888537 found 887627
>=20
> If you're doing all the things live, then those error are more or
> less
> expecccted.

For the record, that was not live, I did all the reseating with the
computer powered off.

>=20
> >=20
> > [=C2=A0=C2=A0 98.418587] BTRFS error (device sdb1): space cache generat=
ion
> > (887711) does not match inode (888531)
>=20
> But this means you're still using v1 space cache, which is no longer
> enabled by default.

Ack.

>=20
> >=20
> > [=C2=A0=C2=A0 98.484961] BTRFS error (device sdb1): csum mismatch on fr=
ee
> > space
> > cache
> >=20
> > [=C2=A0=C2=A0 98.489141] BTRFS error (device sdb1): csum mismatch on fr=
ee
> > space
> > cache
> >=20
> > All errors indicate device sdb1, which is
> >=20
> > $ btrfs filesystem show /dev/sdb1
> > Label: none=C2=A0 uuid: d0e910df-7a34-4cc9-a67f-f28ceb455022
> > 	Total devices 2 FS bytes used 47.82GiB
> > 	devid=C2=A0=C2=A0=C2=A0 1 size 512.00GiB used 49.01GiB path /dev/sdb1
> > 	devid=C2=A0=C2=A0=C2=A0 2 size 512.00GiB used 49.01GiB path /dev/sdd1
> >=20
> > That device is mounted at /mnt/fast001, in a RAID 1 setup
> >=20
> > $ btrfs filesystem usage /mnt/fast001
> > Overall:
> > =C2=A0=C2=A0=C2=A0=C2=A0 Device size:		=C2=A0=C2=A0 1.00TiB
> > =C2=A0=C2=A0=C2=A0=C2=A0 Device allocated:		=C2=A0 98.02GiB
> > =C2=A0=C2=A0=C2=A0=C2=A0 Device unallocated:		 925.98GiB
> > =C2=A0=C2=A0=C2=A0=C2=A0 Device missing:		=C2=A0=C2=A0=C2=A0=C2=A0 0.00=
B
> > =C2=A0=C2=A0=C2=A0=C2=A0 Used:			=C2=A0 95.64GiB
> > =C2=A0=C2=A0=C2=A0=C2=A0 Free (estimated):		 463.21GiB	(min: 463.21GiB)
> > =C2=A0=C2=A0=C2=A0=C2=A0 Free (statfs, df):		 463.20GiB
> > =C2=A0=C2=A0=C2=A0=C2=A0 Data ratio:			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
.00
> > =C2=A0=C2=A0=C2=A0=C2=A0 Metadata ratio:		=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 2.00
> > =C2=A0=C2=A0=C2=A0=C2=A0 Global reserve:		=C2=A0 17.89MiB	(used: 0.00B)
> > =C2=A0=C2=A0=C2=A0=C2=A0 Multiple profiles:		=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 no
> >=20
> > Data,RAID1: Size:48.00GiB, Used:47.79GiB (99.56%)
> > =C2=A0=C2=A0=C2=A0 /dev/sdb1	=C2=A0 48.00GiB
> > =C2=A0=C2=A0=C2=A0 /dev/sdd1	=C2=A0 48.00GiB
> >=20
> > Metadata,RAID1: Size:1.00GiB, Used:33.31MiB (3.25%)
> > =C2=A0=C2=A0=C2=A0 /dev/sdb1	=C2=A0=C2=A0 1.00GiB
> > =C2=A0=C2=A0=C2=A0 /dev/sdd1	=C2=A0=C2=A0 1.00GiB
> >=20
> > System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
> > =C2=A0=C2=A0=C2=A0 /dev/sdb1	=C2=A0=C2=A0 8.00MiB
> > =C2=A0=C2=A0=C2=A0 /dev/sdd1	=C2=A0=C2=A0 8.00MiB
> >=20
> > Unallocated:
> > =C2=A0=C2=A0=C2=A0 /dev/sdb1	 462.99GiB
> > =C2=A0=C2=A0=C2=A0 /dev/sdd1	 462.99GiB
> >=20
> > What is the recommended way of repairing the device? This is not a
> > root
> > device so I can play around with it.
>=20
> Just scrub that device, and everything should be fine.
>=20
> After one scrub, check if there is any unrecovered errors. If all
> errors
> are recoverable, you're totally fine.

That seems to have worked, thanks!

$ btrfs scrub status /dev/sdd1
UUID:             d0e910df-7a34-4cc9-a67f-f28ceb455022
Scrub started:    Tue Mar 19 09:31:45 2024
Status:           finished
Duration:         0:01:42
Total to scrub:   95.64GiB
Rate:             480.07MiB/s
Error summary:    verify=3D230 csum=3D77928
  Corrected:      78158
  Uncorrectable:  0
  Unverified:     0


>=20
> And after everything is fine, it's recommended to migrated to v2
> space
> cache.

Put it on my TODO list, thanks for noticing that.

Thanks,
Robert

>=20
> Thanks,
> Qu
> >=20
> > Thanks,
> > Robert
> >=20


