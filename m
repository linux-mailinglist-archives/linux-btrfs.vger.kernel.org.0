Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B572D902
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 07:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbjFMFRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 01:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFMFRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 01:17:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA8E78
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 22:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IrkyZ2l6feA14TmqW8ByGm4qQKANmdP+xQdjTwmwPQw=; b=w2jfBplYVi5M8yvnBZDy7NN+2i
        jegxZlppuHP2p7ZtfT5L+Fb37ysBj+0uv7JIhz4va5EAP38T4EcrRFn3+L/BHrB8tgg7Mf3vs8gr1
        05AC5h1mZ8FFDxS5qAe4sVMIlrm+wnLcny9TGV9KGEoHxiPxl4B4GZ0vuT9wR8hlhZGErFlV+MznF
        i5lxz4+sm4mJCAHzKq6dRCxq1uJmVZOS0wcUw7Q+hFbj93YXRsCft0Satt/clVW2vGjsuOfDyZTp5
        Wm8/O2s6y9XhyewYNeAS7NmKd6I/so7u0N+hGjHFwVNqlGxswsa+d0WuMLLl1kgccZtN7/tdqWOdW
        sMsag28Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8wPD-006x5H-1J;
        Tue, 13 Jun 2023 05:17:23 +0000
Date:   Mon, 12 Jun 2023 22:17:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Message-ID: <ZIf74wFg7NmvmQxn@infradead.org>
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
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

On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it does
> not directly corresponds to the size of one extent. Instead, this patch
> will limit the allocation size at cow_file_range() for the zoned mode.

Maybe I'm missing something, but that limitation also seems wrong or at
least suboptimal.  There is absolutely no problem in creating a large
allocation in cow_file_range.  btrfs_submit_bio will split it into max
appens size chunks for I/O, and depending on if they got reordered or
not we might even be able to record the entire big allocation as a
single extent on disk.

