Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF06C8CB8
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjCYIiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjCYIhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:37:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5079193EC
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:37:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E358168AA6; Sat, 25 Mar 2023 09:37:12 +0100 (CET)
Date:   Sat, 25 Mar 2023 09:37:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/11] btrfs: simplify btrfs_split_ordered_extent
Message-ID: <20230325083712.GC7598@lst.de>
References: <20230324023207.544800-1-hch@lst.de> <20230324023207.544800-7-hch@lst.de> <20230324075248.37cagxzdugxjovlp@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324075248.37cagxzdugxjovlp@naota-xeon>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 07:52:49AM +0000, Naohiro Aota wrote:
> > +	/* The bio must be entirely covered by the ordered extent */
> > +	if (WARN_ON_ONCE(len > ordered->num_bytes))
> > +		return -EINVAL;
> 
> Can we also reject "len == ordered->num_bytes" case here? So, we will never
> modify the ordered extent to have
> ordered->{num_bytes,disk_num_bytes,bytes_left} == 0.

Sure, I've replaced the > with a >= and expanded the comment.
