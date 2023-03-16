Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0696BD2C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 15:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCPOyS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCPOyR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 10:54:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAC8EA22
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 07:54:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C44021A30;
        Thu, 16 Mar 2023 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678978454;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwbfkOdciBmci2IPJebVtVUNuwkAYcyFJ4wxXNJf5B8=;
        b=XN4IpDO15QQLH+p2YkoaALeyvgmuSRCW3mdTNiBvtvToxyd976pk3IIIgDZADMhjpYZYh2
        A7ExJA6UWlMP1ztxLjgPhbj8SJctB/6oZINuz/KMwA4YN6wfxxevsM7mlAHEACmjzpDWV9
        60jYNfdO225M/o2CCuR+pltdaNtNRd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678978454;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwbfkOdciBmci2IPJebVtVUNuwkAYcyFJ4wxXNJf5B8=;
        b=+I8H5PKsO9sTSi4bIX7W8T5mE/bnLiAS6kgqYYR7IN21kECHf4SsCNs+6RBBJbgsRTl6PA
        VCGszNXM8TSGH8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 428DD13A2F;
        Thu, 16 Mar 2023 14:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ba0YD5YtE2QjdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Mar 2023 14:54:14 +0000
Date:   Thu, 16 Mar 2023 15:48:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: documentation for discard tunables and
 metrics in sysfs
Message-ID: <20230316144806.GX10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4800c5464b3fb4ace327180ffe32c378d6356e13.1678709623.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4800c5464b3fb4ace327180ffe32c378d6356e13.1678709623.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 01:00:50PM +0800, Anand Jain wrote:
> Since kernel v6.1, we have had discard tunables and metrics under sysfs.
> This patch adds documentation for them.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.

> ---
>  Documentation/ch-sysfs.rst | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
> index b3cd8eec4c5a..055ebd457d0b 100644
> --- a/Documentation/ch-sysfs.rst
> +++ b/Documentation/ch-sysfs.rst
> @@ -13,6 +13,7 @@ features/                      All supported features               3.14+
>  <UUID>/devinfo/<DEVID>/        Btrfs specific info for each device  5.6+
>  <UUID>/qgroups/                Global qgroup info                   5.9+
>  <UUID>/qgroups/<LEVEL>_<ID>/   Info for each qgroup                 5.9+
> +<UUID>/discard/                Discard stats and tunables           6.1+
>  =============================  ===================================  ========
>  
>  For `/sys/fs/btrfs/features/` directory, each file means a supported feature
> @@ -247,3 +248,41 @@ rsv_meta_prealloc
>          (RO, since: 5.9)
>  
>          Shows the reserved bytes for preallocated metadata.
> +
> +Files in `/sys/fs/btrfs/<UUID>/discard/` directory are:
> +
> +discardable_bytes
> +        (RO, since: 6.1)

Note that there needs to be a newline between the version info and
descrtipion, so it's rendered on separate lines.
