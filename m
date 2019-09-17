Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02F0B4636
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 06:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfIQEFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 00:05:13 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:50161 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbfIQEFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 00:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u9HdhXniIx2oulX9REsujGhHJZrpCOpVFT+w6hkv1lo=; b=jkOOxXKacRCWt26KSa0yinz6Yq
        iLdEYpUN/G0qrT9Trg+tF14Xa17qhIhrVQe/T5IwsG6ltO3yGxxuwWtVzesZtMPI3sm3Ex09DztZv
        T0wxVqBbfdgQktGxo5pYVAgaarZOj0+CAd1cDjDoYezG69VbpsSlL/GAWaS4qZXG6bO4G5bUk+zq0
        QJ3hNvydBYEg3v7n7u6bcKLfapbNsN0FtCpiOBxFpRrlGcdriuKAHRf8oHk4IsyFOcdMchvyuEli4
        JEVuZ+/6ZIJSQwPXmShTO4efmyDD1vE63dTBcp478eXnteLF+zgIrcro2ggneNRCnaInAM+fqUE91
        k36syCyA==;
Received: from [::1] (port=33232 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1iA4ji-000zXb-K2; Tue, 17 Sep 2019 00:05:11 -0400
Received: from [95.178.242.132] ([95.178.242.132]) by
 server53.web-hosting.com (Horde Framework) with HTTPS; Tue, 17 Sep 2019
 00:05:06 -0400
Date:   Tue, 17 Sep 2019 00:05:06 -0400
Message-ID: <20190917000506.Horde.IwnY98o2FCxGuJVRhmMVBAp@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
 <20190914005655.GH22121@hungrycats.org>
 <20190913215038.Horde.gsxNyK9aSRLm6Qsl5sUNhf0@server53.web-hosting.com>
 <20190914044219.GL22121@hungrycats.org>
 <20190915135407.Horde.qqs07Bais-BPrjIVxyrrIfo@server53.web-hosting.com>
 <20190916225126.GB24379@hungrycats.org>
 <20190916231028.Horde.Zo7I8Sj-BWHmmLSDYGUq8nB@server53.web-hosting.com>
In-Reply-To: <20190916231028.Horde.Zo7I8Sj-BWHmmLSDYGUq8nB@server53.web-hosting.com>
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


Quoting General Zed <general-zed@zedlx.com>:

> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>
>> On Sun, Sep 15, 2019 at 01:54:07PM -0400, General Zed wrote:
>>>
>>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>>
>>>> On Fri, Sep 13, 2019 at 09:50:38PM -0400, General Zed wrote:
>>>> >
>>>> > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>>> >
>>>> > > On Fri, Sep 13, 2019 at 01:05:52AM -0400, General Zed wrote:
>>>> > > >
>>>> > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>>> > > >
>>>> > > > > On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
>>>> > > > > >
>>>> > > > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>
> I have a few questions for you.
>
> 1. Does the btrfs driver already keep a cache off all the mentioned  
> trees (entent tree, subvol tree, free space tree, csum tree) in RAM?
>
>   I guess the answer is YES. This makes defrag easier to implement.
>
> 2. Is the size of those caches dynamically configurable?
>
>   I guess the answer is YES. This makes defrag easier to implement.
>
> 3. Can the cache size of csum tree be increased to approx. 128 MB. ,  
> for example?
>
>   I guess the answer is YES. This makes defrag easier to implement.
>
> 4. This is a part of format of subvol tree that I don't understand. You said:
>
> "A file consists of an inode item followed by extent ref items (aka
> reflinks) in a subvol tree keyed by (inode, offset) pairs.  Subvol tree
> pages can be shared with other subvol trees to make snapshots."
>
> Those "extent ref items" must also be forming a tree. But how are  
> nodes of this tree addressed? The inode&offset is the key, but how  
> do you get an address of a child node?
>
> Do nodes in the subvol tree equal the metadata extents? Or is this  
> tree special in that regard? Because, it seems a bit ridiculous to  
> have (for example) a 16 KB metadata extent for each directory or a  
> 16 K metadata extent in the subvol tree for a file that is only a  
> few bytes in length.

Oh, I think I get the answer to 4.

There can be multiple directory items per metadata extent and multiple  
inode items per metadata extent. Bu t they all have the same parent.  
So a file will just have an inode item, but this inode item will not  
occupy the entire metadata extent. Also, there could be some smart  
optimizations there so that the inode reflinks-to-file-extents are  
pack together with inode header.

That means there are no stale entries in any metadata extents. There  
are only stale metadata extents i.e. unused metadata extents. But,  
they would be enumerated in the free extents tree, right? Did I get  
that right?


