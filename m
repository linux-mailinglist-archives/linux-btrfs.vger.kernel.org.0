Return-Path: <linux-btrfs+bounces-4390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC18A906B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 03:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40EEBB21130
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 01:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F267464;
	Thu, 18 Apr 2024 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UyuMK0Wg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7302CA5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402658; cv=none; b=NFODmDMmrB8UgvLAbt2XNWrmtPYRYiRhjyeMeRDggFQhHUIaZjggqatC3KX1E5pidU5C8gAkNKzLVQAA4pUqd96BPlQsybh1Z9hiJPpTj+BAhtQhrGNEZ5dS+HrD6+9c3g96KWtguWS0CEceC1wCfr8gKC9r0UAq1jMKwipvqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402658; c=relaxed/simple;
	bh=f4U+WByHxnQ8Ds1fDPfkDzFoEA159AMiiMxThY8heyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YcotQHZpbFv2s7Ei4Q6H/fGJimljxRk3Y/0cOZQM4gUEkHAqjCrHK7y++HUNNx+gR35jur9iv38A9x/t0HjYUeLFvnGD9ZSQ0IZwJKh7b/08L8jEEedgK3hqqe/jvoLiwdA6aDEhY1uo8FoloYbCewNAgxKcT+URLCCdzWBSLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UyuMK0Wg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713402650; x=1714007450; i=quwenruo.btrfs@gmx.com;
	bh=aSI4/rrT38wu1qyObDtXRpXSN4ivCp/Zd9xmo0/mTLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UyuMK0Wgh8QAk4jj848tF4KrEdQvg11nqCccQ9OGVRsUoN/72Rrci1fc/FiC21Xc
	 cEX/H2A7aYV3tvAKUtkHJgA9vtn14aHE4WzOddUdbSB2S18C2r5TrBbrSeeO+T4qh
	 nKKRpqZrrEfrFO4V7i07QU/1daUiy0HWta7sbRzfKSlTilccpBJ3rnm7tv5KUPKB4
	 7ycOJT9JjIoamtsp34jIYKbBa83u+burXy7Hj1EE+KHiiWHyPk6KsUlaowBRcffiF
	 O8rdCVOgmBuRr+7F3aTAtwhjs5Khma30NBBfdrZTdImWB58eNSecqa+Dl1nzCWEg+
	 aZKCqsQ//eHWhOhlGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvL5-1s7KwO3uZZ-00RqHp; Thu, 18
 Apr 2024 03:10:50 +0200
Message-ID: <8a52e741-fc38-4b7e-9a2e-6c206295944b@gmx.com>
Date: Thu, 18 Apr 2024 10:40:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: initialize delayed inodes xarray without
 GFP_ATOMIC
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b1eaf444091755ac133e26f44fb2836bb5280132.1713367002.git.fdmanana@suse.com>
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
In-Reply-To: <b1eaf444091755ac133e26f44fb2836bb5280132.1713367002.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vT4wfNg6mVsFvQ8gVNI/mrQhi2QjE7uG7h39Akj/UTdvKFGwgHF
 c4rcVPOu/gefVKpR22AjThHAu+/aBsxCW7/DCyAeh7C53vuqyS8NV9oHYIe1MPYjqHQ0mIv
 KRh3adk8O75DQbbdXA6uJo59dOyXajWF1fA4bgj18WdEYBbf1dvvgHTQElxV33MS1uQAiaA
 KFj5rLAQZqnoYMwUsZ9Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SvwwdBco2dM=;AonD6zI5ogpd0FjyBkD3vmMfcJE
 JGLTsxwUQI9gPK1y7O+qvAi2hKuiF/84qb1LSzkqFWY6u7JMH7gfK4aITccIxpGTZn8OvAHu9
 YJRHk64xDV/3IuPralMlQykQQmAf2eUklQfXvUbdDz34DqXO4n2DGEdwomb/8vBybSXFmWKFY
 BIIjq0XzG0jArhT3DyrTRy7nzoYsdDlROewos3n/cYcr+dEY7OBPRUXEnEFHu1PSD4DsqahSs
 5x0UON27PqXE4gC/iLLL3YaO327vlNvVkkDd+LertTPzleiANL66kOuvkwGfSY+QHLrx/RvzI
 6RN5A4m+WFB26R+6TQwaJ948DZjWprYAVTQsD4RAheSx3xjGsP6SYJ5RHo0EJFvUcZmgqH+Ds
 s4d/WAYiUQ4EFlHklnSPtQU1WWZmmQIFGCyI3EX9YDPp17YgmUxuP1wbn34iyjYNTFb+OFnqn
 HmlJuZOEAETdzpo8RXA0TSTFKmleYA8SqRMh/kV5WLDpPiZU2F/vjObguircEnOpEEPMPP6As
 rtVLsEORdHHvbDghaAE3HezQ3DQuJUOlxlOzTiX/AHt2VG8nTcVB/h7wdtZ6AGyFwDVfugLdA
 BPQXzTem/8opCXUMTRUcG3Ev7c+JSFmRg90+2PLGOO24ILj28SU7pnrDOZmtcnJKEfAzX871n
 /v1HJSFJQ9e34qxrmtn7G+qJnO57RFLjOCHr3R9/C2FReGdniAeJ8sy+fJeDnD5O14p/bfgAe
 55RoiarE5zGijL9itMC6bSZ90eSOgTnbxjiS/OS9lhvo6JBP2PZSPjqd3vt7C9q9RUDb0oHr6
 3CCOq2XFZgQTLGuQxnq8vCue+jq82FbcT2wMT3uKZrIMo=



=E5=9C=A8 2024/4/18 00:48, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> There's no need to initialize the delayed inodes xarray with a GFP_ATOMI=
C
> flag because that actually does nothing on the xarray operations. That w=
as
> needed for radix trees (before their internals were updated to use xarra=
y)
> but for xarrays the allocation flags are passed as the last argument to
> xa_store() (which we are using correctly).
>
> So initialize the delayed inodes xarray with a simple xa_init().

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/disk-io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6eeac9618a69..5b6838156237 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -663,8 +663,7 @@ static void __setup_root(struct btrfs_root *root, st=
ruct btrfs_fs_info *fs_info,
>   	root->nr_delalloc_inodes =3D 0;
>   	root->nr_ordered_extents =3D 0;
>   	root->inode_tree =3D RB_ROOT;
> -	/* GFP flags are compatible with XA_FLAGS_*. */
> -	xa_init_flags(&root->delayed_nodes, GFP_ATOMIC);
> +	xa_init(&root->delayed_nodes);
>
>   	btrfs_init_root_block_rsv(root);
>

