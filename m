Return-Path: <linux-btrfs+bounces-2377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E36854410
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01E91F227A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB89524F;
	Wed, 14 Feb 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ItQxqSkH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661A33DD
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899543; cv=none; b=JpUIBI996rxWg0X3CXbJSenFHoL1iFL1gJHk9ByAyEtk2GG6NU+wTgZCcPnuxDh+sBBvfTMueFoM1pyH+0pXAtUJrDnHK36CocHRdfES6jn6ZkRS0Pll2QAKkhcvBE010tRAAwk67WIrKI/SVP15K7LxndXG3oR5TFbaLbQ9EUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899543; c=relaxed/simple;
	bh=eBozQ+YksG3ivkyMDxvQRWaJPYs/4TVo7mL9HEQi4gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKCL1PbXLm/nV5Fq5ON+CX63X55yG3ACrM4BGba9Pgex4B6LOKh6o+2YyQ72q/a4YLJVghOF2odiOOzox3/3zwkVevFIkxE/gHV+S7uen4XKHOWgcRnxC7QWcd2msPVbyyI3ibI+MujTixtkR0D4keqIb9INJRcFRtBcLU9w9to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ItQxqSkH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707899532; x=1708504332; i=quwenruo.btrfs@gmx.com;
	bh=eBozQ+YksG3ivkyMDxvQRWaJPYs/4TVo7mL9HEQi4gw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ItQxqSkHuRUUV73Ej29c96wURusNaSxxx9442FJ1QBTXGdYaCL7VIArIwndSdIdO
	 Sllpy8zTUf4qjZ7eSQSfOzAhTPvSUPG1i65n51kYryOVTmxxGp6/NbCrfTT3i+HwZ
	 14Fbw8DK0i0kEu7Fo2Yb46DlFqDreBgSCeH4dzqn/rK/dbGmWTID9A/4ltxw/Urny
	 SbBgBbRLrpucEGpM1ZBMoVMCS4eiNEhdtioHkZqx8+/FuvB5HAl6QD7ecwr6Jh147
	 OEdpJKJz6BiS0B3Kkx6AA0gLWvU8gxzJ2Wag9LzzZpIG2setifK1cmTRBlrlxQ/SA
	 +QNPgYWngetV/+S/Ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1rBVBq0KYo-00qUGe; Wed, 14
 Feb 2024 09:32:12 +0100
Message-ID: <ff18404f-ca7e-4c48-a3d5-e7fab921ade1@gmx.com>
Date: Wed, 14 Feb 2024 19:02:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Content-Language: en-US
To: dsterba@suse.cz
Cc: Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20230219181022.3499088-1-hch@lst.de>
 <7fbe36d5-3ebb-4daa-9c92-0761ba49686b@gmx.com>
 <20240214071240.GK355@twin.jikos.cz>
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
In-Reply-To: <20240214071240.GK355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L1z3eFwXROBgF73V6iqrlENcW1KqD0fkU6cN8XcRiHGgUUlvWxJ
 9ujzndFgsT2DG9tLT5muQMFPoLvVi525/DdOD2YJWIRixg0lC4ucOeQAU5eJUaQzXtxnUN0
 Q4tHajazLOceXc9eoE8p79VNQwahcI+I9Z1kC/RA6H5Jp6ALPS2OEA2rwG3jyrmfjC7iGLL
 oA2qzKoMr+1N9Tkhe3skQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iU2A8p7jgvY=;MVN5lQLSFIWV52KTSRY752wHyL5
 Ql5nnhFfCpUga4Fbh2pl+MAAwAbbzeEeXWavMEh5OHDPVobwJN9yeItzAdSsvnX5I5KY6iGr3
 upKxa+5hMfG+L5SFIo01m6VWo2ejFyjLutuOEUtpoRKdFU308yTNfd1AYd9KxNsRuukYJZEQn
 iypbWDuE1PMHKMRme0KTIPh2KWZrtXMruUsCHGedpOVBTg+ZzJXVrN1WUosVrkce0GUlRtc86
 idM0itS+66+hZeZsgktiFpro8mEaMyqtSD0KLK66CsoDoCKNk27PkymXpfZbz6nghIPfuk8z8
 DZpuADTP9zUyIfa8fz3OGg8aEjiPevKpb6XeUHnqsqC07HKrcHctGGcDZxOs+gkjaqaajIkgA
 2KGCjCXTxwjO3VTRR6wfXgauuMPeZBEfEEuNqDa/2cmXR0GFjszfQ35a1AE2JxjuXJKmVASdb
 ABTHZrKV7iqi/s2a5HyncVi4jpxyo2riIhNK89lHpxSGyXCZluBzKnsH3t7Chwo+jICRBGq1c
 ymZD4ba888V2rDeF91QZEUg8e+9xJYiPjI3c1Q2u+svPwATAcrSOrcxW4u6b2lKbeLyr7qNT7
 J9KLX/+ntJUOsqtdH+Tfi//xx6gzcn8bpQhTgu65cmdPosA03K1N7Tlw1hc6C3F+fSA2NJlcM
 VPFb7YZIy+tX7hzoouYXsyUi8B0WB3NMKvDme3YQbIiO0nnqffeTkH6PvN5ckt/Ppsmaql0j5
 RGGlKnjW0k/F2QYJXMS9GYQ3RatccEPyYclc3laJxBXOBX3UEr2ukjsZpi4My5NcZaRa0Wa3N
 sIP+BK5cczq0yXJZ3YP9bySdUvdN7mUcXOOghteUbxOK4=



=E5=9C=A8 2024/2/14 17:42, David Sterba =E5=86=99=E9=81=93:
> On Wed, Feb 14, 2024 at 04:58:55PM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2023/2/20 04:40, Christoph Hellwig =E5=86=99=E9=81=93:
>>> Move the remaining code that deals with initializing the btree
>>> inode into btrfs_init_btree_inode instead of splitting it between
>>> that helpers and its only caller.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Just one small nitpick.
>
> The patch is almost one year old, it does not make much sense to send
> reviews, if there's something to be fixed please send a new patch.

My bad, I'm re-setting up my mail client, and this one popped up and I
thought it's new...

Sorry for the noise,
Qu

