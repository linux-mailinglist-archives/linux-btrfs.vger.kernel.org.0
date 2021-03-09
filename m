Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5D332749
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 14:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCINf4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 08:35:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:43812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhCINfY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 08:35:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3CBAAB8C;
        Tue,  9 Mar 2021 13:35:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DCB4DA81B; Tue,  9 Mar 2021 14:33:25 +0100 (CET)
Date:   Tue, 9 Mar 2021 14:33:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: output sectorsize related warning message
 into stdout
Message-ID: <20210309133325.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210309073909.74043-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309073909.74043-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 09, 2021 at 03:39:09PM +0800, Qu Wenruo wrote:
> Since commit 90020a760584 ("btrfs-progs: mkfs: refactor how we handle
> sectorsize override") we have extra warning message if the sectorsize of
> mkfs doesn't match page size.
> 
> But this warning is show as stderr, which makes a lot of fstests cases
> failure due to golden output mismatch.

Well, no. Using message helpers in progs is what we want to do
everywhere, working around fstests output matching design is fixing the
problem in the wrong place. That this is fragile has been is known and
I want to keep the liberty to adjust output in progs as users need, not
as fstests require.

I can compare two different approaches of testsuites, fstests vs
btrfs-progs and I can say that the number of false positives on fstests
side was much higher and actually making the whole testing experience
much worse, up to ignoring test failures because they were not failures
at all because the tests are not robust enoughh. In btrfs-progs there
have been like 1 or 2 silent test breakages (unexpected pass) but that
led to stronger checks of the expected or unexpected output.
