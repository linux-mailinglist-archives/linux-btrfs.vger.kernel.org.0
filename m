Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5E212581
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgGBODE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:03:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:59518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBODE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 10:03:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0768EADD6;
        Thu,  2 Jul 2020 14:03:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B345DDA781; Thu,  2 Jul 2020 16:02:43 +0200 (CEST)
Date:   Thu, 2 Jul 2020 16:02:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/10] btrfs: raid56: Remove out label in
 __raid56_parity_recover
Message-ID: <20200702140243.GP27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-5-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702134650.16550-5-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 04:46:44PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/raid56.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index a7ae4d8a47ce..d9415a22617b 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2093,7 +2093,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>  		 */
>  		if (atomic_read(&rbio->error) <= rbio->bbio->max_errors) {
>  			__raid_recover_end_io(rbio);
> -			goto out;
> +			return 0;

No please, when there are labels that do cleanup like the one in the
context, 'return's make it harder to follow.

>  		} else {
>  			goto cleanup;
>  		}
> @@ -2113,7 +2113,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>  
>  		submit_bio(bio);
>  	}
> -out:
> +
>  	return 0;
>  
>  cleanup:
> -- 
> 2.17.1
