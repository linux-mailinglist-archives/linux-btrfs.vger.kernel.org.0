Return-Path: <linux-btrfs+bounces-5571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC74900F9C
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 07:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528F4B239E8
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 05:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A317625B;
	Sat,  8 Jun 2024 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UNuiNeAP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCF1FDA
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717823286; cv=none; b=tVRtulgckR0Ql2Z1Bw80AGTWrX+4npr9b3/8pX1aO8wV8vh/+zzbttMFdJe3twTNRyVAApBjlB1nfLl3v4uRvl/qXzrpTqFqtUBjUmuYsjt5lQOvvIpQXQp2XpNkTAiLMclPV4HGceu44buYgMs3rA78pcoebEWTVpFYihBz1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717823286; c=relaxed/simple;
	bh=fUvSxh4FruHJz74K3Z8sWXXvNuIhgCvucOfQwkZLt3E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bKeNmOUW3bEgcwNO6D/8DcTTAMxAVU/IMHYrFzQWDTqhZCiT0RG4vuUP4XZmtQDM6N1AmP+I7CpjaPDciKETQInJcnv/OYaOZ+5+F946DQ1cMqlquUYHOj6OqJfizXF/WQxwEJb1V2whV7EPid8FqTK7kV8bFfWN2yfQkRslOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UNuiNeAP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e72b8931caso28180171fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 22:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717823281; x=1718428081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwPsDWpYlzQVhXHIfxqlyS0xPlA1CjbbFKTUefdgfdE=;
        b=UNuiNeAPhfCOuKjQRtFmUrOUqyNVEgaoQv8J3A2Qa1XoiRG63Qx5i41IKjqz6bixw0
         GMPMsvIEZiEI9s3GZrQMsQXfUDJLuRC2WdPI27wmz5Hiyjfe784yAxEphueVt+QCSi0B
         54IGHLQUDzITYVEpnRgr+LtI0/ByaZISUBSHW8nJraPxoTqEuOLcFAz5oUNDbFFo0iUi
         4v/SM+exW9HA/tE7aCxu/FfrXH21IBS1UKgsMaVvOB62+oSJ286OHnyoFenAOZVxFV2R
         VNXnJyH1In1hOeou3KbvbQp5UNT3blbsu890MqSJ84zdpv6ijwJmLh1B6VikXtJ5GC7C
         pUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717823281; x=1718428081;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwPsDWpYlzQVhXHIfxqlyS0xPlA1CjbbFKTUefdgfdE=;
        b=hcY3jjXeOIiwVFWI7BtGpgD5rO/riTM/tO+/weviX6+G7+WCCMdiwAM4NutC0lRYQE
         7CQqZIOGqvfsSIjZ6vGgUr9ZeWAoR4zfKi2COoi+0dhTlZ0GfFpJi2gcTTmSBU2B99gh
         sSfWz4OFenhWGIg6obpa1VN4O/OlZMCTnCtFhWohJ2ARV1LffDttu9zSuatxX9t7iDV9
         Hbb9xRxqhO9CJPLlHzfLCiOulNdWbTWwuGEvit/NknFdsKRyeuZDvj5345AcXMkWFuYu
         bll4Qua1mqWvEPZP//li9A7eLTfzEFVTGOfrTrtOSYa5dbd33Jbs2Aa8c1jVs4SLC/he
         JHAg==
X-Gm-Message-State: AOJu0YyVaZnsqRE/ayds/3iReZxAm4hSRxAtkdgQ7bsATtU+L+a8W22m
	UNyaTpjkW4L5mbAadLLYUlXa5dYefTvcyInKMLv+qPb07gvDTFVHEeMBz98vxczgZS7e3IPkaTa
	q
X-Google-Smtp-Source: AGHT+IG6kWWIVOp+TlzyIdP1ZJdFaZWNCu8KXvLkx0R9GtjqZolB8F0fj1tPkwNCvWHjvaF80Fu+pQ==
X-Received: by 2002:a2e:804e:0:b0:2e0:14bd:18f2 with SMTP id 38308e7fff4ca-2eadce91456mr25278231fa.47.1717823281086;
        Fri, 07 Jun 2024 22:08:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067d066sm6665052a91.33.2024.06.07.22.07.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 22:08:00 -0700 (PDT)
Message-ID: <4af5f2ab-8c9d-4303-b663-840d2dbb31eb@suse.com>
Date: Sat, 8 Jun 2024 14:37:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs-progs: print-tree: handle all supported flags
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1717819918.git.wqu@suse.com>
 <9a1201c209c72e332ab9d25f5036edc847547550.1717819918.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <9a1201c209c72e332ab9d25f5036edc847547550.1717819918.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/8 13:43, Qu Wenruo 写道:
> Although we already have a pretty good array defined for all
> super/compat_ro/incompat flags, we still rely on hand defined mask to do
> the print.
> 
> This can lead to easy de-sync between the definition and the flags.
> 
> Change it to automatically iterate through the array to calculate the
> flags, and add the remaining super flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   kernel-shared/print-tree.c | 35 +++++++++++++++++++----------------
>   1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index a7018cb724fd..23cd225a9a50 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -1950,18 +1950,13 @@ static struct readable_flag_entry super_flags_array[] = {
>   	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
>   	DEF_SUPER_FLAG_ENTRY(SEEDING),
>   	DEF_SUPER_FLAG_ENTRY(METADUMP),
> -	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
> +	DEF_SUPER_FLAG_ENTRY(METADUMP_V2),
> +	DEF_SUPER_FLAG_ENTRY(CHANGING_BG_TREE),
> +	DEF_SUPER_FLAG_ENTRY(CHANGING_DATA_CSUM),
> +	DEF_SUPER_FLAG_ENTRY(CHANGING_META_CSUM),
>   };
>   static const int super_flags_num = ARRAY_SIZE(super_flags_array);
>   
> -#define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
> -				 BTRFS_HEADER_FLAG_RELOC |\
> -				 BTRFS_SUPER_FLAG_CHANGING_FSID |\
> -				 BTRFS_SUPER_FLAG_CHANGING_FSID_V2 |\
> -				 BTRFS_SUPER_FLAG_SEEDING |\
> -				 BTRFS_SUPER_FLAG_METADUMP |\
> -				 BTRFS_SUPER_FLAG_METADUMP_V2)
> -
>   static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
>   				  int array_size, u64 supported_flags)
>   {
> @@ -1995,26 +1990,34 @@ static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
>   
>   static void print_readable_compat_ro_flag(u64 flag)
>   {
> -	/*
> -	 * We know about the FREE_SPACE_TREE{,_VALID} bits, but we don't
> -	 * actually support them yet.
> -	 */
> +	u64 print_flags = 0;
> +
> +	for (int i = 0; i < compat_ro_flags_num; i++)
> +		print_flags |= compat_ro_flags_array[i].bit;
>   	return __print_readable_flag(flag, compat_ro_flags_array,
>   				     compat_ro_flags_num,
> -				     BTRFS_FEATURE_COMPAT_RO_SUPP);
> +				     print_flags);
>   }
>   
>   static void print_readable_incompat_flag(u64 flag)
>   {
> +	u64 print_flags = 0;
> +
> +	for (int i = 0; i < incompat_flags_num; i++)
> +		print_flags |= incompat_flags_array[i].bit;
>   	return __print_readable_flag(flag, incompat_flags_array,
>   				     incompat_flags_num,
> -				     BTRFS_FEATURE_INCOMPAT_SUPP);
> +				     print_flags);
>   }
>   
>   static void print_readable_super_flag(u64 flag)
>   {
> +	int print_flags = 0;

This line should be using u64, or it can not handle flags beyond u32.

Fixed in github.

Thanks,
Qu
> +
> +	for (int i = 0; i < super_flags_num; i++)
> +		print_flags |= super_flags_array[i].bit;
>   	return __print_readable_flag(flag, super_flags_array,
> -				     super_flags_num, BTRFS_SUPER_FLAG_SUPP);
> +				     super_flags_num, print_flags);
>   }
>   
>   static void print_sys_chunk_array(struct btrfs_super_block *sb)

