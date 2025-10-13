Return-Path: <linux-btrfs+bounces-17745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8666ABD6B1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 01:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18E8405023
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 23:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB802F7459;
	Mon, 13 Oct 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="jm8/xMRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sonic305-21.consmr.mail.gq1.yahoo.com (sonic305-21.consmr.mail.gq1.yahoo.com [98.137.64.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9129D275
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396630; cv=none; b=FFG8a4vM9o8Mxmk+USZjmz1wm551Er/XkRbgyezBDOkmBmDye3EAN7+VJtc3gCYFDybsUfq6Yuv4a48HQ5aihbbk9/IObnIWOhw4T56uSCCcquzP4lDAgqFOXtxRNBqjasVcaGhi7CLnpELEtFWoi15Aqb2/6HESvmBsRXO883Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396630; c=relaxed/simple;
	bh=FkK9VYZOglPajvMFRGk6FKtMm+Y8TGNM5kq2KzCA5y4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=NVy4X02Q2FIBKBOkUxRZx9yoTg/mrFgcfh/zbCYp1rkHRXQr/jTk0MfjZQomwlAS/mO8yc+Z1EzI29ruIVJMPZz1rqZ8Q1auDsQXK8mbgotMdTV70mJUXev6tex8hqtr6+7zAXU3nGmn5bzX/78+mFXnyQ0CGjNfxyvA69ly/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=jm8/xMRR; arc=none smtp.client-ip=98.137.64.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1760396620; bh=zfjWw6F6ofrunyrAu915XQht9Ji7yZloVBaIllCzCXQ=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=jm8/xMRR9VGiK7PqXJhJQw/i5Jtae7S7gKi+NbCYEd+7yq34ypX7nRfvXXNeYgddcLtg5EqVS6jlyQlvmOOoI2aPAWzbahYHqL/ttVSPcF5mtCtyZz7zfNYrdpY4cvwqIajIEHipiSEcd1ufYJXqkD4WuSE5LqWVDI1/z+tM77tGG6XciLrNCWW/E3A5Dx/6dOxSgWN/GEr5JKvwNCt7mvrFc2M4nDEEvcIEVjot8rPiIy3qMTSWn8+ZlT1AOBHmoDTk9NhPYEyoVJfriWVSQkSQNJC0Il9RdYQRUvb0/GAnpUelPall+Cvr/GofrR7siw1g0NZ72NTCqN+VS9+01Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760396620; bh=CO5+HThUlNyLLwzvkwLTUKb9HspYCQFlrpVQw4I+yQz=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=ZCA4gE6CgzAeFPVrl9IwRODOEE0tbnDZjYR4AXNhSnG6Q/haF9Se056QV8iMjPZmlZphATxEW23+aGeybfWFWwLcsfH6wQyDlEsf3PjyM085Zb9AryTdff6VGbrdE+NlFIPeirYR7dSR7nsr7dy0e1aXPIeOfTcbGC/bsVaPPE/5SyvcQyluEBxrlFg51Wy2aMTzIl+bNmmrU/PaAegw9MJwq3QVZ3Kh9tRD1HZRqCFy8Oklfatv0bHOZotaWQm//VRj2Xmeq3uuNmlyxhOPro+wV5cmS22NehI8PpkFDeo/M8Dk3EoOXsNx2cIwr5dDKRQo0KEQbu5uUGfDybiR2w==
X-YMail-OSG: Bi7_DkkVM1mpZN1phXehba3riXELJbPNT7sjqp6BcjjcqBQbfmLYG8WUtyyR_CF
 8SUTsh_VTKXuvkwmpmLkhELnhSbJVHiSpDkt1mk_5G4zFFvICnqSWrjZGz0LM49ByvTeyypPAoqq
 Jk4.iA4q6QzlIG97bgY18Y6dthZVEulJP7CcKviN2uMaeE11V973wVNt7R30_b1V.R107GFcBACA
 u9t1u7lcwxLE1sRhPgQP5zhSjNL0JCEYngO_8F2M8PFoE7ybMfpXo6mca7yX4zOb3U6IwPNESZuR
 .VRKsamRdc6gPyWpQlKhkODmvJbg1fuGlZMkd37eWDZ.AYas.bfJYU87ur1B0PmKSETyrceCeB0G
 K8XGszmkUDv0Dvtbunew86ee8OY9rkT3XsVNy112RnKAqeaWtcFCrrf1kXYrKNJ21Lxdq.UawJU4
 Q0QRPJ8.p7lwvJyGG4BVnQ17dsEe_IMdyX9t3jbdTSMVWoAFWEPpkTaM.sQdrHKIcRWZL1XPdslx
 NEvhhAVKIxpxf18MeJRsQSfmiE5SEaZD1V9ci3n8oCA80HyiAZSK_Iuu6A0.K3rLGF4PxzLoXbnF
 bZK0ctPOma6tWhdqeXaBUC9HWd1a70TEzI1avhscblxaRzJ_Kj_J7IzIL1gp98KQKeze3RG_LR9L
 wQdG.f7.OAiT17W_iGKi.OJZb17XgypZZgk4bJXC4iypbuf.LxY8uhAMJhuYBbMEyjmEapixXXDn
 f5GDMd4kF6mDOnvRZkkNy0zWroPAY4mkUopMASYuCz5q5lb7Jekqd6x8owZ_pr156VIeAX5Qp1y3
 1Qo9dYOFy26ZHpoa.KLN0Bc2F3jfFOQAJ0sSxwECLssZvRQraKt42UKIboj.10fJbk82Xl4CVxAT
 9WOzSyq6raFJMzWRkPhR1eClXnkiSx5cwK2Wbvs8mTlYb3gjf_EDr0W52CJYx9g4Wc0Y8o0gC7cJ
 lEi0ylp0sVF7xLe3338vCJjsEsEIlENVoY7B104opREyEi4Hk.h3.g4rQM.GJGUBsNBViBNkRVsR
 4H1WwMKNDfm02W9WbIMx_fDn6QlqDt.punXckDOi5xT4YMLkl5gqDtWlwLng4v2nR2Bo5bwnXEzK
 RBWGe5KRyuyzYL8Ieag3y3n79VmtzEd6a6J_S4fxvhRkhfuDH5s2Py15ByyrhRZjXrV.nR3pOxVU
 HEmgZNlS2Z0RpS92t2.MDtNDCs1fOXZ4wh62qF2UPUMYRyBTBBWn7b_fe_o9xLBDi_gXH.HaXrQ1
 f5iR_jRM6ZvQjSwK7T7CZtlBxuhvb52EW.6YVMX7mBtn3nBeeLS1F.63vdPMsfOh6Tjbs0chYzKu
 7_ZB6epuisXy.cnEgO_pXhBar0jA7BMvM.8TG34Ubv3fxH2xjksbdwMZNT_4I6RSwRk8EJ6Vh0LP
 OPixZ5a3CsMIc7Yvs7Ky8FzhADhmyCAV4FT6VyRGV4LBix4sx0xsKIAijtwQ2ZGV0wrWjJzAeG6d
 8nq9eRRTINORb7oLyib4gwV8greHkBGUVS836h_SH7b0t.g5ghDyXtQKX_4nAtaigXjBBvrY_.tw
 uommY14Q9dmzSn4wiiPmJRRYgDZAcTovZWusqmsPqT67U2N5sPu31bwVzZSabFYv1NduMRnnsu5B
 wphZINreGI6v7t3CYnhQdL4F2ueZLJMUqmYpTlJohHrQ93emh1au82ZOMlrSHN6XyjEW6CFMJQZL
 2eSUauqgtb.TnxZex_ZpNfc.kiF.xHJ6nZ99rmEngHEhicimrcNypEc9TAXEhwVvTj6JG96uGKQF
 6B9Ugv62Y5w2FrKhSt2FuyODT.LbkwXsM4EZtcBfXf1EkwOuDuKe1YYJNK6mQK6WTEI18mMW1.zD
 CAwDhUmA6Isk21zN0Lno6QtzpacrbqR4auinVWKjtGCnC1HpN5fwrfJuygvGiNVYpN9gR3ukgqU4
 MhaNco2WWH_BKXkBk6gkgayIYdgDwQAxxPJcFnLHtDs0idkIJ.jMbXulF3IHpkejE1A1aJHbpKLx
 xKjX2Vik.dWMcZmf.LJFaw3VG50pALDTvD7Aq5gv5b8_vzmxKVjJJQ5aU5WHYdtG2zNG2a.ZN2Ka
 gc9fq27lZGkvitJLelEn18tDkdpuWFiCASHeh1BGKRpqCk66cBk_uKOziB7iX6bhefc0jnJtFP5G
 hbUqT_jlo.0lL.pR81WvZTUrsqudFoIbMJD8EAoem2GtICLQ6vqeAKmUIHiBo1qj4dZ3UzSgl50u
 dL59ofI.DAWmF58BKKHBRtGsmA_bc08qW0oY5Wz0qSu2O
X-Sonic-MF: <brent.belisle@verizon.net>
X-Sonic-ID: 86f614ae-d516-4131-a3fe-4dcdd1015dbe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 13 Oct 2025 23:03:40 +0000
Received: by hermes--production-bf1-565465579b-sw5jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 900a4ec49a309941392e5bc0bc74ca34;
          Mon, 13 Oct 2025 22:53:30 +0000 (UTC)
Message-ID: <acb2f7d4-ace1-488c-a7f5-cd499d3f637f@verizon.net>
Date: Mon, 13 Oct 2025 17:53:28 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Brent Belisle <brent.belisle@verizon.net>
Subject: Discard=Async question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <acb2f7d4-ace1-488c-a7f5-cd499d3f637f.ref@verizon.net>
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

I hope this is the right place to ask this question.  I noticed that 
when using the latest Linux kernel  6.17.2 and I issue a findmnt 
command, the discard=async mount option is not showing up in the 
output.  However using the Linux kernel 6.16.12 and issuing the same 
command the discard=async command shows in the output. So my question is 
is/has btrfs discard=async been disabled in the Linux 6.17 kernel 
series?  Or is it really enabled and it is just a findmnt command 
display issue.  I'm including the output of both commands  so you can 
see what I'm talking about.  Thnaks for your help.

Linux Kernel 6.16.12
LMDE 7 Debian 13 Trixie

findmnt -t btrfs
TARGET        SOURCE                 FSTYPE OPTIONS
/             /dev/nvme0n1p2[/@]     btrfs 
rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=33929,subvol=/@
├─/btrfs_pool /dev/nvme0n1p2         btrfs 
rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
├─/home       /dev/nvme0n1p2[/@home] btrfs 
rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=33928,subvol=/@home
├─/970_EVO    /dev/sdb1[/@]          btrfs 
rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@
├─/EVO_POOL   /dev/sdb1              btrfs 
rw,noatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
├─/PRO_POOL   /dev/sda1              btrfs 
rw,noatime,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
└─/850_PRO    /dev/sda1[/@]          btrfs 
rw,noatime,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@

Linux Kernel 6.17.2
LMDE 7 Debian 13 Trixie

findmnt -t btrfs
TARGET        SOURCE                 FSTYPE OPTIONS
/             /dev/nvme0n1p2[/@]     btrfs 
rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=33929,subvol=/@
├─/btrfs_pool /dev/nvme0n1p2         btrfs 
rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=5,subvol=/
├─/home       /dev/nvme0n1p2[/@home] btrfs 
rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=33928,subvol=/@home
├─/970_EVO    /dev/sdb1[/@]          btrfs 
rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/@
├─/EVO_POOL   /dev/sdb1              btrfs 
rw,noatime,compress=zstd:1,ssd,space_cache=v2,subvolid=5,subvol=/
├─/PRO_POOL   /dev/sda1              btrfs 
rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=5,subvol=/
└─/850_PRO    /dev/sda1[/@]          btrfs 
rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=256,subvol=/@



