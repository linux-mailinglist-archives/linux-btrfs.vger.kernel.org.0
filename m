Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286275A9184
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 10:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiIAIEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiIAIDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 04:03:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B80C121424;
        Thu,  1 Sep 2022 01:03:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21DFB1FABC;
        Thu,  1 Sep 2022 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662019418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6ag4bKWdZSgH1KJS0M8aqtbFgZvMF+Dd3fE1Fhurzc=;
        b=GrlE3kXJK5XaNztXjiol8xhRWnO/q2oNokQBJ5Dki9U07tlkHKvk6FKpCUQ+rm57Yh1mcO
        rPfrYHLsQj60xRPJjvy1SZiTjcLR5nPYxrM9PiRyAJdjnewfd4iPoHJzqsFJtSLV4ohhaF
        E/bS2ph8ASkTszpxnmOECp3QcDjWhP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662019418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6ag4bKWdZSgH1KJS0M8aqtbFgZvMF+Dd3fE1Fhurzc=;
        b=ITWjpwicbodxcb7+REkcNfh/SvExwUF38cvSBjNhhFZaUL8HxU9rqcO9HIwRhlclMsEebo
        pfb1borYwHbg7rCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C4EE13A89;
        Thu,  1 Sep 2022 08:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8PP4AlpnEGPJHwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Sep 2022 08:03:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D6D7CA067C; Thu,  1 Sep 2022 10:03:36 +0200 (CEST)
Date:   Thu, 1 Sep 2022 10:03:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Chris Murphy <lists@colorremedies.com>,
        Jan Kara <jack@suse.cz>, Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Message-ID: <20220901080336.glpv4i3hyae2zkpk@quack3>
References: <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590>
 <0f731b0a-fbd5-4e7b-a3df-0ed63360c1e0@www.fastmail.com>
 <YwCGlyDMhWubqKoL@T590>
 <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 01-09-22 15:02:03, Yu Kuai wrote:
> Hi, Chris
> 
> 在 2022/08/20 15:00, Ming Lei 写道:
> > On Fri, Aug 19, 2022 at 03:20:25PM -0400, Chris Murphy wrote:
> > > 
> > > 
> > > On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
> > > > On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
> > > > > 
> > > > > 
> > > > > On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
> > > > > > On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
> > > > > > > On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
> > > > > > > 
> > > > > > > > OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
> > > > > 
> > > > > Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.
> > > > > 
> > > > > https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing
> > > > > 
> > > > 
> > > > Also please test the following one too:
> > > > 
> > > > 
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index 5ee62b95f3e5..d01c64be08e2 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx
> > > > *hctx, struct list_head *list,
> > > >   		if (!needs_restart ||
> > > >   		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
> > > >   			blk_mq_run_hw_queue(hctx, true);
> > > > -		else if (needs_restart && needs_resource)
> > > > +		else if (needs_restart && (needs_resource ||
> > > > +					blk_mq_is_shared_tags(hctx->flags)))
> > > >   			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> > > > 
> > > >   		blk_mq_update_dispatch_busy(hctx, true);
> > > > 
> > > 
> > > 
> > > With just this patch on top of 5.17.0, it still hangs. I've captured block debugfs log:
> > > https://drive.google.com/file/d/1ic4YHxoL9RrCdy_5FNdGfh_q_J3d_Ft0/view?usp=sharing
> > 
> > The log is similar with before, and the only difference is RESTART not
> > set.
> > 
> > Also follows another patch merged to v5.18 and it fixes io stall too, feel free to test it:
> > 
> > 8f5fea65b06d blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues
> 
> Have you tried this patch?
> 
> We meet a similar problem in our test, and I'm pretty sure about the
> situation at the scene,
> 
> Our test environment：nvme with bfq ioscheduler,
> 
> How io is stalled:
> 
> 1. hctx1 dispatch rq from bfq in service queue, bfqq becomes empty,
> dispatch somehow fails and rq is inserted to hctx1->dispatch, new run
> work is queued.
> 
> 2. other hctx tries to dispatch rq, however, in service bfqq is
> empty, bfq_dispatch_request return NULL, thus
> blk_mq_delay_run_hw_queues is called.
> 
> 3. for the problem described in above patch，run work from "hctx1"
> can be stalled.
> 
> Above patch should fix this io stall, however, it seems to me bfq do
> have some problems that in service bfqq doesn't expire under following
> situation:
> 
> 1. dispatched rqs don't complete
> 2. no new rq is issued to bfq

And I guess:
3. there are requests queued in other bfqqs
?

Otherwise I don't see a point in expiring current bfqq because there's
nothing bfq could do anyway. But under normal circumstances the request
completion should not take so long so I don't think it would be really
worth it to implement some special mechanism for this in bfq.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
