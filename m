Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB76643AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbjAJOwO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbjAJOwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:52:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D88FEB
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:52:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72B9277202;
        Tue, 10 Jan 2023 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673362329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1syIlqGwTULv62A+b2RAw5A2vBFhhJNNatx9CTmyyTQ=;
        b=T6DgoNsokUDPaWGQ/+ftmo0DkA6kUSoPnveXC7//KBE0B2nQA+4cPObKT9otsfwFXOxxHl
        KxwUZ9WwdwgWJrqEszzzsQOr8lcLzkhhtcxzYzny8esS9MVfyUK7787qpKqss9Kdbk8+tV
        jYJHRAbtGTEIdPXABnh88Uit7/+qpTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673362329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1syIlqGwTULv62A+b2RAw5A2vBFhhJNNatx9CTmyyTQ=;
        b=+XiBU3NymHE7a1LahsXus5kvwqfX5Ap2QN5lG3BizwG83Xefu9jS4iWX0mSps1rSjNZ3Vk
        9fQwKYsIG5dYl3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43F6A1358A;
        Tue, 10 Jan 2023 14:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KI96Dpl7vWNRbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Jan 2023 14:52:09 +0000
Date:   Tue, 10 Jan 2023 15:46:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add extra error messages to cover non-ENOMEM
 errors from device_add_list()
Message-ID: <20230110144634.GC11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fc50bf81b7f93780d19c7eb5bcf1dcabacf00dc6.1670811571.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc50bf81b7f93780d19c7eb5bcf1dcabacf00dc6.1670811571.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 10:19:37AM +0800, Qu Wenruo wrote:
> [BUG]
> When test case btrfs/219 (aka, mount a registered device but with a lower
> generation) failed, there is not any useful information for the end user
> to find out what's going wrong.
> 
> The mount failure just looks like this:
> 
>   #  mount -o loop /tmp/219.img2 /mnt/btrfs/
>   mount: /mnt/btrfs: mount(2) system call failed: File exists.
>          dmesg(1) may have more information after failed mount system call.
> 
> While the dmesg contains nothing but the loop device change:
> 
>   loop1: detected capacity change from 0 to 524288
> 
> [CAUSE]
> In device_list_add() we have a lot of extra checks to reject invalid
> cases.
> 
> That function also contains the regular device scan result like the
> following prompt:
> 
>   BTRFS: device fsid 6222333e-f9f1-47e6-b306-55ddd4dcaef4 devid 1 transid 8 /dev/loop0 scanned by systemd-udevd (3027)
> 
> But unfortunately not all errors have their own error messages, thus if
> we hit something wrong in device_add_list(), there may be no error
> messages at all.
> 
> [FIX]
> Add errors message for all non-ENOMEM errors.
> 
> For ENOMEM, I'd say we're in a much worse situation, and there should be
> some OOM messages way before our call sites.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> @@ -768,8 +768,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
>  
>  	error = lookup_bdev(path, &path_devt);
> -	if (error)
> +	if (error) {
> +		btrfs_err(NULL, "failed to lookup block device for path %s",
> +			  path);

I've added %d to print the actual error.

>  		return ERR_PTR(error);
> +	}
>  
>  	if (fsid_change_in_progress) {
>  		if (!has_metadata_uuid)
