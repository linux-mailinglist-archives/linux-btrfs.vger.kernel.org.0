Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F215938DB5F
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhEWOJz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEWOJy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 10:09:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37172C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 07:08:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c20so24658642qkm.3
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Id0COXJAduhYYc1RB4J4hEs4+tyaWtrRuvWVXfX+llo=;
        b=0D6YypshfQjgpZ1k1RYLGd7vao2LicOdetW1VjYB4eOPecNNM/SUlO8niRoAHC3xq1
         Br2TpdokvdfOd5yQ3cUxIrgIcrWS3h6hrBTGwvpBASGhiaEYftdv3JJlRXxAh2o72+iL
         1pCi7ejlF49Rz1xz9jwJ1HNBp2oCvOsjMJ2X/BVhzmHZ7oEkHb6nVT5rSQcjlyE3JYru
         SZWiC7+Z8nyFMOsomNrNWPnRPIFEA44HtfjuvR3zLKXa2vEZWB1rUmtIL623bmEInDL/
         BbLjlw4k6PC20535Sf27rkOtUPFC6g3gTvOngsI+Sciuv9RJja2rJwpoDSNRUlMCBXSd
         gPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Id0COXJAduhYYc1RB4J4hEs4+tyaWtrRuvWVXfX+llo=;
        b=UvkdDd1RYNRxFibdeb6Vu1I8MCi2P80RoeWHcgRlOQfXsHLKCA5PZ+CRXAc2XyMHSO
         e679PDE8ai1x36pe82rJWTHazcmr29P9B0Dr7xcbqgMDrKDgXcMNf0u/ge2+14YKs2Ef
         CUrBOhTaeqdMThzDG1OFTlXKDUBIbgRBhWTiyJx3aEDl4wImeTBHTzBW/DlUrzQmylZD
         WDYGmU4arnuHxN7uav8A0kQskTdcBZjbnHdKGK8JDqv+cU15RiCSS551dbLOcai971Eh
         7ZVRIHA2vC6Zmf5GDpRAB2wk7oRL1tNGp2feU1edzgUaR8UlTYf5pLhIt+wkmzLQDNhi
         l4Gw==
X-Gm-Message-State: AOAM531zne1S2nhrrNK4DKIkGlps8iDius5FdyjalOyrxJPJ5gTYXq00
        NWHW1fM5rO9XEOT8m7leLyQTyA==
X-Google-Smtp-Source: ABdhPJxR7Q+/K1U5XoeFh3akpc6ZkjG3Q7+7xjEz51ioN1W7sdlABuSG2Fi8jbnSA6DV3D1aIp6s/g==
X-Received: by 2002:a37:4694:: with SMTP id t142mr24552633qka.265.1621778905957;
        Sun, 23 May 2021 07:08:25 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1067? ([2620:10d:c091:480::1:7444])
        by smtp.gmail.com with ESMTPSA id n18sm8859013qkh.13.2021.05.23.07.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 07:08:25 -0700 (PDT)
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
 <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
 <11a47593-81a3-12a9-a3c9-a6d3316922d7@gmx.com>
 <0543dddf-d86e-fcfb-42d7-57b2e8993997@gmx.com>
 <3423895f-5d21-ab98-b8c4-6c3c2b40d8ea@toxicpanda.com>
 <7570c44c-6032-ebbe-5623-79ce16dcd3fe@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a0213b34-28db-37b5-d8e1-df0909017006@toxicpanda.com>
Date:   Sun, 23 May 2021 10:08:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7570c44c-6032-ebbe-5623-79ce16dcd3fe@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/23/21 9:50 AM, Qu Wenruo wrote:
> 
> 
> On 2021/5/23 下午9:43, Josef Bacik wrote:
>> On 5/23/21 3:40 AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/22 上午8:24, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/5/21 下午10:27, Josef Bacik wrote:
>>>>> On 4/27/21 7:03 PM, Qu Wenruo wrote:
>>>>>> There is a pretty bad abuse of
>>>>>> btrfs_writepage_endio_finish_ordered() in
>>>>>> end_compressed_bio_write().
>>>>>>
>>>>>> It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
>>>>>> which is only supposed to accept inode pages.
>>>>>>
>>>>>> Thankfully the important info here is the inode, so let's pass
>>>>>> btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
>>>>>> make @page parameter optional.
>>>>>>
>>>>>> By this, end_compressed_bio_write() can happily pass page=NULL while
>>>>>> still get everything done properly.
>>>>>>
>>>>>> Also, to cooperate with such modification, replace @page parameter for
>>>>>> trace_btrfs_writepage_end_io_hook() with btrfs_inode.
>>>>>> Although this removes page_index info, the existing start/len
>>>>>> should be
>>>>>> enough for most usage.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>
>>>>> This was merged into misc-next yesterday it looks like, and it's caused
>>>>> both of my VM's that do compression variations to panic on different
>>>>> tests, one on btrfs/011 and one on btrfs/027.  I bisected it to this
>>>>> patch, I'm not sure what's wrong with it but it needs to be dropped
>>>>> from
>>>>> misc-next until it gets fixed otherwise it'll keep killing the
>>>>> overnight
>>>>> xfstests runs.  Thanks,
>>>>
>>>> Any dying message to share?
>>>>
>>>> I just tried with "-o compress" mount option for btrfs/011 and
>>>> btrfs/027, none of them crashed on my local branch (full subpage RW
>>>> branch).
>>>
>>> A full day passed, and still no reproduce.
>>>
>>> And this patch really doesn't change anything for the involved
>>> compressed write path.
>>>
>>> And considering it's the BUG_ON() triggered inside btrfs_map_bio(), it
>>> means we have some bio crossed stripe boundary.
>>> It may be related to device size as that may change the on-disk data
>>> layout.
>>>
>>> Mind to shared the full fstests config and disk layout?
>>>
>>
>> Just 10gib slice of a LV with -o compress.  Though I got panics last
>> night and I think Dave pulled your patches, so maybe bisect lied to me.
>> I'm going to re-run again to see what pops.  THanks,
> 
> And if possible, please re-run the branch of ext/qu/subpage-prep-13
> (commit 42793356463a9674f45118125304fd92c4679c27), which folded one
> known fix in patch
> "btrfs: refactor submit_extent_page() to make bio and its flag tracing
> easier".
> 
> Really hope it's not a bug in the subpage preparation patchset.
> 

Yeah it's not you, IDK what happened with my previous bisect, it ended up being

btrfs: zoned: fix parallel compressed writes

Sorry for the confusion,

Josef
