Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40644FB7B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 19:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKMShx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 13:37:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbfKMShw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 13:37:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 296CAAEF3;
        Wed, 13 Nov 2019 18:37:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CDF62DABED; Wed, 13 Nov 2019 19:37:54 +0100 (CET)
Date:   Wed, 13 Nov 2019 19:37:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: mkfs: Make no-holes as default mkfs incompat
 features
Message-ID: <20191113183754.GH3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191111065004.24705-1-wqu@suse.com>
 <20191111180256.GR3001@twin.jikos.cz>
 <aa6d036e-bac9-1756-51b7-12167bd949ac@gmx.com>
 <d0ea9e14-cd33-9da3-9a6c-d625c13b7e2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0ea9e14-cd33-9da3-9a6c-d625c13b7e2b@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 11:10:57AM +0800, Anand Jain wrote:
> On 12/11/19 9:01 AM, Qu Wenruo wrote:
> > On 2019/11/12 上午2:02, David Sterba wrote:
> >> On Mon, Nov 11, 2019 at 02:50:04PM +0800, Qu Wenruo wrote:
> >>> No-holes feature could save 53 bytes for each hole we have, and it
> >>> provides a pretty good workaround to prevent btrfs check from reporting
> >>> non-contiguous file extent holes for mixed direct/buffered IO.
> >>>
> >>> The latter feature is more helpful for developers for handle log-writes
> >>> based test cases.
> >>
> >> Thanks. The plan to make no-holes default has been there for some time
> >> already. What it needs is a full round of testing and validation before
> >> making it default. And as defaults change rarely, I'd like to add
> >> free-space-tree as mkfs default as well, there's enough demand for that
> >> and we want to start deprecating v1 in the future.
> >>
> >> I have in my near-top todo list to do that, with the following
> >> checklist:
> >>
> >> - run fstests with various features together + the new default
> >>    - release build
> >>    - debugging build with UBSAN, KASAN and additional useful debugging
> >>      tools
> > Already running with no_holes for several previous releases.
> > 
> > Not to mention new btrfs specific log-writes test cases are all already
> > using this feature  to avoid btrfs check failure.
> > 
> > So I think this part should be OK.
> > 
> >> - run stress tests + the new feature
> > 
> > Any extra suggestions for the stress test tool?
> > 
> > Despite that, extra 24x7 host may be needed for this test.
> > 
> 
>    To keep the ball rolling I can run stress tests part here,
>    yep need extra suggestions on the stress test tools.

There are synthetic workload generators like fio, fs-mark, etc. so you
can try random options and do unplug tests, or
sync/umount/fsck/mount/continue a few times.

Otherwise you can simulate workloads that users do, like databases, VMs,
copying large files around, git is a good stressing tool as well.

The point here is to get a group focus on the newly enabled features, on
various hardware (cpus, memory, disks). As has been mentioned, no-holes
is part of testing environments of developers so this is not completely
new thing.
