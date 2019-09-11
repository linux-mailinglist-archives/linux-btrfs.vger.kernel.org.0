Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70750AF3A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 02:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfIKA0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 20:26:43 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:41981 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfIKA0n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 20:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:Cc:To:From:Message-ID:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mbhV9GS4HmVnGXY9BeMOTP7fITbrDhBVC5G9H6XGaRE=; b=6WCHm20KGJOu50QmpkqNsNnPP0
        czI/KbDwvM4M3Khf0K3ZYQdA1TmySVZ9Xee0ZWXEZR+YwbVppQ7HdMadQR0Ye8HZEO9aQ3iwATOqf
        50OQuIDlLpphg+rhRHtu0E2oEjGFduTZxB+bXIXYEBdbRTb7+Ox72bWH68uzIj0bApnzZsxdvaWMR
        cSGuRFsdgtcjWgQLkLtgA6mcYcaJh7Qni0AklSHhP6+B2dqioWGEJnq2a4bAQfQA585PG/TosmKDm
        eIyVbnHPNZor3fAJfssE4b1DVRwUuI4zE3hqQWtH5w9Pdm6uTq8Wc8WNqz86zMScxiDhaw38hmyTA
        pw/w6nnw==;
Received: from [::1] (port=60848 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7qSz-003ctg-LK; Tue, 10 Sep 2019 20:26:42 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 20:26:37 -0400
Date:   Tue, 10 Sep 2019 20:26:37 -0400
Message-ID: <20190910202637.Horde.sP3Q7-sjETTnnOXgETzjAZX@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
 <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
 <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
In-Reply-To: <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
Reply-to: webmaster@zedlx.com
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
X-Authenticated-Sender: server53.web-hosting.com: webmaster@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:


> - Introduce different levels for defrag
>   Allow btrfs to do some calculation and space usage policy to
>   determine if it's a good idea to defrag some shared extents.
>   E.g. my extreme case, unshare the extent would make it possible to
>   defrag the other subvolume to free a huge amount of space.
>   A compromise, let user to choose if they want to sacrifice some space.

Ok, I noticed a few thing comming up frequently in this discussion, so  
I thing we should clear up a meaning of a few words before continuing.
Because same words are used with two different meanings.

First, the term "defrag" can has 2 different meanings in filesystems  
with shared extents

A) "plain defrag" or "unsharing-defrag"
   a file is unshare-defragmented if ALL of the following are met:
    1) all extents are written on disk in neighbouring sectors in the  
ascending order
    2) none of its extents are shared
    3) it doesn't have too many small extents

B) "sharing-defrag"
    a file is share-defragmented if ALL of the following are met:
    1) all extents are written on disk in neighbouring sectors in the  
ascending order
    2) all pairs of *adjanced* extents meet ONE of the following criteria
       2.1) both extents are sufficiently large
       2.2) the two extents have mismatching sharing groups (they are  
shared by different sets of files)

So, it might be, in some cases, a good idea to "plain defrag" some  
files like databases. But, this is a completely separate concern and  
completely different feature. So "plain defrag" is very different  
thing from "sharing-defrag"

Why there needs to be a "sharing defrag"
   - it is a defrag operation that can be run without concern
   - it can be run every day
   - eventually, it needs to be run to prevent degradation of performance
   - all other filesystems have this kind of defrag
   - the user suffers no permanent 'penalties' (like loss of free space)

The "unsharing-defrag" is something completely different, another  
feature for another discussion. I don't want to discuss it, because  
everything will just get confusing.

So, please, lets keep "unsharing-defrag" out of this discussion,  
because it has nothing to do with the thing I'm talking about.

So the "sharing defrag" is what I mean by saying defrag. That's the  
everyday defrag.






