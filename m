Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134C34313E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJRKBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 06:01:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35770 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRKBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 06:01:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1D9181FD79;
        Mon, 18 Oct 2021 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634551138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/NvlsyL/Z8ArdKHTxpa+6+zFhefN9GSa0Ty1t0FyfE=;
        b=rtj8AwuolCp7It3xaAaHujKaGlpNtGfd9Bk8gkdBwpPHwZgYqWpimp/jZwuO5dw6LJ3bkf
        VgPY/R+M1IZ28qrPZcOD44cElfVvtB/NGvlyNsS6Ba9Hge3sfqTg3wFsPthyP3MBrWfbIp
        D0YJg+oewNEjzj6xTxmbiiuUu2+a0cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634551138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/NvlsyL/Z8ArdKHTxpa+6+zFhefN9GSa0Ty1t0FyfE=;
        b=LiwEp/w3XqfanbhsWwipNFJ0T7Kdt0A6azDg3ch63AqeB4XllqDpn7nSp+vrIowh0mwSMy
        VWDItFaaOHPbiDAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 13F27A3B8A;
        Mon, 18 Oct 2021 09:58:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27CEBDA7A3; Mon, 18 Oct 2021 11:58:31 +0200 (CEST)
Date:   Mon, 18 Oct 2021 11:58:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Neal Gompa <ngompa13@gmail.com>, Jim Davis <jim.epost@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Ubuntu 21.10, raid1c3, and grub
Message-ID: <20211018095830.GE30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        Neal Gompa <ngompa13@gmail.com>, Jim Davis <jim.epost@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+r1ZhgCPB0JYyfC=pRK3mP0_xXGfTW9YpYV0RtYZ_pDMdYCOg@mail.gmail.com>
 <CAEg-Je8Ao8VdZsajsuNheysqM=zjwZ+d9MowhEygfV63f6Qy9w@mail.gmail.com>
 <5dd76af5-60a6-99bf-0d3e-94f162a898cf@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd76af5-60a6-99bf-0d3e-94f162a898cf@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 12:14:55AM +0200, waxhead wrote:
> Neal Gompa wrote:
> > On Sun, Oct 17, 2021 at 6:37 AM Jim Davis <jim.epost@gmail.com> wrote:
> >>
> >> I've been trying some experiments with raid1c3 on a qemu virtual
> >> machine running Ubuntu 21.10.  Choosing btrfs initially as the root
> >> file system during installation works just fine.
> >>
> >> Adding a new virtual disk to btrfs root file system and running btrfs
> >> balance with -mconvert=raid1 and -dconvert=raid1 works too -- the vm
> >> reboots with no problems.
> >>
> >> Adding another new virtual disk to btrfs root file system and running
> >> btrfs balance again, with -mconvert=raid1c3 and -dconvert=raid1c3 and
> >> then rebooting doesn't work: the vm drops into grub rescue with a
> >> cryptic
> >>
> >> error: unsupported RAID flags 202
> >>
> >> message.  Any ideas?
> >>
> > 
> > Support for the raid1cX modes was added to GRUB in GRUB 2.06. The
> > Debian family (including Ubuntu) has not upgraded yet, nor have they
> > backported the support to their custom release of GRUB 2.04 yet. I
> > would suggest filing a bug with Ubuntu to backport the following
> > commit: https://git.savannah.gnu.org/cgit/grub.git/commit/grub-core/fs/btrfs.c?id=495781f5ed1b48bf27f16c53940d6700c181c74c
> > 
> This would be useful information to have on the STATUS page for 
> RAID1c3/RAID1c4 as well. I am on Debian and had to discover this the 
> hard way when I believed that Grub 2.04 *had* this backported , which it 
> of course has not...

This information is too distro specific, the status on btrfs wiki would
get stale and unreliable, I doubt anybody from ubuntu community would go
there to fix it. There used to be distro specific pages on the k.org
wiki but all got deleted because of no interest to keep them up to date.

The only time-proof advice is "make sure your distro and system supports
all features you enable".
