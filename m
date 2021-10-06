Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3FA423849
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 08:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhJFGl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 02:41:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46010 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbhJFGlx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 02:41:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 759AE2031D;
        Wed,  6 Oct 2021 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633502401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ijg+efjLcl9x3vmrb7Um+3EMNm3pAAW5bb5YdL54TZ4=;
        b=tMd2mtYd2LKoSgzmMGzAl3SPIi0jQK/E7lSx4Aqh/sBIvqkAVxI+qP4L7HFQHzPdqLtps5
        6yTgqYxXdbq3jzLs0zMaGkMDKUqaQhN60hrX/l9fY3QGRZpMYoweyU8JPwjD3YUJ+Vxysd
        LVzM5zEy9iU1qDvYCF2GDqxdywxPpFo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4364213E19;
        Wed,  6 Oct 2021 06:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZVXWDcFEXWGdcwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Oct 2021 06:40:01 +0000
Subject: Re: [PATCH v4 3/6] btrfs: do not call close_fs_devices in
 btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633464631.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c02ba409-9669-df51-b51f-20b7909b21af@suse.com>
Date:   Wed, 6 Oct 2021 09:40:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633464631.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.10.21 г. 23:12, Josef Bacik wrote:
> There's a subtle case where if we're removing the seed device from a
> file system we need to free its private copy of the fs_devices.  However
> we do not need to call close_fs_devices(), because at this point there
> are no devices left to close as we've closed the last one.  The only
> thing that close_fs_devices() does is decrement ->opened, which should
> be 1.  We want to avoid calling close_fs_devices() here because it has a
> lockdep_assert_held(&uuid_mutex), and we are going to stop holding the
> uuid_mutex in this path.
> 
> So simply decrement the  ->opened counter like we should, and then clean
> up like normal.  Also add a comment explaining what we're doing here as
> I initially removed this code erroneously.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0941f61d8071..5f19d0863094 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2211,9 +2211,16 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>  	synchronize_rcu();
>  	btrfs_free_device(device);
>  
> +	/*
> +	 * This can happen if cur_devices is the private seed devices list.  We
> +	 * cannot call close_fs_devices() here because it expects the uuid_mutex
> +	 * to be held, but in fact we don't need that for the private
> +	 * seed_devices, we can simply decrement cur_devices->opened and then
> +	 * remove it from our list and free the fs_devices.
> +	 */
>  	if (cur_devices->num_devices == 0) {
>  		list_del_init(&cur_devices->seed_list);
> -		close_fs_devices(cur_devices);
> +		cur_devices->opened--;

I think an ASSERT(opened == 1) is warranted as this is a special case
and there is very specific expectation of the state of opened.

>  		free_fs_devices(cur_devices);
>  	}
>  
> 
