Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B401FF62C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgFRPGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 11:06:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731001AbgFRPGY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 11:06:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC103ADD6;
        Thu, 18 Jun 2020 15:06:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F124DA703; Thu, 18 Jun 2020 17:06:13 +0200 (CEST)
Date:   Thu, 18 Jun 2020 17:06:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: mkfs: fix mkfs --rootdir size problem
Message-ID: <20200618150613.GX27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200616063230.90165-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616063230.90165-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 02:32:28PM +0800, Qu Wenruo wrote:
> There is a bug report that mkfs.btrfs with -b limit, -d dup, and
> --rootdir with some contents filled, leads to unexpected ENOSPC.
> 
> It turns out that, the new chunk allocation code is broken quite some
> time ago, and by coincident we're using SINGLE data profile by default,
> it doesn't get exposed through existing test cases.
> 
> The patchset will fix it and add corresponding test case for it.
> 
> Qu Wenruo (2):
>   btrfs-progs: fix wrong chunk profile for do_chunk_alloc()
>   btrfs-progs: mkfs-tests: Add test case to verify the --rootdir size
>     limit

Thanks, added to devel.
