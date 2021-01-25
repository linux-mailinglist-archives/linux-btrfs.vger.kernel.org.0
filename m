Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56FC302D23
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbhAYVBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 16:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbhAYVAa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 16:00:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC86C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 12:59:50 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d15so10736386qtw.12
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JJNWcMOWzRaag3SBCPIuuG3V8rOucOBbI9b8+CXDIO0=;
        b=mCwNAdUhFxM1x6BU9SHecQkP0XKWNsVDuGrXcNiaFpZnyd2FCzdA9LYEDYGuWgaBOS
         YGGTa7k2LocdTXi4ioRJXlxxdLVPBMuh1ATzRyKdMpHPageYuJrnqEG7jysVGnjzL2Zo
         7q5F/4WtYPab4jsH9mPygYI6ns7SN+s/p0dSdsd/zmiuJcDBY+tDQ5vaAnJfcOo7atco
         iTDhuUwKelHV3y2ob/NwojMcdHUDDy8OTtptN8ZiHMvDUV8QgZ0qgeltL+BEYRdvezAv
         uLBypQyjkty1Mcu9eEfGdANFcCW6qnZ5GHKjPg2rdiPh9p9K5NLOE4j7WkNiGtLmJyGX
         r1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJNWcMOWzRaag3SBCPIuuG3V8rOucOBbI9b8+CXDIO0=;
        b=Y6r8Zo6YkEcjNTulF5DGtWe3LNplMGifOd6PWV+9N32voYWQQOB3pGW5pJo9MsG0FE
         JQOMZWSl52DV1JwvPqzqa9+HogyAOWDBhYt2KsarK0W09luLRjNJaJfOGbCkTFBNzFuE
         3r14sOXqW0QI1XvHRGfjW0ahi/285Uigw8LFypzN5e2bU7y1PyGaqktvFKG9aYrI3YT2
         CfODBbUr6++pTMSgypi7+qkXCrERE9fOytCDwKWYKxVcAfTuOnXB3wjevTwZBLc5WPgv
         0WicQBgMemCFEG7e2eKH35it/WWiHZELhKeyKf6ZlB6QUk/fyselPes1MJY+TdZL+xfT
         x4ZA==
X-Gm-Message-State: AOAM530D77Qg3V7Jf8dhR6UfAas2F//5HDYVpYn1UOgcftbzAKDU1aPL
        ylodhlqzpmH7qcXmAKjWXIJVvA==
X-Google-Smtp-Source: ABdhPJwjHGGpnI+Y4Q5fI8hJKvjpozuCCSlNPbHk6TkYeK0ZOSf/+6lz7Yp2jOBeANZUheR7REX2+g==
X-Received: by 2002:ac8:4e8b:: with SMTP id 11mr2318597qtp.292.1611608389721;
        Mon, 25 Jan 2021 12:59:49 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::12e0? ([2620:10d:c091:480::1:8a2c])
        by smtp.gmail.com with ESMTPSA id r54sm12564072qtr.70.2021.01.25.12.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 12:59:49 -0800 (PST)
Subject: Re: [PATCH v7 04/10] btrfs: fix check_data_csum() error message for
 direct I/O
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1611346706.git.osandov@fb.com>
 <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1611346706.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6233a6de-664d-cdf8-92fd-09ad2b5380a9@toxicpanda.com>
Date:   Mon, 25 Jan 2021 15:59:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1611346706.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 3:46 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
> check_data_csum()") replaced the start parameter to check_data_csum()
> with page_offset(), but page_offset() is not meaningful for direct I/O
> pages. Bring back the start parameter.
> 
> Fixes: 265d4ac03fdf ("btrfs: sink parameter start and len to check_data_csum")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
