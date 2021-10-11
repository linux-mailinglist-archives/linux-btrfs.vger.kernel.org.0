Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0308429300
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 17:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJKPTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 11:19:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35282 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhJKPTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 11:19:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8222E220EF;
        Mon, 11 Oct 2021 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633965472;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XftdzVQe+wzE/OUo7fNIf+i4gecXJWBm2E4s+9NiRNs=;
        b=GNB0gydhAI7lTvRKxaeDpCUO2Ll/foF1L4qs8iAOadphw1lZJAqT14H2i16oO8FncN+kEC
        MvTxqrA+upmAwLuILd1ZFkta7c6uZicEt8YH4tBYLRWsXSIvhDma4LTvBKGtamC1QTs2J0
        r905xXDiq/cu7my8InNaT0M50s+lw1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633965472;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XftdzVQe+wzE/OUo7fNIf+i4gecXJWBm2E4s+9NiRNs=;
        b=dBFrlCsbWTF2S3rHdiHFgbK759BCz0rFqoHMHcer+rrw8psOJ8iHYbpuYG1UUHt1Ih7+WJ
        27DHqodXYWDUQ1AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7B5C5A3B87;
        Mon, 11 Oct 2021 15:17:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 527EDDA781; Mon, 11 Oct 2021 17:17:29 +0200 (CEST)
Date:   Mon, 11 Oct 2021 17:17:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: clear BTRFS_DEV_STATE_MISSING bit in
 btrfs_close_one_device
Message-ID: <20211011151728.GS9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <1633367733-14671-1-git-send-email-zhanglikernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633367733-14671-1-git-send-email-zhanglikernel@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 01:15:33AM +0800, Li Zhang wrote:
> bug: https://github.com/kdave/btrfs-progs/issues/389
> 
> The previous patch does not fix the bug right:
> https://lore.kernel.org/linux-btrfs/1632330390-29793-1-git-send-email-zhanglikernel@gmail.com
> So I write a new one

This looks correct, dropping the bit when we decrease the missing device
counter. I've added the patch to for-next for now, thanks.
