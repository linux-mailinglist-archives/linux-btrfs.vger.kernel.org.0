Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23D82758EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIWNmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWNmU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 09:42:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068FC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 06:42:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so22782577qke.13
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T0j7iz0jotOOQGrRMacL9I+Jmso6E6crLgVY7mULpCY=;
        b=UEynmk0+er5HmbQYEr8LIc3bcDZfDr8+ZotpWRdAA6Q+BokhXxFF2F7MtpaZhNudHU
         P/x1NMPh/MnffLJZig/o/cY43acedsd1bUbrkQCSriJSnC6JtfqhSDWDPRogqZpmShHf
         EqDVSDLn6dKPCjwwjngAC4A9tdazcjPB9eojM/15+VnWOrdqUUSoSejWxOuVGBJgI2im
         SA40HhKqShPF4tY9yVfjlFxKj+IL91Bu38A4qVZoEJqhdZKccZtN5aST4MuxKEoxrQTt
         spQ8G2RObQZGeeyGQaSmuKnb5qzNdaJFJ5z+9EjQoIvKbwla+CY4zHsnlhm/dLh57SH2
         V1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T0j7iz0jotOOQGrRMacL9I+Jmso6E6crLgVY7mULpCY=;
        b=HUYLiVYQOxiyiVsNXfFlg5DtBzfeR2/MJ0q8pngKlaBQtDiK5SSWwPEXqCh8yI/+b7
         JwhEDi2t9AQCBpn/Gs52/AmOLzCuBNBYAbAtUZpJvCeuTlWnK1b8ok+WjHB30YCx0gqx
         hfXyje9wMNH0KwxCR9bDPocz2iMOdDMlgdvvqRq6kOxnJb/9n9zpbgzS9JzAdFe0PUJf
         uTq7lUAHfG+0Vk3fDqgk/y0hUNJWOfX4yiy1cErWTCy+pJy2azDjWhz5xAQKji6ZiH3z
         p+t1/ogqPLBAzfhupHnrn+jN649jnFJCiwWfa6s9v65KYgj1YobGJwYP1+Lw5M9ogzYh
         saOQ==
X-Gm-Message-State: AOAM532wMTUDAx5unye9l8/EftYevvDDPB5T9c30Mm7bq376YO+GMsyC
        PY7Ze2RcltCrTKGe56gPT+uBDw==
X-Google-Smtp-Source: ABdhPJxTh8c2W7kyllgaTr8E3iOxDh1fxW0K/qC5QaNdHo4Boy48DhTUKtVORb56Mbv8tQP82K2Idg==
X-Received: by 2002:a05:620a:6d9:: with SMTP id 25mr10003059qky.269.1600868538985;
        Wed, 23 Sep 2020 06:42:18 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k20sm15395243qtb.34.2020.09.23.06.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 06:42:18 -0700 (PDT)
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
 <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
 <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
Date:   Wed, 23 Sep 2020 09:42:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/23/20 12:42 AM, Anand Jain wrote:
> 
> 
> On 22/9/20 9:08 pm, Josef Bacik wrote:
>> On 9/22/20 8:33 AM, Anand Jain wrote:
>>> syzbot reported a warning [1] in close_fs_devcies() which it reproduces
>>> using a crafted image.
>>>
>>>          WARN_ON(fs_devices->rw_devices);
>>>
>>> The crafted image successfully creates a replace-device with the devid 0.
>>> But as there isn't any replace-item. We clean the extra the devid 0, at
>>> __btrfs_free_extra_devids().
>>>
>>> rw_devices is incremented in btrfs_open_one_device() for all write-able
>>> devices except for devid == BTRFS_DEV_REPLACE_DEVID.
>>> But while we clean up the extra devices in __btrfs_free_extra_devids()
>>> we used the BTRFS_DEV_STATE_REPLACE_TGT flag which isn't set because
>>> there isn't the replace-item. So rw_devices went below zero.
>>>
>>> So let __btrfs_free_extra_devids() also depend on the
>>> devid != BTRFS_DEV_REPLACE_DEVID to manage the rw_devices.
>>>
>>
>> This is an invalid state for the fs to be in,
> 
> OK, to be more specific. There is an alien device that is pretending to be the 
> replace-target (devid = 0).
> 
>  > I'd rather fix it by
>  > detecting we have a devid == BTRFS_DEV_REPLACE_DEVID with no
>  > corresponding dev_replace item and fail out before we get to this
>  > point.  Thanks,
> 
> Yes. __btrfs_free_extra_devids() is already doing in a way the same.
> 
> ------------------------------------
> 1040 static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
> ::
> 1059 if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
> ::
> 1070 if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> 1071 &device->dev_state)) {
> 1072 continue;
> 1073 }
> ------------------------------------
> 
> OR I did not understand what do you mean.
> 

Yeah I mean we do something in btrfs_init_dev_replace(), like when we search for 
the key, we double check to make sure we don't have a devid == 
BTRFS_DEV_REPLACE_DEVID in our devices if we don't find a key.  If we do we 
return -EIO and bail out of the mount.  Thanks,

Josef
