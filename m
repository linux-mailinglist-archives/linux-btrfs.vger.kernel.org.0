Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4C5971F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbiHQOxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbiHQOxs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F364F5AA16
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660748027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SqR01pq9tq6qm7V2NPRinZ2qHQbpsqAKxq332tGf5Q4=;
        b=D3f4L18CvLe41VBaHYbpzvv4vdUuTI6QGQsi8gZS3wIistfdYbnyyQK2APv490Bq8yH5yX
        0MaTzzhRBDeAP+ybCINiIwDx3q/MGvCJxbKWg9cHIThrPJRZs8FH1G/+FWyrlp1HrdgYoc
        /DI/fw1IseLunx4vprsXEnZHN697Y1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-DvkFF6R-PC-vl_GTPJvKdA-1; Wed, 17 Aug 2022 10:53:41 -0400
X-MC-Unique: DvkFF6R-PC-vl_GTPJvKdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A316185A7B2;
        Wed, 17 Aug 2022 14:53:41 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9D9C15BB3;
        Wed, 17 Aug 2022 14:53:34 +0000 (UTC)
Date:   Wed, 17 Aug 2022 22:53:29 +0800
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
Message-ID: <Yv0A6UhioH3rbi0E@T590>
References: <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 17, 2022 at 10:34:38AM -0400, Chris Murphy wrote:
> 
> 
> On Wed, Aug 17, 2022, at 8:06 AM, Ming Lei wrote:
> 
> > blk-mq debugfs log is usually helpful for io stall issue, care to post
> > the blk-mq debugfs log:
> >
> > (cd /sys/kernel/debug/block/$disk && find . -type f -exec grep -aH . {} \;)
> 
> This is only sda
> https://drive.google.com/file/d/1aAld-kXb3RUiv_ShAvD_AGAFDRS03Lr0/view?usp=sharing

From the log, there isn't any in-flight IO request.

So please confirm that it is collected after the IO stall is triggered.

If yes, the issue may not be related with BFQ, and should be related
with blk-cgroup code.


Thanks,
Ming

