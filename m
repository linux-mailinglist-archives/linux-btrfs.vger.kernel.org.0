Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD734139E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 20:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhIUSSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 14:18:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39350 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhIUSSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 14:18:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AEAE91FF0F;
        Tue, 21 Sep 2021 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632248238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToPl1jc4jFrm/PD8PFBabtOo1t83stPjBaT/oBT84h8=;
        b=NwKwML64Wo84hCL46UdnmcDJPiejKlrl7s5lViusoENw6To+wyZD4x4iy4gif5vuHy1+lK
        kqp+T/zlMDmTQ8GmqUGAS/NNayb1Xh+Hy26Xlu1oai0lFzuyOKz4epqI1Q0871BB4SVnXQ
        TH7sbKT8QsbFQcgjaG9eg7nvulgLTDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632248238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToPl1jc4jFrm/PD8PFBabtOo1t83stPjBaT/oBT84h8=;
        b=Fo2nDuZErzeYfKkctXNmfsEQ7+iAaUpEKPHvhDYz7GDDo3RGueQBkHj41yYhrStY7P4CZz
        0O4gHuvz9o3aKyDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A83F7A3B84;
        Tue, 21 Sep 2021 18:17:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C042DA72B; Tue, 21 Sep 2021 20:17:06 +0200 (CEST)
Date:   Tue, 21 Sep 2021 20:17:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: aarch64: Unsupported V0 extent filesystem detected.
Message-ID: <20210921181705.GP9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQsqsDwzUegUgYAo2PccUP9q=DKKA7kUNtRcbttW-nQrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQsqsDwzUegUgYAo2PccUP9q=DKKA7kUNtRcbttW-nQrw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 21, 2021 at 11:40:17AM -0600, Chris Murphy wrote:
> Downstream bug report with a 5.13.12 kernel.
> https://bugzilla.redhat.com/show_bug.cgi?id=2000482

The report says it's a fresh filesystem so it's not like that it's an
ancient filesystem. As it's on ARM64 machine first hint would be some
endinanness issue but we've been testing on that architecture for a long
time so it can't be a new issue.
