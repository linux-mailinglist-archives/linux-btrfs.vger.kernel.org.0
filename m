Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99104E434B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 16:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiCVPqQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiCVPqQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 11:46:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370DEE76
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LfnJPJXX6Hj7YyNbB0EikDREhdLcxrOoIy4HE+L22lY=; b=j9lrKd7O5mjuN9NoiPMmt+lEtg
        EGm9LkGz3J/aHereyCTUt6eX/AB2OsbSa930d5AqVMPLWcy33hYiXo6Gcq7fKg5ZezdnDMKSfQiIJ
        OZeJcqjh9aYghUqkxaqDkf2jdcmaMxcSaa3jTEYdl29ehrVCDKEm3DDa6XzAyUM/HQIgdLLByrwIU
        NN1o4M/f+oNhMcOqGyXrD1PqM7bp2VmG9HEkI6c5dpndqp6iD0P9TFBS8G0CQkr6qc4qp0LiadrMU
        ehMzS/3GXDT9h2WNdFoxYQKTKhuk0RKROmbJFlk/Y4i3qwLj+0ajxmzaGmZQK22YFpMRCIzSkJDZ7
        H064UfJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWggh-00BZGA-Jv; Tue, 22 Mar 2022 15:44:47 +0000
Date:   Tue, 22 Mar 2022 08:44:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
Message-ID: <Yjnu7yWxAforTGQF@infradead.org>
References: <cover.1647248613.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
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

I spent some time looking over this series and I think while it has
some nice cleanups, it also goes fundamentally in the wrong direction.

The way bios are used is that the file systems always builds bios
to it's own limits like extents, lower drivers split them up if needed.
By building the bigger bios in btrfs a lot of the completion handling
gets much more complicated.

I had actually started a series a bit ago to clean up the btrfs bio
usage bottom up, taking advantage of the newer bios interfaces.  I've
spent some of my vacation time last week to finish this off and also
add a few iomap improvements so that btrfs doesn't need to clone the
iomap dio bios above btrfs_map_bio either.  I'll send it out in a bit.
