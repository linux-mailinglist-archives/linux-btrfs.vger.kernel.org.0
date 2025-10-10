Return-Path: <linux-btrfs+bounces-17612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C322BCBE69
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 09:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0BB935385E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE9271448;
	Fri, 10 Oct 2025 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aOARpySs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C471D6193
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080938; cv=none; b=nlLhTpGNz/piJxm6mY1tyjoqVpVm/zo09hM38+GqJ2pc+22Ep1CeP2mOUuUnAA7Cf9cwcvlKA7rMMSu1TzB3I6RuD7tax2K0Ozyj1T7P/OjuSXMREUUoFGdiLSEzzBcmdQ5bPq7WsqCAmHTROH+HEVyl6UcHtrSC4r3qVnzLS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080938; c=relaxed/simple;
	bh=QR7EqsSQuBPYUOXxbqaMo+SNB8phXTBdkviwMqy1OXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lEwvZeG1iV5qUXLzyNv8XZS7YVSh621Z6Ic5tw9K6C1HLz6mffSLKz7Tj35AL/hqzTbUDGPgGkNMmU118eDUdZXCBAnY3s+l89MBX02FEFsymUAosUJuCHsUNbO8BMpYubljtAUin4zz9oAqwpzQC8WNLpybqKwYmTVzmvuetYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aOARpySs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42568669606so1233209f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760080934; x=1760685734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jMGb1AggVGV/8LBOB2XVM01FY9kfHW/1rlOrhqoSeVk=;
        b=aOARpySsu3IveRZT88YFWekW3BVVaAWWGJXgh2GehWjYoqY61VYIC2FiqdsUZMMOJV
         AWdNMTDNC/+OfXfnM0mF8Vp0VdQDYMbufeGmIJ1ZMuOXnkypWy2dMVaNbtABzfl72IWK
         9Sz3UxMOCJcq33kxXO6h0rVgzS3lnKOdQn5LB6/H7qJbmJraEHc2di4fTVBUjZC9d3M7
         lA0OGuIprGFjFp3xx5b0JNciLxbopIdg6Mht9iFCTTMXGZ3uj6KkfoQZk9RM+xkopf2l
         cfNCjl087dLF/56ftQdxZQCsPTIFHhyFFfpRykXMuheseb0Da+ci2ASyRxA75NvY8V/c
         kqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080934; x=1760685734;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMGb1AggVGV/8LBOB2XVM01FY9kfHW/1rlOrhqoSeVk=;
        b=VXI/S+HFTINVxU+rH6giI7ECGSaXlc6dFR9oqwfUZaocMVwEFwgSNDR5etUfAlPj3s
         CmMd60HG47prXAaSejytXpXgSqz9DDKKQ1mgPZ+excWr7onaD67PbJWsmH+xhGGmGy2U
         B+o4YiswVUdDmnciVCkGeVp0EbeTPQYcDnRTPg7QZANBSeZaJGHAVP/Z3dXOkqXGq+Rz
         8+b1SSHXbRAXkGo7K3kyWGAx8+R+P7ctrt8BuEQVQ+yVWMQQ7dIp9Z/8gdDWXDM67+Ik
         sXOt8aQr27IO++v4xXtrCoeM2mM2sadZIljl/pQGWBJhfdvU3dNYUud41WjIjBjFBMcg
         iLiA==
X-Forwarded-Encrypted: i=1; AJvYcCVW8kAbP3qu1xcbYa+aana2sTcY1/C0uJp1HEMWxajO/izdVoIiTXWdovBG6hueXVzMXTSraTS+rO27mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzelUbJZTIbe4VQOk5d6UhoitouZhmcYIAdHr8bfB7mWw8R43jx
	q032dy8xiA0abKJ5A9FjKlPEAa9JyB9FLZknghcB7shnW63I7KC8K0dVx/POink5/xc=
X-Gm-Gg: ASbGncsuPNpQ1+9TjDGO5VlPezRXGpMo2EgV7St/o/q24mkZcDEfqH4acODrWIBOJ9z
	W0ArYB740WdC5AnMmvTVom0leRasOHbOsBZXhQB6nHALmw7U2BDLQvpnUFupS0WFNKYvW2mL95y
	sIHGX7+MxVzm5OYH/MWhlGDsQq2sbiXvsOD82VgkdF6pPbVPdHhj02THbwQI5zMrJg9yZqSVS6j
	gl5YIzT0S+vq9l9XLWwa4SB8Y+lyc7SioxD4/Vr5aG17Zho/JRlO9UMfvVZ49tXvCJBUphUiZ/k
	Cq//4Nm53OgDqKexih69c2fcvI+lWdCUDqFvp/ZhlFSFnBuAw73F7dDg9O4yevXkGXlgB8N5ss7
	8GdkMpDEVPgeciUzGQu1N6QLKOqWLyCiO7pCOP/g99KMN80KTlliFMdelxfIEseEAyZs4rN9Wc8
	6/gu7M
X-Google-Smtp-Source: AGHT+IF/vigJYmyODX1fJPtPNu9cbpr3/05hP+fI20CsMEyNQabQ13YwREcAH7BYW2rADIEpUrmPRg==
X-Received: by 2002:a05:6000:2086:b0:3e4:e4e:343c with SMTP id ffacd0b85a97d-4266e7e163bmr7767433f8f.31.1760080934313;
        Fri, 10 Oct 2025 00:22:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8135sm1874923b3a.68.2025.10.10.00.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:22:13 -0700 (PDT)
Message-ID: <27be1b9e-f61b-4e59-a195-6e968e2f927d@suse.com>
Date: Fri, 10 Oct 2025 17:52:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] btrfs: introduce a new fs state,
 EMERGENCY_SHUTDOWN
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1760069261.git.wqu@suse.com>
 <38d32b204adb73c36ab00d03dd8fcf7d372a4df6.1760069261.git.wqu@suse.com>
 <a30388d6-26c9-43cb-a222-13745cca30a9@wdc.com>
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
In-Reply-To: <a30388d6-26c9-43cb-a222-13745cca30a9@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/10 17:00, Johannes Thumshirn 写道:
> On 10/10/25 7:01 AM, Qu Wenruo wrote:
>> This is btrfs' equivalent of XFS_IOC_GOINGDOWN or EXT4_IOC_SHUTDOWN,
>> after entering the emergency shutdown state, all operations will return
>> errors (-EIO), and can not be bring back to normal state until unmount.
>>
>> A new helper, btrfs_force_shutdown() is introduced, which will:
>>
>> - Mark the fs as error
>>     But without flipping the fs read-only.
>>     This is a special handling for the future shutdown ioctl, which will
>>     freeze the fs first, set the SHUTDOWN flag, thaw the fs.
>>
>>     But the thaw path will no longer call the unfreeze_fs() call back
>>     if the superblock is already read-only.
>>
>>     So to handle future shutdown correctly, we only mark the fs as error,
>>     without flipping it read-only.
>>
>> - Set the SHUTDOWN flag and output an message
>>
>> New users of those interfaces will be added when implementing shutdown
>> ioctl support.
> 
> 
> I think it would be better to have these helpers introduced in the
> patches that make use of them.
> 
> 
> I.e. btrfs_is_shutdown() in 2/5 and so on.
> 

Indeed, the first two patches are very small, merging them together 
makes more sense.

Will go that path in the next update.

Thanks,
Qu

