Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D823D11AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhGUONo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:13:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59808 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhGUONo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:13:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2C1BF1FEBA;
        Wed, 21 Jul 2021 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626879260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iG6EG+s5mGlI5ABLK6K1vIhu9C41386lkKJvcLXTuGc=;
        b=KgNjDNNcMfs+fECzhnh1E29quw8HoOfAzckFd9DxhxlsrG4Zno4BICsd1t4zqhHYXNSsOU
        6vfir+3FMPDkJr5/mR9aCWHcOeyByvXmHHAPBuy7EQ2RwXCH/CyhRNs7I9pm7csIQITd1z
        AEF5nq9p43E1NTW+85rquzrfNK3HSMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626879260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iG6EG+s5mGlI5ABLK6K1vIhu9C41386lkKJvcLXTuGc=;
        b=cN4WSWfj4tSU8z0YClew9t9kXusuJ6iAPhFbmFpEf14x5thm5HeGi5lA/AIz7FnwAQhKQR
        34kxDQ2N6paBB8CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2404CA3B84;
        Wed, 21 Jul 2021 14:54:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C76B6DA704; Wed, 21 Jul 2021 16:51:38 +0200 (CEST)
Date:   Wed, 21 Jul 2021 16:51:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: Use NULL in btrfs_search_slot as trans if we only
 want to search
Message-ID: <20210721145138.GG19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210720180247.16802-1-mpdesouza@suse.com>
 <974764fb-d786-448c-4930-01bf52367db1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <974764fb-d786-448c-4930-01bf52367db1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 03:37:03PM +0300, Nikolay Borisov wrote:
> 
> 
> On 20.07.21 г. 21:02, Marcos Paulo de Souza wrote:
> > Using a transaction in btrfs_search_slot is only useful when if are
> > searching to add or modify the tree. When the function is only used for
> > searching, insert length and mod arguments are 0, there is no need to
> > use a transaction.
> > 
> > No functional changes, changing for consistency.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Basically when cow is 0 and ins_len is also 0 then no paths which
> utilize a transaction are called so this patch is fine.

This sounds like a recipe for an assertion.
