Return-Path: <linux-btrfs+bounces-6256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA2928F94
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 01:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF66284F4D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30076148FE0;
	Fri,  5 Jul 2024 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y7vTi1Il"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F63A8CB;
	Fri,  5 Jul 2024 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720222349; cv=none; b=TVoS+FKlqnQ+MqqDO3TPWoexIGBR1iSzUeejMpHtd8zA2wQPzHYbKLJSII81AG65QYT6EO3JjfEZMjQrqR/IH8dh8Cu09lP6DczxY2gALHWas10OyBNcPdxifZOyhK0dzgzwqPtbb0PhG/zRexo+8SBLLp0bIvb84sn1KIDKGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720222349; c=relaxed/simple;
	bh=RlWuyUwXnpbKt5Aix7BPTFrQl+92BuIbeVNT14DQx6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNHKGTldVXBz0bGhYxfYtmduuUPfHF5RBfA1pgxEyPzaiIK77nnGdN7JGgEm5+iwkD3gSBnetknyOotiD5ZCKzj3+UNWH06YuprhCzrKsz4qz/1xG5Hgbc+Y9lzkcJrm9MpkRWPQUFArrg7o5VKszD4OuL8dZxsMvtMMk9+FG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y7vTi1Il; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720222333; x=1720827133; i=quwenruo.btrfs@gmx.com;
	bh=QEYn+d5m+RtO8e+9GjlC30TiJIYtcZ6lh+yFt5EGAJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y7vTi1Ilj1FcHUGQxu9HCCG0Fm1Kx956X3Kr/iPgRUfoWnQApXCNAxXztwX7qf/u
	 sXUpD/yplQszUh73LMjLx3qS6mMVG4gyjlv1z8g9LUEME8blOZRnzRpLL9zUBDzw0
	 QyXqENYpCf5eXT4k3r25oFjJq4nPMjZJBssoJcENX9JEX0j7NVRrKlWZlohZGH1Mf
	 hFcO35nl79TaBzdrHQGGcGl77xl76CbiafRrhKooUHvgSmeSEF8O9wgvw5riRv2SO
	 Y1e7XWwyUjnNYX4gqQMN44teB8QBnsmaBGfacmAQ7F8jEq5oaRQul5BCCg+NzLz1B
	 LuZMP00si9Jnv2HOaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2Jt-1rvEcP3S0v-00m9gc; Sat, 06
 Jul 2024 01:32:13 +0200
Message-ID: <f184b3ac-7bf7-45cb-b126-3da7c52980ad@gmx.com>
Date: Sat, 6 Jul 2024 09:02:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] btrfs: rename brtfs_io_stripe::is_scrub to
 commit_root
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-6-f3eed3f2cfad@kernel.org>
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
In-Reply-To: <20240705-b4-rst-updates-v4-6-f3eed3f2cfad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m/CFMkxkVQiOvk0TSPfgQYHWouBScs9dwAf4EADZAeemCskuRfU
 AslYXqxByQpvs3//s2UM3cIH22iAr1J3VlHWpI+XQh3TZFwQBHG7uX0miwQGIyfSYKkdhlV
 x0ywOfhcNsbOrP3avuatB/dZg7u4nWD2AFtP8jOfJ6rwx/FZsFtuTXxgJtfBBCpvtZI0uKX
 Qnhfla4NktwnGZKBj5j7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xtuuOTN5DDI=;j+eyS1u0xp2vs8h4bot1KTa/31a
 VCWmFJVVzQLFG/bdUJMgxqU94ugLTbK3R6+C/UULXIzuEUJk76I5mPc16u0d6UuzctrJwpHQY
 ENat3nbQxLRLTtWue53mLisFC7Sm6b5iPAzwTvoMhhD24OO6GLefmgQDqPf7a9E6BJd/a9hEQ
 RL9mhKnhRQfAIRwtzX6zvZoPNFpRZR4GHEhncL/ltaUrsramXp7jUHkRBPaD64eGhqX+qQch5
 +7EtH1kOexmnvzGztaCZ7qZKAWEPLqBIWhqvpO0/wSsVQ1I0eKEm2Hp9c1yNEROnj03HB5hrZ
 FVOVSdKw0Bmp9VVVJP6ZklubTmIELn83LubsiL17jtLKRW4dztlC1JOpz+4px3zV2R0I1l/is
 AtTXVhsP1xkQDvgQGJuyWh/KcL5OrvxTJ4fXBwZ2n1DbX3UDPfHIuMMmWmltGq2HlfQ7a9loU
 HljdllPr4REM9WIgmzFqEyYDeEUP/RNWJIvPXmRLOnIfXFE6eiGQfL+YhsG3zwS0eD6SfkbCD
 rEBQO3MGZAcFqLDrNGhH2zW+XjED4wqqCEbozWgCaINWiAREhVsfe+l9H8KNbAswzbrhPQrVk
 EhqkLpFE9E92gGB7H/msQtXDrV/nVrzAmOsBosfnD9mSazCTQ2IAXUZm9B/8bcPmyB9L1EgsO
 i+XPT8c1mwGqxNAEG7/wwslzx8FkVa91k04pJC+I7k+vLNzV6IzmwcqK9/h37crAapStNK8E5
 TueGZCYAFkeAKFciwaTF9Ahl2R14Ta3uBofrW6TgyRqgLg7UE8FXTxly9lBjMx4kSezhhZUkg
 fvTfwfK2LzYowRU9nL/jUJRryhDb3JuzuHBuGoTzWdJTg=



=E5=9C=A8 2024/7/6 00:43, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Rename brtfs_io_stripe's is_scrub to commit_root, as this is what it
> actually does, instruct btrfs_get_raid_extent_offset() to look at the
> commit root.

The commit_root name looks a little confusing to me.

Yes, it is to indicate whether we should search commit root, but since
only scrub (and dev-replace) is doing such behavior, it doesn't looks
that odd.

Furthermore, commit_root is way more common in btrfs_root::commit_root,
the same name can lead to different meaning
(btrfs_io_stripe::commit_root means whether to search commit root, while
btrfs_root::commit_root means commit root node).

I'd prefer something like "search_commit_root" if we're really going to
do a rename.

Thanks,
Qu
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/bio.c              | 2 +-
>   fs/btrfs/raid-stripe-tree.c | 2 +-
>   fs/btrfs/scrub.c            | 2 +-
>   fs/btrfs/volumes.h          | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index f04d93109960..5f36c75a2457 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -679,7 +679,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbi=
o, int mirror_num)
>   	blk_status_t ret;
>   	int error;
>
> -	smap.is_scrub =3D !bbio->inode;
> +	smap.commit_root =3D !bbio->inode;
>
>   	btrfs_bio_counter_inc_blocked(fs_info);
>   	error =3D btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_lengt=
h,
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index ba0733c6be76..39085ff971c9 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -259,7 +259,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_inf=
o *fs_info,
>   	if (!path)
>   		return -ENOMEM;
>
> -	if (stripe->is_scrub) {
> +	if (stripe->commit_root) {
>   		path->skip_locking =3D 1;
>   		path->search_commit_root =3D 1;
>   	}
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 14a8d7100018..9c483b799cf1 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1688,7 +1688,7 @@ static void scrub_submit_extent_sector_read(struct=
 scrub_ctx *sctx,
>   					    (i << fs_info->sectorsize_bits);
>   			int err;
>
> -			io_stripe.is_scrub =3D true;
> +			io_stripe.commit_root =3D true;
>   			stripe_len =3D (nr_sectors - i) << fs_info->sectorsize_bits;
>   			/*
>   			 * For RST cases, we need to manually split the bbio to
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 37a09ebb34dd..25bc68af0df8 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -444,7 +444,7 @@ struct btrfs_io_stripe {
>   	/* Block mapping. */
>   	u64 physical;
>   	u64 length;
> -	bool is_scrub;
> +	bool commit_root;
>   	/* For the endio handler. */
>   	struct btrfs_io_context *bioc;
>   };
>

