Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66A34544F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 01:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhCWA5N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 22 Mar 2021 20:57:13 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34636 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhCWA5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 20:57:06 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DE13C9E1107; Mon, 22 Mar 2021 20:57:04 -0400 (EDT)
Date:   Mon, 22 Mar 2021 20:57:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Neal Gompa <ngompa@fedoraproject.org>
Cc:     linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
Message-ID: <20210323005704.GQ32440@hungrycats.org>
References: <20210317200144.1067314-1-ngompa@fedoraproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210317200144.1067314-1-ngompa@fedoraproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 04:01:43PM -0400, Neal Gompa wrote:
> This is a patch requesting all substantial copyright owners to sign off
> on changing the license of the libbtrfsutil code to LGPLv2.1+ in order
> to resolve various concerns around the mixture of code in btrfs-progs
> with libbtrfsutil.
> 
> Each significant (i.e. non-trivial) commit author has been CC'd to
> request their sign-off on this. Please reply to this to acknowledge
> whether or not this is acceptable for your code.

Acked-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

> Neal Gompa (1):
>   btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
> 
>  libbtrfsutil/COPYING              | 1130 ++++++++++++-----------------
>  libbtrfsutil/COPYING.LESSER       |  165 -----
>  libbtrfsutil/btrfsutil.h          |    2 +-
>  libbtrfsutil/btrfsutil_internal.h |    2 +-
>  libbtrfsutil/errors.c             |    2 +-
>  libbtrfsutil/filesystem.c         |    2 +-
>  libbtrfsutil/python/btrfsutilpy.h |    2 +-
>  libbtrfsutil/python/error.c       |    2 +-
>  libbtrfsutil/python/filesystem.c  |    2 +-
>  libbtrfsutil/python/module.c      |    2 +-
>  libbtrfsutil/python/qgroup.c      |    2 +-
>  libbtrfsutil/python/setup.py      |    4 +-
>  libbtrfsutil/python/subvolume.c   |    2 +-
>  libbtrfsutil/qgroup.c             |    2 +-
>  libbtrfsutil/stubs.c              |    2 +-
>  libbtrfsutil/stubs.h              |    2 +-
>  libbtrfsutil/subvolume.c          |    2 +-
>  17 files changed, 495 insertions(+), 832 deletions(-)
>  delete mode 100644 libbtrfsutil/COPYING.LESSER
> 
> -- 
> 2.30.2
> 
