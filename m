Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16C446C398
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 20:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhLGT3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 14:29:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33922 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhLGT3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 14:29:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 944CA1FE00;
        Tue,  7 Dec 2021 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638905137;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQwzSqNr8L31JUztsRwesDxDyFjXCJ9c4WMOqSl8pp8=;
        b=wUyJLAG1EBk2syGikHZ+PglUd9iutOPbmHKLA2G6sL5vTYWzlhkWKhh95tYLwXo9VjENsA
        zYkncyjAVRgZ8JV6Gihfs/KDRvx2VjzYtYAfDTO7WgdFkc+kIa+VJuKgKtvl59YK0O1fP8
        2g1FSHp6ZbUaREQ4N0JtcU0v1wD8ywI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638905137;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQwzSqNr8L31JUztsRwesDxDyFjXCJ9c4WMOqSl8pp8=;
        b=0kXaUubZ+o9vdr8vI3lcC2mTWsuaepHRVhvOfNyMD8f9VdcqQ3gI391X4SGcWTY+9GS9Hp
        ws6RuE1IrX2jTVBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8D73AA3B83;
        Tue,  7 Dec 2021 19:25:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90741DA799; Tue,  7 Dec 2021 20:25:22 +0100 (CET)
Date:   Tue, 7 Dec 2021 20:25:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace the BUG_ON() in btrfs_del_root_ref() with
 proper error handling
Message-ID: <20211207192522.GG28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211201115617.144434-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201115617.144434-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 01, 2021 at 07:56:17PM +0800, Qu Wenruo wrote:
> I hit the BUG_ON() with generic/475 test case, and to my surprise, all
> callers of btrfs_del_root_ref() are already aborting transaction, thus
> there is not need for such BUG_ON(), just go to @out label and caller
> will properly handle the error.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
