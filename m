Return-Path: <linux-btrfs+bounces-10971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309BA11D7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 10:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E81B188C74D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADF61EEA47;
	Wed, 15 Jan 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="d4D037sP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBC248173;
	Wed, 15 Jan 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933031; cv=none; b=LubBUuuaY1CJAtV7NGPmP+THNc7HfsIEnj19El7ymLn4fBdWvXhWelkDeHBG7XzxLPB5Cz96w0SDco+Oepgo6pk/3xasX0T1TUJu2ou1gfya7LQVBnCtxlYTmYYNRFTv3bKQMA+F47HPTn/NHpbu/j6vS75DIBEW7rbBJFEGjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933031; c=relaxed/simple;
	bh=Iwp5DlsntPpB2Ma/i8rcyqrt+6GKhYL4CrI7wbuPs5w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VkQ6MzKMZtuH5g6eDNDgGV5kI2fwpCJjZfxo2OKMtqnLPjFIBxqKFS6/TgT6NwHxKUGWI4/lLmpt8RmczoXVtnclQ/eDDFVqKmeP41jauI6rhEY8kf0epbpWkz/B6s7fkdyshrqEzr17j3E+aWKXiO+Xilkedk/asKC8jESqOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=d4D037sP; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736932969;
	bh=Iwp5DlsntPpB2Ma/i8rcyqrt+6GKhYL4CrI7wbuPs5w=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=d4D037sPA+qhv38uwjV1O5gPKMMwRWa+LVsv53ukV5A9L3Dl0KvF/KQUOwpl3FrHA
	 BtfKeUL/brudsY7w4YnFaJuwOLAcq5mh8131ooNy62y3rltRnh/ftF9xgdhzuAnRa5
	 CvmDKlxdSuiMyMEzI0icqJVqnaklNYlNaj2umvAU=
X-QQ-mid: bizesmtpsz7t1736932967t2qn5kq
X-QQ-Originating-IP: ub0u27b1n0Ja8kBjIn2P5iAqxG7HGMYuzOqGtUyMBOU=
Received: from smtpclient.apple ( [202.120.235.205])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Jan 2025 17:22:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14841633537363899611
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: Potential Deadlock or Resource Contention in Btrfs Subsystem
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <085e2f2d-a306-4a38-9943-1e306a8c11ea@gmx.com>
Date: Wed, 15 Jan 2025 17:22:35 +0800
Cc: josef@toxicpanda.com,
 anand.jain@oracle.com,
 nborisov@suse.com,
 dsterba@suse.com,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BECC6BA3-8FBF-4975-B48D-31B2C975D944@m.fudan.edu.cn>
References: <AA0E5191-E4D8-4FAA-AB60-B38D6F2D0E99@m.fudan.edu.cn>
 <085e2f2d-a306-4a38-9943-1e306a8c11ea@gmx.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MZ4KZWW7YB31tEg0wL2SX3+Ch6+42yci3QbjmzihJhABPV34pJjSfAmp
	hmSQ4BoTfTYkXjqbucVE91Wf0EQLOnZxqoIso2MhidUX1+6ev6T4YbEAkGmOtlcGhU2yGx2
	BLEW/ErTwE3oLZjzqxZlgumrDX02P1WAqoPxHaxUW1In4MrhEBlzM7QJurseeh87EVEsHlC
	d8Yur+U8CGE63G2oC1OoU5TLyMFA9sNGhxiSo583o9PtCpoxZ5Vy1RcRH3bapNMioatO2HO
	1aARkkZeIUyWVD2aKIy9GGFWrcOHV7lBDJJYAk60Ypagc4vuTb80TSPVH1ystBYWt3QySs4
	GiOCJbr1/vhsJhC/qTxacafSnf6GqUHL0WALRqVUfcQ3exQNIIE1odgQStNnnv8gY9W2wW8
	LTl2PzenAvE3Q1mcQ9DImzrfAioFy4wmohShn8Vn83CckOLLxTH2b/2rI2b+aGq/mvSIfpR
	OMHDfgn44wrIt8zm8w5sbjdNoNdl/kg77QRQiOpCZOSVxcM8aM/6cPxCZgWfaRCNwGmjCqY
	ZzqZWfNQCEmxJRJ/93IDTBfrxkhALI0e5nnB28bejJ22DvhLTwHuzTeMLeTPIcQLAiF6n5f
	UYTZYgJ52+UmNl7uy8SPcmstlStm7nOLeFEZxtOzYp8Vz/mKqzw4bkxLP9o1sYiLWKSv8d3
	EmTbR1B5kTv85RfMZVlo+3v7b8iPtmjRaN0fIX1uGzbSZUsALn5BYdlZgQ0z+i/s1cypr7z
	BpqM3/r4XM1wn3edPqnks300NEAHYTn2b4s6Y6wOXT4rFdoBlo8L3JxGN3njbQpKaMfGSWY
	MnIyktBEzpI/yg0z1zM67xB5YD8W8hEnjNPeWPNefpANKe9LPsBZaMZxFgO38y41iqLFidS
	pB3WIb7zEScpfHhxAKT/SZj0Qq4AgK2q838vEsUOMUZJRCSJF+X2SEnWzAOn5Ctw0eKKfZX
	b7nIWoUnUGs+wDT9gHi2b4+SgufoT07e1rVs=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0


>=20
> There is a recent report about btrfs' new mount API change lead to
> mnt_list corruption:
>=20
> =
https://lore.kernel.org/linux-btrfs/ec6784ed-8722-4695-980a-4400d4e7bd1a@g=
mx.com/
>=20
> Which can be fixed by the latest VFS branch provided by Christian:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git =
vfs-6.14.mount
>=20
> Considering the offending fc_mount() triggered by
> btrfs_get_tree_subvol() is involved, mind to test if the above branch
> fixes the bug?

We are still reproducing this issue on the vfs mount - v6.14 branch =
respectively, but I'm not sure if it's a significant issue. Looking at =
the latest crash log it seems to be consistent with the originally =
reported issue (BTRFS filesystem race operation causing deadlocks and =
initialization function failures). Looking at the reproducer =
perf_event_open and syz_mount_image are both using randomly crafted =
parameters.=20

Specifically, perf_event_open entered the cpu=3D0x3ffffffffff parameter =
resulting in frequent performance event monitoring initialization, and =
the CPU number range defined by this parameter did not satisfy the valid =
numbering range, which could trigger invalid accesses and resource =
contention. In addition, the image data for syz_mount_image is randomly =
generated, which may lead to parsing failure of block device metadata, =
log playback errors, and block order anomalies.We give the link of the 3 =
new issue logs : 1) on vfs mount - v6.14 branch, 2) on v6.13-rc7, 3) on =
v6.13-rc7 merged with vfs mount - v6.14 branch

1) Link: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/41-BUG_%20soft=
%20lockup%20in%20lo_ioct/crashlog0113_vfs-mount%20v6.14.txt

2) Link: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/41-BUG_%20soft=
%20lockup%20in%20lo_ioct/crashlog0115_6.13rc7.txt

3) Link: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/41-BUG_%20soft=
%20lockup%20in%20lo_ioct/crashlog0115_6.13rc7_vfs-mount%20v6.14.txt

I=E2=80=99m not sure if the log is useful for you. If you have any =
concerns, Please let me know. And If it=E2=80=99s not a important issue, =
then please ignore it too!=20

=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun Hu=

