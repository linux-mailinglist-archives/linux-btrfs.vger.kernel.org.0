Return-Path: <linux-btrfs+bounces-15084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79600AED3F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984783B3284
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA931B4156;
	Mon, 30 Jun 2025 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aorwLLyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D295227
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262200; cv=none; b=nBk9CSlc7VOP/Idb/44ZoeHE5Fnm1ECR8mk5+w8xJ+stz/NNdfxgDVmFcHlTgGMXVty1env4p0+/wm+C5/ELcbJOKddU3J1vumt2VFGdJRMz6h2aenIJJ75q6TZnax4ZO2cVJx3DmOGjcl8IfSU9mCyB1z59aq/upOiRLDrU4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262200; c=relaxed/simple;
	bh=wi/XWGmYzK1CxHwwejpVsl3t6mImWnYu9sHTEg60TG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snUm2nkgZV2zakfpRVVRnMfEUY//Gb3NL/zjtuNlGsnz/UfhZkoCQhyH7Q11NxLPAJCEnj1TdQFaoQfNZa/ggzi3vzzrmw6LAQ9MrJOU+g7VbOMWf/Bt0GZEm5KVBKKvU+PU9wKXufIlZ2jKY3tcSLKYqs4bwWbdWFfggUWBatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aorwLLyV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2251791f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751262196; x=1751866996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wljRLuKW6XgHhxBmdmFL8lxPPJq4V2bDus7WnqBtFdQ=;
        b=aorwLLyVDGj9Flih+k1OW+5FVvRvI5tan5kxKKvWJb7ukgek5JHIWLS24u7t6kETUI
         zUxtaNf9sCNOdicUEM4XYQKMRSL9s0Kk3wuMlnPesTJIzIHr6A7e+1TlrFeCi8+WdTGU
         CoMjXbFlcBS/a5dLl/mK6qCFIFYmS6XVkdu7mkZKJrmsi8UElk7F5jcML5DX9bJqqfYX
         zn88P/OekBYuTJ92n9Upd25rLYUrDWmJPA2/TxaQuwZHkIF+7z8hhyxv0OVyk//mpJ+p
         9WyUnBcONjF58AhdeZwTZVhu7dK6ueQpj/yObDTCSQLLwzF9HwP0jtFtqTWe2y67b6Lv
         8NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751262196; x=1751866996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wljRLuKW6XgHhxBmdmFL8lxPPJq4V2bDus7WnqBtFdQ=;
        b=wIoG9Qvqlylp+2wh+z8KuKrxQ8E30v3tksDM4vApehitwbWonZgfNBfNIqCzbApStn
         PmcQNjhbgcTMVH02K1B1yqNVwzW4VehdNOX0gXLeCnA7e5FhdVEPp3fNYE0PlZiCIhIk
         cRcOwIiWfwGxRlvGc5RaVVIIH98jV+e77tHgQTpGGhVrpWiACKpTM/nKZIOtzOQFdzG+
         kiErIJ7BSr9t6MubUcKFT/jzYhwH4NFZjQANTMgdQU42OH5xmo+gwSC8vzYdQw+rgeX9
         j6LQTpqW41BMjZIzFjEl6UydBYSBa8HsxMHlCNhPnJ24ZYEnyrBUbuqp1LV6zdx2Ji9J
         0ooA==
X-Gm-Message-State: AOJu0YzrRNHLNEFJTAIhMnJuazfYWzTvdiAqgrR8yuUgmw5GzCE1G073
	o1LrYcVaH2v4w1QUOu8uQFVYJLqMUK8rlCBT2cBgEKmndQp8pFGGfyzHWdI4Ar/Uzfjp06tX69N
	fEkh+
X-Gm-Gg: ASbGnct1tg7QOpj3m8Eu8aua27fG/Wgi2kK9ElqF9c5bq2T6m4o0Q4At8EeEwS2gPw7
	jhhEb7KZXUh8XAZFvgtZa/OJqUFG0vb2jucjRgHr3kOm+pwZfDHb+a5jxv2ELD5uzi5n8u+Vg16
	vKE890d1rNFcIYwXBIS5i+U0/4btYn9Wog6SzOKoDbc0SUNTj4QCkadCSLhEdNLIs4f7QCTyvXZ
	biP++XXQDDz//NZA0kUsNoMRAFDs6EAbCJxrIRKsTaAjdSlErLIZAaIbMXUeBOLx3RVVqDk8OpO
	2NOVh15m5WoeFRoZTHaHJJbV5BbZ1lkKUBRTcAlPos1QZJLD8TC53kIQb0nRbNNQirz0OMbJIRv
	JcGSpPtH5aU2aTw==
X-Google-Smtp-Source: AGHT+IHMHMhljA8WAGL+AGCxZ5tQkTwL/jwGGjiZhnfncjD2teVPDfZdlvnWwINCu+xldN23Lf5PVg==
X-Received: by 2002:a05:6000:881:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3a90b9be8e0mr7458559f8f.56.1751262196149;
        Sun, 29 Jun 2025 22:43:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm75604715ad.80.2025.06.29.22.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 22:43:15 -0700 (PDT)
Message-ID: <2ddf32ff-7411-4325-9ce2-116f4c5f6362@suse.com>
Date: Mon, 30 Jun 2025 15:13:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] btrfs: use fs_holder_ops for btrfs
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1751261286.git.wqu@suse.com>
 <aGIjUs7rVy05sQXd@infradead.org>
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
In-Reply-To: <aGIjUs7rVy05sQXd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/30 15:10, Christoph Hellwig 写道:
> Looks like this doesn't add the remove_dev method and thus does the
> wrong thing when a device underlying a raid configuration gets removed?
> 

The remove_bdev() callback is a completely different patchset, which 
depends on the btrfs shutdown support.

This series is only for the blk_holder_ops, and will be the basis for 
the remove_bdev() series.

Thanks,
Qu

