Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE962287C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 11:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKIK2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 05:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKIK2b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 05:28:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DE10B5B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 02:28:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7803F2261B;
        Wed,  9 Nov 2022 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667989708;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6U3KMHcrmxc+UgWXxbt5mQwrQR3pZIpLBAjxksNWhQ=;
        b=PWFfBdQUhOK6KPQ7nsNgiqX+pCAjlqFED8UtvT1I1toJmiEwx3jaNZfenPXPYwYfNqhSEP
        QsvSqEPvCMuwz5sLEu0SSFQGJTmmGtMoxOMoi9nP6vFXBGx5Lcn6JGyldeB736Tk2GdwYu
        hk3nI5mM2c01g6DyC7ThxyPrQlsMQ8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667989708;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6U3KMHcrmxc+UgWXxbt5mQwrQR3pZIpLBAjxksNWhQ=;
        b=JDZbzCywKpvDVbSJFGmvlj23C0xBQZvnQhDn0j2U5skSpbF2CBa9iHdGH5mWnx9zLY7blq
        oQ0FL0GEa0qwQjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EB36139F1;
        Wed,  9 Nov 2022 10:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UsQKEsyAa2PCFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Nov 2022 10:28:28 +0000
Date:   Wed, 9 Nov 2022 11:28:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: move device->name rcu alloc and assign to
 btrfs_alloc_device()
Message-ID: <20221109102805.GC5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
 <202211091331.YNFqkpxV-lkp@intel.com>
 <6af7ebaf-4dca-31ad-7854-df73772dacbf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af7ebaf-4dca-31ad-7854-df73772dacbf@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 05:21:12PM +0800, Anand Jain wrote:
> On 11/9/22 13:25, kernel test robot wrote:
> > Hi Anand,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > vim +1000 fs/btrfs/volumes.c
> > 
> >     980	
> >     981	static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
> >     982	{
> >     983		struct btrfs_fs_devices *fs_devices;
> >     984		struct btrfs_device *device;
> >     985		struct btrfs_device *orig_dev;
> >     986		int ret = 0;
> >     987	
> >     988		lockdep_assert_held(&uuid_mutex);
> >     989	
> >     990		fs_devices = alloc_fs_devices(orig->fsid, NULL);
> >     991		if (IS_ERR(fs_devices))
> >     992			return fs_devices;
> >     993	
> >     994		fs_devices->total_devices = orig->total_devices;
> >     995	
> >     996		list_for_each_entry(orig_dev, &orig->devices, dev_list) {
> >     997			const char *dev_path = NULL;
> >     998	
> >     999			if (orig_dev->name)
> >> 1000				dev_path = orig_dev->name->str;
> 
> 
> David,
> 
> Access like orig_dev->name->str isn't introduced in this patch.
> We have to restore the original comment about it.
> 
>                  /*
>                   * This is ok to do without rcu read locked because we 
> hold the
>                   * uuid mutex so nothing we touch in here is going to 
> disappear.
>                   */

Yeah and I kept the comment when applying the patch.
