Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD545333F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhKPNzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 08:55:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhKPNzX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 08:55:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BCFE21FD26;
        Tue, 16 Nov 2021 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637070745;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UvcveD268uoUtkiQChrEB8p64Qw44Kd3U7mTB/HFZQ0=;
        b=D2fhJ8kGexYrgc0ZOHs4/7ZtEpEcGrsCNwQ7m88EjFI5h8zGffhzCkXX/7aSoRpu8OX+PZ
        GHm7mohIctdN4tyy11QffDkdoy7DsAXpjbAsDq5r+vv//Q7FzgE3YVGd87cxj+lvWBCkpj
        1DTDS1S9o8pHCIWid9EJzs35UoeZnDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637070745;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UvcveD268uoUtkiQChrEB8p64Qw44Kd3U7mTB/HFZQ0=;
        b=BhTWiHeRNuK4be6y6YChJra5J7NrnOkRXElbepZprjgTBOLt3xUGmvc1KRypPSGvMRVAIi
        PQRd2T0Wjg0lrvDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B656EA3B83;
        Tue, 16 Nov 2021 13:52:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62407DA7A9; Tue, 16 Nov 2021 14:52:22 +0100 (CET)
Date:   Tue, 16 Nov 2021 14:52:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: raid56: fix the wrong recovery condition
 for data and P case
Message-ID: <20211116135222.GP28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211116131051.247977-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116131051.247977-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 16, 2021 at 09:10:51PM +0800, Qu Wenruo wrote:
> There is a bug in raid56_recov() which doesn't properly repair data and
> P case corruption:
> 
> 	/* Data and P*/
> 	if (dest2 == nr_devs - 1)
> 		return raid6_recov_datap(nr_devs, stripe_len, dest1, data);
> 
> Note that, dest1/2 is to indicate which slot has corruption.
> 
> For RAID6 cases:
> 
> [0, nr_devs - 2) is for data stripes,
> @data_devs - 2 is for P,
> @data_devs - 1 is for Q.
> 
> For above code, the comment is correct, but the check condition is
> wrong, and leads to the only project, btrfs-fuse, to report raid6
> recovery error for 2 devices missing case.
> 
> Fix it by using correct condition.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> But I'm more interested in why this function is still there, as there
> seems to be no caller of this function in btrfs-progs anyway.

The file is there from old times when the radi56 implementation landed
and the file was a copy of something in the lib/raid6 directory, but the
sources have diverged.

The function was not used as there was no repair code in userspace, so
the question is if w still want it there or remove it.
