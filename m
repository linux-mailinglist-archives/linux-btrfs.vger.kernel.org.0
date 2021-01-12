Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F02F3406
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389529AbhALPQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:16:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:48632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389393AbhALPQp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:16:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3C09ABD6;
        Tue, 12 Jan 2021 15:16:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57AF6DA87C; Tue, 12 Jan 2021 16:14:12 +0100 (CET)
Date:   Tue, 12 Jan 2021 16:14:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/22] btrfs: add read-only support for subpage sector
 size
Message-ID: <20210112151412.GR6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210106010201.37864-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 06, 2021 at 09:01:39AM +0800, Qu Wenruo wrote:
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
> Currently the branch also contains partial RW data support (still some
> out-of-sync subpage data page status).
> 
> Great thanks to David for his effort reviewing and merging the
> preparation patches into misc-next.
> Now all previously submitted preparation patches are already in
> misc-next.

I merged 1, 2, 3, 6 to misc-next as they're obvious and independent.
The rest is up for review, I haven't looked closely on the open
questions.

> Qu Wenruo (22):
>   btrfs: extent_io: rename @offset parameter to @disk_bytenr for
>     submit_extent_page()

Please drop "extent_io:" from any future patch subjects, they get too
long already and we haven't been using this prefix consistently anyway.
