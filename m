Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B395118EE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 18:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfLJRW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 12:22:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:50100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbfLJRW7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 12:22:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22DDDB256;
        Tue, 10 Dec 2019 17:22:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E3A7DA727; Tue, 10 Dec 2019 18:22:43 +0100 (CET)
Date:   Tue, 10 Dec 2019 18:22:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/9] btrfs: remove dead snapshot-aware defrag code
Message-ID: <20191210172242.GD3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1575336815.git.osandov@fb.com>
 <e8079362b1884b5f71ebe839f01ab8492c2d5d2e.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8079362b1884b5f71ebe839f01ab8492c2d5d2e.1575336815.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 05:34:18PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Snapshot-aware defrag has been disabled since commit 8101c8dbf624
> ("Btrfs: disable snapshot aware defrag for now") almost 6 years ago.
> Let's remove the dead code. If someone is up to the task of bringing it
> back, they can dig it up from git.

While I usually stand against code deletionists, in this case I will not
and apply the patch. This is a good example how not to implement
features or do post-merge stabilization. There were runtime problems
with defrag on heavily referenced extents (many snapshots) so this was
the main reason to disable it. There's a patchset from Josef from 2014
bitrotting in some of his trees that was supposed to fix it but this
hasn't happen.

Defrag has been known to break reflinks, from what I've heared some
users want that behaviour while others not. So this would be good to
make selectable on the defrag ioctl level. This is a broader task and
from brief look I haven't seen an easy way how to wire that to the
current ioctl. Which means a deeper analysis and design needs to happen
first.
