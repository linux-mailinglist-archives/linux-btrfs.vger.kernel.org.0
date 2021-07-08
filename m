Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB473C14DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhGHOJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 10:09:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHOJ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 10:09:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4578522278;
        Thu,  8 Jul 2021 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625753235;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0BS12iyRMXuzFvYiezffbX++3sAv5tAUEmTfuIseH8=;
        b=1TzHDXN2ihoC+fvM1NFcQzJ9EEYzJUXyWckY8vWFiO7f8FXeqR0rVbwf7pO+FzjT9xpbqi
        +PTdBg/Y0WExM7rmOeEYTDRIT09xN1BMGb/GgwX7ZQppBgmau/71jzyrXYWKPUYk3Jd+DG
        VC4O4WD/iGiX8/27Ti+4KYiFHURoXMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625753235;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0BS12iyRMXuzFvYiezffbX++3sAv5tAUEmTfuIseH8=;
        b=Mcr1aLNKCI5WnxJLS8vkqKVDcBuHTsXdcWUg3knOi2ArcKkaLhV+QfwlRRuMf8pBLtGc/z
        T8pJDv/WTaEbKADQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3F91EA3B9C;
        Thu,  8 Jul 2021 14:07:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 114A3DAF79; Thu,  8 Jul 2021 16:04:40 +0200 (CEST)
Date:   Thu, 8 Jul 2021 16:04:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Minor improvements to should_alloc_chunk
Message-ID: <20210708140440.GB2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210702130206.30909-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702130206.30909-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 02, 2021 at 04:02:06PM +0300, Nikolay Borisov wrote:
> Since it's a predicate function make it explicitly return boolean. Also
> the  'thresh' variable is only used when force is CHUNK_ALLOC_LIMITED so
> reduce the scope of the variable as necessary. Finally, remove the + 2m
> used in the final check. Given the granularity of btrfs' allocation I
> doubt that the + 2m made a difference when making a decision whether to
> allocate a chunk or not.

This is mixing 2 cleanups and potentially a functional change in one
patch, "I doubt it made a difference" does not sound like a good
reasoning, I can say that I doubt you're right so what now? :)

Doing the cleanups (return value and moving the scope) in one is
probably fine, but the +2M change needs some explanation and should go
to a separate patch.
