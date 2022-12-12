Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8956499D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiLLH72 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiLLH7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:59:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FDDEF2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:59:24 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED7D568AA6; Mon, 12 Dec 2022 08:59:20 +0100 (CET)
Date:   Mon, 12 Dec 2022 08:59:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: call rbio_orig_end_io from rmw_rbio
Message-ID: <20221212075920.GA11851@lst.de>
References: <20221212070611.5209-1-hch@lst.de> <20221212070611.5209-4-hch@lst.de> <0d509df3-4f20-7a10-ee3d-8c7474af87a8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d509df3-4f20-7a10-ee3d-8c7474af87a8@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 03:39:57PM +0800, Qu Wenruo wrote:
> This changed the schema, as all work functions, rmw_rbio(), recover_rbio(), 
> scrub_rbio() all follows the same return error, and let the caller to call 
> rbio_orig_end_io().
>
> I'm not against the change, but it's better to change all *_rbio() 
> functions to follow the same behavior instead.

I hadn't looked at the other work items, but yes it seems like they
would benefit from a similar change.
