Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB8727FB6
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjFHMPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHMPo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:15:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7C1AE;
        Thu,  8 Jun 2023 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+5P5Qfz6dDNh3x75oBOMYmthUbAwJzhaUllJDTqO3KQ=; b=S3wD3ZNwtWOv6K2YlO0nV/45lQ
        tTFYLxWT0d5JrP+uCKAd+0UPJzFQZjqUzatvbqFxAgV16vszlLD6ezBFXuF7yO0alVNBxVbyGI8ml
        1DixMf4uu3TD0Be61vntJL5qY28YGv3h36Mgz4Lxa2lRIjGG+kiC1cLpFG+noR4y9WksKHd1bZU4Q
        odnM4bMeSFz5KUzQp1O7knuBWjzTLuIXMMR3U/e7R2CbbxjN+6V+b9mp2H8b6pIZMNZRyYl30whU+
        bLVb6prHHSx3CKpn7purn2sZCK+yjb2arYQVKvpxqa02HgBDNEWLsIRtLSSVQ6AlSUVILeJ1eVReF
        XA11k34w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7EYJ-009HO7-08;
        Thu, 08 Jun 2023 12:15:43 +0000
Date:   Thu, 8 Jun 2023 05:15:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all
 page caches are dropped
Message-ID: <ZIHGb+KyYW72MVzp@infradead.org>
References: <20230608114836.97523-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608114836.97523-1-wqu@suse.com>
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

On Thu, Jun 08, 2023 at 07:48:36PM +0800, Qu Wenruo wrote:
>  	echo 3 > /proc/sys/vm/drop_caches
> +	# Above drop_caches doesn't seem to drop every pages on aarch64 with
> +	# 64K page size.
> +	# So here as a workaround, cycle mount the SCRATCH_MNT to ensure
> +	# the cache are dropped.
> +	_scratch_cycle_mount

The _scratch_cycle_mount looks ok to me, but if we do that, there is
really no point in doing the drop_caches as well.
