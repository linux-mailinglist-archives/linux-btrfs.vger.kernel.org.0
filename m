Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38352453A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 May 2022 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349118AbiELF4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 May 2022 01:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350048AbiELF4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 May 2022 01:56:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A9C289A8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 22:56:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA73568BEB; Thu, 12 May 2022 07:56:38 +0200 (CEST)
Date:   Thu, 12 May 2022 07:56:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] btrfs: don't use btrfs_bio_wq_end_io for
 compressed writes
Message-ID: <20220512055638.GA19930@lst.de>
References: <20220504122524.558088-1-hch@lst.de> <20220504122524.558088-7-hch@lst.de> <f8d90519-9911-fde0-9b18-3e4f339590c3@suse.com> <63d980ff-29cf-19e9-e3ea-a5587fabc534@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d980ff-29cf-19e9-e3ea-a5587fabc534@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 11, 2022 at 10:28:02PM +0300, Nikolay Borisov wrote:
> Please fix those to ensure the series is actually bisectable.

Yeah.  Funny thing is this how I had it until the last repost,
just to reshuffle it for some reason.  I should have just left it as-is..
