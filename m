Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C051F575E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgFJPME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 11:12:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgFJPME (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 11:12:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2D60AD65;
        Wed, 10 Jun 2020 15:12:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2ECABDA6FD; Wed, 10 Jun 2020 17:11:57 +0200 (CEST)
Date:   Wed, 10 Jun 2020 17:11:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 1/2] btrfs: Introduce "rescue=" mount option
Message-ID: <20200610151156.GK27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604071807.61345-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 04, 2020 at 03:18:06PM +0800, Qu Wenruo wrote:
> This patch introduces a new "rescue=" mount option group for all those
> mount options for data recovery.
> 
> Different rescue sub options are seperated by ':'. E.g
> "ro,rescue=nologreplay:usebackuproot".
> (The original plan is to use ';', but ';' needs to be escaped/quoted,
> or it will be interpreted by bash)

The separators available:

- "," already used for mount options
- ";" needs shell escaping
- "|" same
- "+" that also looks ok
- * & # $ % @  all would be confusing I guess

so ":" seems like a good choice.

> And obviously, user can specify rescue options one by one like:
> "ro,rescue=nologreplay,rescue=usebackuproot"
> 
> The following mount options are converted to "rescue=", old mount
> options are deprecated but still available for compatibility purpose:
> 
> - usebackuproot
>   Now it's "rescue=usebackuproot"
> 
> - nologreplay
>   Now it's "rescue=nologreplay"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I'll add the patches as topic branch to for-next and to misc-next
eventually. Thanks.
