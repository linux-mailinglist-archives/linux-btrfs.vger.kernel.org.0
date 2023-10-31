Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391DA7DD434
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 18:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjJaRHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjJaRHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 13:07:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56750121;
        Tue, 31 Oct 2023 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gVrSb6ojLUF83IpVsMcphzdsrvPel1nnNKLfkdHef7I=; b=kBk+sF70AvMf4h6sOyGnKsFV6d
        tHWUt/CD6pYYaSSyFRnwOrHRupC3C8o//PQkZwfRy0/DomvCGGZmcNSEWLUhAN3DcQ/HL7PjuPKfA
        b9rG0wO4A36iynTsPQXxzNrlxdOXJjfUSGG3WHBnZ22pRVNycKY7p6d/UEIwQ2/KTgO6tKUYJzOKL
        +2cz8HfZlhu086RD+D0SnndxgBmkuKpGtoni8CLvfqvFaKZFA+1//nXRA9/Q1B1yC3AeVrlvDkLEs
        z/7g2wbMoht7kJLy8mlF9y8r8zGSBm1gS48EJaBQMjfmj1DecpbMYsUtrcwDj0uG1KGMx6xtxqJrG
        r9bGW8/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qxsC1-005oV0-1F;
        Tue, 31 Oct 2023 17:06:17 +0000
Date:   Tue, 31 Oct 2023 10:06:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUE0CWQWdpGHm81L@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-anorak-sammeln-8b1c4264f0db@brauner>
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

On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote:
> So this is effectively a request for:
> 
> btrfs subvolume create /mnt/subvol1
> 
> to create vfsmounts? IOW,
> 
> mkfs.btrfs /dev/sda
> mount /dev/sda /mnt
> btrfs subvolume create /mnt/subvol1
> btrfs subvolume create /mnt/subvol2
> 
> would create two new vfsmounts that are exposed in /proc/<pid>/mountinfo
> afterwards?

Yes.

> That might be odd. Because these vfsmounts aren't really mounted, no?

Why aren't they?

> And so you'd be showing potentially hundreds of mounts in
> /proc/<pid>/mountinfo that you can't unmount?

Why would you not allow them to be unmounted?

> And even if you treat them as mounted what would unmounting mean?

The code in btrfs_lookup_dentry that does a hand crafted version
of the file system / subvolume crossing (the location.type !=
BTRFS_INODE_ITEM_KEY one) would not be executed.

