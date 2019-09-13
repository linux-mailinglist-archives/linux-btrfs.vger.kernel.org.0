Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB6B17E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 07:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfIMFWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 01:22:30 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:35910 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfIMFW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 01:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iuDoMDXolMnYr4Qd1x+FhMMq1DU7jbKtuIg65AeCuuY=; b=Zim5kmY6eeYLN983K8eF0P0/cf
        A1ETQ9Bt73zA4+sW3ZxHioSrFGhGDpeW3Or9bxtpfu3jt+KOaHimz56vMSn6FP5g8B4C7rwwJufJb
        fAuM4cFfngGUTGNBoOwQ2lfJsjp44YDRBmHn5DYIJXsVmWWFHgJgzVZp1hdrout4YwfbYIGef1aER
        MgC09cdDUDplGtqLydQWxEpRq8hGw7IEqGpRspLNSquLUz1sO+x+W1WJb56dV9+9fwk+upSOkFUCo
        9GayfSav5L0dpBqWIGTuzvMU4nivzWkFRRbU1KOlrWNJGo+gtUj0VFQdfS6B6mz4ESkdN1m+8pKTX
        Gs46AzVg==;
Received: from [::1] (port=35048 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8e2L-002icC-0J; Fri, 13 Sep 2019 01:22:29 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Fri, 13 Sep 2019 01:22:24 -0400
Date:   Fri, 13 Sep 2019 01:22:24 -0400
Message-ID: <20190913012224.Horde.29BsHKRl-F2PB5EG-U0wHMA@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
In-Reply-To: <20190913031242.GF22121@hungrycats.org>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: general-zed@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:

> On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
>>
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>
>> You mean: all metadata size is 156 GB on one of your systems. However, you
>> don't typically have to put ALL metadata in RAM.
>> You need just some parts needed for defrag operation. So, for defrag, what
>> you really need is just some large metadata cache present in RAM. I would
>> say that if such a metadata cache is using 128 MB (for 2 TB disk) to 2 GB
>> (for 156 GB disk), than the defrag will run sufficiently fast.
>
> You're missing something (metadata requirement for delete?) in those
> estimates.
>
> Total metadata size does not affect how much metadata cache you need
> to defragment one extent quickly.  That number is a product of factors
> including input and output and extent size ratio, the ratio of various
> metadata item sizes to the metadata page size, and the number of trees you
> have to update (number of reflinks + 3 for extent, csum, and free space
> trees).
>
> It follows from the above that if you're joining just 2 unshared extents
> together, the total metadata required is well under a MB.
>
> If you're defragging a 128MB journal file with 32768 4K extents, it can
> create several GB of new metadata and spill out of RAM cache (which is
> currently capped at 512MB for assorted reasons).  Add reflinks and you
> might need more cache, or take a performance hit.  Yes, a GB might be
> the total size of all your metadata, but if you run defrag on a 128MB
> log file you could rewrite all of your filesystem's metadata in a single
> transaction (almost...you probably won't need to update the device or
> uuid trees).
>
> If you want to pipeline multiple extents per commit to avoid seeking,
> you need to multiply the above numbers by the size of the pipeline.
>
> You can also reduce the metadata cache requirement by reducing the output
> extent size.  A 16MB target extent size requires only 64MB of cache for
> the logfile case.
>
>> > Don't forget you have to write new checksum and free space tree pages.
>> > In the worst case, you'll need about 1GB of new metadata pages for each
>> > 128MB you defrag (though you get to delete 99.5% of them immediately
>> > after).
>>
>> Yes, here we are debating some worst-case scenaraio which is actually
>> imposible in practice due to various reasons.
>
> No, it's quite possible.  A log file written slowly on an active
> filesystem above a few TB will do that accidentally.  Every now and then
> I hit that case.  It can take several hours to do a logrotate on spinning
> arrays because of all the metadata fetches and updates associated with
> worst-case file delete.  Long enough to watch the delete happen, and
> even follow along in the source code.
>
> I guess if I did a proactive defrag every few hours, it might take less
> time to do the logrotate, but that would mean spreading out all the
> seeky IO load during the day instead of getting it all done at night.
> Logrotate does the same job as defrag in this case (replacing a file in
> thousands of fragments spread across the disk with a few large fragments
> close together), except logrotate gets better compression.
>
> To be more accurate, the example I gave above is the worst case you
> can expect from normal user workloads.  If I throw in some reflinks
> and snapshots, I can make it arbitrarily worse, until the entire disk
> is consumed by the metadata update of a single extent defrag.
>

In fact, I overcomplicated it in my previous answer.

So, we have a 1TB log file "ultralog" split into 256 million 4 KB  
extents randomly over the entire disk. We have 512 GB free RAM and 2%  
free disk space. The file needs to be defragmented.

We select some (any) consecutive 512 MB of file segments. They are  
certainly localized in the metadata, because we are talking about an  
ordered b-tree. We write those 512 MB of file extents to another place  
on the partition, defragmented (don't update b-tree yet). Then defrag  
calculates the fuse (merge) operation on those written extents. Then  
it calculates which metadata updates are necessary. Since we have  
selected (at the start) consecutive 512 MB of file segments, the  
updates to metadata are certainly localazed. The defrag writes out, in  
new extents, the required changes to metadata, then updates the super  
to commit.

Easy.

