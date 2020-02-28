Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162B3173C12
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgB1PqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 10:46:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:46182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgB1PqS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 10:46:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A3E9AD9A;
        Fri, 28 Feb 2020 15:46:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21287DA79B; Fri, 28 Feb 2020 16:45:56 +0100 (CET)
Date:   Fri, 28 Feb 2020 16:45:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs: relocation: Refactor build_backref_tree()
Message-ID: <20200228154555.GN2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200226055652.24857-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226055652.24857-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 01:56:42PM +0800, Qu Wenruo wrote:
> This branch can be fetched from github:
> https://github.com/adam900710/linux/tree/backref_cache_new

This is based on v5.6-rc1, you should base on something more recent.
There are many non-trivial conflicts at patch 5 so I stopped there but
if you and I like to get the pathes merged, the branch needs to be in a
state where it's not that hard to apply the patches.

Minor conflicts are expected, like obvious differences in context or
renames, there are tools that can deal with that automatically (I use
wiggle).

The branch also contains unrelated patches to the backref code, some of
them either upstream or in misc-next. All of that makes it unnecessarily
hard to get the patches to for-next when the time comes (reviews, patch
backlog processed).
