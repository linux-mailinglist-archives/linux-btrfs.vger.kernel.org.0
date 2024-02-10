Return-Path: <linux-btrfs+bounces-2293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92721850355
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2232857AD
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46929406;
	Sat, 10 Feb 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Uv/wpCUS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13BE27471
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551147; cv=none; b=Bo/QfLKfyQz59dLG1DbIPDReuRyuGlsSnJwBN54xIn5+RJ3qiBW3PwsKIyXp1g830QM7V15fjr/ZnYJsL2K7SXKXKtgOdgnGJqS46/rfmHrsvIE2I9TzEuiJEBgHAQwe8k3Ph0OmuBtoxYey/O2K/iFdHm57PBZxuJhO/pU1id0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551147; c=relaxed/simple;
	bh=fm4tJGBYwTLCYJF3bOEnzSimzQxipRu7fB+l9L/cHVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W1c5Fn8rb1PTiSfrtfzQFhrLN9apfBdw4ZLtI2S0aj1Sq6RIRq4FZ9/NzO/LqtVCMgC00ESFfV/2oM+q088464cuFQX4Cgk/VgpXoh+kn0hLgA8Lc7L/51LKdjGFKRXoWXyDXbMco/gPbXrPLdNUIvYnzrWvgawa4UXl1+ghq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Uv/wpCUS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551138; x=1708155938; i=quwenruo.btrfs@gmx.com;
	bh=fm4tJGBYwTLCYJF3bOEnzSimzQxipRu7fB+l9L/cHVk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Uv/wpCUSPE0SS6h4V8INJRX80L4s1ZWhuvrARPosePP/OI5fwfa8xUw4fYi6u9Os
	 nYe3IwZ9F7yzHwFy14J9SLNGEzDfYAkew0xY3vfphIDc3Vo/MnR/8KyRxaG+oTWmP
	 wPxwEyKE3ZBp1v4XCEkrTDwynt/rD+UJCzKw6DKJf8hyRhq3slaFAD0wYIe0EhWWc
	 mWt3ocofv44+fuQUDnMlyQnPWv+FUmZwx/Mg9EB/N6FP4vnM7jo3LCcZ6prkpo44s
	 Bbhr40myx/wicfCZWuQeGhvGo5XwEeI/PyDCf4Eqwm67kUyHhbqe0lvFh7wh8MVqG
	 DTp/ni3JCJ+lCifqkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1qwfUY3kt9-017EIQ; Sat, 10
 Feb 2024 08:45:38 +0100
Message-ID: <82543c8f-b4d1-44cc-b733-23d1156380b2@gmx.com>
Date: Sat, 10 Feb 2024 18:15:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] btrfs: stop passing root argument to
 btrfs_add_delalloc_inodes()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <5cfceac9f43f2e296437b01f940dd668208c4b98.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <5cfceac9f43f2e296437b01f940dd668208c4b98.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lYJTvQDPynirQaHjAv0CO/vnFu4Gk2JynBQ9poh7bSahElfyaDB
 yz71KAizj3mNCH/sWOFZrs2zcZcEqSUeR9rqcm7juOPDOio3ANY2AojuXKPJizRyYjPgGLO
 cfwL8vR2Atf9+0cBN3tVJcQ9k0odacQQ71D/O9XUE7xIp7RJ8q2NPSKEjIrqVTSDUBXxyG+
 eEfsTYW9br1o5pyXKuAgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bL5X7vQ/GEA=;FrSyhVW7wzC5GwWS9Bv4E3Kyml7
 EMk7OIx2u5ZjcAwza8mPhgTyEZrarR5agI2uVmKAEAA/cgIy5AlBf/N47K6r4Ti+Ecz2ptVCH
 fNjpo+0dokSPin1lNfKoW427lRf1XNfAENHiNu8DZzT+U+PKgCGEWb7/BM6RIceWCB3p6kmt9
 FWLFiB/HgqLVbKp3lQFD6DrfP9CmLM3MOBwNrSLBrA26DgGD2BN7lUnPHUPIXOBfmHcooiJhf
 WIJJ2ZVhD8bFZohzfhQ8gF/JQx4i+vf2ISDh8g8MsjEufOyiXdPBkHnS5eReMbF9I56et3XIa
 IEYClbD36XdmN3q3EfsW1o+4A7YrF2J2eNIgWaBP4PrDEEoNF11xSiFlcuSBcc9zucosYywFr
 9YvnWS8PslfSSq8KcURfhsGCX7EPywD+X4R4W3nJESx8jOd9YXB20tbAoB7gK5se+kyuEtlWD
 keBOZrYb4mCG6TKuP0tv9d5BHa62COkxaEHTYn0/oL0N/5xIHkFJoxFiQwZVbqc9Xr9cD6n95
 tWoFJb18qwdNF+5ZP0Wirp89MRmb3l+YGtXTZjFNEONateQstdcGMyvIkAr1LB+y6grdQNrFD
 EQCd2r3K4K4lSlgyC+ETUitPTS6c9Y4G4Uwd/GQ+iOJrStdwAAQspN6Xhas01JngggA4hSi+w
 Vy31Pt2lWCuZeYxLjYtSj2a1UGDWClmDJpaAWeewB/dLqJlsGbZQJNxKIeFHucrXpc4RRWz4x
 OTre78pZfUYcRu/uVrv9NDOuo8nyukr3+FkTEHOVRbtu/roQ6vS0I3DTMYRinggGLb9Xy3V+n
 WMS/jebpd82YlEFKoLX37lNovVUDKCV81dG7BrgPoPahA=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> There's no need to pass a root argument to btrfs_add_delalloc_inodes(), =
we
> can just pass the inode since the root is always the root associated to
> the inode in the context it's called. So remove it and have the single
> caller pass only the inode.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2d16bb08e905..e3d12d8cf088 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2385,10 +2385,10 @@ void btrfs_merge_delalloc_extent(struct btrfs_in=
ode *inode, struct extent_state
>   	spin_unlock(&inode->lock);
>   }
>
> -static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
> -				      struct btrfs_inode *inode)
> +static void btrfs_add_delalloc_inodes(struct btrfs_inode *inode)
>   {
> -	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +	struct btrfs_root *root =3D inode->root;
> +	struct btrfs_fs_info *fs_info =3D root->fs_info;
>
>   	spin_lock(&root->delalloc_lock);
>   	if (list_empty(&inode->delalloc_inodes)) {
> @@ -2451,7 +2451,6 @@ void btrfs_set_delalloc_extent(struct btrfs_inode =
*inode, struct extent_state *s
>   	 * bit, which is only set or cleared with irqs on
>   	 */
>   	if (!(state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
> -		struct btrfs_root *root =3D inode->root;
>   		u64 len =3D state->end + 1 - state->start;
>   		u32 num_extents =3D count_max_extents(fs_info, len);
>   		bool do_list =3D !btrfs_is_free_space_inode(inode);
> @@ -2472,7 +2471,7 @@ void btrfs_set_delalloc_extent(struct btrfs_inode =
*inode, struct extent_state *s
>   			inode->defrag_bytes +=3D len;
>   		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
>   					 &inode->runtime_flags))
> -			btrfs_add_delalloc_inodes(root, inode);
> +			btrfs_add_delalloc_inodes(inode);
>   		spin_unlock(&inode->lock);
>   	}
>

