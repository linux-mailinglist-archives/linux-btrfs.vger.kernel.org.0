Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EDE69F5ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBVNws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBVNws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 08:52:48 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E1C311C1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 05:52:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96C0468AA6; Wed, 22 Feb 2023 14:52:43 +0100 (CET)
Date:   Wed, 22 Feb 2023 14:52:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: cleanup btrfs_lookup_bio_sums
Message-ID: <20230222135243.GA9673@lst.de>
References: <20230221205659.530284-1-hch@lst.de> <20230221205659.530284-3-hch@lst.de> <06bc019e-96d2-b372-3db2-34fe45226ee8@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06bc019e-96d2-b372-3db2-34fe45226ee8@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 11:57:12AM +0000, Johannes Thumshirn wrote:
> 
> That wont work, as a) search_csum_tree() returns an 'int' and b)
> count is checked to be < 0 (aka error) the line below this diff:

Indeed.  I'll resend.
