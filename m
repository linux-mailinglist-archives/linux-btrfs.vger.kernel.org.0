Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE91F7E04AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjKCO25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 10:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377781AbjKCO2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 10:28:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA27D4B;
        Fri,  3 Nov 2023 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NIf8zlY6PjIaojz132l2Pfk7Nfa0H/Q3a4IA6INoOig=; b=vFUGkf0orV5GzxqUi8y84O4ou3
        dLF1f+JLzI0EM+b/JaOQ8+TqPl+VsRmuZZcfcCcF6WnhYHjfCxfIYtaM5hF7vOYo+ao3o7ZNDgHL3
        9y7iou5jte1/RwwuFOw63r2/g2YpnVSbBTl8Z999utnDQXJgMbgxRLGH4+4HSBh7MjSsHrfBkHHhY
        Ok9mTJuerLlHRUtwRzRgwoN1lINxhdZ2D8PAUsBYzQzVvYofHBeO3S6N/aRAeZlyF5dPfObPQTrb/
        VSer0a24by8WqOL4AOskdnPWU+kvJTPW6lDC6JQHU2VU2V4miUdBIoGCFb+a58WIgHtPC68CjVHGC
        xhCgMIrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyvAA-00BZmd-0p;
        Fri, 03 Nov 2023 14:28:42 +0000
Date:   Fri, 3 Nov 2023 07:28:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUUDmu8fTB0hyCQR@infradead.org>
References: <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-schafsfell-denkzettel-08da41113e24@brauner>
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

On Thu, Nov 02, 2023 at 12:07:47PM +0100, Christian Brauner wrote:
> But at that point we really need to ask if it makes sense to use
> vfsmounts per subvolume in the first place:
> 
> (1) We pollute /proc/<pid>/mountinfo with a lot of mounts.
> (2) By calling ->getattr() from show_mountinfo() we open the whole
>     system up to deadlocks.
> (3) We change btrfs semantics drastically to the point where they need a
>     new mount, module, or Kconfig option.
> (4) We make (initial) lookup on btrfs subvolumes more heavyweight
>     because you need to create a mount for the subvolume.
> 
> So right now, I don't see how we can make this work even if the concept
> doesn't seem necessarily wrong.

How else do you want to solve it?  Crossing a mount point is the
only legitimate boundary for changing st_dev and having a new inode
number space.  And we can't fix that retroactively.

