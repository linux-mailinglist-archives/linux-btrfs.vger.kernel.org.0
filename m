Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5566FC79A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjEINMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjEINMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 09:12:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0361BC9
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 06:12:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C395168D05; Tue,  9 May 2023 15:12:44 +0200 (CEST)
Date:   Tue, 9 May 2023 15:12:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/21] btrfs: add a btrfs_finish_ordered_extent helper
Message-ID: <20230509131244.GA32049@lst.de>
References: <20230508160843.133013-1-hch@lst.de> <20230508160843.133013-18-hch@lst.de> <c850eb49-2e63-ed20-c987-4ff5a406f851@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c850eb49-2e63-ed20-c987-4ff5a406f851@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 09, 2023 at 12:22:39AM +0000, Johannes Thumshirn wrote:
> > +		  show_root_type(__entry->root_objectid),
> > +		  __entry->ino, __entry->start,
> > +		  __entry->len, __entry->uptodate)
> > +);
> 
> Why can't we use the btrfs__ordered_extent event class here?

We could.  We'd lose the information on the range of the ordered_extent
that actually is being completed.  If the maintainers are ok with not
having that in the trace point we can drop the separate implementation.
