Return-Path: <linux-btrfs+bounces-13399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121EEA9B6B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AD11BA0CC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55D5290BB4;
	Thu, 24 Apr 2025 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqnKcjOM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3B1E47BA;
	Thu, 24 Apr 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520572; cv=none; b=O35PRCF0FdG1Dk1c/ogp4XcwqXnM3mxjov3ZKGj4juuciu79JuyXTXwGD7YMcLmhzaMJu+E3oDUYQ9YEvb4vvibqLXrQGFYbWn0CPtCa5kg7V37JuoG4syPRLX7D0q4gzl/3IcBj7HeRt8jjVAnVzaWsln6NrEDJdL75pVWpyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520572; c=relaxed/simple;
	bh=Y8Zj4Ot+xJLtfDZRdM1wwri1rHBunTzwWrzpp4WjAD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TY03upw5S8k5L3U0iGWpGW7BpxOWXJiVL5tsUmuL1dHWwl9m/fF7wxRxhVhNbgro+yXerCOaXbX6TxiVvsSU9MUrsNFJFD+IThpYA/FlgPJNCfFLChY5gBQsxOl2YtGjfgayzLJwgFo6ynpPTLwK/eVTMsGVDa9D6xfHk2zw4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqnKcjOM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54998f865b8so1369053e87.3;
        Thu, 24 Apr 2025 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745520568; x=1746125368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5MDA9eeZLBxjehbLj9Wx1j9aP1a1OT/E8TcC4HDqSQ4=;
        b=GqnKcjOMBRcxStU0TX4XwqH3ib/jqAVhJZCDpCSCugRiRHCqG/RMVTbNUlJCTXaNoN
         ns9ufi5tsvUVjR8piueqlmHJFjaF9Yw4MFB7biom6aYxbFu5MwL6b+/ZBYepnC/buVPw
         Kcc41jhbM5FWdiY1c2anJA24K9LMapb7mpgLDixpIroV5OTgZD60zu1l4bMxS4IZwWIs
         bbr8k1VmbacXmjckFQgqoHJNIs9tDJ1wr+nFHfguqGsuuIgFSlSS3Gpk9uo9ndsAvuPN
         VzEK7CztDEyalU3Y6ewgKSDX0Q2CGDopobBNXOiga+iPkEBk1yzdmOvgxR9Okn9flDjl
         8sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520568; x=1746125368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MDA9eeZLBxjehbLj9Wx1j9aP1a1OT/E8TcC4HDqSQ4=;
        b=LYzuycAWVDT7e9LBN3g3wVEfLcWf5l0C6GWItw1I/o73z+cj0GGAgJyqNEVoGNw1Ab
         m480a2OUB3jUyyRN4uQzBjlJjft833ZuAwn8P0v9yM64oY6OICUIYL2N/0TsjVSBd9+q
         J3m/9+D5+wK+o1a0gjC+dwFq1/YVlPZ3uy3qNMls0LCSEl92TGDJpz8A4oMAW4fyvtt+
         /o5tnFiXFPKfScIEX9VPa9vEcyLaFhcx+Oy7VQZc1NyUk3t1RsQfzHGH87n6BG1TBQYj
         dCzx0cfMCcusexQDEG1b0C8aKRYot/Ul5jAwCEf+oh/TLOt8aSGujIEILFv/HBkZk5ps
         JX8w==
X-Forwarded-Encrypted: i=1; AJvYcCV17x5BrMk3UvnCnHvG7Q0tLr9BwT241Nksw4bWkESOktFcpQPVdWOut3NCmQqHB07yajYFn1oNZpCj+dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNqTm7ZjgyECrpO7y7HOYsgo8NRToEoMhk83ioYC7rVVINCiT
	fksiSu3kBWlWfG9EX9ax64ABRIWSrr1n624I6sq65FN/miSWpOQ8
X-Gm-Gg: ASbGncvY7EOMBjXMGWE+9AZxN7ZPn2ulVJRStu65WNTfYGgP8Rgu1vnkyxSf1e/GoU6
	BLCXBV9kPLj5c8t0BAMarLed9ORNL2n9RenIWuBm1ueJCO0Fxl2SPjq2wI8l9eaxq3pOmywjhVI
	r3gr50TYKgnvtDIdD0LrDBmcxXU2RRQeR0ovfcJWNE0l3iWlJa3UDN7DZMwTw9ZNxXaXQGFW0LG
	s52lvk6ppCyK537fDCC05e7pgVkEG9nTfeycBNku7dTKVKVJ5unpZsf3KMWYp5XhXqDmMQ+Sf9w
	mRQ5uuWRN9ni6Owf+xqqnNMnuppPluExTBEIL0t2pttJoo3dVC4g9dr/zBr7ZTKGKKr7A/8oMK0
	DbQuDX3xBF+GgRdjKSx7OhcQcUYCJjPXy8hIO
X-Google-Smtp-Source: AGHT+IG2zEkQ101UPCaITffZzJVHlNfgWRLjsy/2HRlTDffLmWDXqwzDq9QA1YpUVY3g0jXmiiSqTA==
X-Received: by 2002:a05:6512:3e0e:b0:549:86c8:1133 with SMTP id 2adb3069b0e04-54e7c416661mr1243785e87.12.1745520567831;
        Thu, 24 Apr 2025 11:49:27 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7ccb7f1asm321999e87.237.2025.04.24.11.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 11:49:27 -0700 (PDT)
Message-ID: <b94e18b9-7e47-4237-8e43-261307c44d8e@gmail.com>
Date: Thu, 24 Apr 2025 20:49:26 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: put all allocated extent buffer folios in
 failure case
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250422125701.3939257-1-neelx@suse.com>
 <20250424150809.4170099-1-neelx@suse.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20250424150809.4170099-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2025-04-24 17:08, Daniel Vacek wrote:
> When attaching a folio fails, for example if another one is already mapped,
> we need to put all newly allocated folios. And as a consequence we do not
> need to flag the eb UNMAPPED anymore.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

This version did not trigger an oops for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

> ---
>   fs/btrfs/extent_io.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 197f5e51c4744..7023dd527d3e7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3385,30 +3385,26 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   	 * we'll lookup the folio for that index, and grab that EB.  We do not
>   	 * want that to grab this eb, as we're getting ready to free it.  So we
>   	 * have to detach it first and then unlock it.
> -	 *
> -	 * We have to drop our reference and NULL it out here because in the
> -	 * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
> -	 * Below when we call btrfs_release_extent_buffer() we will call
> -	 * detach_extent_buffer_folio() on our remaining pages in the !subpage
> -	 * case.  If we left eb->folios[i] populated in the subpage case we'd
> -	 * double put our reference and be super sad.
>   	 */
> -	for (int i = 0; i < attached; i++) {
> -		ASSERT(eb->folios[i]);
> -		detach_extent_buffer_folio(eb, eb->folios[i]);
> -		folio_unlock(eb->folios[i]);
> -		folio_put(eb->folios[i]);
> +	for (int i = 0; i < num_extent_pages(eb); i++) {
> +		struct folio *folio = eb->folios[i];
> +
> +		if (i < attached) {
> +			ASSERT(folio);
> +			detach_extent_buffer_folio(eb, folio);
> +			folio_unlock(folio);
> +		} else if (!folio)
> +			continue;
> +
> +		ASSERT(!folio_test_private(folio));
> +		folio_put(folio);
>   		eb->folios[i] = NULL;
>   	}
> -	/*
> -	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
> -	 * so it can be cleaned up without utilizing folio->mapping.
> -	 */
> -	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> -
>   	btrfs_release_extent_buffer(eb);
> +
>   	if (ret < 0)
>   		return ERR_PTR(ret);
> +
>   	ASSERT(existing_eb);
>   	return existing_eb;
>   }

