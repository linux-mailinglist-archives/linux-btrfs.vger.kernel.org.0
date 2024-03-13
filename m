Return-Path: <linux-btrfs+bounces-3263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435387B1C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 20:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AB91F23814
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF65A4C0;
	Wed, 13 Mar 2024 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NY/J1GVn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DD3FB1C
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357746; cv=none; b=kWtxh4Xy/+SbHhaI2bJYmV3PBCnCMaqywObndyW3jK2IJtGQIUlN09KyJy+pcgBdxMOmmJltN0meEWQv9RbWUyeFLrMZ832FRXEgJ/hAHqgc51zuZhJJsxvRZ53ut3Thq/q5ToUlZfBtbWssc/KReCjnqT7X1itrxQIM6UI0+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357746; c=relaxed/simple;
	bh=m3WcvbRIjqZHahxdlRT3brIISSV1jL/+IOhoaHQTepM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kzEsM7GsJZ1ILsuyipj+xaL1wNibGCpmCEudQ4u53heKDA4oFWX3OguHJ87LqtzHAuD9igFFIolIMRnr1u/2pYf464QnQaB68Kzop/h6dwrYWbrx7pemG2azjGIzrqRuy9LRAGvhLjUBj6oY6PEtp5SHiHCmONLtFJ4u1OPDxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NY/J1GVn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513173e8191so318279e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710357741; x=1710962541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tWJULjSfIXF5x8ANcEcqkhT2RuDMsClbiaEWXo1tKs=;
        b=NY/J1GVnGIoZr51g8tmW3LOWWcQM9Mwrqjh9EI/A6R3ICkARqSvjCpcl5Vy791TS8n
         LEtoWME8XfQ/b+fd9+AXufGUDpuJba1JQVT1JRv/p1Jtmje8o5c8NEGqKtE2FAD7l1Us
         HeySdGvs5Ca7cy6wBwQ26fK3Z6yiM7QJ55IgyVTrM6/2nNV8Q4OVmTBIAI2TCk4OJGay
         Y3KxaPOteuHVg3rf/nbOZ+CO6V8ZYTKpObJKNWIIQDEQlODLrmpk+0/HmuitQiSV+965
         dWnys5++ZBTJnIopkhpZUzwxYIUST7YM/bXRVGs1n7bH08CYoArhGmTpZVd6On74T4Sx
         0bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710357741; x=1710962541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tWJULjSfIXF5x8ANcEcqkhT2RuDMsClbiaEWXo1tKs=;
        b=gN6WvJLu0dkF1+XhvxMBuHCa1ObpNyS0cBx3kl11bxEfV5Raty5cSJWOJwglmaexWp
         EopoehU4UJnnfnsmF96mlA9Iu5ubk8WAtiMyH9CBkplBS7A/8jPuo041SJYxg7pnLvIh
         zsWFj5dVqVOiFjhsAnq03GnsqkPTDi9nX+K7FUTZbL/oLpT/te0Nl4EKXY8p2JYl4Ifo
         tvxz0NP+n52UvXb0JTOFpnpeFWRW5oK/hXigNrhhhICoh/t6pTIkJrZwjxDvAerN3F61
         y/cUp4iSOK+GyW3x8tnWJ71TTkZ3LBP6kz1zv0qYiLD6Uk33OxCgwWzZ3q/5ZIx6CcQy
         uh3w==
X-Forwarded-Encrypted: i=1; AJvYcCVDSiqaSKTlmbIqREggaDpdlRY1c5Eu/LaF9WorBQXw9V2ibV5Hc0/0ZyEi9/iukRgX8edNI1RBOAJIzO4wHX9mTeSsNTJAa76WIZQ=
X-Gm-Message-State: AOJu0Yy9Aaqqhi9ssK3hjJ9xRkP3zyWKwPB7U2CvsAKMRnV9T7qPXMrs
	Fq1vhQWVLIFV0i7OjQh3H7Gs8sGC+0/aWg75Eo37bOKJNJRpmOZUEfYt/7cBWj0=
X-Google-Smtp-Source: AGHT+IERXsX78ijHzNDMNVZLFoA0FqKJO5MswVD+MM6/5PKb8x1RwyqPb4rAfQL7jYRdfMSXDsz7UQ==
X-Received: by 2002:a05:651c:22a:b0:2d4:5788:a2ee with SMTP id z10-20020a05651c022a00b002d45788a2eemr2802432ljn.45.1710357741466;
        Wed, 13 Mar 2024 12:22:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001dca99546d2sm8993686plg.70.2024.03.13.12.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 12:22:21 -0700 (PDT)
Message-ID: <d2f6721b-0a28-45cf-a322-59a498e8c5a5@suse.com>
Date: Thu, 14 Mar 2024 05:52:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: some minor fixes around extent maps
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1710335452.git.fdmanana@suse.com>
 <cover.1710350741.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1710350741.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/14 03:58, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some minor fixes around extent maps for unexpected error cases.
> More details in the change logs.
> 
> V2: Added patch 4/4.
> 
> Filipe Manana (4):
>    btrfs: fix extent map leak in unexpected scenario at unpin_extent_cache()
>    btrfs: fix warning messages not printing interval at unpin_extent_range()
>    btrfs: fix message not properly printing interval when adding extent map
>    btrfs: use btrfs_warn() to log message at btrfs_add_extent_mapping()

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
>   fs/btrfs/extent_map.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 

