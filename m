Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448A75B3B9C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiIIPOH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiIIPN7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 11:13:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085921475E6
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 08:13:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D43721F8C6;
        Fri,  9 Sep 2022 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662736430;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TP69+7CioDOaEn39xb32dsx/WfXlIlYrc3lSDW+k59M=;
        b=Vzdd3Dt7Cgo4EqXqyLfPI7+4Chp5MerMjs/CZOZeBxYXuMwpGgSBgB6LaGkqmvzVMnLCFk
        IM8VmYlDPlply0pOZmTPAGmDkBbsxEKs51b7PgFoyYXlW6AuBvvzgcZ6u7JQMnaQPiUXRY
        3dtgbpk36ZP5UJDQL9gkryDCssPMXvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662736430;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TP69+7CioDOaEn39xb32dsx/WfXlIlYrc3lSDW+k59M=;
        b=u8eW2TUN3G/elKSkyBW2qIb+MXYjz0KIbfCrRcroVT4YbJQ1/WzMvIOQf1yFYz+5nK4uQH
        Vf/nvtLCvLm4sUBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9104139D5;
        Fri,  9 Sep 2022 15:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAh7KC5YG2PDbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 15:13:50 +0000
Date:   Fri, 9 Sep 2022 17:08:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com, johannes.thumshirn@wdc.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor btrfs_check_zoned_mode
Message-ID: <20220909150826.GC32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220907092214.2569409-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907092214.2569409-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 07, 2022 at 11:22:14AM +0200, Christoph Hellwig wrote:
> btrfs_check_zoned_mode is really hard to follow, mostly due to the
> fact that a lot of the checks use duplicate conditions after support
> for zone emulation for conventional devices on file systems with the
> ZONED flag was added.  Fix this by splitting out the check for host
> managed devices for !ZONED file systems into a separate helper and
> then simplifying the rest of the code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next with some fixups, thanks.
> ---
>  fs/btrfs/zoned.c | 111 +++++++++++++++++------------------------------
>  1 file changed, 41 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index e12c0ca509fba..3cd3185fa8c34 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -652,80 +652,54 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  	return 0;
>  }
>  
> +static int btrfs_check_for_zoned_device(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_device *device;
> +
> +	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
> +		if (device->bdev &&
> +		    bdev_zoned_model(device->bdev) == BLK_ZONED_HM) {
> +			btrfs_err(fs_info,
> +				  "zoned: mode not enabled but zoned device found");

I've added %pg to print the problematic device.

> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
