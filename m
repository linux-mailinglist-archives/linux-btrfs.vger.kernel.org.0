Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521A8308A4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhA2Qex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 11:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhA2Qct (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 11:32:49 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925FC061573
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 08:32:09 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x81so9274228qkb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 08:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wt3zfwFtK4ZMSonnnRvfKKN1zlAJQeYgctUFWfn9Mfk=;
        b=A/UXH2yXOdP8b/SbxcMUlYpvB+r/WAfPH1T21c/x83U67foofmvq03tSskVTrTn7XH
         oQlfYZQJhbDPPh64W4UxnXBZlCIru0L0YKVOKN/AiXs7FmVyUEVhYnGNDIt/YWbp2Gjo
         fMY5xygrxYWsWUKAl2o3nSLCMgo/Y/ka78WHA+yIyy+ftT+G5+7Fix8TyjOiwf7fgysl
         4DLgOUrI4vnLvrNgyLrZNStooaPw7Xu7xKXX7t+yAnlG8szCGFcxYzJKZbLYy2rJN5m+
         BzzV40ouekWrugh2NHg6gS1SBSgEK92kTi4m2Q1zX93I8mqAQ/slGDfaFQ/ic6sgOFd9
         tLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wt3zfwFtK4ZMSonnnRvfKKN1zlAJQeYgctUFWfn9Mfk=;
        b=qQuHk0GnTyiXgHLkQ/DbQjFcHsje0Q/jdaqh1jv9VCccbZXJAhrGrgzQW5cysEgYx/
         BhCByzXyMeEp+yeMsXDCFCedJC5E+RbKUAu9Mh8qJ2G9f8vzxdNLIIzKpSKcqXtYFaVW
         qc9QfhjnzzW1Mb1qq6K9bjJOPCrzRHmhqRNThAT2pZ/s9DK1j5PaSzXQT8T6pvpcZzA4
         lnZHp35JKE0Y9lOuSJp6kw53T4qurqkFo6tKxKxBAVj/TyIILkpR6qxPnIi5RHq90wXy
         UP4K0crfU1NGT0zDkmvzzuLyhliDyMJOqmwJIuSsxT86DartiUit3Kfic1CvCWgU71tE
         fAgw==
X-Gm-Message-State: AOAM532f3sSZ54XInswiBVJs4HTZ5Qw4vr2UBie5x3il/QUodhfybH9+
        83rtWN1JobDSHSA7Sd2+p0xjJw==
X-Google-Smtp-Source: ABdhPJymNK9/Js6oc/ngm1HbudDzZyHxvSDxVzXW3vZ3nhWV0oyybefD/TBD2eaQBvckQTSrdfc1Xw==
X-Received: by 2002:a05:620a:149b:: with SMTP id w27mr5048980qkj.64.1611937928334;
        Fri, 29 Jan 2021 08:32:08 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c14sm6337738qkl.18.2021.01.29.08.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 08:32:07 -0800 (PST)
Subject: Re: [PATCH v7 00/10] fs: interface for directly reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1611346706.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7ce164cd-e849-80d8-3d9e-8a9987dc3ad9@toxicpanda.com>
Date:   Fri, 29 Jan 2021 11:32:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1611346706.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 3:46 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series adds an API for reading compressed data on a filesystem
> without decompressing it as well as support for writing compressed data
> directly to the filesystem. As with the previous submissions, I've
> included a man page patch describing the API. I have test cases
> (including fsstress support) and example programs which I'll send up
> [1].
> 
> The main use-case is Btrfs send/receive: currently, when sending data
> from one compressed filesystem to another, the sending side decompresses
> the data and the receiving side recompresses it before writing it out.
> This is wasteful and can be avoided if we can just send and write
> compressed extents. The patches implementing the send/receive support
> will be sent shortly.
> 
> Patches 1-3 add the VFS support and UAPI. Patch 4 is a fix that this
> series depends on; it can be merged independently. Patches 5-8 are Btrfs
> prep patches. Patch 9 adds Btrfs encoded read support and patch 10 adds
> Btrfs encoded write support.
> 
> These patches are based on Dave Sterba's Btrfs misc-next branch [2],
> which is in turn currently based on v5.11-rc4.
> 

Is everybody OK with this?  Al?  I would like to go ahead and get this merged 
for the next merge window as long as everybody is OK with it, as it's blocking a 
fair bit of BTRFS work.  Thanks,

Josef
