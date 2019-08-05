Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF03F82107
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfHEQBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 12:01:44 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:43728 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHEQBo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 12:01:44 -0400
Received: from tux.wizards.de (p5DE2BA44.dip0.t-ipconnect.de [93.226.186.68])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 0D03B4161D6B;
        Mon,  5 Aug 2019 18:01:43 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id A8F3BF0160B;
        Mon,  5 Aug 2019 18:01:42 +0200 (CEST)
Subject: Re: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190805131942.8669-1-josef@toxicpanda.com>
 <ca939ada-e4ef-80a2-9b8f-e64279f48ff7@applied-asynchrony.com>
 <20190805154118.GA28208@twin.jikos.cz>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <09cfdb54-736c-c344-07d4-382b954f7f9f@applied-asynchrony.com>
Date:   Mon, 5 Aug 2019 18:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805154118.GA28208@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/5/19 5:41 PM, David Sterba wrote:
> On Mon, Aug 05, 2019 at 04:10:39PM +0200, Holger Hoffstätte wrote:
>> On 8/5/19 3:19 PM, Josef Bacik wrote:
>>> In testing block group removal it's sometimes handy to be able to create
>>> block groups on demand.  Add an ioctl to allow us to force allocation
>>> from userspace.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>> v1->v2:
>>> - I noticed last week when backporting this that btrfs_chunk_alloc doesn't
>>>     figure out the rest of the flags needed for the type.  Use
>>>     btrfs_force_chunk_alloc instead so that we get the raid settings for the alloc
>>>     type we're using.
>>
>> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>>
>> Now works as intended - very nice, thanks!
> 
> Tell me, are you interested in this ioctl because it was the missing bit
> for testing or because the chunk allocator is so bad that you need a
> command to make work?

Mostly curiosity. "To make [it] work" would be a bit strong - btrfs works
fine by now. But yes, slightly over-allocating both metadata and data
(both by ~1-2 chunks) helps esp. when there is a mix of small and large
files, and to reduce fragmentation of large files. That should not be
surprising.

-h
