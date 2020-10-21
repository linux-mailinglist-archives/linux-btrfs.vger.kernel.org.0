Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBE294BC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439358AbgJULZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 07:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439410AbgJULYG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 07:24:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8EE4AF86;
        Wed, 21 Oct 2020 11:24:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5409EDA7C5; Wed, 21 Oct 2020 13:22:35 +0200 (CEST)
Date:   Wed, 21 Oct 2020 13:22:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/68] btrfs: add basic rw support for subpage sector
 size
Message-ID: <20201021112235.GD6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 02:24:46PM +0800, Qu Wenruo wrote:
> === Patchset structure ===
> Patch 01~03:	Small bug fixes
> Patch 04~22:	Generic cleanup and refactors, which make sense without
> 		subpage support
> Patch 23~27:	Subpage specific cleanup and refactors.
> Patch 28~42:	Enablement for subpage RO mount
> Patch 43~52:	Enablement for subpage metadata write
> Patch 53~68:	Enablement for subpage data write (although still in
> 		page size)

That's a sane grouping to merge it from the top, though it still could
be some updates required. There are some pending patchsets for next and
I don't have an estimate for conflicts regarding the cleanups you have
in this patchset so we'll see.  All up to 27 should be mergeable in this
dev cycle.
