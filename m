Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0083F47732B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 14:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhLPNb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 08:31:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53962 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhLPNb1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 08:31:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E0C93212B6;
        Thu, 16 Dec 2021 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639661485;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kgZ85dUi7/e3j0iGpbKX5ecZJklujz7goJ8ufzL4EwQ=;
        b=g6l/e8OathTxSfK/o4gjPdcbPGVSDKTfXEAaTBJr2BOCeuMG0VySYJruKvDRpfWWcr2lcf
        vBsENDzbjCNZtKkdnHlH/jckuI6TiAJCRLYdOz/aC2aFmODVdtM8RepdEc3JiFfyOZPck2
        YAeeJ0tEFcAGgPHvL7F2WafHC9ZPsJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639661485;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kgZ85dUi7/e3j0iGpbKX5ecZJklujz7goJ8ufzL4EwQ=;
        b=MtkaLr33AdSjZbT4xyhb6ghvUDwSAqefFvCAtkk6+u1k0V9L9GGMdSsFrsWyKlXXIyqSvN
        sc7cpjG6XlOKf3Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B6EBFA3B81;
        Thu, 16 Dec 2021 13:31:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6795BDA781; Thu, 16 Dec 2021 14:31:06 +0100 (CET)
Date:   Thu, 16 Dec 2021 14:31:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] btrfs: Fix kernel-doc formatting issues
Message-ID: <20211216133106.GE28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yang Li <yang.lee@linux.alibaba.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20211216070813.28183-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216070813.28183-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 03:08:13PM +0800, Yang Li wrote:
> Add function names to the kernel-doc of some functions and upgrade
> descriptions of some parameters in it.
> 
> The warnings were found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.

Thanks, we care only about the argument list that the kdoc format and
script can verify, the rest is not really useful for internal functions
and makes it less pleasant to read.  The script will report that though
but we won't fix it, rather would like to see the script updated to
skip that.
