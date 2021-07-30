Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF03DB9D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbhG3N5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 09:57:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52570 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhG3N5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 09:57:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1D4B02024F;
        Fri, 30 Jul 2021 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627653448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPT4usxJd+kaQnZME4NRyK66nDEYB5bQxudz5ltsfWw=;
        b=MD6X6jYwQ6xoNdknN1ZBHaJ9UflwHrMdM6ibA8EIITqcxTl40ChrFHvMiVAaTpyjRfFaXe
        MXcJ0k8csBvNbPsGgl0nhypT4fmngYF6zjFlbkvgUE8YEFBxDmU0S1lEfZeovFfoNrEvD7
        8OuZtiJnWD+C9re7TMDMqKyKa5q2kRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627653448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPT4usxJd+kaQnZME4NRyK66nDEYB5bQxudz5ltsfWw=;
        b=cL67+jMWJtMyC3j53+oaGEY4XGZ9CoThNml2Du8W8v031rxtd05ZZLptkrXdWNBpRYePr5
        cPiKu1yYUCkdfQBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 15800A3B88;
        Fri, 30 Jul 2021 13:57:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35906DB284; Fri, 30 Jul 2021 15:54:39 +0200 (CEST)
Date:   Fri, 30 Jul 2021 15:54:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: check/original: detect directory inode
 with nlinks >= 2
Message-ID: <20210730135438.GG5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210718125449.311815-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718125449.311815-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 18, 2021 at 08:54:48PM +0800, Qu Wenruo wrote:
> Linux VFS doesn't allow directory to have hard links, thus for btrfs
> on-disk directory inode items, their nlinks should never go beyond 1.
> 
> Lowmem mode already has the check and will report it without problem.
> Only original mode needs this update.
> 
> Reported-by: Pepperpoint <pepperpoint@mb.ardentcoding.com>
> Link: https://lore.kernel.org/linux-btrfs/162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
