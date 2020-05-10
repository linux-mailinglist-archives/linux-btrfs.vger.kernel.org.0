Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1B1CCA8A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgEJLIA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 07:08:00 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:52751 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgEJLIA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 07:08:00 -0400
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.92.3)
        id 1jXjoN-009XtU-By; Sun, 10 May 2020 12:07:59 +0100
MIME-Version: 1.0
Date:   Sun, 10 May 2020 12:07:59 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Exploring referenced extents
In-Reply-To: <d89caa53-a3b6-5c4e-a577-a89490064a40@cobb.uk.net>
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
 <d89caa53-a3b6-5c4e-a577-a89490064a40@cobb.uk.net>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <d52ff5969b6026285729bb12d3533dfb@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-05-09 22:32, Graham Cobb wrote:
> On 09/05/2020 12:11, Steven Davies wrote:
>> For curiosity I'm trying to write a tool which will show me the size 
>> of
>> data extents belonging to which files in a snapshot are exclusive to
>> that snapshot as a way to show how much space would be freed if the
>> snapshot were to be deleted, and which files in the snapshot are 
>> taking
>> up the most space.
> 
> I have some scripts to do that. They are slow but seem to pretty much
> work. See https://github.com/GrahamCobb/extents-lists
> 
>> I'm working with Hans van Kranenburg's python-btrfs python library but
>> my knowledge of the filesystem structures isn't good enough to allow 
>> me
>> to figure out which bits of data I need to be able to achieve this. 
>> I'd
>> be grateful if anyone could help me along with this.
> 
> Rewriting them to use Hans' library is one of the things I plan to do
> one day!
> 
>> So far my idea is:
>> 
>> for each OS file in a subvolume:
>>   find its data extents
>>   for each extent:
>>     find what files reference it #1
>>     for each referencing file:
>>       determine which subvolumes it lives in #2
>>     if all references are within this subvolume:
>>       record the OS file path and extents it references
>> 
>> for each recorded file path
>>   find its data extents
>>   output its path and the total number of bytes in all recorded 
>> extents
>> (those which are not shared)
> 
> My approach is different. I don't attempt to understand which files
> share extents, or which subvolumes they are in. Instead, I just try to
> analyse which extents are in use by a subvolume (or, actually, any set
> of files you specify).
> 
> This is easy (but slow) to do. And makes answering some questions easy.
> However, it makes answering questions like "how many extents would
> really be freed if I deleted this subvolume" hard (the scripts end up
> working out the complete list of extents in use on the filesystem, and,
> separately,  the list of which would be in use if the subvolume was
> removed - the difference is the space freed up by deleting the 
> subvolume).

The original goal for my script was to answer the question "why does 
qgroups show this snapshot has so much exclusive data?". I keep a record 
of the qgroups reported exclusive sizes over time and occasionally check 
whether backups or snapshotting need to be reconfigured. I figured that 
a list of files and their exclusive extent sizes would show what is 
contributing the most to the exclusive data shown by qgroups.

I suppose what I'm effectively doing is writing a more granular version 
of qgroups, as Qu said. Like yours, it'll be slow for large trees.

> This often takes a day or two.
> 
> I would be interested if you find a more efficient approach to working
> out how much space will be freed up if a set of files (such as
> particular subvolumes) are removed, allowing for snapshots, reflink
> copies and dedup.
> 
> Graham
-- 
Steven Davies
