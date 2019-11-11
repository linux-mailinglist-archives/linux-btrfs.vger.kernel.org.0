Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354ECF7B06
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfKKSb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 13:31:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:45288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbfKKSbz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 13:31:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14E12B2E3;
        Mon, 11 Nov 2019 18:31:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48398DA7AF; Mon, 11 Nov 2019 19:31:58 +0100 (CET)
Date:   Mon, 11 Nov 2019 19:31:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 1/2] btrfs: tree-checker: Fix error format string
Message-ID: <20191111183158.GT3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191108213853.16635-1-afaerber@suse.de>
 <20191108213853.16635-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108213853.16635-2-afaerber@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 08, 2019 at 10:38:52PM +0100, Andreas Färber wrote:
> From: Andreas Färber <afaerber@suse.com>
> 
> Argument BTRFS_FILE_EXTENT_INLINE_DATA_START is defined as offsetof(),
> which returns type size_t, so we need %zu instead of %lu.
> 
> This fixes a build warning on 32-bit arm:
> 
>   ../fs/btrfs/tree-checker.c: In function 'check_extent_data_item':
>   ../fs/btrfs/tree-checker.c:230:43: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
>     230 |     "invalid item size, have %u expect [%lu, %u)",
>         |                                         ~~^
>         |                                           |
>         |                                           long unsigned int
>         |                                         %u

Is there a gcc warning option that can catch that on 64bit too?
-Wformat=2 does not and I don't see any other of the option family to do
that. We've had fixups of the size_t printk formats and I'd like to
catch that when the patches are added to the devel branches. I can't run
32bit build check each time but this seems to be the only way so far.

> Fixes: a31ccb4b7ba2 ("btrfs: tree-checker: Check item size before reading file extent type")

As the patch is still in the devel branch, the commit id is not stable
and I'll fold the change to to the patch. Thanks.
