Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D789C195543
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0K35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 06:29:57 -0400
Received: from mail.itouring.de ([188.40.134.68]:55052 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgC0K35 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 06:29:57 -0400
Received: from tux.applied-asynchrony.com (p5B07E2B3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id CAE284161B3D;
        Fri, 27 Mar 2020 11:29:55 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 7E4E5F01604;
        Fri, 27 Mar 2020 11:29:52 +0100 (CET)
Subject: Re: Q: what exactly does SSD mode still do?
To:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <8dcb2f1b-7cb4-cfd4-04ba-7fe4f3c3940b@applied-asynchrony.com>
 <6f49d2cc-c0e4-6d1d-f10d-834089698528@knorrie.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <116cfdc1-410a-5e09-2fb2-5da2c0fa428a@applied-asynchrony.com>
Date:   Fri, 27 Mar 2020 11:29:52 +0100
MIME-Version: 1.0
In-Reply-To: <6f49d2cc-c0e4-6d1d-f10d-834089698528@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/26/20 11:21 PM, Hans van Kranenburg wrote:
> Hi!
> 
> On 3/26/20 7:16 PM, Holger Hoffstätte wrote:
>>
>> could someone explain what SSD mode *actually* still does? Not ssd_spread,
>> that's clear and unrelated. A recent commit removed the thread-offloaded
>> bio submission (avoiding context switches etc.)
> 
> Can you share the commit id?

[1] followed by [2].

>> - which I thought was the
>> reason for SSD mode? - and looking through the code I couldn't find any
>> bits that helped clarify the difference.
> 
> After the change in 2017 to change the extent allocator in ssd mode for
> data to behave like nossd already did before, there are two differences
> between ssd and nossd left:
> 
> 1) This if statement in tree-log.c:
> 
> cd354ad613a39 (Chris Mason  2011-10-20 15:45:37 -0400 3042)
>     /* when we're on an ssd, just kick the log commit out */
> 0b246afa62b0c (Jeff Mahoney 2016-06-22 18:54:23 -0400 3043)
>     if (!btrfs_test_opt(fs_info, SSD) &&

Ah yes, multi-writer batching - a common DB optimization technique.
I wonder how much of a difference that actually still makes, but
it sounds like a good idea.

> 2) Metadata "cluster allocator" write behavior:
> 
> *empty_cluster = SZ_64K  # nossd
> *empty_cluster = SZ_2M  # ssd
> 
> This happens in extent-tree.c.

2M used to be a common erase block size on SSDs. Or maybe it's just
a nice round number..  ¯\(ツ)/¯

cheers,
Holger

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08635bae0b4ceb08fe4c156a11c83baec397d36d

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba8a9d07954397f0645cf62bcc1ef536e8e7ba24

