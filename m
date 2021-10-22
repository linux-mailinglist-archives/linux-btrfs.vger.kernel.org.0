Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77754378DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhJVOSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 10:18:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57402 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhJVOSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 10:18:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 361412197A;
        Fri, 22 Oct 2021 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634912177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlBpEBPyW/s3kMlSsg/xtBWI3NGn9yx5T2Shy5E8HzM=;
        b=Ms3i2y256t4iYq7iFk3ViS7/UbCN/4T8l/10ce7M/dzIP4NWy9xR9RxA/asEm/flCyr6AD
        FqiPkPVSzk23jIWG+EnVo9/t9RwOBz9M71BVyG76P4ek1MXT2ANRWiQaF88QSJwx55KSWP
        ozUtE+7aAcZQMH2UDrRdbte54f5Am80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634912177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlBpEBPyW/s3kMlSsg/xtBWI3NGn9yx5T2Shy5E8HzM=;
        b=QUw+EYBItabXx4eyK4I4rewnufvHBcVqp0PkTQ5HfndSNsB8y0b0hJzVkJ3H0HGoNwx/rk
        r7I6AWVjRM5TqdBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2FC59A3B81;
        Fri, 22 Oct 2021 14:16:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0BF41DA7A9; Fri, 22 Oct 2021 16:15:48 +0200 (CEST)
Date:   Fri, 22 Oct 2021 16:15:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: fix comment about sector sizes supported in 64K
 systems
Message-ID: <20211022141547.GM20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, wqu@suse.com
References: <59371eece911ff3e73517fc9e3fbafa843f9bcc3.1634860167.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59371eece911ff3e73517fc9e3fbafa843f9bcc3.1634860167.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 07:53:05AM +0800, Anand Jain wrote:
> Commit 95ea0486b20e ("btrfs: allow read-write for 4K sectorsize on 64K
> page size systems") added write support for 4K sectorsize on a 64K
> systems. Fix the now stale comments.
> 
> No functional change.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
