Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BFD151DFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgBDQPK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:15:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:58432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbgBDQPJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 11:15:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10B14B9E5;
        Tue,  4 Feb 2020 16:15:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5275CDA80D; Tue,  4 Feb 2020 17:14:53 +0100 (CET)
Date:   Tue, 4 Feb 2020 17:14:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: ref-verify: fix memory leaks
Message-ID: <20200204161451.GG2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wenwen Wang <wenwen@cs.uga.edu>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200201203838.19198-1-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201203838.19198-1-wenwen@cs.uga.edu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 01, 2020 at 08:38:38PM +0000, Wenwen Wang wrote:
> In btrfs_ref_tree_mod(), 'ref' and 'ra' are allocated through kzalloc() and
> kmalloc(), respectively. In the following code, if an error occurs, the
> execution will be redirected to 'out' or 'out_unlock' and the function will
> be exited. However, on some of the paths, 'ref' and 'ra' are not
> deallocated, leading to memory leaks. For example, if 'action' is
> BTRFS_ADD_DELAYED_EXTENT, add_block_entry() will be invoked. If the return
> value indicates an error, the execution will be redirected to 'out'. But,
> 'ref' is not deallocated on this path, causing a memory leak.
> 
> To fix the above issues, deallocate both 'ref' and 'ra' before exiting from
> the function when an error is encountered.

Right, the kfrees are missing. The whole function needs to be
restructured otherwise it's too easy to get lost in the conditions and
what needs to be cleaned up after errors but that's for a separate
patch. Added to devel queue, thanks.
