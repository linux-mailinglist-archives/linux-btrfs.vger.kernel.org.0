Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D650E70E264
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 18:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbjEWQaL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjEWQaH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 12:30:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE4DD
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fPH9D92LiVgDrmbDXkeNFIIImZlg9QrF7WTmo1VWrAs=; b=HN53Qu5b+v9hBAQPqazNpZVoX9
        cjPSxKYibk+H6PopxbfF9eh36WbPQL/YYXA9d4Vtc9f+QgEXqNszUgIKYPJEcfc5ncs5rbe+6zpjL
        8Fscg4uxLcPUHFbDYy0mKzakpC5RikLBsfqkJc5aptlamOf77snJB/YPV6wOh5OsUQgpMNazq7vaD
        91HUAHgT3edlRbrKFIqh8eZU+kec8th18MEshx7PlhvYK4jBxQOp+bYMxb6ONagf/dXs4MOr1341R
        LJNyNwG2eBMxmsQKCaSB1CWQvXS+j0evsjcagZiq0Nea4VKNMCs04Rz5oxZGOg7kKd3Sz7O3jo8ti
        oQJ0/V4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Utg-00AntN-0k;
        Tue, 23 May 2023 16:30:04 +0000
Date:   Tue, 23 May 2023 09:30:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: streamline fsid checks in alloc_fs_devices
Message-ID: <ZGzqDIVyRiDT7PSX@infradead.org>
References: <cover.1684826246.git.anand.jain@oracle.com>
 <5113dde5d6f756818885c39bc8ec6f5b8e45ae54.1684826247.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5113dde5d6f756818885c39bc8ec6f5b8e45ae54.1684826247.git.anand.jain@oracle.com>
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

On Tue, May 23, 2023 at 06:03:16PM +0800, Anand Jain wrote:
> +	ASSERT(!(fsid == NULL && metadata_fsid != NULL));

The more readable way to write this would be;

	ASSERT(fsid || !metadata_fsid);

or just throw a 

	ASSERT(!metadata_fsid);

into the else branch of the if (fsid) check.

> +	if (fsid){

missing whitespace before the opening brace.

