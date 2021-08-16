Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEB63ED8F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhHPO2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 10:28:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhHPO2G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 10:28:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4516721D5C;
        Mon, 16 Aug 2021 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629124054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+1JUzLaQ1xu0U4b8YVphLC0cB0yXD8WoYWapO83CXA=;
        b=AH56QkxsdL/0XO+oY6dAy+QloH+4SwvkvHgA0M8nz13Q5erYIh2bCxzy7mlC6c7JEpcPUN
        FwoB7fFDzecFzkg/5ja8r1hcbOOIVkDcGllN2+ZGHytx7zjsVmarsNSLCIIQ6Cktk0mySs
        iWf7Nijo7ZJ5gtgoDIkEH42wz2PERwA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 09128136A6;
        Mon, 16 Aug 2021 14:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kOo5O9V1GmFCRwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 16 Aug 2021 14:27:33 +0000
Subject: Re: [PATCH 2/2] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816060036.57788-1-wqu@suse.com>
 <20210816060036.57788-3-wqu@suse.com>
 <bcda08a2-c014-10d7-64c8-1ac29b0f43ab@suse.com>
 <417cfed7-e7c6-8c51-254b-7a76533b96c8@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <892a4b32-a2f9-56f4-17b8-a494c287dfc8@suse.com>
Date:   Mon, 16 Aug 2021 17:27:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <417cfed7-e7c6-8c51-254b-7a76533b96c8@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.08.21 г. 16:41, Qu Wenruo wrote:
> 
> 
> On 2021/8/16 下午6:26, Nikolay Borisov wrote:
>>
>>
>> On 16.08.21 г. 9:00, Qu Wenruo wrote:
>>> Currently we use u16 bitmap to make 4k sectorsize work for 64K page
>>> size.
>>>
>>> But this u16 bitmap is not large enough to contain larger page size like
>>> 128K, nor is space efficient for 16K page size.
>>>
>>> To handle both cases, here we pack all subpage bitmaps into a larger
>>> bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
>>> subpage usage.
>>>
>>> Each sub-bitmap will has its start bit number recorded in
>>> btrfs_subpage_info::*_start, and its bitmap length will be recorded in
>>> btrfs_subpage_info::bitmap_nr_bits.
>>>
>>> All subpage bitmap operations will be converted from using direct u16
>>> operations to bitmap operations, with above *_start calculated.
>>>
>>> For 64K page size with 4K sectorsize, this should not cause much
>>> difference.
>>> While for 16K page size, we will only need 1 unsigned long (u32) to
>>> restore the bitmap.
>>> And will be able to support 128K page size in the future.
>>>

<snip>

>>
>> offtopic: Instead of having a bunch of those checks can't we replace
>> them with ASSERTS and ensure that the decision whether we do subpage or
>> not is taken at a higher level ?
> 
> Nope, in this particular call site, btrfs_alloc_subpage() can be called
> with regular page size.
> 
> I guess it's better to rename this function like btrfs_prepare_page()?

There are currently 2 callers:

btrfs_attach_subpage - this one only calls it iff sectorsize != alloc_subage

alloc_extent_buffer - here it's called unconditionally but that can
easily be rectified with an if(subpage) check

<snip>


>> 2 argument of find_next_zero_bit is 'size' which would be nbits as it
>> expects the size to be in bits , not start + nbit. Every logical bitmap
>> in ->bitmaps is defined by [start, nbits] no ? Unfortunately there is a
>> discrepancy between the order of documentation and the order of actual
>> arguments in the definition of this function....
> 
> IT'S A TRAP!
> 
> Paramater 2 (@size) is the total size of the search range, it should be
> larger than the 3rd parameter.

It's not even that it's the end index of the bit we are looking for. I.e
if we want to check bits 20-29 we'd pass 20 as start, and 29 as size ...
This is fucked, but it is what it is. I guess the documentation of the
bits function is dodgy...

<snip>
