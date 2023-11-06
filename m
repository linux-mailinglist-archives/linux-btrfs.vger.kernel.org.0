Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B572A7E1DD3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 11:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKFKDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 05:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKDu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 05:03:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47522B6
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 02:03:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB58C433C7;
        Mon,  6 Nov 2023 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699265027;
        bh=zqSDVGb3DqGgjuM4pK3W4GvqbV/ZeF3XB2qeBZfY3i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eU7mwfae1zlAXKXyWC7uPN+KKdPz5qxyLroCTLvbV+egcXkSHzsxIMefKPchvvOeK
         ZjMngWoD4qKRAq5fdMa+86yJwK6EPe2johr1eW+3J4XjZ6b+9CyIWfEVK3+os9qB0y
         Nrf5NSk+/0DjnByO8SQx1Q49xnA67tAUYQV/CLkIE7HzRzOdlMArG2I/bQsVyN3Zmm
         v/kmGW7Da+QshN1C1YnJI4dUapKDWmQQ+jmwP1GcxMdgwwnU7ZbwGQOtVntFWPU97T
         KkfvVO1L//CpV3Th+PtEcW9vn5BGxt/CofYW8Qh8RrpXDmpGIUnFMReZkuoNMhkbZf
         dI+vcGOdJyG4A==
Date:   Mon, 6 Nov 2023 11:03:37 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-fragment-geweigert-1d80138523e5@brauner>
References: <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUibZgoQa9eNRsk4@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > I would feel much more comfortable if the two filesystems that expose
> > these objects give us something like STATX_SUBVOLUME that userspace can
> > raise in the request mask of statx().
> 
> Except that this doesn't fix any existing code.

But why do we care?
Current code already does need to know it is on a btrfs subvolume. They
all know that btrfs subvolumes are special. They will need to know that
btrfs subvolumes are special in the future even if they were vfsmounts.
They would likely end up with another kind of confusion because suddenly
vfsmounts have device numbers that aren't associated with the superblock
that vfsmount belongs to.

So nothing is really solved by vfsmounts either. The only thing that we
achieved is that we somehow accommodated that st_dev hack. And that I
consider nakable.

> 
> > If userspace requests STATX_SUBVOLUME in the request mask, the two
> > filesystems raise STATX_SUBVOLUME in the statx result mask and then also
> > return the _real_ device number of the superblock and stop exposing that
> > made up device number.
> 
> What is a "real" device number?

The device number of the superblock of the btrfs filesystem and not some
made-up device number.

I care about not making a btrfs specific problem the vfs's problem by
hoisting that whole problem space a level up by mapping subvolumes to
vfsmounts.
