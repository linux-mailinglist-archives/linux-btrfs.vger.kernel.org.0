Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B75A776225
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjHIONm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjHIONl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 10:13:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AACC1FCC
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 07:13:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B4F66732D; Wed,  9 Aug 2023 16:13:37 +0200 (CEST)
Date:   Wed, 9 Aug 2023 16:13:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230809141337.GA32478@lst.de>
References: <20230724132701.816771-1-hch@lst.de> <20230727170622.GH17922@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727170622.GH17922@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Please drop it from for-next for now.  There's plenty of outstanding
issues, and with this week being last minute business travel followed
by two weeks of vacation I'm not going to be anywhere near my subpage
test rig even if I had time to look into all the issues.
