Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF4C0C0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 21:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfI0TZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 15:25:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfI0TZ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 15:25:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88339AE35;
        Fri, 27 Sep 2019 19:25:24 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] btrfs: Speed up btrfs_file_llseek
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20190927102318.12830-1-nborisov@suse.com>
 <20190927102318.12830-2-nborisov@suse.com>
 <20190927171051.bfkt575rhg36v4hm@macbook-pro-91.dhcp.thefacebook.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <37b2382d-8c4f-fd27-374c-edf02180592f@suse.com>
Date:   Fri, 27 Sep 2019 22:25:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927171051.bfkt575rhg36v4hm@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.09.19 г. 20:10 ч., Josef Bacik wrote:
> On Fri, Sep 27, 2019 at 01:23:16PM +0300, Nikolay Borisov wrote:
>> Modifying the file position is done on a per-file basis. This renders
>> holding the inode lock for writing useless and makes the performance of
>> concurrent llseek's abysmal.
>>
>> Fix this by holding the inode for read. This provides protection against
>> concurrent truncates and find_desired_extent already includes proper
>> extent locking for the range which ensures proper locking against
>> concurrent writes. SEEK_CUR and SEEK_END can be done lockessly.
>> The former is synchronized by file::f_lock spinlock. SEEK_END is not
>> synchronized but atomic, but that's OK since there is not guarantee
>> that SEEK_END will always be at the end of the file in the face of
>> tail modifications.
>>
>> This change brings ~82% performance improvement when doing a lot of
>> parallel fseeks. The workload essentially does:
>>
>>                     for (d=0; d<num_seek_read; d++)
>>                       {
>>                         /* offset %= 16777216; */
>>                         fseek (f, 256 * d % 16777216, SEEK_SET);
>>                         fread (buffer, 64, 1, f);
>>                       }
>>
>> Without patch:
>>
>> num workprocesses = 16
>> num fseek/fread = 8000000
>> step = 256
>> fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>
>> real	0m41.412s
>> user	0m28.777s
>> sys	2m16.510s
>>
>> With patch:
>>
>> num workprocesses = 16
>> num fseek/fread = 8000000
>> step = 256
>> fork 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>
>> real	0m11.479s
>> user	0m27.629s
>> sys	0m21.040s
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  fs/btrfs/file.c | 26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 12688ae6e6f2..000b7bd89bf0 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -3347,13 +3347,14 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
>>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>  	struct extent_map *em = NULL;
>>  	struct extent_state *cached_state = NULL;
>> +	loff_t i_size = inode->i_size;
> 
> We don't actually need to do all this now that we're holding the inode_lock
> right?  Also I've gone through and looked at stuff and we're good with just a
> shared lock here, the only thing that adjusts i_size outsize of the extent lock
> is truncate, so we're safe.  Thanks,

Yeah, holding the shared inode lock means we can just do inode->i_size
but dunno if the multiple dereferences gets optimised. Though at this
point we are entering into microoptimisation territory. For the sake of
completeness I will check on monday what's the difference in assembly
and if there is none I'll revert the code back to accessing inode->i_size.

> 
> Josef
> 
