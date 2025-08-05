Return-Path: <linux-btrfs+bounces-15868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B64B1BCBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 00:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4732116D851
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22543264A92;
	Tue,  5 Aug 2025 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IY4ExO2p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB821DF759
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433720; cv=none; b=J4bYgH4bWUEJnLV+uit/w8rBQXoTfCCrCFUTRIKjp311JB685qa3gc0zgVsQXu+RO64DqOFdRrHp/RzeDRGqP7a3zSopU7G2tZyax+9UenTp8Z4pGtyShDj+SSLClSnt3RWeT1LzeWaaN+QCEZ3vj60AtnO0HF96guXddmjEHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433720; c=relaxed/simple;
	bh=ebFKkumr/YpiTGCZeh3Qqn0D90IQJz6xMivtVZcWgM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBc8+2dq64HqVBixxfuD3eyXlLMrP5RBI4CavjwdLmyJw84APAun8AEx4+FRW1kevVFOBEu9bRWy6xXRUaMYM1ARo78o/CqdvaJ99fMtLexp+Npb9NMmiu9ZPxcN9an4uLHUrxEWopW9bcWHGTg5PoL4IjB5gEC3UtUv5pN6GAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IY4ExO2p; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b79bddd604so4051030f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 15:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754433716; x=1755038516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gpSOSPpdw53wn3n0oElrX36hW6LZFoH4es7koAVtl0A=;
        b=IY4ExO2pwhbnPHJI4yFnyKpdiUEJfCuTvFOwbX1YPl6R9S4R+WvQ4S2T/ii4W6oulC
         DhF8CIuq5K92uT2+Ie1cRVl0E7SpXdnh1pQP0LAlnXOGWmOGyfAdzwv/6ia8xC45/PL7
         1kaJUEhmbHpfoR/TNCQ4d/hspdm4DlwXqhjuLIgM8xvPNIjqx8LcEtc0zNC8B+RP9L6P
         QY/sb/tUkfJptBAgKS0FshSs3I+hlXCfMbc9+rm9QsEAktkIWoefqZizu+VaZaP9Lxyy
         TV7pkpuV7DUJo29WQ49XIbpVp3SyrgfL9SHFg9h42RPQDYIThKmm5/BgmRuFGMmR/qxr
         /KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754433716; x=1755038516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpSOSPpdw53wn3n0oElrX36hW6LZFoH4es7koAVtl0A=;
        b=u4IOL1uqWTShR2JCPOaxNub8BgVY1XOZXj8h/lcgmyauJzfBdOvkbMoDKTXuySTdVV
         7Nx6ddalaL3+E1HeHiLcQNCbCjforjvvGD138DNCSNahEkOliFOiKfKWANo0mJR+PCxc
         0x8dbP4JVW3j7pK91pL/zPrM0MPPZKn2itxW7A5QFXP0/JPHWz40pAXopdvXf8g3XDFX
         gP+xdlgYP5vWaaE//DxMSacBy1zPr8nmGLSXEGAo7YJgLpIQDu/JkdNLRi9dEVPcspRG
         /j4rzDPE33JHNuBXe0dXFM60vIHZz5axkY2TbKa2dyppTsrcOiGZbAObfKlgJVQgPDX0
         pN0A==
X-Gm-Message-State: AOJu0Yy4EPDgvGTa1U9LRtWTfzf9jtiq0gc2NJQbH+m1z4JZLQXhES4f
	TFtwPEtNvhAVtVd72FeCNoVLsHHw7jdM2/owyUnkBfKRTgqz3eYjEh2aNSenwxDvTvk4swTMYfu
	YrXzC
X-Gm-Gg: ASbGnctKJqZSZhqlUnpIq1D2gK98S5qGLlFuLUe2EgenryNbKLpLlRscGYge0Qzw/Gp
	7KI9F2hY58ebkFh+twTvtB+t4gGAhPiRgMZ8rX1I3HHDwnOAhmRRFIExqzsrZ7FEBAMfS8O93jK
	e3Udxhtx2PlOuNEbNrfzuQENViGGY2kKl58SDo/rKKd09Ca3dOm9+kVaNvnv8pWjJqAAvu1RAuh
	6CUAvCDO76q7+gcAkdrlHvVkxRZRai2XpMN0PEiFP7GkQ0efaxk0NxAqKoIS74EjLkmgB++O5Z6
	cHNELedbb2jRrp5K2qzdUkMyLOGZLD51Kc2wDhqyxDMtLW6TTf898IpjN9pqOMpEju/qyOQvrvx
	eOR6nnmTmoRKQcHAQFGe2ntNpc1UsSDYu9odh+SqjbfUr/NDvAg==
X-Google-Smtp-Source: AGHT+IGNyGFyfFBq4/PKvwPhsYF/OZLiFTjqadgR5uMIRYx/AGfYPGrooXBBozFm4uVerdC46awgZA==
X-Received: by 2002:a05:6000:420e:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b8f41ee87cmr495156f8f.56.1754433715785;
        Tue, 05 Aug 2025 15:41:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce84sm13979940b3a.71.2025.08.05.15.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 15:41:55 -0700 (PDT)
Message-ID: <2e0e7b8c-22f8-4e17-8c0c-6047ea21c91a@suse.com>
Date: Wed, 6 Aug 2025 08:11:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs-progs: add error handling for
 device_get_partition_size()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1754116463.git.wqu@suse.com>
 <525dbf649790b855d109714bf9a82796fe3d7b1e.1754116463.git.wqu@suse.com>
 <20250805190838.GB4106638@zen.localdomain>
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
In-Reply-To: <20250805190838.GB4106638@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/6 04:38, Boris Burkov 写道:
> On Sat, Aug 02, 2025 at 04:25:48PM +0930, Qu Wenruo wrote:
>> The function device_get_partition_size() has all kinds of error paths,
>> but it has no way to return error other than returning 0.
>>
>> This is not helpful for end users to know what's going wrong.
>>
>> Change that function to have a dedicated return value for error
>> handling, and pass a u64 pointer for the result.
> 
> All the callers check ret < 0, rather than ret != 0, so any reason not
> to simply return the positive value in case of no error? Signed
> overflow?
> 
> In the kernel, BLK_DEV_MAX_SECTORS is set to LLONG_MAX >> 9, which I
> think means we are probably OK?

This sounds reasonable, I was under the impression that we need to 
preserve the full U64_MAX for block devices due to our on-disk format.

But if kernel has extra limits, I'm more than happier to use s64.

Thanks,
Qu

> 
>>
>> For most callers they are able to exit gracefully with a proper error
>> message.
>>
>> But for load_device_info(), we allow a failed size probing to continue
>> without 0 size, just as the old code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   cmds/filesystem-usage.c |  9 +++++++--
>>   cmds/replace.c          | 14 ++++++++++++--
>>   common/device-utils.c   | 29 +++++++++++++++--------------
>>   common/device-utils.h   |  2 +-
>>   4 files changed, 35 insertions(+), 19 deletions(-)
>>
>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>> index f812af13482e..e367bffc3a01 100644
>> --- a/cmds/filesystem-usage.c
>> +++ b/cmds/filesystem-usage.c
>> @@ -820,8 +820,13 @@ static int load_device_info(int fd, struct array *devinfos)
>>   			strcpy(info->path, "missing");
>>   		} else {
>>   			strcpy(info->path, (char *)dev_info.path);
>> -			info->device_size =
>> -				device_get_partition_size((const char *)dev_info.path);
>> +			ret = device_get_partition_size((const char *)dev_info.path,
>> +							&info->device_size);
>> +			if (ret < 0) {
>> +				errno = -ret;
>> +				warning("failed to get device size for devid %llu: %m", dev_info.devid);
>> +				info->device_size = 0;
>> +			}
>>   		}
>>   		info->size = dev_info.total_bytes;
>>   		ndevs++;
>> diff --git a/cmds/replace.c b/cmds/replace.c
>> index 887c3251a725..d5b0b0e02ce1 100644
>> --- a/cmds/replace.c
>> +++ b/cmds/replace.c
>> @@ -269,7 +269,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>>   		strncpy_null((char *)start_args.start.srcdev_name, srcdev,
>>   			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
>>   		start_args.start.srcdevid = 0;
>> -		srcdev_size = device_get_partition_size(srcdev);
>> +		ret = device_get_partition_size(srcdev, &srcdev_size);
>> +		if (ret < 0) {
>> +			errno = -ret;
>> +			error("failed to get device size for %s: %m", srcdev);
>> +			goto leave_with_error;
>> +		}
>>   	} else {
>>   		error("source device must be a block device or a devid");
>>   		goto leave_with_error;
>> @@ -279,7 +284,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>>   	if (ret)
>>   		goto leave_with_error;
>>   
>> -	dstdev_size = device_get_partition_size(dstdev);
>> +	ret = device_get_partition_size(dstdev, &dstdev_size);
>> +	if (ret < 0) {
>> +		errno = -ret;
>> +		error("failed to get device size for %s: %m", dstdev);
>> +		goto leave_with_error;
>> +	}
>>   	if (srcdev_size > dstdev_size) {
>>   		error("target device smaller than source device (required %llu bytes)",
>>   			srcdev_size);
>> diff --git a/common/device-utils.c b/common/device-utils.c
>> index 783d79555446..6d89d16b029d 100644
>> --- a/common/device-utils.c
>> +++ b/common/device-utils.c
>> @@ -342,7 +342,7 @@ u64 device_get_partition_size_fd(int fd)
>>   	return result;
>>   }
>>   
>> -static u64 device_get_partition_size_sysfs(const char *dev)
>> +static int device_get_partition_size_sysfs(const char *dev, u64 *result_ret)
>>   {
>>   	int ret;
>>   	char path[PATH_MAX] = {};
>> @@ -354,45 +354,46 @@ static u64 device_get_partition_size_sysfs(const char *dev)
>>   
>>   	name = realpath(dev, path);
>>   	if (!name)
>> -		return 0;
>> +		return -errno;
>>   	name = path_basename(path);
>>   
>>   	ret = path_cat3_out(sysfs, "/sys/class/block", name, "size");
>>   	if (ret < 0)
>> -		return 0;
>> +		return ret;
>>   	sysfd = open(sysfs, O_RDONLY);
>>   	if (sysfd < 0)
>> -		return 0;
>> +		return -errno;
>>   	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
>>   	if (ret < 0) {
>>   		close(sysfd);
>> -		return 0;
>> +		return ret;
>>   	}
>>   	errno = 0;
>>   	size = strtoull(sizebuf, NULL, 10);
>>   	if (size == ULLONG_MAX && errno == ERANGE) {
>>   		close(sysfd);
>> -		return 0;
>> +		return -errno;
>>   	}
>>   	close(sysfd);
>> -	return size;
>> +	*result_ret = size;
>> +	return 0;
>>   }
>>   
>> -u64 device_get_partition_size(const char *dev)
>> +int device_get_partition_size(const char *dev, u64 *result_ret)
>>   {
>> -	u64 result;
>>   	int fd = open(dev, O_RDONLY);
>>   
>>   	if (fd < 0)
>> -		return device_get_partition_size_sysfs(dev);
>> +		return device_get_partition_size_sysfs(dev, result_ret);
>> +
>> +	if (ioctl(fd, BLKGETSIZE64, result_ret) < 0) {
>> +		int ret = -errno;
>>   
>> -	if (ioctl(fd, BLKGETSIZE64, &result) < 0) {
>>   		close(fd);
>> -		return 0;
>> +		return ret;
>>   	}
>>   	close(fd);
>> -
>> -	return result;
>> +	return 0;
>>   }
>>   
>>   /*
>> diff --git a/common/device-utils.h b/common/device-utils.h
>> index cef9405f3a9a..bf04eb0f2fdd 100644
>> --- a/common/device-utils.h
>> +++ b/common/device-utils.h
>> @@ -42,7 +42,7 @@ enum {
>>    */
>>   int device_discard_blocks(int fd, u64 start, u64 len);
>>   int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
>> -u64 device_get_partition_size(const char *dev);
>> +int device_get_partition_size(const char *dev, u64 *result_ret);
>>   u64 device_get_partition_size_fd(int fd);
>>   u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
>>   int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
>> -- 
>> 2.50.1
>>


