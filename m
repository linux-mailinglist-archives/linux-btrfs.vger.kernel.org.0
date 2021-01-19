Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAA12FC2C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 22:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbhASVvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 16:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbhASVmW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 16:42:22 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC08C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:41:37 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so4965196qtv.6
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DrGFFmb2mDRGz2PVkFmfwLRuSGgYqURvsVQb4D8HOys=;
        b=L8XhAu4mWxCuJc0/6L2iTavUhkWdL0Ived+XuGwdKh0PjSZ8QGvS8GEunW59DTZKg7
         jrRmh1mxvtH80dpjwSs6pTq5tuIZX5CmgOYQF8B+h8HcUnTY0RmPJ6GXARTwJRdkC5/E
         x4U64nJstq7ml7Xs6RRTXpEzPSUWUHJ839Fh2TwcJ1h/wrQjbI4zBQ4vku1ddthhc3uV
         knLdg7yg8jlIV47vp0LwlQyP+Nw+x2sj3qWzHd4cFWbfkZOWuEW6bqJE1J8EzLqoXMSq
         041Wfe8VhX87j4Eodr7xm1Tex78S5y5SIrUGKafeLYKZBwhbScVCi1JWJeORbbLN6Fj8
         MWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DrGFFmb2mDRGz2PVkFmfwLRuSGgYqURvsVQb4D8HOys=;
        b=hJU/8BPZTxbyEpLxGSefofwYdX+C9pLCaEqYop0akEMk+sGrqXysW6yT7zEOXBezt/
         mL/5V8IGrT8da7AW0gg3C44A4vBR+c0bUoLSo7CBUhFmsjUeSc1ouchxAtGTxamtH229
         B/1Cb8RfHNZNmXN4NthWZ8LfRjfPM7bEd8t5nmta0EfY+QoQLsiPmalg+lXx32Bofaks
         Kt89AtQIduvB0SOyK+KxLOSjxIHsmQhFOp4I0qFHIm0Ib+JawCz45n8jFahvQ2nQT2Gf
         ZvdGSLSRcwohGA/wXWF5j/ab54jEPozrGswO60h/HfYfV4Lubb1/xRBNObbPlNFXIdwe
         FKGA==
X-Gm-Message-State: AOAM532y7iPem/UjE/ETD+4VgHjyjCLdk8Y4etXdAMMy2JtTTz7MuVCy
        +wlupCcRRuS/gBzoPye/2drG3wEO3Jtq4DnyE2w=
X-Google-Smtp-Source: ABdhPJxZQjq8WkMKMX+XBnt/TDvSDDQHhvBuBK2ouhb2mMrnAJz+ZcGvIetGTzaIZXbmbOV4fV6z+A==
X-Received: by 2002:ac8:4e8b:: with SMTP id 11mr6312446qtp.292.1611092496516;
        Tue, 19 Jan 2021 13:41:36 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:2a44])
        by smtp.gmail.com with ESMTPSA id j66sm3069qkf.78.2021.01.19.13.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:41:35 -0800 (PST)
Subject: Re: [PATCH v4 01/18] btrfs: update locked page dirty/writeback/error
 bits in __process_pages_contig()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b0360753-072a-f5c5-3ea6-08e9db2445dd@toxicpanda.com>
Date:   Tue, 19 Jan 2021 16:41:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> When __process_pages_contig() get called for
> extent_clear_unlock_delalloc(), if we hit the locked page, only Private2
> bit is updated, but dirty/writeback/error bits are all skipped.
> 
> There are several call sites call extent_clear_unlock_delalloc() with
> @locked_page and PAGE_CLEAR_DIRTY/PAGE_SET_WRITEBACK/PAGE_END_WRITEBACK
> 
> - cow_file_range()
> - run_delalloc_nocow()
> - cow_file_range_async()
>    All for their error handling branches.
> 
> For those call sites, since we skip the locked page for
> dirty/error/writeback bit update, the locked page will still have its
> dirty bit remaining.
> 
> Thankfully, since all those call sites can only be hit with various
> serious errors, it's pretty hard to hit and shouldn't affect regular
> btrfs operations.
> 
> But still, we shouldn't leave the locked_page with its
> dirty/error/writeback bits untouched.
> 
> Fix this by only skipping lock/unlock page operations for locked_page.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Except this is handled by the callers.  We clear_page_dirty_for_io() the page 
before calling btrfs_run_delalloc_range(), so we don't need the 
PAGE_CLEAR_DIRTY, it's already cleared.  The SetPageError() is handled in the 
error path for locked_page, as is the set_writeback/end_writeback.  Now I don't 
think this patch causes problems specifically, but the changelog is at least 
wrong, and I'd rather we'd skip the handling of the locked_page here and leave 
it in the proper error handling.  If you need to do this for some other reason 
that I haven't gotten to yet then you need to make that clear in the changelog, 
because as of right now I don't see why this is needed.  Thanks,

Josef
