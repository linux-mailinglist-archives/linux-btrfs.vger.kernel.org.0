Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D467BBB23
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjJFPCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjJFPCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 11:02:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50255A6
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 08:02:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0CCD1F896;
        Fri,  6 Oct 2023 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696604553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOQFu3c1nzh9DAstorQTah1FtHTOqsiuCeHRuVHWv7c=;
        b=z6CSg4vLt3Fn6TclG8qNSALjOejlYt+LhRGpcEVXx+AeNxcVIUySiqAyzFOhHHn8TKvuHW
        hkQiK+rDsgRoDxYSFIWHOC8g8RY8Z+AFF2IjAInC+scenGv9dup2l/LraUsQAwLO3ZtEtK
        0guESs/x3CkKZkgvk0YOnkRIXXUpN2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696604553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOQFu3c1nzh9DAstorQTah1FtHTOqsiuCeHRuVHWv7c=;
        b=z3qZYZoX8r7twYhO/7+BpmJKkJuQSs1OVy/ZpaUakAWzbqnh+KdeefgTKhkV84sm8hgpht
        p00+tB2O9+7UNqBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB77413A2E;
        Fri,  6 Oct 2023 15:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FIy/LIkhIGWxcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 15:02:33 +0000
Date:   Fri, 6 Oct 2023 16:55:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
Subject: Re: [PATCH 4/4] btrfs: show temp_fsid feature in sysfs
Message-ID: <20231006145550.GG28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696431315.git.anand.jain@oracle.com>
 <9fca0011d2ac24f7b84990db1c4af5eaa60da876.1696431315.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fca0011d2ac24f7b84990db1c4af5eaa60da876.1696431315.git.anand.jain@oracle.com>
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

On Wed, Oct 04, 2023 at 11:00:27PM +0800, Anand Jain wrote:
> This adds sysfs objects to indicate temp_fsid feature support and
> its status.
> 
>   /sys/fs/btrfs/features/temp_fsid
>   /sys/fs/btrfs/<UUID>/temp_fsid
> 
>   For example:
> 
>      Consider two cloned and mounted devices.
> 
> 	$ blkid /dev/sdc[1-2]
> 	/dev/sdc1: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..
> 	/dev/sdc2: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..
> 
>      One gets actual fsid, and the other gets the temp_fsid when
>      mounted.
> 
> 	$ btrfs filesystem show -m
> 	Label: none  uuid: 509ad44b-ad2a-4a8a-bc8d-fe69db7220d5
> 		Total devices 1 FS bytes used 54.14MiB
> 		devid    1 size 300.00MiB used 144.00MiB path /dev/sdc1
> 
> 	Label: none  uuid: 33bad74e-c91b-43a5-aef8-b3cab97ae63a
> 		Total devices 1 FS bytes used 54.14MiB
> 		devid    1 size 300.00MiB used 144.00MiB path /dev/sdc2
> 
>      Their sysfs as below.
> 
> 	$ cat /sys/fs/btrfs/features/temp_fsid
> 	0
> 
> 	$ cat /sys/fs/btrfs/509ad44b-ad2a-4a8a-bc8d-fe69db7220d5/temp_fsid
> 	0
> 
> 	$ cat /sys/fs/btrfs/33bad74e-c91b-43a5-aef8-b3cab97ae63a/temp_fsid
> 	1

So the fsid used for the directory is always the new one, is there a way
to read which is the original filesystem's fsid? In this case it would
be the 509ad44b-... We could print it in that file instead of '1',
though it could be confusing that it's not the temp_fsid but the
original one, file name mismatches the contents on first look.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index e07be193323a..7f9a4790e013 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -425,6 +425,15 @@ static ssize_t acl_show(struct kobject *kobj, struct kobj_attribute *a, char *bu
>  }
>  BTRFS_ATTR(static_feature, acl, acl_show);
>  
> +static ssize_t temp_fsid_supported_show(struct kobject *kobj,
> +					struct kobj_attribute *a, char *buf)
> +{
> +	int ret = 0;
> +
> +	return sysfs_emit(buf, "%d\n", ret);

This can be

	return sysfs_emit(buf, "0\n");
