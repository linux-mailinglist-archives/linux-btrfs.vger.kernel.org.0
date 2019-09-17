Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523F5B45D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 05:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfIQDKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 23:10:34 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:49133 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbfIQDKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 23:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T/auK7Fu9aGEtdosgR+a0REJed466hXBdrsmuK8rqXg=; b=v8IA//LznCjjrX/GBJBEwMN3Vt
        H/Z9IPGLRsl9gJuQZIP/bNK+PHj8kochY+VKIH7qmK/OytPRRX3oaCWqBLB+vLUUNgp4Xdkd/G5HH
        KJt540jhqXyg3I8NmC9WEnwhO7Ndfqb53vjcNJaNUDG8fhooCWBkCsVjkByFJCnpUdDglLJv0Ys9A
        X/OHJbiwP3qjbFyoDdufPrfRUNSTQuaI3qPKaLM0Ph5f+HjzKepLeQjKiSG1sIJuQjduaiR8cPnhr
        q03oQNTciGXt32ZCXOAjaS/ktlrxLJ+cPWy+Zu/DbkAwuUqkVJqOnwi9FJL5BR2iOhQP4ZGNkP1ob
        Jme2Xeng==;
Received: from [::1] (port=55116 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1iA3sq-000VYY-RR; Mon, 16 Sep 2019 23:10:33 -0400
Received: from [95.178.242.132] ([95.178.242.132]) by
 server53.web-hosting.com (Horde Framework) with HTTPS; Mon, 16 Sep 2019
 23:10:28 -0400
Date:   Mon, 16 Sep 2019 23:10:28 -0400
Message-ID: <20190916231028.Horde.Zo7I8Sj-BWHmmLSDYGUq8nB@server53.web-hosting.com>
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
In-Reply-To: <20190916225126.GB24379@hungrycats.org>
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

> On Sun, Sep 15, 2019 at 01:54:07PM -0400, General Zed wrote:
>>
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>
>> > On Fri, Sep 13, 2019 at 09:50:38PM -0400, General Zed wrote:
>> > >
>> > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>> > >
>> > > > On Fri, Sep 13, 2019 at 01:05:52AM -0400, General Zed wrote:
>> > > > >
>> > > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>> > > > >
>> > > > > > On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
>> > > > > > >
>> > > > > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:

I have a few questions for you.

1. Does the btrfs driver already keep a cache off all the mentioned  
trees (entent tree, subvol tree, free space tree, csum tree) in RAM?

   I guess the answer is YES. This makes defrag easier to implement.

2. Is the size of those caches dynamically configurable?

   I guess the answer is YES. This makes defrag easier to implement.

3. Can the cache size of csum tree be increased to approx. 128 MB. ,  
for example?

   I guess the answer is YES. This makes defrag easier to implement.

4. This is a part of format of subvol tree that I don't understand. You said:

"A file consists of an inode item followed by extent ref items (aka
reflinks) in a subvol tree keyed by (inode, offset) pairs.  Subvol tree
pages can be shared with other subvol trees to make snapshots."

Those "extent ref items" must also be forming a tree. But how are  
nodes of this tree addressed? The inode&offset is the key, but how do  
you get an address of a child node?

Do nodes in the subvol tree equal the metadata extents? Or is this  
tree special in that regard? Because, it seems a bit ridiculous to  
have (for example) a 16 KB metadata extent for each directory or a 16  
K metadata extent in the subvol tree for a file that is only a few  
bytes in length.


