Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE273B0297
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFVLTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 07:19:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFVLTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 07:19:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0505E2197E;
        Tue, 22 Jun 2021 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624360614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75jDg7aJB1XhocWzVBz1IrJi+PfLRwDXduDW8DyGKiU=;
        b=X1lA3fY5nVeRrJIMOgmfrfp7ICpePQrkL0DXphACt9+nEfar/goMwmX8Wk6thlzqGuDOdz
        j7ZoOI+LbeLzTom0S2C63G+DXLN+LN7LmzFsrNYxPKfUIZdrhrIqZbL8cu1MLy6Vm0tNTn
        j1SpLdP8KOqUJGgp83ExAUwxVlmWnNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624360614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75jDg7aJB1XhocWzVBz1IrJi+PfLRwDXduDW8DyGKiU=;
        b=5lUfjVcdq/ZQCJKmJtlHpQOLcpAyY1cEO98NAYiKkNTjnJMoi/AagqZXYWH4pACYqwW2se
        /F0krqGOymbhvyBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F1413A3B85;
        Tue, 22 Jun 2021 11:16:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41DC6DA79B; Tue, 22 Jun 2021 13:14:03 +0200 (CEST)
Date:   Tue, 22 Jun 2021 13:14:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/9] btrfs: compression: refactor and enhancement
 preparing for subpage compression support
Message-ID: <20210622111403.GF28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210617051450.206704-1-wqu@suse.com>
 <20210617164703.GW28158@twin.jikos.cz>
 <d184445f-a1a1-3f17-c33d-ffe3fc066c66@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d184445f-a1a1-3f17-c33d-ffe3fc066c66@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 18, 2021 at 06:46:51AM +0800, Qu Wenruo wrote:
> > I went through it several times, the changes are scary, but the overall
> > direction is IMHO the right one, not to say it's fixing the difficult
> > BUG_ONs.
> >
> > I'll put it to for-next once it passes a few rounds of fstests. Taking
> > it to 5.14 could be risky if we don't have enough review and testing,
> > time is almost up before the code freeze.
> >
> Please don't put it into 5.14.
> 
> It's really a preparation for subpage compression support.
> However we don't even have subpage queued for v5.14, thus I'm not in a
> hurry.

Ok, no problem. As merge window is close I'll keep the compression and
subpage out of for-next until rc1 is out, the timestamped for-next
snapshots branches could contain it so we can start testing.
