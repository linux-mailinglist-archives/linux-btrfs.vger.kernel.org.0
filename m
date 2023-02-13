Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD395694EFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 19:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBMSOU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 13:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBMSOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 13:14:19 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13818B
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 10:14:18 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 1E868109784; Mon, 13 Feb 2023 13:03:56 -0500 (EST)
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <874jrun7zl.fsf@vps.thesusis.net>
 <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
 <873579y0kr.fsf@vps.thesusis.net>
 <6564fc09-3dcb-4224-d4d9-0a20a37efd64@wdc.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Date:   Mon, 13 Feb 2023 12:56:09 -0500
In-reply-to: <6564fc09-3dcb-4224-d4d9-0a20a37efd64@wdc.com>
Message-ID: <87y1p1wigj.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:

> There is no guarantee for that, no. The block layer can theoretically
> re-order all WRITEs. This is why btrfs also needs the mq-deadline IO

Unless you submit barriers to prevent that right?  Why not do that?

> scheduler as metadata is written as WRITE with QD=1 (protected by the
> btrfs_meta_io_lock() inside btrfs and the zone write lock in the 
> IO scheduler.
>
> I unfortunately can't remember the exact reasons why the block layer
> cannot be made in a way that it can't re-order the IO. I'd have to defer
> that question to Christoph.

I would think that to prevent fragmentation, you would want to try to
flush a large portion of data from a particular file in order then move
to another file.  If you have large streaming writes to two files at the
same time and the allocator decides to put them in the same zone, and
they are just submitted to the stack to do in any order, isn't this
likely to lead to a lot of fragmentation?

