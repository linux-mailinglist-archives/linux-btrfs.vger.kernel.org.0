Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA88B60ED3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 03:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiJ0BJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 21:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJ0BJY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 21:09:24 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B10AFFFB8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 18:09:21 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id BC1475BB4F1; Wed, 26 Oct 2022 21:03:47 -0400 (EDT)
Date:   Wed, 26 Oct 2022 21:03:20 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: compsize reports that filesystem uses zlib compression, while I
 set zstd compression everywhere
Message-ID: <Y1nY2FJGYS+iWMcS@hungrycats.org>
References: <3c352b84-c52a-9e01-1ace-6e984e167753@inbox.ru>
 <eee8a8e1-8e54-4170-af44-a94c524c37ad@app.fastmail.com>
 <fa62c9cb-0fe9-b838-3f69-477dc61dbd45@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa62c9cb-0fe9-b838-3f69-477dc61dbd45@inbox.ru>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 27, 2022 at 01:29:35AM +0300, Nemcev Aleksey wrote:
> 26.10.2022 22:07, Chris Murphy пишет:
> > 
> > On Wed, Oct 26, 2022, at 6:21 AM, Nemcev Aleksey wrote:
> > > Hello.
> > > 
> > > Recently I decided to compress the existing Btrfs volume with zstd.
> > > 
> > > To do this, I set property `compression=zstd` for all subvolumes to
> > > compress new files with the default zstd:3 compression level.
> > > 
> > > Then I run `btrfs filesystem defragment -c zstd:12 -v -r` on all
> > > subvolumes to compress existing files using zstd:12 compression level
> > > (to spend more time now and save more space later, but don't want to
> > > keep slow zstd:12 level all the time).
> > > 
> > > After defragment, I run `btrfs filesystem balance` on all subvolumes to
> > > make Btrfs happy.
> > > 
> > > And after all, I run `compsize` on the root subvolume to check the
> > > compression ratio, and compsize shows me the following:
> > > Processed 1100578 files, 1393995 regular extents (1649430 refs), 666312
> > > inline.
> > > Type      Perc    Disk Usage  Uncompressed Referenced
> > > TOTAL      77%     169G        217G        226G
> > > none      100%      99G         99G        100G
> > > zlib       52%      54G        102G        109G
> > > zstd       19%      12M         65M         66M
> > > prealloc  100%      15G         15G         16G
> > > 
> > > I'm very confused why almost all compressed data is compressed with zlib
> > > while I haven't used zlib at any step.
> > > Why do compsize reports this?
> > > Should I worry about this? It seems zstd offers a much faster
> > > decompression speed than zlib.
> > > Thank you.
> > 
> > If you use chattr +c anywhere, it uses the btrfs default compression algo which is zlib. There is a way to set a compression algo property, but I'm uncertain if the kernel honors it.
> > 
> > So you'll want to recursively remove the compression file attribute. I'm not sure it's worth recompressing but you can use defrag -z for that.
> > 
> Thank you for the idea, I understood where I failed.
> 
> `btrfs filesystem defragment -c zstd -r /` is not correct command, but
> `btrfs filesystem defragment -czstd -r /` is correct one (note the space).
> 
> And the first command will try to defragment the file named zstd using
> default compression (zlib), not the compression from the `compression`
> subvolume property.
> 
> And also it's not possible to specify compression level in defragment - so,
> I'll change the level in subvolume properties, defragment with -czstd, and
> change the level back.

It's not possible to set the level in subvol properties either.  Only the
compress= mount option can set the level.
