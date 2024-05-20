Return-Path: <linux-btrfs+bounces-5099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B098C98E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 08:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF4F281A02
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E313171A4;
	Mon, 20 May 2024 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MrXdDd8s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8E18EA1
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716185068; cv=none; b=GlsonZM29BcyAxTJCFJmEVr2X+Nu9OHUM+YKWeA8wvrU4XagMqOarPGlJbHAICmUUy1DEuud7nZJbUtvJP4nGt0ZQcoQ2NxzcxJUNJuXOB+N+RfdN+1HVI72M3mErWT1yXQ53kFjX+uaaBO/ENGuGyt8IrydL7utmpnnorMYteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716185068; c=relaxed/simple;
	bh=L35S21I6EOL0wIhF+JvwKnmJ6JvyvauHJhTgX+dL/po=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EzCpcn81IxFsOW9mxyWei4oYbdMODFRVOO6wBWPeXGmUaXCMqnpb7tUMpNcPBvCy5r/9Xe80lIxkn9o1G1nCZppF44FG2o0W5lMLar4NZ3NTbQYeUKztepqj0MH6NeH6zgActXXC8tFt/w4LTTjlneKIPsuLqyHs061cKqtaJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MrXdDd8s; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e576057c06so29267601fa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716185064; x=1716789864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1vEFC63p7M7OH+mqrvOAcLgWp67Tv2RDimsxgXVjRU=;
        b=MrXdDd8smJy9fbcxsspr1Av3yidVLTro/Z8SP9PbJfMxuDgDqKP7WBvT0qN97Gg4nP
         Gf6j8Dt5RpswCdEhBjPwg1WvdCWLao2Iab7U4FS1TiwQEftowydbarqV9kQlawwqzLvQ
         kvdqZ29h6ccWPRH9fC9vmt9KB2Cbk5Uw8Xa0gllKVZFnelYR5yYWSZ5kEpFkrZIkl3MA
         90lUswjFejS4xnw5EVEnc+ZNeTgyzIAJRkI8hdAMtOZw95s18H2riGgNlTzDx5LPTmCc
         cccXykS0fwUwFB1QI1U8ksNIQqXT/uXqSJw3BMWLKYbjMzQB7kiOZ23epydPH+aRoFdA
         XeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716185064; x=1716789864;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1vEFC63p7M7OH+mqrvOAcLgWp67Tv2RDimsxgXVjRU=;
        b=BTBm+QD4leiaM/4S+4aaRaAovExuZWKXhMYh1z/uPTGhtPSEfPXvfXvKgHU9+m3hdk
         0/stlLj+aiDv4UQRWqYwniub/xBkiwok1cBZnKGzJTt7yvDcp3/B8HKq6KoAsNafHMv5
         FqljkhuTGGdnk3fPw/aRNKzhV0zkza3lRexjIIzZF/Iw/u7I7hoyuvIU8/XoVw+mIUs6
         nQpAb3lr5AVlpOOHVsJGHoY5SsdBF+o0XVGCRz87KXml3jglVkqTAJDNaaizhwM/wejZ
         GY4T4Pi49CIaRvwEC2O3aA6vNSQS8PaS0lL8kfc8R2UirlMeUxxXZ9Kx8QhyaRJryK0h
         LdZA==
X-Gm-Message-State: AOJu0YwZnljx9EIuKXq9mJSEqBixmVWOwNI0/WQ9gTndjK4PsE/h3tVl
	apzj2IVMD+cR1ooeyFOvmeKizkwXPi+SJqSKnL0LxLoB+EclKruHWJcXAz6rPl/d5GSmJP/txPj
	j
X-Google-Smtp-Source: AGHT+IGb2r8lcf1gXg8/0bLT3EPFFoY3QMdo50W76kmICun2PTDP/cRR79wHxrKp16ZRXbcEwGCZ8g==
X-Received: by 2002:a2e:91ce:0:b0:2df:1e3e:327f with SMTP id 38308e7fff4ca-2e52039bcb3mr190996281fa.38.1716185063827;
        Sun, 19 May 2024 23:04:23 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2ab5sm18419859b3a.155.2024.05.19.23.04.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 23:04:23 -0700 (PDT)
Message-ID: <d1e442ad-ca7d-46e6-a68b-34908d25b44e@suse.com>
Date: Mon, 20 May 2024 15:34:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not clear page dirty at
 extent_write_cache_pages()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <868d6dec9ccac2f7cb320668b5bf4d53887a4eb6.1716175411.git.wqu@suse.com>
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
In-Reply-To: <868d6dec9ccac2f7cb320668b5bf4d53887a4eb6.1716175411.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/20 13:00, Qu Wenruo 写道:
> [PROBLEM]
> Currently we call folio_clear_dirty_for_io() for the locked dirty folio
> inside extent_write_cache_pages().
> 
> However this call is not really subpage aware, it's from the older days
> where one page can only have one sector.
> 
> But with nowadays subpage support, we can have multiple sectors inside
> one page, thus if we clear the whole page dirty flag, it would make the
> subpage and page dirty flags desynchronize.
> 
> Thankfully this is not a big deal as our current subpage routine always
> call __extent_writepage_io() for all the subpage dirty ranges, thus it
> would ensure there is no subpage range dirty left.
> 
> [FIX]
> So here we just drop the folio_clear_dirty_for_io() call, and let
> __extent_writepage_io() and extent_clear_unlock_delalloc() (which is for
> compression path) to handle the dirty page and subapge clearing.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please drop the patch.

Weirdly with this one, generic/027 would hang on locking the page...

Thanks,
Qu
> ---
> This patch is independent from the subpage zoned fixes, thus it can be
> applied either before or after the subpage zoned fixes.
> ---
>   fs/btrfs/extent_io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7275bd919a3e..a8fc0fcfa69f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2231,8 +2231,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
>   				folio_wait_writeback(folio);
>   			}
>   
> -			if (folio_test_writeback(folio) ||
> -			    !folio_clear_dirty_for_io(folio)) {
> +			if (folio_test_writeback(folio)) {
>   				folio_unlock(folio);
>   				continue;
>   			}

