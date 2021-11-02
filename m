Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E0B4431FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 16:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhKBPuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 11:50:40 -0400
Received: from dibed.net-space.pl ([84.10.22.86]:35947 "EHLO
        dibed.net-space.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhKBPuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 11:50:39 -0400
X-Greylist: delayed 2031 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Nov 2021 11:50:39 EDT
Received: from router-fw.i.net-space.pl ([192.168.52.1]:55158 "EHLO
        tomti.i.net-space.pl") by router-fw-old.i.net-space.pl with ESMTP
        id S2119692AbhKBOxM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Nov 2021 15:53:12 +0100
X-Comment: RFC 2476 MSA function at dibed.net-space.pl logged sender identity as: dkiper
Date:   Tue, 2 Nov 2021 15:53:07 +0100
From:   Daniel Kiper <dkiper@net-space.pl>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, grub-devel@gnu.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Make extent item iteration to handle gaps
Message-ID: <20211102145307.ozgcgijs65wef63v@tomti.i.net-space.pl>
References: <20211016014049.201556-1-wqu@suse.com>
 <3845c0be-6ed8-171e-67c2-92a6f80a60cd@suse.com>
 <20211029125229.GY20319@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029125229.GY20319@twin.jikos.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 29, 2021 at 02:52:29PM +0200, David Sterba wrote:
> On Thu, Oct 28, 2021 at 03:36:10PM +0800, Qu Wenruo wrote:
> > Gentle ping?
> >
> > Without this patch, the new mkfs.btrfs NO_HOLES feature would break any
> > kernel/initramfs with hole in it.
>
> Just to clarify, it's not a new feature, it's been out for a long time
> (since 3.14).  The new thing is that it's going to be enabled by default
> so the potential impact would be higher.

I will take a look at this patch probably next week.

Daniel
