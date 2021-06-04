Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D169839B8FD
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFDM2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 08:28:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFDM2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 08:28:11 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 211A221A28;
        Fri,  4 Jun 2021 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622809584;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68aSFdxQrCcgu3e4kaM9HdB6LJTQPLk85xJqiAjeVBA=;
        b=MWGFWkeSccJO1/1UxpgHKkC/7uOz+MnNxZOE+SbnMuWTCNDmNPZqtNrUA4txUZTg2fUSzP
        hvIUQy9kD60XHGmQKHq+1hbcJIvZrDC0jWkQMmc1bHIh9qdbrDS/ciTjDuS/JENnDIgD+o
        IaYnJPn8m2DOkUvrVOER77e8hw9VYy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622809584;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68aSFdxQrCcgu3e4kaM9HdB6LJTQPLk85xJqiAjeVBA=;
        b=mMXZlvJTmrtOPACH4cc3gBjd1fUchWiCNxLHhu67egXaTrOBVVsVOCc/9U5XEvPknbjPvg
        p3ilbM6K/xzufXAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EBE66A3B81;
        Fri,  4 Jun 2021 12:26:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85E78DB225; Fri,  4 Jun 2021 14:23:42 +0200 (CEST)
Date:   Fri, 4 Jun 2021 14:23:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] btrfs: Remove total_data_size variable in
 btrfs_batch_insert_items()
Message-ID: <20210604122342.GB31483@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210603174311.1008645-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603174311.1008645-1-nathan@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 03, 2021 at 10:43:11AM -0700, Nathan Chancellor wrote:
> clang warns:
> 
> fs/btrfs/delayed-inode.c:684:6: warning: variable 'total_data_size' set
> but not used [-Wunused-but-set-variable]
>         int total_data_size = 0, total_size = 0;
>             ^
> 1 warning generated.
> 
> This variable's value has been unused since commit fc0d82e103c7 ("btrfs:
> sink total_data parameter in setup_items_for_insert"). Eliminate it.
> 
> Fixes: fc0d82e103c7 ("btrfs: sink total_data parameter in setup_items_for_insert")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1391
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Added to misc-next, thanks. I've removed the Fixes: tag, we've been
using this is for patches that should be backported or otherwise point
to a patch that causes a real bug.
