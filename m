Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9703123BB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLRAly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:41:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:38462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLRAly (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:41:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D46ABAF8E;
        Wed, 18 Dec 2019 00:41:52 +0000 (UTC)
Message-ID: <65eb6792b6c9e1c8f58a741866305a6ccb9fee32.camel@suse.de>
Subject: Re: [btrfs-progs PATCH 4/4] tests: Do not fail is dmsetup is missing
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Date:   Tue, 17 Dec 2019 21:44:17 -0300
In-Reply-To: <ae5f2516-78e5-022f-f516-6351b75a362c@gmx.com>
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
         <20191217203155.24206-5-marcos.souza.org@gmail.com>
         <ae5f2516-78e5-022f-f516-6351b75a362c@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2019-12-18 at 08:30 +0800, Qu Wenruo wrote:
> 
> On 2019/12/18 上午4:31, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Move the check of dmsetup to check_dm_target_support, and adapt the
> only
> > two places checking if dmsetup is present in the system. Now we
> skip the
> > test if dmsetup isn't available, instead of marking the test as
> failed.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Looks good overall, just a small nitpick inlined below.
> 
> > ---
> >  tests/common                                             | 9
> +++++++--
> >  tests/mkfs-tests/005-long-device-name-for-ssd/test.sh    | 1 -
> >  .../017-small-backing-size-thin-provision-device/test.sh | 1 -
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/common b/tests/common
> > index f138b17e..dc2d084e 100644
> > --- a/tests/common
> > +++ b/tests/common
> > @@ -322,10 +322,15 @@ check_global_prereq()
> >  	fi
> >  }
> >  
> > -# check if the targets passed as arguments are available, and if
> not just skip
> > -# the test
> > +# check if dmsetup and targets passed as arguments are available,
> and skip the
> > +# test if they aren't.
> >  check_dm_target_support()
> >  {
> > +	which dmsetup &> /dev/null
> > +	if [ $? -ne 0 ]; then
> > +		_not_run "This test requires dmsetup tool.";
> > +	fi
> 
> What about using existing check_global_prereq()?

check_global_prereq call _fail when the executable is not found in
$PATH, that's why I open coded the implementation and just called
_not_run.

> 
> Despite that,
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> 
> > +
> >  	for target in "$@"; do
> >  		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
> >  		$SUDO_HELPER dmsetup targets 2>&1 | grep -q ^$target
> > diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> > index 329deaf2..2df88db4 100755
> > --- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> > +++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> > @@ -4,7 +4,6 @@
> >  source "$TEST_TOP/common"
> >  
> >  check_prereq mkfs.btrfs
> > -check_global_prereq dmsetup
> >  check_dm_target_support linear
> >  
> >  setup_root_helper
> > diff --git a/tests/mkfs-tests/017-small-backing-size-thin-
> provision-device/test.sh b/tests/mkfs-tests/017-small-backing-size-
> thin-provision-device/test.sh
> > index 91851945..83f34ecc 100755
> > --- a/tests/mkfs-tests/017-small-backing-size-thin-provision-
> device/test.sh
> > +++ b/tests/mkfs-tests/017-small-backing-size-thin-provision-
> device/test.sh
> > @@ -6,7 +6,6 @@ source "$TEST_TOP/common"
> >  
> >  check_prereq mkfs.btrfs
> >  check_global_prereq udevadm
> > -check_global_prereq dmsetup
> >  check_dm_target_support linear thin
> >  
> >  setup_root_helper
> > 
> 

