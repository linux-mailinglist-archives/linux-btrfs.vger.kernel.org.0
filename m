Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301C5305FA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhA0PbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:31:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:36050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343876AbhA0PaZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:30:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1C4AAE76;
        Wed, 27 Jan 2021 15:29:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EE57DA84C; Wed, 27 Jan 2021 16:27:56 +0100 (CET)
Date:   Wed, 27 Jan 2021 16:27:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 01/12] btrfs: make flush_space take a enum
 btrfs_flush_state instead of int
Message-ID: <20210127152756.GC1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1602249928.git.josef@toxicpanda.com>
 <397b21a29dfe5d3c8d5fec261c3246b07b93e42c.1602249928.git.josef@toxicpanda.com>
 <20210126183624.GU1993@twin.jikos.cz>
 <ea66a2e1-6cd0-8ba9-42dd-a062e31e2dc0@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea66a2e1-6cd0-8ba9-42dd-a062e31e2dc0@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 26, 2021 at 03:32:36PM -0500, Josef Bacik wrote:
> On 1/26/21 1:36 PM, David Sterba wrote:
> > On Fri, Oct 09, 2020 at 09:28:18AM -0400, Josef Bacik wrote:
> >> I got a automated message from somebody who runs clang against our
> >> kernels and it's because I used the wrong enum type for what I passed
> >> into flush_space.  Change the argument to be explicitly the enum we're
> >> expecting to make everything consistent.  Maybe eventually gcc will
> >> catch errors like this.
> > 
> > I can't find any such public report and none of the clang warnings seem
> > to be specific about that. Local run with clang 11 does not produce any
> > warning.
> > 
> 
> IDK, it was a private email just to me with the following output from clang
> 
> s/btrfs/space-info.c:1115:12: warning: implicit conversion from
> enumeration type 'enum btrfs_flush_state' to different enumeration type
> 'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
>                           flush = FLUSH_DELALLOC;
>                                 ~ ^~~~~~~~~~~~~~
> fs/btrfs/space-info.c:1120:12: warning: implicit conversion from
> enumeration type 'enum btrfs_flush_state' to different enumeration type
> 'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
>                           flush = FORCE_COMMIT_TRANS;
>                                 ~ ^~~~~~~~~~~~~~~~~~
> fs/btrfs/space-info.c:1124:12: warning: implicit conversion from
> enumeration type 'enum btrfs_flush_state' to different enumeration type
> 'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
>                           flush = FLUSH_DELAYED_ITEMS_NR;
>                                 ~ ^~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/space-info.c:1127:12: warning: implicit conversion from
> enumeration type 'enum btrfs_flush_state' to different enumeration type
> 'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
>                           flush = FLUSH_DELAYED_REFS_NR;
>                                 ~ ^~~~~~~~~~~~~~~~~~~~~
> 
> I figure it made sense, might as well fix it.  Do we have that option for our 
> shiny new -W build options?  Thanks,

We can add -Wenum-conversion sure, but neither gcc (10.2.1) nor clang
(11.0.1) reproduces the warning for me so I wonder how useful it would
be. I've also tried adding -Wextra and -Wall and the build is clean.

Per gcc documentation, -Wenum-conversion is not exactly what the code
did:

 "Warn when a value of enumerated type is implicitly converted to a
  different enumerated type.  This warning is enabled by -Wextra."

And now that I read the warning carefuly it does not apply to our code,
"btrfs_reserve_flush_enum = btrfs_flush_state" does not happen so it
must have been some older revision of the code.

Changing 
@@ -1073,7 +1073,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 
        spin_lock(&space_info->lock);
        while (need_preemptive_reclaim(fs_info, space_info)) {
-               enum btrfs_flush_state flush;
+               enum btrfs_reserve_flush_enum flush;

---

gcc says (on misc-next without this patchset)

fs/btrfs/space-info.c: In function ‘btrfs_preempt_reclaim_metadata_space’:
fs/btrfs/space-info.c:1112:10: warning: implicit conversion from ‘enum btrfs_flush_state’ to ‘enum btrfs_reserve_flush_enum’ [-Wenum-conversion]
 1112 |    flush = FLUSH_DELALLOC;
      |          ^
  CC [M]  fs/btrfs/block-group.o
fs/btrfs/space-info.c:1117:10: warning: implicit conversion from ‘enum btrfs_flush_state’ to ‘enum btrfs_reserve_flush_enum’ [-Wenum-conversion]
 1117 |    flush = FORCE_COMMIT_TRANS;
      |          ^
fs/btrfs/space-info.c:1121:10: warning: implicit conversion from ‘enum btrfs_flush_state’ to ‘enum btrfs_reserve_flush_enum’ [-Wenum-conversion]
 1121 |    flush = FLUSH_DELAYED_ITEMS_NR;
      |          ^
fs/btrfs/space-info.c:1124:10: warning: implicit conversion from ‘enum btrfs_flush_state’ to ‘enum btrfs_reserve_flush_enum’ [-Wenum-conversion]
 1124 |    flush = FLUSH_DELAYED_REFS_NR;
      |          ^
fs/btrfs/space-info.c:1135:48: warning: implicit conversion from ‘enum btrfs_reserve_flush_enum’ to ‘enum btrfs_flush_state’ [-Wenum-conversion]
 1135 |   flush_space(fs_info, space_info, to_reclaim, flush, true);
      |    
---

So you weren't fixing the reported problem by this patch. Assigning enum
to an int should be natural so thre's no reason to fix that but for
clarity I don't mind, the patch stays.
