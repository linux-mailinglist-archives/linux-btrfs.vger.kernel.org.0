Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928D3153491
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 16:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBEPs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 10:48:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:41238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBEPs4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 10:48:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 751ABAF33;
        Wed,  5 Feb 2020 15:48:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A17A9DA7E6; Wed,  5 Feb 2020 16:48:41 +0100 (CET)
Date:   Wed, 5 Feb 2020 16:48:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/44][v5] Cleanup how we handle root refs, part 1
Message-ID: <20200205154840.GU2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:17AM -0500, Josef Bacik wrote:
> v4->v5:
> - split out the btrfs_free_fs_info() moving around into it's own patch.
> - updated a comment in btrfs_get_root() to describe why we are initializing part
>   of the fs_info

I've commented under the patches, small things that I'd rather fixup
in my branch once you look at them, no need to resend anything.

As the code is split, some changes are removed so even if there's
something called in wrong order, it lasts only a few patches. For
clarity I'd still like to have committed patches that don't have such
things left.
