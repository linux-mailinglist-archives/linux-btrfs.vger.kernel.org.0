Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3C64B60F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 14:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiLMNZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 08:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiLMNZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 08:25:35 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D42035B
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 05:25:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE2F567373; Tue, 13 Dec 2022 14:25:31 +0100 (CET)
Date:   Tue, 13 Dec 2022 14:25:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: small raid56 cleanups v2
Message-ID: <20221213132531.GB21430@lst.de>
References: <20221213084123.309790-1-hch@lst.de> <4a2e71d8-59ca-f29c-a6c7-f07685c2e528@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2e71d8-59ca-f29c-a6c7-f07685c2e528@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 04:59:35PM +0800, Qu Wenruo wrote:
> The series looks good overall, but I'm more interested in how btrfs RAID56 
> can help your other projects.

The project here is mostly to hand off to workqueue earlier in the btrfs
I/O completion path, and thus mostly avoiding irqsave spinlocking,
similar to what XFS has been doing for quite a while.
