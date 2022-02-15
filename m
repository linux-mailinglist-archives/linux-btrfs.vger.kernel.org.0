Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6684B6BB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 13:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiBOMJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 07:09:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiBOMJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 07:09:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC58F11AA
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 04:09:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D9FF210DD;
        Tue, 15 Feb 2022 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644926966;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WRoPJ0A7WNJViepQA2xGv0bANExM3LRGHEniHfMbr4=;
        b=pAFFo+rJVcrjfYY8qRpnmwAswGzbbHxi+q6geLnvHLFRQpOc+SmEmUqbX3HztAkJn9XoV4
        DsEr72ttJ27KMRd4/bRD0YNloUIyBcDP1Ah6rpq4+SPx+Rrdw2xfu2SH7Yprezthvi6vFv
        Nnzgee2cOsXvchTGD5Nh6rBT64Mun8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644926966;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WRoPJ0A7WNJViepQA2xGv0bANExM3LRGHEniHfMbr4=;
        b=+sgcw796oGYU6A7Oh+pJQ1XwBpFBQyAqMe/1QKz3iQTjtrV/xRq40g/aevMh5iZQ3UoYYl
        0eg6bBixzYlW95AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2B5E7A3B85;
        Tue, 15 Feb 2022 12:09:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2403EDA818; Tue, 15 Feb 2022 13:05:42 +0100 (CET)
Date:   Tue, 15 Feb 2022 13:05:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     David Sterba <dsterba@suse.com>, lkp@lists.01.org, lkp@intel.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [btrfs]  dae7bf275f: last_state.incomplete
Message-ID: <20220215120541.GL12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, lkp@lists.01.org, lkp@intel.com,
        linux-btrfs@vger.kernel.org
References: <20220215072054.GD28159@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215072054.GD28159@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 15, 2022 at 03:20:54PM +0800, kernel test robot wrote:
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> the test's last state 'incomplete' seems be caused by below error (detail
> in attached dmesg.xz)
> 
> [   49.293458][ T3822] BTRFS info (device sdb3): flagging fs with big metadata feature
> [   49.301630][ T3822] BTRFS info (device sdb3): disk space caching is enabled
> [   49.309039][ T3822] BTRFS info (device sdb3): has skinny extents
> [   49.320312][ T3822] BTRFS error (device sdb3): invalid number of stripes 0 in sys_array at offset 17
> [   49.329910][ T3822] BTRFS error (device sdb3): failed to read the system array: -5
> [   49.346302][ T3822] BTRFS error (device sdb3): open_ctree failed

Seems that your setup has some problems with creating/using valid
filesystems. It's reported on a patch that moves a sanity check from an
ASSERT, and your kernel is not built with asserts enabled so it actually
started to test more things.

> CONFIG_BTRFS_FS=m
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set

Not set before, now it is. You may want to enable this to see if there
are more problems reported. It can be one time or enabled for all
testing, the assertions should be lightweight enough for that (compared
to CONFIG_BTRFS_DEBUG).

> # CONFIG_BTRFS_FS_REF_VERIFY is not set
