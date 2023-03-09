Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61376B2898
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCIPVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 10:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCIPVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 10:21:10 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A16E683C
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 07:21:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F03C368AA6; Thu,  9 Mar 2023 16:21:06 +0100 (CET)
Date:   Thu, 9 Mar 2023 16:21:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/20] btrfs: merge verify_parent_transid and
 btrfs_buffer_uptodate
Message-ID: <20230309152106.GC17952@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-4-hch@lst.de> <cbeb9ad7-ae37-4bbf-8955-b8134197171a@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbeb9ad7-ae37-4bbf-8955-b8134197171a@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 11:17:47AM +0000, Johannes Thumshirn wrote:
> On 09.03.23 10:07, Christoph Hellwig wrote:
> > verify_parent_transid is only called by btrfs_buffer_uptodate, which
> > confusingly inverts the return value.  Merge the two functions and
> > reflow the parent_transid so that error handling is in a branch.
> 
> This would be a good chance to make btrfs_buffer_uptodate() a bool
> function.

It still can return 0/1/-EAGAIN.
