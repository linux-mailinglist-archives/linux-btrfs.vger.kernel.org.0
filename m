Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FBA4DB656
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 17:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244990AbiCPQk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiCPQk6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 12:40:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B96B091
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 09:39:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 751E21F38D;
        Wed, 16 Mar 2022 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647448782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VnmjwFKm7Ub7Qao8mdvzamG/uJAm1/8J87Qf7Hl6gGU=;
        b=qCuT0A1HLUepX0x+lTiSTadd+uIFixC6sYGxhAHdvRNYt4MJVa09X2MCMB6aGVpPtHKx84
        zCbz6XOLjdIaTgOEuWUDWBeUS8A9iIrUZndtI4bdqaOyyeGqgNK5mM3NK/mrYrYFlSNuWO
        8crwm04EkJ8B5aU+MewDLAA5cnbcW7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647448782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VnmjwFKm7Ub7Qao8mdvzamG/uJAm1/8J87Qf7Hl6gGU=;
        b=NfZMLNkKFEHp53BKnDoJ2I4lgLk0L1Q/knYLnTgZZfy6jPLxnPo9X+l0SmRovb/aYE3SWY
        RcPC4S/Q42oZHpAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 45421A3B83;
        Wed, 16 Mar 2022 16:39:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01C20DA7E1; Wed, 16 Mar 2022 17:35:42 +0100 (CET)
Date:   Wed, 16 Mar 2022 17:35:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: use alloc_list instead of RCU locked
 device_list
Message-ID: <20220316163542.GB12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <c13ae130cf4d170da60d9bde63de78e3583611df.1647425970.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13ae130cf4d170da60d9bde63de78e3583611df.1647425970.git.johannes.thumshirn@wdc.com>
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

On Wed, Mar 16, 2022 at 09:21:12AM -0700, Johannes Thumshirn wrote:
> Anand pointed out, that instead of using the RCU locked version of
> fs_devices->device_list we can use fs_devices->alloc_list, protected by
> the chunk_mutex to traverse the list of active devices in
> btrfs_can_activate_zone().
> 
> We are in the chunk allocation thread. The newer chunk allocation
> happens from the devices in the fs_device->alloc_list protected by the
> chunk_mutex.
> 
>   btrfs_create_chunk()
>     lockdep_assert_held(&info->chunk_mutex);
>     gather_device_info
>       list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
> 
> Also, a device that reappears after the mount won't join the alloc_list
> yet and, it will be in the dev_list, which we don't want to consider in
> the context of the chunk alloc.
> 
> Suggested-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes since v1:
> * Fix crash Anand reported

Patch updated, thanks.
