Return-Path: <linux-btrfs+bounces-19040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CEBC62152
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 03:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DA9F3499AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740FD236A73;
	Mon, 17 Nov 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I74iOzCV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AA1E3762
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763345941; cv=none; b=rs5JOnDR/dozEJJ9Y5nJZd5NYfp3B+jFitXg+wktQWePU/M7ZtMretvsnM2O9ogpTs/SBI/9reiw1dXjKbfbgPmTguNiyof+/kgMXX8cFFGy03xmR3p9UrEBrP8NzcFzQacdBtPfMEbuqaHzNL1ZDoFT2SfnbhBZmxm8Fpdeec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763345941; c=relaxed/simple;
	bh=eFQZorw9hLct4U9U70IOismjS9PMGKSFxHbJj12RCnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QJt9cer4PcU1CGF4IeIYPYbvHVL6cnF3Hme9W5Ojoc6PDKba+ni16MBF0iFfgDgCpmKeaKN2iPJQSQKg07/C4db2DfCCxRfDrSWknuwVaqy7AzPMRPSMmY3lOvXd/unFqiABUZxvqdZhsvs/TjR51gFS9Nzd/tJHxeTB6R91hUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I74iOzCV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775895d69cso20033465e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Nov 2025 18:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763345936; x=1763950736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5YG+48odt9/OvSpWrPBizyMcdE13jystmluSKta3n2g=;
        b=I74iOzCVQpi0xzCWmVLMhWJiJ0iy12+tk8qFhl1eCindwxR9GmRBoq1IeL899UvO48
         h1W1BMWrguSwj9hja1vVORSB0fyK9c3l2skX4XMLHMxIUM0ZtVuyfClOaaXbb/JPud0Q
         2GL2uUxA+YKaa3MAlpl4jiDYG9U+nYqIQgt554A5a5i2qlxoQzAfiaWRIUYtj6lL0kcE
         4yID3xXvy1VxGPd4DO3m4NfSLqHawuKLfefd7b0jgRhGnDkSo7SOmxcQVe62DhVttGDx
         RQTejOpWWklTXNt5ZdfrCcT55mKAdjK5WtF7WOjKtDv+xJsM/k3xDJ+U3yflnkhq9oxw
         NiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763345936; x=1763950736;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YG+48odt9/OvSpWrPBizyMcdE13jystmluSKta3n2g=;
        b=miBxsXeaPzQ47r06+HKZ0e54IU1NlbEiPUkWLuKxwZDk3AQ1LE0NuDDU93UTWHII2e
         F3vye+d27tdhp9c+ZoPqoql09TyNMc0oRn3LBJF+VEoiTOuRhIc2wcBIbCB2RzYBGP/x
         YYQ4FcBQ2meHKupzk4j7Gi1Ko+AteP+WXGlfHrahpzWkla+lWNVrYJt3TxlJQYhUSWo2
         Ucjl0MsiNyaVSa7yQXO8w5q620Xf7V1wdSgaIFZPRa8JjdwzpkPaGOJHZdua8ZZ/7lXg
         Mgw/h5rYDc1Rz2wn+cYdZFaISk6rGpwMkh5hXq22RPB9R5QEj6Ei8Rq8K1ni1SSiZtq4
         YNTg==
X-Forwarded-Encrypted: i=1; AJvYcCU0/CUnLPFzrOYuOuJ2ThTvVf2dl4DUC9Ox5+VWvgoop1PAlpgXUzuVaLyDJgwSh98llnaNpGcTuYS4yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiFoOj1NHXi1C8fzfeSSmFxLWrBxUvVznrYyccTBlJnMH3IoS
	LDLEY+Cdyj2PfEgwGDBX9aCb9G8xAIQz/VOy0FmiKyTCmFcHGOdnEVO7SA3Y52uozZ4=
X-Gm-Gg: ASbGnctoVRLBOVtbyZVzlCWeg34a9AG6LRgGm9B73TM/yWFcLjFRA7XTdnTzDLP+h3W
	Hr/4AX9J4rTkpHb+kHkXaWv6xZM/ZYFOWv78zHMCFeqNDf2MB+Rl1oxepfLVw8oJtYXJcF+vl8W
	5rFUbJFE+lQZjVUqxOKJGbcUUZ2wmIrMwF+mvxYZfQ0u2fvQQAhndxw72FWn/zm/zIIa+poVSpQ
	XFVNgxHemaZkdyVUZZxhAnJGXCLq8G4iCSLo8TEOh8Fx+yZT0otRq8iZ+ApYOxR6WU1Ae66Wtig
	gDbRUE95u+0XXnP0CgPfcYcrsHhBUPCCKknIOw5tlFa9yMk+JdOE5D/N3xSXBP8UAWSpVF6CB2s
	2d3yzNqLDvgbF4Gjxx57DBmAo0fJi1WUAfl53+94IU0L1j33IJIWMb4N3OfQxkqy+O0QziL8XeM
	tt26GnMoWgO+PAjHAwHgagPUPdMYF13V6TC8fr+Fk=
X-Google-Smtp-Source: AGHT+IGlpk8o3yUWhEH2SLvoFbGIFK9HKxTwDWpQDEQyliuANKKDpgj00InEK9QYdovYwH3WhrTwKQ==
X-Received: by 2002:a05:600c:8b42:b0:477:942:7521 with SMTP id 5b1f17b1804b1-4778fe683e1mr87358485e9.14.1763345936204;
        Sun, 16 Nov 2025 18:18:56 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aee8afsm11394027b3a.8.2025.11.16.18.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 18:18:55 -0800 (PST)
Message-ID: <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
Date: Mon, 17 Nov 2025 12:48:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: We have a space info key for a block group that doesn't exist
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
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
In-Reply-To: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/17 12:38, Christoph Anton Mitterer 写道:
> Hey.
> 
> With kernel 6.17.8-1 and progs 6.17.1, I suddenly got this on two
> filesystems:
> 
> # btrfs check /dev/mapper/data-b-1 ; echo $?
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/data-b-1
> UUID: 42cfffe9-a4fe-44dd-863a-6c02896ab7f3
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> We have a space info key for a block group that doesn't exist
> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 13074117332992 bytes used, error(s) found
> total csum bytes: 12754122916
> total tree bytes: 13895467008
> total fs tree bytes: 759627776
> total extent tree bytes: 103284736
> btree space waste bytes: 296939334
> file data blocks allocated: 20763397128192
>   referenced 18946684219392
> 1
> 
> # btrfs check /dev/mapper/data-b-3 ; echo $?
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/data-b-3
> UUID: 8e4d238c-0a69-4f0f-8f35-a16e3c220763
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> We have a space info key for a block group that doesn't exist
> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 13083770884096 bytes used, error(s) found
> total csum bytes: 12763657764
> total tree bytes: 13785333760
> total fs tree bytes: 671154176
> total extent tree bytes: 106496000
> btree space waste bytes: 244008214
> file data blocks allocated: 18338522918912
>   referenced 17654672998400
> 1
> 
> Don't think that error showed up on earlier versions of btrfs-progs.
> 
> Is it something to worry about or a false positive?

Nothing to worry about.

> Can it be fixed?

IIRC a mount time kernel fix has been proposed but no patch yet.

If you want the problem to be gone immediately, mount with 
"space_cache=v2,clear_cache" should handle it.

> Would you rather recommend to re-create the fs from scratch?

No. That's over-reacting.

Thanks,
Qu

> 
> 
> Thanks,
> Chris.
> 


