Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267C416ED2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 11:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbhIXJ1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 05:27:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39590 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhIXJ1j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 05:27:39 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1EE891FFDF;
        Fri, 24 Sep 2021 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632475566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEAo5hrW/wGAdaUR92Y8B0gDOa2epc6Z0UYhIHHcQp8=;
        b=VNqjEj+o/mQKvcWY3iWkOeMi/ceRR4xhOnlHgmECVYAdQHta0UDkSaLmO1e8Jb2WkyweUP
        wJxGkiAUnVKBJXMuuZy3JuZqAbZqNIOFUA/Hb0wHJhfWmwg2RasHvrYEF1vwKQE7kWqYbt
        PLem1l1gKDnXo8gCfLCSpe5q2jQoK/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632475566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEAo5hrW/wGAdaUR92Y8B0gDOa2epc6Z0UYhIHHcQp8=;
        b=kgJ2vzusygWdLjFkngsOzQr7FGbpZI5eKl6qax/jKD0wifPd+wdQCXuf8V9ePe4ZW7c01e
        l2XTsgxqTdMlaKBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 17C4D25D3E;
        Fri, 24 Sep 2021 09:26:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8C15DA7A3; Fri, 24 Sep 2021 11:25:52 +0200 (CEST)
Date:   Fri, 24 Sep 2021 11:25:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Remove support for BTRFS_SUBVOL_CREATE_ASYNC
Message-ID: <20210924092552.GA9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210923124127.119119-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923124127.119119-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 03:41:27PM +0300, Nikolay Borisov wrote:
> Kernel has removed support for this feature in 5.7 so let's remove
> support from progs as well.

For the record, summary of the discussion.  Removing this is from progs
an libbtrfsutil does not seem to be that critical like the kernel patch,
as eg. strace uses the kernel uapi definition and also does conditional
tests if the macro even exists.

If something is using libbtrfs-devel/ioctl.h, then it should switch to
the kernel uapi but I haven't found any such project.

We may still need to keep some placeholder or comment that the value
used to mean something. We could potentially reuse it in the future, but
there must be some deprecation period.
