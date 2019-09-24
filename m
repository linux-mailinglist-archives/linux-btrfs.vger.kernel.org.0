Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0FBC30D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 09:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408160AbfIXHp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 03:45:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408088AbfIXHp4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 03:45:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02DF6AFA5;
        Tue, 24 Sep 2019 07:45:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4541DA959; Tue, 24 Sep 2019 09:46:15 +0200 (CEST)
Date:   Tue, 24 Sep 2019 09:46:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/9][V3] btrfs: break up extent_io.c a little bit
Message-ID: <20190924074615.GO2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190923140525.14246-1-josef@toxicpanda.com>
 <20190923170101.GM2751@twin.jikos.cz>
 <20190923182103.kokip2qevnaqzov4@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923182103.kokip2qevnaqzov4@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 02:21:04PM -0400, Josef Bacik wrote:
> > I got some strange merge conflicts, it turns out patch 6/9 did not make
> > it to the mailinglist (nor patchwork where I could pick it eventually).
> > For that it's useful to have the list of commits too along with the
> > diffstat, ie. what format-patch generates.
> 
> Huh weird.  I see you merged up through patch 5, I'll rebase and resend and
> maybe this time the ML will take it.

Yeah I merged what I had, even some of the 7-9 applied but that could
cause conflicts after your changes.

> How about I start sending pull requests through github for everything in
> addition to sending stuff to the mailinglist, that way it's easier to track the
> bigger things?  Thanks,

You can always send a link to git branch with the patches, not only for
cases like that, but we also want the mailig list copy. I almost always
process the mailinglist to send replies and to check previous
iterations. IOW, git branch is for convenience.
