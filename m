Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6055122E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiFTIJF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 04:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTIJE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 04:09:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B511174
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 01:09:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6540368AA6; Mon, 20 Jun 2022 10:09:00 +0200 (CEST)
Date:   Mon, 20 Jun 2022 10:09:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
Message-ID: <20220620080900.GA12668@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-7-hch@lst.de> <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com> <1b21e3e9-cdd9-baa6-bd39-e9489de883ff@gmx.com> <20220620074742.GB11832@lst.de> <5a344cb5-ced9-ebd5-b871-6fa6cf031e20@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a344cb5-ced9-ebd5-b871-6fa6cf031e20@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 04:03:28PM +0800, Qu Wenruo wrote:
> But in that case, mind to put this patch into the series do all the bio
> counter cleanups?
>
> AFAIK there is no dependency in the patchset on this patch, it would be
> much better to be in a series doing bio counters.

It heavily depends on the previous changes.  Both on the fact that
all cleanup is done through the endio handler, andthe removal of the
stripes_pending field.
