Return-Path: <linux-btrfs+bounces-16688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEDEB46A41
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2069F5A80C8
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E027EFEE;
	Sat,  6 Sep 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dPabKMgU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AA272E7E
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Sep 2025 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148478; cv=none; b=aFuIzSQ90Y8xrpKvgkwUk0hggVOwnn4SD86rrydR7eWuKMNQ1ppYJxjLamiViH7mJFsYAWN7ASRHOSk/jfnjBGZwPw9OJOcI5ywR/TH7fNCMNhJCE7thiEcokatSWDlZqp2MApqpvYokm+ojz2jy2Vvv9cgrgw/6GqBKGCEm1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148478; c=relaxed/simple;
	bh=XZJIxTYo2I/xml7SLc3QqGOyLZi/SvpSBe8pbJDuscw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ov3b1CecTe3zLoqk1qmjuySCqi22Y8JgYn6h13nxVJ4AcG2IryTq+SuLtYtuDzBlBg/A1ndrfimwi7bjNqx6Ggiz4TUFLTjW6HwkNXSl7Q7iES9UqlD5BwQ29sw9relSPEGiEsp5aqo2A99xxyWplAS7pf82earE78CKxIDiPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dPabKMgU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so346855f8f.2
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Sep 2025 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757148474; x=1757753274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kDxjwgrFaFhmtg7Z1dCHlL8LEMVDaDb+6rjBaA3CT1Q=;
        b=dPabKMgUYih6kk3ZNr+Uz9O4fNBhztPg1QIFHYIirkXEdqqEv9O7BpRtKGbARFJe1F
         tabCz75iTH6GJmNM3gGzHPsl6YvfdNZjJR7TbHGdaOgt8QlpUMxNgU/0rTPe0CI7dgGV
         e/JKs6Xkb9bIsfNCyQFlAbYF4ElW96rhovcZLoL1WXBosJfWg3DZfafehuyesUGEOjgG
         k5PuprBSNs3kEYpbRo44n2hMRYQZOSIO+/TVqcza3pNkRY5HFQvA+RARxC937tX8Ik8L
         OBigsdxOU6vXPLr2I8irh83pqh96znOBSZmWgRLRkpJ0Ts5oUWypSYzFLL7kO9Sb1GOM
         iVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757148474; x=1757753274;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDxjwgrFaFhmtg7Z1dCHlL8LEMVDaDb+6rjBaA3CT1Q=;
        b=A7YBsGA25fllkT7EPY43cNeS2O2eS61dKdKo7b4sLgM3vjZ0XxsvQ6XdiL7spKXVUB
         toSL8pcnvAFbzMpBK239mF7Dd/t4Yrz8Vh8DweErowXBtLxbSoh8zEcj7FJ6GC2YX9m+
         9QbHBggxCw9ELMQEnrxt1KR7OoBF2+hTQPPVtNpcN1jRPn6dwYATFdopL2QfFQuvWSvb
         leyjuM1XRKW1FFuZhVzyRYuRbwU204Af30s0iR2Yb4i31/NTdKXyJKuTM21tnwJ/R30g
         1GnT8wn9b0DQqYOWFVBB9BYDIrtbEgw6bR+lf23/FASNZ8TiLDpdw/hPZo+s0UC7hOXW
         Qctw==
X-Gm-Message-State: AOJu0YzFMRF1vSOdBRaLa4k5d84fYMdTfiyMQgYpc5NsxW4NXeTFBZNe
	zLcoLReCr1JL+yM7vU8gzbE5ng40+QY4DVBGbvrcaavHbHoefStmhgyQJfNx83WYOGw=
X-Gm-Gg: ASbGncuxuBH81v5Tzwa3DVM2UHBMG3KeSuMogwDYzdEx7vu+Cc0QCJUIvFUGjbVfk/g
	bVgeBEvuKdW8xgG42HSLtwd1yTXHnUme/DXsKy0RhisqIGJouBcZnfFacKKqaMzpbxb2xDzkJe7
	txDywnYcIXHhB2lleG81j0ewibtRM8cB2eS+EkQa9iuTIw0rQvf30sFsWy1bzEKRIavqlkQlNA/
	oel8rLIVXLFmSpvQAiKILWzyd7dbOP95euFB2Td2Waqz3KCTT+oO0XvC/eJWUMxblMN79yUfaIW
	wxvRqu6mnsPTxPMf0R0NTr9z0D/MK5SeHgWt9G8I4rTnxlwker1UMticpM4AV1Zc9LbsCRmlADB
	VrPVHwkjFcuqThJt+wkj6kBdj5tA1OFKd/aUiGeyzErjiNRTgXBpG/z/S9rDAi6W0iMceywIg
X-Google-Smtp-Source: AGHT+IHvauodpG9ROkgICuhRN4Vzh/VmLvUAQX7FW9Be6VpNi5OoGMBmawN40GbxZg8o4Lvbe4pwZQ==
X-Received: by 2002:a5d:5d82:0:b0:3df:a0f4:abc1 with SMTP id ffacd0b85a97d-3e6438373acmr964607f8f.29.1757148474094;
        Sat, 06 Sep 2025 01:47:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f2c990296sm16769191a12.39.2025.09.06.01.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 01:47:53 -0700 (PDT)
Message-ID: <589e4ad2-b853-4f87-a813-e7e800e9d9fb@suse.com>
Date: Sat, 6 Sep 2025 18:17:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] btrfs: cache max and min order inside
 btrfs_fs_info
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1756803640.git.wqu@suse.com>
 <f81aa24950cbf8329f846d8b42f23710c07a95b7.1756803640.git.wqu@suse.com>
 <20250905173638.GQ5333@twin.jikos.cz>
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
In-Reply-To: <20250905173638.GQ5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/6 03:06, David Sterba 写道:
> On Tue, Sep 02, 2025 at 06:32:16PM +0930, Qu Wenruo wrote:
>> Inside btrfs_fs_info we cache several bits shift like sectorsize_bits.
>>
>> Apply this to max and min folio orders so that every time mapping order
>> needs to be applied we can skip the calculation.
> 
> I've checked where and how many times is btrfs_set_inode_mapping_order()
> called and it's basically once per newly accessed inode. Caching the
> values in fs_info may not make much sense compared to the other cached
> members for the shifts.

For now you're right. But the following code will need to access that 
min_order in the very soon:

- Compression
   For compressed folios.

- RAID56
- Scrub
   To match the min order so that the btrfs_bio_for_each_block*() will
   work correctly.

So it may not be that obvious for now, but will make more sense soon.

Thanks,
Qu

