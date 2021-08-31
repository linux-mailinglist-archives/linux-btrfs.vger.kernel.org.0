Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFABA3FC3BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhHaHd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 03:33:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33328 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhHaHd2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 03:33:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B521F20111;
        Tue, 31 Aug 2021 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630395152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqKgi58+ZxWjC8Kl8l9Zi4NFJeubKY2NAaLpLVOB8+c=;
        b=BF6wx7Z5746J/S1wkumHMzDSqjgkKQbXLH/CQCtZKFHdmTPwfQYHms5vuw6x2qGZ2DsWZd
        YWmi/NScT3Pb0ZIlwh4C3qeN94Oy+KTv+zegcsqs/uwho1SHpgfBlOHuEx8kDG+sJ3FOvz
        vPJ7MTdcfkLWvnPPyfK1xTPJgv9+How=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 63124136DF;
        Tue, 31 Aug 2021 07:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Wvn1FBDbLWHGTAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 31 Aug 2021 07:32:32 +0000
Subject: Re: [PATCH] kobject: add the missing export for kobject_create()
To:     Qu Wenruo <wqu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20210831065009.29358-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <af01fd3e-66ed-30ac-9501-0078f074ca29@suse.com>
Date:   Tue, 31 Aug 2021 10:32:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831065009.29358-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.08.21 г. 9:50, Qu Wenruo wrote:
> [BUG]
> For any module utilizing kobject_create(), it will lead to link error:
> 
>   $ make M=fs/btrfs -j12
>     CC [M]  fs/btrfs/sysfs.o
>     LD [M]  fs/btrfs/btrfs.o
>     MODPOST fs/btrfs/Module.symvers
>   ERROR: modpost: "kobject_create" [fs/btrfs/btrfs.ko] undefined!
>   make[1]: *** [scripts/Makefile.modpost:150: fs/btrfs/Module.symvers] Error 1
>   make[1]: *** Deleting file 'fs/btrfs/Module.symvers'
>   make: *** [Makefile:1766: modules] Error 2
> 
> [CAUSE]
> It's pretty straight forward, kobject_create() doesn't have
> EXPORT_SYMBOL_GPL().
> 
> [FIX]
> Fix it by adding the missing EXPORT_SYMBOL_GPL().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> A little surprised by the fact that no know even is calling
> kobject_create() now.
> 
> Or should we just call kmalloc() manually then kobject_init_and_add()?

There is kobject_create_and_add which seems to be the preferred public API.

> ---
>  lib/kobject.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index ea53b30cf483..af308cf7dba2 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -788,6 +788,7 @@ struct kobject *kobject_create(void)
>  	kobject_init(kobj, &dynamic_kobj_ktype);
>  	return kobj;
>  }
> +EXPORT_SYMBOL_GPL(kobject_create);
>  
>  /**
>   * kobject_create_and_add() - Create a struct kobject dynamically and
> 
