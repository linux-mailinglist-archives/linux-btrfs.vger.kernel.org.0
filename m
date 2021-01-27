Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A928306129
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhA0QmC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhA0Qkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:40:45 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D848C0613ED
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:39:55 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d85so2305237qkg.5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gB51gHp6Doatu2gQya62XBM99vJPEUKFyYb45hpzxK0=;
        b=A2WmW1zDZZCxXOHpSEOxvb/IHZdZKlYpsFwfc5EzTkjzQg74HzgAQkW0OBqDT0IO6F
         qI9rmIvtbIYsKkjuK9rnaPU8wA8kh0PZLcb3IaWxeQDnIb8+GohMkoU2/Z69hIfdk1S1
         TDOcOlzJdDPCaB7kMJnScciwSSjHcFWXOeUEKO8+zvSClx1j6rYUZekbjNo055qGROGl
         BYIGgTBi/K6Wj0S59HPmRQMzE99j+fVkxiHMDZIMAgxqcMQii1+1PWIJHgCt0zPjoe2S
         5LHuGRArJ8nxg+TUNN1+UYAcmPpiV1nu/2qxoDVjx3nHjdOo5x3Cud/YuA29F2uDP54z
         Hsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gB51gHp6Doatu2gQya62XBM99vJPEUKFyYb45hpzxK0=;
        b=dw599GSh2NWutkOrZn0QmmomQYJmYcLxH6Zpgr5dd//Y8JXXzbFGAMF0O8Ieu6id9o
         w/4HnTq6l6zunsI+FE6lbsO60E5ZBjTDbIM6voj6W6JRz00CreJsXrL2QpAb2qwYrko5
         3FZWqm//fxOU+X/afaIHpBWwJ3TrYcDrCB5kNHEpd4aon1cJUm4UcdbCJZRMLXtaGUU9
         5L7lKg+CiI3E8xIooQz6wWGsyNwUozB8X+cwpsa8AukxtdvXdpBHPuoM25puSplcAyLD
         W1NHnvIko+c68aWtIlt7uL3R4oevtrErBvbhx511HV9UNs/eQuxep0/XTrQ6mV44emSn
         BWVA==
X-Gm-Message-State: AOAM532k2QLt1djFxCiZdCiCvqsgeMQECjTsv8r98hb73Er6bhYwRBjw
        ZSL4zgIXQD5UDYwI+6drKtP3RA==
X-Google-Smtp-Source: ABdhPJysCBV/oLnAuSthTPvJvAJwGF289mkwGZ75279UkXIFNZntI2uJ6mttk/ZrBDkmlaj2Yp1YOg==
X-Received: by 2002:a37:458c:: with SMTP id s134mr11806401qka.142.1611765594323;
        Wed, 27 Jan 2021 08:39:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b203sm1463375qkg.26.2021.01.27.08.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:39:53 -0800 (PST)
Subject: Re: [PATCH v5 13/18] btrfs: introduce read_extent_buffer_subpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-14-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a6180053-baea-b53a-0b67-abb016474c04@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:39:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-14-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> Introduce a helper, read_extent_buffer_subpage(), to do the subpage
> extent buffer read.
> 
> The difference between regular and subpage routines are:
> 
> - No page locking
>    Here we completely rely on extent locking.
>    Page locking can reduce the concurrency greatly, as if we lock one
>    page to read one extent buffer, all the other extent buffers in the
>    same page will have to wait.
> 
> - Extent uptodate condition
>    Despite the existing PageUptodate() and EXTENT_BUFFER_UPTODATE check,
>    We also need to check btrfs_subpage::uptodate_bitmap.
> 
> - No page iteration
>    Just one page, no need to loop, this greatly simplified the subpage
>    routine.
> 
> This patch only implements the bio submit part, no endio support yet.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
