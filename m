Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1701E7B51BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbjJBLw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 07:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbjJBLw2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 07:52:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF1DA
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 04:52:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A01921857;
        Mon,  2 Oct 2023 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696247544;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ke8vye23y0MO4V8s4fpnufWvwNdEEVrwniWiMus1kSg=;
        b=tHHi1rBibm4yECHsmc6l/hIBdKYqi1SQBvRDUVN8k9ddtStGMUUzksDkGXNFHN+YD+gacp
        8hUn6soUDAKGKAsQm9RlJv1N3HLEvrg1RUWk9POWA/TcPXPW5BXnq1SoFvOJ6X7GYCajzs
        /RuUeKZmz4vfAEzUwXuprid98xNpIoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696247544;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ke8vye23y0MO4V8s4fpnufWvwNdEEVrwniWiMus1kSg=;
        b=4W+Wt2IXIpz1BokbVpSghVbpoIN0uDJgVAMjgqn8v2a03g2djhuPDxG+agM8go1Ou3ACcz
        TkxzXTH/d6v/7HCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DF1D13456;
        Mon,  2 Oct 2023 11:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +wNCBviuGmXDEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 11:52:24 +0000
Date:   Mon, 2 Oct 2023 13:45:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add helper function find_fsid_by_disk
Message-ID: <20231002114543.GM13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695826320.git.anand.jain@oracle.com>
 <46a185408cb2307eb1f94250533c7d10a3a9d62a.1695826320.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a185408cb2307eb1f94250533c7d10a3a9d62a.1695826320.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 09:09:46AM +0800, Anand Jain wrote:
> In preparation for adding support to mount multiple single-disk
> btrfs filesystems with the same FSID, wrap find_fsid() into
> find_fsid_by_disk().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 298e5885ed06..39b5bc2521fb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -553,6 +553,20 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
>  	return ret;
>  }
>  
> +static struct btrfs_fs_devices *find_fsid_by_disk(

A minor thing here, I think we don't want to use "disk" in the
identifiers, it's been converted to 'device' where possible but there
are still some references that could be related to on-disk structures so
these can't be changed. In new API I'd prefer 'device'.
