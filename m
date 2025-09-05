Return-Path: <linux-btrfs+bounces-16634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A7B44EB4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 09:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6DD3AABA9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEB2BE7DF;
	Fri,  5 Sep 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KYJzW9ZI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF132F76C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056094; cv=none; b=R/Tcz6gGXcD1hZABfzR+RDHKN3mW6/KVhJqn9H44j9xakH/eXyRNJNKI7SnStv4XmPsL2lS/dXeTBEvYJpHRzOCLKE0+n5Z03MHpvLaKwxjZqRWQQZO+VJxWxn3b2YZT64hEtxRb9LnoWIEkw1O+oz/5sIJ/y7nKR0msp5mgGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056094; c=relaxed/simple;
	bh=HZ91s4XTJcOqavxS9GJ8hffwLAoE76SAklAMPIrrKjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/R9DE7zhL67nh1qq77r9y15q3Jafa7nKWF/xAfXTcekyP7bNNqmblR0nKxFiC1+ccmexPCwr0KEXk8800PcEmB5rfC0cZXCT0JUy4OPS3+g6KW5W88E1SFF/B56Pvdss6K65mltNWR8CHjeqhOQ89BVUa9nscBdGK1MIZD0osQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KYJzW9ZI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e2fdddd01dso88159f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Sep 2025 00:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757056090; x=1757660890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r/rqEsVsvHpDY3uYEpV+EXdEddN52ZiBfIUTVKYRqkI=;
        b=KYJzW9ZIuG+8x96B8sVYd+19EptCc1zn5l5h+HYbyV5gkiXLVzy47LUzup2fJWBZbH
         WkcF1CsO0nWVd4dFqOAZUC9lvAhXAQD4pHmKQST4//xg+FG8uRBYqMCwGqF2GzPFJSpV
         rXzdL1MyqJH41LnLjYDxVNPxqjVrFCdC38lXY4aV1NuaTthRr9PuNAwiay4YRQxvQHFj
         O3JbgEH+vvaNe7B5GUtk7wr7CnHCQaYIcGtU4iIHzgk3aijBpb9AT12yOb/lntDZ/6zp
         oH9hvillhvdU1ywvR4IQswsIp+81TczpchJWnwt/07D82h7vSE/MQnGInRtEKSA+PBW2
         N4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757056090; x=1757660890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/rqEsVsvHpDY3uYEpV+EXdEddN52ZiBfIUTVKYRqkI=;
        b=kW0+W+oI9w36OHw7hc/g0AfC9XPURCGI2FC45A8zhMeFDw8jt+jGO2EHTJOqGN8El+
         Dv+2ZczUPFBSqxlOV4r2NV0QZNZpEVUAEEMufj9nDchLnD2ZMXgdv/C2cJtCL5bKraAc
         rNq9oar6LykHrGvygN/j3Q0Z/kRif4sfGOJNFNilfxPIEMGqDJV+APzihIKMPcx4FM4C
         yQhff9YpJMQjJT7XmRAqcuCPFYBbHSw6Y/w/Mtm5tcwBdLLYVwyDKWX2jEQO5TnbZw6w
         CXTEG2sfu9ascAF1KXHywsSVocLe5JxO2FeNB2Wm9azCuKF2hEE+om/qgz5xqPM224FK
         ylnw==
X-Forwarded-Encrypted: i=1; AJvYcCX8wbimMPjE2E2xWVbYIT3vODyih1wkms/aIDq3sesqZ7PGd3oGTDVYsmfoDfqYMNWGPZQgjpUb2AWXoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcj7qqXXUe+7csQoa0/unyx9F+bnpmURcit7vURMkBS1qrmR4q
	Uv9V1O/lWhJ8nTE0RoUSA2TPPavxYz+3WpeDwgcONM0x5zMeV0QwslbsgEDU+aKN/yQ=
X-Gm-Gg: ASbGncsnJ4YZ0liaQRPEW/TC8CeS4w/Gy65Vb++8DmV1OJqRx5mNdSnNQiHXbx/Z2Qi
	6tl74EUMyGDG26faFkv8Vaz9cI8kxiFazNrqIgiKsMDfsnOnpZ5w9YF58zplKwEtu45N8UpyCON
	VhL3TDsX1HuL2V6yVNiIyEQfGQj4IejrRAFhlmf2YDiCeJb49UpgNCm/jetnykUjMajWCxA7MtW
	kIOuAObC5/cGfaRksM9lUg8137tgyJN+7bRrkH66Bo4Br2XcNqGzbxKIkVZZDBwYKd8xvtv1gr9
	adeOff9kHTJQ+wVXx19LlysvXkkdzyDvAab0VBwSecoAAQfcqVrUk6+GU8dBfnrB+oepXyaH1KL
	RVF/REzNwdzrBc8E2U8sNah84CbF9zyACJi/wyQ8FvSNCcSvEAtoJ7LBLhE3Fdw==
X-Google-Smtp-Source: AGHT+IGKYC49JMWxF+Hr77UBIJyrlK3jyy5EhR2LejY932SvHcu+eLotSBbmU0uHz6kKBY5tNYWNIA==
X-Received: by 2002:a05:6000:230a:b0:3e2:b2f0:6e4f with SMTP id ffacd0b85a97d-3e2b2f07270mr2330492f8f.46.1757056089918;
        Fri, 05 Sep 2025 00:08:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f2c990296sm14172625a12.39.2025.09.05.00.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 00:08:09 -0700 (PDT)
Message-ID: <3f2df5b1-e5c7-466a-8e83-4163054e5ae9@suse.com>
Date: Fri, 5 Sep 2025 16:38:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs RAID 1 mounting as R/O
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: jonas.timothy@proton.me,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
 <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com>
 <CAA91j0XXP4+2RACLuiO46VMG9nr=CgGjEpFtAJ1SA4thSQHJ8A@mail.gmail.com>
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
In-Reply-To: <CAA91j0XXP4+2RACLuiO46VMG9nr=CgGjEpFtAJ1SA4thSQHJ8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/5 16:29, Andrei Borzenkov 写道:
> On Fri, Sep 5, 2025 at 8:38 AM Qu Wenruo <wqu@suse.com> wrote:
> ...
>>> [Sep 5 02:22] BTRFS error (device sdb1): parent transid verify failed on logical 54114557984768 mirror 2 wanted 1250553 found 1250557
>>> [  +0.023579] BTRFS error (device sdb1): parent transid verify failed on logical 54114557984768 mirror 1 wanted 1250553 found 1250557
>>
>> COW, the most critical part of btrfs metadata protection is broken.
>> This is already permanent damage to your fs, thus every time extent tree
>> operations touches that part, the fs will flips RO.
>>
>> The damage itself should haven been done in the past.
>>
>> And this looks like FLUSH command not properly handled.
>>
>> Considering you're running btrfs on a raw partition, either it's btrfs
>> not doing metadata write correctly, or the disk itself is faking FLUSH
>> handling.
>>
>>
> 
> ...
>>> Write cache is:   Enabled
>>
>> You may want to disable the write cache so that the firmware has less
>> chance to cheat.
>>
> ...
>>>
>>> SATA Phy Event Counters (GP Log 0x11)
>>> ID      Size     Value  Description
>>> 0x000a  2            7  Device-to-host register FISes sent due to a COMRESET
>>
>> /dev/sda has been reset several times by the controller.
>>
> 
> Disk reset will likely flush any pending IO request in the disk cache
> which may explain transid mismatch.

That means disk resets acts like a FLUSH command, not a real reset...

If it's a FLUSH, it shouldn't be any different than normal operation.
As the fs can send out FLUSH command at any time.
And the disk firmware itself can choose to writeback the cache at any time.

Although for this one, no matter the reset behavior (flush cache or 
discard cache), it's not a huge difference.

The transid mismatch is data from the future one, which normally means 
nobarrier like behavior, thus I tend to believe it's some firmware 
cheat/misbehave.

Thanks,
Qu



