Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFA3BA277
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhGBPF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 11:05:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48716 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhGBPF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 11:05:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1C6D200BE;
        Fri,  2 Jul 2021 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625238203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kSAL8cpcgc8uKhKfttZ9zM0oHZspYGAeDYL6WV+aho=;
        b=QpGDozyfYbMohorXJ8Eg+Z/HNFIqgHBbhG0k2Uj13i3iFe193tnfiZgym1epb39oT3mn41
        3gK3H8EmFy6yKhogKmJ5uRi8wAbXd3PTFYGmrVVVKxjv/XBIShEfgqR3xLyLBC2oV04NJt
        smw6pExJAQXIBj5frjfYoZ4EluI09eQ=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A247E11C84;
        Fri,  2 Jul 2021 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625238203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kSAL8cpcgc8uKhKfttZ9zM0oHZspYGAeDYL6WV+aho=;
        b=QpGDozyfYbMohorXJ8Eg+Z/HNFIqgHBbhG0k2Uj13i3iFe193tnfiZgym1epb39oT3mn41
        3gK3H8EmFy6yKhogKmJ5uRi8wAbXd3PTFYGmrVVVKxjv/XBIShEfgqR3xLyLBC2oV04NJt
        smw6pExJAQXIBj5frjfYoZ4EluI09eQ=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id o0CQJLsq32AHdgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Fri, 02 Jul 2021 15:03:23 +0000
Subject: Re: [PATCH] btrfs: Make btrfs_finish_chunk_alloc private to
 block-group.c
To:     fdmanana@gmail.com, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210702124813.29764-1-nborisov@suse.com>
 <PH0PR04MB741661FC90F8B379EC1E5AEA9B1F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5VFtoMkPi9aWErDcWeeWMdsY-2btzfEELrCiizk_mSZw@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9d06d4cf-50ee-c7d9-d4cb-92b60bbe5874@suse.com>
Date:   Fri, 2 Jul 2021 18:03:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5VFtoMkPi9aWErDcWeeWMdsY-2btzfEELrCiizk_mSZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.07.21 г. 17:12, Filipe Manana wrote:
> On Fri, Jul 2, 2021 at 2:21 PM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
>>
>> On 02/07/2021 14:48, Nikolay Borisov wrote:
>>> One of the final things that must be done to add a new chunk is
>>> allocating its device extents and inserting them in the extent tree.
>>> This is currently done in btrfs_finish_chunk_alloc whose name isn't very
>>> informative. What's more this functino is only used in block-group.c bu                      function ~^                                 but ~^
>>
>>> is defined as public. There isn't anything special about it that would
>>> warrant it being defined in volumes.c.
>>>
>>> Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to
>>> block-group.c, make the former static and it to alloc_chunk_dev_extents.
>>                                    rename ~^
>>
>>
>>> The new name is a lot more explicit about the purpose of the function.
> 
> I find the new name confusing as well.
> 
> alloc_chunk_dev_extents() suggests it's allocating device extents, but
> it's not, all it does is insert the device extent items into the
> devices btree.
> Allocation of extents happened in phase 1, through btrfs_alloc_chunk().

The reason I give it plural name is because the inner function is called
alloc_dev_extent hence I gave the top level functino a plural form. I'm
fine simply renaming both functions to insert_dev_extent[s] respectively?

<snip>
