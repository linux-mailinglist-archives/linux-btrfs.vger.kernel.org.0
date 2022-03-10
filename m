Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776114D511E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiCJSCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiCJSCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 13:02:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8EE197B72
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 10:01:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A6481F381;
        Thu, 10 Mar 2022 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646935300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvv1FrRwGyWxSvBfzdjxwAyRA7HlBJQWR63TU/5jDfY=;
        b=FziIcVCqAyn5RXjC1gNzL16Hq0vSDRnEuI5x0E3d4zc3ZkOnCSDCtqiS0ogoEjgQz2fknf
        Ncr2Klglz+EJail2gGFMWIJPeUzkytGY3RWapiQBGWB6JTZrO3DiF1fvmiItXFeufgg4Vt
        M3A775KnYWkFd0KXHGf9EpsR5h79tfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646935300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvv1FrRwGyWxSvBfzdjxwAyRA7HlBJQWR63TU/5jDfY=;
        b=pbkCACGy76WHFehR73oLVOs9dceDfuWkzK0Yj85yIqCCxcvkczdOsae5dtmCP2le71yBWW
        qkUjisSotRgt1gDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 40B02A3B81;
        Thu, 10 Mar 2022 18:01:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6FE2DA7E1; Thu, 10 Mar 2022 18:57:43 +0100 (CET)
Date:   Thu, 10 Mar 2022 18:57:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] btrfs: scrub: fix uninitialized variables in
 scrub_raid56_data_stripe_for_parity()
Message-ID: <20220310175743.GB12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <7d577c7d7683274c316dda4b8e3a8e2344e4be06.1646829087.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d577c7d7683274c316dda4b8e3a8e2344e4be06.1646829087.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 10, 2022 at 07:15:56PM +0800, Qu Wenruo wrote:
> The variable @extent_start and @extent_end will not be initialized if
> find_first_extent_item() failed.
> 
> Fix this problem by:
> 
> - Only define @extent_start and @extent_size inside the while() loop
> 
> - Manually call scrub_parity_mark_sectors_error() for error branch
> 
> - Remove the scrub_parity_mark_sectors_error() out of the while() loop
> 
> Please fold this fix into patch "btrfs: use find_first_extent_item() to
> replace the open-coded extent item search"

Folded in, thanks.
