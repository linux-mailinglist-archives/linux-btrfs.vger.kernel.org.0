Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26E612D1D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 17:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfL3QRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 11:17:38 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:32865 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfL3QRh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 11:17:37 -0500
Received: by mail-qv1-f65.google.com with SMTP id z3so12530012qvn.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48pgTexxosYoUfr/P76FLjMOps5cczDJn6E45yvy8go=;
        b=BpIQpU803TCL5ma4ajdhdvNIFtjQqO0g719gAZiwWe1jrTCm3n5Q5oYixwifjZoQ6Z
         3LK4cUcHli160IXRU8yjHBXrzH5B+TWQATkv+dAXEFTXEkaI8aKUeKoCIEiXHMQnixDR
         HH2cCOsjWF0rHviWdoblU3VejEz4SsW7K0GYYCknaCEjBupYb4X407GlAn/KMjuepcZ6
         xx6zF3Flz1D1LjSNAr6e8c4xZOpOf7R8Z3WckGw5hkuVH1CRg8EOrcXtDbbNPUUSJ24h
         NefrEvaGCQD6nM/gUD3G+PiRo3BpkjZSmtZ7d0AhO/5HG7xN/JkaZ9WOWv8e94SxW8LC
         P/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48pgTexxosYoUfr/P76FLjMOps5cczDJn6E45yvy8go=;
        b=Vu4PKMdYkMy2fvuKNHNbY/KED/u9yjHEjv1cphcjtcW36WQ3MP+0LnhqXcnMO4HHEc
         gHhEMWBjeaKX1qTFK0NMGextEhy78UK6Ooy+/6fXv81fpBqdKgC1qeCZpJL/YxPCzHQf
         oGlnXE/IfZeq9j36P+BSVep1CzvE9CiCoLhA7TltvpztGX9+kvY3yM0E5S1BanbhlhFL
         hyJ7HL0i1MDfhWH+OBHHESXkIfqEJ6wQJP4kvlcoi0fxp5uKu4NALOtFLdRzhmwKVmR6
         nl1b7mmar+MAf273YMxyFlLm4kewNNcMpRUTpVVamwAzwk9w/nQsIROHQPqZVZBQ6Xzu
         LUBw==
X-Gm-Message-State: APjAAAXvxW647Y8AWGGAaE0GzHgunjToo3dZmZ372Jw0PDC4Ec3YrWue
        ogmFeAEtcddbVE5tVbBkqY+1jg==
X-Google-Smtp-Source: APXvYqydQ9Ql/cY52YV8+5E+PRSpMhuoiUestt+RDHaJf9d+NlUoTtb5X/Jnuf1z3p3t4N0ttUkTkw==
X-Received: by 2002:a0c:b025:: with SMTP id k34mr51240516qvc.170.1577722655912;
        Mon, 30 Dec 2019 08:17:35 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::2e4b])
        by smtp.gmail.com with ESMTPSA id z8sm13920487qth.16.2019.12.30.08.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 08:17:35 -0800 (PST)
Subject: Re: [PATCH RFC 3/3] btrfs: space-info: Use per-profile available
 space in can_overcommit()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Marc Lehmann <schmorp@schmorp.de>
References: <20191225133938.115733-1-wqu@suse.com>
 <20191225133938.115733-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9ccc4f45-a651-6adb-dce6-5892aeb1f222@toxicpanda.com>
Date:   Mon, 30 Dec 2019 11:17:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191225133938.115733-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/25/19 8:39 AM, Qu Wenruo wrote:
> For the following disk layout, can_overcommit() can cause false
> confidence in available space:
> 
>    devid 1 unallocated:	1T
>    devid 2 unallocated:	10T
>    metadata type:	RAID1
> 
> As can_overcommit() simply uses unallocated space with factor to
> calculate the allocatable metadata chunk size.
> 
> can_overcommit() believes we still have 5.5T for metadata chunks, while
> the truth is, we only have 1T available for metadata chunks.
> This can lead to ENOSPC at run_delalloc_range() and cause transaction
> abort.
> 
> Since factor based calculation can't distinguish RAID1/RAID10 and DUP at
> all, we need proper chunk-allocator level awareness to do such estimation.
> 
> Thankfully, we have per-profile available space already calculated, just
> use that facility to avoid such false confidence.
> 
> Reported-by: Marc Lehmann <schmorp@schmorp.de>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
