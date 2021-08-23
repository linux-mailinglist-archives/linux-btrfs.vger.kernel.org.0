Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54FB3F5146
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhHWTat (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:30:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60854 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWTas (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:30:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D79811FFE0;
        Mon, 23 Aug 2021 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629747004;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8zFImSBYLJU032FgVckKJCF9DAWbOIwbyTf196kQhE=;
        b=hYvYc68fIfZeJvCU1jcc42l/jF05pK/Ohym7lScGxGzbC8f2Zjq8ZXJzBpNBge6lGkojYQ
        Mu250fmEzZWHSmU3+wxdoad8axNwfmvjT38DC8JO4x/aEREAZ6z42z4CJmyXUU9uLXP36p
        5wSIo4QGKR4DmmHco9PBafJAPSN3+co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629747004;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8zFImSBYLJU032FgVckKJCF9DAWbOIwbyTf196kQhE=;
        b=7KY2ZHDAypXkwV/C9f7TBm3AspJ3plG5oUTyYa44gdyg9J4lOGCAeLRXsv8YDRVZFSCv92
        5fXVA3PJuz1jGSDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CF22EA3B84;
        Mon, 23 Aug 2021 19:30:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6599DDA725; Mon, 23 Aug 2021 21:27:05 +0200 (CEST)
Date:   Mon, 23 Aug 2021 21:27:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 08/11] btrfs: defrag: introduce a new helper to defrag
 one cluster
Message-ID: <20210823192705.GR5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210806081242.257996-1-wqu@suse.com>
 <20210806081242.257996-9-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081242.257996-9-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 06, 2021 at 04:12:39PM +0800, Qu Wenruo wrote:
> This new helper, defrag_one_cluster(), will defrag one cluster (at most
> 256K) by:
> 
> - Collect all initial targets
> 
> - Kick in readahead when possible
> 
> - Call defrag_one_range() on each initial target
>   With some extra range clamping.
> 
> - Update @sectors_defragged parameter
> 
> This involves one behavior change, the defragged sectors accounting is
> no longer as accurate as old behavior, as the initial targets are not
> consistent.
> 
> We can have new holes punched inside the initial target, and we will
> skip such holes later.
> But the defragged sectors accounting doesn't need to be that accurate
> anyway, thus I don't want to pass those extra accounting burden into
> defrag_one_range().

I think it's ok, any parallel operation can change the file during
defragmentation at any point.
