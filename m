Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D03338E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhCJJfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhCJJfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:35:20 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B2C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 01:35:20 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 75DF89C1C4; Wed, 10 Mar 2021 09:35:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1615368916;
        bh=bFKAvxzw9OeSfFmWlrdcucr/ewfk/i+JlFjKQN01Rs8=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=CrPME3t9hF4s9HeJ4TyVpMhIdcpyy7pXtniub7PGqpvFaKiT5Oqu2Q7Re0pCZFZ5v
         8vS5o/RPrQHNL4D/9Ba0Er4h0HxxwFln2yMG7XLMUIWXVpWlRz1q+qnIwTjwnizgTu
         AY+Wa6qr1Zg84S86fmI4xqk/YSelvKn/SwTCmZ7GJWxs5GVMM3Oo0BqN/RHQbcGdDU
         6nNRUs4Cw7RbaZiRQA646uy1Uv3f8ENIsRz2/nW4vzkYYnhct5hm3+rvnDJY9TcDQH
         AT4rdwnTIYVbLJYlL8NBWR6cZg9JJacbCHze3tX0hF+JwfhDxGMEAwExenQsBuPGqe
         qtLhti2jN4I4Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 447479B966
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:35:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1615368911;
        bh=bFKAvxzw9OeSfFmWlrdcucr/ewfk/i+JlFjKQN01Rs8=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=aaQ9+2Cg7s+jPLDgex9fxbi211c3fc7M9vBcsRfN5hKo61nw5ulXjemppXmAgLmM3
         /Qd+HXjyDtOsvuROJQ1P/pc4d8hBLkU0kvKSn1F5hWHnZf6jTpbmIjsFxnOBalcDor
         fWvtsl7gOHhOwQ82ZmCf9WKlfa5RJIYOv05J3xkUA8P/EsvAPCAhxjuwHU4C0AGQdd
         cfiBg+k1BSAGBCi1pvnsLedf6SXyFOKxIQBAh9+Xz4k41zC7fytTiCbxBYD294ymwJ
         sNpEe0dV9+6kL5Engc/wmhu5vVJKWkIEWcPGnIHK89NnnvbxntiozEaPilKWUG/fbB
         7ImExeLXS0EAw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id BDE1620F7D6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:35:10 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210310075957.GG22502@savella.carfax.org.uk>
 <20210310080940.GB2158@tik.uni-stuttgart.de>
Subject: Re: Re: nfs subvolume access?
Message-ID: <5bded122-8adf-e5e7-dceb-37a3875f1a4b@cobb.uk.net>
Date:   Wed, 10 Mar 2021 09:35:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210310080940.GB2158@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/03/2021 08:09, Ulli Horlacher wrote:
> On Wed 2021-03-10 (07:59), Hugo Mills wrote:
> 
>>> On tsmsrvj I have in /etc/exports:
>>>
>>> /data/fex       tsmsrvi(rw,async,no_subtree_check,no_root_squash)
>>>
>>> This is a btrfs subvolume with snapshots:
>>>
>>> root@tsmsrvj:~# btrfs subvolume list /data
>>> ID 257 gen 35 top level 5 path fex
>>> ID 270 gen 36 top level 257 path fex/spool
>>> ID 271 gen 21 top level 270 path fex/spool/.snapshot/2021-03-07_1453.test
>>> ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
>>> ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
>>> ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test
>>>
>>> root@tsmsrvj:~# find /data/fex | wc -l
>>> 489887
> 
>>    I can't remember if this is why, but I've had to put a distinct
>> fsid field in each separate subvolume being exported:
>>
>> /srv/nfs/home     -rw,async,fsid=0x1730,no_subtree_check,no_root_squash
> 
> I must export EACH subvolume?!

I have had similar problems. I *think* the current case is that modern
NFS, using NFS V4, can cope with the whole disk being accessible without
giving each subvolume its own FSID (which I have stopped doing).

HOWEVER, I think that find (and anything else which uses fsids and inode
numbers) will see subvolumes as having duplicated inodes.

> The snapshots are generated automatically (via cron)!
> I cannot add them to /etc/exports

Well, you could write some scripts... but I don't think it is necessary.
I *think* it is only necessary if you want `find` to be able to cross
between subvolumes on the NFS mounted disks.

However, I am NOT an NFS expert, nor have I done a lot of work on this.
I might be wrong. But I do NFS mount my snapshots disk remotely and use
it. And I do see occasional complaints from find, but I live with it.
