Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145061CC4BB
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 23:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEIVc1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 17:32:27 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:50638 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgEIVc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 17:32:27 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 454149C421; Sat,  9 May 2020 22:32:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589059945;
        bh=1qFZHyY6o6ei9ALlCgXmp8jgj2wb+kF3/1MsJRFwIBk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=BqEa2ABM+8UIbF2xrwR8LtfMLHds8+kR32E3fe9gWhNm1dLlYAM/m3n/aEtu0emi7
         gOhWAyC8AfyJQ1Jv9rDSquxoPpqIi8i6VkGUQRCN4G8N1ywSQYrFtZvonTfN9+3iaN
         7gBTQzkBi8E/j/btjfRIPFCz8I/4WlYm5KpJJiF2n3FtLRhkWl42Xb6C4ci4I2GsFs
         Semsx7z+7G8zxSbHz34mxcnUwvyD/hkUgMXNllG4rGFi/jZjo3GSq8PgGdnIo1VKGM
         v4PwgGAp7/vjJYhMPWg+P2JZ+weHvR3NlK5/LsXye6mfRaTMw4HyFgGRrcBNrbFqTY
         fJRveNPSmdFfw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id F13D39C34F;
        Sat,  9 May 2020 22:32:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589059939;
        bh=1qFZHyY6o6ei9ALlCgXmp8jgj2wb+kF3/1MsJRFwIBk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=RQyG2CbbjuNC5zlkBjvKC73e3BtfOejlslj1sNypFaYVCdWx4SwOi8k3+awdY927s
         I1sSFtyPQKHftOOy3Uf1lEPpMitPGWFMvCJId/o+izpX62Ymj4XUfFFQRzw1pTSA7M
         QDMTghsniEZ0aCaJCyI0tSVKPJ/zgFtwiOXl7SUDYqWBSvWPCn/dO9PrJobMJdgFmW
         hcC6SFY0loU7y/i2ubtGSC4q7zoKZlEPm84Hm+nzKDBmfhJiWg4yhm5wImwpOWnENy
         22eSneZ6YTrWhzk69/pFQmgoSs4LNF42yeHnGpNrd7sPhexGkMkXN5VsPchjyaH4E7
         YtPQ8uOXRrdxQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 8921B101BFA;
        Sat,  9 May 2020 22:32:18 +0100 (BST)
Subject: Re: Exploring referenced extents
To:     Steven Davies <btrfs-list@steev.me.uk>, linux-btrfs@vger.kernel.org
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <d89caa53-a3b6-5c4e-a577-a89490064a40@cobb.uk.net>
Date:   Sat, 9 May 2020 22:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/05/2020 12:11, Steven Davies wrote:
> For curiosity I'm trying to write a tool which will show me the size of
> data extents belonging to which files in a snapshot are exclusive to
> that snapshot as a way to show how much space would be freed if the
> snapshot were to be deleted, and which files in the snapshot are taking
> up the most space.

I have some scripts to do that. They are slow but seem to pretty much
work. See https://github.com/GrahamCobb/extents-lists

> I'm working with Hans van Kranenburg's python-btrfs python library but
> my knowledge of the filesystem structures isn't good enough to allow me
> to figure out which bits of data I need to be able to achieve this. I'd
> be grateful if anyone could help me along with this.

Rewriting them to use Hans' library is one of the things I plan to do
one day!

> So far my idea is:
> 
> for each OS file in a subvolume:
>   find its data extents
>   for each extent:
>     find what files reference it #1
>     for each referencing file:
>       determine which subvolumes it lives in #2
>     if all references are within this subvolume:
>       record the OS file path and extents it references
> 
> for each recorded file path
>   find its data extents
>   output its path and the total number of bytes in all recorded extents
> (those which are not shared)

My approach is different. I don't attempt to understand which files
share extents, or which subvolumes they are in. Instead, I just try to
analyse which extents are in use by a subvolume (or, actually, any set
of files you specify).

This is easy (but slow) to do. And makes answering some questions easy.
However, it makes answering questions like "how many extents would
really be freed if I deleted this subvolume" hard (the scripts end up
working out the complete list of extents in use on the filesystem, and,
separately,  the list of which would be in use if the subvolume was
removed - the difference is the space freed up by deleting the subvolume).

This often takes a day or two.

I would be interested if you find a more efficient approach to working
out how much space will be freed up if a set of files (such as
particular subvolumes) are removed, allowing for snapshots, reflink
copies and dedup.

Graham

