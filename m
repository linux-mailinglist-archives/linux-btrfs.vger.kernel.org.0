Return-Path: <linux-btrfs+bounces-8593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9D599393A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F11F22B74
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 21:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BD218C03A;
	Mon,  7 Oct 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZMpw7SSL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3CA28EA
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336889; cv=none; b=qvW8HE4GYlB5/eYrtx3EgR/F0zEjSPwG7k03fYtRchcjmZM1jLEIUKtYOybdpgXcK+H9sKMSUWLUWDiloIROYSi8Yv9ge/bviRTesRd1kRuWMM31ml2z7I+WG/npIG4ogrvxrk54rcnAwWEGqx5DmMTB9j1Tc4NTjl75STCgOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336889; c=relaxed/simple;
	bh=nL+znP6d95zXM+Wi+OooSiXEbAZzFb6ABW+HV6NLfuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NSZV3smvCh/uE7iNYub0qmMor+I2NpsW7Sn3GmZ9hgcmlEsPDYkpyDEWfMeaHGsFCYqIvwIBan03GNrE2Gqh2O1cAXGlk8TPg+DQf6iNu3ap8yQbPwtvMj6Xw5aiNnBZiTBoJK0WzWVme/C8QE0Q+pdMhznSfDOKGTf5TfxGBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZMpw7SSL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728336880; x=1728941680; i=quwenruo.btrfs@gmx.com;
	bh=D2b9Sh3U7bMaWgMjb4YAunnrwKV+3hsyvRVLu6Gl/7I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZMpw7SSL4ZYjxKyNiltsX9JWkCwh5JQa29WZQI4EiOMqn5MllrMdxjoI9g9Y9Ely
	 lxjMLvUT2Jh1g7s/uRV9Vaq2C8dQa2mCouWMnbZRwXKodBcbbIluxp3UwJiDzh1cV
	 OJcOemYVEDtlcv8fZGcI2MC6OSXO0q9kLvWanhzA5vo7AtRwVshMj5CrlKA8RFc42
	 y4YDUIoTDEOkTJxjBZDP0qU+3bMK4S93/HTmCGorCirvj/p/PMb+Sp6l+wbWYBMHR
	 v/LOeoaKfWacPfLTPs4ApViM9LlFKybqT5p+Gp9XtHLS3H/B5YBJdJCe4BB9YZQ5s
	 wjAkDWW3OXtZLLCyDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1tDLhn3G8W-00D30l; Mon, 07
 Oct 2024 23:34:40 +0200
Message-ID: <11322719-f598-4556-9224-d5ee22fded00@gmx.com>
Date: Tue, 8 Oct 2024 08:04:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: run delayed iputs after ordered extent
 completion
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <2efe2794ecbfbfab1545a9341d3a1fb7464dc048.1728315195.git.fdmanana@suse.com>
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
In-Reply-To: <2efe2794ecbfbfab1545a9341d3a1fb7464dc048.1728315195.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mZT6VosncopqRybJ4yyKHiCX8MUOt6O/cPinCJiCsjsYJP/n6Af
 zHX1st1pdCfEFw30vt2Ubz3lOABiw73iNUC+cQ4KkYYymAasve9aZonRIKnivswl+V89bJ+
 DgqCuxwHzfo2JN6BzEgwLYkNgiV9UYZ8eOGWhOMHSDGu+zHvgjmOj2zPs1yJ15bur4JJPPG
 zuPetzC+YXsIbKyVLCvsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MCbT/fbI/LE=;ZpjFfD+/KdqIiSDNVN5TZIkp9ps
 24Sxg1+r0tL2ABSc4BHLQ+klBvuvKD3xxkoVTcrbQBpMRW2FQzPN71zTLE8KEzJZRO27zcYeK
 Ruvkv+NxkC28ylNhYb40AJbm1YZaYEsfXF+KaYvcR7b0AZ3QMK1udD/EFleCtUHV4s1vzKK9H
 H8MG9jtVa/xUeigT6tGvFgyxuqHCfBPRhFDTlNppeq5Ig/pth5NJ5rN1/p2gy2PTMVkCnrAuH
 KyRmN9tJym2fU52JQzTYWKSyYxh2+wr7IxUYDhaMU4u7dwqKV4Qzt3Im5D1n8B/mRo1vrDV7M
 sHSdpkDrTKFSySXCenRMQVaoifmex0TEzxHgByceoAJVhjkEreP5b/79vNemVD4r7E024cldu
 qHmQ2smuez3l1DjyE9yiPLXrl8bUNQSdbR8zAGJeQPU1FoAjrmJS/ks/vWfDTh0x/4BPYrFwx
 u0q5ajSEdINOKC3MCckcntF0rqxGsWykIXig9/cetX9GywNhTdL0i7RNr4A59nFRAi6uThGdY
 rhT9WhE5ieNEJCtmdiGeJfVvXIbsi0fAMHrlEUPrldjRlrebLh/PjNiLc+8ff78KT/pf8+6PK
 j39FpKelPlzSyr8nTwIOW/dLjl3Q5Rs9rDRvPj4lbnoE6bACXNduDoK/I7DZxeuzUIH4o6Ypd
 SLr0chpIstLa1Z07rNAvmMMVWoQeUoZL4lEFHrgGvKMymjim6zuG2KW8dOsgiy/Rgccd6hA2/
 HCVAkEykZcDvVkCTlKplP7RI6AnCVjFSWVYjEy7ISVPN0c3Wmg3rW3OFUuvFm+z09SmBHJG7W
 QvTMMJ8vXqxtPAzd7+CkxK5Q==



=E5=9C=A8 2024/10/8 02:04, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When trying to flush qgroups in order to release space we run delayed
> iputs in order to release space from recently deleted files (their link
> counted reached zero), and then we start delalloc and wait for any
> existing ordered extents to complete.
>
> However there's a time window here where we end up not doing the final
> iput on a deleted file which could release necessary space:
>
> 1) An unlink operation starts;
>
> 2) During the unlink, or right before it completes, delalloc is flushed
>     and an ordered extent is created;
>
> 3) When the ordered extent is created, the inode's ref count is
>     incremented (with igrab() at alloc_ordered_extent());
>
> 4) When the unlink finishes it doesn't drop the last reference on the
>     inode and so it doesn't trigger inode eviction to delete all of
>     the inode's items in its root and drop all references on its data
>     extents;
>
> 5) Another task enters try_flush_qgroup() to try to release space,
>     it runs all delayed iputs, but there's no delayed iput yet for that
>     deleted file because the ordered extent hasn't completed yet;
>
> 6) Then at try_flush_qgroup() we wait for the ordered extent to complete
>     and that results in adding a delayed iput at btrfs_put_ordered_exten=
t()
>     when called from btrfs_finish_one_ordered();
>
> 7) Adding the delayed iput results in waking the cleaner kthread if it's
>     not running already. However it may take some time for it to be
>     scheduled, or it may be running but busy running auto defrag, droppi=
ng
>     deleted snapshots or doing other work, so by the time we return from
>     try_flush_qgroup() the space for deleted file isn't released.
>
> Improve on this by running delayed iputs only after flushing delalloc
> and waiting for ordered extent completion.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index f68a26390589..bbc54dd154ec 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4195,13 +4195,20 @@ static int try_flush_qgroup(struct btrfs_root *r=
oot)
>   		return 0;
>   	}
>
> -	btrfs_run_delayed_iputs(root->fs_info);
> -	btrfs_wait_on_delayed_iputs(root->fs_info);
>   	ret =3D btrfs_start_delalloc_snapshot(root, true);
>   	if (ret < 0)
>   		goto out;
>   	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
>
> +	/*
> +	 * After waiting for ordered extents run delayed iputs in order to fre=
e
> +	 * space from unlinked files before committing the current transaction=
,
> +	 * as ordered extents may have been holding the last reference of an
> +	 * inode and they add a delayed iput when they complete.
> +	 */
> +	btrfs_run_delayed_iputs(root->fs_info);
> +	btrfs_wait_on_delayed_iputs(root->fs_info);
> +
>   	ret =3D btrfs_commit_current_transaction(root);
>   out:
>   	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);


