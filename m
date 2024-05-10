Return-Path: <linux-btrfs+bounces-4906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1C8C2CCE
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 01:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F67A1F22884
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB0A171E4B;
	Fri, 10 May 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gINHt1eZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCC28F3
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715382278; cv=none; b=kk/CMTVVzoGOCc0cp6wP5uVj+j3xwAxcgQfGNdmrG0yBG08IjdVJpHLuz6NI7t7N4Y4Y2OS/MznR+0aTsv9fGW9AhwSjYcSQ5G4+z5H25T6EVrM7hHIf55y9K3Nb6vZXqF0sCmdJDEVWFIbrhOFlt0uwZyS28MWdn7vyj3Mmry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715382278; c=relaxed/simple;
	bh=z5rCc/aIzkqFsotWOWN/SURVxMkTkK/f1H04Bu4wrFI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fUa5/s53zLrMcSdq8iSMCHf8KhCs/x5gSQ9UtRQlMPOZIgMEJVy9CntwbCEYgTtjdJPWAUQ4b0WCtCOzOfQscRMMwvR4EtbB81yjUcgb7X4rw6bg8mM1gd1glnm1c3N5LKyDlSopo/lW3HLoDrO9XeG2iNbeMh/vNOLFuC3s6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gINHt1eZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so37287111fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715382274; x=1715987074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+xP81moS9Oj60n9vJ+/4pIr40pLyvsRq9LpJMwcx34=;
        b=gINHt1eZWkb3/Uuy+IRsdVD4BDUI6poNt92w+QoX2f6K4repWsJc5e8yRBCsgMBcB8
         0wHHBYPdp0pMOaIpF2q24gHglYUSl4ZZoHPDVpKAkmq2WfezSHNki1qT97XmpuBjIQ1D
         01uF/gfXpe05n+3MJ1b8/aPZPnIrB76e0PeGN0qCYs4Kn+/env9KYdaMAuHN0UHl5zIY
         6ZcaIEyLQW+m5SzG15Beepqm5MrrAbi/YsN7hTRVvPdLf8EqMzt0IqMY5Q449S9XjvqJ
         omf7r+fV6XwBDWVcAP5OAzGRDX9wKUR/ZZwxDajM/mQp6RaHXqs6dgmhcC2xvYWAv0lq
         pzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715382274; x=1715987074;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+xP81moS9Oj60n9vJ+/4pIr40pLyvsRq9LpJMwcx34=;
        b=kEWwg375jyhYH62Jgb/KG/4YIOPpzhTjULE02+y3q9q3DYFY625xG7Hir0bAeurYUa
         R8Mr7a1w79uCBljUlQNTT4WZcRr92IQKzuSzqnt9W+X58ke3r4wudD5puxmUmOhwBu3l
         FXiPn0Ux/o5cqNnuLtDXW+8W23DC4Mi6oH7iM+Zp/S2dFyTIn0MzQg4nOk2X9Kor51KY
         w29cwSls00clV80WfeH/dASq+TjMIMgTVhgEyKt2QA06hDiwr0zLypDilNI1RNlCOl1C
         zVqPGk82ggQ4woLFrK5efJyoYKQKCP4XXaG5Al+wwvMTEsBrDFzXRJ5J6o9RyxORsU8b
         s8lA==
X-Gm-Message-State: AOJu0Yx+Y2509UOGFHIAVRWAQDEFOE8BDAxvYKCNl+YYcHv6+vdo4B/R
	m+Lw/xiN0osWW/We4ObM25hgKEU6YfkrSpmyxt3HMqzMTj1L0EJA5DBhSe2crj8W+SOq/tHaegP
	U
X-Google-Smtp-Source: AGHT+IEOjYOiRkLDJCM9You9gnlT6BRQiMPYi/aCy9ZmwYWx1ucaNILv7AtcfgcKBqnlu3jQh3NoSg==
X-Received: by 2002:a2e:8096:0:b0:2dd:d3a0:e096 with SMTP id 38308e7fff4ca-2e52005f693mr31500701fa.31.1715382273625;
        Fri, 10 May 2024 16:04:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449f4csm3592702a12.4.2024.05.10.16.04.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 16:04:33 -0700 (PDT)
Message-ID: <b3315737-894a-4de3-8979-28ce2ee698f8@suse.com>
Date: Sat, 11 May 2024 08:34:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] btrfs: fix data corruption/rsv leak in subpage
 zoned cases
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1709781158.git.wqu@suse.com>
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
In-Reply-To: <cover.1709781158.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/7 13:46, Qu Wenruo 写道:
> [CHANGELOG]
> v3:
> - Use the minimal fsstress workload with trace_printk() output to
>    explain the bug better
> 
> v2:
> - Update the commit message for the first patch
>    As there is something wrong with the ASCII art of the memory layout.
> 
> [REPO]
> https://github.com/adam900710/linux/tree/subpage_delalloc

Wait, it looks like there are more preparation patches not yet merged.

I'll rebase with all needed patches in one go.
Otherwise it looks like it's causing a lot of more problems reviewing.

Thanks,
Qu
> 
> The repo includes the subpage delalloc rework, or subpage zoned won't
> work at all.
> 
> 
> Although my previous subpage delalloc rework fixes quite a lot of
> crashes of subpage + zoned support, it's still pretty easy to cause rsv
> leak using single thread fsstress.
> 
> It turns out that, it's not a simple problem of some rsv leak, but
> certain dirty data ranges never got written back and just skipped with
> its dirty flags cleared, no wonder that would lead to rsv leak.
> 
> The root cause is again in the extent_write_locked_range() function
> doing weird subpage incompatible behaviors, especially when it clears
> the page dirty flag for the whole page, causing __extent_writepage_io()
> unable to locate further dirty ranges to be submitted.
> 
> The first patch would solve the problem, meanwhile for the 2nd patch
> it's a cleanup, as we will never hit the error for current subpage +
> zoned cases.
> 
> Qu Wenruo (2):
>    btrfs: do not clear page dirty inside extent_write_locked_range()
>    btrfs: make extent_write_locked_range() to handle subpage writeback
>      correctly
> 
>   fs/btrfs/extent_io.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

