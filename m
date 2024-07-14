Return-Path: <linux-btrfs+bounces-6446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F2930BED
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 00:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CDD281C0D
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACF13BAE4;
	Sun, 14 Jul 2024 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e1LdE7kW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D08495
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720994983; cv=none; b=WmrHiP370ki3hBFpfEdafCa2SHWF/2AJK6P893vEyUiPxF+SRtx8h82yfa66dWYTv6fzgZcrgJq27P4SMOY7hx57GpUZ78iaj3+YvkyfBBULfwzJdtVFTJ+ay2PgSDVF2Ipg7sw3wFwawNmYzGJVOlVTfNu0uhhXZUkybliSKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720994983; c=relaxed/simple;
	bh=8OZbHj2CJkDC78QCJSTzdU/F7BZKUJ/yGSRlvKJo5c0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=n/YuPxaER8Huaflxl8ex60U3BTRiRFIhHHYixedvMaZd68h+AlGOInAPi/OfxhgzAjLD5oApwvjIfqu3G+672LcxpRT+h8cjJyPFrx8CYD+IzdUfVONVq/RLUx+UFcxt9ERa+GXfuYknmFiTtw6LI04Hp0+a1KqR9IwMizhaM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e1LdE7kW; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso38241981fa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720994979; x=1721599779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dooBS+TWbQqQHSvejqX2Tgi0ucDZQh/brIsSaNBbZGo=;
        b=e1LdE7kWDSQRv+FgCSVGy6H5mygmuKoFYKDC0dqJtO6PyUFYe8suUrlcpvI3ev2Qwo
         pFMjeysQkDUBUwcJigxvLNRNrJBkFi5yku2FJtjza6/FoCPh6hTvofXULXbRko1yI6Om
         vRV4CLrD45XkU21tj9sj7nysTr9efYxUSNlIAuUwUW1jnv9q05HBx6uaDDp6SlZBMgBk
         pefbcl+nAP3IrOCwXwzEcUlC1KTwlaf2OYZlFpv9mamdn02tK3gXAVONPsckBNiLt6KY
         TcJWwDFWAdn9l87vKxJzPtYPZvutC8XhPZP0+pM8oM3aWE2O9mEH51qmUeZmxRNCVARs
         z2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720994979; x=1721599779;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dooBS+TWbQqQHSvejqX2Tgi0ucDZQh/brIsSaNBbZGo=;
        b=LkLn3eRzeZhV85kmdF+JYG4DMnQLIKfdOAjez+Bddy/mNZG8F93yw62c66nofCMvOP
         8ql3OX+LO+LRDgh6CBiWqY5i3fJy9CB8eQ/QO+wsA8Z49MpXikGVSPJSXlK3WquJQPRQ
         uayB+vChe+NTjewpHQh+q55r2OJTkmA4mI8mq7JfXrxUKOVroEIl2v33sjcHZ3mQWALj
         2YQSZT2YYeiTEekoNNzEp92iG1elch+UcC07fXR2U+Fy10daqWJyTnS4BZKNKJhjAODC
         Y1RapPHQFRcgjEpuJhRCur/yVQ/c96c8yUho30jroX4wq6MxOoAPObpO2ObeZE5Rxzla
         K68A==
X-Gm-Message-State: AOJu0YwqWwppZxlWdeuYzbF5uFgAjMzwO97ojyXNDRcvh2V9+E9b8fJA
	FV9/3WhtEFPLR0DCvGg/f4FoKzh49J/n3AGi8hmRj78wy8vupmPWIVJto/PI8CaewkBq+oZQZyK
	6
X-Google-Smtp-Source: AGHT+IGmDMvwxihdKWiz+wQruDSC+7O070hT5kx/6lNdvw7wkeiks6LJpZcUCKhWSXoxOXLmu6Awrg==
X-Received: by 2002:a2e:a582:0:b0:2ee:8b92:952f with SMTP id 38308e7fff4ca-2eeb304ea94mr154520061fa.0.1720994977995;
        Sun, 14 Jul 2024 15:09:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e33cb6104sm2337508a12.35.2024.07.14.15.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 15:09:37 -0700 (PDT)
Message-ID: <b92f8d33-ff5d-4aa1-93a8-97f26f466320@suse.com>
Date: Mon, 15 Jul 2024 07:39:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs-progs: fix the filename sanitization of
 btrfs-image
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1720415116.git.wqu@suse.com>
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
In-Reply-To: <cover.1720415116.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping?

Any update on this?

Thanks,
Qu

在 2024/7/8 14:44, Qu Wenruo 写道:
> There are several bugs in btrfs-image filename sanitization:
> 
> - Ensured kernel path resolution bug
>    Since during path resolution btrfs uses hash to find the child inode,
>    with garbage filled DIR_ITEMs, it's definitely unable to properly
>    resolve the path.
> 
>    A warning is added to the man page by the first patch.
> 
> - Only the last item got properly sanitized
>    All the remaining INODE_REF/DIR_INDEX/DIR_ITEM are not sanitized at
>    all.
> 
>    This is fixed by the second patch.
> 
> - Sanitized filename contains non-ASCII chars
>    This is fixed by the third patch.
> 
> 
> Finally a new test case is introduced to verify the filename
> sanitization behavior of btrfs-image.
> 
> Qu Wenruo (4):
>    btrfs-progs: add warning for -s option of btrfs-image
>    btrfs-progs: image: fix the bug that filename sanitization not working
>    btrfs-progs: fix rand_range()
>    btrfs-progs: misc-tests: add a test case for filename sanitization
> 
>   Documentation/btrfs-image.rst               | 17 ++++++-----
>   common/utils.c                              | 10 +++----
>   image/sanitize.c                            |  8 ++++-
>   tests/misc-tests/065-image-filename/test.sh | 33 +++++++++++++++++++++
>   4 files changed, 55 insertions(+), 13 deletions(-)
>   create mode 100755 tests/misc-tests/065-image-filename/test.sh
> 
> --
> 2.45.2
> 
> 

