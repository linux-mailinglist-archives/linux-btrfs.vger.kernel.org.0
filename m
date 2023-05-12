Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78370093F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbjELNcN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbjELNcM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 09:32:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673FF5596
        for <linux-btrfs@vger.kernel.org>; Fri, 12 May 2023 06:32:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5C8E68AA6; Fri, 12 May 2023 15:32:06 +0200 (CEST)
Date:   Fri, 12 May 2023 15:32:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: add an ordered_extent pointer to struct btrfs_bio
Message-ID: <20230512133206.GA31235@lst.de>
References: <20230508160843.133013-1-hch@lst.de> <20230510163221.GT32559@twin.jikos.cz> <20230511175637.GA32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511175637.GA32559@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 11, 2023 at 07:56:37PM +0200, David Sterba wrote:
> I did another pass and adjusted some minor style things. I'm curious
> about the performance effects now that the lookups are gone, we'll have
> some data from the nightly CI tests next week.

I've not seen any differences in my testing, but my test right isn't
super beefy.  If you have interesting results to share let me know.
