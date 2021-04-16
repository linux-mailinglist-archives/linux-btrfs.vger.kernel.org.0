Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF98436216F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhDPNvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhDPNvC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 09:51:02 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1EC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:50:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y12so20798849qtx.11
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ds8FiTXXx9xmZcHqjJzoQjddHEFsu8zgB+0oME86NdU=;
        b=rx6vQgEvojIWJFvGwxjXntS2ymygWYfbn05N9K82waQno0KasZQLGJygowhFwp+Lcv
         xYJCIGGOZWYrSiDs0tJyKRbnwtEoXdViksX3oQE9dp+642SGNOla1gHWpXz3mxbhElDI
         fAgBuFDb+t/YUkGwwsG6VAuG08/LEj4ywmUTTP2TuVYvs29WLwb/jARiMa9DaAFXX+o6
         xykTr5P7j5taOutT5gbRUVgc7rXdWFQvQH5fDDnNqr4ZyAZjvvrv8OSOSEVS97NDD3KI
         H5H3nNsDhCulvQIQcSLS7DqKA3G+IGyXLh2lsV6hZ20T2gCe9AD7lHwMWZnP6JeUofIb
         eGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ds8FiTXXx9xmZcHqjJzoQjddHEFsu8zgB+0oME86NdU=;
        b=JG9ql8MgSw2/kCbQGtZiPd5eNGSQHcqx+6XIBB3tDs9uN8ATnYjhgJ5jRL2Pv4bHW2
         QxXGfZyFy6VrhbnEStwkvOVLiP/AmDd7JCMb+hAFgurzRHqmJxUzyYgMLLYmpQVj+S94
         fmIBvspmsSfvtE38LSaPrQbY5fgM41PouMvK8NvROrEwxh7WsyWUr0EU/JNcP9NSxMsD
         0i5qevqje4+QR+bski7vPuIsSm9uihRKoJhWTAu6GsO7nNqpqhnAbEMqDTFQr90RxeMp
         a83Ya8zZ1jGknLVTWfVq2qcYq9dzHRploi/Y32XasKctcMSMKQgV/wxQokQ0LBMm8GSL
         iERg==
X-Gm-Message-State: AOAM531o64kFuoPPFB7TpC2/pS4xKyTPWvJqdt1wP/u84b18ofLaNmgV
        2ZKJfK9uk7H9JsJ37my9Y77u+Aq38/cEYg==
X-Google-Smtp-Source: ABdhPJwLAae1M5gD55IVhIe7NfGNm+WLf/WV+2eAJyHNlmSQur37n4AWb6TEfgHwyxb2+EcLqiWWug==
X-Received: by 2002:ac8:7d42:: with SMTP id h2mr8014065qtb.182.1618581036423;
        Fri, 16 Apr 2021 06:50:36 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v66sm4182672qkd.113.2021.04.16.06.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 06:50:35 -0700 (PDT)
Subject: Re: [PATCH 06/42] btrfs: allow btrfs_bio_fits_in_stripe() to accept
 bio without any page
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-7-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d042daa6-edb3-967f-e1c6-ceebc45cc241@toxicpanda.com>
Date:   Fri, 16 Apr 2021 09:50:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Function btrfs_bio_fits_in_stripe() now requires a bio with at least one
> page added.
> Or btrfs_get_chunk_map() will fail with -ENOENT.
> 
> But in fact this requirement is not needed at all, as we can just pass
> sectorsize for btrfs_get_chunk_map().
> 
> This tiny behavior change is important for later subpage refactor on
> submit_extent_page().
> 
> As for 64K page size, we can have a page range with pgoff=0 and
> size=64K.
> If the logical bytenr is just 16K before the stripe boundary, we have to
> split the page range into two bios.
> 
> This means, we must check page range against stripe boundary, even adding
> the range to an empty bio.
> 
> This tiny refactor is for the incoming change, but on its own, regular
> sectorsize == PAGE_SIZE is not affected anyway.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
