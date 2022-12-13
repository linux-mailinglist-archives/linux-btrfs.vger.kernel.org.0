Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE364B608
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 14:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiLMNYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 08:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLMNYk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 08:24:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006B1902B
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 05:24:37 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B094167373; Tue, 13 Dec 2022 14:24:33 +0100 (CET)
Date:   Tue, 13 Dec 2022 14:24:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/8] btrfs: cleanup scrub_rbio
Message-ID: <20221213132433.GA21430@lst.de>
References: <20221213084123.309790-1-hch@lst.de> <20221213084123.309790-6-hch@lst.de> <083cd81a-644e-a054-80c1-1b3b902ff6e9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083cd81a-644e-a054-80c1-1b3b902ff6e9@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 04:53:33PM +0800, Qu Wenruo wrote:
>>     	ret = scrub_assemble_read_bios(rbio, &bio_list);
>>   	if (ret < 0)
>> -		goto cleanup;
>> +		return ret;
>>     	submit_read_bios(rbio, &bio_list);
>>   	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
>>     	/* We may have some failures, recover the failed sectors first. */
>>   	ret = recover_scrub_rbio(rbio);
>> -	if (ret < 0)
>> -		goto cleanup;
>> +	if (ret < 0) {
>> +		while ((bio = bio_list_pop(&bio_list)))
>> +			bio_put(bio);
>> +		return ret;
>> +	}
>
> Do we still need the cleanup? IIRC after submit_read_bios() (or be more 
> safe, after wait_event()), we should no longer touch @bio_list anymore.

Oh, true.  submit_read_bios does the list_pop, so we don't need
this here, and in recover_rbio either.  And looking at it a little more
I think the are could use even more cleanup by:

 - moving the wait_event for stripes_pending into submit_read_bios.
 - moving the submit_read_bios *_assemble_read_bios and stop passing
   the bio_list entirely, which removes all the confusion about
   who cleans it up.

What do you think of this series (still needs testing before I can
post it):

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-raid56-cleanups

