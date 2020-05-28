Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4345D1E6887
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405422AbgE1RRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 13:17:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405353AbgE1RRt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 13:17:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CBF46ABB2;
        Thu, 28 May 2020 17:17:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1216CDA732; Thu, 28 May 2020 19:17:48 +0200 (CEST)
Date:   Thu, 28 May 2020 19:17:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Don't balance btree inode pages from buffered
 write path
Message-ID: <20200528171747.GO18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200528080513.22914-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528080513.22914-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 11:05:13AM +0300, Nikolay Borisov wrote:
> The call to btrfs_btree_balance_dirty has been there since the early
> days of BTRFS, when the btree was directly modified from the write path,
> hence dirtied btree inode pages. With the implementation of
> b888db2bd7b6 ("Btrfs: Add delayed allocation to the extent based page tree code")
> 13 years ago the btree is no longer modified from the write path, hence
> there is no point in calling this function. Just remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
