Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46787597323
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiHQPfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiHQPfM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 11:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A866564F
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660750506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aBejiWlmL7KTluGGks2ap2v6Rw6S2N1hayNB2ffhKI=;
        b=bAiIXOeyxTWpHu+DW2vPVdt5EsPYYzJECc7/f52vg3EnNl1dgdddqX42XkNf9lOVyUqrvD
        jjOvGDkliIiGRru0qJw+YNymG5hqvh0m3Fu1iDOFWUR6L5da6YZTYP2/qPIWIR5rbZNDVW
        y4G6q3HNOz1hozEAWFrgo2gPJ/Ikzdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-P4u9hwP0OzSmE5K0jvDrUA-1; Wed, 17 Aug 2022 11:35:01 -0400
X-MC-Unique: P4u9hwP0OzSmE5K0jvDrUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDCA8802D2C;
        Wed, 17 Aug 2022 15:35:00 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C2EC14583C0;
        Wed, 17 Aug 2022 15:34:54 +0000 (UTC)
Date:   Wed, 17 Aug 2022 23:34:49 +0800
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
Message-ID: <Yv0KmT8UYos2/4SX@T590>
References: <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
 <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 17, 2022 at 11:02:25AM -0400, Chris Murphy wrote:
> 
> 
> On Wed, Aug 17, 2022, at 10:53 AM, Ming Lei wrote:
> > On Wed, Aug 17, 2022 at 10:34:38AM -0400, Chris Murphy wrote:
> >> 
> >> 
> >> On Wed, Aug 17, 2022, at 8:06 AM, Ming Lei wrote:
> >> 
> >> > blk-mq debugfs log is usually helpful for io stall issue, care to post
> >> > the blk-mq debugfs log:
> >> >
> >> > (cd /sys/kernel/debug/block/$disk && find . -type f -exec grep -aH . {} \;)
> >> 
> >> This is only sda
> >> https://drive.google.com/file/d/1aAld-kXb3RUiv_ShAvD_AGAFDRS03Lr0/view?usp=sharing
> >
> > From the log, there isn't any in-flight IO request.
> >
> > So please confirm that it is collected after the IO stall is triggered.
> 
> Yes, iotop reports no reads or writes at the time of collection. IO pressure 99% for auditd, systemd-journald, rsyslogd, and postgresql, with increasing pressure from all the qemu processes.
> 
> Keep in mind this is a raid10, so maybe it's enough for just one block device IO to stall and the whole thing stops? That's why I included all block devices.
> 

From the 2nd log of blockdebugfs-all.txt, still not see any in-flight IO on
request based block devices, but sda is _not_ included in this log, and
only sdi, sdg and sdf are collected, is that expected?

BTW, all request based block devices should be observed in blk-mq debugfs.



thanks,
Ming

