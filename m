Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867704ADD6A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381989AbiBHPsn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 10:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381982AbiBHPsi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 10:48:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964CBC061578
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 07:48:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 56FD71F383;
        Tue,  8 Feb 2022 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644335315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oBeSXjK8MJli/c3VSshyaSEEJxj3qMFX7CAtPyQqvU=;
        b=O5F01C2GXbO4/Ybi13WCPxdR/3R102bQ7IZsSqoNdMmOK6z9G4Drs0V58+BP5mafdy8fiX
        CwVQMNtdTuIJiD151dH1RwJsCeWhftUu45BH2+oQBkd4WCLoltZWPFWoLp8faL6D/ZUGZr
        Y8n/rDLWDHdEpi5wv66Ni7oD94+oLM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644335315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oBeSXjK8MJli/c3VSshyaSEEJxj3qMFX7CAtPyQqvU=;
        b=69vZOxYcDZ2a32tSMvxMudv0vgZyU/faJxWaC4GFrSx3kAnXQ1D1tibJQZ8S2xvOuUIUAT
        Kbq1JtaxLpMV5EAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 51241A3B8D;
        Tue,  8 Feb 2022 15:48:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C4C1EDAB3F; Tue,  8 Feb 2022 16:44:54 +0100 (CET)
Date:   Tue, 8 Feb 2022 16:44:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: some minor improvements and cleanups mostly
 around extent logging
Message-ID: <20220208154454.GA12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1643898312.git.fdmanana@suse.com>
 <20220204163601.GF14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204163601.GF14046@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 05:36:01PM +0100, David Sterba wrote:
> On Thu, Feb 03, 2022 at 02:55:44PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > This is a mix of small improvements around logging extents, replacing
> > extents in a log tree or subvolume tree, while others are more generic
> > ones, and some cleanups. They are grouped in the same patchset, but they
> > are all independent of each other.
> > 
> > Filipe Manana (6):
> >   btrfs: remove unnecessary leaf free space checks when pushing items
> >   btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
> >   btrfs: avoid unnecessary computation when deleting items from a leaf
> >   btrfs: remove constraint on number of visited leaves when replacing extents
> >   btrfs: remove useless path release in the fast fsync path
> >   btrfs: prepare extents to be logged before locking a log tree path
> 
> Added as topic branch to for-next, thanks.

Moved to misc-next.
