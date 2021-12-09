Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36546E155
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 04:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhLIDtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 22:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhLIDtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 22:49:04 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2CC0617A2
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Dec 2021 19:45:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b11so2909611pld.12
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Dec 2021 19:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=njhG45usifVSAm2aSkNzlUSK10yx6nuwV6S2Kl0u5U4=;
        b=lxly56tID1rFfrom22nKVj1Bo78mbuL35BeHfQH79mlihekrCddSi5Z+LZwr72g+Ib
         OGMytoPiNYXJi++qs9qW6OLDloUcsHFmByYTKXbYJfrzsRODKzaRmzb3AK/WHjfC5rSD
         AQaRRc49NahQhibS0vpWikeNSMn06Fr0jzyHOVdtDEIGNFxHreehIZI3xVXy7/00KG5n
         3lSNN7og+b9EzdYzz4IQHlLTmENYs5GVzi5cNMUAQ7dFUOvUb8Y9Tp0RmXdohQr8PVuR
         oEDr1ZwpdQ5o9veyEm3JYw0v8RDYE1CSPpq4zLRTPYu5fv43o3qmzWvgpQR+D6aG6tUC
         0FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=njhG45usifVSAm2aSkNzlUSK10yx6nuwV6S2Kl0u5U4=;
        b=1dZmTBNBFfZLGnb0YOoEzM6U25LHg+QqYbsqyWzHeMHJ0AZoO17Y1P1D8CmKoxFGyf
         381vRw3148fiqALAERgtepKT5UdaXiDJFi0J9Bc4sVb5xuTOCQPxzlJFcQRc39c5080Q
         EtUzV1BbG8H0LW7MuiMGUDIiJxnktta+TDIvFSzoybpwtK5hPW8HtRXw6Ik6ur/fze1l
         Cff70Yd1QxZAVdcauJPJfv086W4MSNRitFValGKb7UF9fRGYn2Ja0Xu+8MZeX1vLWFOI
         oaXV7fs9x9wOOINmhCzk8KjL4BO+rYZZgbimOWb6BR8npOb0rWtFWtf6Vy+aj7rSonj9
         394g==
X-Gm-Message-State: AOAM532sQdZtilrLWU5CZFXe5HlOfzjJXNiz2vdXZPHBLM9H9zZ1BdFH
        rqhqDtLNuCvtiBL8/T2VROhIvw==
X-Google-Smtp-Source: ABdhPJz7tUH9m3lXUkXs8q2IISmHauEMBN0g0gHbAw9FC3FwsSbC6W27CPuO4vqyFhv7N8g8VPJ6tw==
X-Received: by 2002:a17:903:1d2:b0:142:24f1:1213 with SMTP id e18-20020a17090301d200b0014224f11213mr64832437plh.81.1639021530561;
        Wed, 08 Dec 2021 19:45:30 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id i1sm3967058pgs.50.2021.12.08.19.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 19:45:30 -0800 (PST)
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic (2)
To:     Josef Bacik <josef@toxicpanda.com>,
        syzbot <syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com>
Cc:     asml.silence@gmail.com, clm@fb.com, dsterba@suse.com,
        fgheet255t@gmail.com, io-uring@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wqu@suse.com
References: <000000000000e016c205d1025f4c@google.com>
 <000000000000fadd4905d2a9c7e8@google.com>
 <YbFvF7J220iAHqHJ@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f820728f-8dbd-9e36-1293-02514812eea0@kernel.dk>
Date:   Wed, 8 Dec 2021 20:45:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbFvF7J220iAHqHJ@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/8/21 7:51 PM, Josef Bacik wrote:
> On Wed, Dec 08, 2021 at 02:12:09PM -0800, syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit 741ec653ab58f5f263f2b6df38157997661c7a50
>> Author: Qu Wenruo <wqu@suse.com>
>> Date:   Mon Sep 27 07:22:01 2021 +0000
>>
>>     btrfs: subpage: make end_compressed_bio_writeback() compatible
>>
> 
> This isn't the right patch, this is x86 so sectorsize == pagesize, so this patch
> didn't change anything at all.  Also unless the local fs is btrfs with
> compression enabled I'm not entirely sure how this would even matter, the
> reproducer seems to be purely io_uring related.  Thanks,

Yeah, it's not btrfs, it's just one of those "bisect gone awry" cases. btrfs
guys can ignore this one.

-- 
Jens Axboe

