Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ECD4A9CB4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 17:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376404AbiBDQOx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 11:14:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33056 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiBDQOx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 11:14:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0DE82210F5;
        Fri,  4 Feb 2022 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643991292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3K+F6HESXAq8EYO1ppBPUXt5fXmB7LGV+xBRqHGCaE=;
        b=kl4TGK+vY5rwAUXyuyUDUmOYaUMt3nEc+71bs/9KYbwPXzc/zOXwD1NhBfeiPmrJmDCXxS
        /EICsacmPvfWyT/hEDFHEeK91guxcvMlx5EINnbTWZ4dEcK+Ak4Bv0UgeGk8/upUbxr9Zl
        wQmH+PnVo60zx770ptiP1m5XAWizfj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643991292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3K+F6HESXAq8EYO1ppBPUXt5fXmB7LGV+xBRqHGCaE=;
        b=4hr5KHwzJoLaHA8FCMmcrNRp7UaOs4qnTVx3+cDvbTRJWfwdPgc5easx+tKWlE5AzDazkU
        CbiP6YUDiPLddmDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 68D3BA3B83;
        Fri,  4 Feb 2022 16:14:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96A58DA781; Fri,  4 Feb 2022 17:14:05 +0100 (CET)
Date:   Fri, 4 Feb 2022 17:14:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        linux-btrfs@vger.kernel.org, joshiiitr@gmail.com,
        Johannes.Thumshirn@wdc.com
Subject: Re: [PATCH v2] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Message-ID: <20220204161405.GB14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <pankydev8@gmail.com>, linux-btrfs@vger.kernel.org,
        joshiiitr@gmail.com, Johannes.Thumshirn@wdc.com
References: <CGME20220204120024eucas1p24a253ca559b0ba10f6e1f2c72dbd06d8@eucas1p2.samsung.com>
 <20220204120022.101289-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204120022.101289-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 01:00:22PM +0100, Pankaj Raghav wrote:
> Remove the redundant assignment to zone_info variable in
> btrfs_check_zoned_mode function.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Added to misc-next, thanks.
