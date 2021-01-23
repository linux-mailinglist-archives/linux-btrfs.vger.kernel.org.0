Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F03301490
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 11:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbhAWKkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 05:40:16 -0500
Received: from rin.romanrm.net ([51.158.148.128]:35012 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbhAWKkP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 05:40:15 -0500
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id C6C7D893;
        Sat, 23 Jan 2021 10:39:33 +0000 (UTC)
Date:   Sat, 23 Jan 2021 15:39:33 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210123153933.534a43ea@natsu>
In-Reply-To: <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
References: <20210121222051.GB4626@dread.disaster.area>
        <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 23 Jan 2021 16:42:33 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> For the worst case, btrfs can allocate a 128 MiB file extent, and have
> good luck to write 127MiB into the extent. It will take 127MiB + 128MiB
> space, until the last 1MiB of the original extent get freed, the full
> 128MiB can be freed.

Does it mean enabling compression actually mitigates this issue as a
side-effect? Since each extent will be limited to only 128K.

What are the typical extent sizes without compression?

-- 
With respect,
Roman
