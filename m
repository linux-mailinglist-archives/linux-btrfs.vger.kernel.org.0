Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1066446BD46
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhLGOMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:12:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:56159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237530AbhLGOMy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 09:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638886159;
        bh=5KUM6eVepWH0XWi+vsSTVxqOP0WX1mPmFXZN0OyFL2w=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=SsoDpKQuSfhFJmnKK3sSvTos0smzCnRCMaoPfCCeaOMC6UJqRbYzA410Zdd4yh+D0
         nLfP7a6VQccVDaXe69YsZewwcCbai3llcVHqTqUB+S0e3ewi5wUPfUbuxN8u95H2+d
         +C6XeqZBhFkxRJIEK/dEQVi+KvPd8/SwkcvjM3p8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1mGIGr0aPL-00nSrQ; Tue, 07
 Dec 2021 15:09:19 +0100
Message-ID: <d2b335a8-f615-6506-8b17-f4a1f61ee7a1@gmx.com>
Date:   Tue, 7 Dec 2021 22:09:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Maximilian Eichhorn <maximilian.eichhorn@fau.de>,
        linux-btrfs@vger.kernel.org
References: <c2ecfb9c-5044-a370-2362-8f67b44ce53c@hogwarts.middle.earth>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Question for information about the Extend Tree structure
In-Reply-To: <c2ecfb9c-5044-a370-2362-8f67b44ce53c@hogwarts.middle.earth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+H/qct7FDXM+kQ8kAbG/YlUkLbMJYntjOPZGXOKQ0oDJJU2POc4
 lo7wBGf8LstNNAUMuT9M14eUuunnEFXtSGoVJh9HskvYWRDbWFjndXBsWt0AGQ+zq2V8P/x
 KEz0L1tzZs5w6fhAamqizF1jZdT5umQaX2cxqJhcyhAIWaiRSMnGBjxcE3S/hY5GdQ/DyZb
 UYphw35hUUqJuSwISynAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vN1aWW5GAKU=:vSjWW0KEOmUb8BhDzzdL8C
 pGIA77GhJy7PYRxsHfOVKoJoZrf0Awb0IHrwWlVL9E133wZ9Lh/nz/weQwdyw8Y3mx3jgwYAH
 Mnf+Sx+3vrVTCx2YlmbmtVnRexi/PT+mysAH1V8B5zPxE/gcKLq8TFIk8+4kNX1i2AFkpZwLs
 Pwf4o/yVGRzdz/N/0vtLPKKJaX970K56wUj517al17BO7ROx/4/yiQVQPRgbQVysE2YWFgxZ0
 qBpmhwmH3TcAaZOlQtJwROntUHaJrXxeg7yOqYNFfulQWY4T8f6v6srO3faxts77/eMXH7QUK
 L6txIRtDyh0PNYnfGuAHZ1JmCs63g4YYIQxUd3w9gZcsJaytJOAhAR2ux1bZdZ7rhf1QSkw2x
 B0Y5DMHkCo2zAriupqoq85CiZiat78tl8Hp7wtziHyUcEUxhK4S97HkEGipftD3mgxPoQIXJA
 mLx9/uxsshDQd8WDpX+oaIzhtAwkpaNWF4WYxVwYyADZNvzxW13IIuZ0x+iegg0/vvC8g399l
 z0GmyMcvoNmb/Nuh+Vm+X7whXNeC82VkIYD4C7RUoFTX0E0mTKvfoMhDhFXqwD7u/0nT0Fx/K
 DTruBE69pV2LiyhSTfV+NIQPQrLhC4nsN1mAkaGvugjHg5Xaf+itkC5FMWVTF6T33PI4YQY//
 fC94gc2vq7Pkm9cVZ81mW8NwbuOJv8Q57fAHKxN3uPBWdeesAlkVijItJW9cZ+J+ejyNMYJ2R
 kIFgdQNpCyCgcueVyHcsfcqujIFZ1u65hJ2iHsoM346gYUkwWA+1yJ4OKdBW/t9Llq3e5GpsQ
 yR6Iz5u6HqZscpq5S6g7JAGXslNZX72I3Dk8h569/xNVXHWaikPTrsJOn0SKBmFRGKdiJJ7vW
 z/xy2426XntHqzY02pbIkIlEVz0nmBff2izoFXEA5PuDdg5MzNa96Y5LuHUB3HBWQGek30+iq
 o4ZSJapjFieWla9s9pmBVrP/1A6U3ru4TK0NO3k2GhCWdHXq1NQn0E8w9ZHghm3xX9Ew6kIb6
 bXzD1zPfzu2GwMjpWIljQlibh81ic1M7Uy79boMe+siqYDZCl1dYzD7nDhd0Mq0xipnv3kbX+
 SklBnizNLhnEkI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 21:53, Maximilian Eichhorn wrote:
> Dear Sir or Madam,
>
> as part of a research project, I am working on the file system Btrfs and
> its structures.
> More specifically, I am learning about the extend tree and marking
> individual areas as allocated.
>
> In the course of this I also became aware of the wiki [1] and examined
> the information to be found there.

I guess you mean this?

https://btrfs.wiki.kernel.org/index.php/On-disk_Format

> However, not all aspects of the
> Extend Tree are clear to me yet. Therefore I turn to you with the
> question and request for further information.
>
> In other file systems it is very easy to identify a certain block/sector
> as allocated or to manually mark it as allocated because of the existing
> structures. Unfortunately, I have not been able to do this with Btrfs so
> far.

First thing first, other fses are mostly using bitmap to indicate which
blocks are allocated, that's why they are easy.

But that lacks a feature btrfs needs, to do backref lookup.

That's to say, when we know a block is allocated, we also want to know
which tree or inode owns it.

That's why btrfs extent tree is that complex.


But if your idea is just to get which blocks are in use, it's much easier.

(<logical> EXTENT_ITEM <size>) is for all DATA and some old metadata
backref. That indicates one range of bytes allocated.

All data extent should have one such key. For non-skinny metadata fs
(without skinny-metadata flag), all metadata should also have one such key=
.

(<logical> METADATA_ITEM <level>) is for METADATA backref.
With skinny metadata, all metadata should have either METADATA_ITEM or
EXTENT_ITEM. (For newer fs, there should be no EXTENT_ITEM for metadata,
the co-exist behavior is just for backward compatibility)

For METADATA_ITEM key, although we don't have the size in the key, since
btrfs uses fixed metadata size for the whole fs, the size is fixed to
nodesize from btrfs_superblock.


So just focusing on EXTENT_ITEM and METADATA_ITEM, you can get the
allocation info from extent tree.


Talking about the marking part, it's pretty hard, as although you can
mark one range allocated, you also need to insert the proper backref for
it. But since you're not really allocating the space, the backref will
not be valid and will trigger fsck error.

For a proper EXTENT_ITEM/METADATA insert, I guess you have to jump into
the rabbit hole of btrfs code, btrfs-progs will be a good start point.

Thanks,
Qu
>
> Thanks in advance for your help and efforts!
>
> Kind regards,
> Maximilian Eichhorn
>
