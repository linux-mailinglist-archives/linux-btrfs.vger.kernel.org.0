Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63425C598
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgICPpD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgICPpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:45:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E81C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:45:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so1555365qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OlOL6NNRu0vrRWUjRo8iYwq7yfVfLDxwWdAEPQt+tJw=;
        b=hW3Bq1AJcmxoyZnJmpXZZmH2EC/tRpTM5EEQqsHDciO4cdx8nFe/3Nrnw0BJQ1vqC5
         F6yUO+JUaNEj5jzINTTze0MBtFG5e9CvlNXvgWwNmrhyB2ODxUgt0r9XGFx/3TFOJ7pd
         s+I4o2fvlgAh1eMKruRBO1tDJHg7GpCtDkgncvHi6b/c8ODFxA4K/JzD95juw1MRl4hW
         WtxiGuAkKPoeIzfIB0MZh66szZVlPhJQOiz7Hk4+0c/wwzo8gvtuPLzbgAE/cKqLvOvT
         h2aBAgN1w+lzNTD5qKRBU4t4vVeBle6WEVAT5LAh8ZRApKFJzA599n49B1WHt7y1pWHD
         +VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OlOL6NNRu0vrRWUjRo8iYwq7yfVfLDxwWdAEPQt+tJw=;
        b=r7ZehpaG/iR2IfxHWW7nNzPKdIUpeh7xFgf8aFjDHnGxdeP84o3mugtQDtCjvxJ55/
         ruuFheXgwmHUt3hEuFAQOWAlsJ8JiQRoDWtv1XhtjiMLno47n8OYeSMCynGLHPn9wOnL
         UfHbZVIEle7ofNruUYztzC/Md4VLJ1RvkHAlbSIASq8ZEMKOTXcKaGwnI4EOBTzaw9sk
         zeRNIaY1tUm7xI1rnoJQTsRW0N7pAmjDWF/bxYA5yhPMwgf4c3AX8xhCs6/xTJZMYbRP
         9HfxdU33pu0+NeyGUsjFNWUBtHJU29hX119deGVSDw/jMmRwL6ej0NfK0i+5rq9ImsGX
         6sEA==
X-Gm-Message-State: AOAM531Zl9vtqbe2n+tGOes3JpCvbqNMdJRIqsIlCwtrqHX/Sl0HqLrR
        9CgXvzYZne7izOA0klVfX+Y5SsOiyE1//NAi
X-Google-Smtp-Source: ABdhPJz/A/RThlLOC+AG7dmg00t2KTP4fBI3OcLzx77N85yZE29Uzeqa5sA4xSRLH3jp0SW9q65BTw==
X-Received: by 2002:ad4:4f30:: with SMTP id fc16mr2486005qvb.6.1599147899010;
        Thu, 03 Sep 2020 08:44:59 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u2sm2416336qkf.61.2020.09.03.08.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:44:58 -0700 (PDT)
Subject: Re: [PATCH 04/15] btrfs: refactor btrfs_sysfs_add_devices_dir
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1599091832.git.anand.jain@oracle.com>
 <7f81bf1c3e80e7b558d17c1caf049e0c431033ab.1599091832.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9d394b35-0c05-11d1-e3ff-22297b6156ae@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:44:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7f81bf1c3e80e7b558d17c1caf049e0c431033ab.1599091832.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 8:57 PM, Anand Jain wrote:
> When we add device we need to add a device to the sysfs, so instead of
> using the btrfs_sysfs_add_devices_dir() 2nd argument to specify whether
> to add a device or all of fs_devices, call the helper function directly
> btrfs_sysfs_add_device() and thus make it non static.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This failed to apply cleanly, so I couldn't make sure the rest of the series 
built or review the rest of them.  Thanks,

Josef
