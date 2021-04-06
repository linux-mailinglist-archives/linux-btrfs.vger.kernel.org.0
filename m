Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0E355C29
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 21:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhDFT0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 15:26:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234556AbhDFT0E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 15:26:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 087E9B2FC;
        Tue,  6 Apr 2021 19:25:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AEA7DDA732; Tue,  6 Apr 2021 21:23:42 +0200 (CEST)
Date:   Tue, 6 Apr 2021 21:23:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] fs: btrfs: Remove repeated struct declaration
Message-ID: <20210406192342.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wan Jiabing <wanjiabing@vivo.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
References: <20210401080339.999529-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401080339.999529-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 01, 2021 at 04:03:39PM +0800, Wan Jiabing wrote:
> struct btrfs_inode is declared twice. One is declared at 67th line.
> The blew declaration is not needed. Remove the duplicate.
> struct btrfs_fs_info should be declared in the forward declarations.
> Move it to the forward declarations.

I've reworded the changelog a bit, patch added to misc-next, thanks.
