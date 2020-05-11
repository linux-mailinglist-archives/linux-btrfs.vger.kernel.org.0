Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9451CDCDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 16:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgEKOQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 10:16:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbgEKOQU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 10:16:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76C81AEE9;
        Mon, 11 May 2020 14:16:21 +0000 (UTC)
Subject: Re: [PATCH 19/19] btrfs: update documentation of set/get helpers
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1588853772.git.dsterba@suse.com>
 <86176aac59bae7968d271be7477fe8e36becc9fc.1588853772.git.dsterba@suse.com>
 <1cb28f67-1d0f-fe8d-af78-f0ebd3213172@suse.com>
 <20200511131028.GQ18421@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9c25c145-e596-df1d-c8a0-9bff820590b9@suse.com>
Date:   Mon, 11 May 2020 17:16:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511131028.GQ18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.05.20 г. 16:10 ч., David Sterba wrote:
> On Fri, May 08, 2020 at 12:33:08AM +0300, Nikolay Borisov wrote:
>> On 7.05.20 г. 23:20 ч., David Sterba wrote:
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>  fs/btrfs/struct-funcs.c | 29 ++++++++++++++++-------------
>>>  1 file changed, 16 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
>>> index 225ef6d7e949..1021b80f70db 100644
>>> --- a/fs/btrfs/struct-funcs.c
>>> +++ b/fs/btrfs/struct-funcs.c
>>> @@ -39,23 +39,26 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
>>>  }
>>>  
>>>  /*
>>> - * this is some deeply nasty code.
>>> + * Macro templates that define helpers to read/write extent buffer data of a
>>> + * given size, that are also used via ctree.h for access to item members via
>>> + * specialized helpers.
>>>   *
>>> - * The end result is that anyone who #includes ctree.h gets a
>>> - * declaration for the btrfs_set_foo functions and btrfs_foo functions,
>>> - * which are wrappers of btrfs_set_token_#bits functions and
>>> - * btrfs_get_token_#bits functions, which are defined in this file.
>>> + * Generic helpers:
>>> + * - btrfs_set_8 (for 8/16/32/64)
>>> + * - btrfs_get_8 (for 8/16/32/64)
>>>   *
>>> - * These setget functions do all the extent_buffer related mapping
>>> - * required to efficiently read and write specific fields in the extent
>>> - * buffers.  Every pointer to metadata items in btrfs is really just
>>> - * an unsigned long offset into the extent buffer which has been
>>> - * cast to a specific type.  This gives us all the gcc type checking.
>>> + * Generic helpes with a token, caching last page address:
>>
>> nit: missing 'r' in 'helpers'. Without having looked into the code It's
>> not obvious what a "token" is in this context, is it worth it perhaps
>> documenting? ( I will take a look later and see if it's self-evident).
> 
> I could write it as
> 
> "Generic helpers with a token (a structure caching the address of most
> recently accessed page)"

Much better.

> 
> The use of 'last' is confusing as it's not the last as in the array.
> 
>>> + * - btrfs_set_token_8 (for 8/16/32/64)
>>> + * - btrfs_get_token_8 (for 8/16/32/64)
>>>   *
>>> - * The extent buffer api is used to do the page spanning work required to
>>> - * have a metadata blocksize different from the page size.
>>> + * The set/get functions handle data spanning two pages transparently, in case
>>> + * metadata block size is larger than page.  Every pointer to metadata items is
>>        ^^^^^
>> nit: s/metadata/btree/?
> 
> The terms should be interchangeable, but in the previous sentence it's 'metadata'
> and this one continues, so I wonder how would 'btree' fit here.
> 
> All the structures here are on the higher level, so metadata etc, while
> b-tree node is the storage.

Fair enough, I reread the section and it's ok.

> 
>>> + * an offset into the extent buffer page array, cast to a specific type.  This
>>> + * gives us all the type checking.
>>>   *
>>> - * There are 2 variants defined, one with a token pointer and one without.
>>> + * The extent buffer pages stored in the array pages do not form a contiguous
>>> + * range, but the API functions assume the linear offset to the range from
>>
>> nit: "contiguous physical range"
> 
> Ok.
> 
>>> + * 0 to metadata node size.
>>>   */
>>>  
>>>  #define DEFINE_BTRFS_SETGET_BITS(bits)					\
>>>
