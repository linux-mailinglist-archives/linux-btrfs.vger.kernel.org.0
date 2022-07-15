Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A6F575D7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiGOIaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiGOIaQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 04:30:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6D33A49B
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 01:30:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53D44340CA;
        Fri, 15 Jul 2022 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657873812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6uukFlaIuyV+e7A7JaYSCOc+NHLtAYkXMoYmaOptHI=;
        b=sG5OQRTDXlN8xAaQOF6nJVdbnwRh2LECGjELrAhyfVz/tOihHcs1o/DCm6aJagKT9CFUPe
        GKXAqokrZVwxlXbBHo6HHPmL0MHdhg9RdB5cReh5CrmhJOFkUeoPhfw6p4SQZDc2dmBcd3
        5Ky6e1k4xSzqMtsENVl2bUcDNe1oaaI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 075DD13AC3;
        Fri, 15 Jul 2022 08:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CEzkOpMl0WLmJQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Jul 2022 08:30:11 +0000
Message-ID: <c92d13d8-67cc-fe22-54e8-b53686d08ec6@suse.com>
Date:   Fri, 15 Jul 2022 11:30:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/11] btrfs: make the btrfs_io_context allocation in
 __btrfs_map_block optional
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-11-hch@lst.de>
 <PH0PR04MB741647058825EF24A1E89CAA9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <PH0PR04MB741647058825EF24A1E89CAA9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.07.22 г. 12:58 ч., Johannes Thumshirn wrote:
> On 13.07.22 08:14, Christoph Hellwig wrote:
>> +	/*
>> +	 * If this I/O maps to a single device, try to return the device and
>> +	 * physical block information on the stack instead of allocating an
>> +	 * I/O context structure.
>> +	 */
>> +	if (smap && num_alloc_stripes == 1 &&
>> +	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
>> +	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
>> +	     !dev_replace->tgtdev)) {
>> +		if (unlikely(patch_the_first_stripe_for_dev_replace)) {
>> +			smap->dev = dev_replace->tgtdev;
>> +			smap->physical = physical_to_patch_in_first_stripe;
>> +			*mirror_num_p = map->num_stripes + 1;
>> +		} else {
>> +			set_stripe(smap, map, stripe_index, stripe_offset,
>> +				   stripe_nr);
>> +			*mirror_num_p = mirror_num;
>> +		}
>> +		*bioc_ret = NULL;
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
> 
> 
> Could be my changes on top, but in order to get RAID0 with a raid-stripe-tree
> working I needed the following change:
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a7886e421153..344d2cf941a7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6506,7 +6506,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>           * physical block information on the stack instead of allocating an
>           * I/O context structure.
>           */
> -       if (smap && num_alloc_stripes == 1 &&
> +       if (smap && num_alloc_stripes == 1 && !(map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK) &&

nit: BLOCK_GROUP_STRIPE_MASK already contains BLOCK_GROUP_RAID56_MASK so 
BTRFS_BLOCK_GROUP_RAID56_MASK can be replaced. But I agree with hch that 
this change should come with your series.

>              !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
>              (!need_full_stripe(op) || !dev_replace_is_ongoing ||
>               !dev_replace->tgtdev)) {
> 
