Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF64412EC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhIUGp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 02:45:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52684 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhIUGp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 02:45:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38EB12209B;
        Tue, 21 Sep 2021 06:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632206668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LAC8NdSlbYt6FvtLRoC5lzwxZvpT0kM0taC6BKBl/Q=;
        b=ul66aIngoJPJuEYL6878HY4aaA0KqhKGFRJxvQpHHXWDaISIPvv2SdySq0Mq0mZl8UPDBv
        J+9c7KnedzvLoRIB/cZMtXskmCiUpYPQUHVRr4CUbzIEZHG7PY8MQZ8FMT8yyz5DQOLRof
        AqsCg8dvJ4TTkx2uuTve2az61DeJ62U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02BD313B9C;
        Tue, 21 Sep 2021 06:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u59IN0t/SWENcwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 21 Sep 2021 06:44:27 +0000
Subject: Re: [PATCH v6 2/3] btrfs: remove unused device_list_mutex for seed
 fs_devices
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <cover.1632179897.git.anand.jain@oracle.com>
 <457af6350aa51333fc584210d8dc5ca7e679f3f9.1632179897.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1c79bfe9-20b9-6ec8-285d-0e653215a94a@suse.com>
Date:   Tue, 21 Sep 2021 09:44:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <457af6350aa51333fc584210d8dc5ca7e679f3f9.1632179897.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.09.21 г. 7:33, Anand Jain wrote:
> The btrfs_fs_devices::seed_list is of type btrfs_fs_devices as well and,

seed_list is in fact a list_head which points to btrfs_fs_devices, so
that sentence is somewhat misleading.

> it is a pointer to the seed btrfs_fs_device in a btrfs created from a
> seed devices.
> In this struct, when it points to seed, the device_list_mutex is not
> used. So drop its initialize.

Even if the device_list_mutex is not used in the seed_devices it will
have whatever is the state from the original fs_devices so
re-initializing it to a sane state is the right thing to do.

We don't need this.

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v6: new
>  fs/btrfs/volumes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c4bc49e58b69..e4079e25db70 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2418,7 +2418,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  	seed_devices->opened = 1;
>  	INIT_LIST_HEAD(&seed_devices->devices);
>  	INIT_LIST_HEAD(&seed_devices->alloc_list);
> -	mutex_init(&seed_devices->device_list_mutex);
>  
>  	mutex_lock(&fs_devices->device_list_mutex);
>  	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
> 
