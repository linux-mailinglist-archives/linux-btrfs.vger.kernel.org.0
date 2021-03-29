Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759EB34D793
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhC2Sta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:49:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhC2StB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:49:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01B45AFF5;
        Mon, 29 Mar 2021 18:49:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16B3DDA842; Mon, 29 Mar 2021 20:46:52 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:46:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make reflinks respect O_SYNC O_DSYNC and S_SYNC
 flags
Message-ID: <20210329184651.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <dd702a279373c3b6babdf0d7a69c929e9924bb33.1616523672.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd702a279373c3b6babdf0d7a69c929e9924bb33.1616523672.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 23, 2021 at 06:39:49PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we reflink to or from a file opened with O_SYNC/O_DSYNC or to/from a
> file that has the S_SYNC attribute set, we totally ignore that and do not
> durably persist the reflink changes. Since a reflink can change the data
> readable from a file (and mtime/ctime, or a file size), it makes sense to
> durably persist (fsync) the source and destination files/ranges.
> 
> This was previously discussed at:
> 
> https://lore.kernel.org/linux-btrfs/20200903035225.GJ6090@magnolia/
> 
> The recently introduced test case generic/628, from fstests, exercises
> these scenarios and currently fails without this change.
> 
> So make sure we fsync the source and destination files/ranges when either
> of them was opened with O_SYNC/O_DSYNC or has the S_SYNC attribute set,
> just like XFS already does.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
