Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0281D19AF3D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbgDAQB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 12:01:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732651AbgDAQB0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 12:01:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 907C7ACB1;
        Wed,  1 Apr 2020 16:01:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F097DA727; Wed,  1 Apr 2020 18:00:50 +0200 (CEST)
Date:   Wed, 1 Apr 2020 18:00:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>, osandov@fb.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: inode: Fix uninitialized variable bug
Message-ID: <20200401160050.GV5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, osandov@fb.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200327200135.GA3472@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327200135.GA3472@embeddedor>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 27, 2020 at 03:01:35PM -0500, Gustavo A. R. Silva wrote:
> geom.len is being used without being properly initialized, previously.
> 
> Fix this by placing ASSERT(geom.len <= INT_MAX); after geom.len has been
> initialized.
> 
> Addresses-Coverity-ID: 1491912 ("Uninitialized scalar variable")
> Fixes: 1eb52c8bd8d6 ("btrfs: get rid of one layer of bios in direct I/O")

Thanks.  This is in a development branch so the fixup can be folded in,
we're expecting more revisions of the patchset anyway. CCing Omar.
