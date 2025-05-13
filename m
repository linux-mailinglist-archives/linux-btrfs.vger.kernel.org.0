Return-Path: <linux-btrfs+bounces-13966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC9AB4E9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBFA18866CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C44210F53;
	Tue, 13 May 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bWNmVIxH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633641F1511
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126598; cv=none; b=fby8t7IstRcFMbZ6sxIpZVc8vVoYcdn3VSyO4w0NSatGWlgkShtyRphWKi01PS+jyMErBEchY7Yc25lCs2y8UWUlyknqV1QRgnhhmLZU0h8TPMrjEmWde6jqEEBdA06N2N9pwpb4dy+ALi5zVRffF3jc1ojauc+xhEj3FE4VUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126598; c=relaxed/simple;
	bh=i0rMHwuB6orqrSsvVPlrKR/7G3ALSFnl2EemI0JAzBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oF+ldBTX2IdOFIGgoGKCh5UYw/16yJOsMDNPbQorc13JUWKiSHMgkHxMOb3gsZ0Z1TY5+0OzOlOkVzlrDBAfYq1ikO9pFxRmxex7CQERiNohhMyqNznG6xwbIjvfpOdkeMXREVjNnKWdm4FXWR4GaxAHu5tDnE2jnY/RjfWrQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bWNmVIxH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so55619295e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747126594; x=1747731394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iVWZ4Ql7bCl7hMjmHcmiFVO9RKDFHlpE92FHi1RTONY=;
        b=bWNmVIxHTRd1OpQpdkLBIpnIdv7Q5Lo0/SQ8ypF0yR9+ZiH7e/rOhuHiDafrg2y/Tk
         DR0Hbunkt1MNtZTyI5edILlEkkVRqzn9rr6zNsN8coh1hS3+WsIkJMXkQTlOgS8hpVJq
         JMYzMIwJkNjL8jxboP5T45+n+2fO5mxHFnFGd72NjIkvlPLsZMv2tpk5gBx8BBlOcKID
         1e31C71BsG36ZBUZZQjvJmZZ8le27XUFDRdQIru10JCSx8C+YxNDyfrr/G3wyG9j+VpD
         XNo+ok5GgzMz0H6GTW9Lry75bAV305lQ7YUtMimsLAooR+73+smmrE4nQSziSZoRLI2X
         MPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747126594; x=1747731394;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVWZ4Ql7bCl7hMjmHcmiFVO9RKDFHlpE92FHi1RTONY=;
        b=DDJ/ZDeIXBXwntpeiFlvGNb3CWKUgC1MgYr3R2/JdVoFx3+YohbRhakNfOjKHD2Ccw
         ZTVY5yPtWUJnuZKAf+SwUZvGJtR6ReNu329DOx3+KKwDmSV9zRsGS0TFc7ZPpbx+BZNR
         2NLbO/ul/YY0NUeH8gJW/OL0U5oT1DI8FJrHfntEqU/TgJNIshn7UNfngPr9Mawl99hF
         pc3QOdlmNR+wj3mA5Aoqa0wXhK7tNCW8JfX89dhxQDQfaIqwH5BpweJcjDasJ3pS/wwO
         bsCyZ4IKvFYVR9uZa88andD+SsOliImjQVqPpavvP9HF9CUcUj05213RfbYbm1bezPD6
         yRFA==
X-Forwarded-Encrypted: i=1; AJvYcCXkHXw2JWJQKoN3dvVmHdvF/wBVw37YBXg4BkXu6qgixpcd1i4q4TIuANeS8Mvo0aGGCXe38V0B1uAMaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7qrrTAvM679iwIdUmYJo4t1VMOLkXP7MPMlI89pUUH6v5TYa
	moXbizj50lp3QrijDyz9rBmVxl8QmYhyMjfm0ow8/rN8BEGjmLR9dQ3A614UycM=
X-Gm-Gg: ASbGnct9vnR0YeX5k5UBR8RhB2rIZ2GsFNvGQD1se2z6hcEETrO3Hi6A8NnriElJfu7
	Q1z2yLf2HAw9ezwFD6lqmXj4inRqM/DcoQEIC4AD58NRGQQ77dwsMqg0T8S966GzYmZOFR16FGN
	4n4rM7EWMvM44zhEGHIC2BNUsGndq4RxDdFgIUv7EyELtXNKFWsrszDztI7OUiX60GM1DQOL/YL
	2svNUE/u6WNKWmXnBQMgc1yzMeso4w9hMFls/0gpnwjmv4eCkgqhFhJaDSP6cQNUkqGA+ALKCjI
	oNmso+oVe33Y0JvmOj2G+qJrlN4EUTdua5RQGF5uwm6qH/AJFdXVqWHv0BrszduULYbAMUF1h2h
	aEYQ=
X-Google-Smtp-Source: AGHT+IHPZhfV78U0/HfPb0GXuSW4fKEB/i6oZGPGwWZPQXh+zIUGL0bTyD0a0efamDI4n2FXNtBFkg==
X-Received: by 2002:a05:6000:1889:b0:3a2:377:500c with SMTP id ffacd0b85a97d-3a203775382mr7855620f8f.16.1747126593543;
        Tue, 13 May 2025 01:56:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234ad3f070sm6742330a12.46.2025.05.13.01.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 01:56:32 -0700 (PDT)
Message-ID: <05ac7288-ca4a-4da4-8cb4-54389021640f@suse.com>
Date: Tue, 13 May 2025 18:26:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20250513070749.265519-1-wqu@suse.com>
 <22cdcf91-92af-45f9-ab5b-dc08455f0ba9@oracle.com>
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
In-Reply-To: <22cdcf91-92af-45f9-ab5b-dc08455f0ba9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/13 18:01, Anand Jain 写道:
> On 13/5/25 15:07, Qu Wenruo wrote:
>> [BUG]
>> If the system is using mount from util-linux 2.41 or newer, the test
>> case will fail with the following error:
>>
>>    FSTYP         -- btrfs
>>    PLATFORM      -- Linux/x86_64 btrfs-vm 6.15.0-rc5-custom+ #238 SMP 
>> PREEMPT_DYNAMIC Wed May  7 14:10:51 ACST 2025
>>    MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>>    MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>>    btrfs/220 6s ... - output mismatch (see /home/adam/xfstests/ 
>> results//btrfs/220.out.bad)
>>        --- tests/btrfs/220.out    2022-05-11 11:25:30.749999997 +0930
>>        +++ /home/adam/xfstests/results//btrfs/220.out.bad    
>> 2025-05-13 16:26:18.068521503 +0930
>>        @@ -1,2 +1,4 @@
>>         QA output created by 220
>>        +mount warning:
>>        +      * btrfs: Deprecated parameter 'nologreplay'
>>         Silence is golden
>>        ...
>>        (Run 'diff -u /home/adam/xfstests/tests/btrfs/220.out /home/ 
>> adam/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
>>    Ran: btrfs/220
>>    Failures: btrfs/220
>>    Failed 1 of 1 tests
>>
>> [CAUSE]
>> The newer mount command provides the extra ability to show warning during
>> mount.
>>
>> Although btrfs still supports "nologreplay" mount option to keep
>> consistency with other filesystems, we will output a warning and
>> encourage users to use "rescue=nologreplay" instead.
>>
>> During "nologreplay" mount option test, normally we will mount use
>> the newer "rescue=nologreplay" mount option if the kernel supports.
>>
>> But the following two call sites are still unconditionally utilizing
>> the deprecated "nologreplay" mount option directly:
>>
>> - Expected failure when using nologreplay and rw mount
>>
> 
> 
>> - Mount option verification that "nologreplay" is converted to
>>    "rescue=nologreplay"
>>
>> The second call site caused the above mount warning message and fail the
>> test case.
>>
>> [FIX]
>> If the kernel supports "rescue=nologreplay" we should not utilized
>> "nologreplay" at all.
>>
>> This will avoid the mount warning on the deprecated and discouraged
>> "nologreplay" mount option.
>>
> 
>      test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
> 
> validates that the old mount option `nologreply` doesn't break
> on newer kernels that support `rescue=nologreply` and provides
> a Warning.
> 
> Why not keep this test line and filter out the deprecated parameter 
> warning?

I'd say, if some option is deprecated, we should not use it at all.

Filtering out the warning may ignore some other problems not related to 
the deprecated option, thus I do not think it's a good idea.

Thanks,
Qu

