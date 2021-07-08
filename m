Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0DA3BF965
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGHL71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:59:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhGHL71 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:59:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA6BE220CC;
        Thu,  8 Jul 2021 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625745404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HL6kLeSYQ1bwCkHl7aX2V3CGl2gr8A7T3K2QRADPviA=;
        b=LTIhMUu6cQDW7FNUK1/2MdqtixJ1xHZ2iT+RU9ImrmqJT3zCpAS5nG8tT3rCVW4UnYnIBB
        ERlTI3a0jvMg2PLP2reg3uQN8j1m1PtP8TgptzhPGgvVEAfb5gH5cYQMs6uY7GvggHjGIB
        r85NyxU28gj8DiRnwLQ1WXMqJSq2IIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625745404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HL6kLeSYQ1bwCkHl7aX2V3CGl2gr8A7T3K2QRADPviA=;
        b=LwKvCxYI491snt8CP126Jd87poxkQPf7XHx83hjmAAXUD4vv+gQhmb6GFRJZE3l7qUk/ue
        xGkxR1oPXnzKNoDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D4283A3B9A;
        Thu,  8 Jul 2021 11:56:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1CBADAF79; Thu,  8 Jul 2021 13:54:10 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:54:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 02/15] btrfs: remove the GFP_HIGHMEM flag for
 compression code
Message-ID: <20210708115410.GX2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705020110.89358-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 05, 2021 at 10:00:57AM +0800, Qu Wenruo wrote:
> This allows later decompress functions to get rid of kmap()/kunmap()
> pairs.
> 
> And since all other filesystems are getting rid of HIGHMEM, it should
> not be a problem for btrfs.
> 
> Although we removed the HIGHMEM allocation, we still keep the
> kmap()/kunmap() pairs.
> They will be removed when involved functions are refactored later.

I've sent the highmem cleanup and will drop this patch, there should be
minimal conflicts in the followup changes.
