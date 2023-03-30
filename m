Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66806D107F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 23:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjC3VG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 17:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjC3VGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 17:06:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53212D51E
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:06:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B0AC68BEB; Thu, 30 Mar 2023 23:06:50 +0200 (CEST)
Date:   Thu, 30 Mar 2023 23:06:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: don't offload CRCs generation to helpers if it is fast
Message-ID: <20230330210649.GA30487@lst.de>
References: <20230329001308.1275299-1-hch@lst.de> <ce173f2b-06f5-f7b3-2cea-5a431a180da8@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce173f2b-06f5-f7b3-2cea-5a431a180da8@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 30, 2023 at 11:42:11AM -0400, Chris Mason wrote:
> I spent a while convincing myself we really don't need sync_writers, and
> it's great to get rid of that.  Tangent-man noticed that we're really
> close to being able to drop struct btrfs_bio_ctrl->sync_io.
> 
> As far as I can tell, it's only mirroring wbc->sync_mode, and the only
> place that still cares is lock_extent_buffer_for_io(), and we could just
> pass down the wbc.

btrfs_bio_ctrl->sync_io is already gone in misc-next and replaced with
a check for wbc->sync_mode.
