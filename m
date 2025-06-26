Return-Path: <linux-btrfs+bounces-14980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2020AE98B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BC618882A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A1729AB13;
	Thu, 26 Jun 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bYwjv9VK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA982676CD
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927263; cv=none; b=mwAZvnGUB4Tn8xCE/B6l5XAjJ+7ChNJwrKYhfD7Mh+ekBzYtI9iPb/MIPzARz0ZK6A3kOUlOBlh7MCkt13mdfkqK39bMfT4sJ2FE3PjNr+9FNQNrfz2om4i0io/cs3uCNryMNTzvxlTUMs5jKbzCJQFIN9ViGDdm2rPny3g6RjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927263; c=relaxed/simple;
	bh=CEOLxKnBSHxdNK/8E/hZDZadpr6VDDrPkQ3LThRniAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eS1enZ+67QJD5Sb7fRQYMpcqgNw8KHl42XPr94q10nopfXpY1dw6fJAmtGXRHTzBkNZJCE1BInA0JfZo+v2ZbA0+0licRHy0P0TeonqZn96OQCrnpq+j8MjcLEjfAOk87WqzgsbYYWqkdzwxknxwGTvc1kiGLyVis43Ic6XzQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bYwjv9VK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso524009f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750927259; x=1751532059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mqydyuV2L+c1cc3gUPzPyIMoiV1f+E/9GxzbGWjpkkQ=;
        b=bYwjv9VK8SbHRY5c1pQpiLIr4DGEgt6O3u1rG4ZrGr7Rw+aNk+aACztjBt4EfYX9Js
         +7Gvnm/ID+a5JBZF5DVYEZJEYGLYSH3x0Wtm1DHpxj5We9H9bmGSpPrjk70kKQAh3YS6
         p6fsvGJxs1ILh1Vpp5/MnBOaiAD8/UWO1aVrADmz3cXp4Mjt1sdr7Y1PB8YbRrXPiIHs
         kNObQJdM3U9X0FVKbx+io8Vkf04/v2lfscVolZ3ol2aueb8DT1Lah+U8rJbshMSXsAVC
         IyCraL03wGWgfzRHkkCX8TNcwlxAtAKS7n1j/IpNsxxzDXNFp9+GW40q0JAz9kwmGA1p
         0ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927259; x=1751532059;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqydyuV2L+c1cc3gUPzPyIMoiV1f+E/9GxzbGWjpkkQ=;
        b=InGs+zp4YfeDE+KQYnczF9bnG80mDs1BjIBCE5Xp+LRID9ewS/idVUOAGV7kgC+Jzx
         I8NNsjp8lPFYP+puo8OZle6wfNBM4E/0YXBY5G6zfMrvoWn/KcNECHL5/6zj+uc3U8pO
         rAyXMIBLkgv0Sk+qgeJ+OwPzLU9CaR6onnebh1VdqrAH+6I8MkK31C7WLQJPTk5idvjX
         lYls7XRf9VwSqy1jRanjJmDeCJ2sSx2xslNM5WJC/RZy5spFm5y5z+t8S8Qi9maQ5NWe
         uRnrApyckWstB7NoKlngP+ulphsELObiRDmdA45meaZgTi87NhmeqhpOaiZo/VLcBp1i
         76zw==
X-Forwarded-Encrypted: i=1; AJvYcCUu1gGF84XjC97UPFnmmfBv4l6LkUd2j6rAQV8u/N2+5ER2r7Nk/KLMsYAwFaSliVSLmKy3NMlP6C9Yvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOVU6VEOrAkNvxYsNZ2Q3AHq6hSGmhm9uQmDldl2deEI2vvQ4
	GNpkv4ERAJV65B1haNIoXUbvtoB9595QLVWYAFUZcdZVm5cxRqTjWltY23a6E94WVCs=
X-Gm-Gg: ASbGncv45iF6iyjH1ehnH0rpgHKDdWJ16wWsFM32UiEareoGCKCyJypU317PAoGX10M
	PuuH6vk3iO/1+k9Ej/8sCl9a4//Il1srYFEP2VWxSUUcmsjcSFXBifaSheh8ChOGNg/zVwcZO8C
	cD7vfBxiXsKSlNKTqNt9gOWaeivGduyiPjjsA9EbCjTBW9bfPYRYS5B/JCpRx9EjG5NwIIX7TjH
	Ubj7xymSdpAsQ8nbd7Aquo2bumpwENeUKjx1b32otGj1QlYjSMXn27gKGD6twQni+PQRQ7hS8gX
	4T/h+e5hgMecoD+d8rMcifYBCH0eSazxMnKIwUn5EUrD47R9uGS/exq5qaxJNCle0fbbDzw0MZN
	tkUejp649lriLZg==
X-Google-Smtp-Source: AGHT+IGk85pAoZNBdaoex59k88lUaajcvjUnUboS9LkkZ9rI1dqglevNKjOCDS/0Wdg3nwTyqGkdxQ==
X-Received: by 2002:a05:6000:4287:b0:3a4:f8fa:8a3a with SMTP id ffacd0b85a97d-3a6ed5db09fmr4797028f8f.18.1750927259315;
        Thu, 26 Jun 2025 01:40:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5386dfcsm3890495a91.10.2025.06.26.01.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:40:58 -0700 (PDT)
Message-ID: <ac0d17a3-34c6-41a4-9bb8-ad9f3900c809@suse.com>
Date: Thu, 26 Jun 2025 18:10:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_read_chunk_tree
To: syzbot <syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
References: <685cea8e.050a0220.2303ee.014f.GAE@google.com>
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
In-Reply-To: <685cea8e.050a0220.2303ee.014f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/adam900710/linux.git shutdown

在 2025/6/26 16:07, syzbot 写道:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> fs/btrfs/ioctl.c:5417:1: error: function definition is not allowed here
> fs/btrfs/ioctl.c:5430:7: error: expected '}'
> 
> 
> Tested on:
> 
> commit:         86186e83 btrfs: implement remove_bdev super operation ..
> git tree:       https://github.com/adam900710/linux.git shutdown
> kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa90fcaa28f5cd4b1fc1
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> 
> Note: no patches were applied.


