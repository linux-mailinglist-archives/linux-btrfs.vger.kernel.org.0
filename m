Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0621ED23
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgGNJqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 05:46:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgGNJqO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 05:46:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AB4BABCE;
        Tue, 14 Jul 2020 09:46:15 +0000 (UTC)
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
To:     Robbie Ko <robbieko@synology.com>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, David Sterba <dsterba@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200709024808.18466-1-robbieko@synology.com>
 <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
 <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
Date:   Tue, 14 Jul 2020 11:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/13/20 3:57 AM, Robbie Ko wrote:
> 
> Vlastimil Babka 於 2020/7/10 下午11:31 寫道:
>> On 7/9/20 4:48 AM, robbieko wrote:
>>> From: Robbie Ko <robbieko@synology.com>
>>>
>>> When a migrate page occurs, we first create a migration entry
>>> to replace the original pte, and then go to fallback_migrate_page
>>> to execute a writeout if the migratepage is not supported.
>>>
>>> In the writeout, we will clear the dirty bit of the page and use
>>> page_mkclean to clear the dirty bit along with the corresponding pte,
>>> but page_mkclean does not support migration entry.
>>>
>>> The page ditry bit is cleared, but the dirty bit of the pte still exists,
>>> so if mmap continues to write, it will result in data loss.
>> Curious, did you observe this data loss? What filesystem? If yes, it seems
>> serious enough to
>> CC stable and determine a Fixes: tag?
> 
> Yes, there is data loss.
> I'm using a btrfs environment, but not the following patch

And the kernel is otherwise upstream? Which version?
Anyway we better let btrfs guys know (+CC) even if the fix is in MM code.

> btrfs: implement migratepage callback for data pages
> https://git.kernel.org/pub/scm/linux/kernel 
> /git/torvalds/linux.git/commit/?h=v5.8-rc5& 
> id=f8e6608180a31cc72a23b74969da428da236dbd1

That's a new commit, so if this is really affecting upstream btrfs pre-5.8 we
should either backport that commit, or your fix (after review).

>>> We fix the by first remove the migration entry and then clearing
>>> the dirty bits of the page, which also clears the pte's dirty bits.
>>>
>>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>>> ---
>>>   mm/migrate.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index f37729673558..5c407434b9ba 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -875,10 +875,6 @@ static int writeout(struct address_space *mapping, struct page *page)
>>>   		/* No write method for the address space */
>>>   		return -EINVAL;
>>>   
>>> -	if (!clear_page_dirty_for_io(page))
>>> -		/* Someone else already triggered a write */
>>> -		return -EAGAIN;
>>> -
>>>   	/*
>>>   	 * A dirty page may imply that the underlying filesystem has
>>>   	 * the page on some queue. So the page must be clean for
>>> @@ -889,6 +885,10 @@ static int writeout(struct address_space *mapping, struct page *page)
>>>   	 */
>>>   	remove_migration_ptes(page, page, false);
>>>   
>>> +	if (!clear_page_dirty_for_io(page))
>>> +		/* Someone else already triggered a write */
>>> +		return -EAGAIN;
>>> +
>>>   	rc = mapping->a_ops->writepage(page, &wbc);
>>>   
>>>   	if (rc != AOP_WRITEPAGE_ACTIVATE)
>>>
>>
> 

