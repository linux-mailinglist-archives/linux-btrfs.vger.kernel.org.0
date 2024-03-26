Return-Path: <linux-btrfs+bounces-3637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302A388D094
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B01F61B21
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838813DB88;
	Tue, 26 Mar 2024 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L+pI6RhJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0013D8AF
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491164; cv=none; b=CKfaNkOjLBbybSEg5dnOtoDuU5DPU+axBUs/cLtrMHY80Ac8sEAzrl9nudZ9d8p8CqX5qEkh1j87xU0zK5yYAizlEmBgNP7TAqZWuLgxvYy2mYEEdyDR2EemPhJFPOVaJeB6B2EgWhi7GmTgq/vqPTogakfsG/p7RaBQpMMGCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491164; c=relaxed/simple;
	bh=Mec+Q1651SKpK0/MC9cLozmdt2texvmShcLcks34YGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AnHCt66jbzZj3a0nfVJdNJvXiZ6L2+gKyNu/1nN262dFQ1aPIZYafOhFGoT2D7CpbGCN4sp3S/DifRbX83ToRh2v0w2G1kQrgWfZLHtW76wy1UERV0aJky2nzkUBVv2br1LpDEuX8OZwN0EZUZVh/6UxJiBXA9I77D/lVr4IhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L+pI6RhJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so55467251fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711491160; x=1712095960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XVWsmDWSuIZUhIcY5WXdi3/AIp6b2U4+FTq/6NHOA9s=;
        b=L+pI6RhJLJLggfqV0LTGblq3CsF8/p7AVdmy36+jYDUhaglvneiSjWuuFQl8CjWZBV
         3xLgGiSESIwV6Nx2E8PljnLOFuAY5kNsjKFl0umce/Pjkd5xzdDMIzEfzBwXv1tU/okT
         Xdy5CapTDNJomf9OKF2W1JvSoj5zZW/PLsCsS7jv00dxgxWSWWTG/e+Z60cKc1wkpG48
         2oCdeFJ3uFymqDAY0+kBw86uu7HzmZdEYsOTuIQuS0GZ7/Q2/d9lDhT3FvdD2uFI1Ens
         xg4/oen/j4vk8cisBUowAyymGhibF91c1wO59DL9hxW9QPdeBqiDnge+oLYT4FjHnUlX
         cK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491160; x=1712095960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVWsmDWSuIZUhIcY5WXdi3/AIp6b2U4+FTq/6NHOA9s=;
        b=WGGSiiNVku7ShMUU0f+6YBPHNKee5iqR634+dXMaOo3ME29f+yaHfKaL6hTfIQCB2u
         uFyc5L27/3TH1R5azXfeRqUKsQfUDLjx+dA2qV1ouwmPlio35iXI/RR1/Kj/NgNsNMd+
         rbb45Z1vHFqn89+OFFaRx2xQW2axZrrgZS15Sdy7NEobwSVFatOdCyeW8q8h28+EhoGi
         +5weCuSYq0qNk7gfddoWOIJLXM3/z/SC1WhFEj0uOXkYkE8xTonPYfSUy/Keprvg79aC
         GpeajE7a2faeHpw0VwYYVEZlaURjCv3rgGnG80O1j5YMOcSiUyBQeU96fTMSZ98HpM79
         KaSg==
X-Forwarded-Encrypted: i=1; AJvYcCU7uH1cimjQ/CwXAEmAJaYVNS+WF3+lqGCDjYM49ud7vzuT2W2ayP8LJKLdSBsXm5eJBT5YWpq5WAe1pul1Fz3a+4ZRZuAdPrDPIbM=
X-Gm-Message-State: AOJu0YylbBcGCKyXTptbFdJOCGCa5Pc7J15YAozlYOGXMa/mP+89WYmA
	AK3pSTpSCIq9SsSnFCbyDeowpxtMCUFgs4JR0gV/JB6c7HZ0SPSARw99iVT+ClU=
X-Google-Smtp-Source: AGHT+IGwQGaJgkdOEi6NCnTwBtEdT6vrgMygMNtYPDW14pHqdvNjC/4hW+BJc+Gn5b5yyxOe75RPjg==
X-Received: by 2002:a05:651c:19aa:b0:2d6:d51f:5146 with SMTP id bx42-20020a05651c19aa00b002d6d51f5146mr680307ljb.49.1711491160176;
        Tue, 26 Mar 2024 15:12:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b001e0abeb8fb5sm6579710plr.271.2024.03.26.15.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:12:39 -0700 (PDT)
Message-ID: <e5b26756-9fee-414c-96bc-d92c9664d9b8@suse.com>
Date: Wed, 27 Mar 2024 08:42:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] btrfs: convert PREALLOC to PERTRANS after
 record_root_in_trans
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <acdebc0c8ca16f410a5d13487d1b9e69ae7240aa.1711488980.git.boris@bur.io>
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
In-Reply-To: <acdebc0c8ca16f410a5d13487d1b9e69ae7240aa.1711488980.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 08:09, Boris Burkov 写道:
> The transaction is only able to free PERTRANS reservations for a root
> once that root has been recorded with the TRANS tag on the roots radix
> tree. Therefore, until we are sure that this root will get tagged, it
> isn't safe to convert. Generally, this is not an issue as *some*
> transaction will likely tag the root before long and this reservation
> will get freed in that transaction, but technically it could stick
> around until unmount and result in a warning about leaked metadata
> reservation space.
> 
> This path is most exercised by running the generic/269 xfstest with
> CONFIG_BTRFS_DEBUG.
> 
> Fixes: a6496849671a ("btrfs: fix start transaction qgroup rsv double free")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/transaction.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index feffff91c6fe..1c449d1cea1b 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -745,14 +745,6 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>   		h->reloc_reserved = reloc_reserved;
>   	}
>   
> -	/*
> -	 * Now that we have found a transaction to be a part of, convert the
> -	 * qgroup reservation from prealloc to pertrans. A different transaction
> -	 * can't race in and free our pertrans out from under us.
> -	 */
> -	if (qgroup_reserved)
> -		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> -
>   got_it:
>   	if (!current->journal_info)
>   		current->journal_info = h;
> @@ -786,8 +778,15 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>   		 * not just freed.
>   		 */
>   		btrfs_end_transaction(h);
> -		return ERR_PTR(ret);
> +		goto reserve_fail;
>   	}
> +	/*
> +	 * Now that we have found a transaction to be a part of, convert the
> +	 * qgroup reservation from prealloc to pertrans. A different transaction
> +	 * can't race in and free our pertrans out from under us.
> +	 */
> +	if (qgroup_reserved)
> +		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
>   
>   	return h;
>   

