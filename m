Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8943FD63
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJ2Ng3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 09:36:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52640 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhJ2Ng3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 09:36:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B775B1FC9E;
        Fri, 29 Oct 2021 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635514439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jl+bk6+eFqkkIxbeVoT6nkNE8xjpi1eRKvfCaKzhgHw=;
        b=hLu4nUYtQggXol6e9hsPeWfj1mijk0IW6t+46XN1ugzXSbJWBMVw2bf+lIEVWuKb/ukmjB
        MIQSTw64OdMlF2lDIk8kxxwvF43u9PTVaPGRI0/uEMIYMVx7ZBQqk8ory4OuG5ylsVc8lk
        IQC9M5nbkUTMf+Urf0E8TuS76Pb6hGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635514439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jl+bk6+eFqkkIxbeVoT6nkNE8xjpi1eRKvfCaKzhgHw=;
        b=dcQDoKfiw5tnAAGMsNnLzyg7nayGOpiAab9xOUxKUnDTx37ugTANyc79efOo3lnHd614BL
        Y/Wi2zkfei/sYSBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AA9A8A3B84;
        Fri, 29 Oct 2021 13:33:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AF194DA7A9; Fri, 29 Oct 2021 15:33:26 +0200 (CEST)
Date:   Fri, 29 Oct 2021 15:33:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Hao Sun <sunhao.th@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: INFO: task hung in btrfs_search_slot
Message-ID: <20211029133326.GB20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Hao Sun <sunhao.th@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACkBjsYV8Xv7Ha-daGhkj+uOK31HSsdt06pgMOyQcYzcxUjSyw@mail.gmail.com>
 <CAL3q7H58SZtvEFn5zRMoMy2iJQsvAvqNEqwmvyhQuh33_H0inQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H58SZtvEFn5zRMoMy2iJQsvAvqNEqwmvyhQuh33_H0inQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 27, 2021 at 04:34:37PM +0100, Filipe Manana wrote:
> On Wed, Oct 27, 2021 at 2:08 PM Hao Sun <sunhao.th@gmail.com> wrote:
> >
> > Hello,
> >
> > When using Healer to fuzz the latest Linux kernel, the following crash
> > was triggered.
> 
> This is the same deadlock you reported 3 weeks ago here:
> 
> https://lore.kernel.org/linux-btrfs/CACkBjsax51i4mu6C0C3vJqQN3NR_iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com/
> 
> There's a fix in the integration branch (David's misc-next branch),
> but it's not yet in any released kernel and not in Linus' tree as
> well:
> 
> https://lore.kernel.org/linux-btrfs/cover.1634115580.git.fdmanana@suse.com/

It'll go to 5.15 pull and the fix is tagged for 5.14 stable so it'll be
in some release in the 5.15-rc1 timeframe.
