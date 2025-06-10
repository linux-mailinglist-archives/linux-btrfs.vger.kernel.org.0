Return-Path: <linux-btrfs+bounces-14592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C35AD471C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 01:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657FA16B85C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87398284B3A;
	Tue, 10 Jun 2025 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AbwqgY+F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C617E
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599826; cv=none; b=alGbD6ih+TRc8MyJcHWUjwTtcSQiR2/O1hFlcRRK4q1gsX2Fh9oF3Y5k2wkUjlcBv0O4c++sIcF522FipYWbaS7NXnlLeBsSaKIqOQD0gxnwg8aPXoW3dLOywbdTWPf9iDNGKLA1FTOEsavzHO4Ru40qQCRnUm1zlrV0qPHU9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599826; c=relaxed/simple;
	bh=AXImhIr9RJg9n9m1driuE7LXHbfVDSNe8CzsXym4T5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KlxTkJcQ0OZr3LTnQkZTQNYSGVhfDZ/lc37u2N++EjqrXDqY5VgPiNsmF9DFZFPqXj/DCQBbygtMp+5/UdhVxlaL9dSa8XVZdHw/ITVsbnC3kXxm/mCc5Qs6G3LZHv0+0hoX1SbCjfa5VH+qRGf/KNl/mten89N5PqMfD4ziooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AbwqgY+F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so2463565e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 16:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749599823; x=1750204623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m+sMmMz/pXPtiFMye14cQfpyRkUCdAmDIyNlNWxUe2s=;
        b=AbwqgY+FYRyDCpp0Vy69pQsZxOxsRS0H4omNC+k22LxE6PSKaH2zaeqz1rIUttusQW
         RESZWaVXyeAaH1v/pEZFChiMhLEyOdV7wS9BOLw4P7d8JjEhxqLNZi7xq9r0SRdNdAfS
         WqLrvq1QsXQwSvGsATvx3BkZQ7P2qThz/p3xIpSJ+z9NXLUlWN2XD6xBAkiCl/+3dnLt
         s6u9TmY9EujSkrkm+m6ojYaGnEYYQvgik5OMyDJvDjRxT6MCzshnDOnfZ7yYMF+XqDNZ
         /pTgm/jn/wYhl1E1q6x2JeqzuqUJ0K0HbiSOOQC7QoLhkAW+CmV/FuUKZCCzGSHFYFnq
         ofWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749599823; x=1750204623;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+sMmMz/pXPtiFMye14cQfpyRkUCdAmDIyNlNWxUe2s=;
        b=uHF7KL146bGJRreJ3rHO8SEjvbFCTaH8MlXsC6jHgABpCLxfNKLDSojOHdbnJvo47/
         iTPkdG2pnCraWLcu0vK29z1n7EGQ4osjwmmTNkx+Wv0zQiydmSsYVK2tRLt0b1Wug6pC
         PioZM7fIdAJJMCGVkHcR/XZ2FCFLyQZEf6cSBpFbOPzYevUq4ZwFLdRhdgsT6LA+ygiS
         LsrJUDfFhGx6S+2kqdnrw9dmaRABL7gqyBoUQBmj0jPDu7sVlHdDr0Zt8Y/iGLtXfDm+
         RM0857jthtvo1UAD4h9aOGjc2yo+sQfhKlO1vniOFt6gdgC08dZeIkrhFTYcEZ3AJT1Y
         nYMw==
X-Forwarded-Encrypted: i=1; AJvYcCV3mcu2oRkttgR+3Pk5aqLVGLSuTRnmhH0R/gDl99UCkspf4Jj5BmWsSa2uDOsblSYHxAvqtOhAuQZ7tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycMIz7GA862ETYOw685RTkYqWTITnxwBIim31MNGcoIKfIcM2G
	0mGhwKgLat0DMgFIsI51D4Il/t2+Esy0Bu/2NZ2l/JpXhoi/T6qRmAzKvoodKmIjL2E=
X-Gm-Gg: ASbGncsNSb/Ex+FX3HKUPrBS1VFgMtjFh4HULWQpn92bgSm9cuI7NRFu5pGyyQp9NpX
	kRxCgmaZyuikG4YUR5IDNDfidL5APLJU6qIdwf34m1ZnUkf0BYF5g/qlgD6SCNBEeIog7JeLSFD
	5cZFC9zBHLsKWdVoxVJmOsDAWAJMJAkpZZwyqCGhQM93M8M6UHJ90oQTttGhgOPh/Hk9rz1BPro
	e6G4tfv4VFUPUoxzhlLGI/JTNrAS444bzkMXp2wR8pUe03FIJXtI+1cOLvUchUM2aTXIniodO3z
	ktO4RgKnWqR/7QwEeWQS9zalr+bO7wtgL0avgpBjMoQKNfM1IvEIL6JQfX+8QlqENPT5vGtUKC7
	1FW9MOT/lJ7jSoQ==
X-Google-Smtp-Source: AGHT+IFhK7nAWNmeI61/pFuyQjnw8yD/D4JSWj+/916J6uXSafwYN0c2EzCq+95+OUyuc4h8CFVjgw==
X-Received: by 2002:a05:6000:2086:b0:3a3:598f:5a97 with SMTP id ffacd0b85a97d-3a5581d8c58mr948671f8f.9.1749599822446;
        Tue, 10 Jun 2025 16:57:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f782246sm7344018a12.51.2025.06.10.16.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 16:57:01 -0700 (PDT)
Message-ID: <7a58ebec-17e1-4070-a80d-3828f639c5f1@suse.com>
Date: Wed, 11 Jun 2025 09:26:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] btrfs: remap tree
To: Mark Harmstone <maharmstone@meta.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <dc9e87c5-03c2-47f0-b727-43c9e1d5c086@meta.com>
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
In-Reply-To: <dc9e87c5-03c2-47f0-b727-43c9e1d5c086@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/11 00:01, Mark Harmstone 写道:
> On 5/6/25 17:23, Mark Harmstone wrote:
>> * Some test failures: btrfs/156, btrfs/170, btrfs/226, btrfs/250
> 
> These all turned out to be spurious.
> 
> btrfs/226 is broken for me on the btrfs/for-next branch that I based
> these on (254ae2606b258a63b5063bed03bb4cf87a688502)

You may need to update fstests, as a recent kernel change requires 
nodatasum for NOWAIT.

And fstest commit 7e92cb991b0b ("fstests: btrfs/226: use nodatasum mount 
option to prevent false alerts") updated the test case to handle the 
kernel change.

> 
> btrfs/156, btrfs/170, and btrfs/250 all involve creating small
> filesystems, which are then ENOSPCing because of the extra REMAP chunk.

I do not have a good idea how to handle those cases.

E.g, the test case btrfs/156 is creating a 1G fs, although small it 
should still be fine for most cases.

If even a single 32MiB remap chunk is causing ENOSPC, it may indicate 
more ENOSPC in the real world.

Thanks,
Qu


