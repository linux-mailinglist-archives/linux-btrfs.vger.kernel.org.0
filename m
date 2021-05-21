Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D987D38C798
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhEUNQw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:16:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:58432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhEUNQu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:16:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 438BFAC7A;
        Fri, 21 May 2021 13:15:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CAC21DA72C; Fri, 21 May 2021 15:12:51 +0200 (CEST)
Date:   Fri, 21 May 2021 15:12:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: abort in rename_exchange if we fail to insert the
 second ref
Message-ID: <20210521131251.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <b14ab16d2685978c2d0b1dce7c1a2bb3ad8aa00a.1621447454.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14ab16d2685978c2d0b1dce7c1a2bb3ad8aa00a.1621447454.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 02:04:21PM -0400, Josef Bacik wrote:
> Error injection stress uncovered a problem where we'd leave a dangling
> inode ref if we failed during a rename_exchange.  This happens because
> we insert the inode ref for one side of the rename, and then for the
> other side.  If this second inode ref insert fails we'll leave the first
> one dangling and leave a corrupt file system behind.  Fix this by
> aborting if we did the insert for the first inode ref.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
