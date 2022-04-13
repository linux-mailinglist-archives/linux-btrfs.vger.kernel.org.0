Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A24FF98B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiDMPBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiDMPBF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:01:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE464702;
        Wed, 13 Apr 2022 07:58:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E7DB2160F;
        Wed, 13 Apr 2022 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649861922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GxKh4jt1u41zQwY9fFHOMk5qmURUsLIVA8mQOYyxDU=;
        b=O6hVIo50wvWHDzF2F5mxM/evBWX1ys7K4C3M3vCUT2/eLnQPfFweYZx95LplidWNT9oCQb
        RYGWdMnxCHlJEv7H9ZLPkRwecQX5aKb1syXbVucHysYiEIqxoQNSONpHRS+LrS/5askTWF
        AIBvmRYRknoHncWQPEAHiGVUB5yAxxk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBA0113A91;
        Wed, 13 Apr 2022 14:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GDquLiHlVmIsJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Apr 2022 14:58:41 +0000
Message-ID: <09c2a9ce-3b04-ed94-1d62-0e5a072b9dac@suse.com>
Date:   Wed, 13 Apr 2022 17:58:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: zstd: use spin_lock in timer callback
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>, dsterba@suse.cz
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        terrelln@fb.com
References: <20220411135136.GG15609@suse.cz>
 <20220411155540.36853-1-schspa@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220411155540.36853-1-schspa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.04.22 г. 18:55 ч., Schspa Shi wrote:
> This is an optimization for fix fee13fe96529 ("btrfs:
> correct zstd workspace manager lock to use spin_lock_bh()")
> 
> The critical region for wsm.lock is only accessed by the process context and
> the softirq context.
> 
> Because in the soft interrupt, the critical section will not be preempted by the
> soft interrupt again, there is no need to call spin_lock_bh(&wsm.lock) to turn
> off the soft interrupt, spin_lock(&wsm.lock) is enough for this situation.
> 
> Changelog:
> v1 -> v2:
> 	- Change the commit message to make it more readable.
> 
> [1] https://lore.kernel.org/all/20220408181523.92322-1-schspa@gmail.com/
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Has there been any measurable impact by this change? While it's correct it does mean that
  someone looking at the code would see that in one call site we use plain spinlock and in
another a _bh version and this is somewhat inconsistent.

What's more I believe this is a noop since when softirqs are executing preemptible() would
be false due to preempt_count() being non-0 and in the bh-disabling code
in the spinlock we have:

  /* First entry of a task into a BH disabled section? */
     1         if (!current->softirq_disable_cnt) {
   167                 if (preemptible()) {
     1                         local_lock(&softirq_ctrl.lock);
     2                         /* Required to meet the RCU bottomhalf requirements. */
     3                         rcu_read_lock();
     4                 } else {
     5                         DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
     6                 }
     7         }


In this case we'd hit the else branch.
> ---
>   fs/btrfs/zstd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index fc42dd0badd7..faa74306f0b7 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -105,10 +105,10 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
>   	unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
>   	struct list_head *pos, *next;
>   
> -	spin_lock_bh(&wsm.lock);
> +	spin_lock(&wsm.lock);
>   
>   	if (list_empty(&wsm.lru_list)) {
> -		spin_unlock_bh(&wsm.lock);
> +		spin_unlock(&wsm.lock);
>   		return;
>   	}
>   
> @@ -137,7 +137,7 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
>   	if (!list_empty(&wsm.lru_list))
>   		mod_timer(&wsm.timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
>   
> -	spin_unlock_bh(&wsm.lock);
> +	spin_unlock(&wsm.lock);
>   }
>   
>   /*
