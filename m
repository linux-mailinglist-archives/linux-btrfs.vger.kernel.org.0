Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38F54466C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 17:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhKEQMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 12:12:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhKEQMF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 12:12:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B25E32171F;
        Fri,  5 Nov 2021 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636128564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fxw3jOmQcSFcrCMMRJzYHSC4f9/FTd6OS6ASmVdZfN8=;
        b=gQ0EBeBNiFS9Rtxw5NLjsKPkWwtuX6RjHkj7e7k/iFXQ3AnCFq6Ao95MbjlPzQCwcfftgP
        tF8pb63Zn1dNjDHiuief4k18F4VKIufTEjVCLr4rb/dqpVjZ5C4haYwNUQ5rO/1bjJ+Obz
        3/s9y2qoBX2lM7JZZSuoi8tPL8FxifM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636128564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fxw3jOmQcSFcrCMMRJzYHSC4f9/FTd6OS6ASmVdZfN8=;
        b=iSJQi9a8wH/VIihETUAjtV2mot+vo1cEtKq8ZKwPE0ebLevZuwHc0MgM0LJAVESseD8nq8
        DxYpTPu/ZhhwTZBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AB8E62C154;
        Fri,  5 Nov 2021 16:09:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80E41DA781; Fri,  5 Nov 2021 17:08:47 +0100 (CET)
Date:   Fri, 5 Nov 2021 17:08:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs reflink take too long time(21s)
Message-ID: <20211105160847.GI28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org
References: <20211103184134.631B.409509F4@e16-tech.com>
 <20211105210854.9367.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105210854.9367.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 09:08:54PM +0800, Wang Yugui wrote:
> Is this problem reproduced by other people?
> 
> It seems a blocker kernel  issue for the coming btrfs-progs 5.15 release.
> becase  DUP metadata become default for single SSD in the coming btrfs-progs 5.15 release.

I don't consider it a blocker for btrfs-progs 5.15 release, the same set
of features can be enabled manually and it's reproduced by a fstest case
that's crafted to specially to make reflink slow and monitor how it
reacts to ctrl-c. This is probably a performance issue and to be fixed
on kernel side anyway.
