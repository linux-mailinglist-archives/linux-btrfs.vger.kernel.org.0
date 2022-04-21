Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0554B509E9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 13:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388840AbiDULhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388833AbiDULhi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 07:37:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED8140F9;
        Thu, 21 Apr 2022 04:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69875210ED;
        Thu, 21 Apr 2022 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650540888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUdpjyVDRUB24rLNqY//eTYw8ccYi3jTKMDr7zd60vw=;
        b=jjZFCrhXqkTchu3wl9er2BymzLKc1QQ1YBC2VLTgfRO+Uv2zbl4OuhRewWJuPJ7motlQ/d
        cCTBoDQ2J4IGn3037iy/s4sbZxLjNi7qBafVsy3Cpqr5oLVgDx66iioYHIgQA1OYvKcbC8
        ZicrSjiBHbAOEDsdazC0kgWUO3bHCCM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D5FE13446;
        Thu, 21 Apr 2022 11:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJtJAFhBYWLUfQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Apr 2022 11:34:48 +0000
Message-ID: <d351b938-93c8-acc3-8c0f-eb471af8676d@suse.com>
Date:   Thu, 21 Apr 2022 14:34:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Fix a memory leak in btrfs_ioctl_balance()
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
To:     Haowen Bai <baihaowen@meizu.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
 <2aeffa33-e591-acad-f96f-59cfadb5aeb2@suse.com>
 <c7d16718-1071-2b57-fc77-968945cfb4f5@suse.com>
In-Reply-To: <c7d16718-1071-2b57-fc77-968945cfb4f5@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

<snip>

> 
> Actually to simplify further:
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7a6974e877f4..bbda55d41a06 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4353,6 +4353,7 @@ static long btrfs_ioctl_balance(struct file *file, 
> void __user *arg)
>          bargs = memdup_user(arg, sizeof(*bargs));
>          if (IS_ERR(bargs)) {
>                  ret = PTR_ERR(bargs);
> +               bargs = NULL;
>                  goto out;
>          }

Unf, this also leads to the double free ...

<snip>
