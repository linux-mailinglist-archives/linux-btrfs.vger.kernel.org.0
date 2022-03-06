Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4644CEE92
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 00:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiCFXmC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 6 Mar 2022 18:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiCFXmA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 18:42:00 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 367813969B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 15:41:08 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id BCAE2238D54; Sun,  6 Mar 2022 18:41:07 -0500 (EST)
Date:   Sun, 6 Mar 2022 18:41:07 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Is this error fixable or do I need to rebuild the drive?
Message-ID: <YiVGk6xZqz1n5H2e@hungrycats.org>
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
 <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
 <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
 <YiQzL1evWiPvz59Y@hungrycats.org>
 <c66abc04-9ab1-121c-01fe-69b8eaafb297@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <c66abc04-9ab1-121c-01fe-69b8eaafb297@georgianit.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 06:45:16AM -0500, Remi Gauvin wrote:
> On 2022-03-05 11:06 p.m., Zygo Blaxell wrote:
> 
> > Ideally, 'btrfs replace' would be able to replace a device with itself,
> > i.e. remove the restriction that the replacing device and the replaced
> > device can't be the same device.  This is one of the more important
> > management features that mdadm has which btrfs is still missing.
> > 
> > This form of replace should read from other disks if possible (like -r),
> > otherwise don't write anything on the replaced disk since we'd just be
> > reading the data that is already there and rewriting it in the same block.
> > 
> 
> Ideally, this command would first read and compare the mirrored data.
> That way, only stale data would be replaced.  That way, it can be used
> with solid-state media without consuming a write cycle unnecessarily.

Good point, but it would require interleaved read and write cycles which
would be bad for spinning disks if there large areas with differences.

Maybe this can be solved by having a "SSD mode" and "HDD mode" which
would minimize writes or write everything blindly, respectively.
