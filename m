Return-Path: <linux-btrfs+bounces-14803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E0AE0FD9
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 01:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11CF3B40C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE228C86C;
	Thu, 19 Jun 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xap37wRf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8930E826
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750374254; cv=none; b=R7JqL9KtT0BQHu7btPOhX7I95HjCaYxbr05o0OPdibi14L+sAgUeNKpfArUm17+BZakdTXNA+k8CQylMcJaL3ieQeEI4boVpJNXgBJI6r+5XGKj97ie/MU0h1mM/APjCgk97sDH8GDuhsSzUYebno+n2+3GY0L48PjYNtOvOJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750374254; c=relaxed/simple;
	bh=eKRbk5ucDkFpEBtR1RP/X1XC/d3dJpUVSVqrsjCJ3lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa29qrdUxhBbJSGAjnLt3BSVU2t7pJYiuLC3uQuAE3qsXxon6mIy1I0YkvSqDNnqsECVEhmsowxV0Ekla+uYkqvPlyoz2b6zXKUhmHk1U0ZlSjzLnomj2qrgPFKjzYSa+2+MfAdsGyeu90k2ccDPOx+rtUKEBw7FDqpthAagAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xap37wRf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso775675f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750374250; x=1750979050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KEREApA0SiBVnfvkcUU+p4d/d2Gav6wliVP7MKeTjBk=;
        b=Xap37wRfNuNF6cbJHd0/otxzlHaFbAkT9+v1+p99cR3blJDMIr5zdDqDTWwycixyLX
         Fi0MnMxoKSj+gNoQrO5YuMrif6Z5MBxIStsPUzPg6JVtnF3yM9xIEEGPuvRQws7DCxkM
         WGo+4/gQv1vvAEZYppuOaahRw+aSmSXwx/YR89tPnWeQgnj9MAq2xM9tGmFgtYHgEvbl
         +nqVu7YSUwQJmtf8ICNpYlLV2AtAg8EuclTaggV++u1yWovgrMDiiG2hc+jvcHVLGvOY
         +0N9+Z45rrokPXOEe97vFmWWfMgHr5C3g2Ni9VBpdl0c1Xa8d2B3zUP1oYPOgfGY7mjD
         zpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750374250; x=1750979050;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEREApA0SiBVnfvkcUU+p4d/d2Gav6wliVP7MKeTjBk=;
        b=Rl9I9cA8H9kmhSJukxGrjAU3ufcbRnsWNyw0PjcYj3/se9AytrJmGC27F8TNCCODX5
         2/jqAk9UlMo7xpMZLHIPG14XcvYVUDzpSMADOYTvaPTRY/IVZnS2s/cSltjNm/cgNKqM
         XbSV+on4kSPyIP2ki8xj+sYGkXFNHG8AypfRE9w9VpciWrhLuSM1mGBMnWjLFRSGuAVC
         WGdhmILrXtqRuX+gTZpZDSxGWtwg+kqPnEIewV0JfaUw2q3c0hKlaP1qcsa1srRbyc7g
         v65ll3+Lmveu1ReRNvSDnp/MaTMZO63YsIi/+KxMvbIE84Wjn+babhuZarPsjNCMJzYI
         dPNg==
X-Gm-Message-State: AOJu0YymU2TOhw733IeB/PhLcxdApXVxkkTdFs8fs9fUlGS7YKg689t6
	U5ZJSFtMTR5VeKhbThLJkCooc3uVQqLBlPC1a3QF1EywZkblXHjeL5jlefPfJpXQS6zlj0hUkFa
	O8xYd
X-Gm-Gg: ASbGncuHZsRjXVMUQgxZvq+w6e/nY6fTum+gv4OE1jdeVGxST9SzFh6zv39PiKk7vmI
	L6yoNFOzIiGLWXngdhSNwOqiYfnt30VcbNkyL1PXHqNv8QiXvmFxlP+bJcqLNMFDwtEs+4pu5Di
	zIwKmEr4iSayUof04l8aMkrPvFnYcTmZV8ra2DgiKmmSFimmt+2G6OKGCLAix2TsjtTq+mEBL8O
	Py8DXNkz2MHsn1jfzhCrWSPiM/Bxbux5wXp4umnC2aC7J1wNCbrNmTfpQXROdfYLWhoQSvDdwLz
	2SNic5sHJzPDWuaCO/n57ENKXESmLJOqRLxYHmpxAFcFLLibkAOq73jQ012O79h7FU7UkH4S9SX
	eXbRiPzr5CxGS/Q==
X-Google-Smtp-Source: AGHT+IHCg/51zKqBm3KS18ojGms9Texof7p/dXn1RSWiBf/EhbZlXt68htJC2ZuLvLoibd41Pdw+KA==
X-Received: by 2002:a05:6000:64f:b0:3a3:7593:818b with SMTP id ffacd0b85a97d-3a6d1302e03mr615523f8f.21.1750374249686;
        Thu, 19 Jun 2025 16:04:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8398dcbsm3733805ad.48.2025.06.19.16.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 16:04:09 -0700 (PDT)
Message-ID: <37d284c5-36d5-4613-8722-e8fe34fb0705@suse.com>
Date: Fri, 20 Jun 2025 08:34:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] btrfs: use the super_block as bdev holder
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1750137547.git.wqu@suse.com>
 <20250619132918.GK4037@twin.jikos.cz>
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
In-Reply-To: <20250619132918.GK4037@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/19 22:59, David Sterba 写道:
> On Tue, Jun 17, 2025 at 02:49:33PM +0930, Qu Wenruo wrote:
>> [CHANGELOG]
>> v3:
>> - Drop the btrfs_fs_devices::opened split
>>    It turns out to cause problems during tests.
>>
>> - Extra cleanup related to the btrfs_get_tree_*()
>>    Now the re-entry through vfs_get_tree() is completely dropped.
>>
>> - Extra comments explaining the sget_fc() behavior
>>
>> - Call bdev_fput() instead of fput()
>>    This alignes us to all the other fses.
>>
>> - Updated patch to delay btrfs_open_devices() until sget_fc()
>>    Instead of relying on the previous solution (split
>>    btrfs_open_devices::opened), just expand the uuid_mutex critical
>>    section.
> 
> I've added the patches to linux-next for testing.

Thanks, although I have a 3-lines small patch to pass &fs_holder_ops 
into all the bdev_file_open_by_path() calls, to enable bdev freeze/thaw 
support.

That has already passed several rounds of tests here, and I believe it 
may solve the problem of btrfs corruption during hibernation/suspension.

Should I just send it right now for extra tests, or stick to my original 
plan to submit that along with the full shutdown support?

Thanks,
Qu

