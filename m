Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF13262F5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgIINsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 09:48:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgIINYC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 09:24:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4C50B20F;
        Wed,  9 Sep 2020 12:14:07 +0000 (UTC)
Subject: Re: [PATCH 05/10] btrfs: Remove btrfs_get_extent indirection from
 __do_readpage
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-6-nborisov@suse.com>
 <8d1907b2-9f1f-72ef-6949-f25e64d001d8@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <430126ef-ec2d-f542-0ea2-737dbe82780f@suse.com>
Date:   Wed, 9 Sep 2020 14:56:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d1907b2-9f1f-72ef-6949-f25e64d001d8@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.09.20 г. 14:24 ч., Qu Wenruo wrote:
> 
> 
> On 2020/9/9 下午5:49, Nikolay Borisov wrote:
>> Now that this function is only responsible for reading data pages it's
>> no longer necessary to pass get_extent_t parameter across several
>> layers of functions. This patch removes this parameter from multiple
>> functions: __get_extent_map/__do_readpage/__extent_read_full_page/
>> extent_read_full_page and simply calls btrfs_get_extent directly in
>> __get_extent_map.
> 
> Then it would be much nicer to see a patch renaming all these functions
> to specifically name as like
> get_data_extent_map/do_data_readpage/data_extent_read_full_page.
> 
> The current extent/page naming is too generic, not really distinguish
> the completely different path between data and metadata.
> 
> And maybe split extent_io into meta_io and data_io. <- That may be
> overkilled I guess...

I will mull over this suggestion in any case it  is outside the scope of
the current series.

> 
> Thanks,
> Qu
> 
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 31 ++++++++++++-------------------
>>  fs/btrfs/extent_io.h |  3 +--
>>  fs/btrfs/inode.c     |  2 +-
>>  3 files changed, 14 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 1789a7931312..4c04d3655538 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3110,8 +3110,7 @@ void set_page_extent_mapped(struct page *page)
>>
>>  static struct extent_map *
>>  __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
>> -		 u64 start, u64 len, get_extent_t *get_extent,
>> -		 struct extent_map **em_cached)
>> +		 u64 start, u64 len, struct extent_map **em_cached)
>>  {
>>  	struct extent_map *em;
>>
>> @@ -3127,7 +3126,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
>>  		*em_cached = NULL;
>>  	}
>>
>> -	em = get_extent(BTRFS_I(inode), page, start, len);
>> +	em = btrfs_get_extent(BTRFS_I(inode), page, start, len);
>>  	if (em_cached && !IS_ERR_OR_NULL(em)) {
>>  		BUG_ON(*em_cached);
>>  		refcount_inc(&em->refs);
>> @@ -3142,9 +3141,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
>>   * XXX JDM: This needs looking at to ensure proper page locking
>>   * return 0 on success, otherwise return error
>>   */
>> -static int __do_readpage(struct page *page,
>> -			 get_extent_t *get_extent,
>> -			 struct extent_map **em_cached,
>> +static int __do_readpage(struct page *page, struct extent_map **em_cached,
>>  			 struct bio **bio, int mirror_num,
>>  			 unsigned long *bio_flags, unsigned int read_flags,
>>  			 u64 *prev_em_start)
>> @@ -3211,7 +3208,7 @@ static int __do_readpage(struct page *page,
>>  		if (pg_offset != 0)
>>  			trace_printk("PG offset: %lu iosize: %lu\n", pg_offset, iosize);
>>  		em = __get_extent_map(inode, page, pg_offset, cur,
>> -				      end - cur + 1, get_extent, em_cached);
>> +				      end - cur + 1, em_cached);
>>  		if (IS_ERR_OR_NULL(em)) {
>>  			SetPageError(page);
>>  			unlock_extent(tree, cur, end);
>> @@ -3364,16 +3361,14 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
>>  	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>>
>>  	for (index = 0; index < nr_pages; index++) {
>> -		__do_readpage(pages[index], btrfs_get_extent, em_cached,
>> -				bio, 0, bio_flags, REQ_RAHEAD, prev_em_start);
>> +		__do_readpage(pages[index], em_cached, bio, 0, bio_flags,
>> +			      REQ_RAHEAD, prev_em_start);
>>  		put_page(pages[index]);
>>  	}
>>  }
>>
>> -static int __extent_read_full_page(struct page *page,
>> -				   get_extent_t *get_extent,
>> -				   struct bio **bio, int mirror_num,
>> -				   unsigned long *bio_flags,
>> +static int __extent_read_full_page(struct page *page, struct bio **bio,
>> +				   int mirror_num, unsigned long *bio_flags,
>>  				   unsigned int read_flags)
>>  {
>>  	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>> @@ -3383,20 +3378,18 @@ static int __extent_read_full_page(struct page *page,
>>
>>  	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>>
>> -	ret = __do_readpage(page, get_extent, NULL, bio, mirror_num,
>> -			    bio_flags, read_flags, NULL);
>> +	ret = __do_readpage(page, NULL, bio, mirror_num, bio_flags, read_flags,
>> +			    NULL);
>>  	return ret;
>>  }
>>
>> -int extent_read_full_page(struct page *page, get_extent_t *get_extent,
>> -			  int mirror_num)
>> +int extent_read_full_page(struct page *page, int mirror_num)
>>  {
>>  	struct bio *bio = NULL;
>>  	unsigned long bio_flags = 0;
>>  	int ret;
>>
>> -	ret = __extent_read_full_page(page, get_extent, &bio, mirror_num,
>> -				      &bio_flags, 0);
>> +	ret = __extent_read_full_page(page, &bio, mirror_num, &bio_flags, 0);
>>  	if (bio)
>>  		ret = submit_one_bio(bio, mirror_num, bio_flags);
>>  	return ret;
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index 41621731a4fe..57786feffdbf 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -193,8 +193,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
>>  int try_release_extent_mapping(struct page *page, gfp_t mask);
>>  int try_release_extent_buffer(struct page *page);
>>
>> -int extent_read_full_page(struct page *page, get_extent_t *get_extent,
>> -			  int mirror_num);
>> +int extent_read_full_page(struct page *page, int mirror_num);
>>  int extent_write_full_page(struct page *page, struct writeback_control *wbc);
>>  int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
>>  			      int mode);
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index a7b62b93246b..c8d1d935c8c7 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -8036,7 +8036,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>
>>  int btrfs_readpage(struct file *file, struct page *page)
>>  {
>> -	return extent_read_full_page(page, btrfs_get_extent, 0);
>> +	return extent_read_full_page(page, 0);
>>  }
>>
>>  static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
>>
> 
