Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E534225C9A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICTo7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 3 Sep 2020 15:44:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44594 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICTo6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 15:44:58 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D094C7E64BC; Thu,  3 Sep 2020 15:44:54 -0400 (EDT)
Date:   Thu, 3 Sep 2020 15:44:49 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hamish Moffatt <hamish-btrfs@moffatt.email>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: new database files not compressed
Message-ID: <20200903194437.GA21815@hungrycats.org>
References: <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
 <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
 <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com>
 <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email>
 <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email>
 <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
 <dede53e.d98f7053.1744e402728@lechevalier.se>
 <20200902161621.GA5890@hungrycats.org>
 <f32f6fdf-bc20-b1d1-d0ea-08f779723066@moffatt.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f32f6fdf-bc20-b1d1-d0ea-08f779723066@moffatt.email>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 10:53:23PM +1000, Hamish Moffatt wrote:
> On 3/9/20 2:16 am, Zygo Blaxell wrote:
> > 
> > fallocate doesn't make a lot of sense on btrfs, except in the special
> > case of nodatacow files without snapshots.  fallocate breaks compression,
> > and snapshots/reflinks break fallocate.
> 
> 
> I recompiled Firebird with fallocate disabled (it has a fallback for
> non-linux OSs), and now I have compressed database files.
> 
> It may be that de-duplication suits my application better anyway. Will
> compsize tell me how much space is being saved by de-duplication, or is
> there another way to find out?

Compsize reports "Uncompressed" and "Referenced" columns.  "Uncompressed"
is the physical size of the uncompressed data (i.e. how many bytes
you would need to hold all of the extents on disk without compression
but with dedupe).  "Referenced" is the logical size of the data, after
counting each reference (i.e. how many bytes you would need to hold all
of the data without compression or dedupe).

The "none" and "zstd" rows will tell you how much dedupe you're getting
on uncompressed and compressed extents separately.

> 
> Hamish
> 
