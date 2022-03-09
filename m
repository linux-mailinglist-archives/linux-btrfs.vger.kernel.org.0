Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A24D3147
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiCIOwe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 09:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCIOwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 09:52:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9F17E351
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 06:51:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BA5941F380;
        Wed,  9 Mar 2022 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646837493;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vssTC5zSl78dvgjlAEn3UNJsdkSoqrMAMrRZbxj686c=;
        b=u70XvGBPfT4v6CaVtDBBPOa7kA+xrbiKBfwGymtC26xqJmblPDseSXIjnLFF9jiUC9u7eL
        aoyeSwYRejQx4XwhoTLdiUgHaKPssbV97k739rPExFeDklASLono6pcnWx6fUkKgK/OlRl
        /FkKqfpORl6zD3awqUMdCIp9qbVykoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646837493;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vssTC5zSl78dvgjlAEn3UNJsdkSoqrMAMrRZbxj686c=;
        b=gcHWaEzRgVDk6Zwc+bjkOqpRXSvUD4ZQ007kqPhrHVgEYfFJNAzwwnKsnMTEz2TODNFdB8
        bMC8hXQHeSsAw9Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6F444A3B81;
        Wed,  9 Mar 2022 14:51:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9FE4DA7DE; Wed,  9 Mar 2022 15:47:37 +0100 (CET)
Date:   Wed, 9 Mar 2022 15:47:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wwdc.com>
Subject: Re: [PATCH v2 1/2] btrfs: zoned: use rcu list in
 btrfs_can_activate_zone
Message-ID: <20220309144737.GW12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wwdc.com>
References: <cover.1646649873.git.johannes.thumshirn@wdc.com>
 <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646649873.git.johannes.thumshirn@wdc.com>
 <5990aa9e-9082-613c-4ef1-27568d36329b@oracle.com>
 <PH0PR04MB7416D08232CABEC1A92028DE9B0A9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416D08232CABEC1A92028DE9B0A9@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Wed, Mar 09, 2022 at 07:44:11AM +0000, Johannes Thumshirn wrote:
> On 09/03/2022 08:37, Anand Jain wrote:
> > On 07/03/2022 18:47, Johannes Thumshirn wrote:
> >> btrfs_can_activate_zone() can be called with the device_list_mutex already
> >> held, which will lead to a deadlock.
> >>
> >> As we're only traversing the list for reads we can switch from the
> >> device_list_mutex to an rcu traversal of the list.
> >>
> >> Fixes: a85f05e59bc1 ("btrfs: zoned: avoid chunk allocation if active block group has enough space")
> >> Cc: Naohiro Aota <naohiro.aota@wwdc.com>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/zoned.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> >> index b7b5fac1c779..cf6341d45689 100644
> >> --- a/fs/btrfs/zoned.c
> >> +++ b/fs/btrfs/zoned.c
> >> @@ -1986,8 +1986,8 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
> >>   	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0);
> >>   
> >>   	/* Check if there is a device with active zones left */
> >> -	mutex_lock(&fs_devices->device_list_mutex);
> >> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> >> +	rcu_read_lock();
> >> +	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
> > 
> > 
> >   Sorry for the late comment.
> >   Why not use dev_alloc_list and, chunk_mutex here?
> > 
> 
> That's a good question indeed. Let me try it :)

The 5.18 is now frozen, so please send it as an incremental fix, thanks.
