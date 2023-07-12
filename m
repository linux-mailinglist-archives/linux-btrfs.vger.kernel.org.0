Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301F9750E86
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGLQ2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjGLQ16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 12:27:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F0E8
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qz+Pr3DicCPGRIg6D9Ew+k8boFpiSp9dQTXZ91Hc2GE=; b=Lmm4ugDDc76wm9DcBioIsv+62O
        3P7u4nzHJ30oBt3I53GawGj0EXLNlF2zSZ5I9g1msoCYf2RhYseb8l5ZprqDoALTJwbs2OcaX1ONN
        2/R5B1hj93GBCdSFKowHs4jQbu84gjR9s94IOIGezUMyVW7HB0gubtVzzIA9vEIq6XjRq2HK3w3a0
        /ymcJHfeL38/Beh6UR/WAdsZolsXd6dTl+p4apa1egU4HZ4lG/zDPAyR/d5Bf6Eop2WYGw6runQ0/
        ZdUXhFw3vD21jQsRMvuhIujLJFeyEbLXyoTXcs0QKIL4RolA/wcT+Cm8RizVDIWC2fHcEEujMk/2o
        eMtK6lww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJch2-000aES-3C;
        Wed, 12 Jul 2023 16:27:56 +0000
Date:   Wed, 12 Jul 2023 09:27:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/14] btrfs: raid56: allow caching P/Q stripes
Message-ID: <ZK7UjPyQ+uQq+Yaj@infradead.org>
References: <cover.1688368617.git.wqu@suse.com>
 <04691a8119ab8612a3f3bc4b003f44dcb189be86.1688368617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04691a8119ab8612a3f3bc4b003f44dcb189be86.1688368617.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 03, 2023 at 03:32:27PM +0800, Qu Wenruo wrote:
> @@ -82,6 +82,13 @@ struct btrfs_raid_bio {
>  	 */
>  	int bio_list_bytes;
>  
> +	/*
> +	 * If this rbio is forced to use cached stripes provided by the caller.
> +	 *
> +	 * Used by scrub path to reduce IO.
> +	 */
> +	bool cached;

You probably want to move this next to the five u8 values for better
packing.
