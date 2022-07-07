Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA656A9B2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 19:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiGGReK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGGReJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 13:34:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591D32EFB
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 10:34:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1203467373; Thu,  7 Jul 2022 19:34:04 +0200 (CEST)
Date:   Thu, 7 Jul 2022 19:34:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Christoph Hellwig <hch@lst.de>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
Message-ID: <20220707173403.GA29410@lst.de>
References: <20220630160319.2550384-1-hch@lst.de> <ebf7b037-2c08-8232-6b61-8a97ee22a1ea@oracle.com> <20220707172240.GK15169@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707172240.GK15169@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 07, 2022 at 07:22:41PM +0200, David Sterba wrote:
> Actually yes, it should be here as well, otherwise this would leak.
> RAID56 + zoned combination is rejected much earlier so this would not
> happen in practice.

A version with that fixed is already out on the list, just pick that
one up instead.
