Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A41416737
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbhIWVO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 17:14:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59102 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbhIWVOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 17:14:25 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 71C9D202F5;
        Thu, 23 Sep 2021 21:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632431572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIYxKeNy7V3wqQC6c2y435H7Z/5uTeyZ6GF+8Bs94A0=;
        b=cG76zJKyMesK5y6MA4+OVLJeHHZmJ1+nRZKFpL7EllVHpExlzuWpaUzPVPhhxYDFnMEBPG
        8nrBh2VO9co3ySPfm3SOcdVM5/ZT55Ydxygn9LvbT3LM1jZPf+ZcpTfgbLgVlgtvs5/ln+
        aWC08fG55m6AYCmxpAwp5fcGjP1DokI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632431572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIYxKeNy7V3wqQC6c2y435H7Z/5uTeyZ6GF+8Bs94A0=;
        b=QYgXaZRad9g4u2iarkp5nF3Du0xXj/WweWmiYoKDq8aG/LmhbCtBiRZOgGVVbafEYfbqNN
        DUobUAFNOQo96eDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 6ADE025D3C;
        Thu, 23 Sep 2021 21:12:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B024ADA7A3; Thu, 23 Sep 2021 23:12:38 +0200 (CEST)
Date:   Thu, 23 Sep 2021 23:12:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: make sure btrfs_io_context::fs_info is always
 initialized
Message-ID: <20210923211237.GZ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210923060009.53821-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923060009.53821-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 02:00:08PM +0800, Qu Wenruo wrote:
> Currently btrfs_io_context::fs_info is only initialized in
> btrfs_map_block(), but there are call sites like btrfs_map_sblock()
> which calls __btrfs_map_block() directly, leaving bioc::fs_info
> uninitialized (NULL).
> 
> Currently this is fine, but later cleanup will rely on bioc::fs_info to
> grab fs_info, and this can be a hidden problem for such usage.
> 
> This patch will remove such hidden uninitialized member by always
> assigning bioc::fs_info at alloc_btrfs_io_context().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
