Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA36C8CA5
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCYIef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCYIee (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:34:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E24144BE
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:34:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 54F0468AA6; Sat, 25 Mar 2023 09:34:27 +0100 (CET)
Date:   Sat, 25 Mar 2023 09:34:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: simplify btrfs_extract_ordered_extent
Message-ID: <20230325083426.GB7598@lst.de>
References: <20230324023207.544800-1-hch@lst.de> <20230324023207.544800-6-hch@lst.de> <20230324060725.q2jd6z2wzeytehzb@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324060725.q2jd6z2wzeytehzb@naota-xeon>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 06:07:26AM +0000, Naohiro Aota wrote:
> > -	ret = btrfs_split_ordered_extent(ordered, pre, post);
> > +	ret = btrfs_split_ordered_extent(ordered, len, 0);
> 
> The next patch will overwrite this anyway, but the pre and post are the
> length of new ordered extents which are not covered by the bio. So, giving
> them (len, 0) breaks the semantics so that a new ordered extent is
> allocated for the bio range. They should be (0, ordered_len - len).

Hmm, nothing trips up in my ZNS tests even at this bisection point,
and I don't think it should matter at this stage what part is split
off.  Later we rely on the front being split off and a new
ordered_extent being allocated for the front range covering the
bio.  So maybe this just need to be documented in the commit log?
