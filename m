Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6858C504CC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiDRGnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 02:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiDRGnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 02:43:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C32713DEB
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 23:41:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05C531F383;
        Mon, 18 Apr 2022 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650264074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SC5UQhfdjUFTcM1lIGhl6wgftZbcZuEnv9BVIKYGVl8=;
        b=Bx28kCIexijO0+1+mzODB+DFl41gc2yKPijnprjjv2PfNf6XmIeVycPpUwKPRJFGIGZk/1
        ceQlI73G4DTGNNZlbu+2dOgRTQKRCILeIJxBEb/OTqqcBlIERg9Bi5blnQNFV2yYFYr3U+
        773/qbp3r4mKFs5qrDN1B3v8RKpKzME=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5FAD13ACB;
        Mon, 18 Apr 2022 06:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AjxYLAkIXWKmWgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Apr 2022 06:41:13 +0000
Message-ID: <988fb59d-da07-1419-cfe3-85a5ad0efbca@suse.com>
Date:   Mon, 18 Apr 2022 09:41:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs-progs: do not allow setting seed flag on fs with
 dirty log
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.04.22 г. 14:37 ч., Qu Wenruo wrote:
> [BUG]
> The following sequence operation can lead to a seed fs rejected by
> kernel:
> 
>   # Generate a fs with dirty log
>   mkfs.btrfs -f $file
>   mount $dev $mnt
>   xfs_io -f -c "pwrite 0 16k" -c fsync $mnt/file
>   cp $file $file.backup
>   umount $mnt
>   mv $file.backup $file
> 
>   # now $file has dirty log, set seed flag on it
>   btrfstune -S1 $file
> 
>   # mount will fail
>   mount $file $mnt
> 
> The mount failure with the following dmesg:
> 
> [  980.363667] loop0: detected capacity change from 0 to 262144
> [  980.371177] BTRFS info (device loop0): flagging fs with big metadata feature
> [  980.372229] BTRFS info (device loop0): using free space tree
> [  980.372639] BTRFS info (device loop0): has skinny extents
> [  980.375075] BTRFS info (device loop0): start tree-log replay
> [  980.375513] BTRFS warning (device loop0): log replay required on RO media
> [  980.381652] BTRFS error (device loop0): open_ctree failed
> 
> [CAUSE]
> Although btrfs will replay its dirty log even with RO mount, but kernel
> will treat seed device as RO device, and dirty log can not be replayed
> on RO device.
> 
> This rejection is already the better end, just imagine if we don't treat
> seed device as RO, and replayed the dirty log.
> The filesystem relying on the seed device will be completely screwed up.
> 
> [FIX]
> Just add extra check on log tree in btrfstune to reject setting seed
> flag on filesystems with dirty log.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

One minor nit below but it can be rectified by David at merge time. Why 
don't you also add a btrfs-progs test for this functionality.

> ---
>   btrfstune.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/btrfstune.c b/btrfstune.c
> index 33c83bf16291..7e4ad30a1cbd 100644
> --- a/btrfstune.c
> +++ b/btrfstune.c
> @@ -59,6 +59,10 @@ static int update_seeding_flag(struct btrfs_root *root, int set_flag)
>   						device);
>   			return 1;
>   		}
> +		if (btrfs_super_log_root(disk_super)) {
> +			error("this filesystem has dirty log, can not set seed flag");


nit: I'd probably put something less colloquial such as:

"Filesystem with dirty log detected, not setting seed flag"

> +			return 1;
> +		}
>   		super_flags |= BTRFS_SUPER_FLAG_SEEDING;
>   	} else {
>   		if (!(super_flags & BTRFS_SUPER_FLAG_SEEDING)) {
