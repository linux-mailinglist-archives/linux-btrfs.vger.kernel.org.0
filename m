Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B954FAB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382860AbiFQP6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiFQP6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 11:58:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC873BF84
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 08:58:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 62DFE68AA6; Fri, 17 Jun 2022 17:58:13 +0200 (CEST)
Date:   Fri, 17 Jun 2022 17:58:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't limit direct reads to a single sector
Message-ID: <20220617155812.GB31552@lst.de>
References: <20220616080224.953968-1-hch@lst.de> <a2dd54d7-ea9e-8647-261c-7d622f536f53@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2dd54d7-ea9e-8647-261c-7d622f536f53@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 06:01:07PM +0300, Nikolay Borisov wrote:
> The limit here has direct repercussion on how much space we could 
> potentially allocated in btrfs_submit_direct for csums. For 1m read this 
> means we end up with 256 entries array (provided a blocksize of 4k). For 
> crc32c that's 1k of data, for blake2/sha256 that'd be 8k of data. It would 
> be good to put this into the change log to demonstrated that at least some 
> consideration has been given to this aspect.
> In any case perhaps putting some sane upper limit might make sense?

Now that you mentioned an upper limit around 1MB might make sense. 
Below that this new code isn't any different from how the bbio->csum is
allocated for buffered I/O, and in one of the next round of patches I do
plan to switch it over to using that, including the optimization with
the inline csums to help small I/O.

But with huge pages we can go above the 1MB for direct I/O, while for
buffered I/O we'd need large folio support first, which isn't supported
for btrfs.
