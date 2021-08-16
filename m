Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406B3ED8DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhHPOY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 10:24:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34962 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhHPOY2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 10:24:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3264D21D5C;
        Mon, 16 Aug 2021 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629123836;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LszuKe80hGtngKdJr+SZ3MBj8T/CKqYOiAtGQL8GZYo=;
        b=f23QzlCI0RjMxTY/M98n4sSoSjZaKRMqxhto7VdXg99cocpC1pGRTGZc31FxrBtmbORIOw
        h1EFmPM6pvUjyIygGKAZUULVqDoqJ4rp48y+XG/K4SUmYsF4t0gy0XmdMdLjVAjFuoYaIS
        fbv0Spn33e9zGXOyRdKQKERNgZslp9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629123836;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LszuKe80hGtngKdJr+SZ3MBj8T/CKqYOiAtGQL8GZYo=;
        b=3LU6PHxULmIemCWafJpexNWhZcTDP4z4TGKaBKPFld/A55meubNfjjOb6ZYqMr/6yd7f7S
        fU4jGTAEOJeaP4Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 29766A3B85;
        Mon, 16 Aug 2021 14:23:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80F50DA72C; Mon, 16 Aug 2021 16:21:00 +0200 (CEST)
Date:   Mon, 16 Aug 2021 16:21:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
Message-ID: <20210816142100.GD5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210802065447.178726-1-wqu@suse.com>
 <20210802065447.178726-3-wqu@suse.com>
 <594df624-3895-8787-9058-a00dba01c0cc@suse.com>
 <5e516629-05f1-7750-1f0d-34cd73e8b52f@gmx.com>
 <7953dbaf-7b7a-2279-0ac0-63bb51a51f1d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7953dbaf-7b7a-2279-0ac0-63bb51a51f1d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 02, 2021 at 11:49:38AM +0300, Nikolay Borisov wrote:
> 
> 
> On 2.08.21 г. 11:03, Qu Wenruo wrote:
> > 
> > 
> > On 2021/8/2 下午3:53, Nikolay Borisov wrote:
> >>
> >>
> >> On 2.08.21 г. 9:54, Qu Wenruo wrote:
> >>> The BUG_ON() in btrfs_csum_one_bio() means we're trying to submit a bio
> >>> while we don't have ordered extent for it at all.
> >>>
> >>> Normally this won't happen and is indeed a code logical error.
> >>>
> >>> But previous fix has already shown another possibility that, some call
> >>> sites don't handle error properly and submit the write bio after its
> >>> ordered extent has already been cleaned up.
> >>>
> >>> This patch will add an extra safe net by replacing the BUG_ON() to
> >>> proper error handling.
> >>>
> >>> And even if some day we hit a regression that we're submitting bio
> >>> without an ordered extent, we will return error and the pages will be
> >>> marked Error, and being caught properly.
> >>
> >> Would this hamper debugability? I.e it will result in some writes
> >> failing with an error, right?
> > 
> > Yes, it will make such corner case way more silent than before.
> > 
> > But IMHO the existing BUG_ON() is also overkilled.
> > 
> > Maybe converting it to WARN_ON() would be a good middle land?
> 
> If this can occur only due to code bugs I'd prefer to leave it as a
> BUG_ON. Ideally this should only trigger on developer machines when
> testing code changes.

I'd rather see a WARN_ON + the error handling code, a BUG_ON will shoot
down the whole machine. In this case it's probably serious enough but
in the long run we want to get rid of BUG_ONs that can be reasonably
handled.
