Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87544509D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhKOQog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 11:44:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44810 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhKOQog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 11:44:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E03331FD67;
        Mon, 15 Nov 2021 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636994499;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edRIksyfmuo/3HIk/46AcCi9hYVwcV0GkxGBEcmF+Gs=;
        b=EQ0qgBWTAVXMQxt0XX4R4d/eobSPbIprZzhjG+OzXCDseHfcyKwkwqZ3ZHtO04bPBFJNGX
        PDcbY0O4DeVqNrV7DxZQ69Gbtene4JAIz69GEvW2R9+14lhjcXlVKsOvTRwGy8ausMPDE3
        Ws1Gygs/UGbyyymF+casxeziUreW4SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636994499;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edRIksyfmuo/3HIk/46AcCi9hYVwcV0GkxGBEcmF+Gs=;
        b=GPS1ywVef6bXeagEWrp6I22l+tVnzNaqqrbBoXMBpomRh/xz2d98/UUMaBIFpFo9e2Qldg
        mUO161g3s4ICZEAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D71D2A3B87;
        Mon, 15 Nov 2021 16:41:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04C16DA781; Mon, 15 Nov 2021 17:41:36 +0100 (CET)
Date:   Mon, 15 Nov 2021 17:41:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, "S ." <sb56637@gmail.com>
Subject: Re: [PATCH v2] btrfs-progs: rescue: introduce clear-uuid-tree
Message-ID: <20211115164136.GM28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, "S ." <sb56637@gmail.com>
References: <20211111081433.95253-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111081433.95253-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 04:14:33PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report that a corrupted key type (expected
> UUID_KEY_SUBVOL, has EXTENT_ITEM) causing newer kernel to reject a
> mount.
> 
> Although the root cause is not determined yet, with roll out of v5.11
> kernel to various distros, such problem should be prevented by
> tree-checker, no matter if it's hardware problem or not.
> 
> And older kernel with "-o uuid_rescan" mount option won't help, as
> uuid_rescan will only delete items with
> UUID_KEY_SUBVOL/UUID_KEY_RECEIVED_SUBVOL key types, not deleting such
> corrupted key.
> 
> [FIX]
> To fix such problem we have to rely on offline tool, thus there we
> introduce a new rescue tool, clear-uuid-tree, to empty and then remove
> uuid tree.
> 
> Kernel will re-generate the correct uuid tree at next mount.
> 
> Reported-by: S. <sb56637@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks. I'm not happy that we have to add such fixups
but it's still better than not allowing the mount when the workaround is
simple and safe.
