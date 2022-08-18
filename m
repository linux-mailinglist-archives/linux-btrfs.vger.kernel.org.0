Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6D597DF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 07:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbiHRFPd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 01:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243495AbiHRFPc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 01:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA956AB4DB
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660799730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTzKvXSmWh1TMhjc0Co13nZ/hVTaoOofQvw86K3S3UM=;
        b=M98Zw+iM8KN0Noml4CHycs3yY2hNfc9LX6xIuK1tdzuLpxyJuWvyPvnFhAZ4ImsNjGKkNz
        zmAb7h4aQnhnxaH/EppfURX+LKZm9tkGPmXnWjGm3S6hP0PZGdYEjncMslbcq9oktf11ld
        exLKFuc2ktg9Mt7d5CEbQH6zDR7JTws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277--OvbFB14PB-XdV3zUfhK1A-1; Thu, 18 Aug 2022 01:15:29 -0400
X-MC-Unique: -OvbFB14PB-XdV3zUfhK1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B86B13806705;
        Thu, 18 Aug 2022 05:15:28 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCAFD2026D4C;
        Thu, 18 Aug 2022 05:15:17 +0000 (UTC)
Date:   Thu, 18 Aug 2022 13:15:12 +0800
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
Message-ID: <Yv3K4G/Sv2KDEqif@T590>
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
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Please test the following patch and see if it makes a difference:

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a4f7c101b53b..8e8d77e79dd6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -44,7 +44,10 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 	 */
 	smp_mb();
 
-	blk_mq_run_hw_queue(hctx, true);
+	if (blk_mq_is_shared_tags(hctx->flags))
+		blk_mq_run_hw_queues(hctx->queue, true);
+	else
+		blk_mq_run_hw_queue(hctx, true);
 }
 
 static int sched_rq_cmp(void *priv, const struct list_head *a,


Thanks,
Ming

