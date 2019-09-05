Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB502AA242
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfIEL7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 07:59:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731865AbfIEL7P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 07:59:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE4F5AC6E;
        Thu,  5 Sep 2019 11:59:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73F58DA8F3; Thu,  5 Sep 2019 13:59:38 +0200 (CEST)
Date:   Thu, 5 Sep 2019 13:59:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Tejun Heo <tj@kernel.org>, josef@toxicpanda.com,
        clm@fb.com, dsterba@suse.com, axboe@kernel.dk, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCHSET v3 btrfs/for-next] btrfs: fix cgroup writeback support
Message-ID: <20190905115937.GA2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tejun Heo <tj@kernel.org>,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, axboe@kernel.dk,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190710192818.1069475-1-tj@kernel.org>
 <20190726151321.GF2868@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726151321.GF2868@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 05:13:21PM +0200, David Sterba wrote:
> On Wed, Jul 10, 2019 at 12:28:13PM -0700, Tejun Heo wrote:
> > Hello,
> > 
> > This patchset contains only the btrfs part of the following patchset.
> > 
> >   [1] [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback support
> > 
> > The block part has already been applied to
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/ for-linus
> > 
> > with some naming changes.  This patchset has been updated accordingly.
> 
> I'm going to add this patchset to for-next to get some testing coverage,
> there are some comments pending, but that are changelog updates and
> refactoring.

No updates, so patchset stays in for-next, closest merge target is 5.5.
