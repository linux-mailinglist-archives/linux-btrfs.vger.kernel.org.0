Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC6E5145
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 18:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbfJYQcf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 12:32:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732240AbfJYQce (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 12:32:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 692A6B1C2;
        Fri, 25 Oct 2019 16:32:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CC8F3DA785; Fri, 25 Oct 2019 18:32:44 +0200 (CEST)
Date:   Fri, 25 Oct 2019 18:32:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: remove unnecessary delalloc mutex for inodes
Message-ID: <20191025163244.GO3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191025095242.15996-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025095242.15996-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 10:52:42AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The inode delalloc mutex was added a long time ago by commit f248679e86fea
> ("Btrfs: add a delalloc mutex to inodes for delalloc reservations"), and
> the reason for its introduction is not very clear from the change log. It
> claims it solves bogus warnings from lockdep, however it lacks an example
> report/warning from lockdep, or any explanation.
> 
> Since we have enough concurrentcy protection from the locks of the space
> info and block reserve objects, and such lockdep warnings don't seem to
> exist anymore (at least on a 5.3 kernel I couldn't get them with fstests,
> ltp, fs_mark, etc), remove it, simplifying things a bit and decreasing
> the size of the btrfs_inode structure. With some quick fio tests doing
> direct IO and mmap writes I couldn't observe any significant performance
> increase either (direct IO writes that don't increase the file's size
> don't hold the inode's lock for their entire duration and mmap writes
> don't hold the inode's lock at all), which are the only type of writes
> that could see any performance gain due to less serialization.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next with Josef's comment. Thanks.
