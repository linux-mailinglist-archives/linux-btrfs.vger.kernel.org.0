Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3AFDD58
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 13:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKOMWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 07:22:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:53366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbfKOMWh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 07:22:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF25CAF61;
        Fri, 15 Nov 2019 12:22:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03669DA7D3; Fri, 15 Nov 2019 13:22:38 +0100 (CET)
Date:   Fri, 15 Nov 2019 13:22:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Misc btrfs-progs fixes
Message-ID: <20191115122238.GT3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191030122227.28496-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030122227.28496-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 02:22:24PM +0200, Nikolay Borisov wrote:
> Here are 2 cleanups and 1 minor fix for mkfs. The gist of the fix is to ensure 
> sub_stripes is always set to 1 when mkfs creates blockgroups with alloc profile 
> different than RAID10. This what kernels does. 
> 
> The other 2 patches are simple cleanups which reduce the number of arguments 
> of btrfs_alloc_data_chunk. 
> 
> Nikolay Borisov (3):
>   btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk
>   btrfs-progs: Remove type argument from btrfs_alloc_data_chunk
>   btrfs-progs: Remove convert param from btrfs_alloc_data_chunk

Added to devel, thanks.
