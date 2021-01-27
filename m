Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01578305AC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 13:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhA0MGb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 07:06:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:38928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237259AbhA0MEP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 07:04:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38CD3AC9B;
        Wed, 27 Jan 2021 12:03:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA819DA84C; Wed, 27 Jan 2021 13:01:46 +0100 (CET)
Date:   Wed, 27 Jan 2021 13:01:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     matthias.bgg@kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Marek Behun <marek.behun@nic.cz>,
        u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] fs: btrfs: Select SHA256 in Kconfig
Message-ID: <20210127120146.GZ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, matthias.bgg@kernel.org,
        Qu Wenruo <wqu@suse.com>, Marek Behun <marek.behun@nic.cz>,
        u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20210127094231.11740-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127094231.11740-1-matthias.bgg@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 10:42:30AM +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Since commit 565a4147d17a ("fs: btrfs: Add more checksum algorithms")
> btrfs uses the sha256 checksum algorithm. But Kconfig lacks to select
> it. This leads to compilation errors:
> fs/built-in.o: In function `hash_sha256':
> fs/btrfs/crypto/hash.c:25: undefined reference to `sha256_starts'
> fs/btrfs/crypto/hash.c:26: undefined reference to `sha256_update'
> fs/btrfs/crypto/hash.c:27: undefined reference to `sha256_finish'
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

So this is a fix for u-boot, got me confused and not for the first time
as there's Kconfig and the same fs/btrfs/ directory structure.
