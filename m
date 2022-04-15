Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1B4502670
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351274AbiDOIAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiDOIAx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 04:00:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491C360D8F
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 00:58:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB2E31F747;
        Fri, 15 Apr 2022 07:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650009504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+50gQpe2rnCoQSZqwuJd6phgMjSO5rIweXoWiO86GI=;
        b=eRuKyAKekmG7AOxvVRejcy9p7IptP5L6jwiIXtZq1+t0n7U9bo29SEjC6e1wGGILcntM5T
        yePLC0HCSH6pezldNnuVTII1MXLt6IH2WfU0VPFiNcInylVz4BBRLLmuQGuNL4y2p5RbsS
        VT0gX7VJvTXVDHAe+9Es0Gkh7VhsVrM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D9A7139B3;
        Fri, 15 Apr 2022 07:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xPldI6AlWWJ0DgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Apr 2022 07:58:24 +0000
Message-ID: <8f8e1a81-47e7-1ca4-0bf2-043716cd5dd1@suse.com>
Date:   Fri, 15 Apr 2022 10:58:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs-progs: remove the unused btrfs_fs_info::seeding
 member
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <0965ac68fbcb31b5cc4b70da84725e887fde847c.1650007153.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <0965ac68fbcb31b5cc4b70da84725e887fde847c.1650007153.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.04.22 г. 10:19 ч., Qu Wenruo wrote:
> This member is not used by anyone, just remove it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   kernel-shared/volumes.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
> index 5cfe7e39f6b8..f9ca0a86e319 100644
> --- a/kernel-shared/volumes.h
> +++ b/kernel-shared/volumes.h
> @@ -94,7 +94,6 @@ struct btrfs_fs_devices {
>   	struct list_head devices;
>   	struct list_head list;
>   
> -	int seeding;
>   	struct btrfs_fs_devices *seed;
>   
>   	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
