Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E9C76A159
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGaTfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjGaTft (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 15:35:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C6199E
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 12:35:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FFEE68AA6; Mon, 31 Jul 2023 21:35:43 +0200 (CEST)
Date:   Mon, 31 Jul 2023 21:35:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when
 it is tracking an extent
Message-ID: <20230731193543.GA13557@lst.de>
References: <20230730190226.4001117-1-clm@fb.com> <20230731070025.GA31096@lst.de> <35b14d0e-3a53-fca7-8290-b26f31d07fb5@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b14d0e-3a53-fca7-8290-b26f31d07fb5@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 02:52:23PM -0400, Chris Mason wrote:
> > I'm torn.  On the one hand "btrfs: limit write bios to a single ordered
> > extent" is a pretty significant behavior change, on the other hand
> > stable-only patches with totally different behavior are always a bit
> > strange.
> 
> When are we creating bios without bio_ctrl->wbc set?  I think reads will
> do this?

Yes.  These days the bio_ctrl is only used for data I/O, and
bio_ctrl->wbc is set for all writeback I/O, and clear for all read I/O.
