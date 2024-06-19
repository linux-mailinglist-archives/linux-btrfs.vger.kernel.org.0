Return-Path: <linux-btrfs+bounces-5811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD990E67F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 11:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E002B21A64
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A77E794;
	Wed, 19 Jun 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K38AlgRv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D647770F5
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787946; cv=none; b=On1KaQQC7ahmbEja63syYBdLUw64JdrgJX25kOt7Ae2HQEER6lIqO55mHjdMfCTk6LZUjTtzBL5D1H1Ttk3rr1szNUjG0CTo2T2YFRWhzt6OlmRpGXmBSj0GXllY+kjpt9kp6PgHhTjo1W0vuaZbAowQaZcRkxhEiGnQOEHBlqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787946; c=relaxed/simple;
	bh=4s6d69rq9GgdJkb8K8LvIsX1hEvI+H1adAYigTbzG1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o47ykdFN2t2v2KQanFkoqO9/plChzQachLqmzSkTZ30BFz5k0X/ZS7QdaVH1ogMwV+huNsEtOOrjJvXli5VFOW2+9KSsGXAxZjU5xFn8g82xseC0Rn+yBF0/lb7hw+6W5n75ZS3ilmCWosNZM3PGoQ6FLcYQiPH5pnshR4/2bHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K38AlgRv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so75818751fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718787942; x=1719392742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dcDv4kT5jGEsrtKZXKiseBpRsPQARxA+ktAnltpqyd0=;
        b=K38AlgRvIxv27VwtczFBNj00vTBoHaZ9Fx4mfYqLRvBdvFBAc7mcGBkShfEBUfvfzI
         qIbSzsIh32jZDDUcVRWquhElwGp2cy/2lyF1nFbnfPYpGL6muEf+InGky+1eJE9h0Qiv
         MIkUe0L9f6LXpBmoy+nd7vvhCdGnI6t95yPjLBrFc8bdiyl5fm7EkyjQT7imjdUhk3ET
         MYaFRfi5sMyKU4LfPXK331KJgEFMMVlDBxF0zc3CxME0L1QatObvqCJzoSH/xNFvW9MX
         hPnPsaHDCurpRHZUciHCjotZR4vVZeLIxOsHJmBNVkRUcnusjkie7lKq+ErAkXHA9H34
         jbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787942; x=1719392742;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcDv4kT5jGEsrtKZXKiseBpRsPQARxA+ktAnltpqyd0=;
        b=KMNyKslJsP3s4t2solhlJ/W1a8uRQ01xSogCojx98OAN/RY1JK5qzA1KAPAcXUWva/
         Vkj9F7UMd8e8LiRZxXuE5jjLG4xEZOFogp0YE8pou5vFjSZOvvMnNLqYdPk3JcdnQSdU
         P8TmbfvKe5in95LZI3HliUvbmCCwc0ER8aF+cVYU5Dn/xZJmRoKyzbF0h5T+yzkDoam3
         SDSg8zMv4eU+bakA8deSeuSY02BTdN9H6kloRmkYnMhPsnwZHtzbFYbyv4RgqTpkEVhx
         TO8EEZa1gzYGS9YqqC6QwODEfBvTALJbSm1SKM4mXqws1Gs0jzVHL6/tyK53sa2HCnXQ
         MvDg==
X-Forwarded-Encrypted: i=1; AJvYcCXsMdxR34ecVvcBIdrb2R7vcvzOm01alBQjq+7AE29LSvGISGTtuoNw5LYXEX30nX6AcPdMYpUgYzJL7m26m3C38mOWPVswf6+PnkE=
X-Gm-Message-State: AOJu0Ywb2T8qadL+bV67RlcCT42kVLwRF1syQAFzL+3Bave0pn9qxQ5H
	/gx8pzxvRryKdZY/wIXBd74hLckmykPScdwmN++eJqGyAhmzHGxtwrONFshv2+xqIibabnwqKZL
	7
X-Google-Smtp-Source: AGHT+IEMKT8YmvfrIT6hcDJ7RIpGCpmNH2eZJs/g6ddySa974PSZqmcO3q9UPtw50bT+flUB00uCwQ==
X-Received: by 2002:a2e:9450:0:b0:2eb:d4b0:6ed8 with SMTP id 38308e7fff4ca-2ec3cff2f03mr13005331fa.36.1718787942440;
        Wed, 19 Jun 2024 02:05:42 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb72555sm10244190b3a.181.2024.06.19.02.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:05:41 -0700 (PDT)
Message-ID: <40632d79-b5c0-4dc3-b775-1da89faf8973@suse.com>
Date: Wed, 19 Jun 2024 18:35:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: a few cleanups for update_ref_for_cow()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1718723053.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1718723053.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/19 00:44, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Detais in the change logs, trivial changes.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Filipe Manana (2):
>    btrfs: simplify setting the full backref flag at update_ref_for_cow()
>    btrfs: replace BUG_ON() with error handling at update_ref_for_cow()
> 
>   fs/btrfs/ctree.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 

