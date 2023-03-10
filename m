Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D46B37B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 08:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCJHsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 02:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCJHsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 02:48:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0101EBE8
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 23:47:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF1CD68C4E; Fri, 10 Mar 2023 08:47:24 +0100 (CET)
Date:   Fri, 10 Mar 2023 08:47:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Message-ID: <20230310074723.GA14897@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-6-hch@lst.de> <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 03:42:04PM +0800, Qu Wenruo wrote:
> This is the legacy left by older stripe boundary based bio split code.
> (Please note that, metadata crossing stripe boundaries is not ideal and is 
> very rare nowadays, but we should still support it).

How can metadata cross a stripe boundary?
