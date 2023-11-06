Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B737E2187
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 13:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjKFM3e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 07:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFM3d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 07:29:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D114CA6;
        Mon,  6 Nov 2023 04:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=qMcnQ1tXqR9VDQ0YM+Zymw4lbXMGnoh3jWtk0QQ8lmY=; b=IwUml9XmbwoxsSCPj6b8EeVODn
        UqBj7Crjfkg3g0EmfaRjhLi8bGMOm+GqK2KiCqDPYb+uBjJbRQtO/bV6yHct4UkMsIZAbV+REX174
        /3Zx45AYPOKhoAXirQQZ7rJpke+pnGQv8C6McQ4qHrGaV2SffLitBq+Ch/GfEl0f9CIVcGfPpLgo9
        bA/PCY28BMhQBvfq8bkKRahlNqVQ9QNXwXo34rUuNd+/HwiRYdyAxFhklmnhXwUpSrCmP5Md/ZaUK
        6UTi0QQohEDKCuS9h26l/gBkXY4DqUA67t05ovYAaNiQggK3dps1JMCpqJumLHAqQ/+V6oPlZMcKW
        7fTRkrwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qzyjL-00GdVH-1o;
        Mon, 06 Nov 2023 12:29:23 +0000
Date:   Mon, 6 Nov 2023 04:29:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUjcI1SE+a2t8n1v@infradead.org>
References: <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106-fragment-geweigert-1d80138523e5@brauner>
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

On Mon, Nov 06, 2023 at 11:03:37AM +0100, Christian Brauner wrote:
> But why do we care?
> Current code already does need to know it is on a btrfs subvolume. They
> all know that btrfs subvolumes are special.

"they all know" is a bit vague.  How do you know "all" code knows?

> They will need to know that
> btrfs subvolumes are special in the future even if they were vfsmounts.
> They would likely end up with another kind of confusion because suddenly
> vfsmounts have device numbers that aren't associated with the superblock
> that vfsmount belongs to.

Let's take a step back.  Posix says st_ino is uniqueue for a given
st_dev, and per posix a mount mount is defined as any file that
has a different st_dev from the parent.  So by the Posix definition
btrfs subvolume roots are mount points, which is am obvios clash
with the Linux definition based on vfsmounts.

> > > If userspace requests STATX_SUBVOLUME in the request mask, the two
> > > filesystems raise STATX_SUBVOLUME in the statx result mask and then also
> > > return the _real_ device number of the superblock and stop exposing that
> > > made up device number.
> > 
> > What is a "real" device number?
> 
> The device number of the superblock of the btrfs filesystem and not some
> made-up device number.

The block device st_dev is just as made up.

> I care about not making a btrfs specific problem the vfs's problem by
> hoisting that whole problem space a level up by mapping subvolumes to
> vfsmounts.

While I'd love to fix it, and evern more not have more of this
crap sneak in (*cough* bcachefs, *cough*). І'm ok with that stance.
But that also means we can't let this creep into the vfs by other
means, which is what started the thread.
