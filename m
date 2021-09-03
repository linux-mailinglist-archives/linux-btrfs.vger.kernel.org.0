Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3640005E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhICNVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 09:21:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46178 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhICNVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 09:21:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 693FD1FD88;
        Fri,  3 Sep 2021 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630675254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wuBzmE77a9qXswzZsKsNOwc8R0LT8Tx0Y+QUWQ9s+k=;
        b=s/I3z8V1jf1OxhKsVGBReI184mW2LHhboofgqT0w1wgnM3cosnVYufsGwSsvSHoiVUXqth
        apc220D9X8QVi3KahDYh4iMFStpXL99r4MV72VvdMPUhMAJFuFhj60XODlLCb8Ry7E1MSw
        Z6EqASiTfMkiwL7YiJm9n+od1vJRFSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630675254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wuBzmE77a9qXswzZsKsNOwc8R0LT8Tx0Y+QUWQ9s+k=;
        b=3L+sNsIxAY5AxmkWrh7a24uT52hsiMSdsl2TKMczp57dsoWj34druzAppy5S/p8fnaj4oS
        NZlJYPuUdw2um/Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 622C6A3B97;
        Fri,  3 Sep 2021 13:20:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0818DA72B; Fri,  3 Sep 2021 15:20:52 +0200 (CEST)
Date:   Fri, 3 Sep 2021 15:20:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unexport repair_io_failure()
Message-ID: <20210903132052.GC3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210903124514.71575-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903124514.71575-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 08:45:14PM +0800, Qu Wenruo wrote:
> Function repair_io_failure() is no longer used out of extent_io.c since
> commit 8b9b6f255485 ("btrfs: scrub: cleanup the remaining nodatasum
> fixup code"), which removes the last external caller.
> 
> Just unexport it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
