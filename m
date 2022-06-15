Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD40A54C8E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348534AbiFOMrz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348456AbiFOMry (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 08:47:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86EDF6B
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 05:47:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FD1521C5A;
        Wed, 15 Jun 2022 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655297272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+dd2GJtEQ1YbzxJM0+qYnbkaC9XurfwQ8/BvLNTKVk=;
        b=E2VSyOMZToTailB0MG2pml7rX3erBS5bUfb9Ij/su4FFFkhz+/p8MbUgmxlOyJvMc5HuWg
        mFZNAhmzEgap1OdDPpi5UzK5mC27mZ+K5WeQqZBAPTClBzzqbEMkLnCkcvzvWX39mMJWKl
        j+qim7HV1x7FgGmOAe5imUlzl3xoDlM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA84313A35;
        Wed, 15 Jun 2022 12:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G5ycMvfUqWJxFAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Jun 2022 12:47:51 +0000
Message-ID: <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
Date:   Wed, 15 Jun 2022 15:47:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220614222231.2582876-3-iangelak@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.06.22 г. 1:22 ч., Ioannis Angelakopoulos wrote:
> Create a new sysfs entry named "commit_stats" under /sys/fs/btrfs/<UUID>/
> for each mounted BTRFS filesystem. The entry exposes: 1) The number of
> commits so far, 2) The duration of the last commit in ms, 3) The maximum
> commit duration seen so far in ms and 4) The total duration for all commits
> so far in ms.
> 
> The function "btrfs_commit_stats_show" in fs/btrfs/sysfs.c is responsible
> for exposing the stats to user space.
> 
> The function "btrfs_commit_stats_store" in fs/btrfs/sysfs.c is responsible
> for resetting the above values to zero.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>   fs/btrfs/sysfs.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index db3736de14a5..54b26aef290b 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -991,6 +991,55 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
>   
>   BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
>   
> +static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
> +				struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +
> +	return sysfs_emit(buf,
> +		"commits %llu\n"
> +		"last_commit_dur %llu ms\n"
> +		"max_commit_dur %llu ms\n"
> +		"total_commit_dur %llu ms\n",
> +		fs_info->commit_stats.commit_counter,
> +		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
> +		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
> +		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
> +}
> +
> +static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
> +						struct kobj_attribute *a,
> +						const char *buf, size_t len)
> +{

Is there really value in being able to zero out the current stats?


<snip>
