Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEFE136FBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 15:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgAJOqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 09:46:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:58620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgAJOqY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 09:46:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0FB32B11E
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 14:46:22 +0000 (UTC)
Subject: Re: [PATCH v2] btrfs: Add self-tests for btrfs_rmap_block
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191126160439.GI2734@twin.jikos.cz>
 <20191210180045.2047-1-nborisov@suse.com>
 <20200102154032.GJ3929@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d24de3e2-719f-e656-7d75-e5b258eb449b@suse.com>
Date:   Fri, 10 Jan 2020 16:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102154032.GJ3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.01.20 г. 17:40 ч., David Sterba wrote:
> On Tue, Dec 10, 2019 at 08:00:45PM +0200, Nikolay Borisov wrote:
>> This is enough to exercise out of boundary address exclusion as well as
>> address matching.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>> V2:
>>  * Adjusted comments about some members of struct rmap_test_vector
>>  * Fixed inline comments
>>  * Correctly handle error when initialising dummy device
>>  * Other minor cosmetic changes around comments/braces for single statement 'if'
>>  and structure initialization
> 
> I still found issues unfixed from v1 and some that I did not notice
> before
> 
>>  fs/btrfs/tests/extent-map-tests.c | 146 +++++++++++++++++++++++++++++-
>>  1 file changed, 145 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
>> index 4a7f796c9900..4878904434af 100644
>> --- a/fs/btrfs/tests/extent-map-tests.c
>> +++ b/fs/btrfs/tests/extent-map-tests.c
>> @@ -6,6 +6,10 @@
>>  #include <linux/types.h>
>>  #include "btrfs-tests.h"
>>  #include "../ctree.h"
>> +#include "../volumes.h"
>> +#include "../disk-io.h"
>> +#include "../block-group.h"
>> +
> 
> Extra newline
> 
>>
>>  static void free_extent_map_tree(struct extent_map_tree *em_tree)
>>  {
>> @@ -437,11 +441,144 @@ static int test_case_4(struct btrfs_fs_info *fs_info,
>>  	return ret;
>>  }
>>
>> +struct rmap_test_vector {
>> +	u64 raid_type;
>> +	u64 physical_start;
>> +	u64 data_stripe_size;
>> +	u64 num_data_stripes;
>> +	u64 num_stripes;
>> +	/* Assume we won't have more than 5 physical stripes */
>> +	u64 data_stripe_phys_start[5];
>> +	int expected_mapped_addr;
> 
> This should be bool

Actually the idea here is for expected_mapped_addr to contains the
number of addresses we are expected to map. Currently tests only expect
0 or 1 but if tests are expanded in the future  this might be 2 or 3.

THe body of the test does:

 if (out_ndaddrs != test->expected_mapped_addr) {
                  for (i = 0; i < out_ndaddrs; i++)

                          test_msg("Mapped %llu", logical[i]);


<snip>
>>  int btrfs_test_extent_map(void)
>>  {
>>  	struct btrfs_fs_info *fs_info = NULL;
>>  	struct extent_map_tree *em_tree;
>> -	int ret = 0;
>> +	int ret = 0, i;
>> +	struct rmap_test_vector rmap_tests[] = {
>> +		{
>> +			/*
>> +			 * Tests a chunk with 2 data stripes one of which
>> +			 * interesects the physical address of the super block
>> +			 * is correctly recognised.
>> +			 */
>> +			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
>> +			.physical_start = SZ_64M - SZ_4M,
>> +			.data_stripe_size = SZ_256M,
>> +			.num_data_stripes = 2,
>> +			.num_stripes = 2,
>> +			.data_stripe_phys_start = {SZ_64M - SZ_4M, SZ_64M - SZ_4M + SZ_256M},
> 
> Formatting


What do you mean?

<snip>
