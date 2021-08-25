Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288303F7596
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbhHYNIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 09:08:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55284 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbhHYNIU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 09:08:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B3C1221A6;
        Wed, 25 Aug 2021 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629896854;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w41xtxu+kIWOk7IISwrfAy0sDUd4sPBsZ9XG//JIf2Q=;
        b=P3ZWQDz4o4KM84dvaLNmhqcjz5PlPzG8ZQmNBV/YYkKT1OQ1dnqebLu5eeRFqJ08nbGon5
        RbhYn3Ipmj7cWHnjv/rUhI5lKGozK0rEfbLWY83FNmb0umWCh/PSK7ztP3WzZ8kQJ7SMVq
        MB2I4rupnCc7FIRMOewfLHBENTy3I6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629896854;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w41xtxu+kIWOk7IISwrfAy0sDUd4sPBsZ9XG//JIf2Q=;
        b=KJcZ+w+S7Qzx9BH0Iv1MBPZGhjr6eY3HQ/JH0XP9GUCpbCL+fJj6XAwJOC0ckXTXWGaCLK
        gExunccXOuInUPCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 53D93A3B8C;
        Wed, 25 Aug 2021 13:07:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4FE8DA799; Wed, 25 Aug 2021 15:04:46 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:04:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we
 don't have enough pages"
Message-ID: <20210825130446.GH3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210825054142.11579-1-wqu@suse.com>
 <20210825115559.GG3379@twin.jikos.cz>
 <d0dccd5e-c67f-a18d-8d6e-559504b5ee91@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0dccd5e-c67f-a18d-8d6e-559504b5ee91@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 25, 2021 at 08:06:57PM +0800, Qu Wenruo wrote:
> On 2021/8/25 下午7:55, David Sterba wrote:
> > On Wed, Aug 25, 2021 at 01:41:42PM +0800, Qu Wenruo wrote:
> >> This reverts commit f2165627319ffd33a6217275e5690b1ab5c45763.
> > 
> > At this point the revert is the simplest way to restore the inline
> > extent compression so that's what I'll probably do. However.
> >>
> >> [BUG]
> >> It's no longer possible to create compressed inline extent after commit
> >> f2165627319f ("btrfs: compression: don't try to compress if we don't
> >> have enough pages").
> >>
> >> [CAUSE]
> >> For compression code, there are several possible reasons we have a range
> >> that needs to be compressed while it's no more than one page.
> >>
> >> - Compressed inline write
> >>    The data is always smaller than one sector.
> > 
> > The missing logic was for the true inline extent. The patch was supposed
> > to skip compression for single pages other than inline extents, due to
> > efficiency. So I wonder if we want to do that or just don't bother as
> > it's probably a negligible amount of wasted time.
> 
> Yeah, I guess that's the case.
> 
> We may be able to do such check in the future, but at that time, we need 
> to take inline extents into consideration.
> 
> Thus it won't be just a simple @nr_pages check, but with extra 
> @start/@len check.

Yeah that's why revert is better than enhancing the test with the mising
bits.
