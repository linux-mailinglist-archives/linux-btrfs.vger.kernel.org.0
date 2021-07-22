Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299353D251D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhGVNX0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 09:23:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51908 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhGVNXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 09:23:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D91122672;
        Thu, 22 Jul 2021 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626962640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQUkGi/tY8Arv7TQKE/d6w9RKFR1j9EFfaDs0p6YL+0=;
        b=sYBZfl0wL68O/lMMZlicc9ZAUZxXwhoh5seAfNqWcGvB7ShduNbQw52ix+IsBSQDx4xO6n
        6+4keiEyxeGvuMSYEgud7xo+3JO4RFxyvzUYY2RVFUc0nzr6+ggO3Fds5M7C4QxNBdDxAr
        tuP6Q6xglMX/beNI/ZliKOjb+ljEPx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626962640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQUkGi/tY8Arv7TQKE/d6w9RKFR1j9EFfaDs0p6YL+0=;
        b=zmOT0Vaje6NA58f87txBRn4FNMRASSlE6HQIVFK2m5CL3OWT2L40G5rVFuWEIxbX7MjGpv
        9A0seAsL17AzI+Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1272EA4B46;
        Thu, 22 Jul 2021 14:04:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6102DDAF95; Thu, 22 Jul 2021 16:01:18 +0200 (CEST)
Date:   Thu, 22 Jul 2021 16:01:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: doc: fix the out-of-date contents on
 btrfs-progs support on free space cache tree
Message-ID: <20210722140118.GW19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210714061114.189575-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714061114.189575-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 14, 2021 at 02:11:14PM +0800, Qu Wenruo wrote:
> Since v4.19, btrfs-progs has full write support to free space tree, the
> out-of-date warning in btrfs(5) has already confused some end user.
> 
> Update the content to avoid further confusion.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
