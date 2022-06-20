Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3FB55146F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiFTJew (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 05:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiFTJev (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 05:34:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9463312AA8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 02:34:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53CF921B5E;
        Mon, 20 Jun 2022 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655717689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcXsyAylfmEFWnUUxl1CqknsOnJjTWQtMDiIT3MXhmE=;
        b=a9ARW/79AhBsOw/F4pJSeB1kdjFwreVHgSY4/cgmzRWQS5O249ABeEZUCowrICOQsKt9uN
        3lGYcG4GcdH5YFQPYKGJaSmgk0tAoN5hw6dttQ5sBTlgvf7g0pYQM8EiZfRpgwKqmmXg9c
        goOcq4HhAatnt+1xFPH1r+ZIQNJJbow=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 077CF134CA;
        Mon, 20 Jun 2022 09:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8PVwOjg/sGLmRwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 20 Jun 2022 09:34:48 +0000
Message-ID: <8b478441-ab11-575b-5dba-1136a26cfc35@suse.com>
Date:   Mon, 20 Jun 2022 12:34:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] btrfs: remove bioc->stripes_pending
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-11-hch@lst.de>
 <bc18e270-371c-98ee-28c2-fd4305206d7a@suse.com>
 <20220620085340.GA13344@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220620085340.GA13344@lst.de>
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



On 20.06.22 г. 11:53 ч., Christoph Hellwig wrote:
> On Mon, Jun 20, 2022 at 11:18:03AM +0300, Nikolay Borisov wrote:
>> What if the the currently completed stripe bio is the last - then bio_endio
>> would be called for orig_bio, which will executed bi_end_io() in softirq
>> context, but for reads we want to execute this in process context (as per
>> the below code) ?
> 
>> The old code guaranteed that btrfs_end_bioc() is executed when the last
>> stripe bio was completed. With this new scheme, say we have 3 bios - 2
>> cloned, 1 being the orig, what guarantees that the orig_bio won't be
>> finished before the remaining 2 (or 1) cloned/stripe bios thus calling
>> btrfs_end_bio() on orig bio with __bi_remaining potentially being 2 or 1
>> and finally calling orig_bio->bi_end_io() again with __bi_remaining being
>> elevated?
> 
> This is what the bio_inc_remaining after the bio_alloc_clone takes care
> of.  With that the remaining count in the original btrfs_bio is
> incremented, which ensures that ->end_io for the originl bio is only
> called when all other bios and the original one have completed.
> 
> Take a look at bio_endio and bio_remaining_done for the glory details.

I get what the main idea of bio_remaining_done is. HOwever, say we have 
a write to a RAID1 fs. So we have to do 2 writes - 1 of the orig bio, 1 
of a stripe bio so we make 1 clone of the orig bio, call 
bio_inc_remaining and orig_bio->__bi_remaining is 2. So the 2 bios get 
submitted.

If the stripe bio is completed first 'if (bio != orig_bio) {' check in 
btrfs_end_bio ensures that the function is really a noop. Subsequently 
when orig_bio is completed it proceeds to executed:

orig_bio->bi_end_io(orig_bio);


Consider the same scenario, but this time if orig_bio is completed first 
then we proceed directly calling orig_bio->bi_end_io(orig_bio); 
bypassing bio_endio and the __bi_remaining checks etc. So shouldn't this
orig_bio->bi_end_io(orig_bio);  be converted to bio_endio call ?

> 
>>>    	if (clone) {
>>> -		bio = bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS, &fs_bio_set);
>>> +		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
>>> +		bio_inc_remaining(orig_bio);
>>
>> When cloning why aren't you passing dev->bdev but instead set it after the
>> checks via bio_set_dev ? Is it because of the
>>
>> if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION))
>>
>> check inside bio_endio in case bio_io_error is called in submit_stripe_bio?
> 
> It is because we don't know if we have a valid bdev until after
> the checks a few line down that call bio_io_error.  We need those
> checks to be done later now so that all error handling goes through
> the bio end_io handler.
