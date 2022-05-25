Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC52753400F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbiEYPMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbiEYPM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 11:12:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6F4B0D2C
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 08:12:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B1B31F45B;
        Wed, 25 May 2022 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653491538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwrUj+53M18BhhLAChJpQo0jqt6hE19WpHr4BwHnv30=;
        b=k2pq7Jw7tAzZXeQkj5j8mzMOOpvcg7mSpngStWYo4uevNv9vl6NB0W9ov5D4vewg1jbyTq
        i/8hy6Im92hBsmCFl4QGgng1UD1fYTCfTsi1fT+G3YxWaguRszIHBpA7NGgXkCj88ur2rG
        4QwZOOJPX+3FyYu/5H/norM3mlJQMDE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2BA113ADF;
        Wed, 25 May 2022 15:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mDf4NlFHjmIrAgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 25 May 2022 15:12:17 +0000
Message-ID: <bc9b6b97-ee10-e5eb-f8ab-b533399dc772@suse.com>
Date:   Wed, 25 May 2022 18:12:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
 <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
 <20220522125337.GB24032@lst.de>
 <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
 <20220523062636.GA29750@lst.de>
 <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
 <20220524073216.GB26145@lst.de>
 <6047f29e-966d-1bf5-6052-915c1572d07a@gmx.com>
 <b78b6c09-eb70-68a7-7e69-e8481378b968@gmx.com>
 <20220524120847.GA18478@lst.de>
 <d966f776-79d7-1eec-efe0-bce1c771bc77@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <d966f776-79d7-1eec-efe0-bce1c771bc77@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.05.22 г. 16:13 ч., Qu Wenruo wrote:
> 
> 
> On 2022/5/24 20:08, Christoph Hellwig wrote:
>> On Tue, May 24, 2022 at 04:21:38PM +0800, Qu Wenruo wrote:
>>>> The things like resetting initial_mirror, making the naming "initial"
>>>> meaningless.
>>>> And the reset on the length part is also very quirky.
>>>
>>> In fact, if you didn't do the initial_mirror and length change (which is
>>> a big disaster of readability, to change iterator in a loop, at least to
>>> me),
>>
>> So what is the big problem there?  Do I need more extensive documentation
>> or as there anything in this concept that is just too confusing.
> 
> Modifying the iterator inside a loop is the biggest problem to me.

What iterator gets modified? The code defines a local one, which gets 
initialized by copying the state from the bbio. Then the loop works as 
usual, that's not confusing and is in line with how the other bio vec 
iterator macros work.

> 
> Yes, extra comments can help, but that doesn't help the readability.
> 
> And that's why most of guys here prefer for () loop if we can.
> 
> Thanks,
> Qu
>>
>>> and rely on the VFS re-read behavior to fall back to sector by
>>> secot read, I would call it better readability...
>>
>> I don't think relying on undocumented VFS behavior is a good idea.  It
>> will also not work for direct I/O if any single direct I/O bio has
>> ever more than a single page, which is something btrfs badly needs
>> if it wants to get any kind of performance out of direct I/O.
> 
