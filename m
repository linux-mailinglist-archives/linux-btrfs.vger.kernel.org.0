Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A517D8E47
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 07:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjJ0FqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 01:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0FqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 01:46:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3271AC;
        Thu, 26 Oct 2023 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZLuxSxaXZXtmhz2kwBSLdfxZZzeqNXY/Bo+Zf+OGNgA=; b=qyJ8G3O4Dj3NfjB2h8bnWTkn0e
        k/vcocf321CswfwoIv7sEelvUBP9ncfxx91zquNUCO5KhlEt4YCmxepP9oZEi/Gg5C25DTm1c91Vf
        2Yn/SISlJ89tJ6gxEgggXC4RffyUOMHnHulm2zdYxCR2bv46pY2WJ5kR6M/UKdaArYv3I7GsAjuv+
        RGT56YSnzO0jKA2eo9+WvkCMICd7YaHjLiTZ5r/E5uSC/fni/5DTG7IXWso/n1HVsMGhiWrzK6H1u
        QlwhI8a5JAczPxK680Ekvc/csjFlzQe6SmYqacjIKGBDRFPxWqbbiWmtgyNdjmRQR4Fd4PHP6FyBL
        upxl3dNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwFfV-00FdHN-1L;
        Fri, 27 Oct 2023 05:46:01 +0000
Date:   Thu, 26 Oct 2023 22:46:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTtOmWEx5neNKkez@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025210654.GA2892534@perftesting>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I think you're missing the point.  A bunch of statx fields might be
useful, but they are not solving the problem.  What you need is
a separate vfsmount per subvolume so that userspace sees when it
is crossing into it.  We probably can't force this onto existing
users, so it needs a mount, or even better on-disk option but without
that we're not getting anywhere.

