Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B556F22205F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGPKPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 06:15:47 -0400
Received: from mail.synology.com ([211.23.38.101]:34630 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgGPKPq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 06:15:46 -0400
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594894528; bh=lHblaYpK9Py+0RsvfRbjoNjLu34cxZmUSNhY6JGGRCA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aQmOvhVSgyFHZKHFp7QpZYdpMkgD7JKW+ZP3FahWEhFgdPmuYLldzvGyM2f7VgMMV
         H7cHhyEY2PwewkGo6/tuAj7iH+SSGPy0FigTwSR8/ROYdcMqPx1eW+ie5mSR9aZicG
         3mrx6HfyWrUrpTThcQyPJCI6Bev1As58+qcAs8xM=
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, David Sterba <dsterba@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200709024808.18466-1-robbieko@synology.com>
 <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
 <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
 <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
 <20200714101951.6osakxdgbhrnfrbd@box>
 <a7bb68ef-9b33-3ed7-8eff-91feb2223d80@synology.com>
 <20200715081148.ufmy6rlrdqn52c4v@box>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <68879817-1507-f42e-7f48-8565145754de@synology.com>
Date:   Thu, 16 Jul 2020 18:15:23 +0800
MIME-Version: 1.0
In-Reply-To: <20200715081148.ufmy6rlrdqn52c4v@box>
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


Kirill A. Shutemov 於 2020/7/15 下午4:11 寫道:
> On Wed, Jul 15, 2020 at 10:45:39AM +0800, Robbie Ko wrote:
>> Kirill A. Shutemov 於 2020/7/14 下午6:19 寫道:
>>> On Tue, Jul 14, 2020 at 11:46:12AM +0200, Vlastimil Babka wrote:
>>>> On 7/13/20 3:57 AM, Robbie Ko wrote:
>>>>> Vlastimil Babka 於 2020/7/10 下午11:31 寫道:
>>>>>> On 7/9/20 4:48 AM, robbieko wrote:
>>>>>>> From: Robbie Ko <robbieko@synology.com>
>>>>>>>
>>>>>>> When a migrate page occurs, we first create a migration entry
>>>>>>> to replace the original pte, and then go to fallback_migrate_page
>>>>>>> to execute a writeout if the migratepage is not supported.
>>>>>>>
>>>>>>> In the writeout, we will clear the dirty bit of the page and use
>>>>>>> page_mkclean to clear the dirty bit along with the corresponding pte,
>>>>>>> but page_mkclean does not support migration entry.
>>> I don't follow the scenario.
>>>
>>> When we establish migration entries with try_to_unmap(), it transfers
>>> dirty bit from PTE to the page.
>> Sorry, I mean is _PAGE_RW with pte_write
>>
>> When we establish migration entries with try_to_unmap(),
>> we create a migration entry, and if pte_write we set it to SWP_MIGRATION_WRITE,
>> which will replace the migration entry with the original pte.
>>
>> When migratepage,  we go to fallback_migrate_page to execute a writeout
>> if the migratepage is not supported.
>>
>> In the writeout, we call clear_page_dirty_for_io to  clear the dirty bit of the page
>> and use page_mkclean to clear pte _PAGE_RW with pte_wrprotect in page_mkclean_one.
>>
>> However, page_mkclean_one does not support migration entries, so the
>> migration entry is still SWP_MIGRATION_WRITE.
>>
>> In writeout, then we call remove_migration_ptes to remove the migration entry,
>> because it is still SWP_MIGRATION_WRITE so set _PAGE_RW to pte via pte_mkwrite.
>>
>> Therefore, subsequent mmap wirte will not trigger page_mkwrite to cause data loss.
> Hm, okay.
>
> Folks, is there any good reason why try_to_unmap(TTU_MIGRATION) should not
> clear PTE (make the PTE none) for file page?
>
This, I'm not sure.
But I think that for the fs that support migratepage, when migratepage 
is finished,
the page should still be dirty, and the pte should still have _PAGE_RW,
when the next mmap write occurs, we don't need to trigger the 
page_mkwrite again.

