Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54B39E64A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 20:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFGSQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 14:16:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35226 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGSQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 14:16:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D9091FD33;
        Mon,  7 Jun 2021 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623089657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQ5o6xop42qPLbRXKQBU46D0WF3DUOnpKBC6c9QbmbQ=;
        b=Yo89HEXnINNpVVgRWbyOX8EC+0FS9cDEf98O7X2QmmtF7gdHHYjxI68CiRugmjjmL+GQIJ
        nPRak9Rppg7oOjuVEHCO6qLd4jHKS/14AmK8M19QElgozwkoaM769RPxfIBZn765wdceL0
        eKAOlFnSqEuOCoxFOFfz9mPUrDljFnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623089657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQ5o6xop42qPLbRXKQBU46D0WF3DUOnpKBC6c9QbmbQ=;
        b=fPAnRaYWp0phLeBdNm8Rx2zvJUWCLBM8ude0bc5QWxl34cxbNJ/ScZrz2Mn6zU/uc5vguc
        UOSOySMW/X0pG3BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 30B3EA3B94;
        Mon,  7 Jun 2021 18:14:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D6A0DA8CA; Mon,  7 Jun 2021 20:11:33 +0200 (CEST)
Date:   Mon, 7 Jun 2021 20:11:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused btrfs_{set,clear}_pending_and_info
 macros
Message-ID: <20210607181132.GI31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <9a2e763258dd00074e682f3783ec2156afff8450.1623051748.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2e763258dd00074e682f3783ec2156afff8450.1623051748.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 07, 2021 at 04:42:49PM +0900, Johannes Thumshirn wrote:
> Commit 5297199a8bca ("btrfs: remove inode number cache feature") removed
> the last user, but forgot to remove the macros as well. Let's do that now.

This is part of the pending actions API, it's a way how to do some whole
filesystem change from an unsafe context. The bit is set and the rest is
done inside transaction commit at the same time.

I'm thinking if we're going to have such options, the free space tree
would qualify but it's done in another way. The no-holes can be also
technically switched on a mounted filesystem because the code handles
both cases. So I'm not sure if we want to remove it without evaluation.
