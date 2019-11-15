Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00100FE299
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 17:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKOQUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 11:20:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:38216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbfKOQUk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 11:20:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED724AEEE;
        Fri, 15 Nov 2019 16:20:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3BBFDA7D3; Fri, 15 Nov 2019 17:20:41 +0100 (CET)
Date:   Fri, 15 Nov 2019 17:20:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org, Damenly_Su@gmx.com
Subject: Re: [PATCH 1/2] btrfs-progs: add comments of block group lookup
 functions
Message-ID: <20191115162041.GA3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org, Damenly_Su@gmx.com
References: <20191111084226.475957-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111084226.475957-1-Damenly_Su@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 04:42:25PM +0800, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> The progs side function btrfs_lookup_first_block_group() calls
> find_first_extent_bit() to find block group which contains bytenr
> or after the bytenr. This behavior differs from kernel code, so
> add the comments.
> 
> Add the coments of btrfs_lookup_block_group() too, this one works
> like kernel side.
> 
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

1 and 2 added to devel, thanks.
