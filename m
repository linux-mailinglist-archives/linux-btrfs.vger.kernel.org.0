Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B09554BE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348395AbiFVN4v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiFVN4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 09:56:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C5F34B94
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 06:56:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 411961F966;
        Wed, 22 Jun 2022 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655906208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Qu133MNAriF4GnxoJUoJSZp2eTs8hCNukJ9B3qTewg=;
        b=fRgnF/erAsZA5yBZ08tFjwC5SKkviaBsj1DNH2UQ8Dh/X+QEJtjoHDbz9eZegooDRzESAY
        tgS3cW+J8qv6f3PfyD+TmKWHMjAe6k1wQSeHviFKdno2G8c+Iw/q3sQ5qnJHfHAo7O4tJU
        FyMRdc0bVpJBHk1HWkp3m6r0QC5dkeQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09EA8134A9;
        Wed, 22 Jun 2022 13:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kepmO58fs2KJQwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 22 Jun 2022 13:56:47 +0000
Message-ID: <9bb2b9f6-d654-eb4c-2cf1-1de02fcabfe7@suse.com>
Date:   Wed, 22 Jun 2022 16:56:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/2] btrfs: Expose commit stats through sysfs
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220621225918.4114998-1-iangelak@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220621225918.4114998-1-iangelak@fb.com>
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



On 22.06.22 г. 1:59 ч., Ioannis Angelakopoulos wrote:
> With this patch series we add the capability to btrfs to expose some
> commit stats through sysfs that might be useful for performance monitoring
> and debugging purposes.
> 
> Specifically, through sysfs we expose the following data:
>    1) A counter for the commits that occurred so far.
>    2) The duration in ms of the last commit.
>    3) The maximum commit duration in ms seen so far.
>    4) The total duration in ms of the commits seen so far.
> 
> The user also has the capability to reset the maximum commit duration
> back to zero, again through sysfs.
> 
> Changes from v3:
> 
> 1) Fixed a mistake when using div_u64 that would break the kernel build
> 
> Changes from v2:
> 
> 1) Only the maximum duration can now be zeroed out through sysfs to
> prevent loss of data if multiple threads try to reset the commit stats
> simultaneously
> 2) Removed the lock that protected the concurrent resetting and updating
> of the commit stats, since only the maximum commit duration can be
> cleared out now (any races can be ignored for this stat).
> 3) Added div_u64 when converting from ns to ms, to also support 32-bit
> 4) Made the output from sysfs easier to use with "grep"
> 
> Changes from v1:
> 
> 1) Edited out unnecessary comments
> 2) Made the memory allocation of "btrfs_commit_stats" under "fs_info" in
> fs/btrfs/ctree.h static instead of dynamic
> 3) Transferred the conversion from ns to ms at the point where commit
> stats get printed in sysfs, for better precision
> 4) Changed the lock that protects the update of the commit stats from
> "trans_lock" to "super_lock"
> 5) Changed the printing of the commits stats in sysfs to conform with
> the sysfs output
> 
> Ioannis Angelakopoulos (2):
>    btrfs: Add the capability of getting commit stats
>    btrfs: Expose the commit stats through sysfs
> 
>   fs/btrfs/ctree.h       | 14 +++++++++++++
>   fs/btrfs/sysfs.c       | 45 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/transaction.c | 22 +++++++++++++++++++++
>   3 files changed, 81 insertions(+)
> 


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
