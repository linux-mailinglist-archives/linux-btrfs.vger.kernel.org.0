Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581AE6B28A0
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 16:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCIPWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 10:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCIPWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 10:22:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721DAEFF4D
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 07:22:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF39E68AA6; Thu,  9 Mar 2023 16:22:07 +0100 (CET)
Date:   Thu, 9 Mar 2023 16:22:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/20] btrfs: simplify extent buffer writing
Message-ID: <20230309152207.GE17952@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-13-hch@lst.de> <e3f3a52f-8656-24f9-f8ed-a13c2dcffeb0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f3a52f-8656-24f9-f8ed-a13c2dcffeb0@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 02:00:32PM +0000, Johannes Thumshirn wrote:
> Looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Looking at the resulting code, I hope one of the subsequent
> patches is merging write_one_subpage_eb() and write_one_eb()
> as they're getting quite similar.

The final patch will do that.
