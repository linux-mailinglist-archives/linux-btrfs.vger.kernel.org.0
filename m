Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B967752AB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjGMTFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGMTFS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 15:05:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C02D69
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 12:05:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDD8A22132;
        Thu, 13 Jul 2023 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689275111;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQy5j6KPKQrM4tWuII9TmdGQdAccDfPyfo2y1qY/7MU=;
        b=eMWsebcDOAGk7aAte8FFqJFUOYUlP2LEbBL1GyttP76G6yZosuh9s007a22/ib8QZ6eFz4
        O7o7FSEl1WBNiQFMhsTXrD7tO2Crnkg07w++gHqoWIeGyrTmPyGAwCpVRH/CRC2JPcDc0e
        +CPwWVwK0fFh0OQCOGX9VfG+91boXas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689275111;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQy5j6KPKQrM4tWuII9TmdGQdAccDfPyfo2y1qY/7MU=;
        b=NTH42t3WLdHwZDPAjrn5TUGO8LKLn7eWc2o+HRrG82/OqORb7SVKdCvoogQHjIcIcs8gEF
        uvgFyPMV+kvm3DDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDE87133D6;
        Thu, 13 Jul 2023 19:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3jeCMedKsGR7CgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 19:05:11 +0000
Date:   Thu, 13 Jul 2023 20:58:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/11] btrfs-progs: track total_devs in fs devices
Message-ID: <20230713185835.GF30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1688724045.git.anand.jain@oracle.com>
 <25c9f3b987016c897132146360c5aeab0cca9a12.1688724045.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c9f3b987016c897132146360c5aeab0cca9a12.1688724045.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 07, 2023 at 11:52:38PM +0800, Anand Jain wrote:
> Similar to the kernel, introduce the btrfs_fs_devices::total_devs
> attribute to know the overall count of devices that are expected
> to be present per filesystem.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  kernel-shared/volumes.c | 4 +++-
>  kernel-shared/volumes.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index 1e42e4fe105e..fd5890d033c8 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -367,7 +367,8 @@ static int device_list_add(const char *path,
>  			       BTRFS_FSID_SIZE);
>  
>  		fs_devices->latest_devid = devid;
> -		fs_devices->latest_trans = found_transid;
> +		/* Below we would set this to found_transid */
> +		fs_devices->latest_trans = 0;
>  		fs_devices->lowest_devid = (u64)-1;
>  		fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>  		device = NULL;
> @@ -438,6 +439,7 @@ static int device_list_add(const char *path,
>  	if (found_transid > fs_devices->latest_trans) {
>  		fs_devices->latest_devid = devid;
>  		fs_devices->latest_trans = found_transid;
> +		fs_devices->total_devices = device->total_devs;
>  	}
>  	if (fs_devices->lowest_devid > devid) {
>  		fs_devices->lowest_devid = devid;
> diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
> index 93e02a901d31..09964f96ca37 100644
> --- a/kernel-shared/volumes.h
> +++ b/kernel-shared/volumes.h
> @@ -90,6 +90,7 @@ struct btrfs_fs_devices {
>  
>  	u64 total_rw_bytes;
>  
> +	int total_devices;
>  	int num_devices;
>  	int missing;

All the device counters could be added separately, that's for the
kernel/userspace parity.

>  	int latest_bdev;
> -- 
> 2.39.3
