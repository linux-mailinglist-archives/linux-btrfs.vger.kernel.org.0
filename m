Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E19258428
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 00:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgHaWmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 18:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgHaWmb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 18:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34282B596;
        Mon, 31 Aug 2020 22:42:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA458DA7CF; Tue,  1 Sep 2020 00:41:18 +0200 (CEST)
Date:   Tue, 1 Sep 2020 00:41:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/12] Convert btree locking to an rwsem
Message-ID: <20200831224118.GE28318@twin.jikos.cz>
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
Sender: linux-btrfs-owner@vger.kernel.org
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

1-9 are now in misc-next.

> - switch locks to rwsem (1 patch)

I'll add that to for-next. This is a significant change, so far the
other big changes seem to be witout problems (data tickets, iomap-dio).
The plan is to keep the rwsem, with fallback to reverting this patch in
case something bad pops up.  The lockdep warnings triggered by rwsem
should be fixed in misc-next.
