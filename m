Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF8F7A6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 19:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKKSCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 13:02:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:34886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726871AbfKKSCx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 13:02:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD4E1B33E;
        Mon, 11 Nov 2019 18:02:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C42ADA7AF; Mon, 11 Nov 2019 19:02:56 +0100 (CET)
Date:   Mon, 11 Nov 2019 19:02:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: mkfs: Make no-holes as default mkfs incompat
 features
Message-ID: <20191111180256.GR3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191111065004.24705-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111065004.24705-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 02:50:04PM +0800, Qu Wenruo wrote:
> No-holes feature could save 53 bytes for each hole we have, and it
> provides a pretty good workaround to prevent btrfs check from reporting
> non-contiguous file extent holes for mixed direct/buffered IO.
> 
> The latter feature is more helpful for developers for handle log-writes
> based test cases.

Thanks. The plan to make no-holes default has been there for some time
already. What it needs is a full round of testing and validation before
making it default. And as defaults change rarely, I'd like to add
free-space-tree as mkfs default as well, there's enough demand for that
and we want to start deprecating v1 in the future.

I have in my near-top todo list to do that, with the following
checklist:

- run fstests with various features together + the new default
  - release build
  - debugging build with UBSAN, KASAN and additional useful debugging
    tools
- run stress tests + the new feature
- check that the documentation covers the change
  - mkfs.btrfs help string
  - manual page of mkfs.btrfs: benefits, pros/cons, conversion to/from
    the feature (if applicable), with example commands (if applicable)
  - wiki documentation update
- verify that all commonly used tools work with it (image, check, tune)

For free-space-tree specifically, there's
https://github.com/kdave/drafts/blob/master/btrfs/progs-fst-default.txt

I don't have objections to the patch, that's the easy part. The above is
non-coding work and is namely making sure that the usecase and usability
is good, or with known documented quirks.

Making it default in progs release 5.4 is IMO doable, there are probably
2-3 weeks before the release, but this task needs one or more persons
willing to do the above.
