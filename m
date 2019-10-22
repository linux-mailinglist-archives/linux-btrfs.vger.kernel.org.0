Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572E3E05B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfJVOAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 10:00:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730676AbfJVOAY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 10:00:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9021EB7D5;
        Tue, 22 Oct 2019 14:00:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69F31DA733; Tue, 22 Oct 2019 16:00:35 +0200 (CEST)
Date:   Tue, 22 Oct 2019 16:00:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove extent_map::bdev
Message-ID: <20191022140035.GY3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1570474492.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570474492.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 09:37:40PM +0200, David Sterba wrote:
> The extent_map::bdev is unused and and can be removed, but it's not
> straightforward so there are several steps. The first patch decouples
> bdev from map_lookup. The remaining patches clean up use of the bdev,
> removing a few bio_set_dev on the way. In the end, submit_extent_page is
> one parameter lighter.
> 
> This has survived several fstests runs
> 
> David Sterba (5):
>   btrfs: assert extent_map bdevs and lookup_map and split
>   btrfs: get bdev from latest_dev for dio bh_result
>   btrfs: drop bio_set_dev where not needed
>   btrfs: remove extent_map::bdev
>   btrfs: drop bdev argument from submit_extent_page

Moved from topic branch to misc-next.
