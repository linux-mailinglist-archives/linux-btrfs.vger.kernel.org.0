Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E05429242
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbhJKOm4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 10:42:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33382 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbhJKOlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 10:41:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 45C431FEBE;
        Mon, 11 Oct 2021 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633963190;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Y9oXQAVEsZjooMZ/qa7v2srkcqQAXBiXTTJi26juSk=;
        b=i3aC/U6nmKALtXP+78fReBSmctLEgYcEjt7vDGREcqqJBwwZ+Oi/oomIL4dcdCddkAlIak
        hw1abT+xBUY+JrEiMOxpF+uQIT4Q4yfgJ+6cEQ62BCncQrAIN5Fsxc9JFgCV+v1hMK98d6
        RNaAmrAqcSoJXVEHSKOkZoTZVGfW8v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633963190;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Y9oXQAVEsZjooMZ/qa7v2srkcqQAXBiXTTJi26juSk=;
        b=29aqZa5ZEwLzO/q84+HO7fcA5kzztsko68Kh+D3EfncpjqVUEMypAuxbUv82h9Ix9xpcmW
        5N6r9JGyh9eWwgCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3DB1AA3B83;
        Mon, 11 Oct 2021 14:39:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41A37DA781; Mon, 11 Oct 2021 16:39:27 +0200 (CEST)
Date:   Mon, 11 Oct 2021 16:39:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs-progs: mkfs: make sure we can clean up all
 temporary chunks
Message-ID: <20211011143927.GL9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
 <20211011140517.GI9286@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011140517.GI9286@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 04:05:18PM +0200, David Sterba wrote:
> On Mon, Oct 11, 2021 at 08:06:47PM +0800, Qu Wenruo wrote:
> > There is a bug report that with certain mkfs options, mkfs.btrfs may
> > fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
> > warning about multiple profiles:
> > 
> >   WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> >   WARNING:   Metadata: single, raid1 
> > 
> > The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m dup
> > -d dup".
> > 
> > It turns out that, the old _recow_root() can not handle tree levels > 0,
> > while with newer free space tree creation timing, the free space tree
> > can reach level 1 or higher.
> > 
> > To fix the problem, Patch 2 will do the proper full tree re-CoW, with
> > extra transaction commitment to make sure all free space tree get
> > re-CoWed.
> 
> The extra commit breaks assumptions of test misc/038 that looks up the
> backup roots in particular slot(s). I already had to fix it once due to
> the additional commit with free space tree. Now it broke again, the test
> is too fragle, I'm not sure we want to keep doing the whack-a-mole.

I've check it with the v2, no change, so I'll disable the test.
