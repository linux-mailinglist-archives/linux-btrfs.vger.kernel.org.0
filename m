Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31406C704A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 19:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCWSeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCWSeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 14:34:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D210AA5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 11:34:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8985D1FE11;
        Thu, 23 Mar 2023 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679596446;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8GsP8Qq9ICfRs/ynn473VQ1X1mkTtpN8WcQmCmp9gs=;
        b=qDm62vuXomfFAulcH3U3VXgxCMvP/c1YLdsy+EJlLX5LUEp1LHwCL3rwwlX0YXCRPu0q8Q
        hSOFzE1FjXHELgOo4WloEHnU+v9GxEDoPYF7583VyxyZBACSPlC6PwTgCfV/p45IwexDSs
        MNl3LlagGzAbqhUtu+x0mAFyyVh9zHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679596446;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8GsP8Qq9ICfRs/ynn473VQ1X1mkTtpN8WcQmCmp9gs=;
        b=u+Y4Yg5n2i51L1fFT+Mveqg00sbL7Uw0nY9ts9C3PWzFcbEUf8lRMkd03/J7hZ0h5Eofpv
        rbXrvHhMdERZJ4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DE1A13596;
        Thu, 23 Mar 2023 18:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w3vNFZ6bHGSVDwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Mar 2023 18:34:06 +0000
Date:   Thu, 23 Mar 2023 19:27:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Sherry Yang <sherry.yang@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] btrfs: fix mkfs/mount/check failures due to race with
 systemd-udevd scan
Message-ID: <20230323182755.GX10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230323195710.433E.409509F4@e16-tech.com>
 <cbac9a8b-7db4-dc54-1f1d-4dc48e5dfcc9@oracle.com>
 <20230323212745.4342.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323212745.4342.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 09:27:46PM +0800, Wang Yugui wrote:
> > >> --- a/fs/btrfs/volumes.c
> > >> +++ b/fs/btrfs/volumes.c
> > >> @@ -1366,8 +1366,17 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
> > >>   	 * So, we need to add a special mount option to scan for
> > >>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
> > >>   	 */
> > >> -	flags |= FMODE_EXCL;
> > >>  >> +	/*
> > >> +	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
> > >> +	 * initiate the device scan which may race with the user's mount
> > >> +	 * or mkfs command, resulting in failure.
> > > 
> > > for  FMODE_READ | FMODE_EXCL, we need some sleep/retry,
> > > for  FMODE_WRITE | FMODE_EXCL, we should fail immediately?
> > 
> >   Sorry I don't understand the context here what represents the we here?
> > 
> >   In the LTP testcase the two sides are
> >    mkfs.<vfs|btrfs> side (FMODE_WRITE|FMODE_EXCL) and
> >    device-scan side (now: FMODE_READ, before: FMODE_READ|FMODE_EXCL)
> > 
> > > scan race with with mkfs may result worse?
> > 
> >   In the above example, the mkfs.<vfs|btrfs> failed immediately without
> >   the patch and with the patch it is successful.
> 
> With the patch, when mkfs.<vfs|btrfs> is still running, 
> device-scan can read, but the read data is meaningless, so it is worse?

With running mkfs the scan will not recognize the device as btrfs due to
lack of signature. Once mkfs ends the scan event gets triggered again
and this is the safe case when concurrent read access does not need to
be exclusive.
