Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB803816A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 09:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhEOHtW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 May 2021 03:49:22 -0400
Received: from rin.romanrm.net ([51.158.148.128]:53610 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhEOHtV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 May 2021 03:49:21 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 7AD0069F;
        Sat, 15 May 2021 07:48:04 +0000 (UTC)
Date:   Sat, 15 May 2021 12:48:03 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Christian =?UTF-8?B?VsO2bGtlcg==?= <cvoelker@knebb.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Removal of Device and Free Space
Message-ID: <20210515124803.41f88f70@natsu>
In-Reply-To: <20210515013903.GE32440@hungrycats.org>
References: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
        <20210515013903.GE32440@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 14 May 2021 21:39:04 -0400
Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:

> >     What is occupying so much disk space as the data only has 1.7TB which
> > should fit in 1.8TB (two) devices? (no snapshot, nothing special configured
> > on btrfs). Looks like there are ~400GB allocated which are not from data.
> 
> Chunks are deallocated only when completely empty.  If you recently
> deleted a large number of files, then you'll have chunks with low data
> density and high free space fragmentation.  Normally this does not matter,
> as the free spaces in chunks would be filled in by new data allocations,
> and those allocations would split writes into smaller extents that exactly
> fit the free spaces.  Relocation can't do this--it can only occupy free
> spaces that are equal or larger, and will make free space fragmentation
> even worse.

Oh yeah, if you were just talking about discrepancy between "allocated" vs
"used", then it is what Zygo said, and my other reply regrading extent booking
doesn't apply here. That other issue is relevant only if you observe a
difference between "du [all files]" and "df [filesystem]".

-- 
With respect,
Roman
