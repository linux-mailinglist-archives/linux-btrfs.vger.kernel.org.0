Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AB2488B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHRPIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHRPIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:08:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686BC061342
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:08:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so15327063qtm.10
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LXK4ZgEoNGAPv0KIvY46B9xCzgMDEXEXyV83CASNkqk=;
        b=0PtlHoPZuxOvo8oEVGBv5qhvhHjL9nhUqB8WAPmXUUriU05mFiD79Qnu4YWvFFkN++
         SMwr5CVM+UQWp9VQguV0bGA4c1p8PidcaoxJXRgikfh0bCORbapa1mpxYUbsPg5MDzRh
         KuqfVrD+NLhZcRl7i5DKCrKcqMXA1T0EebknKeqPDn3dr1Jw/YWklyUtwArwFWSm/XGw
         kINUp9qD/t6nT8phxVX6XXXkTXbNdTGf6ugi/p7AFU3ZE9e5NLX1JzutVckIXERKe70g
         pdAhUvDFPpibAHFt0HFsD2oTugZZIWqgATVqG4paAY7Lt+wONahrD/hfufUchTL3sZ8W
         3qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXK4ZgEoNGAPv0KIvY46B9xCzgMDEXEXyV83CASNkqk=;
        b=awKRiIT/q9f6s8XgbRtbJrbSp2L7O7I89n3+jQO3n26mJ5Qq5VabJLJHYLqpAx3Ezo
         Bvu7k6Z8tgeTvDC0autLVhkTeZyNVzDMW6vo8eLo9NN6AB9O2UwV7cr5lidoWaSwMgG0
         okxXqVwTr0W62IbxPbs7EswG2xG/Zc5PtC4NaprymyT1BH5vYssWigeVIXMyp8HGWM5e
         f+SRnae6N7INjm474g+7TtP+RbVl/Ht1YnPvP9n0I5EIRZmmCxk+RcrGfQsmwj6Ak06/
         QWwN0ENyLpJodjr4InEiMioFjiJsoXK7c+ao29nhtynbb2nIpkEdB+jNfQgOQWL+pK8V
         L24A==
X-Gm-Message-State: AOAM531dTCAXgPcfU9ndA1llD+6yzF8qUpv4lMPzYAUczBbg9PZmzwZj
        W9EUd5EJZ7kRB52PQrOA03FZ1tk3yPZ+8NJJ
X-Google-Smtp-Source: ABdhPJx1y28/6LX1DgQ1TzXyM+F3J+JT01wtrjTICu/foj63k60kMqMh0Egk2NP4shjh2zi2unHSzA==
X-Received: by 2002:ac8:3894:: with SMTP id f20mr18498510qtc.243.1597763284522;
        Tue, 18 Aug 2020 08:08:04 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id b187sm19961530qkd.107.2020.08.18.08.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:08:03 -0700 (PDT)
Subject: Re: [PATCH 4/5] btrfs: Simplify setting/clearing fs_info to
 btrfs_fs_devices
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-5-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a4fd6d9b-814f-3c5d-f2e3-0f3f0dc3987d@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:08:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/15/20 6:48 AM, Nikolay Borisov wrote:
> It makes no sense to have sysfs-related routines be responsible for
> properly initialising the fs_info pointer of struct btrfs_fs_device.
> Instead this can be streamlined by making it the responsibility of
> btrfs_init_devices_late to initialize it. That function already
> initializes fs_info of every individual device in btrfs_fs_devices.
> 
> As far as clearing it is concerned it makes sense to move it to
> close_fs_devices. That function is only called when struct
> btrfs_fs_devices is no longer in use - either for holding seeds or main
> devices for a mounted filesystem.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

I was sort of worried we inadvertently depended on some other locking from where 
btrfs_sysfs_add_mounted() was called, but we don't

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
