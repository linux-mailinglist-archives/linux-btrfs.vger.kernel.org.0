Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F490597AD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiHRBDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiHRBDh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 21:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1B2AE00
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 18:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660784612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C60ajPdlC/CsFP22IBpGKTjlxuh488qoa5A4DbUUh+Y=;
        b=TIFTsTlz1ofYz8MZ10G0BNg7xApfTdJyve7izl1WtolFbyJgitLNg5fA0we9ekrduI5ccP
        QGUFkQubAkYW3XtLhW1s7+cEFF9r22gbqlLSoUW+/mPrBlsUJ8qXzq8RLH0YLtUVP5Z0Ol
        EAumzGezIgqC+fi3gxKN79wVgGbFEas=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-Aug8zyljPeaUXo98D8mcwQ-1; Wed, 17 Aug 2022 21:03:28 -0400
X-MC-Unique: Aug8zyljPeaUXo98D8mcwQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D1C23C01D9F;
        Thu, 18 Aug 2022 01:03:28 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 705F6492C3B;
        Thu, 18 Aug 2022 01:03:20 +0000 (UTC)
Date:   Thu, 18 Aug 2022 09:03:15 +0800
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
Message-ID: <Yv2P0zyoVvz35w/m@T590>
References: <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
 <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 17, 2022 at 12:34:42PM -0400, Chris Murphy wrote:
> 
> 
> On Wed, Aug 17, 2022, at 11:34 AM, Ming Lei wrote:
> 
> > From the 2nd log of blockdebugfs-all.txt, still not see any in-flight IO on
> > request based block devices, but sda is _not_ included in this log, and
> > only sdi, sdg and sdf are collected, is that expected?
> 
> While the problem was happening I did
> 
> cd /sys/kernel/debug/block
> find . -type f -exec grep -aH . {} \;
> 
> The file has the nodes out of order, but I don't know enough about the interface to see if there are things that are missing, or what it means.
> 
> 
> > BTW, all request based block devices should be observed in blk-mq debugfs.
> 
> /sys/kernel/debug/block contains
> 
> drwxr-xr-x.  2 root root 0 Aug 17 15:20 md0
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sda
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdb
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdc
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdd
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sde
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdf
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdg
> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdh
> drwxr-xr-x.  4 root root 0 Aug 17 15:20 sdi
> drwxr-xr-x.  2 root root 0 Aug 17 15:20 zram0

OK, so lots of devices are missed in your log, and the following command
is supposed to work for collecting log from all block device's debugfs:

(cd /sys/kernel/debug/block/ && find . -type f -exec grep -aH . {} \;)


Thanks,
Ming

