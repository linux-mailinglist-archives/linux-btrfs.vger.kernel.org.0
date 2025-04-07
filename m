Return-Path: <linux-btrfs+bounces-12835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0BEA7D51C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 09:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4785E1886FED
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3A225390;
	Mon,  7 Apr 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R6jQsIBI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E714B950
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009877; cv=none; b=P20ufCgmJKYSpuMV6jOvYvPq0Sa5gRLUEqhZIZLJWMOtV/anoYCnV/6D1QE96ykVI9VYxLnoTdlyfmEVPf9jXg1gEJBB7a4xrfoh/OXvg+pXz7JpcoFFXbEpISGO/tcOH3qVI5G7e8KVhGeA3hukmFqj/VHBady0CfFkVFl9sB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009877; c=relaxed/simple;
	bh=1xUA8gFXWAIyBkgd+JlhctxX5o9VHdOhtcPkNEfX6pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR1t68NlclVPbwwBUjrs5NCub31ne9AmPiM5hwnytB/75+5GiJ1JJyWmUgRstRPVPFvR94MFteZ11jKuVriiXT/0En1Dhd/D+eqn8Uy9kirZycDt55sbwm3GrNd/Kp6Ah9Bd/psUs5y+FtNr/hccftK0c6BZlZNh/i7JMUoVWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R6jQsIBI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so2400130f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Apr 2025 00:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744009874; x=1744614674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lD3XWqS6cXpIB7K6lywxrfIs+93TOkuw/2DOjuryL+M=;
        b=R6jQsIBIXBMHTGT5z4ajrHxwYbTkaGvQBCLWvQFKsQJQr99pY7/lmY0Qdcv4gZ9yGf
         igkfrsXkjATrsCJr9E6kkIbHivi+PISMo3Cjp4jL5hV6HNI1CzB73j1MW/3ROLras+Ti
         vj0/WJvKoh91TV8RJrJF2Y/dBmdAFwQyp/qpzac/cOUFI3ikJw48VZ6gKp1oEKIMqZPI
         Hupd4e8EdJ1ay2hW4Kch+U1rPvuu1aHjSCmRErhyL65KXy6UhsDj9PK0MfkSj4ll1W7X
         prxrYDD98+BMQ/PJcpy3uQsTaSIWhomqHpwPr76emaRCVnl61rtM/DRiKO+LnScM5Xj3
         4aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744009874; x=1744614674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD3XWqS6cXpIB7K6lywxrfIs+93TOkuw/2DOjuryL+M=;
        b=MYvo9uSYFbWjmZcbPx3n/3GOHoE/0QOC8qSnMiyU5QSLvxGObMYs01usOtZ1ZsnaV3
         lp/hHC6OWjdYuKI87t2EF3l0V2eIsiCEjXC1xjEzazkzvQaZYeBbV2MeOeboDQnPadpX
         QAjt2a85qZXeJhs+1Bw8hP9Ffsk0Q53ByP/2M7Y+IxFEhtyXDidG+wJrLofvtiksO5HC
         lVhsLDIV07PSK33dsPR25PVnB7UmcPBXvqjaXYMpR5tr0XtpsVZOot1lz1BbS2Q904P5
         QEswlniktSLakFOA6lq+OLx0pXeKA7sgT3Y2OyTT045syCgYmfQus6+AXidKRq5iJUi6
         AXVQ==
X-Gm-Message-State: AOJu0YzVfsq/3wBusCLtPOKUTyRUCd4le2+eSC2VF+zYyk0iqgi5yb7g
	8yl4nRyFZYIts/HS1HJ6Kna8kivfMOyyPci0LaAU6uVdsBED8fpc6OYG3Zr4eNsgt4mCdCSZ701
	w
X-Gm-Gg: ASbGncsVL0EJbutf6Jugk/XpVhLPtFDyBxIGN3iWfi+qzj9tCgQtD1RYaVEfbnkDcs6
	wvIZY/AjWxZNRkMqmOlR2ySjO3sUrTtSyds830ut2LndYpmUK63rzvAIsnkQayUldKVPbnAGYZE
	SjTGRlrhlKWxHRsWpr/M1FfeCG4z0kGyPUUIKRyaCZIyrJ6hopUg3Et+ylRVRyX3yWhc5SV7SgT
	Z36hsdrFsIMf5McU4aP4zebGkuKWlwjym+yd32W7gRcibvG27TtPDSbeeAlc53cOFGmF6fEgnht
	NC2xh4f0amHQAsz1Up+FOxLsxVxeTSF7jTaTy0aPKbo4xZnw9E/F05BRmztLJjhIMq6wZI9pv2S
	eRNOqttc=
X-Google-Smtp-Source: AGHT+IEAs8za+7hktJD9ik4i7q6sfmVyV/ZlDV+ddOopkVDEueh7UUQU/y354PKgugJu+JYLtdotkg==
X-Received: by 2002:a05:6000:1867:b0:39c:cc7:3db5 with SMTP id ffacd0b85a97d-39cba9331d6mr8463378f8f.40.1744009873663;
        Mon, 07 Apr 2025 00:11:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad8besm73665445ad.28.2025.04.07.00.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 00:11:13 -0700 (PDT)
Message-ID: <ef4c97e8-e39d-4d41-a5dc-95464bc0e5af@suse.com>
Date: Mon, 7 Apr 2025 16:41:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] btrfs: prepare btrfs_end_repair_bio() for larger
 data folios
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1742195085.git.wqu@suse.com>
 <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
 <Z_NuL8Ucl0FCZ64A@infradead.org>
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
In-Reply-To: <Z_NuL8Ucl0FCZ64A@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/7 15:48, Christoph Hellwig 写道:
> On Mon, Mar 17, 2025 at 05:40:53PM +1030, Qu Wenruo wrote:
>> In above case, the real folio should be folio_b, and offset inside that
>> folio should be:
>>
>>    bv_offset - ((&folio_b->page - &folio_a->page) << PAGE_SHIFT).
>>
>> With these changes, now btrfs_end_repair_bio() is able to handle larger
>> folios properly.
> 
> Please stop messing with internals like bv_offset and bv_page entirely
> if you can, as that makes the pending conversion of the bio_vec to store
> a physical address much harder.

Well, I know this version is bad and it is already causing bugs when I 
enabled large folios.

I have a better solution in the latest version to calculate the offset 
inside the folio, but not sure if it still counts as messing with internals:

	struct page *real_page = bv->bv_page +
				 (bv->bv_offset >> PAGE_SHIFT);
	struct folio *folio = page_folio(real_page);

	return (folio_page_idx(folio, real_page) << PAGE_SHIFT) +
		offset_in_page(bv->bv_offset);

The latest version can be found here just for reference, with the corner 
case taken into consideration.

https://lore.kernel.org/linux-btrfs/f679cbeedbb0132cc657b4db7a1d3d70ff2261f0.1744005845.git.wqu@suse.com/T/#u

> 
> Looking at the code the best way to handle this would be to simply
> split btrfs_repair_io_failure so that there is a helper for the code
> before the bio_init call.  btrfs_repair_eb_io_failure (or a new helper
> called by it) then open codes the existing logic using bio_add_folio
> (it could in fact use bio_add_folio_nofail instead), while
> btrfs_end_repair_bio should just copy the existing bio_vec over
> using an assignment or mempcy.

I guess "btrfs_repair_eb_io_failure" here is just a typo, as we're only 
talking about data read-repair.

Mind to give some pseudo code example? As I still didn't catch all the 
points.

There are quite some direct bv_page/bv_len/bv_offset usage inside 
fs/btrfs/bio.c, and to my uneducated eyes it looks like we will need a 
way to convert bio_vec to folio+offset anyway, as long as we're still 
using bio_vec as btrfs_bio::saved_iter.

Thanks,
Qu






