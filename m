Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A595B694D37
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 17:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBMQrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 11:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBMQrt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 11:47:49 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372141043C
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 08:47:47 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 71B2010971A; Mon, 13 Feb 2023 11:47:16 -0500 (EST)
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <874jrun7zl.fsf@vps.thesusis.net>
 <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Date:   Mon, 13 Feb 2023 11:42:25 -0500
In-reply-to: <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
Message-ID: <873579y0kr.fsf@vps.thesusis.net>
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

> No. With zoned drives we're writing using the Zone Append command [1].
> This has several advantages, one being that you can issue IO at a high
> queue depth and don't need any locking to. But it has one downside for
> the RAID application, that is, that you don't have any control of the 
> LBA where the data lands, only the zone.

Can they be reordered in the queue?  As long as they are issued in the
same order on both drives and can't get reordered, I would think that
the write pointer on both drives would remain in sync.
