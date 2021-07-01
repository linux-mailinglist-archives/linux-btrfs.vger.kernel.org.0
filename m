Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5B43B9687
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhGAT2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 15:28:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhGAT2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 15:28:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 066F82291E;
        Thu,  1 Jul 2021 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625167579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CKw8sqmE5COZNa7Q5/cnlD8pAMA1o1TWNHiQ7N4ghA4=;
        b=pmRMHz+0dnEojfQ0Xci4Iz2VTnrC7SwASX3e8eqzHNGBN9hvgLXSIYNCpGnv03r5Kfmdbh
        mVhzBUpNkdiAXQsitU6nM4oL080MM9VBq8CXN7UPaWRjKcCM6nTnizak4Xg8YW7zKORBHS
        RILuv1h1/QaI5DFrR57/lQLv+JG8Hik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625167579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CKw8sqmE5COZNa7Q5/cnlD8pAMA1o1TWNHiQ7N4ghA4=;
        b=E9FP9Fi5hOGZuFR+YGUfMokdhtRA2X/UZZ2CGaegi+Jseigx8VXfmtrvwpUete+Apa7rEb
        S3az+CxWOMR/CRAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F3668A3B88;
        Thu,  1 Jul 2021 19:26:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 436E3DA6FD; Thu,  1 Jul 2021 21:23:48 +0200 (CEST)
Date:   Thu, 1 Jul 2021 21:23:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: zoned: fix memory leak in btrfs_sb_io()
Message-ID: <20210701192347.GB2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210626150344.25860-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626150344.25860-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 26, 2021 at 03:03:44PM +0000, Sidong Yang wrote:
> In btrfs_sb_io(), blk_zone_report is used for getting information about
> zones. But it is not freed if code goes in usual path. This patch frees
> the variable just after it used.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Added to devel, thanks.
