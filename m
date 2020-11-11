Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9C2AF356
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 15:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKKOQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 09:16:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:55224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgKKOQK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 09:16:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A888AC98;
        Wed, 11 Nov 2020 14:16:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59419DA6E1; Wed, 11 Nov 2020 15:14:27 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:14:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/8] btrfs: remove the recursion handling code in
 locking.c
Message-ID: <20201111141427.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1604697895.git.josef@toxicpanda.com>
 <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 06, 2020 at 04:27:32PM -0500, Josef Bacik wrote:
> Now that we're no longer using recursion, rip out all of the supporting
> code.  Follow up patches will clean up the callers of these functions.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/locking.c | 63 ++--------------------------------------------
>  1 file changed, 2 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index d477df1c67db..9b66154803a7 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -28,40 +28,16 @@
>   * Additionally we need one level nesting recursion, see below. The rwsem
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That needs to be deleted too, the other sentence about spinning seems to
be still useful so I'll keep it ther.

>   * implementation does opportunistic spinning which reduces number of times the
>   * locking task needs to sleep.
