Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208815AD6BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiIEPkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiIEPkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 11:40:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ADC167D7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 08:40:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F350033906;
        Mon,  5 Sep 2022 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662392421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zeXX+lrXE3fjycCh1yJAfQnY/9gGLagzDmJQ0Oxx0ts=;
        b=niEvE1GQ/T8vBpSOChsbEQKfaUbdjIG+0I/2L2iCo2by/6XNqzswiyYQa+6x252TfgamvH
        dGtUp7xX5sluDp1d6Ci1nmch4DlvCCmSrpU/1lNIM45b60H5e4Svo3xMcbylQr+pWtKcox
        +wGJq9jbRl8V/ozkMeheikYU4JN24oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662392421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zeXX+lrXE3fjycCh1yJAfQnY/9gGLagzDmJQ0Oxx0ts=;
        b=PcpLwDd6goIIP5zCYSynQMxJowMd6n/8b/23q2u0N4YFp2uzKAZXgjKyUN2wva/HKWPBqZ
        667vB8LD5O154CDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D14B0139C7;
        Mon,  5 Sep 2022 15:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bQYjMmUYFmOZXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 15:40:21 +0000
Date:   Mon, 5 Sep 2022 17:34:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: slience the sparse warn of rcu_string
Message-ID: <20220905153459.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220824051208.19924-1-wangyugui@e16-tech.com>
 <20220905115726.6C63.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905115726.6C63.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 11:57:26AM +0800, Wang Yugui wrote:
> Hi,
> 
> > slience the sparse warn of rcu_string reported by 'make C=1'
> > 
> > warning example:
> > fs/btrfs/volumes.c:2300:41: warning: incorrect type in argument 3 (different address spaces)
> > fs/btrfs/volumes.c:2300:41:    expected char const *device_path
> > fs/btrfs/volumes.c:2300:41:    got char [noderef] __rcu *
> 
> I'm sorry that some new WARNING is triggered when 
> lockdep(CONFIG_PROVE_LOCKING/...) check is enabled.
> 
> [  112.742722] =============================
> [  112.746835] WARNING: suspicious RCU usage
> [  112.750917] 6.0.0-4.0.el7.x86_64 #1 Not tainted
> [  112.755540] -----------------------------
> [  112.759624] fs/btrfs/volumes.c:918 suspicious rcu_dereference_check() usage!
> [  112.766776] 
>                other info that might help us debug this:
> 
> [  112.774921] 
>                rcu_scheduler_active = 2, debug_locks = 1
> [  112.781566] 2 locks held by mount/1725:
> [  112.785471]  #0: ffffffffc50592a8 (uuid_mutex){+.+.}-{3:3}, at: btrfs_mount_root+0xfe/0x520 [btrfs]
> [  112.794763]  #1: ffffa1147bf068e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: device_list_add+0x28d/0x830 [btrfs]
> 
> 
> The fix is yet not clear,  we may need rcu_read_lock() just like
> 3181faa85bda3dc3f5e630a1846526c9caaa38e3 (cfq-iosched: fix a rcu warning)

There are probably more instances that would need the rcu lock/unlock,
eg. in btrfs_open_one_device, btrfs_dev_replace_finishing,
btrfs_destroy_dev_replace_tgtdev, btrfs_rm_device, clone_fs_devices,
device_list_add, btrfs_open_one_device where the dereference is done in
parameter list.

There's one dereference in the message helpers but not using the _in_rcu
variant:

zoned.c:
1403                 case BLK_ZONE_COND_READONLY:
1404                         btrfs_err(fs_info,
1405                 "zoned: offline/readonly zone %llu on device %s (devid %llu)",
1406                                   physical[i] >> device->zone_info->zone_size_shift,
1407                                   rcu_str_deref(device->name), device->devid);

We can keep the the patch in for-next and add the missing annotations as
they appear, updating the patch so it may take some time but we'll fix
all the warnings eventually.
