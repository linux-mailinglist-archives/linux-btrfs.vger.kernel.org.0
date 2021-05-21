Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0B38C74A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhEUM72 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:59:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233930AbhEUM7X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:59:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52E3CAC11;
        Fri, 21 May 2021 12:57:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8376DA725; Fri, 21 May 2021 14:55:24 +0200 (CEST)
Date:   Fri, 21 May 2021 14:55:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: check error value from btrfs_update_inode in tree
 log
Message-ID: <20210521125524.GK7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 11:26:25AM -0400, Josef Bacik wrote:
> Error injection testing uncovered a case where we ended up with invalid
> link counts on an inode.  This happened because we failed to notice an
> error when updating the inode while replaying the tree log, and
> committed the transaction with an invalid file system.  Fix this by
> checking the return value of btrfs_update_inode.  This resolved the link
> count errors I was seeing, and we already properly handle passing up the
> error values in these paths.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
