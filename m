Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEBE4CD576
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiCDNu4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 08:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiCDNuz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 08:50:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C6151D3C
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 05:50:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9AE5B21110;
        Fri,  4 Mar 2022 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646401806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbHWL52G4DQHMsSJL4rvYCLgg3VUF94q4F1FAd64cKM=;
        b=fu/wUDp/3hcl2kwRSseGVzXOhU0Ew2WrV3So62ZY5dXyLWmpmIZmfMn0YqwLEPKsCatg0c
        lMNi8jcIp4f3Uypf9Y3uveTMnHwn/RfT4q3QFRtzUQjORnQ9zuZkomyXRoZ0tnyqLreoun
        puYqRNiO7wj8J9R+0RajhYNGlDmVIDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646401806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbHWL52G4DQHMsSJL4rvYCLgg3VUF94q4F1FAd64cKM=;
        b=Ykn7XKeF6bLJkIxFEZwqj5/dUekUeFGFD3eVdBo8O7rSqsf2l0zlr5CTY1K75PABw4ubnJ
        5t6HGCzs7ekJ9IBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3A0BAA3B83;
        Fri,  4 Mar 2022 13:50:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41EA5DA80E; Fri,  4 Mar 2022 14:46:13 +0100 (CET)
Date:   Fri, 4 Mar 2022 14:46:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] btrfs: add lockdep_assert_held to
 need_preemptive_reclaim
Message-ID: <20220304134613.GX12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Niels Dossche <dossche.niels@gmail.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220303003838.7328-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303003838.7328-1-dossche.niels@gmail.com>
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

On Thu, Mar 03, 2022 at 01:38:39AM +0100, Niels Dossche wrote:
> In a previous patch ("btrfs: extend locking to all space_info members
> accesses") the locking for the space_info members was extended in
> btrfs_preempt_reclaim_metadata_space because not all the member
> accesses that needed locks were actually locked (bytes_pinned et al).
> 
> It was then suggested to also add a call to lockdep_assert_held to
> need_preemptive_reclaim. This function also works with space_info
> members. As of now, it has only two callsites which both hold the lock.
> It was suggested to add this to be better safe than sorry regarding the
> locking on bytes_pinned et al, in order to prevent similar issues in the
> future.
> 
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>

Added to misc-next, thanks.
