Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0AF1CCB33
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgEJMvm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 08:51:42 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:40201 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgEJMvl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 08:51:41 -0400
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.92.3)
        id 1jXlQi-009lpS-1C; Sun, 10 May 2020 13:51:40 +0100
MIME-Version: 1.0
Date:   Sun, 10 May 2020 13:51:40 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Exploring referenced extents
In-Reply-To: <f1a97a6f-4351-147a-ccf3-714387b0f07f@gmx.com>
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
 <13d76c35-fbbf-c5e1-20ee-70a9a716d11f@gmx.com>
 <f2784429472cb7f9cb4d5cbe4b609494@steev.me.uk>
 <f1a97a6f-4351-147a-ccf3-714387b0f07f@gmx.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <8308bcdede193bdbd55ba10aae0e9370@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-05-10 12:55, Qu Wenruo wrote:
> On 2020/5/10 下午6:55, Steven Davies wrote:
>> On 2020-05-10 02:20, Qu Wenruo wrote:

>> Yes, I'm now stuck with a btrfs_extent_inline_ref of type
>> BTRFS_SHARED_DATA_REF_KEY which I understand is a direct backref to a
>> metadata block[1],
> 
> Yep, SHARED_DATA_REF is the type for direct (shows the direct parent)
> for data.
> But there is also an indirect (just tell you how to search) one,
> EXTENT_DATA_REF, and under most case, EXTENT_DATA_REF is more common.
> 
>> but I don't understand how to search for that block
>> itself. I got lucky with the rest of the code and have found all
>> EXTENT_ITEM_KEYs for a file. The python library makes looking through
>> the EXTENT_DATA_REF_KEYs easy but not the shared data refs.
> 
> For EXTENT_DATA_REF, it contains rootid, objectid (inode number), 
> offset
> (not file offset, but a calculated one), and count.
> That's pretty simple, since it contains the rootid and inode number.
> 
> For SHARED_DATA_REF, you need to search the parent bytenr in extent 
> tree.
> It can be SHARED_BLOCK_REF (direct meta ref) or TREE_BLOCK_REF 
> (indirect
> meta ref).
> 
> For TREE_BLOCK_REF, although it contains the owner, you can't stop 
> here,
> but still do a search to build a full path towards that root node.
> Then check each node to make sure if the node is also shared by other 
> trees.
> 
> For SHARED_BLOCK_REF, you need to go to its parent again, until you
> build the full path to the root node.
> 
> Now you can see why the backref code used in balance and qgroup is 
> complex.

I can, I get the feeling that this is now way beyond my abilities and I 
can see why it will be very slow to run in practice - especially through 
the Python abstraction. Perhaps if knorrie adds backref walking helpers 
to python-btrfs it might become more feasible.

-- 
Steven Davies
