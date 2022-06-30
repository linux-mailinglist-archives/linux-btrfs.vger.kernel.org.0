Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4B560FF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 06:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiF3EWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 00:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiF3EWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 00:22:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73305377F9
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 21:22:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D0A8868AA6; Thu, 30 Jun 2022 06:22:48 +0200 (CEST)
Date:   Thu, 30 Jun 2022 06:22:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Burkov <boris@bur.io>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: simplify the pending I/O counting in struct
 compressed_bio
Message-ID: <20220630042248.GA4901@lst.de>
References: <20220623055338.3833616-1-hch@lst.de> <20220623055338.3833616-2-hch@lst.de> <YrzjVv3WTKVqmrD+@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrzjVv3WTKVqmrD+@zen>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 29, 2022 at 04:42:14PM -0700, Boris Burkov wrote:
> On Thu, Jun 23, 2022 at 07:53:35AM +0200, Christoph Hellwig wrote:
> > Instead of counting the bytes just count the bios, with an extra
> > reference held during submission.  This significantly simplifies the
> > submission side error handling.
> 
> Interestingly, this more or less exactly un-does the patch:
> 
> btrfs: introduce compressed_bio::pending_sectors to trace compressed bio
> 
> which introduced the sector counting, asserting that counting bios was
> awkward. FWIW, in my opinion, counting from 1 feels worth it to not have
> to add up the size, and simplifying the error handling.

Looking at the commit history: yes, it kind of does, but this new
version actually has several advantages over the version before that
commit as well, one being the extra bias on the refcount, and other
things are APIs fixed in the meantime like actually propagating the
error code.
