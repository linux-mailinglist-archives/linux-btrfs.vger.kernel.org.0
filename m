Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA431968F2
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Mar 2020 20:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgC1TfV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 28 Mar 2020 15:35:21 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41882 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgC1TfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Mar 2020 15:35:21 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 681AD63CF48; Sat, 28 Mar 2020 15:35:20 -0400 (EDT)
Date:   Sat, 28 Mar 2020 15:35:20 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Q: what exactly does SSD mode still do?
Message-ID: <20200328193520.GZ13306@hungrycats.org>
References: <8dcb2f1b-7cb4-cfd4-04ba-7fe4f3c3940b@applied-asynchrony.com>
 <6f49d2cc-c0e4-6d1d-f10d-834089698528@knorrie.org>
 <116cfdc1-410a-5e09-2fb2-5da2c0fa428a@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <116cfdc1-410a-5e09-2fb2-5da2c0fa428a@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 27, 2020 at 11:29:52AM +0100, Holger Hoffstätte wrote:
> On 3/26/20 11:21 PM, Hans van Kranenburg wrote:
> > 2) Metadata "cluster allocator" write behavior:
> > 
> > *empty_cluster = SZ_64K  # nossd
> > *empty_cluster = SZ_2M  # ssd
> > 
> > This happens in extent-tree.c.
> 
> 2M used to be a common erase block size on SSDs. Or maybe it's just
> a nice round number..  ¯\(ツ)/¯

As a side-effect, 2M write clusters close the write hole on raid5/6 if you
have an array that is a power of 2 data disks wide.  This capability is
wasted when it's only available through the 'ssd' mount option.

The behavior could be quite useful if it was properly integrated with
the raid5/6 stuff:  set *empty_cluster = block group data width, make
sure it's aligned to raid5/6 stripe boundaries, and use it for both data
and metadata.

It works by effectively making partially-filled clusters read-only.
If we can guarantee that clusters are aligned to raid5/6 data/parity block
boundaries, then btrfs can't allocate new data in partially filled raid5/6
stripes, so it won't break the parity relation and won't have write hole.

> cheers,
> Holger
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08635bae0b4ceb08fe4c156a11c83baec397d36d
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba8a9d07954397f0645cf62bcc1ef536e8e7ba24
> 
