Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16571402A7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhIGOOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 10:14:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52430 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIGOOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 10:14:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C33DD20007;
        Tue,  7 Sep 2021 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631024006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hfvDzJ3vf6mSHqJCzxjE+uxgPaJy6fq0ogpV1dNJSm4=;
        b=rLpN5N4WNnOgbDKDdoYGi6zhiaPXRAB7jeBy0PiH+VXlnvRqBf7kQ9eg+/5UGCE2z8/mec
        7npvJBrAPT0tqp3SRpS8Y8RqI3tsSwuTB/dIzUM4TAXN2NXTBKZS9dVcXCdjimgV3BQYwK
        fwi33HYHAnz4V9DQLUQp7WKmd0ZtHOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631024006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hfvDzJ3vf6mSHqJCzxjE+uxgPaJy6fq0ogpV1dNJSm4=;
        b=gCrsAZsC9fJGiR5H7ZmSdIhsUmvpgRks5eHD9OXCi1epYu6aQWZl+Ptmo91hECvTth74M0
        Lb9DuBPuPT4Vb+Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BBB79A3B8C;
        Tue,  7 Sep 2021 14:13:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A22DCDA7E1; Tue,  7 Sep 2021 16:13:22 +0200 (CEST)
Date:   Tue, 7 Sep 2021 16:13:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
Message-ID: <20210907141321.GP3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816235540.9475-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816235540.9475-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 07:55:40AM +0800, Qu Wenruo wrote:
> There is a BUG_ON() in btrfs_csum_one_bio() to catch code logic error.
> 
> It has indeed caught several bugs during subpage development.
> 
> But the BUG_ON() itself will bring down the whole system which is
> sometimes overkilled.
> 
> Replace it with a WARN() and exit gracefully, so that it won't crash the
> whole system while we can still catch the code logic error.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Re-send as an independent patch
> - Add WARN() to catch the code logic error

Added to misc-next, without changes. The way with separate condition and
WARN is ok for now.
