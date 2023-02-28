Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01FE6A59D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Feb 2023 14:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjB1NNw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 08:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1NNv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 08:13:51 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4721968
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 05:13:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBF4B68AA6; Tue, 28 Feb 2023 14:13:43 +0100 (CET)
Date:   Tue, 28 Feb 2023 14:13:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Message-ID: <20230228131343.GA25954@lst.de>
References: <20230227151704.1224688-1-hch@lst.de> <20230227151704.1224688-7-hch@lst.de> <4253c978-d19e-5032-913a-dafda476eded@wdc.com> <20230228025824.GA26819@lst.de> <4ef88b3e-1352-e3ca-9e5a-a139ba30c498@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef88b3e-1352-e3ca-9e5a-a139ba30c498@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 28, 2023 at 09:02:42AM +0000, Johannes Thumshirn wrote:
> Sh*t, then at least let's document that with a comment. Otherwise someone
> will see the code and try to clean it up and possibly break it.

I'll literally blow up on the first compression xfstests.
