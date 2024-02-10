Return-Path: <linux-btrfs+bounces-2296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428F850358
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45CF1F22607
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839528DC9;
	Sat, 10 Feb 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="teHzL7bu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111533CCF
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551190; cv=none; b=QzvIkrVBLKL59pGqwgsaswQVdeuncAeVfqvIDt3IiqiQuMleFao7FTivK9NGfOvtZYQ6wim6a0ILBcjWufbrX8YmxX5WtRbZUYedmNjA4urp4k1MB8zd8SbxcACXugztEAEyUr2EHN2Pk7cIL/CANVueHfzq6d7XkENYVj7aMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551190; c=relaxed/simple;
	bh=mhq13ikje/jCA59vHByG3r218+rh1F2E9LHQqhO17oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fK0jJrAkEEMQG9hajMFlqgJTGwTs/qL3HmPLHcfAQ9YIGURvSTTSIYjficDiw7xw4hksxcL9tWCaty4XDSz5haSqM1UT6ba3fXg5uSl02dQvkwv3TUD5ukw7zWTGM6AhGyAstXdFcFNenqS7IYikDxOetulrnLO5EI7M06t/cN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=teHzL7bu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551183; x=1708155983; i=quwenruo.btrfs@gmx.com;
	bh=mhq13ikje/jCA59vHByG3r218+rh1F2E9LHQqhO17oo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=teHzL7buyDaP+ZaNPr4Rs7lcCFfBUJXUAv2D3ZMlNz686pM2rPHwbtqlck/JFeIf
	 JeMq4QJnuwfpogb1E4PtlyGfn821ziCPzi/Ps+EV6cUl3YD3dISc4rkOmIsdNVAp7
	 TWmcwVeoVVbhpEpp/rxZ8dplNw+eXriKehhXI/6jqnRvjbU7rc7UoaqJQHNm45zcl
	 lv5k1Jq2G4SthRKyHvBWP0ssuIlsqfVlq6WD8fBhkKTqRAgMRXHV21s8WuG47V7h3
	 xnfdNZIxrzR0BSDaS/g0tkdhH6PMGTJ/0TKM+kVCCoz3vEmHrxjEidXiPkY3zHvmK
	 uQHQjYVcXYnUEmRFqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1rAbaw2FdA-00kLrR; Sat, 10
 Feb 2024 08:46:23 +0100
Message-ID: <90e0f0ea-070d-4881-85b9-2107dd68f2c9@gmx.com>
Date: Sat, 10 Feb 2024 18:16:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] btrfs: rename btrfs_add_delalloc_inodes() to singular
 form
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <2e26e61c8974a2c7e7ba1b2e14e771395bfa4a57.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <2e26e61c8974a2c7e7ba1b2e14e771395bfa4a57.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gBrUzYCqQFo5qIKjYOYuo32VO8VGnmrg1RA7B0c+H6XJS7GU6Cx
 WIieJum2cPLmG7YECDVKKLpxc8ZulRLqGMC/xtvZedDw2VNX7IRlFKh4iIVlzOFRAZpOQtu
 qEB4hWj797Zdz+ijVgXfySkTJaEgXJCmKIvObx9oaUBjlC+2RPQ0RVceQf3exWX++hw15U8
 76uuOQjgfH9gsnr3IoqlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YmS3cDGp0y8=;G4/xC7pVRiEcBTfAa/iel7XUWmZ
 UVU1MMGU2gt1naME1SXLoqszxQWWk6bNjglVuR9/l/wcl7N0GJXmLiowvp5CqN7xaAaygUYbC
 COSxU3LZd6e/K6G0qUDSkI1ehGxR8gaj6yF/9wWcWs87IDTXHd6UX0tCh/Ggq5jfWJiTO/9RH
 fPkxrJH3E1/ITamL9TfUWQYfClmljIo0nuymJW8C7PTn85UXQUhgyfE0ES+L/Ly2Jv5tPDu5U
 tYqJD3BHHPBZQgkuj81LRDWCut3dselMJuz90K6O4OoyPe6i1RJjhhyuOwUo2DGqVFJs7T0m4
 rKmL9kHXN96OsZLd1DYOyYB67C5R7KDWb4TyWEhKqh7p9uqYwErBexGBHs90lUyHvnTWdQOsV
 PPo/Zn2/jTMdhlICglbnhQA5BIaAApCvdL4QWhOyKkHQKfvNCXuHi9u1NS+e70Cbii+kidrGq
 xZvKK4WWkJ4Wbf0CtAZBfYBzpOuOOM0PNymkYbbRkb81QmHMz3MFf0gKti4xSYM1tdWLFfiRD
 iYMOTmxeN5khIBrq5HKWF0CdhdMt9w1B+wgnAR0a3zM2nxgB0BOaU/9YGPRhjvwu7GINYCYVo
 rYrNhIXG6usJiygrUFwb3t4yFEa/8z4XDRwQY49Yy0Ol74nPANSGmzWbp16TvyLAF6hr2iX4b
 5300glM19MhUMhS1/0lqCIutswl/KAb9Sw3kMXeiZlwWIqqU48tVDxCgnFAMUCtH/c8eQ10s6
 CKoi6vdgUSrLU/HoEYc04YRvdEE1nCHwgsWAHePi6Z+RpDqjm1xYoYZIBktRPo7a8JkvQBj+u
 VCV9QvfdyJAc8kPva4JxRDNMSMVtYW5unw4ybg2SaE7eU=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The function btrfs_add_delalloc_inodes() adds a single inode its root's
> list of delalloc inodes, so it doesn't make any sense at all for the
> function's name to be plural. Rename it to the singular form
> btrfs_add_delalloc_inode() to avoid any confusion.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3a19e30676e8..b273fdbd63cd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2385,7 +2385,7 @@ void btrfs_merge_delalloc_extent(struct btrfs_inod=
e *inode, struct extent_state
>   	spin_unlock(&inode->lock);
>   }
>
> -static void btrfs_add_delalloc_inodes(struct btrfs_inode *inode)
> +static void btrfs_add_delalloc_inode(struct btrfs_inode *inode)
>   {
>   	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -2472,7 +2472,7 @@ void btrfs_set_delalloc_extent(struct btrfs_inode =
*inode, struct extent_state *s
>   			inode->defrag_bytes +=3D len;
>   		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
>   					 &inode->runtime_flags))
> -			btrfs_add_delalloc_inodes(inode);
> +			btrfs_add_delalloc_inode(inode);
>   		spin_unlock(&inode->lock);
>   	}
>

