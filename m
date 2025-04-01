Return-Path: <linux-btrfs+bounces-12733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09DA783E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B9D16B9D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 21:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B56212FBF;
	Tue,  1 Apr 2025 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LhnUOvu4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615A1E9B39
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542461; cv=none; b=TyxrTirVa3oGs++vVh1MU+yQ9KjGIwhDWIj2O1LtPEkBJ4F2qMxhquc5aHk9Gz9C4ayPMJUEiJydTK++0biSd0YE9gx5UOSQ1pzB3D+dHSCGz601GJEu6eYWFi9cLRin4emXEC2EmD72yQEVR1QhltnF25ezEDXgv47WzEVzOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542461; c=relaxed/simple;
	bh=zT2elm5F5MJKEfNsXCsyr/5jS5QNq+0L18cNI6mGqKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YdyExctVYk1uPAKChEv835Xs5N11NEAT14kK5yuvbj4G12a7JZfDPde8DHlE/hLnIx4YTe7l4LfW0+VTF0xuOYzbpgkVdlvyjNy1mdcjbvLvlTiVIKRfHzja1U6r4yYBfRnZjE/sAhlOYZpoLXRRCzUJeYDL7jXahMxaUcxCjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LhnUOvu4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so39618175e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743542457; x=1744147257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hr1mMN2c7O8Vg90tK1noc/fGQ5iVTkJ7CfyWY/UpX0=;
        b=LhnUOvu4bWM3vINBnLwDTuOrgwfQ8iByI/5b9+ydNwPK/MWkJJSEH8HaIk6XU//tym
         9l2RNdpLRgyH5OrQHm0WVYZMuU4wbmquLjjQX1UaYTQ9WqcHLOnkrl16SnDAVO48LQ1O
         Tw1QTCyfNAfanC4ZGYj7GBf+d5KQUtX/Wq5RTgi1WbAL9f+stUApHHurSO2oErDCkrDC
         I8ajtxtgV3ZousWzVZUC5zOIUEjVEzfbguJ0gkSGPVWCqm0PLQ2E3uqrV3xTaTWxqVz8
         KVSNauMuj9bpnibnldgxNX+OhLN6IpUetfa0hRJwFWB6deP/3j9hZvoCqUkij+gV9u20
         1sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743542457; x=1744147257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hr1mMN2c7O8Vg90tK1noc/fGQ5iVTkJ7CfyWY/UpX0=;
        b=nEH5SRUKirXFsq921JB1kzFi6CqF3KPcIJzfuHCr1UH3HVUgCoJ6xlOeVPPGRrOMYX
         yEmQ7oEUw5SRsu6R2RBhLMf3jFnoa2pDjnm5tXPJv2c3P78v99EVuv5Y0amJLkwioWH+
         X32ZAnOnA67dNBvTi74mj7xmniH3kXyUwz1S292YbJSNqdAUjzNkuYCpqufJrcTyknBX
         Zt+Y51pUfxGPjo4mwAEI5IQSz7mvMZCYO3f1hYwTSC9lUjSwKqmcIS68Yy1t17cjySow
         Ihn9mr13ciNVqPv/QgbYAGCc/ZYwQu/pU9IaSS+WvhtQFx8g/gff350RwsUr0D/VW2tk
         lJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrt/aDRnhk1gayFf7wbvFOA+C5xx5QVbPajb/oWzLVDNCulwA5JiyPLMsgTgTp4Tots3zZ88V0uDLPlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwltfSAY+0gkjoW/X83hK246300KfLLPf/avKi37xPuyrjbFKeg
	hQvsOcA/KwPAF8QqADtvXqPFK4H0nEXk1WcJ0DrxfRmg7heYt/u5F92URF+o8f2L4M6Fdw52klC
	N
X-Gm-Gg: ASbGncui73oUfYvPbdggJ76Vq2b2bYtyIIQQgYpkRV1YrCKVslybqbE6cvIsSbR4LNY
	a+boH4lyoY2BteU0ridbLPJfCtKNAgvS0kwQuTwJrS/+JHPe322Exw9VNLOrwUXaZlWeYyBaRZ1
	uMujmSOBtm5myGXj29+GmGAwfLj+ZFikmaBqRTWiSWSSvWF5ftYvAdX/tgDzffi+7aNzS1PW2BA
	nx1PwHpTF/VVruesUvbSmNxD7THn9QpNbtC9XZyWJOLDJDhXAC6caz4FxQC2KH8Iz0FYOnrg7RX
	tzsbqDjApXSj3yD+rUYF0dwV4Esk1ppCE9reyP0KfkBI21tOIq7EM5tIbCHXpAChTVyJbGCKpxJ
	qavZ59YY=
X-Google-Smtp-Source: AGHT+IFkYsvPiRjr2kapO8Fwq2L+ULtO4ZlMhIrpl/TPJzhfWihG8Zwr0j1sL3/u+4zysW9XrpEzuA==
X-Received: by 2002:a05:6000:402b:b0:391:ab2:9e71 with SMTP id ffacd0b85a97d-39c2975188dmr46121f8f.20.1743542457115;
        Tue, 01 Apr 2025 14:20:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710636ddsm9376503b3a.88.2025.04.01.14.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 14:20:56 -0700 (PDT)
Message-ID: <1188e8e7-b507-438a-bfef-00766a43ca0c@suse.com>
Date: Wed, 2 Apr 2025 07:50:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: some trivial cleanups related to io trees
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1743508707.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1743508707.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/1 22:35, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some simple cleanups related to io trees that are very trivial and were
> initally part of a larger patchset. Details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (3):
>    btrfs: use clear_extent_bit() at try_release_extent_state()
>    btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
>    btrfs: simplify last record detection at test_range_bit_exists()
> 
>   fs/btrfs/extent-io-tree.c | 8 +++-----
>   fs/btrfs/extent_io.c      | 2 +-
>   fs/btrfs/volumes.c        | 7 +++----
>   3 files changed, 7 insertions(+), 10 deletions(-)
> 


