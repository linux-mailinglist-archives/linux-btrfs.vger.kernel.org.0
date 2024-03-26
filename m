Return-Path: <linux-btrfs+bounces-3640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03488D0C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EF8B21B02
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3613DBBE;
	Tue, 26 Mar 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YQHZVRh6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4351CAAE
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491989; cv=none; b=In64gUXzDhIRWZwVC6aQURv7kSm15yBMAj/pJnapLnaCoRxiUNN9BiRnWQjjZJbFXmOaklBOYQEAixyNMcYOWePfrVuY0OGVidDUoMaNDLblMkdibIvFoQOEuXT8Nt84CbxOJl2zxh5y24Hg5z/a/vEK9EdvzzA9zl4JM8dBGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491989; c=relaxed/simple;
	bh=gp3q9iBwJiIJVqbs9vTofxj9TgTy1pFAWqadTPg3tQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oqUYgI012OM7ipOUa5dGIQqeY+IFg6j5ebrKG/UXruPc8Kace1U3u8d6A54J6JeEpCbgKK6ejv/sz1hjP0zl1XWWj2odbdeCtQPL2sBi23YTma71bg3/RJXuNQ/wPF+7d+o8AJFBKcrlS8yHJYDCgBx70SMG59i3PF+1yUEY4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YQHZVRh6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so99852541fa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711491985; x=1712096785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BXfcBoLB0Ts+EfyM0e/eGtR6KrkCLsCAXYdD2kvnB5o=;
        b=YQHZVRh6MLlr8GV5frSp0V+W4XoVr1soZYBqwzGPzruYjBizT5lTpOppmkxgPnA8hk
         ivgx2XOsVFw+AJhQS4zVvHWdioR9B3lF7L0jUYGczdNJ3ZWVBFFml+T/JiK6hbJlHlii
         v4Zy/OMDelsVvEh+i8+ebz+7ppFotMA2Vj64mgjrL9xHm8AvT8IPvRPRORZGqsPs3LF8
         UATjBLEXrZN65Z0u8uN44Eo2ljm5s85LdCywPRGp5jFDwNstaKU7/wvUTCvQ2m0hoEBD
         yLRZI6Crw5IuDZ7Yv2Fcr853IlNW6Ir3cigEv9HuSojrrKzaL7BcFp7oGq0bWEO0MLNW
         lj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491985; x=1712096785;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXfcBoLB0Ts+EfyM0e/eGtR6KrkCLsCAXYdD2kvnB5o=;
        b=dnYu66Qkw/qWqFBn/XskfuzHYyTCX6ztd2gC144V6D5JAXRsTyQUxcnmwpy67zH6Hj
         c0HqDeyqBvv/TGcKOiUkSwHchSPxWUHQVpEwEuZjwNUotI0ZQUIzMWEdDBacGq/Oz5mm
         eGofusAb1E7JiX5MOMTjMyVpl2gyraQ6luoiHsufx/KkGBdv4P++g7LN32Ww4VPIdIDH
         18EFA44XNgS+nFEBsqzddizY5VgA4HnIhEGKMG5IoSPc+GNWU3iGO10DEMv3Hz89vQZt
         4Gy7XkUA+7BFm1GkJedPXxt3RM27orQRzFdA/gb3WyH2CJNHJbSBwlL4DHbUrgFloWrm
         JiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLOjqeJxzgyafO6MGYkUjO0lzwKsJDpJgmC+JIAqeDuYWbvMRepPJl+U6MNIZLCeUkyRCRbftgVPYMb8fQW3x1zmAHebLoYDk0VvM=
X-Gm-Message-State: AOJu0YzZxRyZl8hVSm5JbZdjKbPlVMbqm7/2o19fAs3S548enc7X3E6P
	6L3ekMzPDcOgNiPCWQfPnLZdI4Q5uXvPGEMTTvAgJzucOW9fyG97qNxynV/0vJs=
X-Google-Smtp-Source: AGHT+IFb5pZiRryh8XOlF4yxef1+TZ6gsqsdlicLlJbuH1qywlPAizf8XrTQM65txWbBeiRaTDATFw==
X-Received: by 2002:a2e:9995:0:b0:2d6:abda:8d8d with SMTP id w21-20020a2e9995000000b002d6abda8d8dmr1746862lji.3.1711491985430;
        Tue, 26 Mar 2024 15:26:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id fi16-20020a056a00399000b006e795082439sm6460668pfb.25.2024.03.26.15.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:26:24 -0700 (PDT)
Message-ID: <586364af-9082-4b9f-b1fe-3ed75797d87d@suse.com>
Date: Wed, 27 Mar 2024 08:56:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs: btrfs_clear_delalloc_extent frees rsv
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <ce7db2df5f2f7617ac37f7c715a69e476acc7f1d.1711488980.git.boris@bur.io>
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
In-Reply-To: <ce7db2df5f2f7617ac37f7c715a69e476acc7f1d.1711488980.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 08:09, Boris Burkov 写道:
> Currently, this callsite only converts the reservation. We are marking
> it not delalloc, so I don't think it makes sense to keep the rsv around.
> This is a path where we are not sure to join a transaction, so it leads
> to incorrect free-ing during umount.
> 
> Helps with the pass rate of generic/269 and generic/475

I guess the problem of all these ENOSPC/hutdown test cases is their 
reproducibility.

Unlike regular fsstress which can be very reproducible with its seed, 
it's pretty hard to reproduce a situation where you hit a certain qgroup 
leak.

Maybe the qgroup rsv leak detection is a little too strict for aborted 
transactions?

Anyway, the patch itself looks fine.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2587a2e25e44..273adbb6b812 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2533,7 +2533,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
>   		 */
>   		if (bits & EXTENT_CLEAR_META_RESV &&
>   		    root != fs_info->tree_root)
> -			btrfs_delalloc_release_metadata(inode, len, false);
> +			btrfs_delalloc_release_metadata(inode, len, true);
>   
>   		/* For sanity tests. */
>   		if (btrfs_is_testing(fs_info))

