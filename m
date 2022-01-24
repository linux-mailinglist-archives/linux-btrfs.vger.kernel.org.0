Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F234985E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbiAXRIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 12:08:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40584 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiAXRIo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 12:08:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D7B1F1F37D;
        Mon, 24 Jan 2022 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643044122;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DkioVPKgDZBj807NWgJrcHQo10Sc0jtmUGirysRvMuk=;
        b=v5/9qE4WbZAsAFOEbiq4xLFD0FvsFOU5SaT+y7FwStKYafbaUsJi0PbWQaL0s6wdeH09Wv
        +8iMoUw+ngLL4HdY6RnDpuoXo14aYIHRJ9mTWaDAhCurYji2Es+Ir+G2s1ypcxN/tHC78r
        xz8WqmB7MIsV71jvxDO2TcT0wpP2bXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643044122;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DkioVPKgDZBj807NWgJrcHQo10Sc0jtmUGirysRvMuk=;
        b=eEBjhUsoiaTJWxq6piMwbVefDL6iecyHbfVl+ljLKwHX91JJ4gLI+h+SP1biDHPGihFuCt
        oM7klHDB2JDitlDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CD161A3B81;
        Mon, 24 Jan 2022 17:08:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E41A4DA7A3; Mon, 24 Jan 2022 18:08:02 +0100 (CET)
Date:   Mon, 24 Jan 2022 18:08:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add back missing dirty page rate limiting to
 defrag
Message-ID: <20220124170802.GA14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <3fe2f747e0a9319064d59d051dc3f993fc41b172.1642698605.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe2f747e0a9319064d59d051dc3f993fc41b172.1642698605.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 05:11:52PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A defrag operation can dirty a lot of pages, specially if operating on
> the entire file or a large file range. Any task dirtying pages should
> periodically call balance_dirty_pages_ratelimited(), as stated in that
> function's comments, otherwise they can leave too many dirty pages in
> the system. This is what we did before the refactoring in 5.16, and
> it should have remained, just like in the buffered write path and
> relocation. So restore that behaviour.
> 
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
