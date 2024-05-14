Return-Path: <linux-btrfs+bounces-4957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD88C4D26
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 09:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDB51C210E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0A17573;
	Tue, 14 May 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="njB466Es"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42F1400A
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672242; cv=none; b=izsgQaBMuzLrIDCtqOtHZvetzvJe01Fi365yxC/KPlY32cUo1A0rV8kPeDubhztkDuzJrusPKHjlj7IVHjq05JXURR5Uai99z4s/ECn9kF57AAY/ZPmfAYr/3iR/r7b4L/e+B3YEcNWvgIuXUSbvPxEeVeCH6tb/4dwBKYMYzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672242; c=relaxed/simple;
	bh=XzpAN01TkzG4OtXCMMSS6KVWBsTU+R0J1le+zcp8oEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pCoAXwkCEPBiScMndXHSRzacy8mLDc3Dhjn+Epy9Q0LvGK9UA57x/eqn8RTkGc7WdbnC7224ob/O/P1VGjU7uOIrfb/G9LxRDqyv10fout56I18gMPYY/BFM+VyYK+PFL89nareaY2Ii8oo+N5dPcY8dLST0fyEsNCUyRLhvKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=njB466Es; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715672233; x=1716277033; i=quwenruo.btrfs@gmx.com;
	bh=s2F0epS2hfbDolamHzcIegefN0UvYfoY17RvRtFxHNI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=njB466EshpZJIPEQKph1pXOn6QSVnEg8j+TMJsVamXeHxVdA95hSJAedh/Zbr83G
	 jHPcqKztURanDormH9CYkiY6gDiDBzQfvc26AkoLUieF9dHbXZXec6R88kdr74F8k
	 tP1j1XnbY+8v1K762rACFTZRf/TseCms6ThHntSQDJNTP2YkcvVX3UEMmZZuVFv+Z
	 19myi91trUxaPaja+cXgdF7KcVbK+ylKhPhqEC7lAGxPoP5rBb9i6fkV6pN5/2VW8
	 XQo86XO1B2RJnJrL6TpJcfsV+pHfspSY5tkmUBUbYFTmOuSXWRY2MML7sCrZ3ciSQ
	 Sbc1QY6BV5/gWTAD/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mv2xO-1sOaca36W0-00uGWf; Tue, 14
 May 2024 09:37:13 +0200
Message-ID: <9153d401-6fca-4874-91ea-34ec20216f0d@gmx.com>
Date: Tue, 14 May 2024 17:07:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove no longer used
 btrfs_migrate_to_delayed_refs_rsv()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <7a6704f8877c76f07ea3fc2e995b0bceea9ef602.1715620125.git.fdmanana@suse.com>
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
In-Reply-To: <7a6704f8877c76f07ea3fc2e995b0bceea9ef602.1715620125.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oj4VqRWvJwe2/A8MIo8+hgFvF1qlM+BXEZX55t1A2CV2QH2ytNq
 vX9z1+kI/O20fv/cnaWw4aqyUD5ON/OryNM2ukveCgRi3I2ZJmHnTE/tTsSeSSEkJVRonaJ
 wu3DmcOX8aNtnLH5FZH7kHThd/FmUbo9ZrKUfx45v530eJsuyfZEnsVbkqvEuerPxv13+OJ
 mIdW0Qp/Td0qezrQnwJcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tk3qSVohQXE=;esr/YuGYBOe5Z2CYqmDWV6ArE2c
 fdNwJNmfiNUmCYYf4NA/PaiIq2oNxfH/O1q5h/mw0pZD5QUOBZh5uJfyA+r/5QcHPW+6SxiIJ
 +0oVXys6QH0wfRmWLiSfExnHy2jQiN27+Lf9dB3JTI+6YNpIQtOiYH/TyZfxFPFW+8zNL/BVt
 YRKMHIJyI27Jmqd8jQMXwH5Xf84IBxykn6cMvkiU0AavuLI66qJLjmWSpxamnKgPOdasx3755
 hjdUVePu/JF/1EYMCngpAINqTexX9X4Icy98JYD3SVAQ/aJq3aOTIL3C9IV4rGl1vBY9hp4NV
 WiEu5meR4wo0RSEzeygfksqrpWq+/+VAE46j4iawdpl3iikaYgSAFjVp7OSgJdtRhw9lFnGKx
 8l2Ho6sr/L+joS5uTfHzmfEiQBpvEWsCBOzymDhEE6Oe3ZP/Wn40qNm9PIFlcX5N5h/G0a9OZ
 DUY+bjwgxeW+hSyAb4xFMq8MQlWhOpEuGUGK2QCOCdOFyLTJ1tVQQRIo+/5Tve/KHln+LH3t7
 MZWXH7Aj7WDoO2+3e9m3nd2r4sippnPyFWGyei8u6jTuE+RanuSp0GpSxx9j9GduqFqCc+C8p
 p4EKhnnJxmjtDZlnxpEILfye1z4iYpN320xXKom6tCpoHeQQf1CqP9CIgiYysUMJ/tNHZfuFS
 Hv0Gpxr9AmnrDyNhZ+2NDvzT6lmOgQsiHA9doeyfl9mgPnY/cbRUKSFAOPWaNLqmDEsOeIyco
 dZxo9nCf7CIZHKP5zdzfJiK503AP7nsQDffyFbMpSxSdIz4th2DkmK7KLFJq9jKd3wwV4Whzc
 BwdtQLu76cpqNTWfKIZzc8vyrjGOIn8VHV/16l8L+Dw74=



=E5=9C=A8 2024/5/14 02:39, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The function btrfs_migrate_to_delayed_refs_rsv() is no longer used.
> Its last use was removed in commit 2f6397e448e6 ("btrfs: don't refill
> whole delayed refs block reserve when starting transaction").
> So remove the function.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 42 ------------------------------------------
>   fs/btrfs/delayed-ref.h |  2 --
>   2 files changed, 44 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6cc80fb10da2..6b4296ab651f 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -194,48 +194,6 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct b=
trfs_fs_info *fs_info)
>   					      0, released, 0);
>   }
>
> -/*
> - * Transfer bytes to our delayed refs rsv.
> - *
> - * @fs_info:   the filesystem
> - * @num_bytes: number of bytes to transfer
> - *
> - * This transfers up to the num_bytes amount, previously reserved, to t=
he
> - * delayed_refs_rsv.  Any extra bytes are returned to the space info.
> - */
> -void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
> -				       u64 num_bytes)
> -{
> -	struct btrfs_block_rsv *delayed_refs_rsv =3D &fs_info->delayed_refs_rs=
v;
> -	u64 to_free =3D 0;
> -
> -	spin_lock(&delayed_refs_rsv->lock);
> -	if (delayed_refs_rsv->size > delayed_refs_rsv->reserved) {
> -		u64 delta =3D delayed_refs_rsv->size -
> -			delayed_refs_rsv->reserved;
> -		if (num_bytes > delta) {
> -			to_free =3D num_bytes - delta;
> -			num_bytes =3D delta;
> -		}
> -	} else {
> -		to_free =3D num_bytes;
> -		num_bytes =3D 0;
> -	}
> -
> -	if (num_bytes)
> -		delayed_refs_rsv->reserved +=3D num_bytes;
> -	if (delayed_refs_rsv->reserved >=3D delayed_refs_rsv->size)
> -		delayed_refs_rsv->full =3D true;
> -	spin_unlock(&delayed_refs_rsv->lock);
> -
> -	if (num_bytes)
> -		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
> -					      0, num_bytes, 1);
> -	if (to_free)
> -		btrfs_space_info_free_bytes_may_use(fs_info,
> -				delayed_refs_rsv->space_info, to_free);
> -}
> -
>   /*
>    * Refill based on our delayed refs usage.
>    *
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 04b180ebe1fe..405be46c420f 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -386,8 +386,6 @@ void btrfs_inc_delayed_refs_rsv_bg_updates(struct bt=
rfs_fs_info *fs_info);
>   void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_in=
fo);
>   int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
>   				  enum btrfs_reserve_flush_enum flush);
> -void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
> -				       u64 num_bytes);
>   bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)=
;
>
>   static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_nod=
e *node)

