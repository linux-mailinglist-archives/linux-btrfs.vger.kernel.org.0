Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6F124C5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLRQDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:03:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:55520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfLRQDN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:03:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E5FDAFF7;
        Wed, 18 Dec 2019 16:03:11 +0000 (UTC)
Message-ID: <42fb02336941007b590e82abe86c336f9a9b4c80.camel@suse.de>
Subject: Re: [btrfs-progs PATCH 1/4] tests: common: Add
 check_dm_target_support helper
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Date:   Wed, 18 Dec 2019 13:05:36 -0300
In-Reply-To: <20191218155812.GK3929@suse.cz>
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
         <20191217203155.24206-2-marcos.souza.org@gmail.com>
         <076b3709-c702-b7bf-cd03-276115aa5263@gmx.com>
         <20191218155812.GK3929@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2019-12-18 at 16:58 +0100, David Sterba wrote:
> On Wed, Dec 18, 2019 at 08:26:09AM +0800, Qu Wenruo wrote:
> > > +# check if the targets passed as arguments are available, and if
> not just skip
> > > +# the test
> > > +check_dm_target_support()
> > > +{
> > > +	for target in "$@"; do
> > > +		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
> > 
> > To utilize $SUDO_HELPER, we need to call setup_root_helper() in the
> > first place, just like all the other $SUDO_HELPER users in
> `tests/common`.
> > 
> > Although nowadays it feels a little unnecessary, since the
> functionality
> > is introduced because I'm a lazybone who doesn't bother to startup
> a VM
> > to do proper test, but uses current unprivileged user to utilize
> self tests.
> > 
> > Maybe it's time to get rid of SUDO_HELPER ?
> 
> No, that should stay, my local testing relies on that heavily.

An updated version keeping SUDO_HELPER and adding setup_root_helper is
in [1].

All other patches are the same ones, already reviewed by Qu.

[1]: https://github.com/marcosps/btrfs-progs/tree/mpdesouza_mkfs_fixes

