Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275D11CCA5D
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEJKzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 06:55:16 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:41459 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEJKzQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 06:55:16 -0400
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.92.3)
        id 1jXjc1-009WE0-V3; Sun, 10 May 2020 11:55:13 +0100
MIME-Version: 1.0
Date:   Sun, 10 May 2020 11:55:13 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Exploring referenced extents
In-Reply-To: <13d76c35-fbbf-c5e1-20ee-70a9a716d11f@gmx.com>
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
 <13d76c35-fbbf-c5e1-20ee-70a9a716d11f@gmx.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <f2784429472cb7f9cb4d5cbe4b609494@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-05-10 02:20, Qu Wenruo wrote:
> On 2020/5/9 下午7:11, Steven Davies wrote:
>> For curiosity I'm trying to write a tool which will show me the size 
>> of
>> data extents belonging to which files in a snapshot are exclusive to
>> that snapshot as a way to show how much space would be freed if the
>> snapshot were to be deleted,
> 
> Isn't that what btrfs qgroup doing?
> 
>> and which files in the snapshot are taking
>> up the most space.
> 
> That would be interesting as qgroup only works at subvolume level.
> 
>> 
>> I'm working with Hans van Kranenburg's python-btrfs python library but
>> my knowledge of the filesystem structures isn't good enough to allow 
>> me
>> to figure out which bits of data I need to be able to achieve this. 
>> I'd
>> be grateful if anyone could help me along with this.
> 
> You may want to look into the on-disk format first.
> 
> But spoiler alert, since qgroup has its performance impact (although
> hugely reduced in recent releases), it's unavoidable.
> 
> So would be any similar methods.
> In fact, in your particular case, you need more work than qgroup, thus
> it would be slower than qgroup.
> Considering how many extra ioctl and context switches needed, I won't 
> be
> surprised if it's way slower than qgroup.
> 
>> 
>> So far my idea is:
>> 
>> for each OS file in a subvolume:
> 
> This can be done by ftw(), and don't cross subvolume boundary.
> 
>>   find its data extents
> 
> Fiemap.
> 
>>   for each extent:
>>     find what files reference it #1
> 
> Btrfs tree search ioctl, to search extent tree, and do backref walk 
> just
> like what we did in qgroup code.
> 
>>     for each referencing file:
>>       determine which subvolumes it lives in #2
> 
> Unlike kernel, you also need to do this using btrfs tree search ioctl.
> 
>>     if all references are within this subvolume:
>>       record the OS file path and extents it references
>> 
>> for each recorded file path
>>   find its data extents
>>   output its path and the total number of bytes in all recorded 
>> extents
>> (those which are not shared)
>> 
>> #1 and #2 are where my understanding breaks down. How do I find which
>> files reference an extent and which subvolume those files are in?
> 
> In short, you need the following skills (which would make you a btrfs
> developer already):
> - Basic btrfs tree search
>   Things like how btrfs btree works, and how to iterate them.
> 
> - Basic user space file system interface understanding
>   Know tools like fiemap().
> 
> - Btrfs extent tree understanding
>   Know how to interpret inline/keyed data/metadata indirect/direct
>   backref item.
>   This is the key and the most complex thing.
>   IIRC I have added some comments about this in recent backref.c code.

Yes, I'm now stuck with a btrfs_extent_inline_ref of type 
BTRFS_SHARED_DATA_REF_KEY which I understand is a direct backref to a 
metadata block[1], but I don't understand how to search for that block 
itself. I got lucky with the rest of the code and have found all 
EXTENT_ITEM_KEYs for a file. The python library makes looking through 
the EXTENT_DATA_REF_KEYs easy but not the shared data refs.

> - Btrfs subvolume tree understanding
>   Know how btrfs organize files/dirs in its subvolume trees.
>   This is the key to locate which (subvolume, ino) owns a file extent.
>   There are some pitfalls, like the backref item to file extent 
> mapping.
>   But should be easier than extent tree.

[1] 
https://btrfs.wiki.kernel.org/index.php/Data_Structures#btrfs_extent_inline_ref

Thanks,
-- 
Steven Davies
