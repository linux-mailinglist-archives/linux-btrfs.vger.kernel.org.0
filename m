Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62A740F6C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbhIQLgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:36:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33258 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbhIQLga (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:36:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 20F501FDC7;
        Fri, 17 Sep 2021 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631878508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgTJE3JK8871/OiYXMrvi15x08K9bk5kopFCvJQ2xYU=;
        b=kAa7OdOeRepVPLRZqx0fMemstfSdZYZ1t9+Qk636VvOcpnB+HWvOmxHcd0Ig5mK7oVqA0p
        1/ACPVwicw6ROWiaT2FaS+dTib/CsJpvLuQRmf1LGeodNYDOlUSSeOsvYmVmQ+SNdn1mEF
        AX3XqzNYi1x/MHqEm20yo0L8WARD75w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631878508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgTJE3JK8871/OiYXMrvi15x08K9bk5kopFCvJQ2xYU=;
        b=7Y7P8yRCbySz4/i0viPah5n+gtn7gjuR54JQu8rpumnmlf0gG4EntJTfL/jBj8lAVQhWHb
        ubNcuTOQDFf6sUDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 19E74A3B81;
        Fri, 17 Sep 2021 11:35:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 93E19DA781; Fri, 17 Sep 2021 13:34:58 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:34:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] btrfs: remove root argument from btrfs_log_inode()
 and its callees
Message-ID: <20210917113458.GP9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1631787796.git.fdmanana@suse.com>
 <03c99e78af748d21af7ff0bb6e915230cf0e3310.1631787796.git.fdmanana@suse.com>
 <20210917105158.GL9286@twin.jikos.cz>
 <CAL3q7H75r83Ou=-k0zMtOmb80Zjh-KNQcFBLcc99S2aYSWRyag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H75r83Ou=-k0zMtOmb80Zjh-KNQcFBLcc99S2aYSWRyag@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 17, 2021 at 12:09:29PM +0100, Filipe Manana wrote:
> On Fri, Sep 17, 2021 at 11:52 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Sep 16, 2021 at 11:32:10AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > The root argument passed to btrfs_log_inode() is unncessary, as it is
> > > always the root of the inode we are going to log. This root also gets
> > > unnecessarily propagated to several functions called by btrfs_log_inode(),
> > > and all of them take the inode as an argument as well. So just remove
> > > the root argument from these functions and have them get the root from
> > > the inode where needed.
> > >
> > > This patch is part of a patchset comprised of the following 5 patches:
> > >
> > >   btrfs: remove root argument from btrfs_log_inode() and its callees
> > >   btrfs: remove redundant log root assignment from log_dir_items()
> > >   btrfs: factor out the copying loop of dir items from log_dir_items()
> > >   btrfs: insert items in batches when logging a directory when possible
> > >   btrfs: keep track of the last logged keys when logging a directory
> >
> > This is a nice description, in all the patches, though I think you could
> > make it less tedious for yourself to just reference the patch with
> > results or a significant change. Up to you.
> 
> It's just copy paste, it doesn't add any significant work for me.
> Btw, I see that patch 2/5 is missing in misc-next, was that intentional?

Unintentional. My bad, sorry.
