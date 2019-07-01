Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7E5C0A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfGAPvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 11:51:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729055AbfGAPvw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 11:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09E24AFC2
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2019 15:51:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80CBDDA8CC; Mon,  1 Jul 2019 17:52:35 +0200 (CEST)
Date:   Mon, 1 Jul 2019 17:52:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Evaluate io_tree in find_lock_delalloc_range()
Message-ID: <20190701155235.GM20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20190621150254.kql745ulwzqginhc@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621150254.kql745ulwzqginhc@fiona>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 21, 2019 at 10:02:54AM -0500, Goldwyn Rodrigues wrote:
> Simplification.
> No point passing the tree variable when it can be evaluated
> from inode. The tests now use the io_tree from btrfs_inode
> as opposed to creating one.
> 
> Changes since v1:
>  - included btrfs sanity tests
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>
