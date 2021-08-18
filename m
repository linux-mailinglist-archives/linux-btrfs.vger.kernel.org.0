Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC33F09D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhHRRDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 13:03:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43174 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhHRRC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 13:02:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 690D021FDB;
        Wed, 18 Aug 2021 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629306143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzsXE/r6slCGihYuMb+ShiK0lSo6DP7ypPku37llAA0=;
        b=Gvn6Kj7tFgJqgvnUgjc+RRDaCHm/8kLKozm1sk/LAHDcR9kecUVNeyxak6St6CzE+kNHck
        Trh7nRFEloVHlYV4kDJdW1F6gDtzpAzT0CghK0dXNrQT7jTETUDxZY/rbI84tpdl8NeW8T
        yaYamQr5sl+LmJo6KD3zaVRsrGUpXB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629306143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzsXE/r6slCGihYuMb+ShiK0lSo6DP7ypPku37llAA0=;
        b=3ycOZr3IFrBBpM+ZHRLH8RX+50nyqx5wC26rHpN0nNGw1nr9XZAdsvJJl4O2stc23ywjeg
        zQFk6TypRd4ZNGCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5ED1DA3B98;
        Wed, 18 Aug 2021 17:02:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 576DFDA72C; Wed, 18 Aug 2021 18:59:26 +0200 (CEST)
Date:   Wed, 18 Aug 2021 18:59:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210818165924.GV5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz>
 <20210818003819.GA2365@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818003819.GA2365@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 12:38:19AM +0000, Sidong Yang wrote:
> On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
> > On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
> > > This patch adds an subcommand in inspect-internal. It dumps file extents of
> > > the file that user provided. It helps to show the internal information
> > > about file extents comprise the file.
> > 
> > Do you have an example of the output? That's the most interesting part.
> > Thanks.
> 
> Thanks for reply.
> This is an example of the output below.
> 
> # ./btrfs inspect-internal dump-file-extent /mnt/test1
> type = regular, start = 2097152, len = 3227648, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> type = regular, start = 5324800, len = 16728064, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> type = regular, start = 22052864, len = 8486912, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> type = regular, start = 30572544, len = 36540416, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> type = regular, start = 67112960, len = 5299630080, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none

This resembles a debugging output, something like we have for
tracepoints but I think this should be more human readable, with
possiblity of parsing by scripts/tools.

So to not just duplicate what filefrag or xfs_io -c fiemap do, we can
optionally enhance the information with the specifics of btrfs, like on
which devices the extents are, which compression is there etc. But the
basic output should be more or less like filefrag.
