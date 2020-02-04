Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58D01518D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 11:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgBDKcl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 05:32:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:48040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgBDKck (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 05:32:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2DDAAC69;
        Tue,  4 Feb 2020 10:32:37 +0000 (UTC)
Subject: Re: [PATCH 1/3] btrfs: add a comment describing block-rsvs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200203204436.517473-1-josef@toxicpanda.com>
 <20200203204436.517473-2-josef@toxicpanda.com>
 <8d33b43f-bcba-0fed-60e5-2908e219181b@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e184b283-dffd-898c-53c9-681d399ace98@suse.com>
Date:   Tue, 4 Feb 2020 12:32:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8d33b43f-bcba-0fed-60e5-2908e219181b@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.02.20 г. 11:30 ч., Qu Wenruo wrote:
> 
> 
> On 2020/2/4 上午4:44, Josef Bacik wrote:
>> This is a giant comment at the top of block-rsv.c describing generally
>> how block rsvs work.  It is purely about the block rsv's themselves, and
>> nothing to do with how the actual reservation system works.
> 
> Such comment really helps!
> 
> Although it looks like there are too many words but too little ascii
> arts or graphs.
> Not sure if it's really easy to read.
> 
> And some questions inlined below.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>  fs/btrfs/block-rsv.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>
>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>> index d07bd41a7c1e..54380f477f80 100644
>> --- a/fs/btrfs/block-rsv.c
>> +++ b/fs/btrfs/block-rsv.c
>> @@ -6,6 +6,87 @@
>>  #include "space-info.h"
>>  #include "transaction.h"
>>


<snip>

>> + *
>> + *   We go to modify the tree for our operation, we allocate a tree block, which
>> + *   calls btrfs_use_block_rsv(), and subtracts nodesize from
>> + *   block_rsv->reserved.
>> + *
>> + *   We finish our operation, we subtract our original reservation from ->size,
>> + *   and then we subtract ->size from ->reserved if there is an excess and free
>> + *   the excess back to the space info, by reducing space_info->bytes_may_use by
>> + *   the excess amount.
> 
> So I find the workflow can be expressed like this using timeline (?) graph:
> 
> +--- Reserve:
> |    Entrance: btrfs_block_rsv_add(), btrfs_block_rsv_refill()
> |
> |    Calculate needed bytes by btrfs_calc*(), then add the needed space
> |    to our ->size and our ->reserved.
> |    This also contributes to space_info->bytes_may_use.
> |
> +--- Use:
> |    Entrance: btrfs_use_block_rsv()
> |
> |    We're allocating a tree block, will subtracts nodesize from
> |    block_rsv->reserved.
> |
> +--- Finish:
>      Entrance: btrfs_block_rsv_release()
> 
>      we subtract our original reservation from ->size,
>      and then we subtract ->size from ->reserved if there is an excess
>      and free the excess back to the space info, by reducing
>      space_info->bytes_may_use by the excess amount.

I find this graphic helpful. Also IMO it's important to explicitly state
that ->size is based on an overestimation, whereas the space subtracted
from ->reserved is always based on real usage, hence we can have a case
where we end up with  excess space that can be returned.

Over reservation is mentioned in the BLOCK_RSV_GLOBAL paragraph but I
think it should be here and can be removed from there.
> 
>> + *
>> + *   In some cases we may return this excess to the global block reserve or
>> + *   delayed refs reserve if either of their ->size is greater than their
>> + *   ->reserved.
>> + *
> 
> Types of block_rsv:
> 
>> + * BLOCK_RSV_TRANS, BLOCK_RSV_DELOPS, BLOCK_RSV_CHUNK
>> + *   These behave normally, as described above, just within the confines of the
>> + *   lifetime of ther particular operation (transaction for the whole trans
>> + *   handle lifetime, for example).
>> + *
>> + * BLOCK_RSV_GLOBAL
>> + *   This has existed forever, with diminishing degrees of importance.
>> + *   Currently it exists to save us from ourselves.  We definitely over-reserve
>> + *   space most of the time, but the nature of COW is that we do not know how
>> + *   much space we may need to use for any given operation.  This is
>> + *   particularly true about the extent tree.  Modifying one extent could
>> + *   balloon into 1000 modifications of the extent tree, which we have no way of
>> + *   properly predicting.  To cover this case we have the global reserve act as
>> + *   the "root" space to allow us to not abort the transaciton when things are
nit: s/transaciton/transaction
>> + *   very tight.  As such we tend to treat this space as sacred, and only use it
>> + *   if we are desparate.  Generally we should no longer be depending on its
nit: s/desparate/desperate

>> + *   space, and if new use cases arise we need to address them elsewhere.
> 
> Although we all know global rsv is really important for essential tree
> updates, can we make it a little simpler?
> It looks too long to read though.

The 2nd sentence of the paragraph can be removed. Also it can be
mentioned that globalrsv is used for other trees apart from extent i.e
chunk/csum ones. Also isn't it used to ensure progress of unlink() ?

> 
> I guess we don't need to put all related info here.
> Maybe just mentioning the usage of each type is enough?
> (Since the reader will still go greping for more details)
> 
> This also applies to the remaining types.


I disagree, those comment provide glimpses of the problem that
necessitated having block rsv in the first place. It's good to read this
before diving into the code.

<snip>
