Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A818B557C5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 14:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiFWM6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiFWM6q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 08:58:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92694CD72
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 05:58:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E45F67373; Thu, 23 Jun 2022 14:58:37 +0200 (CEST)
Date:   Thu, 23 Jun 2022 14:58:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: fix read repair on compressed extents
Message-ID: <20220623125836.GA7146@lst.de>
References: <20220623055338.3833616-1-hch@lst.de> <52dbd483-4ebc-89b7-635a-7f9e76341ad3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52dbd483-4ebc-89b7-635a-7f9e76341ad3@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 23, 2022 at 04:14:16PM +0800, Qu Wenruo wrote:
> I thought we would fix that after getting the read repair thing figured
> out and just use that new read repair facility to do that.
>
> Especially considering the similarity between compressed read and dio
> read path (all handling pages not from page cache, needs extra structure
> member to grab logical address), it would be a perfect match for the new
> read repair code.

My attempt at consolidating the code is what lead me to this discovery.
But I think I'd much rather fix such a grave bug first, which is why
I spent some extra time yesterday to extract it from a large stack of
patches.

