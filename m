Return-Path: <linux-btrfs+bounces-15830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC85B19C51
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 09:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A35B3A6C55
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 07:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C5233722;
	Mon,  4 Aug 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvKi/BBa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8A15539A;
	Mon,  4 Aug 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291891; cv=none; b=JEYvcvtJCXLh8D4pBv+ooK74Z9EqsIFYIGsz/zR2gQ3gD246tb0t6fWkXHCzGKkH/FMjfaS3zgfa1odJjJdW8LtfoXv6RzpfiXj/ukqWv7uIupQBk/VYDBHyYyBpKyM6ygJ283mUceO9nqEyk52Y2GuUetd1Cq9cHFTT9QS1rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291891; c=relaxed/simple;
	bh=eewziuLd0MhSgXJ10NTu2ceozPeHWXA+DMSoJiD7BYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKMCord+jmxGuDnkUsfpBLj/bHgfmnXk2KHE1MLGczJtO592CGRjAK6bhH1l1CsoaL/lIn3c23dTWDDrufgPBzRAx8n1PJ/claJRr9+CmPG3basMOw7CkqL5BjtxpHvbAuv2Iqgyc4kql2EAgrOJnPzu8A3YyBunSAX/UYeaM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvKi/BBa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2307456b3a.0;
        Mon, 04 Aug 2025 00:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291889; x=1754896689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vTgXvqL0YXUEOeNxXpdovH462H2b22Hy/IbslpJAsk=;
        b=ZvKi/BBaJv2jNhgz5bbXl/VU/cJ9764SWW9zqeJVDJGvV2bEx730OWdKZP1scKBOFO
         XUhk8xJWVqjh1II0TXhvjSW6m2Dm92wj8cij0Q9WVewkqxxdTUeU05yj/D543EKgmxrr
         9SU5snnOttVnyKsihDkgMb/7QO1qKV4VrIRdiH0kXglPXAaIaQyG0cV7eND+AQA/BVrW
         e6H8oWQk4mGSQpipGP4LyJRKw0nz6za+k4xcT775KQr/LBk97tRI5aDu96ZgyATvP7km
         VHcCrsHEpZafpQUKAu2rKqPzLRotMl1UMec9YRMYk0P9sv82Sue0hgLbHdfBwmj705zz
         EeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291889; x=1754896689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vTgXvqL0YXUEOeNxXpdovH462H2b22Hy/IbslpJAsk=;
        b=ip0s4wTj0nqL+rFL/OEJSdn2gCmFYeWFnmNZDgAAvxuJAIOf3CfMY+Yq+dGUZDTufw
         1/dEn209MGeWsBktJ2s/WnPfjBtKwo3EhcUDbiFHmNkI4egsMStfrWUxzxsDQQNlEUF6
         0Ff8P9JHDuCHIGrAnDPoV7NHlIMZ9su2EFFgvbgM4hWpDSvug+n/+9/SjYJv2ZDERk5X
         8A5XadWGVtHXR1SfoUfT3gyKzDn4olyUaymkOZQ/ojGCCBvzIKEYdjikdk1uSzSHshwz
         3JOGpOHl/HX8v1mmPcmyabMepeWNxHz5nQ8OiGOctd+bM1pOuUPjv95nW2dAAjAwi6DG
         yL7w==
X-Forwarded-Encrypted: i=1; AJvYcCVqxa1BWAWtNKEjJOaa4VPpw4fFBpQfx1hOfrrCvl2mUEaSP9jpxBDGg0UlxReprl/RxqaKhAZ9KpQvCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydQ2gismztvRiskbSUzQRID2lYJ3OidBklf4nyJssHV9Ub76IQ
	4nQi03iuRy37dzexHiS2grjU5O2QZy0U/iFyID97jlKoyOtT+YAmbMzs
X-Gm-Gg: ASbGncsAnPneKToAbVwNL1KDzVzUz4aMat4zblqe9yfNt3OKf9AYdv2h2u0lnZvqPnQ
	PMt2pyeXK1nhtEztqxXbO3bY/ee16O+kQHWaai3ynGiQkFKRzRtViJwCceb5HqYaasCSywRCRIl
	OqQPIpqB2VFKxi8kF9GZrvolNLRSjXQdWt+Y2DTBmVs4xv5rXBPUzGsnF1t4PK6m44KZqf2hKnM
	GttRWOko68R4oR/RCruCoAczMu6PucvsMi8XTVATkEpSNJ02hnfAz77iuIH+IBGcCz5jo/EELwc
	oFQuh5ytBSV8cpsObqKLM9Fu832nCF9pkkq/1QwRzL9kw/Hb2ya3CD5jfqTH1NhWWsjEYFDS7NJ
	1YpzFEHJXwbS7vBx0fnq8DC7+WWI4WZQg347zwCXeVzQ=
X-Google-Smtp-Source: AGHT+IETRnzvaNkRjVPQGA8zx0QGDsh/isj2Ruz/+kwWy4XdfRF+VrT8H9xDu1fT2CTQbcIIkcTPCg==
X-Received: by 2002:a05:6a00:1905:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-76bec4b6564mr9714286b3a.16.1754291889209;
        Mon, 04 Aug 2025 00:18:09 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfaf78c94sm3126336b3a.19.2025.08.04.00.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:18:08 -0700 (PDT)
Message-ID: <669aaa3b-3a56-4729-94ba-5570079266a9@gmail.com>
Date: Mon, 4 Aug 2025 12:48:04 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] generic/563: Increase the write tolerance to 6% for
 larger nodesize
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
 <aIh8NT2DhablZp5G@infradead.org>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aIh8NT2DhablZp5G@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/29/25 13:15, Christoph Hellwig wrote:
> On Tue, Jul 29, 2025 at 06:21:48AM +0000, Nirjhar Roy (IBM) wrote:
>> +# writes, due to increased metadata sizes.
>> +# Hence have a higher write tolerance for btrfs and when
>> +# node size is greater than 4k.
>> +if [[ "$FSTYP" == "btrfs" ]]; then
>> +	nodesz=$(_get_btrfs_node_size "$SCRATCH_DEV")
>> +	if [[ "$nodesz" -gt 4096 ]]; then
>> +		check_cg $cgdir/$seq-cg $iosize $iosize 5% 6%
>> +	else
>> +		check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +	fi
>> +else
>> +	check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +fi
> Everyone please stop hacking file system specific things into generic
> tests.  Add proper core helpers for this instead.

Okay. I will try to work something out. Thank you.

--NR

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


