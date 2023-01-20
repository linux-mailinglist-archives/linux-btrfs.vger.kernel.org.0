Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE2674F3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 09:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjATIOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 03:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjATIN5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 03:13:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756B891EC
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 00:13:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E4D168D07; Fri, 20 Jan 2023 09:13:43 +0100 (CET)
Date:   Fri, 20 Jan 2023 09:13:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: the raid56 code does not need irqsafe locking
Message-ID: <20230120081342.GA27851@lst.de>
References: <20230120074657.1095829-1-hch@lst.de> <b6561756-40f9-67a3-49e6-d11cf5605fe5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6561756-40f9-67a3-49e6-d11cf5605fe5@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 20, 2023 at 04:05:07PM +0800, Qu Wenruo wrote:
> And thanks to the patch, I exposed that for read/write endio, we lacks 
> spinlocks for bitmap operations.
>
> As we still have chances to have multiple bios for the same stripe, and 
> bitmap operations themselves are not atomic.

So, bitmap_set is indeed not atomic.  But if you switch to the
set_bit that should be enough here.

