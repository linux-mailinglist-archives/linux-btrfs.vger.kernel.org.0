Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7393372FB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 15:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfGXNSd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 09:18:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:45350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbfGXNSc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 09:18:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 403D6AE8C;
        Wed, 24 Jul 2019 13:18:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7958DA808; Wed, 24 Jul 2019 15:19:08 +0200 (CEST)
Date:   Wed, 24 Jul 2019 15:19:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: misc-test/034: Avoid debug log populating
 stdout
Message-ID: <20190724131908.GL2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190724050705.29313-1-wqu@suse.com>
 <20190724105228.GH2868@twin.jikos.cz>
 <5d20c4d5-17c0-a40c-f762-e8f35a3cf598@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d20c4d5-17c0-a40c-f762-e8f35a3cf598@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 24, 2019 at 07:47:33PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/7/24 下午6:52, David Sterba wrote:
> > On Wed, Jul 24, 2019 at 01:07:05PM +0800, Qu Wenruo wrote:
> >> When running misc-test/034, we got unexpected log output:
> >>       [TEST/misc]   033-filename-length-limit
> >>       [TEST/misc]   034-metadata-uuid
> >>   Checking btrfstune logic
> >>   Checking dump-super output
> >>   Checking output after fsid change
> >>   Checking for incompat textual representation
> >>   Checking setting fsid back to original
> >>   Testing btrfs-image restore
> >>
> >> This is caused by commit 2570cff076b1 ("btrfs-progs: test: cleanup misc-tests/034")
> >> which uses _log facility which also populates stdout.
> >>
> >> Revert to echo "$*" >> "$RESULTS" to remove the noise.
> > 
> > Yes to remove the noise but the idea was to avoid manual redirections to
> > $RESULTS, so we need a new helper or adjust _log.
> > 
> 
> OK, I'll change _log to avoid populating stdout.

There are more calls to 'echo ... $RESULTS' in several tests, so that
would be good to unify.

> BTW, the reason I didn't change _log is at commit e547fdb16667
> ("btrfs-progs: tests, add more common helpers") it's using _log in
> _run_mayfail(), but now it's not.

I see, the code has evolved. The helpers like run_mayfail are allowed to
use the raw calls (or can use own internal helpers if that makes sense),
and we can make _log exclusively used by tests, once it does print to
stdout.

> So some commits are doing conflicting modification during that cleanup.

Yeah.
