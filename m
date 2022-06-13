Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0792549F21
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiFMUbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351381AbiFMU3k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:29:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CC6560
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:18:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D9ED1F933;
        Mon, 13 Jun 2022 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655147920;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5NyIjwaBiF1Yddqsa4zaCfIxjzG0+c2TPhRtCiZYJs=;
        b=KtmF+aOiG6X0Zb5FgHPQUR2rQvcnZb1UikOJLYpzI1Uy8NRPuCC8KBneyyUxpf5+0c+7zv
        dkqjRFquAtRuCFIVx4Jic56OTzGptW1oyvAIKP7iH2etmlCYE34L9qy84oKkLnFzadyuhJ
        /yxfffMDgL2NRKXKgDQ7wqr0vUWzkMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655147920;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5NyIjwaBiF1Yddqsa4zaCfIxjzG0+c2TPhRtCiZYJs=;
        b=CkaCs2PLCi1dZiOc93fFRVLyLTSz2Eo9ou2Oeacsfm/lICp8a7U84k9gFzVA7Nd2vSidIr
        tm3w3KrFje3GC3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71A4813443;
        Mon, 13 Jun 2022 19:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DQvAGpCNp2KaLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 13 Jun 2022 19:18:40 +0000
Date:   Mon, 13 Jun 2022 21:14:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Message-ID: <20220613191407.GH20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220610205406.301397-1-iangelak@fb.com>
 <20220610205406.301397-3-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610205406.301397-3-iangelak@fb.com>
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

On Fri, Jun 10, 2022 at 01:54:09PM -0700, Ioannis Angelakopoulos wrote:
> Create a new sysfs entry named "commit_stats" for each mounted BTRFS
> filesystem. The entry exposes: 1) The number of commits so far, 2) The
> duration of the last commit in ms, 3) The maximum commit duration seen
> so far in ms and 4) The total duration for all commits so far in ms.
> 
> The function "btrfs_commit_stats_show" is responsible for exposing the
> stats to user space.

Please mention the actual path of the file, the callbacks are
implementation detail. Also mention the path at the description at the
beginning of sysfs.c.

> The function "btrfs_commit_stats_store" is responsible for resetting the
> above values to zero.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>  fs/btrfs/sysfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index b6cb5551050e..f68fc73006c0 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -991,6 +991,53 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
>  
>  BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
>  
> +static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
> +				struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +
> +	/*
> +	 * Expose the commits so far, the duration of the last commit, the
> +	 * maximum duration of a commit so far and the total duration of
> +	 * all the commits so far
> +	 */

Comment not necessary

> +	return sysfs_emit(buf, "Commits: %llu, Last: %llu ms, Max: %llu ms, Total: %llu ms\n",

So this is another format of sysfs output that does not follow any
established format. There are two: one file per value, or list of
"name space value newline" in one file (which is suitable for a set of
stats as it allow to grab a consistent snapshot). See eg.
btrfs_devinfo_error_stats_show .

> +					  fs_info->commit_stats->commit_counter,
> +					  fs_info->commit_stats->last_commit_dur,
> +					  fs_info->commit_stats->max_commit_dur,
> +					  fs_info->commit_stats->total_commit_dur);
> +}
> +
> +static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
> +						struct kobj_attribute *a,
> +						const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +
> +	if (!fs_info)
> +		return -EPERM;
> +
> +	if (!capable(CAP_SYS_RESOURCE))
> +		return -EPERM;

Should this accept only numeric value? Right now it would accept
anything, that's not common.

> +
> +	/*
> +	 * Just reset everything
> +	 * Also take the trans_lock to avoid race conditions with the udpates
> +	 * in btrfs_commit_transaction()

Comment not necessary, this is obvious.

> +	 */
> +	spin_lock(&fs_info->trans_lock);

Also I think the trans_lock is not the right one, it's a lock used for
transaction locking and more related to the transaction itself, while
the stats are a long term object and the super_lock is more sutable.

> +	fs_info->commit_stats->commit_counter = 0;
> +	fs_info->commit_stats->last_commit_dur = 0;
> +	fs_info->commit_stats->max_commit_dur = 0;
> +	fs_info->commit_stats->total_commit_dur = 0;
> +	spin_unlock(&fs_info->trans_lock);
> +
> +	return len;
> +}
> +
> +BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show,
> +			  btrfs_commit_stats_store);
> +
>  static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
>  				struct kobj_attribute *a, char *buf)
>  {
> @@ -1230,6 +1277,7 @@ static const struct attribute *btrfs_attrs[] = {
>  	BTRFS_ATTR_PTR(, generation),
>  	BTRFS_ATTR_PTR(, read_policy),
>  	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
> +	BTRFS_ATTR_PTR(, commit_stats),
>  	NULL,
>  };
>  
> -- 
> 2.30.2
> 
