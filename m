Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1108376C6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbfGZPMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 11:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727645AbfGZPMt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 11:12:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BA92B11C;
        Fri, 26 Jul 2019 15:12:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AE5CDA811; Fri, 26 Jul 2019 17:13:23 +0200 (CEST)
Date:   Fri, 26 Jul 2019 17:13:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
        axboe@kernel.dk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCHSET v3 btrfs/for-next] btrfs: fix cgroup writeback support
Message-ID: <20190726151321.GF2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tejun Heo <tj@kernel.org>,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, axboe@kernel.dk,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190710192818.1069475-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710192818.1069475-1-tj@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 10, 2019 at 12:28:13PM -0700, Tejun Heo wrote:
> Hello,
> 
> This patchset contains only the btrfs part of the following patchset.
> 
>   [1] [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback support
> 
> The block part has already been applied to
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/ for-linus
> 
> with some naming changes.  This patchset has been updated accordingly.

I'm going to add this patchset to for-next to get some testing coverage,
there are some comments pending, but that are changelog updates and
refactoring.
