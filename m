Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7363B0FFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 00:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFVWVU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 18:21:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFVWVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 18:21:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 232761FD45;
        Tue, 22 Jun 2021 22:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624400343;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJW/qzv1HPORQ4r8PAkjRjLV49p93vJve2ZrcLBsrvA=;
        b=HAUr2mXVuA//VNxE7CkOphb+I6TYzqD+R7kVyWlCFVGnbXaAgZjawqP0QPZf+v1NxGmUPO
        PwHqgiP1IO034qS4l6Qm1nCxV+WxSKSeQOKO6ADEeBXxG+sFaWk8LKYEdayvF0//I8FzBD
        8Q2Yx8Qk2FL1Lih0zj4Fpl24pwsTFzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624400343;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJW/qzv1HPORQ4r8PAkjRjLV49p93vJve2ZrcLBsrvA=;
        b=XhF51cUFhp56/8nNQXcCIblPy+mg+z5iZwlGjQRZs0RHqmUtyR3xdLX+nWnDfQWocEJLB1
        sAd9wXmRSEHW88CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1C349A3B97;
        Tue, 22 Jun 2021 22:19:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E329DA8D1; Wed, 23 Jun 2021 00:16:12 +0200 (CEST)
Date:   Wed, 23 Jun 2021 00:16:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove btrfs_fs_info::total_pinned
Message-ID: <20210622221612.GL28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210622132738.2357003-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622132738.2357003-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 04:27:38PM +0300, Nikolay Borisov wrote:
> This got added 14 years ago in 324ae4df00fd ("Btrfs: Add block group pinned accounting back")
> but it was not ever used. Subsequently its usage got gradually removed
> in  8790d502e440 ("Btrfs: Add support for mirroring across drives") and
> 11833d66be94 ("Btrfs: improve async block group caching"). Let's remove
> it for good!
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
