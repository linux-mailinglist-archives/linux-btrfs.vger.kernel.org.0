Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795DEFDDEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 13:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKOMc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 07:32:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:59800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbfKOMc3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 07:32:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF7D8B1AA;
        Fri, 15 Nov 2019 12:32:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2B9EDA7D3; Fri, 15 Nov 2019 13:32:30 +0100 (CET)
Date:   Fri, 15 Nov 2019 13:32:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: check: Introduce optional argument for
 -b|--backup
Message-ID: <20191115123230.GU3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191021093755.56835-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021093755.56835-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 21, 2019 at 05:37:52PM +0800, Qu Wenruo wrote:
> Before this patchset, if we want to use backup roots, it's only possible
> to let btrfs-check to automatically choose the backup.
> 
> If user want to use a specified backup, it can only use -r|--tree-root
> option along with backup roots dump from "btrfs ins dump-super".
> 
> This patchset will introduce optional argument for -b|--backup, so user
> can specify which backup to use by providing the generation difference
> (-3, -2, -1).

Please don't introduce the optional arguments. I think we've learned the
lesson with 'defrag -c' or balance -d/-m arguments. In this case a long
option would be fine as the backup roots is not something that's used
often. We can keep the --backup as "use first good" and add the more
specific selection.
