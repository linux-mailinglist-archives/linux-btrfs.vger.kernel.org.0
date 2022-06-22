Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66355554200
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 07:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355674AbiFVFH3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 01:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbiFVFH2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 01:07:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E635AAC
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 22:07:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 147EC68AA6; Wed, 22 Jun 2022 07:06:58 +0200 (CEST)
Date:   Wed, 22 Jun 2022 07:06:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Message-ID: <20220622050658.GA22104@lst.de>
References: <20220619082821.2151052-1-hch@lst.de> <6490bdce-d5f6-9e59-ba04-41f0fdf8bbff@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6490bdce-d5f6-9e59-ba04-41f0fdf8bbff@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 12:32:16PM +0800, Qu Wenruo wrote:
> Personally speaking, why not only repair the initial failed mirror?

Because that is a risk to data integity?  If we know there are multiple
failures  we know that we are at risk of losing the data entirely if one
(or in the case of raid1c4 two) additional copis fail.  And we can trivially
fix it up.

> It would be much simpler, no need to record which mirrors failed.

How would it be "much simpler"?  You could replace the do{  } while loop
with single call to repair_io_failure and loose the prev_mirror helper.

We need to record at least one failed mirror to be able to repair it, and
with the design in this patch we can trivially walk back from the first
good mirror to the first bad one.
