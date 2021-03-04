Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2F32D8EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 18:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbhCDRrZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 12:47:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:51398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236477AbhCDRq4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Mar 2021 12:46:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27DF3AE1C;
        Thu,  4 Mar 2021 17:46:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19457DA81D; Thu,  4 Mar 2021 18:44:19 +0100 (CET)
Date:   Thu, 4 Mar 2021 18:44:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a couple races between fsync and other
 code
Message-ID: <20210304174418.GV7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1614081281.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1614081281.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 23, 2021 at 12:08:46PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first patch fixes a race between fsync and memory mapped writes, which
> can result in corruptions. The second one fixes a different race that in
> practice should be "impossible" to happen, but in case it's triggered
> somehow, results in not logging an inode when it has new extents. The last
> patch just removes some no longer needed code.
> 
> The first patch, as mentioned in its changelog, depends on Josef's patchset
> which has the subject:
> 
>    "Introduce a mmap sem to deal with some mmap issues"

The patchset is now in for-next so I'll add your fixes on top of that.
