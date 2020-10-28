Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE73929D323
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgJ1VlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgJ1VlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:41:05 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E18C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:41:05 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 140so462072qko.2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nDzfLqgyKEhy7ysjd+aAcj55RchlhY2cVPa5IgXHF+k=;
        b=RQCe0XAxXAjfyaDL3kfFCYE8j9X5Q9ksIbKueTnxSyF/6LqtvJADrkrtX42HjliI1U
         9C+OfXtc3nmOj4g6CPr1DxzUKCWqvZiH4G0zq1tZ7oDvMuNwIFgejq2hYadcnChFXQsR
         XvFmcaDp+U/oFn2ZETCqY4UTL0iWEvVeRCWa9TaC8wpy9k3vlG/ng7ddo9qpp1s0dWgD
         nPzTzkgaDX5k5Ns8oHUKtfQgZttN5xOVj1rBc4Jb9LabNq09YWwY8c9+rz32/rqWMyLc
         ZLN43gyLWAD9aRFLns5l7Ci0sqhj0dl4L/H7Px0eM0fYWbZ2OXusLJewZ83b1aGj1G2a
         1//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nDzfLqgyKEhy7ysjd+aAcj55RchlhY2cVPa5IgXHF+k=;
        b=iWq04o3Anck2bLQS9Y5PZCia/ejpfSpXzf8QMospMAwtniCQSIHoQBzGa1WEV6boB6
         HkelVYOg7wx84lL3TIBpAAERKmYI7t4e18yx8XFk8yjbFL7W2s8lOzFj4WvEMk2raDNP
         Xhcw8zrQlvfn5ychQzxauS1MBceDDoWrdSBCNC6xATQq/SWxmvKHEj3Rh5CH65UZHYpi
         tY6TVxGRuWqyoZ2QLT1OteFK8XB4Pzs2ffB4r1dJZ8k4Iex8f7pcB8P1IbK9U3iPPDXN
         Cmi1xC3B4l3P3AMlIjeBcfS/VkCX0YiFZNeoS7Bba9/umC46pKlq40AH3oPaNyzXON5n
         4aWw==
X-Gm-Message-State: AOAM533QBAyuBUW7pqJOQoKI3tlc5GI0jYCU+5aP/Mfq+CN30oX1OdfX
        VX0SM3I3+JcUifNo5MePpPp3ItQ9oEuzdkwr
X-Google-Smtp-Source: ABdhPJzlnGTW4zVITG3P7yMAo1g/JeMiPp5YZJhjxeXmaHka3PcFyYkTHfhDnTZhA278lSHKFltdxA==
X-Received: by 2002:a37:77c5:: with SMTP id s188mr7720044qkc.266.1603895862602;
        Wed, 28 Oct 2020 07:37:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g15sm2987561qki.107.2020.10.28.07.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:37:41 -0700 (PDT)
Subject: Re: [PATCH 2/4] btrfs: introduce new device-state read_preferred
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <b2cfd7bfb0ff90063196cb38b4689fb8d2ac9986.1603884539.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <72a5f7b5-1412-f82d-a22a-5fddcaa47748@toxicpanda.com>
Date:   Wed, 28 Oct 2020 10:37:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b2cfd7bfb0ff90063196cb38b4689fb8d2ac9986.1603884539.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/28/20 9:26 AM, Anand Jain wrote:
> This is a preparatory patch and introduces a new device flag
> 'read_preferred', RW-able using sysfs interface.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/sysfs.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  1 +
>   2 files changed, 56 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 88cbf7b2edf0..52b4c9bef673 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1413,11 +1413,66 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
>   }
>   BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
>   
> +static ssize_t btrfs_devinfo_read_pref_show(struct kobject *kobj,
> +					    struct kobj_attribute *a, char *buf)
> +{
> +	int val;
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	val = !!test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t btrfs_devinfo_read_pref_store(struct kobject *kobj,
> +					     struct kobj_attribute *a,
> +					     const char *buf, size_t len)
> +{
> +	int ret;
> +	unsigned long val;
> +	struct btrfs_device *device;
> +
> +	ret = kstrtoul(skip_spaces(buf), 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	/*
> +	 * lock is not required, the btrfs_device struct can't be freed while
> +	 * its kobject btrfs_device::devid_kobj is still open.
> +	 */
> +	device = container_of(kobj, struct btrfs_device, devid_kobj);
> +
> +	if (val &&
> +	    ! test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
> +

No extra space between the ! test_bit, and you don't need these extra newlines.

I sort of wonder what happens if we have multiple SSD's with multiple slow 
disks, we may want to load balance between the SSD's and set the two SSD's to 
preferred.  But typing it out made me think its not really related to this 
change, so don't worry too much about it, just thoughts for the future.  Thanks,

Josef
