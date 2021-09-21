Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D08413B0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhIUT6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 15:58:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57328 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhIUT6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 15:58:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C1DAE1FF16;
        Tue, 21 Sep 2021 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632254204;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vr+Gja9TrhFG3u1W6iKBhRN4fCBxyUv5ixDzutqPJB0=;
        b=YTeiqhd88Fm7he4k5yhyiAlNAxFNEHM6zKtVBwUUCTAgyLnAIB21+GulIAL/ZbQ8sCgZH0
        KrareYRVpwvBbNNSiIRQlNNNSKvB3SosvZs1kHPMadmXKm5/vDElC34EfHdK3r/D4leIzL
        Qo4fPkjs66mWasUxrTdrs33qUOPvfQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632254204;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vr+Gja9TrhFG3u1W6iKBhRN4fCBxyUv5ixDzutqPJB0=;
        b=KOy+Bt5gGl10YUHNYsq2VO8lk355Qv1ncqlReVkRkjBoIjNehtXdIHc48zLM56h6lFmQ6N
        6aKoQpzXcBse6rBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BAC4EA3B96;
        Tue, 21 Sep 2021 19:56:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F0E0DA72B; Tue, 21 Sep 2021 21:56:32 +0200 (CEST)
Date:   Tue, 21 Sep 2021 21:56:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.15.0-rc1 armv7hl Workqueue: btrfs-delalloc btrfs_work_helper
 PC is at mmiocpy LR is at ZSTD_compressStream
Message-ID: <20210921195632.GR9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtT+OuemovPO7GZk8Y8=qtOObr0XTDp8jh4OHD6y84AFxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtT+OuemovPO7GZk8Y8=qtOObr0XTDp8jh4OHD6y84AFxw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 06:13:07PM -0600, Chris Murphy wrote:
> https://kojipkgs.fedoraproject.org//work/tasks/8820/75928820/oz-armhfp.log

> 00:09:50,679 EMERG kernel:[<c08bd768>] (mmiocpy) from [<c089c314>]
> (ZSTD_compressStream+0x184/0x294)

The last function to fail is inside ZSTD implementation in kernel.
If btrfs passes wrong data to zstd we'd see that also on non-arm builds,
so guessing by mmiocpy as a copy-something function it could be some
sort of alignment problem that works on x86_64 but throws an exception
on arm as it's stricter about alignment.
