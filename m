Return-Path: <linux-btrfs+bounces-4207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E98A3C31
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D39281E35
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D13BB32;
	Sat, 13 Apr 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IePpWDt9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519831A94
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003389; cv=none; b=oQX3gR8Ty3GS25BbDmhPc9q+Osoeah4bmrSxQmsmMPMI7AMTgAQQr9NpdPAksqoUMh2Fw2P0J8Wxh3Rmkpp3gFinkig1liGDnGn+hQMW4/DF8heiZvRaIuZbuGEFmCwsrVllvGW5P2vg1lJ2b+lvazmjL+1wwPubw4ffKN4kac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003389; c=relaxed/simple;
	bh=oqjxqbil9/kR1afAP5nzZHyAqL+/iDIOgXjDyB4CEcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h+LL3ugY/bzAi8TF+HyB5gBjW/9HSNi9iQj4Vevo563k1mpBLnXDFO5V3iVCeqE8sA+hYhqvFtjlb1Twa7ivPglYz2X92TyM9lF7Tn+SxsXg5bEk87FfgcbSMNLcXHJZsLZ/LWrrcwdvfZ/Liou2QH72kaJZ/Hp1wBuZ10NZbjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IePpWDt9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713003380; x=1713608180; i=quwenruo.btrfs@gmx.com;
	bh=0PRlfC6Wg+rpjAJ+mY5tb70h4R3LiWYsAbee4GEoRSA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=IePpWDt900+pws5cLffep9/nE7ImRNHN2KtQB9pAxUUWeC39NyA1I/dEfsIpTjD5
	 Z1Kv+MAIvJHIxX09n5Tbz3STdLlL6jnxbhPu2zUu55Bp3Ca080ezOOY89qfwoYGDg
	 3tp6rRavJlvKHM+hW8zhM++z5PTrOyK1GSCyZC/5Rit6NbYw8YLYtf0x1nJ3q+utV
	 UX0QcWnUAunVf1Zk5VaizPJ0JDuvZo9+aYcl2IRj7icpeo3mSr5SbjZQmRGXbhc87
	 D0tj8ij7ez10MXC17RoP7n7HZPSqSzWeq0Bd7faBnEqyXV2iDZJ9ghDBBI/ixxu4z
	 3wmLQwpvudsHwRH6sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2aN-1sea9M3mGV-00kBpy; Sat, 13
 Apr 2024 12:16:20 +0200
Message-ID: <5aef7d50-6183-457f-b0e7-ca4e4f0c6439@gmx.com>
Date: Sat, 13 Apr 2024 19:46:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] btrfs: open code csum_exist_in_range()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712933003.git.fdmanana@suse.com>
 <43c7b46211cc26f0f47ccd8bca522d70e4e563b8.1712933006.git.fdmanana@suse.com>
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
In-Reply-To: <43c7b46211cc26f0f47ccd8bca522d70e4e563b8.1712933006.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j7iPpPoXhCEW+5qGOZhbHRr+0UhWKKQYkIS1+SCBAtozhidQ7Qc
 WOkp1sC86opigfiqi7RoDEnWaDN9ilPt4NX7su1r1+jRDnT2l/vDuDpwTeahQCgGv9Xsw0I
 RIDUYIAosxhp8PDvfj10ISCaOG7vHmo4WTfK+ijhYTIQd9+OZTkau5M04MPbDhH1BasH9Pr
 mUeEZ38FKLqvOAW5awRUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:je3m+z87Jr4=;WAkEp6L8IY3u9h0/FsXwTzKIERt
 /YAxABKg2ZvR8an6PRwOmMAtIf4YoXx6I6KyR5KW4rarvSRBDhUP+kyqPpfrWFw9NPB/8ealg
 GqEzk+aO79JTpDxjJW3pESooPycAZrJPkBLZZgxTPdeUEfHf65zmEsrehDGhsyvPT4irOq924
 703Wr/eUC+nwDi1BBPWmvBhOzJP/C/senlrPlkBUEtGe4667sVM0/qFei2sHFqoJGUN4Ktk2f
 zVmpdI8SBotZW12R3AxYXFZaKLjTvisKun56PIgTLY6jVMY5BSBlAtYqioz+t+SleRDqMfpJG
 AveUgvIQosNhoFcDulQVBh/wWFYl759Da+25M92xjoRtABJvS0dt5TVCjG6iJAj2/nmKUY42V
 2XLxFDe9VaSxZUWhKg/m1gniy9JO/RKtmiHXIuPF9l8xOQkuJFAOunV1nMpCT/WjgE8DFy6xo
 j9QxJAWjlTDcDas4odmOHGQ8rk5RhYpvCD3wal77DlGm0kk/vjFB6xnXJYkD+AUQq5EgSIAXn
 ZUOOSWorZQ3OUfqxsvRpB5TiRIipOAOtcE4NM33b6SxCpZVqZ2zCNPBPvSPY24yZ07f75+6cp
 F75mOAapSbmFsP2jcmPGLLY8zxDtc6dYI5J/qIFVuo3r3LDTA+/v+D7PSm/Mz8b5Y/X9c+WZr
 swpiTSRWtUgJ/SMnt8FKrm2HCLOczrnybafyQleOnGYvogJFEhlRMJLzVNl98v5DLbyzgllak
 BsAyhi/O/mFUh4xUL/Rilg3hrimkgI3BbkRwhBSGAwuY6Pl1r4VaKWUwDtFmCHB4uyBrbWp/L
 /GB4e79gy3epmOxN2vE+OKULTnmkDun6PsjgGZnYaAi50=



=E5=9C=A8 2024/4/13 00:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The csum_exist_in_range() function is now too trivial and is only used i=
n
> one place, so open code it in its single caller.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1d78e07d082b..f23511428e74 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1737,15 +1737,6 @@ static noinline int run_delalloc_cow(struct btrfs=
_inode *inode,
>   	return 1;
>   }
>
> -static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
> -					u64 bytenr, u64 num_bytes, bool nowait)
> -{
> -	struct btrfs_root *csum_root =3D btrfs_csum_root(fs_info, bytenr);
> -
> -	return btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes -=
 1,
> -				       NULL, nowait);
> -}
> -
>   static int fallback_to_cow(struct btrfs_inode *inode, struct page *loc=
ked_page,
>   			   const u64 start, const u64 end)
>   {
> @@ -1860,6 +1851,7 @@ static int can_nocow_file_extent(struct btrfs_path=
 *path,
>   	struct extent_buffer *leaf =3D path->nodes[0];
>   	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_file_extent_item *fi;
> +	struct btrfs_root *csum_root;
>   	u64 extent_end;
>   	u8 extent_type;
>   	int can_nocow =3D 0;
> @@ -1920,7 +1912,7 @@ static int can_nocow_file_extent(struct btrfs_path=
 *path,
>   	if (args->free_path) {
>   		/*
>   		 * We don't need the path anymore, plus through the
> -		 * csum_exist_in_range() call below we will end up allocating
> +		 * btrfs_lookup_csums_list() call below we will end up allocating
>   		 * another path. So free the path to avoid unnecessary extra
>   		 * memory usage.
>   		 */
> @@ -1941,8 +1933,11 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>   	 * Force COW if csums exist in the range. This ensures that csums for=
 a
>   	 * given extent are either valid or do not exist.
>   	 */
> -	ret =3D csum_exist_in_range(root->fs_info, args->disk_bytenr, args->nu=
m_bytes,
> -				  nowait);
> +
> +	csum_root =3D btrfs_csum_root(root->fs_info, args->disk_bytenr);
> +	ret =3D btrfs_lookup_csums_list(csum_root, args->disk_bytenr,
> +				      args->disk_bytenr + args->num_bytes - 1,
> +				      NULL, nowait);
>   	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>   	if (ret !=3D 0)
>   		goto out;

