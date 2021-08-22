Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB223F3E0C
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 07:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhHVFqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 01:46:30 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41006 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhHVFqa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 01:46:30 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 63225B41574; Sun, 22 Aug 2021 01:45:49 -0400 (EDT)
Date:   Sun, 22 Aug 2021 01:45:49 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Forza <forza@tnonline.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Support for compressed inline extents
Message-ID: <20210822054549.GC29026@hungrycats.org>
References: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 22, 2021 at 01:25:48AM +0200, Forza wrote:
> I'd like to see the option to allow compressed extents to be inlined. It
> could greatly reduce disk usage and speed up small files by avoiding
> extra seeks.
>
> I tried to understand why we don't allow
> it but could only find this reference
> https://btrfs.wiki.kernel.org/index.php/On-disk_Format#EXTENT_DATA_.286c.29
>
> "the extent is inline, the remaining item bytes are the data bytes
> (n bytes in case no compression/encryption/other encoding is used)."
>
> Is the limitation in the disk format or perhaps in the compression
> heuristics?

A far better question is "when did we _stop_ compressing inlined extents",
and the answer is in v5.14-rc1: f2165627319f "btrfs: compression: don't
try to compress if we don't have enough pages".  This check affects
inlined extents, so they are never compressed after 5.14.  Oops.

> Not all use cases would benefit, and we'd have more metadata, which
> increase the risk of enospc. But i think it could be very valuable
> nonetheless. For example mail servers, source code/CI, webservers, and
> others that commonly deal with many small but highly compressible files.
>
>
> I did a quick test by copying all files smaller than 8192 bytes from
> my home server. The filesystem has 90GiB used.

An 8192 byte file cannot currently be inline (on a 4K page size system)
because the read code in btrfs assumes inline extents always fit inside
one page after decoding.

What you're really asking here is "can we have an arbitrary length
of compressed inline extent, as long as the encoded version fits in a
metadata block" and the short answer is "not with this on-disk format,"
because existing readers cannot cope with it.  If we are to consider this,
it requires an incompatible format change.

> The result was 357129 files, 207605 inline. 792MiB disk usage, 1.0GiB
> data size, or 1.1% of fs usage.
>
> Zstd compressed them, which gave 295419 files inline. Total data size
> 500MiB. The size of the inlined files is 208MiB.
>
> Uncompressed the inlined files to see how much of the original data
> could have been compressed and inlined. 599MiB total data with 501MiB
> disk usage and 207576 inlined files.
>
> All in all we would save 501-208=293MiB, which is very good. Ontop of
> this we'd have savings because we avoid padding up to 4kiB block size
> due to inlining. Also my test only included files less than 8kiB. It
> is possible that many files larger than this could be compressed to
> less than max_inline size.
>
>
> Thanks
