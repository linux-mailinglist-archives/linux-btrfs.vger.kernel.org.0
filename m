Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8294597E17
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 07:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbiHRFZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 01:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiHRFZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 01:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856F4D27A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 22:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660800311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rxhzxA1d8E+PIuuMRI/DOACXqYZZN6j/zwh1o5qvZc=;
        b=OAnAIdtZAl8n46VGWVCy47syo63wY14SFG3cssXovyJE1qC0tgf1n8ZW1sddQLcdGPGcqK
        80cjgieZvfxDIC3EOKS7GxpHIGL7PiSVK8o/mrp3HT5Q1crf5VrYB6WD2k8Dn+IztkTSsT
        68Q3s7UB2uO3qiy+JnnwOqyg+y/8LaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-sB2Y5UMzPia25Rg2AitPzg-1; Thu, 18 Aug 2022 01:25:07 -0400
X-MC-Unique: sB2Y5UMzPia25Rg2AitPzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D02D802D2C;
        Thu, 18 Aug 2022 05:25:07 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C1559457F;
        Thu, 18 Aug 2022 05:24:55 +0000 (UTC)
Date:   Thu, 18 Aug 2022 13:24:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Message-ID: <Yv3NIQlDL0T3lstU@T590>
References: <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
> 
> 
> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
> > On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
> >> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
> >>
> >>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
> 
> Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.
> 
> https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing
> 

Also please test the following one too:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ee62b95f3e5..d01c64be08e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && needs_resource)
+		else if (needs_restart && (needs_resource ||
+					blk_mq_is_shared_tags(hctx->flags)))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
 		blk_mq_update_dispatch_busy(hctx, true);


Thanks,
Ming

