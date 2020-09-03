Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A525C594
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgICPnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgICPnu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:43:50 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A2EC061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:43:49 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so1501572qvb.12
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FjMSh+zE+l7vUNdRZOmssX+xVNu8Y4cLInZg4OMV9sg=;
        b=xKSHFh8taYqBB/TxDgA1OFWxa38qve0e8BuT1ByflqdfEASzQVyTDOD34IsKL5fpBY
         hRkixhaHerHuXnCRvLstN6/20OOYQTgEgd39tlddvTs4QP9et6YLu8ooP+o4UkrJCpMD
         hYQiQ/sD6pykT+A32tR/rN4/gczoXONQUYYFC7zvVR3yaXTckUq9Ow1qVSO5vSWbzfca
         j7Dt34IO19fcuR4SDq3l0AXTCnH8C1DRiceYvQHt4/e7Ug3IKBM7BTadDBeneKOJFzxN
         Nr+uIhYmG/dyz6ntS3Io+GseOHxmqkZ3ni0gICEyNt8tPnbWciLFHeXTdNQ8QBxhEC2x
         7K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FjMSh+zE+l7vUNdRZOmssX+xVNu8Y4cLInZg4OMV9sg=;
        b=mL/hPUEdqspDgYqk3OqfP2uMFupqKNSNOmd8woHR8Qta069KN62hEJ2gX9AdUJO2d0
         mN/WP7zWMGV+qPkSTRdmFo17X4FYGmbCzo9ulaDtqj3matX+zleud8/R9y+st5XSVGxn
         jxId3+NYTlZesbA0NsyTEdyKM5OR6KtnVWUvxQ0fTmENxpyHpQo/N0NhxHVll6G38lXw
         ZadSAxWNq2Hnu1jDL/xB3k24YmOQmeIWdP5zNFdHvqjgCdtF8BvK3LYSpHpERImUrlmT
         rzLLsQV2eJK9p99QGm0bLsmZL+3LYYWVEs1z8UFDRK1DUM1eGdiSnqqePmU0QRXTq8HQ
         wllQ==
X-Gm-Message-State: AOAM530aNTKPIxm2Eyq+87dZS56iDZDI257xkTHvjRKy9j3+r4sWlXRb
        ZnD4CPN9RnLzVecykY6rHnXIfCWlCffVzcdb
X-Google-Smtp-Source: ABdhPJx56GaG3hzYIzJy6itYFRv2YmescZ1dbhMmtemXMU4bVOgvE7Aq1yTBgtJHgEn+JdHEM+Vvfg==
X-Received: by 2002:a0c:b524:: with SMTP id d36mr3418261qve.12.1599147828585;
        Thu, 03 Sep 2020 08:43:48 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c1sm2337403qta.86.2020.09.03.08.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:43:47 -0700 (PDT)
Subject: Re: [PATCH 02/15] btrfs: add btrfs_sysfs_remove_device helper
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1599091832.git.anand.jain@oracle.com>
 <e86c1cd026973f7b65ccf26a523cc2e476fb13fc.1599091832.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fa7b9163-507a-b9e6-7c52-46442ec094e8@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:43:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e86c1cd026973f7b65ccf26a523cc2e476fb13fc.1599091832.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 8:57 PM, Anand Jain wrote:
> btrfs_sysfs_remove_devices_dir() removes device link and devid kobject
> (sysfs entries) for a device or all the devices in the btrfs_fs_devices.
> In preparation to remove these sysfs entries for the seed as well, add
> a btrfs_sysfs_remove_device() helper function and avoid code
> duplication.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
