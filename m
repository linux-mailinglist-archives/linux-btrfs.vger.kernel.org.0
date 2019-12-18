Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF28124C4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 16:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfLRP6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 10:58:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:52426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfLRP6Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 10:58:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5FBE2AF79;
        Wed, 18 Dec 2019 15:58:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 604DADA729; Wed, 18 Dec 2019 16:58:12 +0100 (CET)
Date:   Wed, 18 Dec 2019 16:58:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: Re: [btrfs-progs PATCH 1/4] tests: common: Add
 check_dm_target_support helper
Message-ID: <20191218155812.GK3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
 <20191217203155.24206-2-marcos.souza.org@gmail.com>
 <076b3709-c702-b7bf-cd03-276115aa5263@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076b3709-c702-b7bf-cd03-276115aa5263@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 08:26:09AM +0800, Qu Wenruo wrote:
> > +# check if the targets passed as arguments are available, and if not just skip
> > +# the test
> > +check_dm_target_support()
> > +{
> > +	for target in "$@"; do
> > +		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
> 
> To utilize $SUDO_HELPER, we need to call setup_root_helper() in the
> first place, just like all the other $SUDO_HELPER users in `tests/common`.
> 
> Although nowadays it feels a little unnecessary, since the functionality
> is introduced because I'm a lazybone who doesn't bother to startup a VM
> to do proper test, but uses current unprivileged user to utilize self tests.
> 
> Maybe it's time to get rid of SUDO_HELPER ?

No, that should stay, my local testing relies on that heavily.
