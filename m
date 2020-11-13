Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8A2B23F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKMSm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKMSm4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:42:56 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6927C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:42:54 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d28so9698764qka.11
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O76xUT7SSARx3cTDI+8c0nJmW6EIyOXlmUF53JN4QxE=;
        b=rqfr7jSkKFULgwGRgCxYfeG84RYL+r7VvUwn25nT8bZRVMji1LdpMU6ss32FvyNDwE
         j9+YAdsjKHy6hPTfFLAIIiWeFXtF9PZp6w7znYkHNQ7+IqqbUYc7a8FpQs7aUpp35QCK
         IhKzC8cxND0s7Cmi9jWZ1f3nylujx3gzzjwtG0AdEn7c0xd/bsBNev/iKdc1DLYQgFQk
         gSGijqOjbBIG5OCGwrTTr1N7AdQCmtWgL6FC2RpWP5Aj3GBNP20n31fPTXX/O0dNcJmn
         QWo8AYS9vv9msafFYs8HfU2NZ8xQUK9tvdYtoUsmHy9u+OOsi7dCRx0J6be1lvjpFHMo
         3/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O76xUT7SSARx3cTDI+8c0nJmW6EIyOXlmUF53JN4QxE=;
        b=kbdysfvR1NH/A1ZKNlsNJqdONCrFz9LTU5NQaAKv+A2+5tlBBC5e04JJtYl8nYVB15
         mBO8WRQuWLIdWWuZFSPPJXZRuwIURfSuns5bWZ19TdrJlfzlDHeY7fwxwl4meid7BhRz
         sduwzT1WaRL143u+OnQTvWpVaGIqfj8V3WyMPyQPKnz9XrnwJlgfGCknRR5FNcYWPcTh
         FTKXDVToiSAbh2YKZLtBmmf0gpOO+S3ZIVFKzw5S0GEXuzzPqfatLoANM6Xeb9DKoAli
         hvKlkO9xCRf0cEQAfQUv5DM1UrAcgXi9sN0RdkEioRiUq2hvBfJtI6dII+gdozwbHwK9
         AIug==
X-Gm-Message-State: AOAM531SlfYjC1iDrUkrFQlxP+N6Zaz5RX64tZNy42W6L3MhcnpycegF
        RmoFSAwy4z6N4ebTFKGkpo+17TnbjH+CnQ==
X-Google-Smtp-Source: ABdhPJzANARWKZAHfskT0NonvsL3L50PkPpWMzZDwgYuwKr5NlAWPx0gCmZpq9epH6NKZ+cIe94Wtg==
X-Received: by 2002:a37:c4d:: with SMTP id 74mr3546707qkm.161.1605292973295;
        Fri, 13 Nov 2020 10:42:53 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c27sm7119122qkk.57.2020.11.13.10.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:42:52 -0800 (PST)
Subject: Re: [PATCH v2 02/24] btrfs: extent-io-tests: remove invalid tests
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3692dd4b-e592-11aa-7b5a-c87c87106054@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:42:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> In extent-io-test, there are two invalid tests:
> - Invalid nodesize for test_eb_bitmaps()
>    Instead of the sectorsize and nodesize combination passed in, we're
>    always using hand-crafted nodesize, e.g:
> 
> 	len = (sectorsize < BTRFS_MAX_METADATA_BLOCKSIZE)
> 		? sectorsize * 4 : sectorsize;
> 
>    In above case, if we have 32K page size, then we will get a length of
>    128K, which is beyond max node size, and obviously invalid.
> 
>    Thankfully most machines are either 4K or 64K page size, thus we
>    haven't yet hit such case.
> 
> - Invalid extent buffer bytenr
>    For 64K page size, the only combination we're going to test is
>    sectorsize = nodesize = 64K.
>    However in that case, we will try to test an eb which bytenr is not
>    sectorsize aligned:
> 
> 	/* Do it over again with an extent buffer which isn't page-aligned. */
> 	eb = __alloc_dummy_extent_buffer(fs_info, nodesize / 2, len);
> 
>    Sector alignedment is a hard requirement for any sector size.
>    The only exception is superblock. But anything else should follow
>    sector size alignment.
> 
>    This is definitely an invalid test case.
> 
> This patch will fix both problems by:
> - Honor the sectorsize/nodesize combination
>    Now we won't bother to hand-craft a strange length and use it as
>    nodesize.
> 
> - Use sectorsize as the 2nd run extent buffer start
>    This would test the case where extent buffer is aligned to sectorsize
>    but not always aligned to nodesize.
> 
> Please note that, later subpage related cleanup will reduce
> extent_buffer::pages[] to exact what we need, making the sector
> unaligned extent buffer operations to cause problem.
> 
> Since only extent_io self tests utilize this invalid feature, this
> patch is required for all later cleanup/refactors.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
