Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4BE3C9E09
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhGOL6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 07:58:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59208 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhGOL6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 07:58:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 301CA22A08;
        Thu, 15 Jul 2021 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626350138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0P5XBtGFEFlf02xC8Z0PQcajQCMzXtZPbZNkfbQBcI=;
        b=On8ITqXY3szBMaOX4uyA4mLGdeqWiLBEJK/Dfbpk0iOHe67oFS8jJkY7RhH9+GAiKVIiZX
        kwZu43aCGJV7C5ru5FBwFpqyW3aiJcF0wWH8pURBySyyElQwtxig2znzBtFS3g600x033z
        pTB44ZWTcSGA6jkIXBdp0ZGwc4E5OlQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9D62F13D7E;
        Thu, 15 Jul 2021 11:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WyiAIzki8GDdNAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 15 Jul 2021 11:55:37 +0000
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7ae7a858-9893-c41c-ed96-10651c295087@suse.com>
Date:   Thu, 15 Jul 2021 14:55:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715103403.176695-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.07.21 г. 13:34, Desmond Cheong Zhi Xi wrote:
> Syzbot reports a warning in close_fs_devices that happens because
> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
> on each device.
> 
> This happens when a writeable device is removed in
> __btrfs_free_extra_devids, but the rw device count is not decremented
> accordingly. So when close_fs_devices is called, the removed device is
> still counted and we get an off by 1 error.
> 
> Here is one call trace that was observed:
>   btrfs_mount_root():
>     btrfs_scan_one_device():
>       device_list_add();   <---------------- device added
>     btrfs_open_devices():
>       open_fs_devices():
>         btrfs_open_one_device();   <-------- rw device count ++
>     btrfs_fill_super():
>       open_ctree():
>         btrfs_free_extra_devids():
> 	  __btrfs_free_extra_devids();  <--- device removed
> 	  fail_tree_roots:
> 	    btrfs_close_devices():
> 	      close_fs_devices();   <------- rw device count off by 1
> 
> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

Is there a reliable reproducer from syzbot? Can this be turned into an
xfstest?

> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 807502cd6510..916c25371658 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>  		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>  			list_del_init(&device->dev_alloc_list);
>  			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> +			fs_devices->rw_devices--;
>  		}
>  		list_del_init(&device->dev_list);
>  		fs_devices->num_devices--;
> 
