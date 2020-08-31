Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF27257DA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgHaPj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgHaPjS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 11:39:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE0C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 08:39:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so3712245qka.5
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fcA45Gt9ivLlDIzRrc+a6CdCWvPcyul5EKLCV+VSGYs=;
        b=cHiX+uppkkVFCxC388Ib59Zkef13iaSWjtyRrCmh+OR8qKNgI/cMVLxcXbgA5AEWQX
         wMoGMgIKfuyeHEeN9shcIPXiIk9TMxQMPdf8MGJ4m4VazpqLHZHZT14dRQnOR3HYXhN8
         Pmpvjidvx3+rZtc00sAdmaiw9sAKFFzWgXcm/9Og7/HJMkH/akAnr0FHCBrSdgsKwS4X
         G59moajLtyCVBwoSEWvhhUMMkPQxA6RMQ+VZv4SQJAD6/IStq5mcWkePcwHPHS17Mo/s
         duzIZaYG0Ti7cddVdBhSNrVvJjI4wuzyVmUQyNDNsxNwX2dcVXLKccmrURKRrQDzVs8F
         AN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fcA45Gt9ivLlDIzRrc+a6CdCWvPcyul5EKLCV+VSGYs=;
        b=cI74QmCJA8EfeOaMfX3sb8OA+EKbk327xIU26TH7EAp1bq197SbbEVs9IRow1gD+JH
         2DJAze44tjSEQLX+CEPqDqS58Mp72mDROQt8lOs9RWaVsxFOefsSu47juK8oZXyRWaYy
         0Nv83/tbHLFhG2YM7ectIHNwsu6oT2C4dWgfJKU3CKsZEBIIn0Qqs6ydJFgLSsbC/Z6m
         L1NdHe+vWZ4/XlSqUdd1ojOP6YtiaAzKAANl3c8ZXJvghbbjVbzxMarPTQrD+jNzdSyA
         HFIEXbR8kjNfNRYEY030SeeOniqr14m/s1gixUAhlztRvEx424SGGqBcJ5X4feE1LtyH
         3oDQ==
X-Gm-Message-State: AOAM531/+NO0u9/blTl5PIy3Pi9nRXSEaRwA/95zvRylUc31YiBdQoSS
        1B2Z58OtYY2so8KftUcO5QCPfO6IdqmuQUEJ
X-Google-Smtp-Source: ABdhPJyoq1Mif2+1wNoYEV0QGmpzyIOnMPZEaW0oRjvwhtCXzZRjkjUcDvp5wiV0daKvM99KZqzLYw==
X-Received: by 2002:a37:89c2:: with SMTP id l185mr1909030qkd.41.1598888356532;
        Mon, 31 Aug 2020 08:39:16 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm10422221qtp.96.2020.08.31.08.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:39:15 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Use transid for DIR_ITEM/DIR_INDEX's location
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200828132010.27886-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e706106d-e9f8-b0df-818c-ac956ff9bfdf@toxicpanda.com>
Date:   Mon, 31 Aug 2020 11:39:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200828132010.27886-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/28/20 9:20 AM, Nikolay Borisov wrote:
> When a snapshot is created its root item is inserted in the root tree
> with the 'offset' field set to the transaction id when the snapshot
> was created. Immediately afterwards the offset is set to -1 so when
> the same key is used to create DIR_ITEM/DIR_INDEX in the destination
> file tree its offset is really set to -1. Root tree item:
> 
>      item 13 key (258 ROOT_ITEM 7) itemoff 12744 itemsize 439
>          generation 7 root_dirid 256 bytenr 30703616 level 0 refs 1
>          lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x0(none)
>          uuid f13abf0d-b1f5-f34b-a179-fd1c2f89e762
>          parent_uuid 51a74677-a077-4c21-bd87-2141a147ff85
>          ctransid 7 otransid 7 stransid 0 rtransid 0
>          ctime 1598441149.466822752 (2020-08-26 11:25:49)
>          otime 1598441149.467474846 (2020-08-26 11:25:49)
>          drop key (0 UNKNOWN.0 0) level 0
> 
> DIR_INDEX item for the same rooti in the destination fs tree:
> 
> item 5 key (256 DIR_INDEX 9) itemoff 15967 itemsize 39
>          location key (258 ROOT_ITEM 18446744073709551615) type DIR
>          transid 7 data_len 0 name_len 9
>          name: snapshot1
> 
> The location key is generally used to read the root. This is not a
> problem per-se since the function dealing with root searching
> (btrfs_find_root) is well equipped to deal with offset being -1, namely:
> 
>      If ->offset of 'search_key' is -1ULL, it means we are not sure the
>      offset of the search key, just lookup the root with the highest
>      offset for a given objectid.
> 
> However this is a needless inconcistency in the way internal data
> structures are being created. This patch modifies the behavior so that
> DIR_INDEX/DIR_ITEM will have the offset field of the location key set
> to the transid. While this results in a change of the on-disk metadata,
> it doesn't constitute a functional change since older kernels can cope
> with both '-1' and transid as values of the offset field so no INCOMPAT
> flags are needed.
> 
> Finally while at it also move the initialization of the key in
> create_pending_snapshot closer to where it's being used for the first
> time.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
