Return-Path: <linux-btrfs+bounces-10616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5559F83CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 20:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4198518815D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864611A9B47;
	Thu, 19 Dec 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmMpbFfE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CC1A9B27;
	Thu, 19 Dec 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635327; cv=none; b=l6+mbq6cpYu9Wt3Qu1I/EVtbBXRF7nRhnoqUBJ4owKkjt2qLJfWVdFREs0yhYqAMfIXPopySuAiaRxkLijzPe8rPSY2Wjc6LM5SWwMu+duJPoc2hkfmkgYhXR33tudCvn3DLIwdvIIEwxkdMYf04i47le5LmnrsGMedPf2dtctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635327; c=relaxed/simple;
	bh=zqFlMGMww8x7VbVatarrvJcxlzPWchRJCnbsOQFVQqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHFD/+P+xQc0In9K4iWL+hTXBcN0otBRygUug0r0SyfCBKL/11SDIBtEhTRoNCrYT8nRM7XKywQPz2REacv7qDVoSN6pM4cP/Lccg8zI4Ocub1vZuRyAwRVsDtnEuGnHPzXwcIFpNza3BinQiydAHdb/5ToJhu4e4tFKeFWeGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmMpbFfE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e3621518so612468f8f.1;
        Thu, 19 Dec 2024 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734635324; x=1735240124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fnlds2Siuf8LVxsHGBj2fzy8VLB3CDmLvK64Ua9Njw=;
        b=nmMpbFfEXjSsrHfjdIuPE8AGPuJnpp1eRRE0hUf3zF+bhiCOnvY30/VRvbi2jC2+wL
         kkuXENGqrOWA81h85uht3zuui0ug5hsU+RPuZX77FbEHQSeVq3Nu9LNai2L8jxDj8aS3
         yVfLEQWBEIAqqnNrdqLvjqR6Ms0tp/8s7zVn8eDIpfEl8C7dPh9IOzKPJCSiHdzf0+vu
         pVbQrmFDnK7J+BAGIYP6tK2GpcGiOxtHrvmQJfnd39OkngNmgq57RYFO/DQ9SNSSF80b
         jNQ553hLvkS/IJxI1gyDoEhx+PWLKM2GCYoG0E8QKg1RuUA5+3AAREDgJDS0U9nh5gRo
         dH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635324; x=1735240124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fnlds2Siuf8LVxsHGBj2fzy8VLB3CDmLvK64Ua9Njw=;
        b=me9H/XMLqjiHSnJ/quDEHJ2DWCVdzqkqDnxoqGBC3I/5HfZePhpy1sohZGFl3hDgRg
         cqIb0SdlZp9ijr8lCIt6ZKBNTqX8UQ2W2kcriLWfzcL44Ia4MqE5WO5gEPsidIB0wngJ
         d78n10IJynu2SZPbkmzdJyXflVUT7F1hBYXy3Wqw8D8pATaHfpNNXByvhqCYG+7vCL+s
         V8Xxpuy3LN7a6xOcvw0Tk4uRPBC1CXhF/+LbHS6cLhaumFkmzxFtg20g8yny+5eJTXke
         m3VH/rKn6ijzrT+ntnPTSGHDH7+LV+BoFln8Z4m7gJYoNKL8aPUFY94J662oXwNTM7jh
         yejA==
X-Forwarded-Encrypted: i=1; AJvYcCVGl32doS5zHyhm0SMznh32nu33tuaN+inti2AQPE+EznlA9N2trEwpuyivkFqqN0l72b8qcc55gjaO7A==@vger.kernel.org, AJvYcCWHuJMOK9SNzSpuxkOCymzZzntDN8QlUusIOOfU6hoeAi8XplhjSUtN2v7M2JAw3cJIiHJWfNnRD3s93KtM@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUqL/7nOduFisx69sCoIGInGAssCNUqoly6LnLd0OusOzZBNA
	UeC4YAS39GoqUXbyXWXypoZlF2EYO8p8sIGoVv1svUtzp5RY5X0C
X-Gm-Gg: ASbGnct5VnWlNn/FfBYLKkNBpSqcuBjeeR5T0gPdOOuzX++8DiTZqL5aToitC5evJ/N
	YpOAeW6AhOBloc3LE59HoP8g6EKQTKeYCl5vZSJBAAbYB8ujR/QpdKnmskrF0TX2x9sX5s4fH85
	I2Op3lut8OtCupE94p7DXQXPzAtz1nT8+qmzi/DrkN4j94EExxHVHFznFvWIP9uKP9vJXw+d7GL
	0MmM70+USPfRHVwI5q8bsdlcXkfECluYEHblKvRYfcUfRuJldEoLKH7n13SGNE8PQ==
X-Google-Smtp-Source: AGHT+IG8iZiSbm1HlR1t/CABhx5+LDjCdSZgKiCJTuap3K/iUYNwm2eXWvtKFeQKXV0U36wVUR2DiQ==
X-Received: by 2002:a5d:5e09:0:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38a223fd75amr278942f8f.51.1734635324067;
        Thu, 19 Dec 2024 11:08:44 -0800 (PST)
Received: from [192.168.1.240] ([194.120.133.23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436612899f0sm25367225e9.38.2024.12.19.11.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 11:08:43 -0800 (PST)
Message-ID: <6b17563a-dd94-4ca8-8ab4-3b3aa86e4d36@gmail.com>
Date: Thu, 19 Dec 2024 19:08:42 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: add btrfs_read_policy_to_enum helper and refactor read,
 policy store
To: Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cd8135e4-2de5-48d7-a7de-65afb201b3fe@gmail.com>
 <38a661e3-f8be-4511-8be0-d16c589a540d@oracle.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <38a661e3-f8be-4511-8be0-d16c589a540d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/12/2024 18:59, Anand Jain wrote:
> 
> Hi,
> 
>   The changes have already been submitted and will be included in the 
> next re-roll.

Thanks for the update.

I noticed the fix was:

strncpy(param, str, 31);

perhaps that should be based on the sizeof param, e.g. sizeof(param) - 1 
rather than a hard-coded 31 just in case the size of param is changed in 
the future.

Colin

> 
>   https://patchwork.kernel.org/project/linux-btrfs/ 
> patch/9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com/#26168805
> 
> 
> Thanks,
> Anand
> 
> On 19/12/24 21:10, Colin King (gmail) wrote:
>> Hi,
>>
>> Static analysis on linux-next today has found a potential buffer 
>> overflow in fs/btrfs/sysfs.c in function btrfs_read_policy_to_enum()
>>
>> The strcpy to string param has no length checks on str and hence if 
>> str is longer than param a buffer overflow on the stack occurs. This 
>> can potentially occur when a user writes a long string to the btrfs 
>> sysfs file read_policy via btrfs_read_policy_store()
>>
>> int btrfs_read_policy_to_enum(const char *str, s64 *value)
>> {
>>          char param[32] = {'\0'};
>>          char *__maybe_unused value_str;
>>          int index;
>>          bool found = false;
>>
>>          if (!str || strlen(str) == 0)
>>                  return 0;
>>
>>          strcpy(param, str);   /* issue here */
>>
>>      ....
>> }
>>
>> Colin
> 


