Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8F6CF706
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjC2XZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjC2XZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:25:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B276659D0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ZRcWXKbSEbhj1YsHd/wy/nbgBgvx9SOftOcYWwYwSU=; b=fKYlXlZ8vjC2O2IPSqABl3ykyh
        K5Gy7Ut5z0eTFFWrdZXyPUARI2lrsScUK0koH5c4KzPIQcmdvDYkK5s2JAz73MYd2LqB8kovzPOv/
        IUPSp4BmkMI2fnVh10wtE0avWYMXFaoXf6golyUBsHiGPPVhrei4H1SIGR6oqHqG4oKtoYwESFDBA
        E3wWT4iE0SXAgHbmeqUr59QqTb44g59VQIGDLmvrDs+G39/48qopeTYUvPHplJIKM++l1KPLIDbZu
        9qO428fJBeQkjO8x4oSb7HAJcjzCfhBbxvQ1wMiQBAgC+yKGYV12VUIbxU7dUQdru1Dh2B62lPwwo
        rtwwptgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfAn-0023Me-1j;
        Wed, 29 Mar 2023 23:25:45 +0000
Date:   Wed, 29 Mar 2023 16:25:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v7 01/13] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Message-ID: <ZCTI+e3obkkHbVNG@infradead.org>
References: <cover.1680047473.git.wqu@suse.com>
 <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1680047473.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1680047473.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 29, 2023 at 07:56:08AM +0800, Qu Wenruo wrote:
> +	ret = btrfs_validate_super(fs_info, sb, -1);
> +	return ret;

Just return directly here instead of assining to ret just to return it
in the next line.

Otherwise this looks good minus the __bio_add_page nit:

Reviewed-by: Christoph Hellwig <hch@lst.de>
