Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB106A1238
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 22:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBWVn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 16:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWVn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 16:43:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD3311EB2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 13:43:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDC5133FBD;
        Thu, 23 Feb 2023 21:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677188634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NLWMJlCAlkN6I7MreDMIS8QZGD28Yunz678Wf3SQIQ=;
        b=DqSNaV2x/RsEe8MOhAcPj19abvu5IpQCv+MlcuAEZpnHMhuF/VEC6kAhMyNJO6B1ScfgfY
        DFDXJrvF7ItIUt5iyR4D23XzWMJ+45KkCUxepzBSp2SUdHrl/az1sW/+A9toDweCYRMxXZ
        VJm80sSiB7nGeTb/B1xQt4ZoMgViEgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677188634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NLWMJlCAlkN6I7MreDMIS8QZGD28Yunz678Wf3SQIQ=;
        b=kix6a3kuSUv+WnwSahfUjY1X6wpbhlLGd/f2ceCx90V/xT7h5YxnmEcjIJSmtb0T/nlfWD
        jdFLWxaG+rSNCbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAA93139B5;
        Thu, 23 Feb 2023 21:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SPVmMBre92OvfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 21:43:54 +0000
Date:   Thu, 23 Feb 2023 22:37:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: ioctl: allow dev info ioctl to return fsid of
 a device
Message-ID: <20230223213757.GE10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c3e2ff2f10b0da711a619745495bb8e8c80c1ad0.1676116309.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e2ff2f10b0da711a619745495bb8e8c80c1ad0.1676116309.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 11, 2023 at 07:53:05PM +0800, Qu Wenruo wrote:
> Currently user space utilize dev info ioctl to grab the info of a
> certain devid, this includes its device uuid.
> 
> But the return info is not enough to determine if a device is a seed.
> 
> This patch will add a new member, fsid, into btrfs_ioctl_dev_info_args,
> and populate the member with fsid value.
> 
> This should not cause any compatibility problem, following the following
> combination:
> 
> - Old user space, old kernel
> - Old user space, new kernel
>   User space tool won't even check the new member.
> 
> - New user space, old kernel
>   The kernel won't touch the new member, and user space tool should
>   zero out its argument, thus the new member is all zero.
> 
>   User space tool can then know the kernel doesn't support this fsid
>   reporting, and falls back to whatever they can.
> 
> - New user space, new kernel
>   Go as planned.
> 
>   Would found the fsid member is no longer zero, and trust its value.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next and queued for 6.3 as we already have sysfs export.

> ---
> v2:
> - Fix the wrong padding number
>   I doubt why we stick with u64, not u8 for padding, which is way less
>   bug-prone.

I don't know either, in any case the static_asserts that we don't have
there could catch that regardless of the type.
