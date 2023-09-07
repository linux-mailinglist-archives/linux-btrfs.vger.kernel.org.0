Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FF797A1A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbjIGRaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjIGRav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 13:30:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4624F91
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 10:30:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18B7F1F461;
        Thu,  7 Sep 2023 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694086351;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jaAzWCd64GLKcAI7yBVVfVbGBhHSDWpNzSQiVOQzW50=;
        b=nWVPogd2p0m3jHhOJIZKn/qBgcN9AjQcAy2kl6A0bkGnIDZfULGWgzVfOtcGopcXUB+gBN
        iJsFE00aJfk12oKWzSA6V0pLzM0k74pw0bCitO+xOktlkh/do96bzZy8NmVxb2RySTt2Vx
        y3MavY3Qre51D1Ji0XyxAfd2gq+6S3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694086351;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jaAzWCd64GLKcAI7yBVVfVbGBhHSDWpNzSQiVOQzW50=;
        b=aUeGhr3CMcWhi65VcodpHXpr/LtLmMSZWtVfFwTxDe9mOUkSlw4zq1tmEUOAWHzRAmOCRO
        EOhZzEA4uT6/SiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4C90138F9;
        Thu,  7 Sep 2023 11:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mcJLM860+WQ8ewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 11:32:30 +0000
Date:   Thu, 7 Sep 2023 13:25:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 03/18] btrfs: expose quota mode via sysfs
Message-ID: <20230907112559.GC3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <9c9d150a93e91a5a648840ef77240e81b70ff769.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9d150a93e91a5a648840ef77240e81b70ff769.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:50PM -0700, Boris Burkov wrote:
> Add a new sysfs file
> /sys/fs/btrfs/<uuid>/qgroups/mode
> which prints out the mode qgroups is running in. The possible modes are
> disabled, qgroup, and squota

Can you get the 'disabled' at all? Because when the quotas are disabled
by ioctl the whole sysfs directory is gone, see btrfs_free_qgroup_config().

> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/sysfs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index b1d1ac25237b..e53614753391 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2086,6 +2086,31 @@ static ssize_t qgroup_enabled_show(struct kobject *qgroups_kobj,
>  }
>  BTRFS_ATTR(qgroups, enabled, qgroup_enabled_show);
>  
> +static ssize_t qgroup_mode_show(struct kobject *qgroups_kobj,
> +				struct kobj_attribute *a,
> +				char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
> +	char *mode = "";
> +
> +	spin_lock(&fs_info->qgroup_lock);
> +	switch (btrfs_qgroup_mode(fs_info)) {
> +	case BTRFS_QGROUP_MODE_DISABLED:
> +		mode = "disabled";
> +		break;
> +	case BTRFS_QGROUP_MODE_FULL:
> +		mode = "qgroup";
> +		break;
> +	case BTRFS_QGROUP_MODE_SIMPLE:
> +		mode = "squota";

You can do

	lock;
	switch (mode) {
	case FULL:   sysfs_emit(buf, "qgroup\n"); break;
	case SIMPLE: sysfs_emit(buf, "simple\n"); break;
	}
	unlock;
	return 7;

or track the return value from sysfs_emit so it's not so hacky.

> +		break;
> +	}
> +	spin_unlock(&fs_info->qgroup_lock);
> +
> +	return sysfs_emit(buf, "%s\n", mode);
> +}
> +BTRFS_ATTR(qgroups, mode, qgroup_mode_show);
> +
>  static ssize_t qgroup_inconsistent_show(struct kobject *qgroups_kobj,
>  					struct kobj_attribute *a,
>  					char *buf)
> @@ -2148,6 +2173,7 @@ static struct attribute *qgroups_attrs[] = {
>  	BTRFS_ATTR_PTR(qgroups, enabled),
>  	BTRFS_ATTR_PTR(qgroups, inconsistent),
>  	BTRFS_ATTR_PTR(qgroups, drop_subtree_threshold),
> +	BTRFS_ATTR_PTR(qgroups, mode),
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(qgroups);
> -- 
> 2.41.0
