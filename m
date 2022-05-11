Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A0523D64
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 21:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346815AbiEKT2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346839AbiEKT2J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 15:28:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198B54018
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 12:28:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0BC6221CC3;
        Wed, 11 May 2022 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652297283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBjPhlksTICRYoGuaSH/pqAAtNjIUqc+6ShpkFW3E5E=;
        b=R0XU9RQE8jdBRur0JOKBsPKt+2aPkTwX1JoOurOqNAHLC2sI3M7LF9SSwGmQXSRD9Swqts
        NcETJwalBcxC8baW8eBf3wnZkjxrRquF/irqDnIMaO716+fdjwspGYqckfGMiBRIw2DauV
        fMlugH3pXDBG6YKJ4Y5p1ZOupM4NgP8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3336139F9;
        Wed, 11 May 2022 19:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PF4NKUIOfGKCDQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 11 May 2022 19:28:02 +0000
Message-ID: <63d980ff-29cf-19e9-e3ea-a5587fabc534@suse.com>
Date:   Wed, 11 May 2022 22:28:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 06/10] btrfs: don't use btrfs_bio_wq_end_io for compressed
 writes
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-7-hch@lst.de>
 <f8d90519-9911-fde0-9b18-3e4f339590c3@suse.com>
In-Reply-To: <f8d90519-9911-fde0-9b18-3e4f339590c3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.05.22 г. 22:20 ч., Nikolay Borisov wrote:
> 
> 
> On 4.05.22 г. 15:25 ч., Christoph Hellwig wrote:
>> Compressed write bio completion is the only user of btrfs_bio_wq_end_io
>> for writes, and the use of btrfs_bio_wq_end_io is a little suboptimal
>> here as we only real need user context for the final completion of a
>> compressed_bio structure, and not every single bio completion.
>>
>> Add a work_struct to struct compressed_bio instead and use that to call
>> finish_compressed_bio_write.  This allows to remove all handling of
>> write bios in the btrfs_bio_wq_end_io infrastructure.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>

<snip>


>> @@ -771,6 +762,9 @@ blk_status_t btrfs_bio_wq_end_io(struct 
>> btrfs_fs_info *info, struct bio *bio,
>>   {
>>       struct btrfs_end_io_wq *end_io_wq;
>> +    if (WARN_ON_ONCE(btrfs_op(bio) != BTRFS_MAP_WRITE))
>> +        return BLK_STS_IOERR;
> 
> This is broken w.r.t to btrfs_submit_metadata_bio since in
> that function the code is:
> 
>   if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
>                        /*
>                         * called for a read, do the setup so that 
> checksum validation
>                         * can happen in the async kernel threads
>                         */
>                      ret = btrfs_bio_wq_end_io(fs_info, bio,
>                                                  BTRFS_WQ_ENDIO_METADATA);
>                        if (!ret)
>                                ret = btrfs_map_bio(fs_info, bio, 
> mirror_num);
> 
> 
> 
> So metadata reads  will end up in function which disallows reads..
> This results in failure to mount when reading various metadata.
> 
> I guess the correct fix is to include the following hunk from patch 8 in 
> this series:
> 
> @@ -916,14 +839,7 @@ void btrfs_submit_metadata_bio(struct inode *inode, 
> struct bio *bio, int mirror_
>       bio->bi_opf |= REQ_META;
> 
>       if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
> -        /*
> -         * called for a read, do the setup so that checksum validation
> -         * can happen in the async kernel threads
> -         */
> -        ret = btrfs_bio_wq_end_io(fs_info, bio,
> -                      BTRFS_WQ_ENDIO_METADATA);
> -        if (!ret)
> -            ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +        ret = btrfs_map_bio(fs_info, bio, mirror_num);
> 
> 
> 
> 
> 

Even if I apply this hunk to patch 6 I get more io failures, this time 
from btrfs_submit_data_read_bio, again there is relevant hunk in patch 8:

-	ret = btrfs_bio_wq_end_io(fs_info, bio,
-			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
-			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto out;
-

And then there is another due to DIO in btrfs_submit_dio_bio's call of 
btrfs_bio_wq_end_io if we want to read.


Please fix those to ensure the series is actually bisectable.


<Snip>
