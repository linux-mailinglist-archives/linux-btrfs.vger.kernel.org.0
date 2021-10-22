Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770314378B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhJVOJ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 10:09:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42226 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhJVOJv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 10:09:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 91F591FD3D;
        Fri, 22 Oct 2021 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634911651;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4pgo+pj3i0YxQtFF/OUQpKatQDfgv1ZDqlHEpfUK++g=;
        b=l+uvgkfZz313CGeIvYHLTP/QC9qVELEI4T5IwQJttJ5L77S0Ts1W4bkfeyhir4IM6W+xZ+
        WYsnETn0auh2pKUQtzYNCjvBbIJ0ywjGrzA+327+GkLxTW/SzivOjo3Y9QuSbLoUeC6WY1
        Ic+sEHUQZPXXOxCJUXB81U3xPHkiYls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634911651;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4pgo+pj3i0YxQtFF/OUQpKatQDfgv1ZDqlHEpfUK++g=;
        b=MgF/SrBAUMjpDUGkermcqc/lzZ7UNuNPM5apEL78rzf4IzIqPi6BdSTLboOvdCYFYi5hhl
        CaY+3EogMo7f7NBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8B987A3B83;
        Fri, 22 Oct 2021 14:07:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E633DA7A9; Fri, 22 Oct 2021 16:07:02 +0200 (CEST)
Date:   Fri, 22 Oct 2021 16:07:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     IB Development Team <dev@ib.pl>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: send/receive backward compatibility question
Message-ID: <20211022140701.GJ20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, IB Development Team <dev@ib.pl>,
        linux-btrfs@vger.kernel.org
References: <7df25e10-df12-0581-c8ce-fa2387001d57@ib.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df25e10-df12-0581-c8ce-fa2387001d57@ib.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 02:05:25PM +0200, IB Development Team wrote:
> Man pages
> 
> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-send
> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-receive
> 
> do not say anything about kernel versions required on sending/receiving 
> side.
> 
> Is possible to do btrfs send/receive between systems with different 
> kernel versions, i.e. sender with newer linux kernel 5.10 (btrfs-progs 
> v5.10.1, debian 11) and receiver with older linux kernel 4.19 
> (btrfs-progs v4.20.1, debian 10)?

The compatibility level hasn't changed for a long time, so in general it
should be fine to use older kernels and progs.
There were some small updates eg. fixing chmod and capabilities, with an
intermediate workaround, so this could be a (fixable) problem.

> Does "btrfs receive" protect against applying incremental snapshot diff 
> in case it's not compatible with btrfs FS on receiver or admin must take 
> care of compatibility checks "manually"?

I'm not aware of any such checks that would be needed. I think there
were some problems with SElinux enabled on the receiving side, so I'd
expect this sort of problems and not inside the send/receive protocol
itself.

An update to the send protocol is underway so the question of
compatibility will become important.
