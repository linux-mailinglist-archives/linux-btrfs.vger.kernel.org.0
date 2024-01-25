Return-Path: <linux-btrfs+bounces-1772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B064883B894
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 05:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412941F23048
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72F748D;
	Thu, 25 Jan 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UHxCn5x7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109763DD
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155704; cv=none; b=e6SO3VT9KCxqe75jC+NfoYgOPk3sAbHZZAUXl081pLcIBQ8I58D5iLZ3/FC5qRSA8Krh5j1gbzj+8C60pEnO2dl9dfNEPefl4AZhsH+m5O9GbsaA7FBl1AM3vkeuQjw8KnSqWuwWGkIEBzbjwo/yjTsN6ISPtE3oyUKaVJW2Y10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155704; c=relaxed/simple;
	bh=7rm7S/mhjM+E0m7Ko9LWvwOfhuKWQuMJI5QNUxlnzDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nsniBUoBk25IcYptYWcGoDTv2069cJLyx9gpouGZX5oKlpGOpEM70VFvE9zxkHn5s3Q2TJ7VpCKXZFN1uriBe0BzH89AaNuhSsg+7KPMi32CuXQUz2JZdI6WQgVb1ByKqw/hVGFH9YcgJR1GCJwynRh64XjJknZuWIIKkl2kdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UHxCn5x7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706155699; x=1706760499; i=quwenruo.btrfs@gmx.com;
	bh=7rm7S/mhjM+E0m7Ko9LWvwOfhuKWQuMJI5QNUxlnzDc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=UHxCn5x7EjAvi+DQY3WOe11BTGTrEAmndgaxLM5LXF7sQSB3uVG9n6Qqa+v5y8eH
	 m66KzljO3Ssui5hNGeGXYFV/m8f8TcrAB5wafQM3LUSSWtEjIvgnIOEpHaISSAr3F
	 7kiWjmVG1tWfm2XYOzkuKKhC25c6Q3nUqS2Yi6zvw3jNFgebHhG2zpNi46RF77cue
	 XOplAgWyYL4z0qOXne0jJhBoB8B3oLtCmLN66z3W8WlaqPkQbWOu600naEEaWBy3s
	 4WsFHlxy40OfVre0MLc2/7bia6W2+5x4WWwbacnIFmU+ivR0jWxMm3D2tEhc/GVZ7
	 ROgr4j2SDjnp3eMEtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt75H-1rCxyt2nKz-00tUjN; Thu, 25
 Jan 2024 05:08:19 +0100
Message-ID: <21add1cf-d22e-4a95-a293-65ac51b7ec23@gmx.com>
Date: Thu, 25 Jan 2024 14:38:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] btrfs: handle chunk tree lookup error in
 btrfs_relocate_sys_chunks()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <ae9556ccc1c06b17ea40f2e05b60cc4d8dcac0a7.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <ae9556ccc1c06b17ea40f2e05b60cc4d8dcac0a7.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eKHwDrcpbrtigL03eqSQ5LFq8uXDMXKKkyZh256nxv7J+Shq0Ou
 sjWpwaXpu1oL/mSj0hrnR1uc5S588eJHMiVBsyUkouCKgLi4i48/Irux8QkSywpsDS8gj32
 nj0fn5MBTDyyHLcYvac8alInUPFprESXrhGsRQQLc+ll6BH+MImCkkuaKy4f4z9ClT2J6kp
 3P3PklAXFAD/pVePhxGug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GAAKgjULAU4=;K7HKWNsRkrVNlrtOuZnYC/r199V
 udoHMpf17DIJ4c7lgvP4xSpblGbv2SEBc63ZD32834xNp+/riemtrZj8M/GembySfED84TdAG
 QiqJi64qr3zecCKntmN+kuzQnzA5Fc1SKEjwhtus7IP8zXfdWvVvWOUjb/9Gr1xGPyGMjvHEQ
 qRcEFODRa/Fl7U5P6Y02ppRzJn/yVqV/HL8p0H2Nsg3MFwXYlK7Bz9OKpscdWxLZU46Ic9lhm
 Mw5nByHqnB4nsyg6gBYoGkkxzKEbWHUF0kzZIX5aPowkYIyK2usdiQfhfqLaV/ILDeTPCjuiV
 vfTAWsQfAMzvKIuAi32nqGZaD7D/+WfNTJhmwgOVamy7g3/+FlVTDVyXMaBHKfu/Tgu3JXnBA
 agne6eHmtu+N8O0aSSL+JZj4hAm5U1QfPDoFZUJAz1tvhkasncozBa+nZc03AVgQHS+GOjC86
 XhMYjq2lG6TAmtuFhQ2+XTJdrbIywTxSZ6aBYyZCwmm4RDqeojJj8gEbrR+Ow1ZaSCOthsLE1
 L+AW82I+7ik8R5LoTPXXL/GtSB8FYL3bGCXYWp0OJZr3LQPlenReHp/1JLXyF2GN9Z0D8Pcl4
 E+D1WCJdgKIZMpAVY0FouqEBGxMFJzRfkQ4vW2HEoRG9XLHRrXLsX+4aK9VXdkByk2jAhvsAr
 +ELz/ceWjoTi/706rq5k6F7mbXhcnKXIWknocyzXoddCsQEo48sFQwmxsEFsFaezEWvR4W1nV
 QfEnnokOk6Lxi+gCWokr98IetqxdIlpmEW3fuRFdyu4jg+xrT5zgpB6SsrDD8xujsZTN2oZTH
 EYm2HBLQnVW3F8DweH5Oz9Z0iX+WuDxF6Oy/qKiNLXtl+Vywn1atDxxwvkLVxZ8LAJ4yomms2
 w4Mv5AVTaYMhuyjPf+hZsdx6uy/A5JXkhN9c9z8+QJXHPjsIeu/m6Ek6FdxMzjSfqmEk2u3jP
 1qAz11gtjEbWInofHIfe7l9YQ/Q=



On 2024/1/25 07:48, David Sterba wrote:
> The unhandled case in btrfs_relocate_sys_chunks() loop is a corruption,
> as it could be caused only by two impossible conditions:
>
> - at first the search key is set up to look for a chunk tree item, with
>    offset -1, this is an inexact search and the key->offset will contain
>    the correct offset upon a successful search, a valid chunk tree item
>    cannot have an offset -1
>
> - after first successful search, the found_key corresponds to a chunk
>    item, the offset is decremented by 1 before the next loop, it's
>    impossible to find a chunk item there due to alignment and size
>    constraints
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/volumes.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d67785be2c77..6aae92e4b424 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3393,7 +3393,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs=
_fs_info *fs_info)
>   			mutex_unlock(&fs_info->reclaim_bgs_lock);
>   			goto error;
>   		}
> -		BUG_ON(ret =3D=3D 0); /* Corruption */
> +		if (ret =3D=3D 0) {
> +			/*
> +			 * On the first search we would find chunk tree with
> +			 * offset -1, which is not possible. On subsequent
> +			 * loops this would find an existing item on an invalid
> +			 * offset (one less than the previous one, wrong
> +			 * alignment and size).
> +			 */
> +			ret =3D -EUCLEAN;
> +			goto error;

This can be handled by adding new root item offset key check in
tree-checker, then converting to an ASSERT().

Thanks,
Qu
> +		}
>
>   		ret =3D btrfs_previous_item(chunk_root, path, key.objectid,
>   					  key.type);

