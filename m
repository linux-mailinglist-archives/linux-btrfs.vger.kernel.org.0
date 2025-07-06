Return-Path: <linux-btrfs+bounces-15268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A52AFA2DF
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jul 2025 05:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFCB3BF1D6
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jul 2025 03:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12E19004A;
	Sun,  6 Jul 2025 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WdjkExy5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D83A1BA
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Jul 2025 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751773050; cv=none; b=RwwYVYu14b1Vgr6qFlCKWJt/hUfunPwBMgwWs4GNsSfIJs+QL0RHr2rfNVZwGV+Aye6WErDOqVG0WkiPcFGab50sFwpDh0xUJEhbbNyAIa4CVjzC87VGo3vQHOoJJ4WTfQtbPZBqxuQ0kLq6QomboaQCSLsqzcRolmQq/Z3q53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751773050; c=relaxed/simple;
	bh=nxCvvt+md57djP10/vqkAB5m81CXVghLF0DzPPw+hl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2RKdZvK36XN8qtf84n11TE5yaXgJjvaRxoXtpxdCus8QpF6LMnfnZj/MaqCaSCOpZ45DkpawzNveRhHRK2pCX1PFi9mVOmCt/XlU6KJrWhvGCoHWTvlqmYRheMxZ86t5UAXoMtC37bi99HzC+b5gRRl+wNKRvJ0Mll9/hKNp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WdjkExy5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso885981f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Jul 2025 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751773047; x=1752377847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uimqJ7Q/zYULB0k1zkbdsBjAIwCCdenpD3Zq/IQP814=;
        b=WdjkExy5jrMp9BwVs4J4pWLAaaTuV2P0K4l6sjg3OK6h8wE3cHM+Hpi2vw5sVfUb2w
         3+q3rEj5CwB4xAstbzPosMd0nuxiiY9QYtoryNyAAbpYmqWL8TzzAXAOuAWJAQWA7Tn1
         dMO1mdc+A5VG3ex1vP0wEpL3IKOl/mUZnkcIx9y0bAJDNUiont9Hrka5crunkpqufe2P
         BMTbVxUaysO01WEG3UVjvS8oPtLyRKNvVnzvXDV575UlCgevsr2+6/YOJfUALAlqlj2U
         T9cM+Dq+C0M4L391VRO+wvHYd6jfAtxQTF8CF46Z0TnenPdHGkuA8Ua+R1E2zPgyzuDE
         jWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751773047; x=1752377847;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uimqJ7Q/zYULB0k1zkbdsBjAIwCCdenpD3Zq/IQP814=;
        b=QCnQURcsgw6bqvyhnNbfXInMFIvgulqKHGunnPLUZcV6w6rYK09JyS54kJzfiqNRnT
         1b57REa08QkScAhna4mRzF231yQT2h+fm4KqfBxD3pQTVzq0n/RTBEbOJzLgo8zxqmJP
         WPU/xbvyw8v0txdd6JH9/46gCImvnvL0GfkoWEY4mn5l7iVFcPnPSEgW8CGgMiQmOS0v
         oNSG1o1to0PcPTX9DQTk4ZtGmx0H9WdZaZPtDfBADLi3zNVgf/SkgwkGLJHcPE22Oe5R
         IneFiotuiJhYi+fkgSYOhtBfO6T04eTMaW7T6tZ5GgmVnvJrbXMCYn8ZqdjP3uJpACPJ
         BxuA==
X-Gm-Message-State: AOJu0YxvmFIrrjPl6h+sUPmU3p1zdI9fXGb8EFBpYzXijTuCR5ncyZ9l
	AQFfC6spLKdeYjn2bl+qxVK8Eyc7wTkGKXcUEeSr8unljauZatK95de6NRyuYnEYI1Y=
X-Gm-Gg: ASbGncvTR+UmY1HeM+49yvqzSn2TEhJqs57CMJQm62wOCg4nnjySD5YlgQ0xSiFpBl9
	myXfS/C7AYnlirmZOxcX3qgQrUbH+XXKu4EvXrf7kBTaWNUsChJs24hpHrBOsvFpm94Ckx5REFr
	WXrhft6GGVcrINcW75nqt3yykVgzx9opQHKyycbQ/e1WGgnBkHPs+i2WxDIvsQGiO8pXJcoUE95
	5ClY4qaaKEE0O0q0fdNuh5XCxlM1FabAXlQEMhEisFlN4erX5Sxpi1BJGHMkks8vJ5i5YQxymHN
	1e4cGefJxeOlagNkAxJQid+/2Wm16KQJ0oTR9FjjFzkg3Y5yUC6/AFWaZH4VrrKwaj94XsMUjU9
	dMcT3eLVOBNRoRg==
X-Google-Smtp-Source: AGHT+IGlvFM8Q5ovcZC4SNydrrGv1juSo9zK/sjcWGNAHRCEcLuhxK/NI5Qt/fySOIGBgX0nc3jlWA==
X-Received: by 2002:adf:e18c:0:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3b49a97693cmr2824900f8f.0.1751773046461;
        Sat, 05 Jul 2025 20:37:26 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84598b70sm57453105ad.204.2025.07.05.20.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 20:37:25 -0700 (PDT)
Message-ID: <6642f8b5-d357-4fb6-a295-906178a633f9@suse.com>
Date: Sun, 6 Jul 2025 13:07:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] btrfs: implement shutdown ioctl
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
References: <cover.1751589725.git.wqu@suse.com>
 <5ff44de2d9d7f8c2e59fa3a5fe68d5bb4c71a111.1751589725.git.wqu@suse.com>
 <20250705142230.GC4453@twin.jikos.cz>
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
In-Reply-To: <20250705142230.GC4453@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/5 23:52, David Sterba 写道:
> On Fri, Jul 04, 2025 at 10:12:33AM +0930, Qu Wenruo wrote:
>> The shutdown ioctl should follow the XFS one, which use magic number 'X',
>> and ioctl number 125, with a u32 as flags.
>>
>> For now btrfs don't distinguish DEFAULT and LOGFLUSH flags (just like
>> f2fs), both will freeze the fs first (implies committing the current
>> transaction), setting the SHUTDOWN flag and finally thaw the fs.
>>
>> For NOLOGFLUSH flag, the freeze/thaw part is skipped thus the current
>> transaction is aborted.
>>
>> The new shutdown ioctl is hidden behind experimental features for more
>> testing.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c           | 40 ++++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/btrfs.h |  9 +++++++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 2f3b7be13bea..94eb7a8499db 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -5194,6 +5194,36 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +static int btrfs_emergency_shutdown(struct btrfs_fs_info *fs_info, u32 flags)
>> +{
>> +	int ret = 0;
>> +
>> +	if (flags >= BTRFS_SHUTDOWN_FLAGS_LAST)
>> +		return -EINVAL;
>> +
>> +	if (btrfs_is_shutdown(fs_info))
>> +		return 0;
>> +
>> +	switch (flags) {
>> +	case BTRFS_SHUTDOWN_FLAGS_LOGFLUSH:
>> +	case BTRFS_SHUTDOWN_FLAGS_DEFAULT:
>> +		ret = freeze_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
> 
> Recently I've looked at scrub blocking filesystem freezing and it does
> not work because it blocks on the semaphore taken in mnt_want_write,
> also taken in freeze_super().
> 
> I have an idea for fix, basically pause scrub, undo mnt_want_write
> and then call freeze_super. So we'll need that too for shutdown. Once
> implemented the fixup would be to use btrfs_freeze_super callback here.

It may not be that simple.

freeze_super() itself is doing extra works related to the 
stage/freeze_owner/etc.

I'm not sure if it's a good idea to completely skip that part.

I'd prefer scrub to check the frozen stage, and if it's already in any 
FREEZE stages, exit early.

Thanks,
Qu

> 
>> +		if (ret)
>> +			return ret;
>> +		btrfs_force_shutdown(fs_info);
>> +		ret = thaw_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH:
>> +		btrfs_force_shutdown(fs_info);
>> +		break;
>> +	}
>> +	return ret;
>> +}
>> +#endif
>> +
>>   long btrfs_ioctl(struct file *file, unsigned int
>>   		cmd, unsigned long arg)
>>   {
> 
>> --- a/include/uapi/linux/btrfs.h
>> +++ b/include/uapi/linux/btrfs.h
>> @@ -1096,6 +1096,12 @@ enum btrfs_err_code {
>>   	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
>>   };
>>   
>> +/* Flags for IOC_SHUTDOWN, should match XFS' flags. */
>> +#define BTRFS_SHUTDOWN_FLAGS_DEFAULT	0x0
>> +#define BTRFS_SHUTDOWN_FLAGS_LOGFLUSH	0x1
>> +#define BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2
>> +#define BTRFS_SHUTDOWN_FLAGS_LAST	0x3
>> +
>>   #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
>>   				   struct btrfs_ioctl_vol_args)
>>   #define BTRFS_IOC_DEFRAG _IOW(BTRFS_IOCTL_MAGIC, 2, \
>> @@ -1217,6 +1223,9 @@ enum btrfs_err_code {
>>   #define BTRFS_IOC_SUBVOL_SYNC_WAIT _IOW(BTRFS_IOCTL_MAGIC, 65, \
>>   					struct btrfs_ioctl_subvol_wait)
>>   
>> +/* Shutdown ioctl should follow XFS's interfaces, thus not using btrfs magic. */
>> +#define BTRFS_IOC_SHUTDOWN	_IOR('X', 125, __u32)
> 
> In XFS it's
> 
> #define XFS_IOC_GOINGDOWN            _IOR ('X', 125, uint32_t)
> 
> It's right to use the same definition and ioctl value as this will
> be a generic ioctl eventually, with 3 users at least. I like the name
> SHUTDOWN better, ext4 also uses that.


