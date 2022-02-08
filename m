Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F314ADD72
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 16:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381982AbiBHPt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 10:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381971AbiBHPtZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 10:49:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D430C061576
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 07:49:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BF7681F387;
        Tue,  8 Feb 2022 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644335363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xy2aMi1pd0rnRBiSasRkMpi3OQLFepOrr4W1b5lVyTY=;
        b=FM2fuPT8f5nqng5S0so5dwWgxstmgugxOrCqOutUqF2Bvq4LmKNi0I4CN00o+AhZL/6UKD
        dMmBfPo6prUw6o5f8QfusXYGyP+e3e6/EHSXJSaoas6ColTAqKaCIZY2AOB74tMAMYucXi
        h4b9K0Dh2v/YFaYREjXyy/AORHe+VDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644335363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xy2aMi1pd0rnRBiSasRkMpi3OQLFepOrr4W1b5lVyTY=;
        b=9vH17nH8tvAvv5ibVuGyXy++zyXZQpo5/MRMXYRJqz5ATDi8NQTy4nbezyKpNwAqPIBZvJ
        ehEyG8I0ihztoFDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B8D96A3B81;
        Tue,  8 Feb 2022 15:49:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DBACDAB3F; Tue,  8 Feb 2022 16:45:43 +0100 (CET)
Date:   Tue, 8 Feb 2022 16:45:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some misc cleanups and a fix around page
 reading
Message-ID: <20220208154543.GB12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1643902108.git.fdmanana@suse.com>
 <20220204163527.GE14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204163527.GE14046@twin.jikos.cz>
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

On Fri, Feb 04, 2022 at 05:35:27PM +0100, David Sterba wrote:
> On Thu, Feb 03, 2022 at 03:36:41PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > A small set of changes, mostly cleanups, a fix for an error that is not
> > being returned, and adding a couple lockdep assertions.
> > 
> > Filipe Manana (4):
> >   btrfs: stop checking for NULL return from btrfs_get_extent()
> >   btrfs: fix lost error return value when reading a data page
> >   btrfs: remove no longer used counter when reading data page
> >   btrfs: assert we have a write lock when removing and replacing extent
> >     maps
> 
> Added as topic branch to for-next, thanks.

Moved to misc-next.
