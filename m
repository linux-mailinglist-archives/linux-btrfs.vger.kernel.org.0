Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4E25535C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352539AbiFUPT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352464AbiFUPTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 11:19:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2B2BFC
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 08:19:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BEFF221C8E;
        Tue, 21 Jun 2022 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655824760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hX3i7FrhFvH0M9Nhb6gSygekiqqgJafKQsv+ugTEvIE=;
        b=O15g1D/o+DuMEU1TewnrftNMS4ifLm88BwJXKspOx1NQjCheTA0phk0wgV6WlZEpSgbYxq
        GUvx37b7z32ecTdwSf9G35350F6qWUEyufPXvJB1+x030nHzWMROjRHiezXTOMdv82vyQ2
        8a8icv+SuI/cQ8NRzDb4lGdTsTw7Muk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78E1813A88;
        Tue, 21 Jun 2022 15:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ieH/GnjhsWK6agAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 21 Jun 2022 15:19:20 +0000
Message-ID: <b633dedf-b322-2d8c-adfb-8ab88af5652e@suse.com>
Date:   Tue, 21 Jun 2022 18:19:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220619082821.2151052-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220619082821.2151052-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.06.22 г. 11:28 ч., Christoph Hellwig wrote:
> When there is more than a single level of redundancy there can also be
> mutiple bad mirrors, and the current read repair code only repairs the
> last bad one.
> 
> Restructure btrfs_repair_one_sector so that it records the original bad
> bad mirror, and the number of copies, and then repair all bad copies
> until we reach the original bad copy in clean_io_failure.  Note that
> this also means the read repair reads will always start from the next
> bad mirror and not mirror 0.
> 
> This fixes btrfs/265 in xfstests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 127 +++++++++++++++++++++----------------------
>   fs/btrfs/extent_io.h |   3 +-
>   2 files changed, 63 insertions(+), 67 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 854999c2e139b..9775ac5d28a9e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2432,6 +2432,20 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
>   	return ret;
>   }
>   
> +static int next_mirror(struct io_failure_record *failrec, int cur_mirror)
> +{
> +	if (cur_mirror == failrec->num_copies)
> +		return cur_mirror + 1 - failrec->num_copies;
> +	return cur_mirror + 1;
> +}
> +
> +static int prev_mirror(struct io_failure_record *failrec, int cur_mirror)
> +{
> +	if (cur_mirror == 1)
> +		return failrec->num_copies;
> +	return cur_mirror - 1;
> +}
> +
>   /*
>    * each time an IO finishes, we do a fast check in the IO failure tree
>    * to see if we need to process or clean up an io_failure_record
> @@ -2444,7 +2458,7 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
>   	u64 private;
>   	struct io_failure_record *failrec;
>   	struct extent_state *state;
> -	int num_copies;
> +	int mirror;
>   	int ret;
>   
>   	private = 0;
> @@ -2468,20 +2482,19 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
>   					    EXTENT_LOCKED);
>   	spin_unlock(&io_tree->lock);
>   
> -	if (state && state->start <= failrec->start &&
> -	    state->end >= failrec->start + failrec->len - 1) {
> -		num_copies = btrfs_num_copies(fs_info, failrec->logical,
> -					      failrec->len);
> -		if (num_copies > 1)  {
> -			repair_io_failure(fs_info, ino, start, failrec->len,
> -					  failrec->logical, page, pg_offset,
> -					  failrec->failed_mirror);
> -		}
> -	}
> +	if (!state || state->start > failrec->start ||
> +	    state->end < failrec->start + failrec->len - 1)
> +		goto out;
> +
> +	mirror = failrec->this_mirror;
> +	do {
> +		mirror = prev_mirror(failrec, mirror);
> +		repair_io_failure(fs_info, ino, start, failrec->len,
> +				  failrec->logical, page, pg_offset, mirror);
> +	} while (mirror != failrec->orig_mirror);

But does this work as intended? Say we have a raid1c4 and we read from 
mirror 3 which is bad, in this case failrec->orig_mirror = 3 and 
->this_mirror = 4. The read from mirror 4 returns good data and 
clean_io_failure is called with mirror= 3 in which case only mirror 3 is 
repaired (assume 1/2 were also bad we don't know it yet, because the 
original bio request didn't submit to them based on the PID policy).

<snip>

> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index c0f1fb63eeae7..5bd23bb239dae 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -262,8 +262,9 @@ struct io_failure_record {
>   	u64 len;
>   	u64 logical;
>   	enum btrfs_compression_type compress_type;
> +	int orig_mirror;
nit: how about we name this failed_mirror
>   	int this_mirror;
nit: this name is also somewhat uninformative and one has to go and see 
how it's used in order to figure out the usage.
> -	int failed_mirror;
> +	int num_copies;
>   };
>   
>   int btrfs_repair_one_sector(struct inode *inode,
