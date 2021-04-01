Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D49351ACB
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhDASDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 14:03:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:39530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhDAR6l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 13:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1301B1D5;
        Thu,  1 Apr 2021 17:58:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80724DA790; Thu,  1 Apr 2021 19:56:31 +0200 (CEST)
Date:   Thu, 1 Apr 2021 19:56:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 01/13] btrfs: add sysfs interface for supported
 sectorsize
Message-ID: <20210401175631.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210325071445.90896-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325071445.90896-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 03:14:33PM +0800, Qu Wenruo wrote:
> Add extra sysfs interface features/supported_ro_sectorsize and
> features/supported_rw_sectorsize to indicate subpage support.
> 
> Currently for supported_rw_sectorsize all architectures only have their
> PAGE_SIZE listed.
> 
> While for supported_ro_sectorsize, for systems with 64K page size, 4K
> sectorsize is also supported.
> 
> This new sysfs interface would help mkfs.btrfs to do more accurate
> warning.

I've reworded the changelog to reflect the code status, ie. just one
file and that the read-only support could do more than it's advertised
in the sysfs file and that this will change.
