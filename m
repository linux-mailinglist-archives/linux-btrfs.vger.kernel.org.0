Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069DE7DCD04
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 13:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbjJaMWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJaMWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 08:22:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1D49F;
        Tue, 31 Oct 2023 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F1pKAr/THK/HWYDp2/B5vQtbVvy2Ha3J/TQ3V/uaj9g=; b=unZbxOls7l1HJf5GUqy6GKPxmm
        3BXVEw5H9fqQzfPlxtBUl3568xURrVvUwFm1jKBL2TAr7su+ITWX/MO1hHnWyTWEjup2H1HV4IAiz
        JnqQNg0zpI00NG/DmywdGkUX5j5Eej3OGzDVXQjwQvQnJTP2UHfy7Tq6+7CnDtgat+Cw9GniuV1eX
        hcbKbUmem8fA2bJpCcegNv5nmsmUWEB+ORup0ikMtEYFZsNsS4U0kgPVBPSyo1dOTbNAlYgn9a/Ls
        DpwZxcqTp5jbOyH3TmEJEb1FGWmytLUQImvvmGgM8pwI7A/zTR3IfiDioiQHB5nD5AKN69fwO4e0o
        yFgmviHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qxnle-005GcT-1E;
        Tue, 31 Oct 2023 12:22:46 +0000
Date:   Tue, 31 Oct 2023 05:22:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUDxli5HTwDP6fqu@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 01:14:42PM +0100, Christian Brauner wrote:
> What happens in the kernel right now I've mentiond in the mount api
> conversion patch for btrfs I sent out in June at [1] because I tweaked
> that behavior. Say I mount both subvolumes:
> 
> mount /dev/sda -o subvol=subvol1 /vol1 # sb1@vfsmount1
> mount /dev/sda -o subvol=subvol2 /vol2 # sb1@vfsmount2
> 
> It creates a superblock for /dev/sda. It then creates two vfsmounts: one
> for subvol1 and one for subvol2. So you end up with two subvolumes on
> the same superblock.
> 
> So if you mount a subvolume today then you already get separate
> vfsmounts. To put it another way. If you start 10,000 containers each
> using a separate btrfs subvolume then you get 10,000 vfsmounts.

But only if you mount them explicitly, which you don't have to.

> Or is it that you want a separate superblock per subvolume?

Does "you" refer to me here?  No, I don't.

> Because only
> if you allocate a new superblock you'll get clean device number
> handling, no? Or am I misunderstanding this?

If you allocate a super block you get it for free.  If you don't
you have to manually allocate it report it in ->getattr.
