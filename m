Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB6740BAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 10:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjF1Iik (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjF1IeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 04:34:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D620E3C2D
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lyoDhAtbpyBa8djryiBhV9e4nf
        3rCz2tbiuDWuCXMFVnZDMcpJyRPenm/HlVsZ1xnWNJ4ibI+iyuWQsTLbe9haMFK3Nn2ZwGVCuREXj
        4hWofnCXFR5r0cace6eoZB3r7BFYXzrjs2ouyregX9/DkUfTXcmT7oRgyagSNMJjWm9ma7mGfu7gL
        mxKouOP0Hr/x/iw8ly7BLuFbI3u73aWVSudgGUHNMPxm9hyLuuyWEiJ8i0gJpWTaiD22Dt62UhRu0
        H5OHJK5qoxPm2euZSONoA7en9QJoUdZssjRHkys+PgmG7S/6m+kYpVXhqk+zoqYRF1Xm/Ok+0V9se
        /ua2pDtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEQVH-00FAAD-27;
        Wed, 28 Jun 2023 08:26:19 +0000
Date:   Wed, 28 Jun 2023 01:26:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: raid56: remove unused BTRFS_RBIO_PARITY_SCRUB
Message-ID: <ZJvuq4aABypFr4bi@infradead.org>
References: <65b7602d5baadf1b7102072abc98515322c67892.1687939844.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b7602d5baadf1b7102072abc98515322c67892.1687939844.git.wqu@suse.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
