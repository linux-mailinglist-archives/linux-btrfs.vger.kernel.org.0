Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B965D3B8337
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhF3Nfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:35:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhF3Nfq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:35:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0453122024;
        Wed, 30 Jun 2021 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625059997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGP6Wi2w9cprBTP1ygW0VW5BUbxCuoakNytRCup/SUc=;
        b=uEz+mZ5Gj4bjEM1sRvV0crMKUUhsiBApY6hYo2v6S2aHulX7eAVlfkMzw6kQ3cXNTpKVD5
        esAUDl/Ha7NqixJE8eqEbbmP3J0h10+YNtiJbClhrdyYlGtyjQ7sHNCrxJp2jj1WzbniUx
        Bpv1H0Pyv0oXahbjIbwShD1/2dKEAmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625059997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGP6Wi2w9cprBTP1ygW0VW5BUbxCuoakNytRCup/SUc=;
        b=q3uPOc5bGdy3erGatsoBhce0Jd4qq+N58w/o81YZYgiTZX6v3MRHm9hmk6ifljMmpCytA0
        mmi8mL9rSi+sdnAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F1C4BA3B99;
        Wed, 30 Jun 2021 13:33:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EBC97DA7A2; Wed, 30 Jun 2021 15:30:46 +0200 (CEST)
Date:   Wed, 30 Jun 2021 15:30:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
Message-ID: <20210630133046.GO2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210628101637.349718-4-wqu@suse.com>
 <20210630131640.GM2610@twin.jikos.cz>
 <43550620-f6b6-aec9-9315-ca50cfbbac9b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43550620-f6b6-aec9-9315-ca50cfbbac9b@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 30, 2021 at 09:26:20PM +0800, Qu Wenruo wrote:
> > Is there a way to list such subvolumes from progs?
> 
> No, root with 0 ref will not show up in "btrfs subv list".

We might need one then, but I'll read the full report, maybe it's a
one-off bug.

> In fact unless we pass @check_ref = false, btrfs_get_fs_root() won't 
> return such ghost root at all.

In progs the subvolumes are searched directly by the key, so this
(kernel function) is not relevant.
