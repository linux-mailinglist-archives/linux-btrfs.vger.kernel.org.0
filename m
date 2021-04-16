Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB180362411
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbhDPPgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245739AbhDPPgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:36:47 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051CC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:36:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 18so12381448qkl.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eflX6mQAscdRv+QuTbgqw9E/ppK26Wf2UwOd3rsTn80=;
        b=y0z439WPIsVc97+VVVvoOFb0uucZ1xWNUdzd0ydZMexuyuKgjx0jAY+gArSmtzuMRl
         dOl2EbEbUNCkXBalJwbOi8jTLvrtiJb6KqP46bfudA8wyOJT8FqQKv2vmHxIzCRA3IQY
         wah0xRfAH4JHGvJby2LMsrgv+exr1okJCfcVSI1cNgpt9lid79dnzIXUwkft6s46x0tn
         xsgHTFJ6pDLxk533sU41zic5mzcFtVL5VfeJY/5u0WLXvdJgjM/zGyibR0azWRhxtwCG
         o7YXrw/MM2PSDK3LAVaTap6w2Eup7dHnMrweXbH5b1htr/IiUbRa9GpjFAWwrx1M0M+w
         xz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eflX6mQAscdRv+QuTbgqw9E/ppK26Wf2UwOd3rsTn80=;
        b=JykxJW50s9cjZgJoyCoCTafARceX9Lja6WkDMIbT4RTA72l67UXDp8NmkMLb1rDINK
         DR2hAu6muOACkB+w9Y+qlbT8+uDXfyRQrOx+jBl+Fx/Qruy0/pDApctWfJ6v1w8b7w9m
         tW3EI71onka/h7ov2KhCqiUmLoH9yXWHllEAuMS8VyEjtjkgKTN8iZI07mj+S6zuwBGX
         FgX2DUyEae8J1cZJ6rCjy3iNQ+qQXVF+McIruGiuJnxZ1WpCDmil/SUAOKWN8Y7n1Tq7
         GTc7xyuMM4LROyQzEpe5A1lSI8hsLfFbS+crzUpmDDXXmmXR56MyzPUJgEfWZBKjO9sE
         VNqg==
X-Gm-Message-State: AOAM530FXf16eCePShUEWy2NNVLTHK2RwtKKX9wBR+AzSesqjlfKoz1c
        htMFcPEnZVcHGKO0T0rss8fworoDF6qBRQ==
X-Google-Smtp-Source: ABdhPJx5KM0WCq1X5OXbrVvUXPqXMb+FCJ5ZWS2d48ZvI19KIY9zQUgbPyJZhm9fkHo1YQS4AvYZMQ==
X-Received: by 2002:a37:e213:: with SMTP id g19mr9476246qki.260.1618587380424;
        Fri, 16 Apr 2021 08:36:20 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a11sm4399564qkn.12.2021.04.16.08.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:36:20 -0700 (PDT)
Subject: Re: [PATCH 21/42] btrfs: make process_one_page() to handle subpage
 locking
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-22-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2740fee0-5fcd-ac5d-01e2-c4411f229958@toxicpanda.com>
Date:   Fri, 16 Apr 2021 11:36:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-22-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Introduce a new data inodes specific subpage member, writers, to record
> how many sectors are under page lock for delalloc writing.
> 
> This member acts pretty much the same as readers, except it's only for
> delalloc writes.
> 
> This is important for delalloc code to trace which page can really be
> freed, as we have cases like run_delalloc_nocow() where we may exit
> processing nocow range inside a page, but need to exit to do cow half
> way.
> In that case, we need a way to determine if we can really unlock a full
> page.
> 
> With the new btrfs_subpage::writers, there is a new requirement:
> - Page locked by process_one_page() must be unlocked by
>    process_one_page()
>    There are still tons of call sites manually lock and unlock a page,
>    without updating btrfs_subpage::writers.
>    So if we lock a page through process_one_page() then it must be
>    unlocked by process_one_page() to keep btrfs_subpage::writers
>    consistent.
> 
>    This will be handled in next patch.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
