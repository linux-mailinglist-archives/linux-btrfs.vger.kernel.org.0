Return-Path: <linux-btrfs+bounces-6974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7F947289
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 02:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4961F211B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 00:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD626AD0;
	Mon,  5 Aug 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N4JdejcE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E0EDC
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722818788; cv=none; b=oc3A8F44U6HJbgV9mz6L1tL4nCSKLB7E4gG1CA/+mzom9rLuZnz9lEY9drzwjOSvapfNU2HK1JhP5bAlsknnb6rFeLtlf5p2IHRWjVfnQsc3bSuquN5qzAH7mylMfkPQqkJ4r0//t+/DfFlTJUvOYCPsvrXbZ1ATuXK8NFvT+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722818788; c=relaxed/simple;
	bh=7LiMi7ADuOWU4o5TWh0ANwGd8837Zk95D2d0CApyPbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=txV3bHQ8Nxo9HmMAvz68ecOm3at2Ndz6/SqeEa656sSGXMMMW5iYLAo8RYZBpn/a5+/ZdY/hC8TqWNFZrdjoalFKYs8xEVVjXHp2l8B/HFU3Iuy1ZmGMIcqlkFuQ5KIOCnJaYDXiH+FwtA7TqZulSTIMJhcxZYenE0daGPtffhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=N4JdejcE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722818781; x=1723423581; i=quwenruo.btrfs@gmx.com;
	bh=zvqRVZSDJtyYebvPq37SZUCMdp0vADQk3xCU+4R44/8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N4JdejcEbhB4Xm733hwbLIzvEkBEncQqzeeEEynWhSX5jfzftMGwlJDxG7ov8Imk
	 7bgX4stGNxTlZwsbAY8FT5i1w2zRTE09HqX+dB0wqq3U3Zr3t1WGQo9MyLYKTxT7A
	 JUsbF5CmXCNtQG/DLPEK4puux14yGRwgRvZiTlv1zoSihgShfX9Z80LFIgr1hKUs7
	 G7D92l6xsVan0PJZXbsaaXJ7ROe9yeY1by58Z6drOuhl4HGtD9+v6/3jWjA987os5
	 Ee2wTf29KaS3CqpOCu/86zi83n4Ro1VMoAeOQmYc95Nu1EXNW9lU8xO44QunrIDgV
	 ZtGQY6ACqv/IVnUaQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1rthkt3Cy3-00ZFOp; Mon, 05
 Aug 2024 02:46:21 +0200
Message-ID: <e2d4cc82-bf94-4251-be9a-c98e6e0f6a1a@gmx.com>
Date: Mon, 5 Aug 2024 10:16:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] btrfs-progs: use libbtrfsutil for subvolume
 creation
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240802112730.3575159-1-maharmstone@fb.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240802112730.3575159-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAqm1zR9B+UWPA2p8nyI038TzhrbIhm2vR0IeCSjWpuwXCOcZFL
 NwRDst1jhGmIpd6l1n9FwT8p0dItUXSWBlGmNhN1h+ae6SvKf3i8JpW8fwSOkKI0tQ4gEP9
 QOhw1ah8HlVYvQNUq2s8bcM3a3yGXVcJkXbvYNqg4XXoLGjtdrz6l469m9q7Vy3nd94PJVc
 IzcR6b5Zk3TAO/Q4yM54Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lfVolXBcTCc=;zsOmJ8C8liMVzz6MYzDUcecjkpf
 QLpJVX+43ncaBjyG2a7npfR0aQvLBGW8f/yY3ERgz4aW3SknHDiRcWK5Xw1a5NreZDtYQETX9
 vmb0fNbZdJTh2CrBxDMm5b8I94Pg8ilCOMjqJgMu3vl/wg5yrFgKwhu0BZJb381DJtcenkTx3
 xLsDyKtoBsfC9enqtk4OLcHhvoWthCg7Gir+N2T6ja1V/cVApqegg6InjGqxwKaSr9qWUlTP/
 qqrtIVtAEX+GgmkLLilgZPQzWK+KLxkFauI3vKyheldhtXics/ObhBNJVt+M3jCFFLgE1HfMz
 d46diM0FrJRJDaa/TwXwNW6JOf8jC7jzfzZWcC0mFSdlf0Ur0q7naSdWItSHB/7g5n7m2FbMV
 rewBz5ZAKVUGihjHv/GmNnS1ps8pfrKevOxESq8bgNCXK12+c9TVymr2Ma7FQovzXjlJ/6Ny5
 tEFhL5SvulaVQyb3y8BMDNROyqFcfiyagFM0OJold6wN/aESaJYAXv17iPFfaiqfbGSRxDXwQ
 vRWyOTIwUEaqXzNFq2paVJfzs6SYrkVKJfdK9zNhClSH+49PNMheXD+cb4YuKoRmCFbJxl6IT
 lJxtBArmslcTChRoXWNFEwPysHl2/baFx/fhlTRQzmuAr8A7zKl5HdalV8AI7TJr2SkzgWIe8
 YEzFrMEi+wNBHfExIYp7TC4i+zgudYHPyA+GazUu40uGWpP0vkvPgV/MUxl6z25xLn/6h8yn3
 4dvCqIdCK4ulP2wyC5scn3ejRMMjBZFYoaiKxmaVQML3G3g2oPtmHRBeT4euQuwHo40/rt0mZ
 DTOOz5Nhft469flDVzu9yM4A==



=E5=9C=A8 2024/8/2 20:57, Mark Harmstone =E5=86=99=E9=81=93:
> These patches are a resending of Omar Sandoval's patch from 2018, which
> appears to have been overlooked [0], split up and rebased against the
> current code.
>
> We change btrfs subvol create and btrfs subvol snapshot so that they use
> libbtrfsutil rather than calling the ioctl directly.
>
> [0] https://lore.kernel.org/linux-btrfs/ab09ba595157b7fb6606814730508cae=
4da48caf.1516991902.git.osandov@fb.com/

Since you're reviving the cleanups, you may also want to move some
btrfs-progs' ioctl related functions to libbtrfsutils.

One example is btrfs_lookup_uuid_subvol_item() and
btrfs_lookup_uuid_received_subvol_item().

With them moved to libbtrfsutils, we can mark
kernel-shared/uuid-tree.[ch] as fully cross-ported from kernel.

Thanks,
Qu
>
> Changelog:
> * Fixed deprecated function names
> * Fixed test failures (now returns correct return value on failure)
> * Fixed this breaking fstest btrfs/300 (thanks Boris)
>
> Mark Harmstone (3):
>    btrfs-progs: use libbtrfsutil for btrfs subvolume create
>    btrfs-progs: use libbtrfsutil for btrfs subvolume snapshot
>    btrfs-progs: remove unused qgroup functions
>
>   cmds/qgroup.c    |  64 ----------------
>   cmds/qgroup.h    |   2 -
>   cmds/subvolume.c | 194 +++++++++++++++++++----------------------------
>   3 files changed, 76 insertions(+), 184 deletions(-)
>

