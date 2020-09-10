Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48315265152
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIJUvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgIJO6i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:58:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43E5C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:58:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so5009810qtp.13
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0ET3pJal8Z4h9OhykINCUv4ecVN2BFZY6tmBg3v4yfo=;
        b=FLjWPSl4+zFrtp288osIlXLEuOzYzob0AHItyOgwWBfHVXV5d7amFCuV78VOsuMRLV
         aR1LNGQazTgkVFZp/X+6HrRXcLOtY7IPS/ASM/7EGH7jowcH8uHtlxc5J/vXmfV/jLBU
         aHK7WJiSKXJC7J7f/sAHKm82AJ2Lju++IcKcV+JNfB1hYWpJzyaxZq7yV00Yf4UIfRE7
         EViJJHxDtLK2rg/OftURX2CYINajFaxP+1xT6FNKgLvgg+yzVe5i7GgOvejDCrSKdM8g
         pZpMKnhKKPxyLQoPR0Xa+b9Cat9oVSEe6WYznBvajW50r43H977XXRn9OTCtVpsLBJcv
         Y4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ET3pJal8Z4h9OhykINCUv4ecVN2BFZY6tmBg3v4yfo=;
        b=rAqYVRfwpUNGKlSe5fUWzmdJk4QrlleBKAsvdJkNOQeo8bMlbAUyTYuufcOMVpdmGj
         D+WA6afv7t0Cj85lAuWrLS4iWMrDPi502vPnlfgeeJsS6+siHh77Wlkao/8uweVB0Lz4
         F8150/wN0weP6yUu4G5cRIxlVfkLDZj6TXy/R66O12ufaRz+uefaYdcm5Z+ZxdbMu5ne
         L1n2gG7L9aQqDyHgMoAQJdB37lU3LrylRKmCACzcEL8Par6mKmPJ/oKFdf7qet+GyzJO
         Nb4prInzYZUxATLrbmaRJx9GOHJua32WzNoWAcfanLPmDwAeD07EJAYOeuMFU8OmvPkt
         WVbA==
X-Gm-Message-State: AOAM531inwUx6VU3ab8mQMKvel/bMwvuJmoaS+KQZYvvOxbZIXS9Uq4b
        myGNG6eGXuFWDUnD9B+vocXrLL9ytFqjp768
X-Google-Smtp-Source: ABdhPJxOJREMBnhbpcwHTVbOPtuOe9teobSRqBiXv7dxmNwlc2vRmOpDwuuM7ezE25ImceA5XKtnNQ==
X-Received: by 2002:ac8:1c16:: with SMTP id a22mr7784182qtk.85.1599749916684;
        Thu, 10 Sep 2020 07:58:36 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p37sm7460242qtp.31.2020.09.10.07.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:58:35 -0700 (PDT)
Subject: Re: [PATCH 06/10] btrfs: Remove mirror_num argument from
 extent_read_full_page
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-7-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d65b2662-f19f-b362-73f8-d4716f45f234@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:58:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-7-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:49 AM, Nikolay Borisov wrote:
> It's called only from btrfs_readpage which always passes 0 so just sink
> the argument into extent_read_full_page.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
