Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED84D3746
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiCIRPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 12:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbiCIROj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 12:14:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44E133973
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 09:09:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E6E9210ED;
        Wed,  9 Mar 2022 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646845789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G65C7dQanf26bAjvD15ILOQFGd+DmYz8/UlPVPorv9s=;
        b=yUFSnjM0DTU3uV5Tw88XLCBzc0c/bBjN9ISh8g9neN6ihjj14YsmGvLl64XHe+wpC12jf6
        3+xgCH06dMLHvO6Cr7RwgIlGgscnllXEUzKUGJABjPJLAbOR+WG6QoTkq180sKvqHSdJ75
        rCHKJxJl7551pVTvohBIRQ8OkLKTpB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646845789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G65C7dQanf26bAjvD15ILOQFGd+DmYz8/UlPVPorv9s=;
        b=RQC1tvGJschXGSWOcvqvNd1wZSQc03veNNa6H6wjNQxUPw4lWmQsNXypUhcrzxQ7Hza0n8
        jBRK2ujotsiTgZAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 39F59A3B84;
        Wed,  9 Mar 2022 17:09:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67C7DDA7DE; Wed,  9 Mar 2022 18:05:53 +0100 (CET)
Date:   Wed, 9 Mar 2022 18:05:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v5 12/19] btrfs-progs: set the number of global roots in
 the super block
Message-ID: <20220309170553.GY12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
 <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
 <20220308161951.GN12643@twin.jikos.cz>
 <PH0PR04MB741601104CC2D56A2EF3C02C9B099@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741601104CC2D56A2EF3C02C9B099@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Tue, Mar 08, 2022 at 04:41:44PM +0000, Johannes Thumshirn wrote:
> On 08/03/2022 17:23, David Sterba wrote: 
> >>  	u8 metadata_uuid[BTRFS_FSID_SIZE];
> >>  
> >> +	__le64 nr_global_roots;
> >> +
> > 
> > Shouldn't this be added after the last item?
> > 
> >>  	__le64 block_group_root;
> >>  	__le64 block_group_root_generation;
> >>  	u8 block_group_root_level;
> >>  
> >>  	/* future expansion */
> >>  	u8 reserved8[7];
> >> -	__le64 reserved[25];
> >> +	__le64 reserved[24];
> 
> Or at least inside one of these reserved fields.

OTOH, it's still experimental so we don't expect backward compatibility
yet so it should be ok to change for now.
