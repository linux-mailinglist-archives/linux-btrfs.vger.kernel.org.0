Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1BDED90
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJUNaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:30:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbfJUNaH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:30:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78DD4B70D;
        Mon, 21 Oct 2019 13:30:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B14DCDA8C5; Mon, 21 Oct 2019 15:30:19 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:30:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: reduce indentation in lock_stripe_add
Message-ID: <20191021133019.GJ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191018095823.15282-1-jthumshirn@suse.de>
 <20191018095823.15282-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018095823.15282-2-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 18, 2019 at 11:58:20AM +0200, Johannes Thumshirn wrote:
> -			/* can we steal this cached rbio's pages? */

> +		/* can we steal this cached rbio's pages? */

> +		/* no merging, put us on the tail of the plug list, our rbio
> +		 * will be started with the currently running rbio unlocks
> +		 */

In patches that touch comments it's allowed if not encouraged to
reformat the comments to the preferred style. Ie. capital first letter,
aligned to 80, and not the ugl^Wnet code format. I'm fixing that in many
other patches anyway, no need to resend.
