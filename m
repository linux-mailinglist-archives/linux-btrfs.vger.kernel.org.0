Return-Path: <linux-btrfs+bounces-8525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9488898F89F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED167B21163
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB21B85E0;
	Thu,  3 Oct 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="I760Sr1E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021EA1DFFC;
	Thu,  3 Oct 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989887; cv=none; b=i6aKi8TV+axows6xFNSxLSXtsum6N9o90SR9BrmM+Xx+q1A3wKXPP60xS5J0igj8p7uYKfTEhiGPNxmcdfkdLoOMfHYODLiUyPbJotj3balj/5o3NTGyT/qKMt7kyHnwp/15Jq1ak8JFW8gF1UrpJa4AcGaPUPCVnJOQfyLctK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989887; c=relaxed/simple;
	bh=BjwhLb7Xvtl2TuwlTfR3B9eUZRhkaQhwh6xIKSkJui4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScyOOOFUkzdyAhGUScGRx+uGSAlQ2PhGfFugx1Jh3nXV3QQD+9Z2KPMQ3BObkCTn4IYJHCRcIr/5YGbxhMfO8fvuAaYWGKJ2DoYdoP+DfZd8t60/coiWBdgtZ0rJXX9xZDDaqiOxec5oJqeGxzICz2s8ofIq/VuZibuN3vWs1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=I760Sr1E; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727989867; x=1728594667; i=quwenruo.btrfs@gmx.com;
	bh=f7yyoQFSOQT+b4o47Ikgi8HeKRR68DNo0UDKGdowkpY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I760Sr1Eg0JkOlO3ArIvJil/4agNBm7RfJcxy9NaNWTMd7hycficV78qCDNhPftz
	 UCHtavmPopwE/sTSjX2gLM20wmyyqvzmbdFXNi07FhfChLIxkIyQnGdxoh/OAnbS0
	 gLyDmUs9x4wS2jM9nb4FXSTERZpX4ym0UzSiLrCpY4z8JxPn3uNdEfu5IU635r8PJ
	 cO5cBi/6TG1GKqymVp7xF6YvUia6lTd4vSR+HWy+U8h9hBamGfKMeDkqZNuoP2uwx
	 KAaxzdkVx9pkSjhmB7k750IOB2VgDbN6qRXVbQEL6HXcbXTLq9Oj+Ru8EZ5iDQMtg
	 qUjgllQ4gxip7SNVEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNNy-1sRF602oyo-00Rq6k; Thu, 03
 Oct 2024 23:11:07 +0200
Message-ID: <aa56f811-4b80-4df6-92c5-c4f44f73f0f4@gmx.com>
Date: Fri, 4 Oct 2024 06:41:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Remove unused btrfs_is_parity_mirror
To: linux@treblig.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 hch@lst.de
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003142727.203981-1-linux@treblig.org>
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
In-Reply-To: <20241003142727.203981-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+OGNNLriVCXX/guSVds8pDWTvhyYa2FMxfnssA2ZU45fbzS8+Bn
 KG1T/njyIOHi14Sca5V4AmKZW6cQEifStiStMvOfQadDbMxf841ELAjtWuoz5DYxEduQuZK
 zzLarnjgk9KEDrBerKrIMVbjZI5vnhI6/OFsbSC0CvvP5a/aKyUs8NWVpPMS5oG0W8xV6az
 GS0/zGY7iscwcmekAHaQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OsYBCBG2DVs=;X2dfpYhstNvd3KQcHkAqy18miQJ
 ba5ul94SnqURYY04lV60oXYIdQ8iNpAylzsTCQrcnNwNuyQ56eVMH0ixY13DYGKJMNIEXui1W
 CjAOIvThAPL+D3zK0GCvCRV/MJIc+/7Bbcmfk4qop1bQGUDkZg8YyOmnkPn0G89sThb7jIavj
 +4kcS1afJpbYp9GV7sZ+Kv03T/ZoXtrvRTnBFRJjAkGu7jAReiJ8Ue9oREXHwQI+LDpevk54r
 ODLTSbeiDBAtcNiE+NTaw/cjfkd490UUfB92QWa7qeYdOCzwmEhRevovdSZqEToaWgF2M3vGs
 mP0gQzDVab/ezdPrg9HIFyZEic6SYMv4PAgyug89GF89AzBz81aOLdV7QB4JfeM9YWMy2U0PV
 4fJuwcoXZ4evKDK7JCEtNomIm3BA2K5Ff5QdsDJQo77ULbVUaMEdfSEjZF4SJ8Ap/ZLvjxF7+
 cWtgUjbOYP1fIjLF4lbWDF086dKFXvw3gaVIdGpoC4RYXwyevNqM/0aZ10oqfS6MmLWv6jNV1
 WDSMgMMpIAdmHYcRh2wRVwXX77AdbWarplCDLC0cK6lqDjwwOSrHXQ8PBBesmHzepcLttHBAL
 /oXufdZFboina6qo/WgJBC/13PHB9NNB5FNK+4UHRMGz5rOzXkFzdoP3butVaaFdoBMURu073
 maRdGsdBhUUhrUQj9TkDV5XNsKfbDvbupOSKbpnJMFjEPp/ZwKPX7GKPux8Cx4jMxDoZwAki5
 PNyYAYxF7EjQsv9un1Yl2sk37aUo9K/IAR1cOLJscRj82DQxvh8ArEc+XtmbLJGAhze0hHuaa
 CuhV/WyavMSesn6UbgYu0Y+g==



=E5=9C=A8 2024/10/3 23:57, linux@treblig.org =E5=86=99=E9=81=93:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> btrfs_is_parity_mirror() has been unused since commit
> 4886ff7b50f6 ("btrfs: introduce a new helper to submit write bio for rep=
air")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 18 ------------------
>   fs/btrfs/volumes.h |  2 --
>   2 files changed, 20 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8f340ad1d938..7453b4999263 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5841,24 +5841,6 @@ unsigned long btrfs_full_stripe_len(struct btrfs_=
fs_info *fs_info,
>   	return len;
>   }
>
> -int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, =
u64 len)
> -{
> -	struct btrfs_chunk_map *map;
> -	int ret =3D 0;
> -
> -	if (!btrfs_fs_incompat(fs_info, RAID56))
> -		return 0;
> -
> -	map =3D btrfs_get_chunk_map(fs_info, logical, len);
> -
> -	if (!WARN_ON(IS_ERR(map))) {
> -		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> -			ret =3D 1;
> -		btrfs_free_chunk_map(map);
> -	}
> -	return ret;
> -}
> -
>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   			    struct btrfs_chunk_map *map, int first,
>   			    int dev_replace_is_ongoing)
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 03d2d60afe0c..715af107ea5d 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -735,8 +735,6 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle *t=
rans);
>   void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev);
>   void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev);
>   void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev);
> -int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
> -			   u64 logical, u64 len);
>   unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
>   				    u64 logical);
>   u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map);


