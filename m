Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951AD13DF76
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgAPQAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 11:00:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47026 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgAPQAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:00:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so19519997qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 08:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YaLgIO8mxBk3Lsjb7Rfwc/2ch8zUhfeWCLDN7iperBc=;
        b=DN5crRVCZ1nag7bgjNoXuCqxnUF1kwSEJLDqlHVCKvUPjHCM3ESek4OTWFoGB7WJGc
         hMFsTacBHrTQd1ExycuV419CpgsyUUCwCM4D/jOFNEwP+OTeY0bB+k834ECuj90nF7u7
         +HRuNPHVEJgIxwJRjcHJWXZRe1EyUmXCBnJRo0mBiuSGAdlCeQfN6BI4+uaGHXfgO8Au
         dEAZlU8f+htBobUYafQ9+yWXF4zvg3+7JK+byZmA+46sTh7YaxblCzdgDgFmzPvO0HLA
         TNKrVa9RpFrE74l5NLpsRZ49E6DHuHy1+GEhjWctyUAzy6x4OGFMa3WdX0Y8Kutq8cYd
         G1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YaLgIO8mxBk3Lsjb7Rfwc/2ch8zUhfeWCLDN7iperBc=;
        b=mEhQ8Nq50jSpBSrOHnDIbv6KA/WUgL18YpMdFkg3o7kJTr6tF918RQa1t7FW6YQJNV
         pDv5Kia5oX9Q1udSNWph80oYr526E1f/bRUvPSUXKvB9u5GZlQXyvIcDxmjqsyDAaBNj
         Sf4Zz0EzIgQ749vsOCTCy1RDF3Frbp1nLmzQOc/1JhQVP1Sjt2ORU7fJg9O/hKf+j83Y
         /AhfP8WvQckWJ9pAfdEa+cRyqvytSfbilobiJAcvGbCMdMHPulosdiLWwwsUa6u4gICJ
         +8nJqDGPBrcbxlZJf5v5J7Dp/vs74Sq2qWSNyLzABWs8YHmg8x5vfLysFvpYkth5oUVY
         eRaA==
X-Gm-Message-State: APjAAAUZSq1xCBk58gGozXSo0dKSORAUjmrVDSmYRdhCyIarFFuOoXe1
        +hJuidXxMW/1R6wJynRydXsD22AFR7ay2Q==
X-Google-Smtp-Source: APXvYqxvZoGMVeQRFpEaY+ZQzmrdnRnI6y/GU6i0+iK0slSqfLIYE4YGi/cT6q9Yg/3cNnNQONK1SA==
X-Received: by 2002:a37:2f47:: with SMTP id v68mr27390002qkh.217.1579190433974;
        Thu, 16 Jan 2020 08:00:33 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id m21sm10297648qka.117.2020.01.16.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:00:33 -0800 (PST)
Subject: Re: [PATCH 5/5] btrfs: free alien device due to device add
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-6-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c78edb05-c277-6345-d7b5-7d05d6a4559c@toxicpanda.com>
Date:   Thu, 16 Jan 2020 11:00:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191007094515.925-6-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/19 5:45 AM, Anand Jain wrote:
> When the old device has new fsid through btrfs device add -f <dev> our
> fs_devices list has an alien device in one of the fs_devices.
> 
> By having an alien device in fs_devices, we have two issues so far
> 
> 1. missing device is not shows as missing in the userland
> 
> Which is due to cracks in the function btrfs_open_one_device() and
> hardened by patch
>   btrfs: delete identified alien device in open_fs_devices
> 
> 2. mount of a degraded fs_devices fails
> 
> Which is due to cracks in the function btrfs_free_extra_devids() and
> hardened by patch
>   btrfs: include non-missing as a qualifier for the latest_bdev
> 
> Now the reason for both of this issue is that there is an alien (does not
> contain the intended fsid) device in the fs_devices.
> 
> We know a device can be scanned/added through
> btrfs-control::BTRFS_IOC_SCAN_DEV|BTRFS_IOC_DEVICES_READY
> or by
> ioctl::BTRFS_IOC_ADD_DEV
> 
> And device coming through btrfs-control is checked against the all other
> devices in btrfs kernel but not coming through BTRFS_IOC_ADD_DEV.
> 
> This patch checks if the device add is alienating any other scanned
> device and deletes it.
> 
> In fact, this patch fixes both the issues 1 and 2 (above) by eliminating
> the source of the issue, but still they have their own patch as well
> because its the right way to harden the functions and fill the cracks.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I agree, but mostly because btrfs_scan_one_device(), which is what gets called 
by the control thingy, does this in the case that it adds a device.  This patch 
makes add dev consistent with the normal scanning stuff, so I'm ok with it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
