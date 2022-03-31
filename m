Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506ED4EE047
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiCaSVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCaSVA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 14:21:00 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC2E35875;
        Thu, 31 Mar 2022 11:19:10 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 8F5EF80746;
        Thu, 31 Mar 2022 14:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648750749; bh=KNvxQYBQic9pofn0PgmzAb/owVTqsgyVDZW5db+ph54=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=B07JMpme9jYQkYdbyeZY2FZqP95dA2Y55gjKO2qxqYE6oiStVB2ws9p7vIynjfoPz
         J7eTX4vAIm29u38CfYomjHXabQHqRbr0riMGFiEoSTmwsbMp11VlqX1VdKcyCmrf65
         0lgZejODuy4FHKBpOaRHSu18+YnKTs6Gtqxk3FYFv37ICJYxt9BJhuGXosfbVW89Fp
         nozvoEuKN9H837hav9zeG/sMgZjpqdHWDVoGnzRjKeNF2UOwMzAEF1Bz/vypUlGh7F
         nS7S4AM5a1pN7H57KcYNcfCqCxqR6whS7mjGkcd2szBFIAE0038zsm9B525BVHHGWt
         hRpoGHfmKbodw==
Message-ID: <f9493291-9981-d684-bf49-a551aaf08061@dorminy.me>
Date:   Thu, 31 Mar 2022 14:19:07 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] btrfs: allocate page arrays using bulk page
 allocator
Content-Language: en-US
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1648669832.git.sweettea-kernel@dorminy.me>
 <ede1d39f7878ee2ed12c1526cc2ec358a2d862cf.1648669832.git.sweettea-kernel@dorminy.me>
 <20220331173525.GF15609@twin.jikos.cz>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220331173525.GF15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/31/22 13:35, David Sterba wrote:
> On Wed, Mar 30, 2022 at 04:11:23PM -0400, Sweet Tea Dorminy wrote:
>> While calling alloc_page() in a loop is an effective way to populate an
>> array of pages, the kernel provides a method to allocate pages in bulk.
>> alloc_pages_bulk_array() populates the NULL slots in a page array, trying to
>> grab more than one page at a time.
>>
>> Unfortunately, it doesn't guarantee allocating all slots in the array,
>> but it's easy to call it in a loop and return an error if no progress
>> occurs. Similar code can be found in xfs/xfs_buf.c:xfs_buf_alloc_pages().
>>
>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>> Changes in v3:
>>   - Added a newline after variable declaration
>> Changes in v2:
>>   - Moved from ctree.c to extent_io.c
>> ---
>>   fs/btrfs/extent_io.c | 24 +++++++++++++++---------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index ab4c1c4d1b59..b268e47aa2b7 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3144,19 +3144,25 @@ static void end_bio_extent_readpage(struct bio *bio)
>>    */
>>   int btrfs_alloc_page_array(unsigned long nr_pages, struct page **page_array)
>>   {
>> -	int i;
>> +	long allocated = 0;
>> +
>> +	for (;;) {
>> +		long last = allocated;
>>   
>> -	for (i = 0; i < nr_pages; i++) {
>> -		struct page *page;
>> +		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages,
>> +						   page_array);
>> +		if (allocated == nr_pages)
>> +			return 0;
>>   
>> -		if (page_array[i])
>> +		if (allocated != last)
>>   			continue;
>> -		page = alloc_page(GFP_NOFS);
>> -		if (!page)
>> -			return -ENOMEM;
>> -		page_array[i] = page;
>> +		/*
>> +		 * During this iteration, no page could be allocated, even
>> +		 * though alloc_pages_bulk_array() falls back to alloc_page()
>> +		 * if  it could not bulk-allocate. So we must be out of memory.
>> +		 */
>> +		return -ENOMEM;
>>   	}
> 
> I find the way the loop is structured a bit cumbersome so I'd suggest to
> rewrite it as:
> 
> int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
> {
>          unsigned int allocated;
> 
>          for (allocated = 0; allocated < nr_pages;) {
>                  unsigned int last = allocated;
> 
>                  allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, page_array);
> 
>                  /*
>                   * During this iteration, no page could be allocated, even
>                   * though alloc_pages_bulk_array() falls back to alloc_page()
>                   * if  it could not bulk-allocate. So we must be out of memory.
>                   */
>                  if (allocated == last)
>                          return -ENOMEM;
>          }
>          return 0;
> }
Sounds good, I'll amend it that way.

> 
> Also in the xfs code there's memalloc_retry_wait() which is supposed to be
> called when repeated memory allocation is retried. What was the reason
> you removed it?

Trying to keep the behavior as close as possible to the existing behavior.

The current behavior of each alloc_page loop is to fail if alloc_page() 
fails; in the worst case, alloc_pages_bulk_array() calls alloc_page() 
after trying to get a batch, so I figured the worst case is still 
basically a loop calling alloc_page() and failing if it ever fails.

Reading up on it, though, arguably the memalloc_retry_wait() should 
already be in all the callsites, so maybe I should insert a patch in the 
middle that just adds the memalloc_retry_wait() into 
btrfs_alloc_page_array()? Since it's an orthogonal fixup to either the 
refactoring or the conversion to alloc_pages_bulk_array()?

Thanks!

Sweet Tea
