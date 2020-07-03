Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14D2137FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGCJrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 05:47:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGCJrt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 05:47:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43174AD1B;
        Fri,  3 Jul 2020 09:47:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 710CFDA87C; Fri,  3 Jul 2020 11:47:31 +0200 (CEST)
Date:   Fri, 3 Jul 2020 11:47:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200703094731.GX27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 03:53:40PM -0400, Josef Bacik wrote:
> On 7/1/20 3:43 PM, waxhead wrote:
> > Josef Bacik wrote:
> > Just an idea inspired from RAID1c3 and RAID1c3, how about introducing DUP2 
> > and/or even DUP3 making multiple copies of the metadata to increase the chance 
> > to recover metadata on even a single storage device?
> 
> Because this only works on HDD.  On SSD's concurrent writes will often be 
> shunted to the same erase block, and if the whole erase block goes, so do all of 
> your copies.  This is why we default to 'single' for SSD's.
> 
> The one thing I _do_ want to do is make better use of the backup roots.

Oh please do, otherwise the backup roots are on the track to be removed
due to very little chances to actually make things better. We've heared
complaints about that for long.
