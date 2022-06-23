Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06997557EA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiFWPbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFWPbi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 11:31:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A0B4163A
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 08:31:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55A0F1F74A;
        Thu, 23 Jun 2022 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655998296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6weq5KySz4wX/jjNcOcfrSd4M6oRdQ/viJGTJohfE4=;
        b=hajjePgZbeNLJgce0FuUCOahw25RY5rz5IlxxICRIL1nDHLTEPlFHWQaZeyMgqNL+zgoga
        NvZHhaY4nIQAcWK2FsX4jXAzP53FVkQ2FmhL62bHQOymwUmSvzoiWAr2sUC3t+Plwfcf6/
        9srnMbXhd8S7Qsx3te8GPeSyIbrwYOQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2ECDA13461;
        Thu, 23 Jun 2022 15:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uTreCFiHtGLWaQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Jun 2022 15:31:36 +0000
Message-ID: <2bac0acd-fe6c-9b26-5eec-73d6326f7781@suse.com>
Date:   Thu, 23 Jun 2022 18:31:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] Profile mask and calculation cleanups
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1655996117.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1655996117.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.06.22 г. 17:56 ч., David Sterba wrote:
> There are still some instances of hardcoded values repeating what we
> have in the raid attr table or using a similar expresion to calculate
> things that can be simplified.
> 
> David Sterba (2):
>    btrfs: use mask for all RAID1* profiles in btrfs_calc_avail_data_space
>    btrfs: merge calculations for simple striped profiles in
>      btrfs_rmap_block
> 
>   fs/btrfs/block-group.c | 5 ++---
>   fs/btrfs/super.c       | 8 ++------
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
