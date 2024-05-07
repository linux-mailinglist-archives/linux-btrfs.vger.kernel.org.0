Return-Path: <linux-btrfs+bounces-4787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D78BD8E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 03:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D47BB213CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 01:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136C3FE4;
	Tue,  7 May 2024 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jw+1u6HU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FE1862
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045147; cv=none; b=fV2Dkfl3Ax3mXdsaGTB1MHlZnuj++pEekEwAYSQ9B2b+lUllKBmheu25db6zD4qOknKeGIv1SMXOdlFpxbORR5lLuyzC9/7Mj7/7Npw3NqksIBJt3k4sh/ziF0htSq9ggwNxeNvwV51P+d+Z55ZNvbNp9hnh3AXRCc8By9W2MJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045147; c=relaxed/simple;
	bh=mBUqzSWpbhNZ/p3ForvlxlAwjZH65zv4J8/Pd+RgE/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrJp1NMt4+HdU/RlcgrC1QXeeHzDVlH9eUqRaMk5Agcj2+foF0atqrWjQ/nTmPSnRKzwwIrxdX3EDk0bDHLRqKYnrC0qskn/ZpdhcHuhtXG31MA1BfS4CON8nLDCmRPT/7BGH4p3CG3RDX3515N2MfuW3Agy0yC+X/wwko0mqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jw+1u6HU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715045137; x=1715649937; i=quwenruo.btrfs@gmx.com;
	bh=3tXBm0hGpYMsc9R+XO+sZDIUpkd2qpy+iCqounAjVQ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jw+1u6HUmJy4q0yqTC4vz8TD593eF7/yu/3afQjarzG/A2bW0Fea0g4tf/J75CmI
	 Zux+rgXbJr5j6X/5+rg1jZREVTX9oOW0f3fiQIXWrlwhBUkczonf6C99S26psDVs+
	 0lgs0vJmpQsd3BrX9spAjkXuee33+Gki9b/8gwuzdNR9AJ8G4HF4mmIky5jnnzNJW
	 cHhIZo5Agrfb1p9fOK3iDW896vEhsrhJq8IGVxk6mZoYSNKTyQEdqDP1P5rHebVZn
	 sQvXTc8mXuhsC7gseHyKwlLX73Yh7e0Zc2WUB59ekj9LdqcG9Dx7M7bdtyypK4Vo2
	 wj6M/VO11phjxcIgFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKBm-1rvw7m1wHa-00A4qr; Tue, 07
 May 2024 03:25:37 +0200
Message-ID: <5da145c8-802d-4fd2-a52d-9a4c6fe37ea5@gmx.com>
Date: Tue, 7 May 2024 10:55:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, y16267966@gmail.com
References: <cover.1714963428.git.anand.jain@oracle.com>
 <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
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
In-Reply-To: <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZTRxNarus8XzHm+X6tW1ip1UDSVddnitN6Tj+AXPFBtm41/vYAb
 DUjxU9DPv8VYpgGOGezRAhBV/Y0BTqylnZ2hA/jZ2MBAkID4nglc2yii2dBdHeR88QO6oGc
 HtzH6rQxNpDdbbicqVELCqCValVl6Vmqyvlb/2BTvzLGAoIqcy9DAFF3U9lew8pJ/kvY5i0
 Dj5wkGZc7cq9KNpZwKRQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eDj/C/m0utc=;NYb8mTFuA6BY0xZaAFs9P12b1jK
 W2Igd9r+wwt2t8gBxanFkbkoZ0+Hr4G1cQv63vNX9XJojy/divDqQV+IeARdIDGFexpVtYnh0
 CjMagvFGrAz0Nu3eB2gxKeRJviK5zGmrp+rxtiNGgRLPvoeG3W+xmodcUEapJZSCx1rcbEHrb
 CUC965YepcOBn3m0kjLpHgMZargIlzOYynqBkEWme4Etyoo+hAFjzzxeQD/LtFyiMij4Yf0Cw
 ilGoUeLLCupP7GdHITMzWZobcvzWhItZsdnM0sIJmxs3/mPn3MlXI0T8UfvtCb8oOTgvqx08f
 kaVHZ2giJIbJeCbTKEaJOSE1SYuyDppMZSFfbB3uy9UyZIzXw5U7c+E+rCHEJOwYJRsgIy6AV
 I0UGt6T22vRjooboAnkNTGBLBovDYxQeolAdWQ7nEklmFuPIIauh2zfKHV0KpN/Mk2Yy4l2yl
 Tz8/yRLXie+haEilG4ICh7DcyDpPyDWmnxAYa712vIJi3vHcHd2gLiqZKC4dB+Ca/orArCH0I
 Svy19CY6QUxW2T3Lo1s+00wWixBsx0p1ChCGEtzrl/iJyGgXCd9NdlMVGxawZnuQxRKTEq+EA
 BXyyi9ldM4vmGwTK7XtKNoPjvCLStD/lzFm+8V2g4Zh90E6RzdbnCQKwdjzf1rcyHMg60x4EE
 SBcZ2pHGRiBi7yl4QkBPAofZeCI7Q6d52LnR5q2tnkKfl+qzctIPU95OpTVfVVmWl8r0HRxCH
 dnqflwh+/BKW6Whz5sA4SQg6gO4HCbs3C3EpcJ5UIz7YLVEsvDnOOXEN1f+40iv0p2cOJek2/
 Iwglv976mzuPgKW+24aD0mzCHVPorjs+y2Np5m1iQ7iUE=



=E5=9C=A8 2024/5/6 12:34, Anand Jain =E5=86=99=E9=81=93:
[...]
>       18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  =
/mnt/test/foo
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>
> . Remove RFC

Nope, you didn't even test the patch using the selftests.
(Despite the RST introduced failure, the first ext2 is enough to expose
your bug).

Not to mention the lack of functionality to handle part written part
unwritten extents.

This is NOT acceptable at all.

> +	if (ext2fs_extent_open2(src->ext2_fs, src->ext2_ino,
> +				src->ext2_inode, &handle)) {
> +		error("ext2fs_extent_open2 failed, inode %d", src->ext2_ino);
> +		return -EINVAL;
> +	}

Have you tried ext2?

ext2fs_extent_open()/open2() all needs the inode to have EXT4_EXTENTS_FL
flag, or it would immediately return error.

> +
> +	if (ext2fs_extent_goto2(handle, 0, index)) {
> +		error("ext2fs_extent_goto2 failed, inode %d num_blocks %llu",
> +		       src->ext2_ino, data->num_blocks);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	memset(&extent, 0, sizeof(struct ext2fs_extent));
> +	if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
> +		error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
> +		       src->ext2_ino);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	if (extent.e_pblk !=3D data->disk_block) {
> +	error("inode %d index %d found wrong extent e_pblk %llu wanted disk_bl=
ock %llu",
> +		       src->ext2_ino, index, extent.e_pblk, data->disk_block);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}
> +
> +	if (extent.e_len !=3D data->num_blocks) {
> +	error("inode %d index %d: identified unsupported merged block length %=
u wanted %llu",
> +			src->ext2_ino, index, extent.e_len, data->num_blocks);
> +		ext2fs_extent_free(handle);
> +		return -EINVAL;
> +	}

You didn't handle the halfwritten extent correctly.

And it looks like you didn't even understand how to properly iterate
through all the extents.

In fact, if you really spent your time to check how debugfs
"dump_extents" command works, it would be clear that we can easily
iterate the split extents.

I strongly doubt if you're handling the case correctly or with any
responsibly.

I already have a small patch to properly handle all the legacy and newer
EXTENTS_FL features, and handle the uninit extents correctly.
I'll do cleanup the RST test case first, run the full convert tests at
least, with proper test case for it.

I appreciate your effort so far, but this is really below our standard.

Thanks,
Qu

