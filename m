Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906B50DC5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiDYJWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiDYJW0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:22:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F51FA66
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:19:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 13F2368AA6; Mon, 25 Apr 2022 11:19:21 +0200 (CEST)
Date:   Mon, 25 Apr 2022 11:19:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Message-ID: <20220425091920.GC16446@lst.de>
References: <20220425075418.2192130-1-hch@lst.de> <20220425075418.2192130-4-hch@lst.de> <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 25, 2022 at 05:11:15PM +0800, Qu Wenruo wrote:
>
>
> On 2022/4/25 15:54, Christoph Hellwig wrote:
>> Split btrfs_submit_data_bio into one helper for reads and one for writes.
>
> If we're splitting the bio mapping, wouldn't it be better to split by
> read/write first, then by data/meta?
>
> Especially for all read bios, we use workqueue to defer to a less strict
> context, which is unrelated to data/metadata.

Splitting the read vs write handling entirely and not allocating a
btrfs_bio for writes will be the next series after this one.  You're
getting ahead of me :)
