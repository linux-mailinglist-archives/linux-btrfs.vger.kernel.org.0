Return-Path: <linux-btrfs+bounces-5681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4634905D7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 23:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F97F2818D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3E84FCC;
	Wed, 12 Jun 2024 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="giaziw18"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF057333
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226699; cv=none; b=Z3Xv4BpYu+7S0l8+0Tu83wFB/XZkQqES87irqGMh/XWM3hYxFKWNEMMycRZXBScSiUxc86kI/2s62F8LTolPXQmuQ87gGzPtYyVdVzjaa3UAigdjzaL14fLoz5HJOj/RHn4wpCaiuJI5kAuT44u1nPjdD50lAorKScpUz9DK5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226699; c=relaxed/simple;
	bh=SZNgK2A1kGP2+IRcvouHH7Ir9swHjZh0C2689pksX3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iar7WIr5gkeP6NQ2ZWERyr6pQcjyhR+4TGbiZGI05wrGdoxrGHcUCGH8JG0rYC9r4/0qTaKBSFiDmrGr3gvgeSZgYn/6sCQQsMtOYalEsQL9YeH1U7s6VCpwi4ziDnwCpyHUxDCRzUNsNoyf/3M+0a7FhRZhGFYkF7+gKSxVYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=giaziw18; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebed33cb67so2605651fa.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718226695; x=1718831495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AxCkTSrvggT94uM9fdqnozKvftQDsB5fk7xCkbF+fNs=;
        b=giaziw187qbTJdDNCuMxVW+Q9T9hZ/0cPxjEe4euZhqETkprFOGNt7Es+6/0hnfHIm
         Mwh1RR5dN9yxx2aqjbh0sV4HCVGdAepEktgz3vyzuC/ahLMomOm08gTFZjbA7PMQ+T+x
         baicNSGMCUWleARBNNdIFBuhrjCQ8h5tGQ9cRDTerwoqf1L63PfLJ6v4CTt33AcujXKp
         DrJepRqbRjE2JqEdFWzYMPWX0vU7FTcMbcNYyugQIuMIErt/wPokGbE9PSq3fW8uAhI+
         EitlEBWdlhFOePqZskYPC1eoYOO4bKNsTWN8rDv6pV+klMj/DijWbdnDqlerxYLF4aOB
         m5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226695; x=1718831495;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxCkTSrvggT94uM9fdqnozKvftQDsB5fk7xCkbF+fNs=;
        b=ol0Sq2CMJmSAdv8ELaEqXDC8efDAr9/4H7+YVBVSaOIayTDzRrvGYKwf/q3FPnVJ4D
         GswYcgSQQLTIQ96Z1aNCyag7F/gGv9VN7P+5WhYAgWbgAafBj5EMnAiKJm76/w3rlniL
         BY8ujbJ9NgD5fcs1SuIYvd8xY4gIto70982rfl3vSCjkJouzNaFilRQaMR1HlMuFhZCP
         fjQKM5/ECOabPn7e8Hex8Q6o4O3UPtEyvKOO+LTVjixJkgclnRCHA0UrKxw36l2ske2m
         retba9bNLuJwG113WP5Qwe25UCLyrLycqDqA036ZdkFWxqmbu1+J7RAhv/ybqSSDSxlj
         hl0g==
X-Gm-Message-State: AOJu0YwO5HYrDLsIuHK+AZebUcSak0GRn/+H0e0HR3RfVkLC2nSgTACy
	b68TVf0RtLg6h+phW0U5t7EJDpWw0wsZJV25hTDrP/MJ61GoUn8prE7h0pe3J1MAfr4KwwU463f
	o
X-Google-Smtp-Source: AGHT+IH01Io9Gdtkt6dEQ3u1G6BQ/FdQ0Bp3/2DpzFp9K7qdgFfrSOVK1erVcn88R8Kgu/NRd6AbCQ==
X-Received: by 2002:a05:651c:1989:b0:2ea:e3b4:d509 with SMTP id 38308e7fff4ca-2ebfc8ab322mr21630571fa.6.1718226695488;
        Wed, 12 Jun 2024 14:11:35 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc9696b5sm422b3a.66.2024.06.12.14.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 14:11:34 -0700 (PDT)
Message-ID: <2bd8bde3-2314-48fe-b828-6b02820766a1@suse.com>
Date: Thu, 13 Jun 2024 06:41:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] Revert "btrfs-progs: convert: add raid-stripe-tree
 to allowed features"
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <62b84fee8124d455689f8c2ab151eafb136a04d9.1718008470.git.wqu@suse.com>
 <20240612194803.GM18508@twin.jikos.cz>
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
In-Reply-To: <20240612194803.GM18508@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/13 05:18, David Sterba 写道:
> On Mon, Jun 10, 2024 at 06:05:10PM +0930, Qu Wenruo wrote:
>> This reverts commit 346a3819237b319985ad6042d6302f67b040a803.
>>
>> The RST feature (at least for now) is mostly for zoned devices to
>> support extra data profiles.
>>
>> Thus btrfs-convert is never designed to handle RST, because there is no
>> way an ext4/reiserfs can even be created on a zoned device, or it would
>> create the correct RST tree root at all
>>
>> Revert this unsupported feature to prevent false alerts.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This was included in the btrfs-convert unwritten extent patchset/pull
>> request but is not merged.
> 
> For the record, RST first use is for zoned device but will allso fix the
> raid56 problems once implemented.

*ONCE* implemented, while it's still hiding behind CONFIG_BTRFS_DEBUG.

> It can be used independently, I don't
> see a reason to remove it's support from convert. Any related test
> failures will be fixed separately.

Nope, I have already argued it again and again, only DEBUG kernel can 
even recognize the RST feature, while you still insists to enable it for 
regular mkfs.

I can not understand your eager to push such an experimental features to 
btrfs-progs meanwhile we have so many things to fix for RST.

Let me to be honest on this, I do not understand why you refuse to even 
move RST to experimental features, when no distro enables 
CONFIG_BTRFS_DEBUG by default.
Thus no 6.9 kernel can even mount a RST btrfs.

I think you're doing an immature decision on RST.

Thanks,
Qu

