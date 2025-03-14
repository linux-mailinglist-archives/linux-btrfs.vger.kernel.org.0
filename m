Return-Path: <linux-btrfs+bounces-12290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDEA621A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAA4207F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87971F3FD3;
	Fri, 14 Mar 2025 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N9mAU/Hj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F61DEFE0
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994740; cv=none; b=vCT4j16rT1jqAqABN4vOgz+k+V7qFP0he6KQPpka6QjV8yCpl1ElTeW5T2wO7kS66OZ2aWSs9A0sXhvIA4tN+ZwHXjtBI1PTSSLKyHU3p7l/ZejJQTBE72EU18tvv8s2l4OEgsltqO318HDb3L1/O0EaT+5/amqt9sihCUNhumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994740; c=relaxed/simple;
	bh=jRtO+a45fWmdJFlKsPIOuaGSek2qqy4/6De92hdyPPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnAznsudrHHrVcg6vyNsJ4rc7Ak7+p2z/rMZNeQuF+SumfnYjfJ9ksHTlVRZ0ufrf7L6tGJUGY7pdm4/dvg63pNIk8F0abBoBVGCYZAegEgD/vW7ZNRJpytWdS5WNs0kB5hHDnnkkCJ+xN+bJikZQhhLUk4gF8djaLBDnQb6mJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N9mAU/Hj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so1547097f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741994736; x=1742599536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pC5pMPeYjN/u4dErVaBcU5IoVHk0gJFzpNqgOSJFfuc=;
        b=N9mAU/HjDTtNVe9L4R890jMU73gP6ZE6jBRw9eBrbXvI1p2k8gPZ2kZV2sboPNsi1p
         zfypZohSmvbytVblcauCMiiG2IJYw1luxkmRbRNgB/CMEAllgjBgFjCuEsJaTTY7UoX/
         FiRObOosvMXW2evZR/1hJHUrs1z6ZGdDHDxA5bw++rdrHWZ4w+49QeNn2IO1lVoy1BkU
         oHQRPcaJzFYuarAYgbNazAi+uMe+dF3LQWBpl3PPHLIli1Jx59PHFwk1V7jqY+plLHEZ
         mKUHzCF5RYDeGr3IxV9f1oNyshkqqg2FmKGIJPfxTIPGYk8L6AEMfGmL2ixgh9v00M4n
         TiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741994736; x=1742599536;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC5pMPeYjN/u4dErVaBcU5IoVHk0gJFzpNqgOSJFfuc=;
        b=uFGUDDBZ2A0UI8QPRTcf8DP0cKltlFEva0M0zoofoMcMAk0ZpfMqDeHqFNDfFQc1HG
         EmiJmVdJPbyzqqi519XWj2K+GdxT6KWDE7U9Kh2jM0XnT1g5Qmzmk8czrQlA+1fWRP4h
         R2gg4b03vguauA+Iq4Ug2bWrzMd7BoRf2EfyAyeguo9Hhy4cz9wuqkaLNSMPZ9rs4XyY
         kcVImCle8Kc4a2yhUlCD8jqk4Vn7EV+IT4iVP+95W9IcCA3HtRWi6AKn9CcstQsvz4Og
         XCSjNreQ1PHAeneaUgiV72QJ+sEybCxHmuvQ/by23TA7rqMwilSb4ZSS+VSmoZb499Yc
         lX/A==
X-Gm-Message-State: AOJu0YyC7XEMcI2eT141n7QMCjUhdtuiAn5YRvNRoSfDaeyr1cuA44Bg
	WC0OoPwic8PF5744IwBOZ7ea77tMt7qIT6+XLbkd1gjjbReX06TXkE4fJsdODnApUQufn62bTmC
	q
X-Gm-Gg: ASbGnct79yJ6/uCe3GVyogBEXLKP9SPNNu3s9+k7rL+V7KCcZP2qpDUEp5Z355nPeAT
	wadF4/HzNixpfUg9TK2TMto3WDqRIxFyyOH+FoEEb14y3Y9JrYMyONOJa+0+vTeP4iYM+ctaxz1
	KfWR3ABqADErV3H099HBD8rYTBEsq6AVQYWgYhYT9MMyo6c6SV+FMngUwTBGBYomfzP8MX3uemp
	JwGas3RmxULs1NMqMZrnkOR67KqOxbEjATshXqDLPjZuJPY+/avu60nCPDb/zIs6VsQ+6IoXatx
	X8TBN5jCMgmtdUq5wi38/WBoa6A5h8rJQBdAy5zmQMvA2sUxKKBAnO3wwAEBKeYxiZNAX4I9
X-Google-Smtp-Source: AGHT+IG6fYiRtS0/8JQgtSijqC3TzAqQ+F5Y58RXhcTNB/JYy+Z4uvdddOVl7lcZX2+nVWYacBTcqQ==
X-Received: by 2002:a05:6000:1fa2:b0:38f:2ffc:1e99 with SMTP id ffacd0b85a97d-3971ffb38e1mr5600336f8f.49.1741994735571;
        Fri, 14 Mar 2025 16:25:35 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa637sm34141195ad.94.2025.03.14.16.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 16:25:35 -0700 (PDT)
Message-ID: <eb9c52ec-a902-4750-9b1f-3d0a2fea963e@suse.com>
Date: Sat, 15 Mar 2025 09:55:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] btrfs: send: remove the again label inside
 put_file_data()
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1741839616.git.wqu@suse.com>
 <ab9bc3e04e0344667b72edff9127e3fece6c4ab6.1741839616.git.wqu@suse.com>
 <20250314165253.GR32661@twin.jikos.cz>
 <78d2f543-1ffc-4454-830c-e52a6eae024c@gmx.com>
 <20250314225803.GT32661@twin.jikos.cz>
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
In-Reply-To: <20250314225803.GT32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/15 09:28, David Sterba 写道:
> On Sat, Mar 15, 2025 at 08:20:43AM +1030, Qu Wenruo wrote:
>> 在 2025/3/15 03:22, David Sterba 写道:
>>> On Thu, Mar 13, 2025 at 02:50:43PM +1030, Qu Wenruo wrote:
>>>> The again label is not really necessary and can be replaced by a simple
>>>> continue.
>>>
>>> This should also say why it's needed.
>>
>> Do you mean why we need to continue, or why the old label was needed?
> 
> Something about that old and new code is equivalent and what implies
> that (no changes in the variables). Changes in the control flow could
> change invariants.

I thought all developers here should understand what "continue" keyword 
does.

Do you really want me to copy the official definition of "continue" 
keyword here as a commit message?
That doesn't make much sense to me.

