Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2147B3FAB13
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 13:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhH2LXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 07:23:18 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:41714 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhH2LXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 07:23:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C424240282;
        Sun, 29 Aug 2021 13:22:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -3.39
X-Spam-Level: 
X-Spam-Status: No, score=-3.39 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-1.49]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hx1Xb9-rIlzR; Sun, 29 Aug 2021 13:22:22 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 62D0F4027E;
        Sun, 29 Aug 2021 13:22:22 +0200 (CEST)
Received: from [192.168.0.10] (port=58520)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mKItJ-0001Vh-Ed; Sun, 29 Aug 2021 13:22:21 +0200
From:   Forza <forza@tnonline.net>
Subject: Re: Support for compressed inline extents
To:     dsterba@suse.cz, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
 <20210822054549.GC29026@hungrycats.org>
 <1097af0f-fb9e-3c68-24b9-2232748ed77c@tnonline.net>
 <20210822083356.GE29026@hungrycats.org>
 <ca2452a6-3f5d-76df-e91b-dff2dcb53052@tnonline.net>
 <20210823202329.GG29026@hungrycats.org> <20210827100855.GV3379@twin.jikos.cz>
Message-ID: <3d3b0bc0-4804-2c40-a343-d6e52bbfa642@tnonline.net>
Date:   Sun, 29 Aug 2021 13:22:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827100855.GV3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-08-27 12:08, David Sterba wrote:
> On Mon, Aug 23, 2021 at 04:23:29PM -0400, Zygo Blaxell wrote:
>> On Mon, Aug 23, 2021 at 09:34:27PM +0200, Forza wrote:
>>> Further up you showed that we can read encoded inlined data. What is missing
>>> for that we can read encoded inlined data that decode to >page_size in size?
>>
>> In uncompress_inline():
>>
>> 	// decoded length of extent on disk...
>> 	max_size = btrfs_file_extent_ram_bytes(leaf, item);
>>
>> 	...
>>
>> 	// ...can never be more than one page because of this line(*)
>> 	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
>>
>> There might be further constraints around this code (e.g. the caller
>> only fills in structures for one page, or doesn't bother to call this
>> function at all for offsets above PAGE_SIZE).
>>
>> All the restrictions would need to be removed in the kernel and support
>> for reading multi-page inline extents added where necessary.  There would
>> have to be an incompat bit on the filesystem to prevent old kernels from
>> trying (and failing) to read longer inline extents.  The disk format is
>> already technically capable of specifying a longer inline extent (up to
>> min(UINT32_MAX, metadata_page_size)) but that was never the problem.
> 
> Regarding the idea of compressed inline extents, I'm not much in favor
> of increasing the limit beyond one page (or sector). The metadata space
> is more precious and that's also the motivation behind low default
> max_inline. Another thing is mixing data and metadata with potentially
> different block group profiles.

We already mix profiles today with inlining small extents. It is not a 
problem as most people use a better/higher redundancy for metadata than 
for data.

> The inline files is IMO a nice little optimization and helps when the
> size is below certain limit to avoid wasting data blocks and the
> indirection.
> 

To be fair, I think the benefit is that we inline instead of creating 
4KiB extents for small amounts of data. This benefit would be true even 
if that data was compressed data and the compressed size was <2KiB.

I do understand the earlier points that this would perhaps be a big 
thing to change, also incompatible with earlier kernels. Given that work 
the benefit is rather small.

Perhaps if we are doing incompatible changes in the future, this could 
be considered at that time? One reference is what Qu wrote here about 
taking in more factors to consider for inlining? 
https://lore.kernel.org/linux-btrfs/d0dccd5e-c67f-a18d-8d6e-559504b5ee91@suse.com/

Thanks
