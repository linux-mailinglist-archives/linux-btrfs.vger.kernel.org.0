Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463C12FAFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE3Lgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 07:36:43 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:39923 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfE3Lgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 07:36:42 -0400
Received: by mail-it1-f177.google.com with SMTP id j204so3493900ite.4
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a3GhSTTSubPQCR2Iq8pL5QgC7SXygfsUeWYQf5UpoNk=;
        b=tF6VQcrSQAHvgsP6BdKBbORfo+HbBJI5e9UIYI8d2DC7D9/sJWsuI0woRVK/xGlMZ4
         KLvcmD78519LikPSO9B/sCnMK9VFzEDEqClcTCFG+akTuqwz6BCqbHrcuox/Zq/uc8Ti
         cNYq95YCBzenk9TJbNJExpJ9quiO/qfBeb4THGZAy4Ks4IzB8qMe41oHo0sLs9IUI91u
         Dd9374hYy5JyhdSfPOpjfMDWL/VQXffe7THshxLv9q8HjTfly0UwhrEz76/UdqNeADYD
         iR7MEEj2EeB6ORGIKy7m5dROsFTcK0XQWEdzJwgkNCVE3PszPuW7X0jBIFj6XNgofqb2
         YiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a3GhSTTSubPQCR2Iq8pL5QgC7SXygfsUeWYQf5UpoNk=;
        b=IYDlyTTvOfQ3S9or5oj/Tj8CWaKWdklkEY+03ALM8vlPWIcjPTAzlQBrLaF6zmgfZL
         //7EKRdTZ28SthRAbrOuqKUiQoFtkvqSTbkjObeYG38O5zMO4x8cqzTYWX6A4R0Az+xv
         qAlVHVqRZnUY+k5B4H6Oy4HxRLs/EHdEWkzlFNjVsA+dkdz7BiTOAIhjyeaD0BQyf/2n
         IIsTWS2OUIdIYw8d3kAfvvNfGcxMCTICzJWmOHFsRcrf+JRmWat7Zm8jTpzc4zYFsxkp
         qYgUBqenH1WNHF0yDtZiEvjRo9/HH2kDXaH8KmKbnJ95scgG2dOZRd8eFfcqgNVF8N/R
         ywFQ==
X-Gm-Message-State: APjAAAUfEHm7L+gzYBKnOi/PISjuxhZNMlkUwbJO4J615fR8Jj4rpQp0
        SYm6Mhxupm2D/lMWejgFKkT7Ez99/3YJnw==
X-Google-Smtp-Source: APXvYqxgeKWqxxPEOBPOBpzvuJzzwDtnWaF/ZJ8hHkPbdfxkT+trZiIq3R1aXAcyLCtFy4Fcet2cKw==
X-Received: by 2002:a24:170b:: with SMTP id 11mr1081633ith.14.1559216201700;
        Thu, 30 May 2019 04:36:41 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id h20sm807149iog.6.2019.05.30.04.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:36:41 -0700 (PDT)
Subject: Re: sub-file dedup
To:     Newbugreport <newbugreport@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0tUXYHrSBzkwOdUp7Az8PrnXzFeWPycFN82KoFJ-fkvTjnrYwPP77RoZbDkO6RjkpPBjQlL4p2tUKywSpxErBQJTVJk8zexKNWjW6k6W0CE=@protonmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <38eb5d80-4c71-c449-c940-2c2ced59ae9c@gmail.com>
Date:   Thu, 30 May 2019 07:36:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0tUXYHrSBzkwOdUp7Az8PrnXzFeWPycFN82KoFJ-fkvTjnrYwPP77RoZbDkO6RjkpPBjQlL4p2tUKywSpxErBQJTVJk8zexKNWjW6k6W0CE=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-29 21:13, Newbugreport wrote:
> I'm experimenting with the rsync algorithm for btrfs deduplication. Every other deduplication tool I've seen works against whole files. I'm concerned about deduping chunks under 4k and about files with scattered extents.
AFAIK, regions smaller than the FS block size cannot be deduplicated, so 
you're limited to 4k in most cases, possibly larger on some systems.

Also, pretty much every tool I know of for deduplication on BTRFS 
operates not on whole files, but on blocks.  duperemove, for example, 
scans whole files at whatever chunk size you tell it to, figures out 
duplicated extents (that is, runs of sequential duplicate chunks), and 
then passes the resultant extents to the dedupe ioctl.  That approach 
even works to deduplicate data _within_ files.
> 
> Are there best practices for deduplication on btrfs?
> General thoughts:

* Minimize the number of calls you make to the actual dedupe ioctl as 
much as possible, it does a bytewise comparison of all the regions 
passed in, and has to freeze I/O to the files the regions are in until 
it's done, so it's both expensive in terms of time and processing power, 
and it can slow down the filesystem.  The clone ioctl can be used 
instead (and is far faster), but runs the risk of data loss if the files 
are in active use.

* Doing a custom script or tool for finding duplicate regions for your 
data that actually understands the structure of the data will almost 
always get you better deduplication results and run much faster than one 
of the generic tools.  For example, I've got a couple of directories on 
one of my systems where if two files have the same name and relative 
path under those directories, they _should_ be identical, so all I need 
to deduplicate that data is a simple path-matching tool that passes 
whole files to the dedupe ioctl.

* Deduplicating really small blocks within files is almost never worth 
it (which is part of why most dedupe tools default to operating on 
chunks of 128k or larger) because:
     - A single reflink for a 4k block actually takes up at least the 
same amount of space as just having the block there, and it might take 
up more depending on how the extents are split (if the existing 4k block 
is part of an extent, then it may not be freed when you replace it with 
the reflink).
     - Having huge numbers of reflinks can actually negatively impact 
filesystem performance.  Even ignoring the potential issues with stuff 
like qgroups, the fragmentation introduced by using lots of reflinks 
increases the overhead of reading files by a non-negligible amount (even 
on SSD's).
