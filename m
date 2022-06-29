Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D35609FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 21:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiF2TIq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiF2TIo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 15:08:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A5C22500
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 12:08:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C27468AA6; Wed, 29 Jun 2022 21:08:39 +0200 (CEST)
Date:   Wed, 29 Jun 2022 21:08:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Burkov <boris@bur.io>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: fix read repair on compressed extents
Message-ID: <20220629190838.GA28224@lst.de>
References: <20220623055338.3833616-1-hch@lst.de> <20220629084201.GA25725@lst.de> <YryiSQcMbgOJbgqf@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YryiSQcMbgOJbgqf@zen>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 29, 2022 at 12:04:41PM -0700, Boris Burkov wrote:
> Under that setup, the new btrfs/270 fails on step 4 checking if
> the repair worked (the output looks all random rather than aa's)

I think that is the first, incorrect version that I posted that
documents the current behavior.  The correct test is in my first
reply to it.
