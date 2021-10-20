Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5643510A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJTRQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 13:16:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTRQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 13:16:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 91AEA1FD4B;
        Wed, 20 Oct 2021 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634750034;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBLmkCNRhqVJaIxDevHon4N4LjAlkp4H8ugWwOOUsTE=;
        b=syi8UIpQGezeh2MnRnpYtXNbCHbq2AIDh7XchSJMk9xy1tqs2nRmkRqLXhCBgXU4UW1HkM
        udQmRmPAYs6HoRg4kZeqBjgFKwz6c8DPoJ8cVZFHoUg+uG8ibAaMYM4h9rb6Vwnfr8WHP0
        MBo1T8YHxhBYziRIfgLRUZBvY76o9xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634750034;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBLmkCNRhqVJaIxDevHon4N4LjAlkp4H8ugWwOOUsTE=;
        b=cKJq12QNaZpfX5G+plywzzRtn+h5cCYRscASg0QLmgkO52mA9++rJOyEjiJsIDqBH8oLX2
        8g9HxTlRvf7HeuAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8ABD2A3B81;
        Wed, 20 Oct 2021 17:13:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 636FBDA7A3; Wed, 20 Oct 2021 19:13:26 +0200 (CEST)
Date:   Wed, 20 Oct 2021 19:13:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: move btrfs_super_block to
 uapi/linux/btrfs_tree.h
Message-ID: <20211020171326.GB30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211019112925.71920-1-wqu@suse.com>
 <20211019112925.71920-3-wqu@suse.com>
 <20211019161033.GV30611@twin.jikos.cz>
 <8e567e7b-e6ef-603e-c376-afd68bfa152c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e567e7b-e6ef-603e-c376-afd68bfa152c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 08:19:30AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/10/20 00:10, David Sterba wrote:
> > On Tue, Oct 19, 2021 at 07:29:25PM +0800, Qu Wenruo wrote:
> >> Due to the fact that btrfs_tree.h contains all the info for
> >> BTRFS_IOC_TREE_SEARCH, it's almost the perfect location of btrfs on-disk
> >> schema.
> >>
> >> So let's move struct btrfs_super_block to uapi/linux/btrfs_tree.h,
> >> further reducing the size of ctree.h.
> >
> > The definitions of tree items are in the public header due to the search
> > tree ioctl, but why do you want to make superblock public? Ie. what user
> > space tool is going to use it?
> >
> 
> Well, for super block I'd say any user space tool can directly see it.
> 
> My main objective here is to move all on-disk format to uapi.

Why? You sent such patches in the past, I need to read again what we
discussed but I don't think we should put everything to the UAPI
headers.
