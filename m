Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A147A3B9828
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 23:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhGAVbw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 17:31:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35968 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhGAVbv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 17:31:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D665722959;
        Thu,  1 Jul 2021 21:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625174959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vxVxeO/BLR2aPXwEjhxpngI+8ToJNLPDRHzxpgrd4M=;
        b=BzUMWsJ39sLfnbIlgywU4tIjHM3FN0Qgc23aU5fYBB1nwcwUSKOpcic3ItSxllwrjQ0Y5H
        gwr8VQMamVw5BUji+Acqt+UTj7OTRgicngvBuhMkHBxMSuGllD/TyuqRSLvq7JNF2bLuuf
        JvY5Y7dPLwHVQ0agxwbKmCKCMw3sThU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625174959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vxVxeO/BLR2aPXwEjhxpngI+8ToJNLPDRHzxpgrd4M=;
        b=oyyEsiu0PIQ+bgjtfNMtmU+Tk+x3HQkMWXRUCpt6rCJ1Da9xfDgAqAYdn7oj5WW4Xo8K9K
        iSltrYqgb2diKpAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7E31F11CD6;
        Thu,  1 Jul 2021 21:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625174959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vxVxeO/BLR2aPXwEjhxpngI+8ToJNLPDRHzxpgrd4M=;
        b=BzUMWsJ39sLfnbIlgywU4tIjHM3FN0Qgc23aU5fYBB1nwcwUSKOpcic3ItSxllwrjQ0Y5H
        gwr8VQMamVw5BUji+Acqt+UTj7OTRgicngvBuhMkHBxMSuGllD/TyuqRSLvq7JNF2bLuuf
        JvY5Y7dPLwHVQ0agxwbKmCKCMw3sThU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625174959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vxVxeO/BLR2aPXwEjhxpngI+8ToJNLPDRHzxpgrd4M=;
        b=oyyEsiu0PIQ+bgjtfNMtmU+Tk+x3HQkMWXRUCpt6rCJ1Da9xfDgAqAYdn7oj5WW4Xo8K9K
        iSltrYqgb2diKpAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id FOdOE68z3mASKgAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Thu, 01 Jul 2021 21:29:19 +0000
Date:   Thu, 1 Jul 2021 16:29:17 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Dave Sterba <DSterba@suse.com>
Subject: Re: [PATCH] btrfs-progs: Correct check_running_fs_exclop() return
 value
Message-ID: <20210701212917.l4lvoq7lofkrpher@fiona>
References: <20210628194000.org5zuvytk34yvwy@fiona>
 <20210701192125.GA2610@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701192125.GA2610@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21:21 01/07, David Sterba wrote:
> On Mon, Jun 28, 2021 at 02:40:00PM -0500, Goldwyn Rodrigues wrote:
> > check_running_fs_exclop() can return 1 when exclop is changed to "none"
> > The ret is set by the return value of the select() operation. Checking
> > the exclusive op changes just the exclop variable while ret is still
> > set to 1.
> > 
> > Set ret = 0 if exclop is set to BTRFS_EXCL_NONE or BTRFS_EXCL_UNKNOWN.
> > Remove unnecessary continue statement at the end of the block.
> 
> That's describing what the code does in words, but there must be some
> user visible effects like failed command. Do you have some reproducer?
> 
> I've applied patch as it's a fix but would still like to update the
> changelog.

If check_running_fs_exclop() returns anything but zero, it would exit
immediately and the ioctl, for which the program is called, is not
executed, without any error notice. IOW, the command appears to have
executed, but does not. This was found when balance which typically
reports chunks relocated did not print anything on screen.

-- 
Goldwyn
