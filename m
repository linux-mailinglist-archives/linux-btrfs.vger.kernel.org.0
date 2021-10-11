Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921F4298E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhJKV3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 17:29:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhJKV3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 17:29:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2137D1FEF6;
        Mon, 11 Oct 2021 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633987672;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s6ZJu1et55W9GdtXFoxupmNHG0b7XkGOdyjr+6udjJE=;
        b=gw8p2TCwfz5IzCgo5mThFQplo4d6gqhnVD0sdCCeEmkBFrE7DZPGzjiev5jDTLRK97SvuZ
        oJ/0oxz/RObAob5QkkLK2vZ5kp3hJGVhpso1yI8gL1+QdZr+tGDQK4RZZhUyhHiHxYBV8f
        IcrcrmlxfnqHnMu6xygXd3x6aDx0Zg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633987672;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s6ZJu1et55W9GdtXFoxupmNHG0b7XkGOdyjr+6udjJE=;
        b=pXiNi0LRWCtSONZanTYv1MA26EWnF4DGQsnnvKVaOCFswEbiOJG+V/EwDtbrxk78ps/blq
        HFxa+4F41SDV1LAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1987BA3B83;
        Mon, 11 Oct 2021 21:27:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1DB9DA781; Mon, 11 Oct 2021 23:27:28 +0200 (CEST)
Date:   Mon, 11 Oct 2021 23:27:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs fixes for 5.15-rc6
Message-ID: <20211011212728.GU9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1633976241.git.dsterba@suse.com>
 <CAHk-=whyP7conp58OoJA5wjWdMf8BBek3vw0C3n9HBOw8BHZuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whyP7conp58OoJA5wjWdMf8BBek3vw0C3n9HBOw8BHZuw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 12:18:12PM -0700, Linus Torvalds wrote:
> On Mon, Oct 11, 2021 at 11:40 AM David Sterba <dsterba@suse.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc5-tag
> 
> I see the 'for-5.15-rc5' _branch_, but there is no tag there.
> 
> Did you forget to push that out?

Ah sorry, yes, I even forgot to create the tag. Now it's there.
