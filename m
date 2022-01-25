Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8917449B8C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451082AbiAYQdg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 11:33:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44314 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbiAYQcP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 11:32:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7DA49210F5;
        Tue, 25 Jan 2022 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643128329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6GPmOmf6OOpHlN2SfzDETN1iRcP4uzqL/9hxWZpxFg=;
        b=kqzvB9hhucHyB0mNgSRvEtpXnO2q3c1Ws6K5UYNQQLFkINkNxSn7mbMCCx5U80yT8jd0eU
        VXbfr8RVgOrWkG0bPfn7mO8rER+MIn5nsZCUAcxe5B2Z4tl6ta0BX+SaRSX4GWy/Fi/ifu
        13YcZp79pHPltQScLX/prlzW0nsYGwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643128329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6GPmOmf6OOpHlN2SfzDETN1iRcP4uzqL/9hxWZpxFg=;
        b=onWhW748c9PLDRIkz3CTTooLrTn0PwQD4LgFkdOfQ8/a3J4uxBxawkZ5v7ztg+8xlM90d8
        FXNpt2mTovq2tCAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7424FA41D4;
        Tue, 25 Jan 2022 16:32:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE5D9DA7A9; Tue, 25 Jan 2022 17:31:28 +0100 (CET)
Date:   Tue, 25 Jan 2022 17:31:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: some fix for the comment in btrfs patch please
Message-ID: <20220125163128.GR14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
References: <20220125201301.CBA6.409509F4@e16-tech.com>
 <229e952f-f04a-e062-7915-7918b5df0c3f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229e952f-f04a-e062-7915-7918b5df0c3f@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 11:23:30PM +0800, Anand Jain wrote:
> 
> Thanks, Wang, for the report.
> 
> David,
> 
>   Could you please help fix the typo in the comments for the function
>   btrfs_free_stale_devices(). The bellow diff can be rolled into the
>    commit a67b5c57cda9 (btrfs: match stale devices by dev_t)
>   in misc-next.

Patch updated, thanks.
