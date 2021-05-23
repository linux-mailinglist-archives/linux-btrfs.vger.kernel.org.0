Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D208038DB4A
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhEWNpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEWNpR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 09:45:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9834C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 06:43:49 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c10so18805612qtx.10
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ECHmmH4383kqgQIZ61eiGgQATwwto4MfLAGzhDxILc8=;
        b=XGStuHW0Pj6tolBVS8gYeHkdMdvAm6UgwF2YU6NPbBdG86c74uqi0Jgm+V1xRg/mWe
         GcQ7T+D8mbSvqbVRCj71MK1GHnssVF0zB2kJ8mLDh+kCUU5Vue81MNnIdKRO42nfb4uP
         VcJrVucqBFKAu2UKNfxBQ4FEd+hl88vLmWrCWCozxnoWhxX50vZ7e6YRCMGRt4g9Zyd3
         KviinlrS3vGFuTwiZw6kHt9TCHbhUFSbgMUDEwFrVyZdOn9fKODkysOOobrvz64FzsO4
         23CB7a5gY6ALVESq+BeojqH8aj+zsdu3XlLrm8NFQOdkVIho3yyAfKQW7ihsYkmI/P6j
         uN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ECHmmH4383kqgQIZ61eiGgQATwwto4MfLAGzhDxILc8=;
        b=gjFVB6BS/diHU673xeDn0bU0Bs+gCRA+zPiOngvF7oGDTBsNa/D74A6K+qMzZVJO/7
         GP0REjBE2AHiceSzbO9cjSNfnKkhGrNiKrEyFYFfYFolp8B2i5IrJofFE6TwFpRdmWnf
         UYB3ZKYg/RqnSCG/sPM0ZezjxmwVK0xXL85X1iJ/mdoSQhrIhOoRNKAqfqqL0sYt1v2R
         VhPZQ7gdOzWFtK1rvRxuprsugzkzZFB+QaLBvCujZ0wvoQsIk/wgRl58hbe/QTqJCMiP
         8J1vX/EzWPgWuVsU1RhPuo0qLoDTahSco0Bz0BC0xz7jlRJMRi2JZDxb+uwOGiwRxILX
         1VhA==
X-Gm-Message-State: AOAM532B/SuQ8yB4F4AGYaoHvShDU+ImLw5+fK7wVU8lqwBuVhJUEtev
        3VG2c7PYfCgJwZfQapl6TiR3rQ==
X-Google-Smtp-Source: ABdhPJyH2dOOmBwLjeo+LBRZevIAfeINaf3mkoKo0+xMaZc10syf+iozWl9rUdFC2V4bQseHXxhR2A==
X-Received: by 2002:ac8:5b81:: with SMTP id a1mr21521296qta.172.1621777428796;
        Sun, 23 May 2021 06:43:48 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1067? ([2620:10d:c091:480::1:7444])
        by smtp.gmail.com with ESMTPSA id c185sm8912536qkg.96.2021.05.23.06.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 06:43:48 -0700 (PDT)
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
 <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
 <11a47593-81a3-12a9-a3c9-a6d3316922d7@gmx.com>
 <0543dddf-d86e-fcfb-42d7-57b2e8993997@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3423895f-5d21-ab98-b8c4-6c3c2b40d8ea@toxicpanda.com>
Date:   Sun, 23 May 2021 09:43:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <0543dddf-d86e-fcfb-42d7-57b2e8993997@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/23/21 3:40 AM, Qu Wenruo wrote:
> 
> 
> On 2021/5/22 上午8:24, Qu Wenruo wrote:
>>
>>
>> On 2021/5/21 下午10:27, Josef Bacik wrote:
>>> On 4/27/21 7:03 PM, Qu Wenruo wrote:
>>>> There is a pretty bad abuse of btrfs_writepage_endio_finish_ordered() in
>>>> end_compressed_bio_write().
>>>>
>>>> It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
>>>> which is only supposed to accept inode pages.
>>>>
>>>> Thankfully the important info here is the inode, so let's pass
>>>> btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
>>>> make @page parameter optional.
>>>>
>>>> By this, end_compressed_bio_write() can happily pass page=NULL while
>>>> still get everything done properly.
>>>>
>>>> Also, to cooperate with such modification, replace @page parameter for
>>>> trace_btrfs_writepage_end_io_hook() with btrfs_inode.
>>>> Although this removes page_index info, the existing start/len should be
>>>> enough for most usage.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> This was merged into misc-next yesterday it looks like, and it's caused
>>> both of my VM's that do compression variations to panic on different
>>> tests, one on btrfs/011 and one on btrfs/027.  I bisected it to this
>>> patch, I'm not sure what's wrong with it but it needs to be dropped from
>>> misc-next until it gets fixed otherwise it'll keep killing the overnight
>>> xfstests runs.  Thanks,
>>
>> Any dying message to share?
>>
>> I just tried with "-o compress" mount option for btrfs/011 and
>> btrfs/027, none of them crashed on my local branch (full subpage RW
>> branch).
> 
> A full day passed, and still no reproduce.
> 
> And this patch really doesn't change anything for the involved
> compressed write path.
> 
> And considering it's the BUG_ON() triggered inside btrfs_map_bio(), it
> means we have some bio crossed stripe boundary.
> It may be related to device size as that may change the on-disk data layout.
> 
> Mind to shared the full fstests config and disk layout?
>

Just 10gib slice of a LV with -o compress.  Though I got panics last night and I 
think Dave pulled your patches, so maybe bisect lied to me.  I'm going to re-run 
again to see what pops.  THanks,

Josef


