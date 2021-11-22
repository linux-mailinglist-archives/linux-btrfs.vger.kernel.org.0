Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109314594AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 19:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhKVS1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 13:27:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50814 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhKVS1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 13:27:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 011F11FD39;
        Mon, 22 Nov 2021 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637605449;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wwbUYh/esw9ob5vYLYStUneiTFn6S4GgUXudjr+3JOc=;
        b=YB5CkL4ibo1LXDDy8hTQ5pPcqO1CxSPjysyJ52f7VeTAr2spJWJs1RgiX0TOgSdNAVwPwB
        GKXiDlieRg01B/F9sSYejQteXYD0A5gSzss2GiibDMiFuj9R/oNFEXdGTc2xKKjAVkn8wF
        nfmWPsiO68TTbWG+E0X43SnPQciwGXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637605449;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wwbUYh/esw9ob5vYLYStUneiTFn6S4GgUXudjr+3JOc=;
        b=MyIi1AFAwL7AynvJ6/VOabIUnneHLEsJZw8N+HzEmP4vXTFYhtZwJREcLbg9/6gI22BtHu
        CfRXWSP8bvKFXUDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EE586A3B81;
        Mon, 22 Nov 2021 18:24:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35F5BDA735; Mon, 22 Nov 2021 19:24:02 +0100 (CET)
Date:   Mon, 22 Nov 2021 19:24:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: get next entry in tree_search_offset before doing
 checks
Message-ID: <20211122182402.GN28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211122151646.14235-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122151646.14235-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 05:16:46PM +0200, Nikolay Borisov wrote:
> This is a small optimisation since the currenty 'entry' is already
> checked in the if () {} else if {} construct above the loop. In essence
> the first iteration of the final while loop is redundant. To eliminate
> this extra check simply get the next entry at the beginning of the loop.
> ---

Added to misc-next, thanks.
