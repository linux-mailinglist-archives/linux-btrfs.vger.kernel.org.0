Return-Path: <linux-btrfs+bounces-17856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A306BE0CAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 23:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE78019C4C51
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90A2EDD7A;
	Wed, 15 Oct 2025 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b6e2PtTj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823622DC772
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563206; cv=none; b=e406WNULHmN2QibXB2Vx2ytkt1l5IJ2evCFoYX7YoiQjbTvBdkEqjbaQv1hYSb4JQKajXlEY5PxZ3mfrq+hMiOLNuGEfTAuGCC9KHEEneKK/hrjvOx2NLWitH8XwivpAYnvZG17NrqHSifQHZqRg5zTSLakUVHC1TocggNCMvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563206; c=relaxed/simple;
	bh=s06ivH4eiqP9s0T4/AVF1adOCqfpv3BAn7j+O3oLn/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uXOp1+7rFEdK8MT0HHhUOYPS/xEav8dnyVWFoQ/082O1j3XnWrDkqoV/iSa5dtFfcvyuZl6V1YOJ57r5qDkTrlzD08pixdzvUipcvWpSc9FzKKeBS+BuModb/aVzcrcZHyMn8boNS/r3CbiPEUstO++Pozez6piEZazi0vZL+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b6e2PtTj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so25203f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760563203; x=1761168003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/XK6QfLlPHHztpjX1fZNpuAM0duPIIaj16APBB3YJXE=;
        b=b6e2PtTjR1bwbiKUin/VvWZuRtXdpvGoX/G3Yvkss8gx9KYRxCdpORlkMely0A91pF
         ji+CejlgwtXVImpGF7kU4ETSOMOkKePnpjAyNZaAALqqttXNLkUwYB7Na+16lufECQD9
         2xbfmUVDuDr+VXyLgThGYgcGtsW9y1DzKCZBLyttu6aS8d3BRSaWQIZ/GUI4KiF3nz2c
         8elgiDufheafNDCxjoyZnJz06iH9CBkQ5lCo5D+9rJV6O5+0q48KYzz7ga5h0p2eMCI0
         mPlSb7VG0kVXQhK24Nhs3GWM3P7rUNCYd57fp8l1CFnRdfz6SFE6HpgBfDVoTWFk7Qqe
         toaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563203; x=1761168003;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XK6QfLlPHHztpjX1fZNpuAM0duPIIaj16APBB3YJXE=;
        b=bdhz6+aqwslHqpWaIFUYw2vIbKpOII8goafvp3mg0XXHE3KyG3PxQbHUuGLjj0pO5v
         9ermRar5AYIbUzxGT4Bg1zRxQv555DjX5L+3ItOoK0E6ytxSEq+5oFMsAwiyzVZ1y6mc
         gJpe40MkmTlYc/s5Gphuy9+oNKmCxul+pWuFLMzsLE5dooXAvbnLAcPlSKSB440R5+be
         YEZXeMnRHB6Tp+pt4C9So0SSUGtZWXEBiz20G0auNDU1oMM4ouVcnjA6KgiBMdWvnLSJ
         XCEwbyfg20Awe66xydr/BgWIDKbMbeJKTcmh4oyGb/ZEyYk72rqKKj904RGzNyvSvZDG
         I/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIEGda3HqqUfZA3H1GPfNaB8pr1H6DlLOthw/Q/8eXjWzqBoeZJ2/BmDL8TTJgymKzPELSb0W1gMKgsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzetcndl5QNlScG6QSRlKVJlbkQfaclkl9sr4Cx7FJlC11BOmgu
	l3lKx2LgUivt+82DQYYPmgwdrgJ7r9XYAzQzQwX3A0oIgBNT8rsDc5raBMuFm93yN/HMHqPAHtn
	RYSq+
X-Gm-Gg: ASbGncsAzQ7rhRhoLBQ3KHkqwBAAqGzX5CbtgpRUvAS5CEQUawHSiCL7XjUzIXe+2yB
	yBveyJGsg9jGP6nv6500Pokz3BQf0wJO25DLRbBP4rEkMrWvN+zoqLHsNIJQI71fJnLl9oNcgIo
	geE8cmdPajagnujDvjuqLTfnpVzg/Rheb/qae9ro22G8T49/StrwqswRTaS9ZV2nYAKx0394X6U
	egtZwJsAaufudSxZPQ8gojQMdeUOHQJZVMNDB9dHdjJUfu4PMldJ++I//2vsl8Aoo8iYvhmitN2
	MQPA8tPdXjgvGEnUSK0O7wIVlTD4I09KXjx4yvnQjYDdxwhuIH23jAy/ItV982j6H8qacaM5woH
	BaTMV9ODR9tB11cP2N6FsBg8T5g1wLYwZPwIQuveAPTYsRosN/KRKU9l9j8Fg7wETmzGsyVcH1T
	md9L+3L5/oFeayRieTQwcZN9krTkjn9w65o/EOtKc=
X-Google-Smtp-Source: AGHT+IHymfftZPxHzfdYKPf/uy6M1XaqNB1p9hLbhaWW7cdnfeN8iIZVIxvplvcv7w98YkOYPpNekQ==
X-Received: by 2002:a05:6000:2f83:b0:3ed:f690:a390 with SMTP id ffacd0b85a97d-4266e7d4413mr18678118f8f.40.1760563202645;
        Wed, 15 Oct 2025 14:20:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab9b0fsm5963965ad.84.2025.10.15.14.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 14:20:02 -0700 (PDT)
Message-ID: <255946fa-1f50-4193-b77b-1f9629f6d82f@suse.com>
Date: Thu, 16 Oct 2025 07:49:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: add and use helper macros to print keys
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760530704.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <cover.1760530704.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/15 22:51, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (2):
>    btrfs: add macros to facilitate printing of keys
>    btrfs: use the key format macros when printing keys
> 
>   fs/btrfs/backref.c      | 11 +++++------
>   fs/btrfs/ctree.c        | 17 +++++++----------
>   fs/btrfs/extent-tree.c  | 14 +++++++-------
>   fs/btrfs/fs.h           |  3 +++
>   fs/btrfs/inode.c        |  4 ++--
>   fs/btrfs/print-tree.c   | 14 ++++++--------
>   fs/btrfs/qgroup.c       |  6 ++----
>   fs/btrfs/relocation.c   |  4 ++--
>   fs/btrfs/root-tree.c    |  4 ++--
>   fs/btrfs/send.c         | 10 ++++------
>   fs/btrfs/tree-checker.c | 21 +++++++++------------
>   fs/btrfs/tree-log.c     | 38 ++++++++++++++++++--------------------
>   12 files changed, 67 insertions(+), 79 deletions(-)
> 


