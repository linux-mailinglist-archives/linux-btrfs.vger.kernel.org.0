Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CB49FCEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349601AbiA1Per (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 10:34:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55684 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349600AbiA1Peq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 10:34:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 395392114E;
        Fri, 28 Jan 2022 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643384085;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nesMCb7K2dcu2Xfi3ILRzbOLPLMDUKrC07c5AbgjpBE=;
        b=DXxnHJZ/7+20HgLjrfwo4D6bP5myDKsvku8utNJ2Urma/c13pwoCDXLNefz14ib72DMDAW
        /mDxfaXrsKmWqTlNwd3VsH5TKAEzaWYlshTVA4CHkq5r5kLXKBAfD++2OEl47igcI5ztl+
        sLRXuyUuL7RjsPGldamqs1OnxHWxbbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643384085;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nesMCb7K2dcu2Xfi3ILRzbOLPLMDUKrC07c5AbgjpBE=;
        b=y8pUEtgLN8rDQktj3txQi98SbMVI4B4RmzfwRbNs94Bp0hQZTZYnVL6QeizEknply0UOJM
        ES3xAPveIKA9mDCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2BB85A3B8B;
        Fri, 28 Jan 2022 15:34:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C1BCDA7A9; Fri, 28 Jan 2022 16:34:03 +0100 (CET)
Date:   Fri, 28 Jan 2022 16:34:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix an IS_ERR() vs NULL bug
Message-ID: <20220128153403.GH14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20220127084834.GB25644@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127084834.GB25644@kili>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 11:48:34AM +0300, Dan Carpenter wrote:
> The alloc_dummy_extent_buffer() function does not return error pointers,
> it returns NULL on failure.
> 
> Fixes: 5068210cf625 ("btrfs: use dummy extent buffer for super block sys chunk array read")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Folded to the patch, thanks.
