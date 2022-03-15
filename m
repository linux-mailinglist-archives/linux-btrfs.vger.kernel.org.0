Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741214DA3B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 21:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbiCOUIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiCOUIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 16:08:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143E56234
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 13:07:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FCA51F38A;
        Tue, 15 Mar 2022 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647374849;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lieWX7+VbpLWRgImyyoXKGP8nqalpHw3LtC0CaGbG00=;
        b=x/lJOo2V4QXByxgVSbqsvbum7zEDBC+4b0Gmk9NjvL9CnvtBvLwRDMnpsOtw1igciANwYE
        eKvXGQrdca/Q6B4DUVQOAEuhPAHCEytUw4q3S8BB1mZ2NaQPaxtXknHlR39NvKb8bhTKAn
        salWpstaQZ/4i3CUEvNml02zXhxU3XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647374849;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lieWX7+VbpLWRgImyyoXKGP8nqalpHw3LtC0CaGbG00=;
        b=7s9O3jsqKlFFI46TVZihWIaF8rLIezqMq69eCsRtA9IG9yUpf8vXWHNpbGlfoQTBfpZsbG
        pp0CH0w7pclRzvDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DF512A3B83;
        Tue, 15 Mar 2022 20:07:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E971DA7E1; Tue, 15 Mar 2022 21:03:30 +0100 (CET)
Date:   Tue, 15 Mar 2022 21:03:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked
 device_list
Message-ID: <20220315200330.GW12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
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

On Mon, Mar 14, 2022 at 07:16:47AM -0700, Johannes Thumshirn wrote:
> Anand pointed out, that instead of using the rcu locked version of
> fs_devices->device_list we cab use fs_devices->alloc_list, prrotected by
> the chunk_mutex to traverse the list of active deviices in
> btrfs_can_activate_zone().
> 
> Suggested-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

With updated changelog added to misc-next, thanks.
