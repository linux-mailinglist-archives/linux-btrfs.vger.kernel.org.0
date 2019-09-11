Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BBAAF3D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 03:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfIKBA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 21:00:29 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:38398 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbfIKBA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 21:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:To:From:Message-ID:Date:Sender:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OMWCzDlarZT9nfv26uMUWviGZ6BRZaKNFIfPtSIc9AY=; b=QZ7M1C2ZFaZBh6RbTIFAB5e4+o
        ymLz0h31dZE6aidOZeOGMpR551YpuLabg8FHhCBEcmkvxzbYZQ5Ia5DJXU70v0rWuJ3roErx1qwyt
        SbVZ7KboPBXSTEKpVxkKzZwygf82ai7NS0eLCunVLLvu3+CAHKeSzGSl5+uufbHlMQvImRLtbDcsq
        VGJT5rROEazCqFUI73jGyxWu3CRv42Mj3hNXErvhVzBJRIcjRG8kZfLDVtiDmt0CRi4O/t2vY9wb7
        B5q02LXKDUkG4F93Z4f8Z9c5hPoU17TI1gjyK6E2hbrBlPdDoRDCjhox2WwnjXcPMdaHngxB76+ge
        z3ggeaYQ==;
Received: from [::1] (port=42462 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7qzf-003tYY-It; Tue, 10 Sep 2019 21:00:27 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 21:00:23 -0400
Date:   Tue, 10 Sep 2019 21:00:23 -0400
Message-ID: <20190910210023.Horde.FW3TNKclQrm7CjBRGG_NPNO@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
 <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
 <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
 <20190910202637.Horde.sP3Q7-sjETTnnOXgETzjAZX@server53.web-hosting.com>
In-Reply-To: <20190910202637.Horde.sP3Q7-sjETTnnOXgETzjAZX@server53.web-hosting.com>
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


Quoting myself webmaster@zedlx.com:

> B) "sharing-defrag"
>    a file is share-defragmented if ALL of the following are met:
>    1) all extents are written on disk in neighbouring sectors in the  
> ascending order
      2) all pairs of *adjanced* extents meet AT LEAST ONE of the  
following criteria
>       2.1) both extents are sufficiently large
>       2.2) the two extents have mismatching sharing groups (they are  
> shared by different sets of files)

If it is hard to undersztand what is meant by those rules, consider  
the following example (copy-pasted from previous post):

Let's say that there is a file FFF with extents e11, e12, e13, e22,
e23, e33, e34
- in subvolA the file FFF consists of e11, e12, e13
- in subvolB the file FFF consists of e11, e22, e23
- in subvolC the file FFF consists of e11, e22, e33, e34

After defrag, where 'selected subvolume' is subvolC, the extents are
ordered on disk as follows:

e11,e22,e33,e34 - e23 - e12,e13

In the list above, the comma denotes neighbouring extents, the dash
indicates that there can be a possible gap.

As you can see in the list, the file FFF is fully sharing-defragmented in
subvolC, since its extents are occupying neighbouring disk sectors.  
Except for extents e33,e34  which can be fused if one of them is too  
small. If that is not the case (e33,e34 are sufficiently large), then  
the perfect solution is given.

