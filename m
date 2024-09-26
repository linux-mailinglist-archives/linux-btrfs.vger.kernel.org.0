Return-Path: <linux-btrfs+bounces-8252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAEE9870FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 12:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90043286A6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012691A726A;
	Thu, 26 Sep 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NiiZsAFN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788A1D5AD4
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344844; cv=none; b=U7vUdU+MmeL1Rk6iuvVUvxOeSMOC1Mzuok4pp6kgggK8iXXtAkcsi/B+9mFRLoZmmStfPY6ucB/CdwPHqMOhsnNrfBL+KfFq5TUBCTsgzvbFcpsxp8fMzGfax7gmdKMXE20Wvf9cANYsjjJgMXPW3C7gKe4mXsUYuX3wkHimKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344844; c=relaxed/simple;
	bh=kXEg9a6hxGoE3RXTbNgpFUwnUB6VJloNgtg213/SFgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dyVI3MXV2Z09ZzZYuuH43cJ2q7Cjbzp8sr5Rdc9u/lv0pttWJMLIl4eA7VbQxtHvIXsgN+ncFZzz6UlSY9t+A1VOdaeWBVWQp+qSg1R5XVKPKcrBuUOEANFm5k79g0vPZJSD8NkIVEKBJZpu33JcWU2vsOCBD465Ojt0EOltjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NiiZsAFN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727344836; x=1727949636; i=quwenruo.btrfs@gmx.com;
	bh=OnaGerl+FkFsDigXA3tfZJ+YCnZ/L69EKvK+qeA5F8Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NiiZsAFNoA2QQBvhsXTG1c2y1rJKe1donbPqCkwXAosheAg0gModdATtCgzR90zb
	 i8JNUbXQBE50fedjfN9Ryu3KbW+uWJ215xCFmUa+BFPW582TFd8cvMSpVbDYkbqgB
	 0VKZYgoJ8sLRQWOi/dgblZhhwYVDHXrpUembCHn8NTtcH3RfFaUbVju9K589vysc6
	 XyRRXj5c/7vvp1KkjBAO3/4u7ITvxzXFyy0bQKTNb5/RQ1nNrD1PG6itEMGzoZYOT
	 J69NBsTvXc4ICG1ZhwLPW98QtsWn+WlB5dNqYN8Cjzg5inPvW4J0kpB5pd0SHXzNN
	 FkYeNDMPuf2ol8ZNSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1sQupG46Ib-00UIvC; Thu, 26
 Sep 2024 12:00:36 +0200
Message-ID: <fcd229e6-7d45-46bb-b886-75a8059f8dac@gmx.com>
Date: Thu, 26 Sep 2024 19:30:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] btrfs: re-enable the extent map shrinker
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727174151.git.fdmanana@suse.com>
 <2ddc45133bcee20c64699abf10cc24bf2737b606.1727174151.git.fdmanana@suse.com>
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
In-Reply-To: <2ddc45133bcee20c64699abf10cc24bf2737b606.1727174151.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oMSHg0ffK1ZoK0ycgzHq7goNa94guXiujVJ91qfts/DQ6lsSlZr
 yUQ23/lPvMzW7jn18nv0t/6UCqMjiLjfq++kjtxdsKQPU6sVDhYylQVBpWga/yM6iO1XdyY
 II1yJQVNHlh/dsyQL/AxStd79iTQj/JbUxK4hWjLNSyYFN5T8ydAYT5JJ8jaNxIgaAZOdzC
 JwmuOhU/tOkyM8zb/1C/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oaYdDm+vQiI=;UAycWZTGA5SzzZHYDvRgVifjmP/
 jvZzXQxBqQWuTRGdRB/KUoxpP74hOJvaEb0yGceCsRrrsu8+wLSkjZisO2wNVUEivs4H4WE9E
 RiF63QogpfNWutmsRuNV4FhL+qBZy902BizkuUGS7T3hRhkYspAS4pMGazP0eJWYG5lfV24QU
 gwXN22dXdQcVEs2yXbYfYyB+fBYuk8/GIZrMf6LFa/QQDrwj/Gtw1B4WMCFp2Ec+zkvrne8Tt
 FbxWEmYy54RVdwRrr0Rg13M1qtVzn/Yo9rE932XcHI+U1hD//MsihY8xMj6YdMUXdq0JsbJGW
 Qgy3LDE65w8G5E/LqgaDKIkYosn8czUFTsj2FjhPJytzodS2wcIO25iijDhT2CHF1O7u1FRWL
 mPQQ94cXzdqpuB7zybYpVJZNAGUkBJo81X1yBjcVlecRm4vVzlD/9XxF7Zy1kNyN+4sBZ0vD2
 GkLOV+yDdHctlJwqQ+SJUkQ1Cw3O2DhdKC81+03pVDdx+Z3B2v2gqbaNaqcKrI2N0BCLXXkp0
 1to5l3eZhUNVF/TVkQrmQYF/ngU2sxmCYLoFMr6ANkcekqTmZE9qffFY1BwxAtmbqCWuVke7X
 JeY8E+y42ojoK1pFgd1XE5PXlo/K6F6SFp3eMaXgMMb9zg24YVUd92erLxICfgMJ5Ewja5DBT
 yf4HBw4HFehj2s3ru7BgiE+ayVazi8Ab8QPBRrWzZ72QOs8Ip3OW1EavM8q+pdbQlb9Wf2237
 SY/0qJr0Fj6q+vVtWo09cIuv3pdb9atL2gFNtdVanUL4YDem/LIIZRuCh/x6DZBvl8oo3EIkF
 efXGYtdhGQoDouS97vqR0RTg==



=E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Now that the extent map shrinker can only be run by a single task and ru=
ns
> asynchronously as a work queue job, enable it as it can no longer cause
> stalls on tasks allocating memory and entering the extent map shrinker
> through the fs shrinker (implemented by btrfs_free_cached_objects()).
>
> This is crucial to prevent exhaustion of memory due to unbounded extent
> map creation, primarily with direct IO but also for buffered IO on files
> with holes. This problem, for the direct IO case, was first reported in
> the Link tag below. That report was added to a Link tag of the first pat=
ch
> that introduced the extent map shrinker, commit 956a17d9d050 ("btrfs: ad=
d
> a shrinker for extent maps"), however the Link tag disappeared somehow
> from the committed patch (but was included in the submitted patch to the
> mailing list), so adding it below for future reference.
>
> Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c5=
5e@amazon.com/

Forgot to mention, I'd prefer the enablement patch to be merged in a
later release cycle, not at the same time inside the series.

We need more tests, especially from the original reporters, and that's
why we have EXPERIMENTAL flags.

Thanks,
Qu

> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/super.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index e9e209dd8e05..7e20b5e8386c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2401,13 +2401,7 @@ static long btrfs_nr_cached_objects(struct super_=
block *sb, struct shrink_contro
>
>   	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
>
> -	/*
> -	 * Only report the real number for EXPERIMENTAL builds, as there are
> -	 * reports of serious performance degradation caused by too frequent s=
hrinks.
> -	 */
> -	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL))
> -		return nr;
> -	return 0;
> +	return nr;
>   }
>
>   static long btrfs_free_cached_objects(struct super_block *sb, struct s=
hrink_control *sc)


