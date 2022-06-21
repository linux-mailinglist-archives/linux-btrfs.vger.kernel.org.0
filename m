Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE1553502
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbiFUOyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 10:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350167AbiFUOyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 10:54:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF2237F6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 07:54:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB15821A91;
        Tue, 21 Jun 2022 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655823238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmkecIeWc2i5eH7vg/XYRl5h3UBUrN3X0hS+3ZYQ49k=;
        b=yMRJ8ZQBU9tXOZxUHEqgl07l/m/Bv4wv43eLzzUy+qkiO2h4L7isCQl64SfYbue+dunIub
        pGJWBIAixYUfLFMeIcpds8vAaUCIb1037qrt4omNzU+BrvaU+wFeiOpi7z7xOMLZwshphJ
        xDsUttgzkQLCj/qo0wHXmgm78/8gz8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655823238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmkecIeWc2i5eH7vg/XYRl5h3UBUrN3X0hS+3ZYQ49k=;
        b=moT70xueb+47TRKVb54uf0wKHSkT/MR+D7pprK5gCM0niDXstidQhqdM3WuTkXGbqwYD0X
        L1GcI/V+ir4mkvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B1D913638;
        Tue, 21 Jun 2022 14:53:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oLjmJIbbsWLBWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 14:53:58 +0000
Date:   Tue, 21 Jun 2022 16:49:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Message-ID: <20220621144921.GC20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614222231.2582876-3-iangelak@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 14, 2022 at 03:22:34PM -0700, Ioannis Angelakopoulos wrote:
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
>  fs/btrfs/sysfs.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index db3736de14a5..54b26aef290b 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -991,6 +991,55 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
>  
>  BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
>  
> +static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
> +				struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +
> +	return sysfs_emit(buf,
> +		"commits %llu\n"
> +		"last_commit_dur %llu ms\n"

		last_commit_dur_ms %llu

so the name and units is in one string and "name value" on each line. In
case we'd want to add _ns variants for better precision. Sysfs is often
used as "grep value_name /sys/.../file" so it's future proof.

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
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	unsigned long val;
> +	int ret;
> +
> +	if (!fs_info)
> +		return -EPERM;
> +
> +	if (!capable(CAP_SYS_RESOURCE))
> +		return -EPERM;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +	if (val)
> +		return -EINVAL;
> +
> +	spin_lock(&fs_info->super_lock);
> +	fs_info->commit_stats.commit_counter = 0;
> +	fs_info->commit_stats.last_commit_dur = 0;
> +	fs_info->commit_stats.max_commit_dur = 0;
> +	fs_info->commit_stats.total_commit_dur = 0;
> +	spin_unlock(&fs_info->super_lock);
> +
> +	return len;
> +}

No newline

> +
> +BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show,
> +			  btrfs_commit_stats_store);
> +
>  static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
>  				struct kobj_attribute *a, char *buf)
>  {
> @@ -1230,6 +1279,7 @@ static const struct attribute *btrfs_attrs[] = {
>  	BTRFS_ATTR_PTR(, generation),
>  	BTRFS_ATTR_PTR(, read_policy),
>  	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
> +	BTRFS_ATTR_PTR(, commit_stats),
>  	NULL,
>  };
>  
> @@ -2236,4 +2286,3 @@ void __cold btrfs_exit_sysfs(void)
>  #endif
>  	kset_unregister(btrfs_kset);
>  }
> -
> -- 
> 2.30.2
> 
