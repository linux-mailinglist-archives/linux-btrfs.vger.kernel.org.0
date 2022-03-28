Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97CB4E9FA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiC1TSa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbiC1TSU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 15:18:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793186662F
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 12:16:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26E2F1FD3E;
        Mon, 28 Mar 2022 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648494998;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wa1xN9dr1JY1MHAISOAlNONzGxbTcetPHGS7drjaey0=;
        b=uomAn5wuwLSMFZI0JMkVFDHSQV0xfAb00tmDTmvNxivn5JRTKRPmGaQ+yQfr2Cmzgvbb16
        Tu5Robu84m39j2ARF1y3t7dJp6r6TG3cFtoTGMA7VDP2FHYuIPXH6BFP3BJqlV1XkXjKjM
        d6K7EzMEDnZL4FlKH5KKVIULW6nNJU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648494998;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wa1xN9dr1JY1MHAISOAlNONzGxbTcetPHGS7drjaey0=;
        b=8W7tvIYJ9igH6Mdg7Qn808e3Cl9YEeaL/so8yCvoQgCVl6XQy0xKvI2PNASV9JxhnXfYaJ
        5T3Y+eNIJRFzjoBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E3608A3B82;
        Mon, 28 Mar 2022 19:16:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2AF0DA7F3; Mon, 28 Mar 2022 21:12:40 +0200 (CEST)
Date:   Mon, 28 Mar 2022 21:12:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Message-ID: <20220328191240.GT2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-3-hch@lst.de>
 <PH0PR04MB7416CF5DB1670FF12D823D779B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416CF5DB1670FF12D823D779B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Fri, Mar 25, 2022 at 09:09:56AM +0000, Johannes Thumshirn wrote:
> On 24/03/2022 17:54, Christoph Hellwig wrote:
> > Zone Append bios only need a valid block device in struct bio, but
> > not the device in the btrfs_bio.  Use the information from
> > btrfs_zoned_get_device to set up bi_bdev and fix zoned writes on
> > multi-device file system with non-homogeneous capabilities and remove
> > the pointless btrfs_bio.device assignment.
> > 
> > Add big fat comments explaining what is going on here.
> 
> Looks like the old code worked by sheer luck, as we had wbc set and thus
> always assigned fs_info->fs_devices->latest_dev->bdev to the bio. Which 
> would obviously not work on a multi device FS.

No, it worked fine because the real bio is set just before writing the
data somewhere deep in the io submit path in submit_stripe_bio().

That it has to be set here is because of the cgroup implementation that
accesses it, see 429aebc0a9a0 ("btrfs: get bdev directly from fs_devices
in submit_extent_page").

Which brings me to the question if Christoph's fix is correct because
the comment for the wbc + zoned append is assuming something that's not
true.
