Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943E9499EC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 00:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579888AbiAXWnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 17:43:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836897AbiAXWlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 17:41:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C3AE81F38A;
        Mon, 24 Jan 2022 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643064073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLwAsplTIXNRdkmmwKp1Ch2eOvcRWFAlWChvIJPMfH0=;
        b=gmw8laBfsJIPGvgCMTdba00c/5FVwjELsFHN312Cax39Z812riVmOFiHne3zK+X2vIVGU6
        m7cnVSo5PUuhGuJ35x5ilQc944mnR5w0F490EXp1ewQd2r2NtHH7Rui0hfs/9u6PFvMSXn
        GGGgZ1NCCjYIKIUv6Q+A3eJjMDlr5A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643064073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLwAsplTIXNRdkmmwKp1Ch2eOvcRWFAlWChvIJPMfH0=;
        b=sNSKCf7/fM4NEpFW3OuYe2FQMk/vUumaA8moeylzEyBly2E4bfNJ6iXCi1mYTjb2Q49ZXJ
        ehf3+YG1lhwJ4ZAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B80CBA3B89;
        Mon, 24 Jan 2022 22:41:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B6AE0DA7A9; Mon, 24 Jan 2022 23:40:33 +0100 (CET)
Date:   Mon, 24 Jan 2022 23:40:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 12/17] btrfs: send: fix maximum command numbering
Message-ID: <20220124224033.GM14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <bc324fbf99e8a792719da7bb96f5dcf4964904de.1637179348.git.osandov@fb.com>
 <20211118142359.GE28560@twin.jikos.cz>
 <YZahWPMfY5CLXTa6@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZahWPMfY5CLXTa6@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 10:54:16AM -0800, Omar Sandoval wrote:
> On Thu, Nov 18, 2021 at 03:23:59PM +0100, David Sterba wrote:
> > On Wed, Nov 17, 2021 at 12:19:22PM -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
> > > _BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
> > > version plus 1, but as written this creates gaps in the number space.
> > > The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
> > > accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
> > > has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
> > > 23 and 24 are valid commands.
> > 
> > The MAX definitions have the __ prefix so they're private and not meant
> > to be used as proper commands, so nothing should suggest there are any
> > commands with numbers 23 to 25 in the example.
> > 
> > > Instead, let's explicitly set BTRFS_SEND_C_MAX_V* to the maximum command
> > > number. This requires repeating the command name, but it has a clearer
> > > meaning and avoids gaps. It also doesn't require updating
> > > __BTRFS_SEND_C_MAX for every new version.
> > 
> > It's probably a matter of taste, I'd intentionally avoid the pattern
> > above, ie. repeating the previous command to define max.
> > 
> > > --- a/fs/btrfs/send.c
> > > +++ b/fs/btrfs/send.c
> > > @@ -316,8 +316,8 @@ __maybe_unused
> > >  static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
> > >  {
> > >  	switch (sctx->proto) {
> > > -	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
> > > -	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
> > > +	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
> > > +	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
> > 
> > This seems to be the only practical difference, < or <= .
> 
> There is another practical difference, which is more significant in my
> opinion: the linear style creates "gaps" in the valid commands. Consider
> this, with explicit values added for clarity:
> 
> enum btrfs_send_cmd {
>         BTRFS_SEND_C_UNSPEC = 0,
> 
>         /* Version 1 */
>         BTRFS_SEND_C_SUBVOL = 1,
>         BTRFS_SEND_C_SNAPSHOT = 2,
> 
>         BTRFS_SEND_C_MKFILE = 3,
>         BTRFS_SEND_C_MKDIR = 4,
>         BTRFS_SEND_C_MKNOD = 5,
>         BTRFS_SEND_C_MKFIFO = 6,
>         BTRFS_SEND_C_MKSOCK = 7,
>         BTRFS_SEND_C_SYMLINK = 8,
> 
>         BTRFS_SEND_C_RENAME = 9,
>         BTRFS_SEND_C_LINK = 10,
>         BTRFS_SEND_C_UNLINK = 11,
>         BTRFS_SEND_C_RMDIR = 12,
> 
>         BTRFS_SEND_C_SET_XATTR = 13,
>         BTRFS_SEND_C_REMOVE_XATTR = 14,
> 
>         BTRFS_SEND_C_WRITE = 15,
>         BTRFS_SEND_C_CLONE = 16,
> 
>         BTRFS_SEND_C_TRUNCATE = 17,
>         BTRFS_SEND_C_CHMOD = 18,
>         BTRFS_SEND_C_CHOWN = 19,
>         BTRFS_SEND_C_UTIMES = 20,
> 
>         BTRFS_SEND_C_END = 21,
>         BTRFS_SEND_C_UPDATE_EXTENT = 22,
>         __BTRFS_SEND_C_MAX_V1 = 23,
> 
>         /* Version 2 */
>         BTRFS_SEND_C_FALLOCATE = 24,
>         BTRFS_SEND_C_SETFLAGS = 25,
>         BTRFS_SEND_C_ENCODED_WRITE = 26,
>         __BTRFS_SEND_C_MAX_V2 = 27,
> 
>         /* End */
>         __BTRFS_SEND_C_MAX = 28,
> };
> #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1) /* 27 */

So as a compromise to avoid gaps and also repeating the last command name in
the definition, let's do it in a similar way as in your example,
explicit numbering of the commands, so the number will be repated for
the MAX constants.
