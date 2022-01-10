Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF844489B78
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 15:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiAJOlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 09:41:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39988 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiAJOlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 09:41:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43EC01F383;
        Mon, 10 Jan 2022 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641825677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/6Z1OXfjxeMLuZrpcFt24CKTMXmMeMHPvRbrtxljHo=;
        b=lYbapEhcBp+hcpqjrh/MrQyDnXfkxYhYk4A0qiAY7IjaTSjaHtoXc6MD6NJkQC8/m9vFPY
        Z2CxVSOzJJK+cEfdtLVBzjBxK2G/VUxCyjFsaQjCGXlEqQkbkhvT3E0CxHJQ1bnkH5UNPn
        Z8lx0/SPCBQSjGGYPp51shGoHS1wLec=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCF1513D9D;
        Mon, 10 Jan 2022 14:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHpXMoxF3GEBYgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 14:41:16 +0000
Subject: Re: [PATCH v4 1/4] btrfs: harden identification of the stale device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <b1523d512e2e032c38bbb1b0341e95c52a0f08ba.1641794058.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4ecf171e-86f9-7ee5-e622-a538c96a52f3@suse.com>
Date:   Mon, 10 Jan 2022 16:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b1523d512e2e032c38bbb1b0341e95c52a0f08ba.1641794058.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.01.22 г. 15:23, Anand Jain wrote:
> Identifying and removing the stale device from the fs_uuids list is done
> by the function btrfs_free_stale_devices().
> btrfs_free_stale_devices() in turn depends on the function
> device_path_matched() to check if the device repeats in more than one
> btrfs_device structure.
> 
> The matching of the device happens by its path, the device path. However,
> when dm mapper is in use, the dm device paths are nothing but a link to
> the actual block device, which leads to the device_path_matched() failing
> to match.
> 
> Fix this by matching the dev_t as provided by lookup_bdev() instead of
> plain strcmp() the device paths.
> 
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v4: Return 1 for device matched in device_matched()
>     Use scnprintf() instead of sprintf() in device_matched()
> v3: -
> v2: Fix 
>      sparse: warning: incorrect type in argument 1 (different address spaces)
>      For using device->name->str
> 
>     Fix Josef suggestion to pass dev_t instead of device-path in the
>      patch 2/2.
> 
>  fs/btrfs/volumes.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4b244acd0cfa..05333133e877 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -535,15 +535,43 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>  	return ret;
>  }
>  
> -static bool device_path_matched(const char *path, struct btrfs_device *device)
> +/*
> + * Check if the device in the 'path' matches with the device in the given
> + * struct btrfs_device '*device'.
> + * Returns:
> + *	1	If it is the same device.
> + *	0	If it is not the same device.
> + *	-errno	For error.
> + */
> +static int device_matched(struct btrfs_device *device, const char *path)
>  {

Again, this is a predicate function, the error return values is treated
the same as if the match failed. So why not simply make the function
bool and in case of error return false and be done with it? This is not
a big deal for the latest kernel as this function is removed in patch 4
but AFAIR it's going to be backported to 5.4. My question is do we have
 a real need to communicate the error? Given that errors can be safely
ignored here making a simpler interface is a better option.


<snip>
