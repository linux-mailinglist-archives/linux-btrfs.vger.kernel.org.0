Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5337A4150A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 21:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhIVTqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 15:46:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39612 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhIVTqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 15:46:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 45FEB20241;
        Wed, 22 Sep 2021 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632339909;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8TT7ViR/EUeH0ixq38KV11ytIRrdbXE4DLm/3lNUX8=;
        b=IenJozwJEY9uEAtgtwCThlxLA8cFbdXIhVoH727UG9TDsry0cEi9dGHvXGtiO8C8uHTBut
        rLFsl7H44vfmCgFvWiEvao91fv6JmooK6q9+Cy/J+n3M2BGPkqAnBaZfNW3jMuZ4c3ZcL3
        Cj33qSVxFl9/U5i/WGYunHJh3+gbaXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632339909;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8TT7ViR/EUeH0ixq38KV11ytIRrdbXE4DLm/3lNUX8=;
        b=pQXCF2BqNua8JVXSiDDwByv35tR15LSPHWJubBfhwZnZnJs92iXgnnY1prSLmyYm/cCSEx
        3sVClHGscU1ajLAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3E01AA3B81;
        Wed, 22 Sep 2021 19:45:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A06DFDA799; Wed, 22 Sep 2021 21:44:56 +0200 (CEST)
Date:   Wed, 22 Sep 2021 21:44:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: assert that extent buffers are write locked
 instead of only locked
Message-ID: <20210922194456.GT9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <7869e87c5d9a7d079510e780ea6bc4a32b952a7b.1632303323.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7869e87c5d9a7d079510e780ea6bc4a32b952a7b.1632303323.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 22, 2021 at 10:36:45AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We currently use lockdep_assert_held() at btrfs_assert_tree_locked(), and
> that checks that we hold a lock either in read mode or write mode.
> 
> However in all contextes we use btrfs_assert_tree_locked(), we actually
> want to check if we are holding a write lock on the extent buffer's rw
> semaphore - it would be a bug if in any of those contextes we were holding
> a read lock instead.
> 
> So change btrfs_assert_tree_locked() to use lockdep_assert_held_write()
> instead and, to make it more explicit, rename btrfs_assert_tree_locked()
> to btrfs_assert_tree_write_locked(), so that it's clear we want to check
> we are holding a write lock.
> 
> For now there are no contextes where we want to assert that we must have
> a read lock, but in case that is needed in the future, we can add a new
> helper function that just calls out lockdep_assert_held_read().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
