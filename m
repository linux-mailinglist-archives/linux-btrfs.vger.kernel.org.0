Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756984509BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhKOQg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 11:36:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44028 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhKOQgS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 11:36:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BD1321FD6B;
        Mon, 15 Nov 2021 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636994001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXpx891ReSy/m6d3OgVd5a+80lVA6Bx+wcpCGOcywbA=;
        b=hPpfshLGeCh5r8te/ymnroFNEpOq49sgBZ7mZIY1ITEarpkS0aJD4SJAEXNfHkGDuQU6Ov
        RKrsxuyxtVcg3SuvM10+/BmmOM9HJuxPR7hjgod9ISUSes/oxR9ISzeJHwn4tzj7vjch/s
        ZmsfZgsvLcS6PovkswK9xa4kHlj33s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636994001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXpx891ReSy/m6d3OgVd5a+80lVA6Bx+wcpCGOcywbA=;
        b=HixoUKWj//WsswQplNRq8iXYOGWgoEXvZUm3Yq9IQ/xt1JaBkGiAtMK4xwOiZRKPzzcA0b
        Lk7R5ECyM1ytVuAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B4FDFA3B8C;
        Mon, 15 Nov 2021 16:33:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D751ADA781; Mon, 15 Nov 2021 17:33:18 +0100 (CET)
Date:   Mon, 15 Nov 2021 17:33:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        "S ." <sb56637@gmail.com>
Subject: Re: [PATCH] btrfs-progs: rescue: introduce clear-uuid-tree
Message-ID: <20211115163318.GL28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        "S ." <sb56637@gmail.com>
References: <20211111024138.41687-1-wqu@suse.com>
 <3644e6ea-1756-5fd0-106b-2d130f6a2c2b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3644e6ea-1756-5fd0-106b-2d130f6a2c2b@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 08:37:24AM +0200, Nikolay Borisov wrote:
> On 11.11.21 г. 4:41, Qu Wenruo wrote:
> > [BUG]
> > There is a bug report that a corrupted key type (expected
> > UUID_KEY_SUBVOL, has EXTENT_ITEM) causing newer kernel to reject a
> > mount.
> > 
> > Although the root cause is not determined yet, with roll out of v5.11
> > kernel to various distros, such problem should be prevented by
> > tree-checker, no matter if it's hardware problem or not.
> > 
> > And older kernel with "-o uuid_rescan" mount option won't help, as
> > uuid_rescan will only delete items with
> > UUID_KEY_SUBVOL/UUID_KEY_RECEIVED_SUBVOL key types, not deleting such
> > corrupted key.
> > 
> > [FIX]
> > To fix such problem we have to rely on offline tool, thus there we
> > introduce a new rescue tool, clear-uuid-tree, to empty and then remove
> > uuid tree.
> > 
> > Kernel will re-generate the correct uuid tree at next mount.
> 
> SHouldn't this be made part of btrfs repair, why do we need specific
> rescue subcom ?

This is a one-shot fix for that we have the rescue subcommand, check
could do a normal pass and verify the tree but that's a bit different
what this patch does and requiring --repair goes opposite to what we
recommend to do.
