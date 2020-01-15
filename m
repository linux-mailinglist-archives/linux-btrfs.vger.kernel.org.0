Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299E313C1AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 13:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAOMvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 07:51:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:57306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgAOMvt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 07:51:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43B76AFE0;
        Wed, 15 Jan 2020 12:51:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D222CDA791; Wed, 15 Jan 2020 13:51:34 +0100 (CET)
Date:   Wed, 15 Jan 2020 13:51:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org,
        Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>
Subject: Re: Scrub resume regression
Message-ID: <20200115125134.GN3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs@vger.kernel.org,
        Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>
References: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 09:03:13AM +0000, Graham Cobb wrote:
> OK, I have bisected the problem with scrub resume being broken by the
> scrub ioctl ABI being changed.

Thanks for the bisecting, I'll forward the fix to 5.5-rc so it can be
picked by stable trees. The regression has been there since 5.1, which
at the moment is only for 5.4.x.

> The bad commit is:
> 
> 06fe39ab15a6a47d4979460fcc17d33b1d72ccf9 is the first bad commit
> commit 06fe39ab15a6a47d4979460fcc17d33b1d72ccf9
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Fri Dec 14 19:50:17 2018 +0000
> 
>     Btrfs: do not overwrite scrub error with fault error in scrub ioctl
[...]

> It is important that scrub always returns the stats, even when it
> returns an error. This is critical for cancel, as that is how
> cancel/resume works, but it should also apply in case of other errors so
> that the user can see how much of the scrub was done before the fatal error.

That's something we need to document in code and perhaps in the manual
pages too.
