Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6678124A790
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHSULz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgHSULw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 16:11:52 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD44C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 13:11:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 62so22800228qkj.7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=twOug1w5qf0qiWdZKiuExDWEPkMRAV9mCoPCon/iQDE=;
        b=T7swWFMRuPUqLAJIt7DAalMfYrAI0AX4WsjriddAR4RFT6xgc8HbUmjyZs0tmV2bdv
         UjripoRlT9PvRv20ZSygxfxUqf601/2MDCN2sZrtUjDn3WsEXgynDCB+BKUluu8mbvXC
         q1PlMTBEVfp2m6j61Yn/fZeMk+GJKlW9fNFzxa3vfXdIhL1hultx67tlUwEigc4GK+Is
         P+VqBBvpvPncJqKqTwbxpeEJK8LXVUjrg6S+HMInDP2tMWKki+9eKqxCzaV+P/uDWdan
         fODTtUj9ZLWbrWGwand2Ao7nYej6i2AXajgG15JC7NwroirATnKttAWt73FqLE/TBRg5
         kh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=twOug1w5qf0qiWdZKiuExDWEPkMRAV9mCoPCon/iQDE=;
        b=rD/adnsM2Ir9LpOi5u5v5WlGSrfskP2CcBM7YV67tTia/JtcPvraiVMXBHFEITzlQD
         rgkcCZtmC4WEzTbTtSY+m3J5fCF6WbZIku82nzhc+4NSZoIosTFuYrBWrbVE/oJ1ewpg
         tZpxbX5saCUXIdxOwQFgjWRLbtvlKbXOb9shsIUFaPfWvL1mrL4fB6VtnvQpHqan6cqv
         PRDDlPGsBKpvWhuli6NxjYaShsRd+FhwKnWlucRc2mS4yo79QdZA0XKQLxh7mXtla/ls
         mxVf19xqARKm1tYaEneAGgN0qvMwpWn3OzRkyHIQCrLfah6Op7vSM+fHEKWlT447v4zm
         Kstw==
X-Gm-Message-State: AOAM530O3F0lI11+uEXC/W0h6Mj/dAyoN2h4RLNcEOQuGFbvmMwIdZjc
        Q28KeLI8zab+Z5nx3tBHw6F6r/7aMclO+Gqv
X-Google-Smtp-Source: ABdhPJy1ouQxhkaj4tK3AZeiWL/CobbKqteT7w28piPB98TYCV8aw9DSxmFtZ/rqeVaa0WIBXDOqzA==
X-Received: by 2002:a37:a34d:: with SMTP id m74mr23136643qke.358.1597867910773;
        Wed, 19 Aug 2020 13:11:50 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1212? ([2620:10d:c091:480::1:4a8d])
        by smtp.gmail.com with ESMTPSA id d26sm85814qtc.51.2020.08.19.13.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 13:11:50 -0700 (PDT)
Subject: Re: [PATCH] btrfs: switch btrfs_buffered_write() to page-by-page pace
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200819055344.50784-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <81f146e9-c2e3-b3c8-9cfb-1b88b9149772@toxicpanda.com>
Date:   Wed, 19 Aug 2020 16:11:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819055344.50784-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/19/20 1:53 AM, Qu Wenruo wrote:
> Before this patch, btrfs_buffered_write() do page copy in a 8 pages
> batch.
> 
> While for EXT4, it uses generic_perform_write() which does page by page
> copy.
> 
> This 8 pages batch behavior makes a lot of things more complex:
> - More complex error handling
>    Now we need to handle all errors for half written case.
> 
> - More complex advance check
>    Since for 8 pages, we need to consider cases like 4 pages copied.
>    This makes we need to release reserved space for the untouched 4
>    pages.
> 
> - More wrappers for multi-pages operations
>    The most obvious one is btrfs_copy_from_user(), which introduces way
>    more complexity than we need.
> 
> This patch will change the behavior by going to the page-by-page pace,
> each time we only reserve space for one page, do one page copy.
> 
> There are still a lot of complexity remained, mostly for short copy,
> non-uptodate page and extent locking.
> But that's more or less the same as the generic_perform_write().
> 
> The performance is the same for 4K block size buffered write, but has an
> obvious impact when using multiple pages siuzed block size:
> 
> The test involves writing a 128MiB file, which is smaller than 1/8th of
> the system memory.
> 		Speed (MiB/sec)		Ops (ops/sec)
> Unpatched:	931.498			14903.9756
> Patched:	447.606			7161.6806
> 
> In fact, if we account the execution time of btrfs_buffered_write(),
> meta/data rsv and later page dirty takes way more time than memory copy:
> 
> Patched:
>   nr_runs          = 32768
>   total_prepare_ns = 66908022
>   total_copy_ns    = 75532103
>   total_cleanup_ns = 135749090
> 
> Unpatched:
>   nr_runs          = 2176
>   total_prepare_ns = 7425773
>   total_copy_ns    = 87780898
>   total_cleanup_ns = 37704811
> 
> The patched behavior is now similar to EXT4, the buffered write remain
> mostly unchanged for from 4K blocksize and larger.
> 
> On the other hand, XFS uses iomap, which supports multi-page reserve and
> copy, leading to similar performance of unpatched btrfs.
> 
> It looks like that we'd better go iomap routine other than the
> generic_perform_write().

I'm fine with tying it into iomap if we get to keep our performance.  The 
reality is we do so much more in the write path per-write that we really do need 
to batch as much as possible.  If you can figure out a way to modify the generic 
code to allow us to use that and still get the batching/performance then go for 
it.  Otherwise the complexity is worth the price.  Thanks,

Josef
