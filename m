Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E16BAA6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCOIHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 04:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCOIHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 04:07:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9714383EF
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HpgNr7xB9CYnszhTln6Z1CS4slfvuDKB8E4isyKYsJU=; b=WqeWd0GPEDG3i60Gj0G64WXPfb
        /DlV46OytgLWJmVWOkt2ffynf/ttcqFxJRWVCZEBSm1Z18w3B8vgAqhcsNUsyoAXXCVOjMLpZem7o
        CaVfPQeuxt1mT4mkXT6JX2gcLBxhaFvyFOvz+PuKFVsZo2byhzcsJL+bdWZlrKXTzXq/3u4HdmbLt
        dxo2og0BefyK58OmKBnySK3HJtSe/5oTxu2V/03tqV8zh9tWcxJw6HFVdD+YLnmMC/G6rdO00WgZe
        BmuMUClI24Vv92QZv5Vnkjh7E3EgCkBU++Ws4RMXT6TZ/dBG5tGr/+/Mwi4sLbLBdt7tC2G16DRi/
        h5gW2GBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcMA5-00CkXl-0h;
        Wed, 15 Mar 2023 08:07:05 +0000
Date:   Wed, 15 Mar 2023 01:07:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Message-ID: <ZBF8qeZ/Yp06baPF@infradead.org>
References: <cover.1678777941.git.wqu@suse.com>
 <27af1ebdc7a7048895be3eaccd3fb437337e1830.1678777941.git.wqu@suse.com>
 <ZBF5r3itXwDKCsA8@infradead.org>
 <736958db-3c6e-7ae2-b1b6-c658cbbd0b96@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736958db-3c6e-7ae2-b1b6-c658cbbd0b96@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 15, 2023 at 04:04:19PM +0800, Qu Wenruo wrote:
> > Ugg.  Let's not go into too crazy unions here that make the code
> > alsmost impossible to use correctly.  If we want to get away without
> > the inode we just need an extra unconditional fs_info field, which
> > is what most users of ->inode actually use.  I can take care of that.
> 
> If the memory usage is not a big deal, then I'm totally fine with a
> dedicated fs_info member.

According to pahole we still have a fair amount of space in the
btrfs_bio before increasing the allocation.  While I don't want to use
it lightly, this seems like a good use case.

With a little more work I might be able to move the inode into a
union leg only used for data writes as well.
