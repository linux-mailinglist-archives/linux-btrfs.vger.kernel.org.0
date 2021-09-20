Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BB4110FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhITIdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 04:33:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbhITIdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 04:33:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1099520044;
        Mon, 20 Sep 2021 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632126697;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKPoVGaFIvbSkqjGcRpr2zpT4zM6QwAsLVmZvBDIYS0=;
        b=FHLTpE06xTyn4qVnJu8WyYRpGUTqaQE0vtfTRZq3fsuPRsuUwgveqFuJsC0nkFpBYEzyJp
        K88Nmsibwd2Uwvoy2sykpvSC7+92/EtW9Vx23kFX8z1E1+vtG/tgjSccFDosqTt8plfvJE
        Irh/3Nn9QkudIYgios4/34jYxLDv90M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632126697;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKPoVGaFIvbSkqjGcRpr2zpT4zM6QwAsLVmZvBDIYS0=;
        b=MDTAda5yaE00pZmRAH4k+K5gXUk8+0+n5ganREvvEud9wWfHJIjjZNskeTb74O5Z9bGHBG
        GFnIdVqMeOAUpzCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0859DA3B9D;
        Mon, 20 Sep 2021 08:31:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6C65DA781; Mon, 20 Sep 2021 10:31:25 +0200 (CEST)
Date:   Mon, 20 Sep 2021 10:31:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
Message-ID: <20210920083125.GZ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
 <20210920081246.GX9286@twin.jikos.cz>
 <7be281ea-1811-0ffe-0c78-c7491cafc3a6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be281ea-1811-0ffe-0c78-c7491cafc3a6@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 04:25:24PM +0800, Qu Wenruo wrote:
> > Kees Cook does a tree wide unification to { } because there are some
> > oddities with partial initialization and { 0 } so this will get fixed
> > eventually.
> 
> Does this mean in the future only "= { }" is preferred?

Yes,
https://lore.kernel.org/all/20210910225207.3272766-1-keescook@chromium.org/

> It would looks a little weird to me as C89/C90 doesn't allow this.
> 
> And I guess checkpatch would also be updated to handle that?

I think so but we can always override what checkpatch suggests.
