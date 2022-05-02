Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29FB5174E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 18:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350753AbiEBQt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378056AbiEBQtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 12:49:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E7F12635
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AMpzb43R4u0T0oK8Jdg5FHau4dJFOV6e78gysMkNzvg=; b=WF6FIKegytTNHM1lx58UA0616D
        FbjbTYIzjkj6ljMMwhqzQCouKd72yQkMiYtijWdxIp6D6f5RZKFWY6WXU/4QEg3dB2Uj3ZbuFGe/O
        GGdh5L04yefGOscW5jJRw+3bSjCmtDFBIrUboCDPLaZjMaNE28jWRz86nxZ0rAgT20FZRjROAzbax
        sxeZmwHE9vHVl1chmk5Z+svTF3HDNuGheegF+jUjLZL1F4FL7mgj9sRBwl8t59GYa12QvT7uU20r7
        4d1lfr2ZGtHJdbAQeVKY5KFBeUq1vkNOYoG46jvjykTYljx7ABXOo4NlGTS2Fung0XkJjn1HFnphR
        AZLhsp/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlZAy-001lpD-IP; Mon, 02 May 2022 16:45:32 +0000
Date:   Mon, 2 May 2022 09:45:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Message-ID: <YnAKrM+i5V2iOzB1@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
 <YmqaOynJjWS2XB76@infradead.org>
 <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
 <YmwAzU+UORfX92Te@infradead.org>
 <32e7a9c3-00b8-9e59-276c-ce5965ccb92a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e7a9c3-00b8-9e59-276c-ce5965ccb92a@gmx.com>
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

On Mon, May 02, 2022 at 07:59:43AM +0800, Qu Wenruo wrote:
> So with your previous mention on mempool, did you mean that we allocate
> another mempool for read repair only?
> 
> With the extra read repair mempool, even we exhaust the last btrfs bio
> in the pool, we still have something like btrfs read repair bio?
> (And we can get rid of the extra members unused in btrfs bio, since what
> we really need is just a logical bytenr and pointer back to
> btrfs_read_repair_ctrl).
> 
> This sounds pretty good to me then.

I primarily meant a separate mempool for the actual read_repair_ctrl
structure with embedded bitmaps.  But yes, bios also do need to be taken
care off, and a different bio_set might work very well there.
