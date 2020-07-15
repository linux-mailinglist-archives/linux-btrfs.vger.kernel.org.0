Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60841220E52
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgGONjF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 09:39:05 -0400
Received: from [195.135.220.15] ([195.135.220.15]:56884 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731785AbgGONjF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 09:39:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3CABADB3;
        Wed, 15 Jul 2020 13:39:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EC74DA790; Wed, 15 Jul 2020 15:38:41 +0200 (CEST)
Date:   Wed, 15 Jul 2020 15:38:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RESEND] btrfs: raid56: Remove out label in
 __raid56_parity_recover
Message-ID: <20200715133841.GY3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200715110217.19698-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715110217.19698-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 15, 2020 at 02:02:17PM +0300, Nikolay Borisov wrote:
> There's no cleanup that occurs so we can simply return 0 directly.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

> @@ -2083,7 +2083,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>  		 */
>  		if (atomic_read(&rbio->error) <= rbio->bbio->max_errors) {
>  			__raid_recover_end_io(rbio);
> -			goto out;
> +			return 0;

The rest of the function can be seen from that point so readability is
not hurt.
