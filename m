Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5265476B896
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjHAP3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHAP3Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 11:29:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3CFD
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 08:29:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A2F86732D; Tue,  1 Aug 2023 17:29:12 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:29:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230801152911.GA12035@lst.de>
References: <20230724132701.816771-1-hch@lst.de> <20230727170622.GH17922@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727170622.GH17922@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 07:06:22PM +0200, David Sterba wrote:
> On Mon, Jul 24, 2023 at 06:26:52AM -0700, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series has various fixes for bugs found in inspect or only triggered
> > with upcoming changes that are a fallout from my work on bound lifetimes
> > for the ordered extent and better confirming to expectations from the
> > common writeback code.
> 
> I've so far merged patches 1-3, the rest will be in for-next as it's
> quite risky and I'd appreciate more reviews.

So who would be a suitable reviewer for this code in addition to Josef?

Any volunteers?
