Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35364A5DEE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiBAOGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 09:06:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38610 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiBAOGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 09:06:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AB0F31F37F;
        Tue,  1 Feb 2022 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643724391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5hp9VL4wv0jZCM16FJnuiDkZjEsCZ05FrYmJce5e9k=;
        b=k5pOFVczRC0/ClsElZNf98FsVc2PGJnLzUKq3xcuKA/IpE2MV2T770qnibosCW0u8+I55J
        JYeYyOW0lQbIj0OsKFPQch4JPplpyFFmKKwSWSlNDw94rLxufyELJeIDwmDI8iuhAoaRMv
        NqG2PMxDf9n/uvbMohYFYUEMIc24lyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643724391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5hp9VL4wv0jZCM16FJnuiDkZjEsCZ05FrYmJce5e9k=;
        b=BmYhM/saeXzPT3qeqPdmcywwzwmfJxQ7abfHtmxArXP/Tnnem4cLdfavQ69/vn45vEmO9h
        QbSNvqvf7J/KW4Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7DB24A3B84;
        Tue,  1 Feb 2022 14:06:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C1AADA7A9; Tue,  1 Feb 2022 15:05:47 +0100 (CET)
Date:   Tue, 1 Feb 2022 15:05:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove dead code
Message-ID: <20220201140547.GO14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220128115027.1170373-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128115027.1170373-1-usama.anjum@collabora.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 04:50:27PM +0500, Muhammad Usama Anjum wrote:
> Local variable stop_loop is assigned only once, to a constant value 0,
> making it effectively constant through out its scope. This constant
> variable is guarding deadcode. The two if conditions can never be true.
> Remove the variable and make the logic simple.
> 
> Fixes: 585f784357d8 ("btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub")

Thanks, this patch is still only in for-next so the change can be folded
into it.
