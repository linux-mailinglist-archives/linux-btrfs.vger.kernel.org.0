Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60C6BAA0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 08:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCOHxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCOHwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 03:52:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40330746C2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3frU1NEszuL8hiZd+wsW1pT3A41VW/Dll9lA5200v9E=; b=w1EwD2+jyhLnQrskpM4FihFLno
        zrdhou0cuuE97GbTW+e8RbIFXUWgbbviDjKzffKrQXwPyv4nwCAW74YZX/c3+ODDTo+RI97tclGPX
        IET8Hzz4dfyRVXRHV+qfbnt2xQxzsLfqeBDDEDqQiJOdLuvES9PwLY8fsyHGMGvyVrs2DLq0jjSLZ
        F5/VvFk+J+4cXiC3jRemUet+/JRE/WshyGIk9X+C9We0h6LTn2TXc3Vwa5UiBD66UFIZsGkoASJfm
        6vuHSRN8m+AlEhJV0t9kkeUPoBu6j/WsG0wkPuDROQND0IASTQEuwSHHmdyxTrJTnuXTd/XY2w35H
        4CPh7TMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcLvn-00ChMJ-1y;
        Wed, 15 Mar 2023 07:52:19 +0000
Date:   Wed, 15 Mar 2023 00:52:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <ZBF5M5R3pDdp/075@infradead.org>
References: <cover.1678777941.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678777941.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 03:34:55PM +0800, Qu Wenruo wrote:
> - More cleanup on RAID56 path
>   Now RAID56 still uses some old facility, resulting things like
>   scrub_sector and scrub_bio can not be fully cleaned up.

I think converting the raid path is something that should be done
before merging the series, instead of leaving the parallel
infrastructure in.
