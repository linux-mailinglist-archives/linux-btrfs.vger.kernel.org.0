Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2770A564
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 May 2023 06:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjETEse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 May 2023 00:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjETEsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 May 2023 00:48:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346FFE40
        for <linux-btrfs@vger.kernel.org>; Fri, 19 May 2023 21:48:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C989A68CFE; Sat, 20 May 2023 06:48:28 +0200 (CEST)
Date:   Sat, 20 May 2023 06:48:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: call btrfs_orig_bbio_end_io when
 btrfs_end_bio_work
Message-ID: <20230520044828.GA32182@lst.de>
References: <20230515091821.304310-1-hch@lst.de> <2706bb39-a7a6-f04f-89be-427914b98d49@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2706bb39-a7a6-f04f-89be-427914b98d49@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 19, 2023 at 03:09:23PM +0000, Johannes Thumshirn wrote:
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

To add some context:

in addition to the old file system with unaligned metadata chunks case
documented in the commit log, the combination of the new scrube code
with Johannes pending raid-stripe-tree also triggers this case.  We
spent some time debugging it yesterday and found that this patch solves
the problem.
