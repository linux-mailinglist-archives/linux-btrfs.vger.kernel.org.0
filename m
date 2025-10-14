Return-Path: <linux-btrfs+bounces-17763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11074BD7613
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 07:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D61B18A8491
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 05:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB457296BA7;
	Tue, 14 Oct 2025 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EKqco9wA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F5245023
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418845; cv=none; b=LK6s4Y0/UjYIiSfg+fli6cUlPmIhNCqxPI50XGsUjAM2Ik3j4CULrpuoCH/kcmM3W+VXuk+TOxXf+G0FSbEHqiQHiKN3uAeNk/gadN/Vl2J4zpLbgLZoG4KvSH2ODJWQ5QKCjA7Bog5uNVyOERn5LmOTneaU9IApgupF7f7063E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418845; c=relaxed/simple;
	bh=iqtaVI5XEyh5592SG25WZntlMN944UQCQ1GcQfweCU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKDG1F36soEMc08bfk8g/ENgDMhfrpI0stHHQAZX9HvTmvoS1yEY9GHHKJqqrAY4++ADFLMrALw0pXefO4UwiFol1taPnrf1iJu3+4JXlPBQa3iZrOqVuZ8mJI8st8MGHa8f7LasmUVeLj0+eGIVfpd1oj8v+8ljFHbap0jRGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EKqco9wA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so4338310f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 22:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760418841; x=1761023641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rln7mORLnWvgfvd24w2tXe1xINLMmx+fNiAqEE0B1Js=;
        b=EKqco9wABGqo0RlxeJVrsFY/7iLMCRYPxlTAnspbHmlwh0gELIoIimyoYKfEKM7M4k
         rLpf57Xs76R63Vr48ay8M0gGmbr5eafbwccC0rMJXQytJkXmAf9NHQqw2439RfuaNHT/
         +QNNX1W9D3LPKDuEJqM8zDMabxZnH2ufB3vUTjQhwwMg+0gGUXvLfId9yDd3ieF4uvJm
         1bUSuePb9vlywKvDS2kjbJ84neArvDnBrVtetcjbFJKhSOMsFMzYeuM/CsOgjbnXtczf
         j+BBZTb4smU40s5ZCJZpdBioTyj1OgK2tmL54JOGfoEc/EZvKFbmJL/uIXNyoAnEmSwv
         NWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418841; x=1761023641;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rln7mORLnWvgfvd24w2tXe1xINLMmx+fNiAqEE0B1Js=;
        b=Ld20Vj9Dg8SpVAujvWY1zcXdXghWI5VyZ4iZEaCdOK4XdlxQT1cFO5i54rEXTpjXb7
         CmPnZOC7ZZgFLlsMcO8Syic1neI24R1YeHdLIF9BoACmJpm6a1/IuHVB0a2XCvJ8q3Y7
         6MyOSJ8deZPNBxPyK+ynxFVITePPNucmoPLNOvbelklaB/09JKf3d5JdLZAgiQ+A4TMi
         j7xPmoraeLXQkYYEvUAK0difcsdJlGuqM5OoyX7h0tn1CxCpSZi6NBYO4jEvDHZK8FRi
         17KpgpLkT8Rv9kSVjUzDKk0Nqf9R0k3XSEJLGdOUngqxHwNeQOg5X0ZsIDOeL0I/vAu3
         FcSg==
X-Forwarded-Encrypted: i=1; AJvYcCXUQgELPQGCmoIQGXjijLYvsBq0iWwy1i5fCzCVaQwhiZgzYrmH5eSn43htaGm00ifKOjVjEIDpMz/NyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyA7HPvDIPEQESiDgoMrtmKntkZARf9atuYSelvTslZiRrbfv+
	P+9lo2qyk6cMBmiK633SKvD6U3gsIhKzaeS6NHtKmHTOwLAXGPfcq2yrA+Pq4tZhm0E=
X-Gm-Gg: ASbGncs8vi5cE6lqzHqGaSy/qGOubiFI/24paKDJrawWLI/LsVYv/B7VQVyDw8n+/KL
	Hg/GD3PV/CHacLRSioh04BgDkqSK3xRKZk2BOdShnQAJRxvnvD15GV3QTlwlF6TSdLxZC7mFvyV
	sN54vHWlXqoqYUy5v5d3p8oFbXiO8K8rKnLbZheNlIEqcOz5gDTyLCokjNxOxGfmNgpJLhuFwsC
	HoQQ/p+hjciS2SpbzxjMfLT/M4EiSlERPWh2RUgprytEo+GvXopqFD2ZlFwqw4Xu4KCQ2LhAvgE
	cjhJyH12WfbNJNa49/zYZ3KW4hYgW840DNdwx5rJv11Iu184JHh+1GJCYGcClyb/G0qz2biOqQ+
	gqB6YxAWNJvxWscQgWw+JPJ9xfTkJLmaOyS4TlpDC64cSHhMOps/CKowII7XfXAKM262txg==
X-Google-Smtp-Source: AGHT+IHHWcRnVM188ZrFg3N9NneaIaGiyPkpGn6/Jt1Ad+BWLO/MpTuXxwiZERz6PVjYfRm4N18LZg==
X-Received: by 2002:a05:6000:22c5:b0:3fb:bb69:d91b with SMTP id ffacd0b85a97d-42666ac4a07mr14269691f8f.2.1760418841327;
        Mon, 13 Oct 2025 22:14:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9932edsm13435303b3a.73.2025.10.13.22.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:14:00 -0700 (PDT)
Message-ID: <fe7201ac-e066-4ac5-8fa1-8c470195248b@suse.com>
Date: Tue, 14 Oct 2025 15:43:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
To: Christoph Hellwig <hch@infradead.org>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
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
In-Reply-To: <aO3T8BGM6djYFyrz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 15:09, Christoph Hellwig 写道:
> On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
>> Some filesystem have non-persistent UUIDs, that can change between
>> mounting, even if the filesystem is not modified. To prevent
>> false-positives when mounting overlayfs with index enabled, use the fsid
>> reported from statfs that is persistent across mounts.
> 
> Please fix btrfs to not change uuids, as that completely defeats the
> point of uuids.
> 

That is the temp-fsid feature from Anand, introduced by commit 
a5b8a5f9f835 ("btrfs: support cloned-device mount capability").

I'm not 100% sure if it's really that important to support mounting 
cloned devices in the first place, as LVM will reject activating any LVs 
if there is even conflicting VGs names, not to mention conflicting UUIDs.

If temp-fsid is causing problems with overlayfs, I'm happy to remove it, 
as this really looks like a niche that no one is asking.

Yes, mounting cloned devices can be useful for certain cases, but with 
metadata_uuid changing the uuid should not even take a second, or one 
can just unregister the previously scanned device.

I'd say we paid too much cost for a niche that is not worthy.

Thanks,
Qu

