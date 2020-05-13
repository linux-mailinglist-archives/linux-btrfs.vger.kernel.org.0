Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8911D1FD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 22:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbgEMUIG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 16:08:06 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:45553 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387445AbgEMUIG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 16:08:06 -0400
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.92.3)
        id 1jYxfh-00FwN9-7Z; Wed, 13 May 2020 21:08:05 +0100
MIME-Version: 1.0
Date:   Wed, 13 May 2020 21:08:05 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Exploring referenced extents
In-Reply-To: <3e9446ef-955b-351c-8238-9ca07ee38bf6@knorrie.org>
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
 <3e9446ef-955b-351c-8238-9ca07ee38bf6@knorrie.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <ac22328714cb200989294a451fc9930b@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-05-11 02:21, Hans van Kranenburg wrote:
> Hi!

Thanks for your insights!

> On 5/9/20 1:11 PM, Steven Davies wrote:
>> For curiosity I'm trying to write a tool which will show me the size 
>> of
>> data extents belonging to which files in a snapshot are exclusive to
>> that snapshot as a way to show how much space would be freed if the
>> snapshot were to be deleted, and which files in the snapshot are 
>> taking
>> up the most space.

<snip lots of useful information>

This is what I was missing when I read the documentation:

>>      find what files reference it #1
>>      for each referencing file:
>>        determine which subvolumes it lives in #2
> 
> For this, we delegate the work to the running linux kernel code, to ask
> it who's using the extent at this disk_bytenr.
> 
> https://python-btrfs.readthedocs.io/en/stable/btrfs.html#btrfs.ioctl.logical_to_ino_v2
> 
> The main thing you're looking for is the ignore_offset option, which
> will give you a list of *any* user of *any* data in that extent, 
> instead
> of only the first 4096 bytes in it which disk_bytenr itself is part of.

I did rework the script - albeit not the way you suggested (I still walk 
the file tree and look up the extents) because my subvolumes are small 
and stored on relatively fast SSDs, and this way allows me to narrow the 
search to a single directory - but it seems to work now. It isn't pretty 
yet either! It's succeeded in telling me that the reason the oldest 
snapshot of my / subvolume is huge is because it contains a dump of 
linux-firmware that's not shared by anything.

Next job - make it into a tree-like utility.

https://github.com/daviessm/btrfs-snapshots-diff/blob/4003a3fdec70c2a0de348e75a6576f9342754f54/btrfs-subvol-size.py

-- 
Steven Davies
