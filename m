Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8B3F97E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244724AbhH0KPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 06:15:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35510 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244492AbhH0KPw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 06:15:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A9341FEE8;
        Fri, 27 Aug 2021 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630059303;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMSISrx/LJtQ6pg6KYrxO95iRyrmvPvFjOmUyUTBe6E=;
        b=u81WxU72uJii4NUyRoS37JuogNb0Y4Rq3dqVYi2febnLkRCxETiRtNcZNx66Q3NxVjyxOw
        u2SLdD8gstM55ze9D0A4/JEDch3HJvfnPef/XSsgv9k1bB9FxOIYHAUVHRxgriCB9pjxIE
        O0cnTLGzpV3gOwPcW8ekDdp9qC5bXyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630059303;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMSISrx/LJtQ6pg6KYrxO95iRyrmvPvFjOmUyUTBe6E=;
        b=veJuhMJfGNs/6EyZNIE6BqBGbq80hg218iEdBdlJ/O3a3GYOo3sYrrduN4Q4K1hxBuc0SX
        /sDcZhBoU1PPi5CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 42A0EA3B91;
        Fri, 27 Aug 2021 10:15:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 63655DA7F3; Fri, 27 Aug 2021 12:12:14 +0200 (CEST)
Date:   Fri, 27 Aug 2021 12:12:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we
 don't have enough pages"
Message-ID: <20210827101213.GW3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210825054142.11579-1-wqu@suse.com>
 <20210827114153.19CB.409509F4@e16-tech.com>
 <025d8f85-a86c-63be-14be-a3f1e2170107@gmx.com>
 <20210827083532.GS3379@twin.jikos.cz>
 <467cadfd-8b30-5a9e-9b7a-812cb4902185@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <467cadfd-8b30-5a9e-9b7a-812cb4902185@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 27, 2021 at 05:31:54PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/27 下午4:35, David Sterba wrote:
> > On Fri, Aug 27, 2021 at 01:04:56PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2021/8/27 上午11:41, Wang Yugui wrote:
> >>> Hi,
> >>>
> >>> With this patch, kernel panic when xfstest btrfs/244
> >>
> >> It's completely unrelated.
> >>
> >> The fix for btrfs/244 is beadb3347de2 ("btrfs: fix NULL pointer
> >> dereference when deleting device by invalid id").
> >
> > The commit has been tagged for 5.4 but I don't see it in the stable
> > repo, there are no conflicts when applying. I don't know why,
> > nevertheless I can ask for merging it again.
> >
> 
> I guess it's because the patch is not pushed for mainline yet?
> 
> The latest pull only contains my revert for the compressed inline, not
> this one...

Ah right, I did 'git describe' and saw 5.14-rc6, but it's still in
misc-next.
