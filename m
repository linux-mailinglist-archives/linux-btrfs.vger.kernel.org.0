Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB8742ACC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjF2Qr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjF2Qrz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 12:47:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7BF30DD
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 09:47:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB89A21845;
        Thu, 29 Jun 2023 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688057272;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMrqpEEn+zgOPuq2hTPbZ9XjFQz9yGfdz6sLKf2Ja/Y=;
        b=NZfEZuqzMMDOuJPmA1ofBCU1qnTnuh7JAuo9cbuFPfDiZM0thg/tFo3MSL1j83uTgTCiPW
        kXwdflZeNGZ+K11HMFkeRlWm7FxtYY07HB2n/QumTo5c5ztwOzJZfo2h3ZQC3XaQlt6z52
        +A9VkmYGN/bbCKrAiI7bFxK+9JxOlD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688057272;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMrqpEEn+zgOPuq2hTPbZ9XjFQz9yGfdz6sLKf2Ja/Y=;
        b=+jTnktBs8WqP7W9+SidpL8Xhnky1PU6iMSoful/+jy0fKSMjg9fw7JOESDRa0RfiGdjTaF
        0uPdHIpkwX2ZutBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F7EB13905;
        Thu, 29 Jun 2023 16:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wsBGHri1nWRAXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 16:47:52 +0000
Date:   Thu, 29 Jun 2023 18:41:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: display ACL support
Message-ID: <20230629164123.GS16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com>
 <1d62fb411a289807d8d12d6a76bdca867a56b591.1687248417.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d62fb411a289807d8d12d6a76bdca867a56b591.1687248417.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 04:55:09PM +0800, Anand Jain wrote:
> ACL support is dependent on the compile-time configuration option
> CONFIG_BTRFS_FS_POSIX_ACL. Prior to mounting a btrfs filesystem, it is not
> possible to determine whether ACL support has been compiled in. To address
> this, add a sysfs interface, /sys/fs/btrfs/features/acl, and check for ACL
> support in the system's btrfs.
> 
>   To determine ACL support:
> 
>   Return 0 indicates ACL is not supported:
>     $ cat /sys/fs/btrfs/features/acl
>     0
> 
>   Return 1 indicates ACL is supported:
>     $ cat /sys/fs/btrfs/features/acl
>     1
> 
> IMO, this is a better approach, so that we also know if kernel is older.
> 
>   On an older kernel
>     $ ls /sys/fs/btrfs/features/acl
>     ls: cannot access '/sys/fs/btrfs/features/acl': No such file or directory
> 
>     mount a btrfs filesystem
>     $ cat /proc/self/mounts | grep btrfs | grep -q noacl
>     $ echo $?
>     0
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/sysfs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 25294e624851..25b311bb47ac 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -414,6 +414,21 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>  BTRFS_ATTR(static_feature, supported_sectorsizes,
>  	   supported_sectorsizes_show);
>  
> +static ssize_t acl_show(struct kobject *kobj, struct kobj_attribute *a,
> +			char *buf)
> +{
> +	ssize_t ret = 0;

The simple callback can return directly sysfs_emit_at without the return
variable. Updated.

> +
> +#ifdef CONFIG_BTRFS_FS_POSIX_ACL
> +	ret += sysfs_emit_at(buf, ret, "%d\n", 1);
> +#else
> +	ret += sysfs_emit_at(buf, ret, "%d\n", 0);
> +#endif
> +
> +	return ret;
> +}
> +BTRFS_ATTR(static_feature, acl, acl_show);
> +
>  /*
>   * Features which only depend on kernel version.
>   *
> @@ -426,6 +441,7 @@ static struct attribute *btrfs_supported_static_feature_attrs[] = {
>  	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>  	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
>  	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
> +	BTRFS_ATTR_PTR(static_feature, acl),

Please keep the features sorted alphabetically, moved to the beginning
of the list.

>  	NULL
>  };
