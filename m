Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479142731F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgIUSaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 14:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIUSaM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 14:30:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDC3CACC2;
        Mon, 21 Sep 2020 18:30:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB453DA6E0; Mon, 21 Sep 2020 20:28:56 +0200 (CEST)
Date:   Mon, 21 Sep 2020 20:28:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reschedule when cloning lots of extents
Message-ID: <20200921182856.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <23e7f73a25cea63f33c220c1da3daf62d9ffd3e8.1600709608.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e7f73a25cea63f33c220c1da3daf62d9ffd3e8.1600709608.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 22, 2020 at 02:38:10AM +0900, Johannes Thumshirn wrote:
> We have several occurrences of a soft lockup from generic/175. All of these
> lockup reports have the call chain btrfs_clone_files() -> btrfs_clone() in
> common.
> 
> btrfs_clone_files() calls btrfs_clone() with both source and destination
> extents locked and loops over the source extent to create the clones.
> 
> Conditionally reschedule in the btrfs_clone() loop, to give some time back
> to other processes.
> 
> Link: https://github.com/btrfs/fstests/issues/23

It would be better to put relevant parts of the report to the changelog,
the fstests issues are more like a todo list than a long-term bug
tracking tool.
