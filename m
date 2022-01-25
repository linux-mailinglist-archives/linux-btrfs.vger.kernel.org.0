Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29A949B986
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384829AbiAYRBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 12:01:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348841AbiAYQ7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 11:59:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D3D51210EF;
        Tue, 25 Jan 2022 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643129941;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IY4T84VwgOOMq9qh0f2kKVn60wy2ZjHgQjsDXzqHTtw=;
        b=F/COjr39mwuTQqRHRDbxMOFBM9k6RWTJyn/0So/c7+NGm8uuvqCt19sYOdN163kpTZr9a1
        ZqJvsCIZ+5eR39+Q4wXS81Njov/w1gWDMbjJHKpNOxBosvrPslNgcNbhEYkXfvF4fuMyh8
        SmqfcWZklypQLTsCno4KD2FSddOcAfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643129941;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IY4T84VwgOOMq9qh0f2kKVn60wy2ZjHgQjsDXzqHTtw=;
        b=mf/sQSR8STOzgZ8Y/Y7m2sevbKt2iW2bXukA3W7UydXAGbYFdVnaJMslWgBwshTJf7o6x+
        MiyRDPABrKnaG9Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CD11FA3B83;
        Tue, 25 Jan 2022 16:59:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8674ADA7A9; Tue, 25 Jan 2022 17:58:21 +0100 (CET)
Date:   Tue, 25 Jan 2022 17:58:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: fix log tree cleanup after a transaction abort
Message-ID: <20220125165821.GT14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <f0bed6300fc1dcad405c894640f7140b4a8e04f4.1639743512.git.fdmanana@suse.com>
 <3aae7c6728257c7ce2279d6660ee2797e5e34bbd.1641300250.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aae7c6728257c7ce2279d6660ee2797e5e34bbd.1641300250.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 12:54:15PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V3: Renamed subject (was "btrfs: fix reserved space leak on log tree nodes after transaction abort").
>     Reworked the patch to take into account that after writeback is triggered through log syncing,
>     the range of the extent buffers is removed from the log dirty pages io tree. That was making
>     the mentioned test cases still fail often (just a bit less often however).
>     Also take into account that if fail during the cleanup, we stopped iterating over the tree
>     and leaving some extent buffers not being cleaned up - this was actually often triggered by
>     generic/648.

For the recrod, there's a report
https://lore.kernel.org/all/YeVcOXAsCcA7ijoX@debian9.Home/ that this
patch makes performance worse and that there will be a different patch.
I've removed it from misc-next now.
