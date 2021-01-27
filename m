Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9243060EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhA0QWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhA0QWO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:22:14 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38A7C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:21:33 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id n15so2230488qkh.8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0wQ0/wBnUiFPsA/ystyRJFGcZb9piLIalos4o/vFXaY=;
        b=rwxw+P4Yec0TkoGG+Fos65XuU6dAW9u6Z9G5e8xQRo4SMlr53a9yym5ag9Od+ImxXD
         Rqo3uPxEjbQrnZLYqEXx18FWAxLvBTuo1BQduFHugcrLijE3J3fIkIhHVlVukbzB5Hb2
         OQn7velOQhAsHK6yEoTsOmmHCubHfbQ2Ml1gYRV1PqsSwhAaYelBsijxyBrHLO1z5mk+
         HuDRIdDIXwubUdkY7vTUGWwfbcdnVcgjHRo5olIblZo+9+iHNynkrrjzP4zQgtRU6R3a
         Hm826iQj/J9NEL6hcDtcydPWlYpJMkZ9BrwD3NB4m1hkCKVMRz2qG2lJiyKBHA/dzHQD
         pfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0wQ0/wBnUiFPsA/ystyRJFGcZb9piLIalos4o/vFXaY=;
        b=oxVHm0UsggECmH0x2/As1tPwMIIZwS9+Xd0KKRfNWoXf5eXtkw9mB66MpFkMnHqQaU
         691J2s/VuzwlX25H9rc/d+HxHPN8zl6CC3UqAUJ/2FzNm+F3IV40sh0k49cbUwsG5KeC
         jtgWFZLlo7YYKSa395JVZyZcT8ZVbaYcixXIv8oa4+gs/iZeehrtLR8CLouBlN1uZ9Fo
         F+iV8a4MfeqV98M7sFEt+QjKaasbUDbqYW0EoOSxZE1DCeXgbEzuTHDUPD/jRZ68o9Nu
         tC8J4lYFWqhg/MJhzlnjJT/qY+YeAR4/aXr1kkCULSwwgp5hlQ2sXYmYq2F515CZncwT
         k/7A==
X-Gm-Message-State: AOAM533nw+1QfZrqrEFcOkPDxAobPhBIc+Y9AC3QOkVbosfKROoxyO84
        wTz/EqeVhIXpDXCt6wuimzHheQ==
X-Google-Smtp-Source: ABdhPJyR78+CtejJzldA8ZwD3G58S0a2C+tPQav+8T1gK4oX5SynfQQ5tm/aX2XoWJIkBeexnisAGA==
X-Received: by 2002:a37:d286:: with SMTP id f128mr10937925qkj.462.1611764493188;
        Wed, 27 Jan 2021 08:21:33 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a188sm1447566qkg.33.2021.01.27.08.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:21:32 -0800 (PST)
Subject: Re: [PATCH v5 07/18] btrfs: attach private to dummy extent buffer
 pages
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5fab0f18-5546-b76d-ae61-f648c2ec21c5@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:21:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> There are locations where we allocate dummy extent buffers for temporary
> usage, like in tree_mod_log_rewind() or get_old_root().
> 
> These dummy extent buffers will be handled by the same eb accessors, and
> if they don't have page::private subpage eb accessors could fail.
> 
> To address such problems, make __alloc_dummy_extent_buffer() attach
> page private for dummy extent buffers too.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Yup I'm slow,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
