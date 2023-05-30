Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A647163F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjE3OZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjE3OYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 10:24:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCFA1BE
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 07:23:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B2AC68B05; Tue, 30 May 2023 16:23:36 +0200 (CEST)
Date:   Tue, 30 May 2023 16:23:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/16] btrfs: fix range_end calculation in
 extent_write_locked_range
Message-ID: <20230530142336.GA9014@lst.de>
References: <20230523081322.331337-1-hch@lst.de> <20230523081322.331337-2-hch@lst.de> <20230529171318.GI575@twin.jikos.cz> <20230530131304.GP575@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530131304.GP575@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 03:13:04PM +0200, David Sterba wrote:
> Seems it's directly affecting subpage since e55a0de18572 ("btrfs: rework
> page locking in __extent_writepage()"), the range_end is passed there
> and adjusted by + 1, IOW expecting it to initially have the value of
> 'end'.

This code is only used for compression, which isn't supported for
zoned devices, and for compression, which unless I misremember the code
only supported for multiples of the page size for the allocations.
