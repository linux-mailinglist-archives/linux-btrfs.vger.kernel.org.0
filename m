Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D512E92B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 18:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgABROS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 12:14:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:38392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgABROR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 12:14:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA105AC52;
        Thu,  2 Jan 2020 17:14:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 054FEDA790; Thu,  2 Jan 2020 18:14:08 +0100 (CET)
Date:   Thu, 2 Jan 2020 18:14:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: disk-io: Remove duplicated ASSERT() call
Message-ID: <20200102171408.GN3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191210075202.47373-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210075202.47373-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 03:52:02PM +0800, Qu Wenruo wrote:
> There are two ASSERT() with completely the same check introduced in
> commit f7717d8cdb7d ("btrfs-progs: Remove fsid/metdata_uuid fields
> from fs_info").
> 
> Just remove it.
> 
> Fixes: f7717d8cdb7d ("btrfs-progs: Remove fsid/metdata_uuid fields from fs_info")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied, thanks.
