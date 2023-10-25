Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072BC7D7102
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbjJYPea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbjJYPea (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 11:34:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01E184;
        Wed, 25 Oct 2023 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MksVKmxFF/LOSGBS+HFtPGWz3xXVQGzCyxDBQuuQye0=; b=1vvnudHqJnQC2ZRqLZXuUJQKXu
        MOM8Uvr1em0IyrUx+dBy1/lwTIa9MZGTdxRufefgB4E6yCGyW/HPHa+wchRz8+PxpFgQ4ZhZ4Bxkm
        sNxNMZV3GLC/UoVraFhcbpAfGALv92E6KKkLZzhR1njbh26PX8oPn9v2suBYfJCmy/ZmDK4m9j6j/
        WR4bpU3oa9Y5+g3ezoGqBA6VoLmzmuUKS7pybaevGfvuMOSrvPt2623BgDKuPaRnBnY9FjrXtFzc9
        S+stIgS0RMgRTh0JgIvthZypT0KUBtl91ibHKKRwDcony+uM48tXtHqN8w4l54We5+Wzf/SlKddKy
        NRsqpAtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qvftl-00CdCL-1L;
        Wed, 25 Oct 2023 15:34:21 +0000
Date:   Wed, 25 Oct 2023 08:34:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTk1ffCMDe9GrJjC@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135048.36153-1-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 25, 2023 at 04:50:45PM +0300, Amir Goldstein wrote:
> Jan,
> 
> This patch set implements your suggestion [1] for handling fanotify
> events for filesystems with non-uniform f_fsid.

File systems nust never report non-uniform fsids (or st_dev) for that
matter.  btrfs is simply broken here and needs to be fixed.
