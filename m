Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B808220227
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGOCFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 22:05:30 -0400
Received: from mail.synology.com ([211.23.38.101]:60084 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbgGOCF3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 22:05:29 -0400
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594778727; bh=YDrsMEH4rB9HXHNVRExpD6LMr7xokp4y9XlpkI3qsRo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kHqL3YjTUkLKU+mFo39ywmRMf4qTO8txj2I5J34NwSQiOHh7HNklZCY4H6mFUzXBV
         GeVsjmCAtIkNCO5Tbt3orFAbv3EVXejLhZTOuEmhwhypkLlUBzhS7jeKCw1GPp25tH
         deYTKO02Sk3S3YYJTWoYOUAfLmaIUyQO2wW/66S8=
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, David Sterba <dsterba@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200709024808.18466-1-robbieko@synology.com>
 <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
 <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
 <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <13d4b937-23e8-2d6f-919c-deb2f4284951@synology.com>
Date:   Wed, 15 Jul 2020 10:05:26 +0800
MIME-Version: 1.0
In-Reply-To: <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Vlastimil Babka 於 2020/7/14 下午5:46 寫道:
> On 7/13/20 3:57 AM, Robbie Ko wrote:
>> Vlastimil Babka 於 2020/7/10 下午11:31 寫道:
>>> On 7/9/20 4:48 AM, robbieko wrote:
>>>> From: Robbie Ko <robbieko@synology.com>
>>>>
>>>> When a migrate page occurs, we first create a migration entry
>>>> to replace the original pte, and then go to fallback_migrate_page
>>>> to execute a writeout if the migratepage is not supported.
>>>>
>>>> In the writeout, we will clear the dirty bit of the page and use
>>>> page_mkclean to clear the dirty bit along with the corresponding pte,
>>>> but page_mkclean does not support migration entry.
>>>>
>>>> The page ditry bit is cleared, but the dirty bit of the pte still exists,
>>>> so if mmap continues to write, it will result in data loss.
>>> Curious, did you observe this data loss? What filesystem? If yes, it seems
>>> serious enough to
>>> CC stable and determine a Fixes: tag?
>> Yes, there is data loss.
>> I'm using a btrfs environment, but not the following patch
> And the kernel is otherwise upstream? Which version?
> Anyway we better let btrfs guys know (+CC) even if the fix is in MM code.

Kernel verion is 4.4.
I think this is a bug that has been around for a long time.

I think the problem is not limited to btrfs, as long as other fs
have not implemented the migrationpage, they will encounter
the problem. (Eg ecryptfs, fat, nfs...)

>> btrfs: implement migratepage callback for data pages
>> https://git.kernel.org/pub/scm/linux/kernel
>> /git/torvalds/linux.git/commit/?h=v5.8-rc5&
>> id=f8e6608180a31cc72a23b74969da428da236dbd1
> That's a new commit, so if this is really affecting upstream btrfs pre-5.8 we
> should either backport that commit, or your fix (after review).
>
>>>> We fix the by first remove the migration entry and then clearing
>>>> the dirty bits of the page, which also clears the pte's dirty bits.
>>>>
>>>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>>>> ---
>>>>    mm/migrate.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index f37729673558..5c407434b9ba 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -875,10 +875,6 @@ static int writeout(struct address_space *mapping, struct page *page)
>>>>    		/* No write method for the address space */
>>>>    		return -EINVAL;
>>>>    
>>>> -	if (!clear_page_dirty_for_io(page))
>>>> -		/* Someone else already triggered a write */
>>>> -		return -EAGAIN;
>>>> -
>>>>    	/*
>>>>    	 * A dirty page may imply that the underlying filesystem has
>>>>    	 * the page on some queue. So the page must be clean for
>>>> @@ -889,6 +885,10 @@ static int writeout(struct address_space *mapping, struct page *page)
>>>>    	 */
>>>>    	remove_migration_ptes(page, page, false);
>>>>    
>>>> +	if (!clear_page_dirty_for_io(page))
>>>> +		/* Someone else already triggered a write */
>>>> +		return -EAGAIN;
>>>> +
>>>>    	rc = mapping->a_ops->writepage(page, &wbc);
>>>>    
>>>>    	if (rc != AOP_WRITEPAGE_ACTIVATE)
>>>>
>
