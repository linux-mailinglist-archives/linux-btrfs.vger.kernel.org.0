Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B736E6216EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 15:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiKHOiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 09:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiKHOiP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 09:38:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69718F007
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 06:38:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 250D21F901;
        Tue,  8 Nov 2022 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667918293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDaM0Jpg/mURWcPGw4qNCvgZfj1L5iYw1cHXedB4Jfk=;
        b=a/f82WdjMQ8xiwupApVK4CvP6eqmpJKXdKNdolg6gwxxLW7oioEAEZom4IkWTEe+Rb3RdC
        bvIFKOjtl3RGZv0j69QLJH8qGgaUf8tj4YwBzn6dIOmJ3czlJ4wVPD9IYVSpFnilORKO1S
        Lj627fck/OM9cY5syWPIHw1QrvcNRaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667918293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDaM0Jpg/mURWcPGw4qNCvgZfj1L5iYw1cHXedB4Jfk=;
        b=MIY3h9p3XT7FZD3hMmt6MjNeJ+yUR8w05xpWj/XPGyxtdoGthMw0kR3CCk+i8p8bPNU4LS
        E1IthWMI4+FfbLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C15113398;
        Tue,  8 Nov 2022 14:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5pj/AdVpamPNNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 08 Nov 2022 14:38:13 +0000
Date:   Tue, 8 Nov 2022 15:37:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop path before copying subvol info to userspace
Message-ID: <20221108143751.GA5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3d46bd74955e2087332e492a96f6da78ca4ed533.1667898218.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d46bd74955e2087332e492a96f6da78ca4ed533.1667898218.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 08, 2022 at 07:23:19PM +0530, Anand Jain wrote:
> Similar to the commit
>    btrfs: drop path before copying root refs to userspace
> 
> btrfs_ioctl_get_subvol_info() frees the search path after the userspace
> copy from the temp buffer %subvol_info. Fix this by freeing the path
> before we copy to userspace.

Seems that there are a few more ioctls that need to be fixed:
btrfs_ioctl_logical_to_ino,
btrfs_ioctl_ino_to_path,
btrfs_ioctl_get_subvol_rootref.
