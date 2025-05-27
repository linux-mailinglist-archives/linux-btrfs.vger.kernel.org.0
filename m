Return-Path: <linux-btrfs+bounces-14263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E158AC5D23
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725584C053D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9E2110;
	Tue, 27 May 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y+qymA2j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB651F460B
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384864; cv=none; b=k5gvzqayHSq4/Q2lbxUwVHJC7MuPs+YvQfFcyFjKa41FtT0RBbaeuAL4F44GNDM9EueHNwr8npBk3x5gtWkPXrhV+NKEw0IpLWG3jq1/0uwSsJPdMZ0FOOV8Mj4zQ6RfU4aKRvkINAOMdjYm+NaxC25Er1Vw2RqOT/qVaOQSzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384864; c=relaxed/simple;
	bh=zd3L7e82mjYWEsgC98Bc/+Q0tYX0v2qGty+MxhVIt50=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sbLz7BcFLvHy4/lKWY0N1X0nMriNYrqpdr2Ng8pXAEHWe5O8ZU1fDFKAWpI3KCX4r3DL3v35LYo2vJggzR2E+MUZkGFgP1JvAb6/yUzEFXafrQeIdShRrlyPY2zFZOOevMSSgjvm+nAuWrkDNCzPwt5wGm9xxWtHeGmdDbGoTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y+qymA2j; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4dba2c767so192045f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748384860; x=1748989660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pAo5vK38R1gUCrJGwnhfCIQIAzhCtu7FeH3UEg/pH94=;
        b=Y+qymA2jO2+FRb9A/T2aoG+Dg9eH3Il1C6e8qPqhECfadIr/D6vvlFbpvNAheBdYYJ
         2VlWezP2Cwaqccp69nhQv+U6TufaLoA8KtGlPDEy4Rst018NarzYZ+qa5Wn4j91eU7mA
         YWvXJ4Rlz6u1cc9QuHzALQ9l91Ria8Q1HxlHzKs/RGTlRLQd6PXdQGrt8EgFPlFnt6tX
         43tVvDewQ7d7qg4Ces0YkDa2uBvEBZWzeCj6CLWj7zvlUkjKsUVoEP1f5vTj8KTDFotV
         3gC8V4Y2QwwAjjD7cEqMAEo3sTnB64GaSnHlkELlif63HXe7nl4oAACjwvtdGUZBFX6v
         w26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748384860; x=1748989660;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAo5vK38R1gUCrJGwnhfCIQIAzhCtu7FeH3UEg/pH94=;
        b=Xb8Cqrz6G4ays7BAwacVqcPg7OD0sUCfUiNrwDYf23S9B1z6NLVDGdJMNDnuYWX9GR
         Gi+f831+qZA4CWB43C/N052I9aXjjdvQz3h8+Wc5jMjAL7qfvWvIqpg3jpA0l8UXVR1/
         12gaa5eZyFul4XMgA9MuGtDGlIz4WLQjNZCLQ92P2ht281kYcvQRUkP5syxC0f9iT4ZE
         Koat5ftWlCm/h2St0OGbAcHfvBTSCuyRXEs8N2bwq3c184P4ClemqlSzJOOnUaraNM47
         Z5w/mmF/IAOK00hX8xIBA3n9NhbwbWJ2y+FjSF/IBjxIPVcPeqt1UvOBx+o8YlZq/Fc5
         mxXA==
X-Forwarded-Encrypted: i=1; AJvYcCUzoHyv6mCgFPCYTUjJcvF4CKfj5jsUqGeOvrGa/BwzquymliQtXQo5qKTq9QtRrccmBSdgzmZJ8lIzCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRXk4UkGKwMNaiYb/6iCDzVh2R+te11Mt1Ep3S+r7CaauqEeo
	JPpVpyPcrlsOA9xSrUuh+NlkZhV5pGf/qG7r2PnKjJMGxXP6Geoq8JC2U+ZvBOqQHcPDLdYvJXc
	uR9Z1
X-Gm-Gg: ASbGncsXIuNPGQgIs/9oUfVmG/6XG8vFhh+EpmdozAI6MNb1C7DlxKB0/v8p2YW2lX9
	G9OBNaigG+i95JkEvcRdKjfnG4c/oFV3IGnTI+pR0+JAFcXgt9Hef2BP+Az2PhxU8zAAzWMaCFb
	ByeChFuUimQsqNDU8GQ7mT329DZgGAkCVpt+sVy/WncN37jOiRmApV7JA3nJq4Dr+nvrMJH3D4L
	kW3XGsxBfYKCJ5DOaSwcAsaQiGR+1TFRqtNC5slGXxiw6fLALvU0LeM2wUopnhv1LKAmuyhyIFq
	MB+r8H2HHu3Du1EUHV8Gl9OUrCpCa9ooa6NqV8ZOAlU+Dk6Bfha/WDzpq2GTOkHkKcCdZZ0nrdp
	T8lo=
X-Google-Smtp-Source: AGHT+IF8ALSWIzdYdSWqpNGIjy5ygL6hvB0kfNKTaJrePbEr1JElTWSQb7ggDCSJ8v0Swr3XRzmUmA==
X-Received: by 2002:a05:6000:40cc:b0:3a4:cec5:b599 with SMTP id ffacd0b85a97d-3a4e5eac252mr2127163f8f.26.1748384859558;
        Tue, 27 May 2025 15:27:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7465e65feecsm94044b3a.37.2025.05.27.15.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 15:27:39 -0700 (PDT)
Message-ID: <a5232598-53cb-4c7a-ac26-17ef38f2d80a@suse.com>
Date: Wed, 28 May 2025 07:57:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: some cleanups for btrfs_copy_root()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747649462.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1747649462.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/19 20:12, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple simple cleanups, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (2):
>    btrfs: unfold transaction abort at btrfs_copy_root()
>    btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
> 
>   fs/btrfs/ctree.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 


