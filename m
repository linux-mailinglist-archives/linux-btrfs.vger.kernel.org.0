Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08D69D4A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfHZRGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 13:06:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732089AbfHZRGz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 13:06:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EE55B63F
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 17:06:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 503D2DA98E; Mon, 26 Aug 2019 19:07:18 +0200 (CEST)
Date:   Mon, 26 Aug 2019 19:07:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2.1 0/3] btrfs-progs: Check and repair invalid root item
 generation
Message-ID: <20190826170718.GZ2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190812063422.22219-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812063422.22219-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 12, 2019 at 02:34:19PM +0800, Qu Wenruo wrote:
> Kernel is going to reject invalid root generation.
> 
> Consider the existing checks are causing some error reports, we should
> handle such problem in advance, so that's the patchset is going to do,
> check and repair such invalid root generation.
> 
> Changelog:
> v2:
> - Use existing recow_extent_buffer() to do the repair
> 
> v2.1:
> - Add beacon file to allow lowmem mode repair for newly added test case.
> 
> Qu Wenruo (3):
>   btrfs-progs: check/lowmem: Check and repair root generation
>   btrfs-progs: check/original: Check and repair root item geneartion
>   btrfs-progs: fsck-tests: Add test case for invalid root generation

Added to devel, thanks!
