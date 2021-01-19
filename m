Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F12FC418
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 23:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbhASWsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 17:48:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:55974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbhASWsk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 17:48:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A25BFAAAE;
        Tue, 19 Jan 2021 22:47:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E171BDA6E3; Tue, 19 Jan 2021 23:46:01 +0100 (CET)
Date:   Tue, 19 Jan 2021 23:46:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/13] btrfs: Document now parameter of peek_discard_list
Message-ID: <20210119224601.GV6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210119122649.187778-1-nborisov@suse.com>
 <20210119122649.187778-7-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119122649.187778-7-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 19, 2021 at 02:26:42PM +0200, Nikolay Borisov wrote:
> Fixes fs/btrfs/discard.c:203: warning: Function parameter or member 'now' not described in 'peek_discard_list'
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/discard.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 2b8383d41144..bfe53eb4c1f3 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -189,6 +189,7 @@ static struct btrfs_block_group *find_next_block_group(
>   * @discard_ctl: discard control
>   * @discard_state: the discard_state of the block_group after state management
>   * @discard_index: the discard_index of the block_group after state management
> + * @now: Time when discard was invoked, in ns

Please follow the formatting, no uppercase letter in 'Time'

>   *
>   * This wraps find_next_block_group() and sets the block_group to be in use.
>   * discard_state's control flow is managed here.  Variables related to
> -- 
> 2.25.1
