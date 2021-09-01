Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857903FD6B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbhIAJXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 05:23:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbhIAJX2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 05:23:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCC2C202A8;
        Wed,  1 Sep 2021 09:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630488150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fx9Ocja+mh8pDvDaUtoNhVHhSYw7PeCEJ52bur4lgbQ=;
        b=XenSPa6raNuSm9q3twXF8rsLobZnjLpPbbDg90aytXHxhSQVMOTqD6dY/7j12ADqeO7hLW
        YcmLtwEVDIjg57CTi5yFEIImnvoWWowLsGcfknDxIn47op6XZxm9zKHPTnvV7S1z+Y36RM
        YAuibVszXESimnyJzoumOxBruPR1bdc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A98F513A3E;
        Wed,  1 Sep 2021 09:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KpSiJlZGL2H4GAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 01 Sep 2021 09:22:30 +0000
Subject: Re: [PATCH 1/2] btrfs: use num_device to check for the last surviving
 seed device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1630478246.git.anand.jain@oracle.com>
 <d9c89b1740a876b3851fcf358f22809aa7f1ad2a.1630478246.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ea5d6985-7c7d-3147-e0b6-fac17a2e298f@suse.com>
Date:   Wed, 1 Sep 2021 12:22:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d9c89b1740a876b3851fcf358f22809aa7f1ad2a.1630478246.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.09.21 г. 9:43, Anand Jain wrote:
> For both sprout and seed fsids,
>  btrfs_fs_devices::num_devices provides device count including missing
>  btrfs_fs_devices::open_devices provides device count excluding missing
> 
> We create a dummy struct btrfs_device for the missing device, so
> num_devices != open_devices when there is a missing device.
> 
> In btrfs_rm_devices() we wrongly check for %cur_devices->open_devices
> before freeing the seed fs_devices. Instead we should check for
> %cur_devices->num_devices.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Is there a sequence of step that reproduce the problem?

> ---
>  fs/btrfs/volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 53ead67b625c..5b36859a7b5e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2184,7 +2184,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>  	synchronize_rcu();
>  	btrfs_free_device(device);
>  
> -	if (cur_devices->open_devices == 0) {
> +	if (cur_devices->num_devices == 0) {
>  		list_del_init(&cur_devices->seed_list);
>  		close_fs_devices(cur_devices);
>  		free_fs_devices(cur_devices);
> 
