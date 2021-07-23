Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641103D3EA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGWQrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 12:47:00 -0400
Received: from rin.romanrm.net ([51.158.148.128]:40722 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231171AbhGWQq7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 12:46:59 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id DF96C15F;
        Fri, 23 Jul 2021 17:27:30 +0000 (UTC)
Date:   Fri, 23 Jul 2021 22:27:30 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <20210723222730.1d23f9b4@natsu>
In-Reply-To: <20210723140843.GE19710@twin.jikos.cz>
References: <20210722192955.18709-1-dsterba@suse.com>
        <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
        <20210723140843.GE19710@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 23 Jul 2021 16:08:43 +0200
David Sterba <dsterba@suse.cz> wrote:

> > Can we slightly enhance the output?
> > RAID0/1 really looks like a new profile now, even the "1" really means
> > the number of device.
> 
> Do you have a concrete suggestion? This format was inspired by a
> discussion and suggested by users so I guess this is what people expect
> and I find it clear. It's also documented in manual page so if you think
> it's not clear or missing some important information, please let me
> know.

It really reads like another RAID level, easily confused with RAID10.

Or that it would flip between RAID0 and RAID1 depending on something.

Maybe something like RAID0d1?

-- 
With respect,
Roman
