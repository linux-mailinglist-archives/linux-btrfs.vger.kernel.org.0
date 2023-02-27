Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD476A4A86
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjB0TCP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 14:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0TCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 14:02:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4F25295
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 11:02:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C137219FB;
        Mon, 27 Feb 2023 19:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677524530;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGO7Xth/OOlUstZ4FRk2GV3d+IRwDtrRJhsSxExEG6w=;
        b=VN+1tAyaVl/CvEKpUP2qAoadmzKFVgIthCtSi6ercDlZKrdTUEknb0UCYQr3OxZ6ntqAhy
        cXYm4/Q+wpzyyxXC+alOFoVyW5D5eLRkowC8V8DzSik/gTL7O3vdgvvbYl97BoZJbJvAH5
        LgEB/7AQIpBDfIgWEAuFBBGn5IN/09Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677524530;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGO7Xth/OOlUstZ4FRk2GV3d+IRwDtrRJhsSxExEG6w=;
        b=z4RtDp/GSMCMMM/DhQlTkFd++ldI1o3HfAfVV+GGTMyKiwpe6kt1l69y48CsHgwWpLxhr6
        EhcwBkSpi1CiSJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CA1713A43;
        Mon, 27 Feb 2023 19:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5VS8ETL+/GP0CAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 19:02:10 +0000
Date:   Mon, 27 Feb 2023 19:56:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: ioctl: allow dev info ioctl to return fsid of
 a device
Message-ID: <20230227185611.GI10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c3e2ff2f10b0da711a619745495bb8e8c80c1ad0.1676116309.git.wqu@suse.com>
 <c8dfba01-a78d-b450-3452-931dce4305f1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8dfba01-a78d-b450-3452-931dce4305f1@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 24, 2023 at 11:59:01AM +0800, Anand Jain wrote:
> 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> I was uncertain whether we needed this patch, as the sysfs already
> provides fsid. Nevertheless, it looks good

The sysfs and ioctl overlap in the provided information and we can
extend them in both was as needed. The sysfs files are universal and
often targeting shell scripts, the ioctls are for programatic use.

> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Small nit below.
> 
> 
> > diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> > index b4f0f9531119..cbb22dbdd108 100644
> > --- a/include/uapi/linux/btrfs.h
> > +++ b/include/uapi/linux/btrfs.h
> > @@ -245,7 +245,18 @@ struct btrfs_ioctl_dev_info_args {
> >   	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
> >   	__u64 bytes_used;			/* out */
> >   	__u64 total_bytes;			/* out */
> > -	__u64 unused[379];			/* pad to 4k */
> > +	/*
> > +	 * Optional, out.
> > +	 *
> > +	 * Showing the fsid of the device, allowing user space
> > +	 * to check if this device is a seed one.
> > +	 *
> > +	 * Introduced in v6.4, thus user space still needs to
> 
>                           ^ v6.3
> It looks like this will go into v6.3, so it should be fixed while merging.

Fixed in the committed version.
