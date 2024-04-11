Return-Path: <linux-btrfs+bounces-4172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921CB8A2243
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 01:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118331F2306C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154FA481B4;
	Thu, 11 Apr 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dACiZe6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75F224FA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877915; cv=none; b=Jth6syMlGHOahuvVA+321KNF4NLajfwBCjrUgc1ETSrDEmxpn9L44mDM4LhACwasZ9BLINdfS09MH7++DmJ1fEAH9TVUlBuhFXsglMkYTfam1v9EdNjZOf1bs8Ub5YpDHZWm8WGQZi/9d/BUoyeyscj5cE6tmaO+GPww+sdyJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877915; c=relaxed/simple;
	bh=p8SesXz6G0AG7sqheV/41LKwnP7I9V6kqmhiaXPD4PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SB2yjKI8IkwC8bPCUj7eE8DZpxDkBTC9R0vAT9vlQQyt0pWWGk0hazgi1cPN8evj4F76mtweVi4DFCNYc1fzkXrIqat6XU7fRx3q1q9u07LTg/oK7VWub5Zakzu1WP7nFeQ3hGqkRG59qMdtebP4dHWWSJGa3mB1gQM6gaYg7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dACiZe6L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3442f4e098bso790050f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712877911; x=1713482711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yumywYd9r66LcsUcfEQrNoQ+hGfwVLHLhSsb6Kmz4/A=;
        b=dACiZe6LA7WEUSvTHM+f9F9du/zzDLx61HRwX1nrcRbHomA7Y+49+oq0FworNSCrM+
         QcXfzaxAy5nNFUyYXs+av5fQ7R/TmVyuO5IIaC4L7kBNVDDP3c44anfbBoy7dD7xUBT5
         v77VGIz5nWeW9Y6TKGAvYqiKWbRowAGLYTEQzLKqUuT/MRRmPK9SbICx+CswircfbXNc
         +sWJMGwSFoqSKP3lp2vTb0A4hdonC8dL72HzAi1mk/XeaQ9RN0NCbT00tl2ZnQtY/MkT
         +Re8gI916rQgqRN0cGS7STEh4MiCgwEhgTaNjDqAZ8eU7lUiAuCtaBhEwrnDxznobrS+
         BUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877911; x=1713482711;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yumywYd9r66LcsUcfEQrNoQ+hGfwVLHLhSsb6Kmz4/A=;
        b=gpu/c++0iwd8vVLX82BcxEPkUxcVNvAndsyNlX5HDLXtyXnLybni0Sf+dB5eta9GtX
         dhxNhYd2kj7l1YD0PQAgQ0xeGgGCbRtZW+ttzmS4QTPqC4jSF7tSG+M4PfqX9NJOJcGi
         rJ5WDeBepouik9WzlbarGgNyME24xh0PhA/uW+FWQQkVV35MMqsqrZqnLM8e3JPcuqX5
         /NkYSJREfAD7UqhEtQJGGUtO6fwwSM0zO4bdwjYF60wF0tAMPk6HTTyU3leDlSBjPeXJ
         rbs3usPds/WvVH00N5rZa/MVVqsBPpOfYBFDcq3zMeewABLwvp0miN/SbKm03HClGU5D
         +18w==
X-Forwarded-Encrypted: i=1; AJvYcCX21nIIKL8vAE3ZPwvq+WT33TZm1MUnEvrpG5wG9ou+qcMyhE9vFFmGO/mCJyY6eAYvnQJ6JrCe3RxTTrgdMxC60l0IiejznOXLb+s=
X-Gm-Message-State: AOJu0YwHpu4e1Dq/oIT+vAepffnlme7NGkygIAXXK3ki4qDDOH3zu1aP
	xBEvh4n3Looe7qRpFJlfH/bH9fjng+nbtZGEuXzjwQ9ci3qvNIOscQXuNmLbaX9Qs+P3Nb+HS/H
	X
X-Google-Smtp-Source: AGHT+IFk79nXlcrAxsmIjJR3aHUrcsgMXbVLQiG/ypkP8dkecbWHbv/yH2FLASvlKP6y25SZ590s0g==
X-Received: by 2002:a05:6000:1549:b0:343:8485:4edd with SMTP id 9-20020a056000154900b0034384854eddmr4451680wry.23.1712877911072;
        Thu, 11 Apr 2024 16:25:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78694000000b006e6adfb8897sm1705245pfo.156.2024.04.11.16.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:25:10 -0700 (PDT)
Message-ID: <fcb277ab-c627-400b-917e-4599a0fadde0@suse.com>
Date: Fri, 12 Apr 2024 08:55:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] btrfs: pass the extent map tree's inode to
 setup_extent_mapping()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712837044.git.fdmanana@suse.com>
 <7e8a8cc96cc25b31df62ce8a3492c690dc25608d.1712837044.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <7e8a8cc96cc25b31df62ce8a3492c690dc25608d.1712837044.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/12 01:49, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Extent maps are always associated to an inode's extent map tree, so
> there's no need to pass the extent map tree explicitly to
> setup_extent_mapping().
> 
> In order to facilitate an upcoming change that adds a shrinker for extent
> maps, change setup_extent_mapping() to receive the inode instead of its
> extent map tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_map.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 15817b842c24..2753bf2964cb 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -342,7 +342,7 @@ void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
>   		try_merge_map(tree, em);
>   }
>   
> -static inline void setup_extent_mapping(struct extent_map_tree *tree,
> +static inline void setup_extent_mapping(struct btrfs_inode *inode,
>   					struct extent_map *em,
>   					int modified)
>   {
> @@ -351,9 +351,9 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
>   	ASSERT(list_empty(&em->list));
>   
>   	if (modified)
> -		list_add(&em->list, &tree->modified_extents);
> +		list_add(&em->list, &inode->extent_tree.modified_extents);
>   	else
> -		try_merge_map(tree, em);
> +		try_merge_map(&inode->extent_tree, em);
>   }
>   
>   /*
> @@ -381,7 +381,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
>   	if (ret)
>   		return ret;
>   
> -	setup_extent_mapping(tree, em, modified);
> +	setup_extent_mapping(inode, em, modified);
>   
>   	return 0;
>   }
> @@ -486,7 +486,7 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
>   	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->map);
>   	RB_CLEAR_NODE(&cur->rb_node);
>   
> -	setup_extent_mapping(tree, new, modified);
> +	setup_extent_mapping(inode, new, modified);
>   }
>   
>   static struct extent_map *next_extent_map(const struct extent_map *em)

