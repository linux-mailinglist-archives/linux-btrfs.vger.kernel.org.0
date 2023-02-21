Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06E169E247
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjBUO2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBUO2X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:28:23 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23561D93B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:28:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E59468AFE; Tue, 21 Feb 2023 15:28:19 +0100 (CET)
Date:   Tue, 21 Feb 2023 15:28:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Message-ID: <20230221142818.GA29949@lst.de>
References: <20230219181022.3499088-1-hch@lst.de> <20230220201905.GJ10580@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220201905.GJ10580@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 20, 2023 at 09:19:05PM +0100, David Sterba wrote:
> On Sun, Feb 19, 2023 at 07:10:22PM +0100, Christoph Hellwig wrote:
> > Move the remaining code that deals with initializing the btree
> > inode into btrfs_init_btree_inode instead of splitting it between
> > that helpers and its only caller.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Added to misc-next, thanks.

Btw, in case you need to rebase again, the subject needs a
'inode' after 'btree'.
