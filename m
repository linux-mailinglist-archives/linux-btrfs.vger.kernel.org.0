Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799286B8AF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCNGNC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCNGNC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:13:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1661F64B16
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:13:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8059168AA6; Tue, 14 Mar 2023 07:12:57 +0100 (CET)
Date:   Tue, 14 Mar 2023 07:12:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 17/20] btrfs: don't check for uptodate pages in
 read_extent_buffer_pages
Message-ID: <20230314061257.GE25047@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-18-hch@lst.de> <fa92c65c-fb11-938a-20a0-4e0d7965b3f3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa92c65c-fb11-938a-20a0-4e0d7965b3f3@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 05:08:17PM +0800, Qu Wenruo wrote:
> Can we rely completely on EXTENT_BUFFER_UPTODATE flag and getting rid of 
> PateUptodate for metadata?

I looked into this a bit, and think without stopping to use the
page cache entirely (which I want to get to eventually) this causes
more trouble than it solves.  So I've skipped it for this series,
but eventually there will be another round of massive simplifications
here.
