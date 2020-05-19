Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6921D9979
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgESO04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 10:26:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgESO04 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 10:26:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACA75ABCB;
        Tue, 19 May 2020 14:26:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E008FDA7AD; Tue, 19 May 2020 16:26:00 +0200 (CEST)
Date:   Tue, 19 May 2020 16:26:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Bug 5.7-rc: write-time leaf corruption detected (fixed)
Message-ID: <20200519142600.GE18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <29b671353fff0d745e2e99d420585c1f25fab107dd63b8e1a812c384875575b8.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b671353fff0d745e2e99d420585c1f25fab107dd63b8e1a812c384875575b8.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 12, 2020 at 04:15:38PM +0200, David Sterba wrote:
> generic/457		[05:40:52][17606.984360] run fstests generic/457 at 2020-05-04 05:40:52

> [17608.092098] BTRFS critical (device dm-0): corrupt leaf: root=18446744073709551610 block=30949376 slot=104, csum end range (13807616) goes beyond the start range (13717504) of the next csum item
> [17608.098129] BTRFS info (device dm-0): leaf 30949376 gen 6 total ptrs 121 free space 6325 owner 18446744073709551610
> [17608.102727] BTRFS info (device dm-0): refs 2 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 27162

> [17608.645834] BTRFS error (device dm-0): block=30949376 write time tree block corruption detected

> [17608.650272] WARNING: CPU: 2 PID: 27162 at fs/btrfs/disk-io.c:537 btree_csum_one_bio+0x297/0x2a0 [btrfs]

Fixed in misc-next by Filipe's patch "btrfs: fix corrupt log due to
concurrent fsync of inodes with shared extents".
