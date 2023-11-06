Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF17E22D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 14:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjKFNFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 08:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjKFNFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 08:05:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54873BD
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 05:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2531C433C9;
        Mon,  6 Nov 2023 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699275951;
        bh=ezjRNz36YPeF/BTqJXA0UO74QbjRLxn+r/wcNsolT+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjpR4oWzNvlwKDQ+AO6TdkFR+N4vQ7oqjQyKM2ft4f4pRzV8gVvojWbtfeZQFW9is
         hx1OsboYheS9qF/boy1n6uy6X7qAVNKE9ZMR5JNheiZ+TMaX9ixEar8NLmUnBHDz93
         wQ7jbb02Q8nm61XBXHa3T8hwphs+p03oSOurU29GMvaze96zgNkuF2JWuKIIQH2WrU
         266fmKN5x6Pmgp61W3WtO9FKtumv8k8rfRKM4h5Pz+kIB+Saa28CwJqYvR4M5GMYeu
         YDYpiyKiLA972OKZws7tvWQITgOkxqbJfXxcDFm6C+ZzNyjNLy6RBagH5rcUekaaPN
         K3C5XxT2IZiSg==
Date:   Mon, 6 Nov 2023 14:05:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-datei-filzstift-c62abf899f8f@brauner>
References: <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUjcgU9ItPg/foNB@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 06, 2023 at 04:30:57AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 06, 2023 at 11:59:22AM +0100, Christian Brauner wrote:
> > > > They
> > > > all know that btrfs subvolumes are special. They will need to know that
> > > > btrfs subvolumes are special in the future even if they were vfsmounts.
> > > > They would likely end up with another kind of confusion because suddenly
> > > > vfsmounts have device numbers that aren't associated with the superblock
> > > > that vfsmount belongs to.
> > > 
> > > This looks like you are asking user space programs (especially legacy
> > > ones) to do special handling for btrfs, which I don't believe is the
> > > standard way.
> > 
> > I think spending time engaging this claim isn't worth it. This is just
> > easily falsifiable via a simple grep for btrfs in systemd, lxc, runc,
> > util-linux.
> 
> Myabe you need to get our of your little bubble.  There is plenty of

Unnecessary personal comment, let alone that I'm not in any specific
bubble just because I'm trying to be aware of what is currently going on
in userspace.

> code outside the fast moving Linux Desktop and containers bubbles that
> takes decades to adopt to new file systems, and then it'll take time
> again to find bugs exposed by such odd behavior.

So what?

Whatever you do here: vfsmounts or any other solution will force changes
in userspace on a larger scale and changes to the filesystem itself. If
you accommodate tar then you are fscking over other parts of userspace
which are equally important. There is no free lunch.

Second, we're not going to shy away from changes just because it takes
long for them to be adopted. That's just not a position for us to take.
