Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC83B4114B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhITMnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 08:43:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43830 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhITMnF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 08:43:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD44822016;
        Mon, 20 Sep 2021 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632141697;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeTryxi670R4S03g5DCliOop7MQqSb1fgS1wng2K/Y0=;
        b=RGJ0rH+4iRhSQcSHiyRZPWeePEZ4upv9/AtdNGgq8eio2fBcK1ck5gZCxVfnCGwz6UIWJ/
        Lqrah9599QhTxbDzianLmLjygcQbGTBpKWXGYICuj8/PzN2R0UYDg4xzTDdPsViMxep9Mz
        bH+6ayGuV0Zqhxzf25QlqylTHb8idkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632141697;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeTryxi670R4S03g5DCliOop7MQqSb1fgS1wng2K/Y0=;
        b=n4Smxc05dPT5vkfiSactjGlqArEB3x2oz/Negh52rTTW8d7tdlbZAkK/KzdLetVKDfp3Ah
        PNZadMeWKvIrYXCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C430EA3B9A;
        Mon, 20 Sep 2021 12:41:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87CFBDA7FB; Mon, 20 Sep 2021 14:41:26 +0200 (CEST)
Date:   Mon, 20 Sep 2021 14:41:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
Message-ID: <20210920124126.GK9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
 <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
 <20210917124341.GS9286@twin.jikos.cz>
 <6d4ee72e-1f3c-0d06-7ce4-6e17d296c390@suse.com>
 <ce7b5672-9aa4-607f-f21a-594f1f9d3262@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce7b5672-9aa4-607f-f21a-594f1f9d3262@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 06:33:14PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/17 20:49, Nikolay Borisov wrote:
> >
> >
> > On 17.09.21 г. 15:43, David Sterba wrote:
> >> So should we add another helper that takes the exact number and drop the
> >> parameter everwhere is 0 so it's just btrfs_io_bio_alloc() with the
> >> fallback?
> >
> > But by adding another helper we just introduce more indirection.
> >
> > Actually I'd argue that if 0 is a sane default then BIO_MAX_VECS cannot
> > be any worse because:
> >
> > a) It's a number which is as good as 0
> > b) It's even named. So this is technically better than a plain 0
> >
> 
> Any final call on this?
> 
> I hope this could be an example for future optional parameters.
> 
> We have some existing codes using two different inline functions, and
> both of them call a internal but exported function with "__" prefix.
> 
> We also have call sites passing all needed parameters just like Nikolay
> suggested.

I'm fine with explicitly using BIO_MAX_VECS instead of 0. I'll update it
in the patch, no need to resend.
