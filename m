Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26E94836B1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiACSSB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:18:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57736 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiACSSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:18:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6AF63210F7;
        Mon,  3 Jan 2022 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641233879;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNVo/Hi3GadVnVTd21K+xznpguwwQzRe3HR6SqtX7Wc=;
        b=MPYVzUfXYam/CcqhBE57ImlKkPP0+t7yJmaTBwyBIkZ8wUmBAAuVzRJBuoYp30aDYpn3g0
        Xdq0q9hT+nmmngKWvdrB/prXXXRku/zpZwJHw4xZgK9lxre+pv9ddVbIgyqGiBENQZ2loq
        538+Hf+wA9+pbj2g/z6oFPJRS/s55W4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641233879;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNVo/Hi3GadVnVTd21K+xznpguwwQzRe3HR6SqtX7Wc=;
        b=pi3/Sd0NYE6iogADQPraIilB1KtfgUt+C6YlPYp2+kegaSItb4thpWKinx5tJAnCHNs9Go
        V3k1a0FCZplO0TAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 63331A3B81;
        Mon,  3 Jan 2022 18:17:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87FAFDA729; Mon,  3 Jan 2022 19:17:30 +0100 (CET)
Date:   Mon, 3 Jan 2022 19:17:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unnecessary parameter type from
 compression_decompress_bio
Message-ID: <20220103181730.GM28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20211227101839.77682-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227101839.77682-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 27, 2021 at 06:18:39PM +0800, Su Yue wrote:
> btrfs_decompress_bio, the only caller of compression_decompress_bio gets
> type from @cb and passes it to compression_decompress_bio.
> However, compression_decompress_bio can get compression type directly
> from @cb.
> 
> So remove the parameter and access it through @cb.
> No functional change.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Added to misc-next, thanks.
