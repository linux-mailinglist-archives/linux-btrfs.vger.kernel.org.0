Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE849CC9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfHZJeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 05:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbfHZJeP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 05:34:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8340ABC4
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:34:12 +0000 (UTC)
Subject: Re: [RFC PATCH 10/17] btrfs-progs: add checksum type to checksumming
 functions
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <cover.1564046812.git.jthumshirn@suse.de>
 <71245b857a7214b284a57989fe677101c2ea13e5.1564046972.git.jthumshirn@suse.de>
 <f7db0360-adcc-05c7-f99a-8302ac99a06d@suse.com>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c159de9e-0c69-eae7-62dd-7f9efe315f21@suse.de>
Date:   Mon, 26 Aug 2019 11:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f7db0360-adcc-05c7-f99a-8302ac99a06d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/08/2019 12:21, Nikolay Borisov wrote:
> 
> 
> On 25.07.19 г. 12:33 ч., Johannes Thumshirn wrote:
>> Add the checksum type to csum_tree_block_size(), __csum_tree_block_size()
>> and verify_tree_block_csum_silent().
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>> ---
>>  btrfs-corrupt-block.c       |  3 ++-
>>  cmds/rescue-chunk-recover.c |  3 ++-
>>  convert/common.c            |  3 ++-
>>  convert/main.c              |  3 ++-
>>  disk-io.c                   | 21 ++++++++++++---------
>>  disk-io.h                   |  5 +++--
>>  mkfs/common.c               | 21 ++++++++++++++-------
>>  7 files changed, 37 insertions(+), 22 deletions(-)
>>
>> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
>> index bbef0c02e5d1..1dde9594bdcc 100644
>> --- a/btrfs-corrupt-block.c
>> +++ b/btrfs-corrupt-block.c
>> @@ -158,7 +158,8 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
>>  	if (!trans) {
>>  		u16 csum_size =
>>  			btrfs_super_csum_size(fs_info->super_copy);
>> -		csum_tree_block_size(eb, csum_size, 0);
>> +		u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
>> +		csum_tree_block_size(eb, csum_size, 0, csum_type);
> 
> I'm not a big fan of open-coding this csum manipulation. Generally if we
> ensure that we always pass a well-formed eb to csum_tree_block_size and
> by well-formed I mean one which has its ->fs_info, which in turn is
> well-formed then we can encapsulate this interrogation of csum type into
> csum_tree_block.
> 
>>  		write_extent_to_disk(eb);
>>  	}
>>  }
>> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
>> index 308731ea5ea6..1a368310d895 100644
>> --- a/cmds/rescue-chunk-recover.c
>> +++ b/cmds/rescue-chunk-recover.c
>> @@ -768,7 +768,8 @@ static int scan_one_device(void *dev_scan_struct)
>>  			continue;
>>  		}
>>  
>> -		if (verify_tree_block_csum_silent(buf, rc->csum_size)) {
>> +		if (verify_tree_block_csum_silent(buf, rc->csum_size,
>> +						  rc->csum_type)) {
> 
> But this is not a well-formed eb :(
> 
>>  			bytenr += rc->sectorsize;
>>  			continue;
>>  		}
>> diff --git a/convert/common.c b/convert/common.c
>> index dea5f5b20d50..f8bbb23cba89 100644
>> --- a/convert/common.c
>> +++ b/convert/common.c
>> @@ -223,7 +223,8 @@ static inline int write_temp_extent_buffer(int fd, struct extent_buffer *buf,
>>  {
>>  	int ret;
>>  
>> -	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
>> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
>> +			     cfg->csum_type);
> 
> Neither is this ...
>>  
>>  	/* Temporary extent buffer is always mapped 1:1 on disk */
>>  	ret = pwrite(fd, buf->data, buf->len, bytenr);
>> diff --git a/convert/main.c b/convert/main.c
>> index 9711874bd137..5e6b12431f59 100644
>> --- a/convert/main.c
>> +++ b/convert/main.c
>> @@ -1058,7 +1058,8 @@ static int migrate_super_block(int fd, u64 old_bytenr)
>>  	BUG_ON(btrfs_super_bytenr(super) != old_bytenr);
>>  	btrfs_set_super_bytenr(super, BTRFS_SUPER_INFO_OFFSET);
>>  
>> -	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
>> +	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0,
>> +			     btrfs_super_csum_type(super));
>>  	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
>>  		BTRFS_SUPER_INFO_OFFSET);
>>  	if (ret != BTRFS_SUPER_INFO_SIZE)
>> diff --git a/disk-io.c b/disk-io.c
>> index 01314504a50a..a4995a628210 100644
>> --- a/disk-io.c
>> +++ b/disk-io.c
>> @@ -149,7 +149,7 @@ void btrfs_csum_final(u32 crc, u8 *result)
>>  }
>>  
>>  static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
>> -				  int verify, int silent)
>> +				  int verify, int silent, u16 csum_type)
>>  {
>>  	u8 result[BTRFS_CSUM_SIZE];
>>  	u32 len;
>> @@ -174,24 +174,27 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
>>  	return 0;
>>  }
>>  
>> -int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size, int verify)
>> +int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size, int verify,
>> +			 u16 csum_type)
>>  {
>> -	return __csum_tree_block_size(buf, csum_size, verify, 0);
>> +	return __csum_tree_block_size(buf, csum_size, verify, 0, csum_type);
>>  }
>>  
>> -int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size)
>> +int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
>> +				  u16 csum_type)
>>  {
>> -	return __csum_tree_block_size(buf, csum_size, 1, 1);
>> +	return __csum_tree_block_size(buf, csum_size, 1, 1, csum_type);
>>  }
> 
> Now that those function take the csum_type it renders passing the
> csum_size redundant. Refactor them so that only csum_type is passed and
> make __csum_tree_block_size (perhahps it should be renamed now?) get the
> size based on the type.
> 
> I think the csum interface can be simplified further:
> 
> 1. Leave csum_tree_block for callers that pass well-formed eb's (as is
> currently)
> 
> 2. Rename __csum_tree_block_size to __csum_tree_block which takes just
> the buffer, boolean flag verify and u16 (or better enum btrfs_csum_type)
> csum_type arguments and the nitty-gritty details
> 
> 3. Remove csum_tree_block_size and directly call the new
> __csum_tree_block. The former just wraps the 'silent' parameter...
> 
> In the end we will be left with just 2 functions:
> 
> (__)csum_tree_blocks .
> 
> Additionally verify_tree_block_csum_silent has really one caller because
> in csum_tree_block it's enough to call __csum_tree_block_size just once
> and pass verify and fs_info->suppress_check_block_errors directly to it.
> Then you can also directly call __csum_tree_block in scan_one_device in
> rescue-chunk-recover.c . And this would put some sanity into the current
> csum interfaces in progs.
> 
> I guess this could land as a follow-up to your patches...
> 

I'd really like to have this rework as a follow up as it introduces a
non-negligible regression potential and can "easily" be done after this
series has landed.


-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
(HRB 247165, AG München)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
