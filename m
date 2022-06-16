Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D096654DF90
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 12:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376600AbiFPKzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFPKzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 06:55:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5715DE56
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 03:55:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E5D1D67373; Thu, 16 Jun 2022 12:54:56 +0200 (CEST)
Date:   Thu, 16 Jun 2022 12:54:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: remove the raid56_parity_{write,recover}
 return value
Message-ID: <20220616105456.GA10225@lst.de>
References: <20220615151515.888424-1-hch@lst.de> <20220615151515.888424-5-hch@lst.de> <281a06be-aba0-bcce-5681-dc81b0245124@gmx.com> <e2d5e49f-28da-95de-20b6-b29c0ce00cf9@gmx.com> <20220616063618.GB5608@lst.de> <63bf9e04-373a-0bee-5200-c843f0490f42@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bf9e04-373a-0bee-5200-c843f0490f42@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 05:53:52PM +0800, Qu Wenruo wrote:
> But I didn't see the caller increasing the counter either.
>
> Or did I miss something? (I expect the counter inc/dec still get
> properly paired at least inside the same patch)

btrfs_submit_bio increments it, and then decrements it after calling
the raid helpers.
