Return-Path: <linux-btrfs+bounces-3565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F2D88B2EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA74300437
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D26EB52;
	Mon, 25 Mar 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bIstVrh7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD066D1A3
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402714; cv=none; b=LiNVMRO6WfUuoAGaT7mtq7mtIrnsHX8hL4N28CYAPvNiRwBx4Blir8TVyRWnM4OSw7IIlNR4I/HS/Vh/vbh45vYBCpUH/4g5DmfXSD1kKUXJ9pT6qz/xSup3dkOG7UD4vA5Ec2DKZJod3CPh1CPJpDj3Kuu5TnassOk1D3e945s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402714; c=relaxed/simple;
	bh=DNpWpe87xh9PabO35UylFPM8TG3wRvKmfmPxgf8a0pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mP36qFRHIiEkOBxUGUaj5V52TNioFYXbzqLsoA/Qcs8lo1RfV9qn60Sirvmey8wKaJcp8tHEmgRlNv3fLshGeV3dQnEGXKXFL0TGYiM5EpbJPnI/3dj2ala0i5xatPbb7zFHBb6c2/B6CyFHSjpbCMgV256G6H6WldTkhQBJZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bIstVrh7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d46c2e8dd7so61572691fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711402710; x=1712007510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pgYgvyhRdwdMcvIN63JIPNbc1Cxsib6eEKdDzyxJBTg=;
        b=bIstVrh7Qfta+aQJzZiGWVhda+QnKV7cFJ5gyMU/3DvHS7pqbeGOGN6+i10+hSI1xZ
         ePPxBZUu0wGHJAluKitXdulfMU2cy/AWdpYzoHKT68+5w20VphNgGNKLnucTF5zXq6rc
         4km/ZTKLSw8AMVqqIWQM1zI4AzmexQbSJT+HfQ3oT/B3C3iqMlnFXN9iE0kiLRjuEjGB
         kKaSPXNNsutaa44KM/gcLtsM3kXjO2+rX23x+9bfiFpdqY9rjSGs5b3ws1iYNptvzK9P
         ELlbbL8xaCXYuTOQieWslcBdo4Y68zxWv8GRJORNWCIaqDktCdc6/ocKvaVAFe5Kl5Nm
         LyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711402710; x=1712007510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgYgvyhRdwdMcvIN63JIPNbc1Cxsib6eEKdDzyxJBTg=;
        b=M63NtyMjE1mY3FW954U/HOAilH2cmNLgB8VpKfcdCYbeD1mIr6Oi48shD6KeiyV+rp
         O0dsLzs7lFjhtA8AAOsTSZUMDpFzlKS9quZOJVg5BxKtjxAwwJhB3IiZckWQYCu99oQX
         n1a9OZM57swp9zMGYPyzaWpb/BYV2LZuRZn1F/1+f5+URNzMJY6neBj/f37H/0sLUfc4
         TMM944xWSrLjyLnOo4AYT1xHiFyUlmcW6DYqUoLqZPh+FVg3mB4abgHyc92nq2oUOUHm
         JR6OMK//AFr9uCs0FNVdHn3tUj8nprlH/gKUWCQOD5so7sJ22Gz/OVzVbkUYax4F0P1F
         BU4g==
X-Forwarded-Encrypted: i=1; AJvYcCXNjqlnS7Uq8Lc2ji8JdF9WaY+YCCq3Z+YAHY9Rz2FtJS4Fgq4t1qti6k9I8au1QfZOmxWfvECU1Sbby3aNdplB6Tr+/KVbJZ+QbIc=
X-Gm-Message-State: AOJu0YxB7QjGwhs2sEtyfIMAbEFyUOp8ZR/rougYZKS8i+UneT7MLBhr
	zJU4T1sSmDfVHWf5H/JhYooYk1Rmwc4544XsJ2F6ATacI9yfuxyIoUqdbkElYfQ+hKetZhGLgKI
	d
X-Google-Smtp-Source: AGHT+IFn5RF2/HSEnA8tggv89Y+FEZuEpQqqyelK3n9a2EzMLHENGUbMNlWEZJyAY3sKAgQQGIn2Og==
X-Received: by 2002:a2e:2ac6:0:b0:2d2:a3bb:e319 with SMTP id q189-20020a2e2ac6000000b002d2a3bbe319mr5386131ljq.1.1711402710292;
        Mon, 25 Mar 2024 14:38:30 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id n1-20020aa79841000000b006e689b25e38sm4721510pfq.90.2024.03.25.14.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:38:29 -0700 (PDT)
Message-ID: <3a7d64b1-f8d9-4a8f-a795-39eaaed21ab4@suse.com>
Date: Tue, 26 Mar 2024 08:08:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fallback to single page allocation to avoid bulk
 allocation latency
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>
References: <9ec01e023cc34e5729dd4a86affd5158f87c7a83.1711311627.git.wqu@suse.com>
 <a4fa315e-294f-4649-9315-629648e15de3@dorminy.me>
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
In-Reply-To: <a4fa315e-294f-4649-9315-629648e15de3@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 07:48, Sweet Tea Dorminy 写道:
> 
> 
> On 3/24/24 16:20, Qu Wenruo wrote:
>> [BUG]
>> There is a recent report that when memory pressure is high (including
>> cached pages), btrfs can spend most of its time on memory allocation in
>> btrfs_alloc_page_array().
>>
>> [CAUSE]
>> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
>> even if the bulk allocation failed we still retry but with extra
>> memalloc_retry_wait().
>>
>> If the bulk alloc only returned one page a time, we would spend a lot of
>> time on the retry wait.
>>
>> [FIX]
>> Instead of always trying the same bulk allocation, fallback to single
>> page allocation if the initial bulk allocation attempt doesn't fill the
>> whole request.
> 
> 
> I still think the argument in 395cb57e85604 is reasonably compelling: 
> that it's polite and normative among filesystems to throw in a 
> retry_wait() between attempts to allocate, and I'm not sure why we're 
> seeing this performance impact where others seemingly don't.

The reporter is hitting this during compression, meanwhile no other 
major fs (until recent bcachefs?) supports compression.

Thus I guess we have a corner case where other fses don't?

> 
> But your change does a lot more than just cutting out the retry_wait(); 
> it only tries the bulk allocator once. Given the bulk allocator falls 
> back to the single-page allocator itself and can allocate multiple pages 
> on any given iteration, I think it's better to just cut out the 
> retry_wait() if we must, in hopes we can allocate more than one when 
> retrying?
> 
> Or, could we add in GFP_RETRY_MAYFAIL into the btrfs_alloc_page_array() 
> call in compression.c instead, so that page reclaim is started if the 
> initial alloc_pages_bulk_array() doesn't work out?

My question is, I don't have a good reference on why we should retry 
wait even for successful allocation.


In f2fs/ext4/XFS, the memalloc_retry_wait() is only called for page 
allocation failure (aka, no allocation is done at all), not after each 
bulk allocation unconditionally.

Thus I'm wondering if it's really a policy/common practice to do the 
wait for successful allocation at all.

In that case, I'm totally fine to only call retry wait if we are unable 
to allocate any page, other than unconditionally.

Thanks,
Qu

