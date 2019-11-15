Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F236FD97D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 10:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKOJmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 04:42:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:56912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfKOJmY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 04:42:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95469AC48;
        Fri, 15 Nov 2019 09:42:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB7EADA783; Fri, 15 Nov 2019 10:42:25 +0100 (CET)
Date:   Fri, 15 Nov 2019 10:42:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: fix missing hole after hole punching and fsync
 when using NO_HOLES
Message-ID: <20191115094225.GO3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112151331.3641-1-fdmanana@kernel.org>
 <20191114151817.GJ3001@twin.jikos.cz>
 <CAL3q7H7SwZD0mzv2Aqpo58a47e=iGxp4kqmadVQ=+AzfEco_uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7SwZD0mzv2Aqpo58a47e=iGxp4kqmadVQ=+AzfEco_uA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 03:45:38PM +0000, Filipe Manana wrote:
> > > Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Added to misc-next, thanks.
> 
> Actually, could you hold on a bit for this one?
> There's nothing wrong with it, I'm simply fixing other cases and
> realized I can fix them all in a single patch.
> If I take too long or end up not being able to fix all as I'm
> expecting, I'll let you know, otherwise I'll send a very different v2
> tomorrow.

Sure, no problem. Patch removed from misc-next. Thanks.
