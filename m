Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549ED1A485F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDJQYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 12:24:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgDJQYv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 12:24:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 02DE2AB64;
        Fri, 10 Apr 2020 16:24:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0008FDA72D; Fri, 10 Apr 2020 18:24:12 +0200 (CEST)
Date:   Fri, 10 Apr 2020 18:24:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't force read-only after error in drop snapshot
Message-ID: <20200410162412.GM5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200225140553.24849-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225140553.24849-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 03:05:53PM +0100, David Sterba wrote:
> Deleting a subvolume on a full filesystem leads to ENOSPC followed by a
> forced read-only. This is not a transaction abort and the filesystem is
> otherwise ok, so the error should be just propagated.
> 
> This is caused by unnecessary call to btrfs_handle_fs_error for almost
> all errors, except EAGAIN. This does not make sense as the standard
> transaction abort mechanism is in btrfs_drop_snapshot so all relevant
> failures are handled.
> 
> Originally in commit cb1b69f4508a ("Btrfs: forced readonly when
> btrfs_drop_snapshot() fails") there was no return value at all, so the
> btrfs_std_error made some sense but once the error handling and
> propagation has been we don't need it.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

I'm hitting the ENOSPC and now also EINTR after the fast balance cancel
patches so this is needed. If anybody has still concerns, please let me
know, patch goes to misc-next.
