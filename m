Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3959C922
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiHVTmD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiHVTmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 15:42:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F0148E8F
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 12:42:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 302B120746;
        Mon, 22 Aug 2022 19:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661197319;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCE//WlegMOPrROnQQfKP6MJdcBDr1KZqkmWbEUXw8o=;
        b=g/4swi+UfZuj0BPajpL46uaq8niJBQusrdWUKVUUrcZ6WSdkmygDYs29I5BgjG3hTodO2c
        OMoP73DvFrsdUDpGFcARJJE/w6sVB2Qiwias2v67C5CUdm91N5uW8fzO0h82KLb5R0Bhag
        1wNTwMsXHxB6cIyDYTGFfO5k/qlyXkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661197319;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCE//WlegMOPrROnQQfKP6MJdcBDr1KZqkmWbEUXw8o=;
        b=raqUBRt+cEtOejOTKfM6YVlapi5Is5PLAlyKdrncslNXKAsiGz2JoTTsfBSNBMJIpvkX/h
        SGi0pNUzXea3X8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 018AA1332D;
        Mon, 22 Aug 2022 19:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Et0IOwbcA2PncAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 19:41:58 +0000
Date:   Mon, 22 Aug 2022 21:36:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Samuel Greiner <samuel@balkonien.org>
Subject: Re: [PATCH 2/2] btrfs: add info when mount fails due to stale
 replace target
Message-ID: <20220822193645.GF13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Samuel Greiner <samuel@balkonien.org>
References: <cover.1660299977.git.anand.jain@oracle.com>
 <6a99394d3248034a908f8f1e22df8917c193446d.1660299977.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a99394d3248034a908f8f1e22df8917c193446d.1660299977.git.anand.jain@oracle.com>
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

On Fri, Aug 12, 2022 at 06:32:19PM +0800, Anand Jain wrote:
> If the replace-target device re-appears after the suspended replace is
> cancelled, it blocks the mount operation as it can't find the matching
> replace-item in the metadata. As shown below,
> 
>    BTRFS error (device sda5): replace devid present without an active replace item
> 
> To overcome this situation, the user can run the command
> 
>    btrfs device scan --forget <device-path-to-devid=0>
> 
> and try the mount command again. And also, to avoid repeating the issue,
> superblock on the devid=0 must be wiped.
> 
>    wipefs -a device-path-to-devid=0.
> 
> This patch adds some info when this situation occurs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Samuel Greiner <samuel@balkonien.org>
> Link: https://lore.kernel.org/linux-btrfs/b4f62b10-b295-26ea-71f9-9a5c9299d42c@balkonien.org/T/
> ---
>  fs/btrfs/dev-replace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 9d46a702bc11..7202b76ce59f 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -166,6 +166,8 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>  		if (btrfs_find_device(fs_info->fs_devices, &args)) {
>  			btrfs_err(fs_info,
>  			"replace devid present without an active replace item");
> +			btrfs_info(fs_info,
> +	"mount after the command 'btrfs deivce scan --forget <devpath-of-id-0>'");

The messages should be on the same level and in one message, I've
reprhrased it a bit.
