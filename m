Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868DA4A9D01
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376611AbiBDQgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 11:36:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48820 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiBDQgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 11:36:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E696B1F382;
        Fri,  4 Feb 2022 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643992606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7zosivgpYWiuNQ0ifRajzdabdBqxpC9Kdt/DLIgi1Q=;
        b=PlOWzECJ5u9pS8IZ65/3fkZTopKXsaY55JzC/E+eIa3SBKHvd53bTSKR7Dmte3mngsUF9n
        9oX3vaGICnbXILWUr6wPCit89L07Umeb9JgESOrzXiz4nwC6gfkzdJRJf45h2nM28BcWZ1
        oFcbnAgyFwHqmBl6vp/Yzp/kc05lpe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643992606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7zosivgpYWiuNQ0ifRajzdabdBqxpC9Kdt/DLIgi1Q=;
        b=cHZXCo3O9BOFYVpuNpy1ty5QSN+fvgZT+dwY1cSVipjoe1o7doXD8IrFNKrC6029RT7D6G
        TSA56bo2sOmxS6AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DE121A3B81;
        Fri,  4 Feb 2022 16:36:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E887DA781; Fri,  4 Feb 2022 17:36:01 +0100 (CET)
Date:   Fri, 4 Feb 2022 17:36:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: some minor improvements and cleanups mostly
 around extent logging
Message-ID: <20220204163601.GF14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1643898312.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643898312.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 03, 2022 at 02:55:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This is a mix of small improvements around logging extents, replacing
> extents in a log tree or subvolume tree, while others are more generic
> ones, and some cleanups. They are grouped in the same patchset, but they
> are all independent of each other.
> 
> Filipe Manana (6):
>   btrfs: remove unnecessary leaf free space checks when pushing items
>   btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
>   btrfs: avoid unnecessary computation when deleting items from a leaf
>   btrfs: remove constraint on number of visited leaves when replacing extents
>   btrfs: remove useless path release in the fast fsync path
>   btrfs: prepare extents to be logged before locking a log tree path

Added as topic branch to for-next, thanks.
