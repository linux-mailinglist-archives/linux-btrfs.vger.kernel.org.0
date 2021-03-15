Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F5833C581
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhCOSY5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 14:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:33852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhCOSYj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 14:24:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9355AE3D;
        Mon, 15 Mar 2021 18:24:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA919DA6E2; Mon, 15 Mar 2021 19:22:36 +0100 (CET)
Date:   Mon, 15 Mar 2021 19:22:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs-progs: common: make sure that qgroup id is in range
Message-ID: <20210315182236.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210315155638.18861-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315155638.18861-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 15, 2021 at 03:56:38PM +0000, Sidong Yang wrote:
> When user assign qgroup with qgroup id that is too big to exceeds
> range and invade level value, and it works without any error. but
> this action would be make undefined error. this code make sure that
> qgroup id doesn't exceed range(0 ~ 2^48-1).
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  common/utils.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/common/utils.c b/common/utils.c
> index 57e41432..a2f72550 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -727,6 +727,8 @@ u64 parse_qgroupid(const char *p)
>  		id = strtoull(p, &ptr_parse_end, 10);
>  		if (ptr_parse_end != ptr_src_end)
>  			goto path;
> +		if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
> +			goto err;

Please add a helper that validates the id or use btrfs_qgroup_level and
check that level is 0 if that makes sense in the context of the call.
