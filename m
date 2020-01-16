Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA35913DF45
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 16:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgAPPwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 10:52:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40622 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgAPPwi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 10:52:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so19513378qkg.7
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jjTL9ioGSxQmprP/I/EYRHOjGvj4xIQQRZyt9cSqYMI=;
        b=kD7443kxZLzcJe0NdttZXw8OW+9t6nuTsjhVsFxQGFs5DJz+kb+gotBNlOFN28LE17
         Sxplr0L3lNIclkTTRfgppU546nmGp094OZwxv50+wk4PbY45HBrrwpaPwMaK78M5Sk62
         n9lc5H/8Z9/cicYmrjsoUr6Ocm3T6l0RQq5Ou45XnmB6KI/CNIJODtz/JdroeRVU8ObG
         JOgiq5p3Cpkim8IPPYBwgeLGhwCP4EqpYVQynuFJXgRWJ7UaGTYy2KMfjS6WDiDHdPAQ
         qv/KMGmUh7bp53MzsF5CgcGMvZMNTspR/7ZaKZ1xL5/5C0IHSxvetpxAOxTOpw47I5IZ
         bplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jjTL9ioGSxQmprP/I/EYRHOjGvj4xIQQRZyt9cSqYMI=;
        b=rGfAgUV7k9yUVdMCZf5EP0wwgvsFhhPOdFvLWdk8jWyuKf2CwJpRZC8Z59cCUt+hrB
         +1qIrBN4ckO16wrPDsz2YZJl9olU1fvOZAsKRDyrQVtTYEa9Zaj9d/df+C6krksNiwLU
         +Aqqc6yO+1ah1vc44qzu9K4zNu6OMWJARjeBWZwUC3V0goQfDhxBNRw9ZA1K8d4u18Iq
         IqANEMJGEydMU+gUHCXhNLfSK8T1txDdtJ/eemwwK0/0A9WuoMDmn7P+Bdgn8c+Rwc8b
         n5vjaw8h2hDs0UD9O9JQHTH7xWIh5v1FLyGEzwH+XH091do2msqD0zA176dgFnFgmM7o
         KZpg==
X-Gm-Message-State: APjAAAUFFjzc3qSRBzHhEtujmsSQ/XegNJnLh8GWV9t1FX55pqB7roYT
        8DaIbulmnguDek9E+1C9dXyyeLxfGW+45w==
X-Google-Smtp-Source: APXvYqxAST+U+3CgHFR0qmZxyXdkUHwRkSxyJiQd/B8TJzbBk9scvp2hhFzjUSMIsFfHgY0F2V2xsw==
X-Received: by 2002:a37:2d41:: with SMTP id t62mr28462172qkh.255.1579189957260;
        Thu, 16 Jan 2020 07:52:37 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id z15sm759265qtv.56.2020.01.16.07.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 07:52:36 -0800 (PST)
Subject: Re: [PATCH 2/5] btrfs: include non-missing as a qualifier for the
 latest_bdev
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-3-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <36b867df-4795-d467-dd08-dc5ac4ad7cd0@toxicpanda.com>
Date:   Thu, 16 Jan 2020 10:52:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191007094515.925-3-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/19 5:45 AM, Anand Jain wrote:
> btrfs_free_extra_devids() reorgs fs_devices::latest_bdev
> to point to the bdev with greatest device::generation number.
> For a typical-missing device the generation number is zero so
> fs_devices::latest_bdev will never point to it.
> 
> But if the missing device is due to alienating [1], then
> device::generation is not-zero and if it is >= to rest of
> device::generation in the list, then fs_devices::latest_bdev
> ends up pointing to the missing device and reports the error
> like this [2]
> 
> [1]
> mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
> mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
> sleep 3 # avoid racing with udev's useless scans if needed
> btrfs dev add -f /dev/sdb /btrfs
> 
> mount -o degraded /dev/sdc /btrfs1
> 
> [2]
> mount: wrong fs type, bad option, bad superblock on /dev/sdc,
>         missing codepage or helper program, or other error
> 
>         In some cases useful info is found in syslog - try
>         dmesg | tail or so.
> 
> kernel: BTRFS warning (device sdc): devid 1 uuid 072a0192-675b-4d5a-8640-a5cf2b2c704d is missing
> kernel: BTRFS error (device sdc): failed to read devices
> kernel: BTRFS error (device sdc): open_ctree failed
> 
> Fix the root of the issue, by checking if the the device is not
> missing before it can be a contender for the fs_devices::latest_bdev
> title.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This should be turned into an xfstests.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
