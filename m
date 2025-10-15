Return-Path: <linux-btrfs+bounces-17813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150ABDCA3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 07:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1459519A4D4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF9305E04;
	Wed, 15 Oct 2025 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D7KzmuvB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526A2FFDD3
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507243; cv=none; b=QsC0ULlZXd003zCCwC4d9xPM/RGkGMMWD/MboIRCtlVxaa0+LUGbp5AdI+NDEfmZE6ZF6R5vw2to4cOcjmN25KUKGnHkIgCkMIwoxKuGrEMqu+Ki7s6Cn6DzAcFFA+114bTMkSqvUVe1duQOlgdk0IRJdJEsePqMT+9uFOUoOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507243; c=relaxed/simple;
	bh=Ma7lFDbMiY8cXSbM9K4jwAjfFaic3KX+goW6lZonNxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QI+q0eJD0EEyJZ/imQ0X7O0gNKH0tJCA9TJ09peL4D/U3ZouLG3yDIyosoSxPLmuLuPKpJ9Ku6E8eKJXEjRR640CEVrZhRTPzSA1djhF5OVjFITtrbyglbuGQTO9ZlinlPk+sMbkkrveuk2ote9nfe8FA4GEe/z/MdpL8g+2LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D7KzmuvB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee12807d97so4491241f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760507237; x=1761112037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwIPlSTTpS0fuFdgu43lElmq0CyIMYG8ZpS7XRGRQhs=;
        b=D7KzmuvBuWlgUf/mNk61agSf8Ei4tyFV/qZxu6BxvgtvppI4EhroVGEEQEZeP3P3bL
         CudNP/e46PGKjP0+G5r3q7TxlrRPOCA6fI4k6Vs87fdknj1XFQmtkeP0uV8IxGgtJHx2
         8Mdk9OzQgZiZm6XbiVnNAwKGiT4QsqCNtngv1CKw+nohgHJvTrUnETwuTKhF8d/lyVcs
         +uvlfHSapner9t6Vk9Eu1FNoURIO4Yv7rB7gFyrzZ3+6FFW/a2l5k+LBniLU4L/FQcQi
         845yWn6YlyL5JfYqo6AaHfS1rouhlHofwGIxHSKKKoVrw26474y11ZdIyIZXG7WgRiTO
         MRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760507237; x=1761112037;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwIPlSTTpS0fuFdgu43lElmq0CyIMYG8ZpS7XRGRQhs=;
        b=Pjc9EBJCqs+xKcbFU5Fg6Ad/ydZfeOaWHSsH6A/P1aPuKf2g1fTFAJLUwXjganYaGf
         nL5JrAKLlP4KAf2tR1gAWxXFTJaqtdz4xYrRlJQI5QauxA5HU257Mv4xmUV4+BJJp0su
         vDfdDBMNgB3MY9PV4wHAcVe89yixZaFgTFJUoYj3Cq+t18c+tgyU7pppCltSmE/nCiiu
         dr6VQnT7wO1k6KNteI/87Y1APEeP1MzQbPBWGAjZVsN7LTTlz2ztMcH6+rI4Bs7RAg99
         c/faUBsycJxaC7A1EDXCz8322BDQPusCx7xZbaPzzPvjKDFdHWYutu4Kg6f0FSrz6kwq
         BDBg==
X-Forwarded-Encrypted: i=1; AJvYcCVEZa0g39XCRahWnn2m68E7rOYNqtFlz2OpjF5WcwjcHwFLOxr+RWXl6b5eeDTKUKyP9dOro7hnrrK2Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5F6uhysnqLfa5UUHd2QbdtIRDEYPqv+X2Tf8B9fpQ1rgAq/RE
	b6qE28604fYMR7qnseWXO9QiB/pJNjsUWNKZmP1l9Bu76VLPrwPJplI/X+TmIwSIv5D1GFC4p9P
	LfJ6V
X-Gm-Gg: ASbGnctC5YmFGUZwr0vNfigESmWQKpGCWIlglTowe2GZgXkKdmjdTMgc8fWpraPN/pM
	0G3V/wZIfuT3fOEflhTa04vUF9klLjhPg5QypGEzX+8qHVNHZkBr0IMfW96WtnZrHHH0/rawqG1
	ZxwyAAN4QSiLNT46Dg1ZIiVCQ4o2VnMWzrjIA8wkco3d66LOs7D9BoOW+pjn1+Vy3n+17SJrqxQ
	jllXm+T2gIPo8O8xxXSO16SZcB140k1NeKhwWK3lqz/dNx9X2+VMsCF94Rw2myAejddvT9mgDHH
	uEYFL0b36oc8hmy3YFEOt9daW+/wTBv0drqw8yglb2ckWq1FHsjaU24p2Oj/H7/yOuwhOd/aD/h
	KLZRqM3CP+K19XjXQzwxUsG05Fgqm2nx57C9GIX/RKrjWhu//GmdrYw7Te0+yN/R5h/rlPg==
X-Google-Smtp-Source: AGHT+IEkcvbrjRF8ByNZFEapjDm0EaOA3MvYyF2N8mJ4wQTA5m0aAYUQWhE342uB5wYaO6O6A2bTtg==
X-Received: by 2002:a5d:5c84:0:b0:3ee:1461:165f with SMTP id ffacd0b85a97d-4266e8f801amr16647520f8f.31.1760507236942;
        Tue, 14 Oct 2025 22:47:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0964c1sm16975310b3a.54.2025.10.14.22.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 22:47:16 -0700 (PDT)
Message-ID: <9194ad3f-183d-46e9-afc3-b52ab2bf28cb@suse.com>
Date: Wed, 15 Oct 2025 16:17:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setting owner and permissions of subvolumes in newly-created
 BTRFS filesystem
To: Demi Marie Obenour <demiobenour@gmail.com>, linux-btrfs@vger.kernel.org
References: <0ff47dc5-cf0d-4b5a-8d84-f309a74cbf32@gmail.com>
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
In-Reply-To: <0ff47dc5-cf0d-4b5a-8d84-f309a74cbf32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/15 16:13, Demi Marie Obenour 写道:
> I need to create a BTRFS filesystem where /home and /tmp are BTRFS
> subvolumes owned by root.  It's easy to create the subvolumes with
> --subvol and --rootdir, but they wind up being owned by the user that
> ran mkfs.btrfs, not by root.  I tried using fakeroot and it doesn't
> work, regardless of whether fakeroot and btrfs-progs come from Arch
> or Nixpkgs.
> 
> What is the best way to do this without needing root privileges?
> Nix builders don't have root access, and I don't know if they have
> access to user namespaces either.

Not familiar with namespace but I believe we can address it with some 
extra options like --pid-map and --gid-map options, so that we can map 
the user pid/gid to 0:0 in that case.

Thanks,
Qu

