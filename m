Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0B6BAA14
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 08:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCOHy1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCOHyY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 03:54:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA682364A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 00:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M8tSe1/RU293ZxRte6ylh20wp+iOj/rzv3QbbtW2DXY=; b=VPStZSvvgbhkH6y5WIWaJYWDHB
        /96UQgV5B08mgcokeAlYN3wmQQSyrv2g5p3Xf5g/Z9k9sujYonUtjICfy5YSZOMB0RsAVkwdObPoI
        MNptfI1xqwoKPB8HdT5V2HmFpnPc1fAt+W6sbFAWThpmtxEW4Ren9nD8Q0g7goYRbleXez5X8hziH
        bPn4TOevqrQWneHgo6WxdCm8WqxFA+e3iTPckwS9j/sUwKRyMRd6Dir+UXQaS4xKAUNb/HGAi5hRs
        Dg0FxoY2NgasnLiYz7ud1K/6KYrJAW9Rzoa+HQfUKOTVfn25Wg8mzaYlvk4XHUGxAezOYepkOvn0O
        p8TFoxkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcLxn-00ChUa-07;
        Wed, 15 Mar 2023 07:54:23 +0000
Date:   Wed, 15 Mar 2023 00:54:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Message-ID: <ZBF5r3itXwDKCsA8@infradead.org>
References: <cover.1678777941.git.wqu@suse.com>
 <27af1ebdc7a7048895be3eaccd3fb437337e1830.1678777941.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27af1ebdc7a7048895be3eaccd3fb437337e1830.1678777941.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> +	 * @inode can be NULL for callers who don't want any advanced features
> +	 * like read-time repair.
> +	 * In that case, @fs_info must be properly initialized.
> +	 */
>  	struct btrfs_inode *inode;
> -	u64 file_offset;
> +
> +	union {
> +		/* If @inode is initialized. */
> +		u64 file_offset;
> +
> +		/* If @inode is NULL. */
> +		struct btrfs_fs_info *fs_info;
> +	};

Ugg.  Let's not go into too crazy unions here that make the code
alsmost impossible to use correctly.  If we want to get away without
the inode we just need an extra unconditional fs_info field, which
is what most users of ->inode actually use.  I can take care of that.
