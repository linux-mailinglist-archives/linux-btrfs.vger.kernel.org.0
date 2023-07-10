Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE974CC30
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 07:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGJF2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 01:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJF2O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 01:28:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40826B3
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 22:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NN2Mk5hmVWy6jVbOR0lJuBKlTJduLb1zyZCtw7nTb8w=; b=Fr8KHofgdOXX6VUKhFK69TKiFv
        nSrqXMOYgCxMeb1gXw/+ftx+KPUx6Won0dLNjCUVW8fB763fPmHNrnSPZGyn+8EWtKjrxjau2KbfO
        WAURVSBcfiTuSFk14zRMhR3tmlZtp69TP4jjfWME/KqPwF9xntb2Cn5BMYc5gLSNsQCAsMqrdypOz
        eFqd2bSMps1jy0MT034qYa8wXrZViewLgRh6H58ON3/ze4K1nn3PBhYuvv+sr7ivhWjhSbLhTfblb
        0hhlBJvOmDcAncH6PvOG6wgv6aW691yJe/9ahHax0NTYRbw88XLUAbO69YXtvDMALs7u+Bv99uAJy
        Gq1MWqEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjRU-00ATRq-0a;
        Mon, 10 Jul 2023 05:28:12 +0000
Date:   Sun, 9 Jul 2023 22:28:12 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Message-ID: <ZKuW7IkT9wtgJXQw@infradead.org>
References: <cover.1688658745.git.josef@toxicpanda.com>
 <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
 <ZKf5IjoGAAdkrz1I@infradead.org>
 <wbsmajimcou2ow6s4rtzeopwvd5dhku7hcdvm2u3doy6lagvev@3kga7xlvxn5t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wbsmajimcou2ow6s4rtzeopwvd5dhku7hcdvm2u3doy6lagvev@3kga7xlvxn5t>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 10, 2023 at 12:57:52AM +0000, Naohiro Aota wrote:
> It depends on what we consider the "minimal" is.

I think minimal means a file system that can actually be be continuously
used.

> Even with the 5 zones (2
> SBs + 1 per BG type), we can start writing to the file-system.
> 
> If you need to run a relocation, one more block group for it is needed.
> 
> The fsync block group might be optional because if the fsync node
> allocation failed, it should fall back to the full sync. It will kill the
> performance but still works...
> 
> If we say it is the "minimal" that we can infinitely write and delete a
> file without ENOSPC, we need one (or two, depending on the metadata
> profile) more BGs per META/SYSTEM.

Based on my above sentence we then need:

 2 zones for the primary superblock

metadata replication factor * (
  2 zones for the system block group
  2 zone for a metadata block group
  2 zone for the tree log)


data replication factor * (
 1 zone for a data block group
 1 zone for a relocation block group
)

where the two for the non-sb, non-data blocks accounts for beeing
able to continue writing after filling up one bg and allowing
gc.  In fact even just two might lead to deadlocks in that case
depending on the exact algorithm in other zoned storage systems,
but I don't know enough about btrfs metadata placement to understand
how that works on zoned btrfs right now.
