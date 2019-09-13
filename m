Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83817B17DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 07:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbfIMFF6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 01:05:58 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:51086 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbfIMFF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 01:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=viSfbLG2J+Ev01+ThMjzIHF7kRhKU8XmatfyJ8TE0kA=; b=lPmMHazi7Dfva2Xc43iBlFK+9h
        cbgRQ3jaPjPgML3yscn7/ijT2XUwAV3yB3yJqIrPhev71wFLBru95rdw3oXtqaSeFozVD6unpq0zJ
        RX6mzAFv2t6wo3So2giSMU1sWgLBb+hYCr4XmNp6Po7eefJIGAEDO+DkWoctwPRu+eC+pmf0nz3+o
        ah8l5niN3zWBpXHnycZ1OK4MalFtAvlJo2GCiykYpGRWN7uIxYvLLfjEKVZN0XOG16KArfII8cpPT
        38yc81vDLLJyuvWuWaqd94OynL7qytPwiZDjMOH32WlnUBPRtEvcicSE9z2jSa+QAa4KNsHMza5lH
        PSDum3RA==;
Received: from [::1] (port=60308 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8dmK-002ZZc-B6; Fri, 13 Sep 2019 01:05:56 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Fri, 13 Sep 2019 01:05:52 -0400
Date:   Fri, 13 Sep 2019 01:05:52 -0400
Message-ID: <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
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

I can't believe I am considering this case.

So, we have a 1TB log file "ultralog" split into 256 million 4 KB  
extents randomly over the entire disk. We have 512 GB free RAM and 2%  
free disk space. The file needs to be defragmented.

In order to do that, defrag needs to be able to copy-move multiple  
extents in one batch, and update the metadata.

The metadata has a total of at least 256 million entries, each of some  
size, but each one should hold at least a pointer to the extent (8  
bytes) and a checksum (8 bytes): In reality, it could be that there is  
a lot of other data there per entry.

The metadata is organized as a b-tree. Therefore, nearby nodes should  
contain data of consecutive file extents.

The trick, in this case, is to select one part of "ultralog" which is  
localized in the metadata, and defragment it. Repeating this step will  
ultimately defragment the entire file.

So, the defrag selects some part of metadata which is entirely a  
descendant of some b-tree node not far from the bottom of b-tree. It  
selects it such that the required update to the metadata is less than,  
let's say, 64 MB, and simultaneously the affected "ultralog" file  
fragments total less han 512 MB (therefore, less than 128 thousand  
metadata leaf entries, each pointing to a 4 KB fragment). Then it  
finds all the file extents pointed to by that part of metadata. They  
are consecutive (as file fragments), because we have selected such  
part of metadata. Now the defrag can safely copy-move those fragments  
to a new area and update the metadata.

In order to quickly select that small part of metadata, the defrag  
needs a metatdata cache that can hold somewhat more than 128 thousand  
localized metadata leaf entries. That fits into 128 MB RAM definitely.

Of course, there are many other small issues there, but this outlines  
the general procedure.

Problem solved?


