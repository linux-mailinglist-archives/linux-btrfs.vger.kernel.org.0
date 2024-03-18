Return-Path: <linux-btrfs+bounces-3367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE887F0BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 21:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C375284146
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1C58AC2;
	Mon, 18 Mar 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cg04y0Tj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46A57870
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792139; cv=none; b=o51+8OFs3V8JZXG9PKzHdaN+u9XAp/u5R2yHKol5BFwwmizwLm+DXk+Nq9QlYhKkptbFQ/oJSAoIPl1witRoj74eflIfR4RS027rEzZ8qwuB9eVdGMeFHEVaiuaggU2ITzkZ6WCpQCdhhvA6lxR6wQjOPFRJNawR02Q7+nAOblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792139; c=relaxed/simple;
	bh=obUAucjwcvZL2wfSPP2B1l+zPFj7a/nU9kyHNyekWRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJrx4fsUnDXE8AMsOS628YoWOZCDW4+khmAjhz3mthADTlSEk5hePh83QtFbgTeySfXGVHwquYV9cCoGqQDK1LDRqW/aV8WIYVJYbaKnFAttClFobY4Gr7Xo1MZ0u0tNYmt4koqFDnySExYtlEJW/38w/unfYykAmmmAg8NsEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cg04y0Tj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4698f4936so68891251fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710792135; x=1711396935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdyLyM543Arky9D0r7XdnpKK1UtLEtCNMuvZdX4gd98=;
        b=cg04y0TjbJEVXu20ubVcB3e/p6bZSD7sZG0ZUlieYs0MxxTFXtEjfLZcZYiSzbksz5
         WTxXGSHNcCr+wNdnmS3UdeF0mfViKCo0gGfrs+s7v7NIvaXdf+MKdzG8+5F2JxqyTs3t
         2DG4L2LJXqUK+TrmI1gNxEvDDnLxRVtFRUnzJeKkotM9OZAXro1C4M48Kmff3nZ4GshI
         Sw2rLodUeZBaJl+hBnWa03h+VaWR5tBlaHnuZtMdzA6ykxk+llnq3c7+xG+KLTwymc/X
         vn9CDjf1zvx8wcaelnJp48bS9fmqEuTyTIygx2nVCpaPnGx7p1x9q2Hrjzy1r3WkfSH/
         mBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792135; x=1711396935;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdyLyM543Arky9D0r7XdnpKK1UtLEtCNMuvZdX4gd98=;
        b=ke4ofTkkMuaGnHiHgoVLjhiiHGfRon1sFRyA1gCXUOgWjt7g5bzsMPBkanT0DiSSMk
         R8AVSjCLX3xBWEP4VB8ZNAXCI/9z5OjZA69Gps+chQSU/voheUplVxjW21uGOY13nJ2W
         WZrCoze9jYqMsPlhHCalgjOanmj6/VcqXQZNJJIA4dXZL1jd8RNaBKUrVwj3KveBVCOi
         95C1FosMISyQbqqvVCocudXNsTuFrxwE7oISLh148bc/Owkskdp4IxCeOsHNaqQW/ZdY
         BZc4Cu2VkdnAS+0Lp+xDy+e809KU5w4+v34DEmhDgJSr2O6aj46MX3inAYH7PizpmHPQ
         IwOg==
X-Forwarded-Encrypted: i=1; AJvYcCUX6TOd+Uvl61zaChJsCKOTsIxbJk5Ye/dGVjMkElTnJzgk7psuQr92/lABrti6/bgwkkquOPyulZ94rkKBN18XrjAiNKPwS+/qouI=
X-Gm-Message-State: AOJu0YyQ/55Fyna+9X1/dz1MYDcMSojD7n1HWiXRIyVT+xZ/DNNGm+iP
	ol6rg3PhrymrQ0dNGx8EYJLSEWz5iTgCFdPz3OiN0M3tUAUSpHL5JTVxDT/+XbA=
X-Google-Smtp-Source: AGHT+IFDQuJqjRSZlsdKtJkXMcjShwFZq0SA0ybWKP8ic73opV47zBkZwoVit9M8FtabNk5ctw+fmA==
X-Received: by 2002:a05:651c:1025:b0:2d4:7264:c5c6 with SMTP id w5-20020a05651c102500b002d47264c5c6mr7871581ljm.51.1710792135521;
        Mon, 18 Mar 2024 13:02:15 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001db37fd26bcsm3595673plf.116.2024.03.18.13.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 13:02:14 -0700 (PDT)
Message-ID: <99dba217-ba1b-424c-8d04-5b3f1ef78d5f@suse.com>
Date: Tue, 19 Mar 2024 06:32:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: WARN if EXTENT_BUFFER_UPTODATE is set while
 reading
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>, linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
References: <cover.1710769876.git.tavianator@tavianator.com>
 <d4a055317bdb8ecbd7e6d9bdb5ebb074fa93f7f8.1710769876.git.tavianator@tavianator.com>
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
In-Reply-To: <d4a055317bdb8ecbd7e6d9bdb5ebb074fa93f7f8.1710769876.git.tavianator@tavianator.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/19 00:26, Tavian Barnes 写道:
> We recently tracked down a race condition that triggered a read for an
> extent buffer with EXTENT_BUFFER_UPTODATE already set.  While this read
> was in progress, other concurrent readers would see the UPTODATE bit and
> return early as if the read was already complete, making accesses to the
> extent buffer conflict with the read operation that was overwriting it.
> 
> Add a WARN_ON() to end_bbio_meta_read() for this situation to make
> similar races easier to spot in the future.
> 
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 46173dcfde4f..0024ea20bfc4 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4285,6 +4285,13 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
>   	struct folio_iter fi;
>   	u32 bio_offset = 0;
>   
> +	/*
> +	 * If the extent buffer is marked UPTODATE before the read operation
> +	 * completes, other calls to read_extent_buffer_pages() will return
> +	 * early without waiting for the read to finish, causing data races.
> +	 */
> +	WARN_ON(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags));
> +
>   	eb->read_mirror = bbio->mirror_num;
>   
>   	if (uptodate &&

