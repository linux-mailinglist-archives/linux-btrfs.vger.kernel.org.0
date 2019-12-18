Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D7124C62
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLRQDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:03:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfLRQDx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:03:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49E42B26B;
        Wed, 18 Dec 2019 16:03:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4609EDA729; Wed, 18 Dec 2019 17:03:50 +0100 (CET)
Date:   Wed, 18 Dec 2019 17:03:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: Re: [btrfs-progs PATCH 4/4] tests: Do not fail is dmsetup is missing
Message-ID: <20191218160350.GL3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
 <20191217203155.24206-5-marcos.souza.org@gmail.com>
 <ae5f2516-78e5-022f-f516-6351b75a362c@gmx.com>
 <65eb6792b6c9e1c8f58a741866305a6ccb9fee32.camel@suse.de>
 <a880c99c-982d-135c-4e6e-e82c19e681c1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a880c99c-982d-135c-4e6e-e82c19e681c1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 08:48:21AM +0800, Qu Wenruo wrote:
> >>> +# check if dmsetup and targets passed as arguments are available,
> >> and skip the
> >>> +# test if they aren't.
> >>>  check_dm_target_support()
> >>>  {
> >>> +	which dmsetup &> /dev/null
> >>> +	if [ $? -ne 0 ]; then
> >>> +		_not_run "This test requires dmsetup tool.";
> >>> +	fi
> >>
> >> What about using existing check_global_prereq()?
> > 
> > check_global_prereq call _fail when the executable is not found in
> > $PATH, that's why I open coded the implementation and just called
> > _not_run.
> 
> Makes sense.
> 
> Although it would be even better to change from "_fail" to "_not_run"
> for check_global_prereq().

I'd rather keep it as _fail, the utilities checked by this helper is
mostly some system tool or other filesystem tool, all should be present
for the testing. I don't want the testsuite to skip random tests without
a good reason. We can add a script or make target to make the checks in
advance and not when some test fails after a long time.
