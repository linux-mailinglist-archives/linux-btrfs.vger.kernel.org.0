Return-Path: <linux-btrfs+bounces-16011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF6DB21E52
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC806254CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 06:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD41A9FA2;
	Tue, 12 Aug 2025 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naGyzRoA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC5311C18;
	Tue, 12 Aug 2025 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980238; cv=none; b=mx3/SSKnxaalyS8ussIjLsV1tAV9g9ESc5dcQ/Tt84THGiXR6+lKUCZcie9N3FQLLkCqPMvlSrkVLOofUBwAwQecLE6ew1OH2s8R5azOnjQSB3HT9syxEx8jw1L35gA4fUYTQzt9uqThldtBTViiGzjsed8xOnekRDnUZswNwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980238; c=relaxed/simple;
	bh=wQROX2uMcO7OZGN2UqbZRMB6VfoL+J4RMqAC+ez2a4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5rp1nrByZD+j0QxJ2BhUuM/082ar8xMPYh5UW0UrHrxBxa+Bn5tHJoWRvcVJ4LxwVz2+OV7l4h0+O94tsNhIWd7Ns4XLmN/9EkApnbgahZGxRAQEFP2XlNAF6P3v3FThSvaJ6qR4z5/QNM6w2Jxz0eQCU7j6UgiU9MNs1wUnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naGyzRoA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4209a0d426so5113644a12.1;
        Mon, 11 Aug 2025 23:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754980235; x=1755585035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq3BM9Unf3jY36f15urqBH4/0JvOnoLRTMX0xksEsJ4=;
        b=naGyzRoA7c9qjy/vonce35ZY8wzPf5V4aF/TshESdWB7BFtb3XV8Zl8VP2NfRxQeiA
         zSmYEr8kWbiND/L2uOwjQDhu8vinI1AYsZK3ZZ41FeeCOaFxEQDHncspY/HzP22LH7k8
         e3Dnrezw2761xuCF5GJNQl2e5pF1z1zvmxaiAtju+699JZJG0kjZlINEfmgL2BqM35o4
         hpGgd6ipxUFtRN8fnzKCg3HQGgYaL8Iidc17k8/rKf61j6Rs8i+9N9W1DxTDEloUxcDU
         YoqvQEXRqzU+VAgAsBaOY/Cz++FgKGCmgDCz65j4buXKlEg4VHmt18LitTsJxgpIBM47
         VRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980235; x=1755585035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq3BM9Unf3jY36f15urqBH4/0JvOnoLRTMX0xksEsJ4=;
        b=PETfttfip9BSV7q/4g7jiPiPSsSKaR3D/Hw3JzX5mCqtvHG2B7q+6S1Uf+zngSPSu7
         xTjucBjveIBB5zyLhtAmaUQbZ7eoCJ35FagP8Zl8eNodV8w18wFVvR3NgxVTBonVPSDq
         sbzqu5sxJF7u+I6wIR0+pyN2ZgPre3T51ezZFe017fd4KJQfEyW3/OnQS5q1/WiQEkW8
         xvzPtJkVMMSxe9SbPm6hmBiU6NlJmtkKtD6uOEFL+OP0w5N0CyISh1JO3CJzxoTMtBPm
         FrqUha6In2a5rCCe2g4D/Friht5ZJKqaLmUfVx5IuWTo89cYKRior52su0VXH18xe4tG
         vUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJKDhQWLfIebmo/zGcS8d+QbZIiieczjgPa+2qIxXKbXRSqJUQp07T5Cfr6d0iEIi8vQzI6xnd@vger.kernel.org
X-Gm-Message-State: AOJu0YwLyHnm940r+7YMVSzYxQy/yalv4gzyoKTj9sV3a9JhXWeTR219
	f8qBDs8RoEUBohfIWFcGvvV/1Ph6tdaFOzNxSwp/AWCxIrLGanANtx/r
X-Gm-Gg: ASbGncvL8Svy7y65H+nCHM/AvbeXoJjgD3j0TLiKTbJajPSR4+DRDczv5/s/HrVi8wc
	KQxVhLRKlIiXS0SfUDzRUKwFzFMJiiZYE13tgXAvMAXGO+CpUtfWirJkZUsDsKszsRTkmu5YwDQ
	wOMtCH02ydJeYQ/Uc+HrpNOgqiOEH7XLlMHQZuATnbuu4RQ4N1g476Xc0hOUYC0iXfdhUvrv8Nr
	7O9aEtB61+GP5YTbmRvQ0Co789vH25gTOTO0x7MOO3pOe0bFqCP+uat2G0Si0YlM4f1sO02Hjra
	wSQHsg4YdtgeokpRC83Qg2LOCRDFuV/S2hOdDZsWX4poUAtPVY24wtShP6UUySeeT+yEcQyzz4/
	yNUCXaZux3V0pcH3nf5wqepIbcbUXvsBy
X-Google-Smtp-Source: AGHT+IGbb4F2Z30sgOjkCjoWJ9HNhJJ6Gw//T1I2PtkmGiX8I3jp+X6NWAvvSd1PsEQJTFUy6Kluyg==
X-Received: by 2002:a17:903:1acc:b0:242:9bbc:6018 with SMTP id d9443c01a7336-242fc37297cmr31725215ad.56.1754980235107;
        Mon, 11 Aug 2025 23:30:35 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef75bdsm289288445ad.11.2025.08.11.23.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:30:34 -0700 (PDT)
Message-ID: <2ebb81e6-4f65-4b08-996d-67dccfe48b1a@gmail.com>
Date: Tue, 12 Aug 2025 12:00:28 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs/301: Make this test compatible with all block
 sizes.
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <a8233808db2ee1d7c5fe7ee8710388bb0cb8f787.1753769382.git.nirjhar.roy.lists@gmail.com>
 <1b7aa1de-a544-4387-b776-9816a5058f87@gmx.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <1b7aa1de-a544-4387-b776-9816a5058f87@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/4/25 10:02, Qu Wenruo wrote:
>
>
> 在 2025/7/29 15:51, Nirjhar Roy (IBM) 写道:
>> With large block sizes like 64k on powerpc with 64k pagesize
>> the test failed with the following logs:
>>
>>       QA output created by 301
>>       basic accounting
>>      +subvol 256 mismatched usage 33947648 vs 4587520 \
>>           (expected data 4194304 expected meta 393216 diff 29360128)
>>      +subvol 256 mismatched usage 168165376 vs 138805248 \
>>     (expected data 138412032 expected meta 393216 diff 29360128)
>>      +subvol 256 mismatched usage 33947648 vs 4587520 \
>>     (expected data 4194304 expected meta 393216 diff 29360128)
>>      +subvol 256 mismatched usage 33947648 vs 4587520 \
>>     (expected data 4194304 expected meta 393216 diff 29360128)
>>       fallocate: Disk quota exceeded
>> (Please note that the above ouptut had to be modified a bit since
>> the number of characters in each line was much greater than the
>> 72 characters.)
>
> You don't need to break the line for raw output.
Noted.
>
>>
>> The test creates nr_fill files each of size 8k i.e, 2x4k(stored in 
>> fill_sz).
>> Now with 64k blocksize, 8k sized files occupy more than expected
>> sizes (i.e, 8k) due to internal fragmentation since 1 file
>> will occupy at least 1 block. Fix this by scaling the file size 
>> (fill_sz)
>> with the blocksize.
>
> You can just replace the fill_sz to 64K so that all block sizes will 
> work.
>
> Just tested with 64K fill_sz, it works for both 4K and 64K block size 
> with 64K page size.

Okay, I will make the test work with 64k aligned values (similar to 
suggestions to the previous fixes in this patch series).

--NR

>
> Thanks,
> Qu
>
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/btrfs/301 | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/301 b/tests/btrfs/301
>> index 6b59749d..7547ff0e 100755
>> --- a/tests/btrfs/301
>> +++ b/tests/btrfs/301
>> @@ -23,7 +23,13 @@ subv=$SCRATCH_MNT/subv
>>   nested=$SCRATCH_MNT/subv/nested
>>   snap=$SCRATCH_MNT/snap
>>   nr_fill=512
>> -fill_sz=$((8 * 1024))
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount
>> +blksz=`_get_block_size $SCRATCH_MNT`
>> +_scratch_unmount
>> +fill_sz=$(( 2 * blksz ))
>> +
>>   total_fill=$(($nr_fill * $fill_sz))
>>   nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super 
>> $SCRATCH_DEV | \
>>                       grep nodesize | $AWK_PROG '{print $2}')
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


