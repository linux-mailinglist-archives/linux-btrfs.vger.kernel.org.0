Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE905033C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 07:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiDPEtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Apr 2022 00:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiDPEtG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Apr 2022 00:49:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69165F94
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 21:46:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A6BE68AFE; Sat, 16 Apr 2022 06:46:30 +0200 (CEST)
Date:   Sat, 16 Apr 2022 06:46:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: minor bio submission cleanups
Message-ID: <20220416044629.GA6162@lst.de>
References: <20220415143328.349010-1-hch@lst.de> <fc163e9a-ff50-ac31-9b41-fea23913f579@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc163e9a-ff50-ac31-9b41-fea23913f579@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 16, 2022 at 06:44:05AM +0800, Qu Wenruo wrote:
> Mind to share which commit your code are based on?

the misc-next branch as of yesterday.

>
> After patch 3/5 "btrfs: do not return errors from
> btrfs_submit_metadata_bio", I was expecting the same cleanup for
> btrfs_submit_data_bio(), but it doesn't.

patch 5 handles it, but it btrfs_submit_data_bio can't be done standalone
as it is also used as a callback for btrfs_repair_one_sector.
