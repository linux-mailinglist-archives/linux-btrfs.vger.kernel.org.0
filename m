Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697076B2896
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjCIPUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 10:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCIPU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 10:20:29 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189878481F
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 07:20:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8704668AA6; Thu,  9 Mar 2023 16:20:19 +0100 (CET)
Date:   Thu, 9 Mar 2023 16:20:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "hch@infradead.org" <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <20230309152019.GB17952@lst.de>
References: <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com> <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com> <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com> <ZACsVI3mfprrj4j6@infradead.org> <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com> <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com> <ZAIBQ0hzLTjOIYcr@infradead.org> <e9e7820b-9cf3-8361-cf3c-e4d59baa5b21@wdc.com> <20230308143330.GB14929@lst.de> <ff038aba-943d-5df5-5673-4e475dd397b2@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff038aba-943d-5df5-5673-4e475dd397b2@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 10:53:08AM +0000, Johannes Thumshirn wrote:
> I wanted to avoid memory allocations in the end_io handler though.
> If all is offloaded to a common workqueue, like with your proposal,
> that'll be ok for me, but atomic allocations don't look right for
> this for me.

Indeed.
