Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE672A5659
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 22:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgKCV0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 16:26:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387468AbgKCVBc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 16:01:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8803DAE47;
        Tue,  3 Nov 2020 21:01:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6AAC2DA7D2; Tue,  3 Nov 2020 21:59:52 +0100 (CET)
Date:   Tue, 3 Nov 2020 21:59:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/12] Convert btree locking to an rwsem
Message-ID: <20201103205951.GE6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1597938190.git.josef@toxicpanda.com>
 <20200826145822.GG28318@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826145822.GG28318@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 04:58:22PM +0200, David Sterba wrote:
> On Thu, Aug 20, 2020 at 11:45:59AM -0400, Josef Bacik wrote:
> > v1->v2:
> > - broke the lockdep fixes out into their own series.
> > - added a new fix where we need to handle double splitting leaves in some cases.
> 
> The split lockdep patches are now in misc-next, I'd like to continue
> with a piecemal steps with the whole rwsem series:
> 
> - preparatory stuff, like the annotations patches 1-10
> - switch locks to rwsem (1 patch)
> - post cleanups once things prove to be ok

The rwsem seems to be working ok, the two remaining patches have been
added to misc-next. RIP tree locks.
