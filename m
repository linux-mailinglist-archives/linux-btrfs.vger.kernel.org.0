Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB283D8580
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 03:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhG1Bj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhG1Bj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 21:39:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C61C061760
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 18:39:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k1so727025plt.12
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svIq3M8HhmjOQFHJQVWbDLjaKokejNdfgbcRMVtQl6I=;
        b=OkeYqPnbSWWqVhkH3XroWcXMPLjvBpzL07PshovmwhHsgpcjHE/dwBaIT57dE6cguD
         wfacScli3WcozLzcK7oOWYp1cr/cauCMt5zOXwYqVRt/eld6koC6z6wzTDj39ILXyPCS
         u23uNSRCr3BshpsazezRbAAOpEcuTo8HlCD56SiPr0Udvm6yJpoh2jxr+RZqZ4gVGrqy
         1vBIFStGTKz6wxYTBJ2r6H3qoqNNCw0z9s03i+NhcuItRBiexi9mFZR1JGLFD5Ja/uhq
         2zgF/R88YiIs7q+GTZojmm1iimQe8VX81QQiSrtBWxMuc6KPQQ0HvH88ow1NF18cMW+z
         FPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svIq3M8HhmjOQFHJQVWbDLjaKokejNdfgbcRMVtQl6I=;
        b=S1J7KPLCg+eR6/08SgC08f9EsSKPod5XnNMxrotQRTEUH9oxEgjojHqi7KQeP33heB
         O3PJ1AB//kD3BuTSv7SFOtumP8Fbbe0vRnmOOf3/BWaT/0JE+5yoY+YdeTruVmBi6tcB
         bJjh8JceiLV5FPN+ombxqKsO4umxyafESq41ddbddU4Z2kW1hvxmFucWiiCZ5/qHXf4G
         Jiy6z8lXcI0yOLw2Pyq7bqBfEcTP9Jc55rsv8Y1hW4NxPh/bAToZ7acbXBv0rs6DIHIK
         X9KAZyXfnXPV+En3Egsffe+44XUtbe7SyZS6ZDNtzkZWIYgp0qmMEc3zZWw8lgf4lSHn
         osDQ==
X-Gm-Message-State: AOAM5330/Sr6olFfo8Yx9aoSduPV5eDCSfxBkQhnLKZJQyuV3S2FPgLB
        Qk+QhBfuv8TrcHnVQ6971sdab9puPVmbef4S
X-Google-Smtp-Source: ABdhPJyJLwNyRctObcxyK4toXEaF7zEJrs1ztdt1iDwWMOxEFMftiOxaVnTlS6RBmwQHMU92F/6ihA==
X-Received: by 2002:a17:902:a587:b029:12c:3265:26a with SMTP id az7-20020a170902a587b029012c3265026amr8666756plb.34.1627436394755;
        Tue, 27 Jul 2021 18:39:54 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p11sm4131248pju.20.2021.07.27.18.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:39:53 -0700 (PDT)
Subject: Re: fixes and cleanups for block_device refcounting v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210722075402.983367-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23d8cafb-413a-8feb-a2c7-601783d18706@kernel.dk>
Date:   Tue, 27 Jul 2021 19:39:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/22/21 1:53 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixes up a possible race with the block_device lookup
> changes, and the finishes off the conversion to stop using the inode
> refcount for block devices.

Dropped the btrfs patch since it's in -git, and applied #1 to block-5.14,
rest for 5.15.

-- 
Jens Axboe

