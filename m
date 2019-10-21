Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E4DEDC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfJUNiE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:38:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbfJUNiE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:38:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E01EAF40;
        Mon, 21 Oct 2019 13:38:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA104DA8C5; Mon, 21 Oct 2019 15:38:15 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:38:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] Small coding style cleanups
Message-ID: <20191021133815.GK3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191018095823.15282-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018095823.15282-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 18, 2019 at 11:58:19AM +0200, Johannes Thumshirn wrote:
> Here are some minor coding style cleanups which I think are neat as they make
> some functions a bit easier to read.
> 
> None of these patches is really needed though.
> 
> The patches have no regressions with regrads to the basline
> btrfs-devel/misc-next on an xfstests -g auto run.
> 
> A gitweb preview can be found at
> https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=btrfs-raid-cleanups
> 
> Note I did rebase the branch because one patch did not have a changelog.
> 
> Johannes Thumshirn (4):
>   btrfs: reduce indentation in lock_stripe_add
>   btrfs: remove pointless local variable in lock_stripe_add()
>   btrfs: reduce indentation in btrfs_may_alloc_data_chunk
>   btrfs: remove pointless indentation in btrfs_read_sys_array()

Added to misc-next, thanks.
