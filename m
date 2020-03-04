Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09E11791C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 14:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgCDNxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 08:53:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:40346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCDNxk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 08:53:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 64BA7AE5C;
        Wed,  4 Mar 2020 13:53:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B6DD3DA7B4; Wed,  4 Mar 2020 14:53:15 +0100 (CET)
Date:   Wed, 4 Mar 2020 14:53:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] Fix btrfs check handling of missing file extents
Message-ID: <20200304135315.GS2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200130204736.49224-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130204736.49224-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 03:47:34PM -0500, Josef Bacik wrote:
> While adding an xfstest for the missing file extent problem I fixed with the
> series
> 
>   btrfs: fix hole corruption issue with !NO_HOLES
> 
> I was failing to fail my test without my patches, despite the file system being
> actually wrong.
> 
> It turns out because the normal check mode sets its expected start to the first
> file extent it finds, instead of 0.  This means it misses any gaps between 0 and
> the first file extent item in the inode.
> 
> The lowmem check does not have this issue, instead it doesn't take into account
> the isize of the inode, so improperly fails when we have a gap but that is
> outside of the isize.  I fixed this as well.
> 
> With these patches we're able to properly find another set of corruptions, and
> now my xfstest acts sanely.  Thanks,

Added to devel, thanks.
