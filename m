Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F64402067
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhIFTb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 15:31:57 -0400
Received: from mail136-4.atl41.mandrillapp.com ([198.2.136.4]:2514 "EHLO
        mail136-4.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235520AbhIFTb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 15:31:57 -0400
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Sep 2021 15:31:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexedi.com;
        s=mandrill; t=1630955699; i=jm@nexedi.com;
        bh=8bR1/6o729O5u5rzHsTFzldApz8A5FuWqFp6wUfFV1A=;
        h=From:Subject:To:Cc:References:Message-Id:In-Reply-To:Date:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=Oh3FRNtwAMeaxPpWHkm4Hmm7WFe0dNi9HTWWJ0MSuQQN28lvAb+4vH2JZX9ERQsuT
         fXGQjTb/btNZI7r9HktAvDWyQqPFv90r7x6DfInxzhiuxyhVj4ub5i1yeRrefpnYC7
         piC9JyvQXKcxO3LY36HXV2gpiYNv3Va2wCEVdt7w=
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
        by mail136-4.atl41.mandrillapp.com (Mailchimp) with ESMTP id 4H3J4g4R3wzS62HdN
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 19:14:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1630955699; h=From : 
 Subject : To : Cc : References : Message-Id : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=8bR1/6o729O5u5rzHsTFzldApz8A5FuWqFp6wUfFV1A=; 
 b=bf5k2M5gI2cpelxHhXdXkeGixLStRJkM7F5hdUx13E/a//eUsA9II57W09j+vjliXwIjuQ
 jpiH9ly/RZI0JGUfutFmIALxcw2/fft3krtufm2RKmHD1PsZdAjPm9x9COVW9A6TiEp7RSro
 KCjFvPeqTLc3OlRwUU3deAEGWfob4=
From:   Julien Muchembled <jm@nexedi.com>
Subject: Re: fallocate + ftruncate
Received: from [87.98.221.171] by mandrillapp.com id 7103dbdc5d854f7b95d0d6a61bf35287; Mon, 06 Sep 2021 19:14:59 +0000
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Vincent Pelletier <vincent@nexedi.com>
References: <ed3642c2-682e-08a1-f18d-2d63409b7631@nexedi.com> <0aa8496e-a666-8fda-8a50-78b4f7890b20@gmx.com>
Message-Id: <d744a192-35e0-a42a-86e4-8d69f983bc45@nexedi.com>
In-Reply-To: <0aa8496e-a666-8fda-8a50-78b4f7890b20@gmx.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.7103dbdc5d854f7b95d0d6a61bf35287
X-Mandrill-User: md_31050260
Feedback-ID: 31050260:31050260.20210906:md
Date:   Mon, 06 Sep 2021 19:14:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 03/09/2021 =C3=A0 01:41, Qu Wenruo a =C3=A9crit=C2=A0:
> On 2021/9/3 =E4=B8=8A=E5=8D=882:04, Julien Muchembled wrote:
>> I'd like to report what seems to be a Btrfs bug. XFS does not have this =
issue.
>>
>> On a machine (kernel 4.19.181) that has several RocksDB databases, some =
on XFS and other on Btrfs, we noticed that disk usage increases significant=
ly faster on Btrfs. RocksDB pattern for SST files is:
>>
>> 1. fallocate(A)
>> 2. write(B) with B < A
>> 3. fruncate(B)
>> 4. close
> 
> This is caused by btrfs extent bookend.
> 
> For 1. We allocate an extent whose size is round_up(A, sectorsize)
> 
> Then 2 happens, which writes round_up(B, sectorsize) to the existing
> preallocated extent.
> So far so good.
> 
> For 3, we just reduce the inode size, resizing the existing file extent
> just to point to part of the preallocated extent, and call it a day.
> 
> The preallocated extent whose size is round_up(A, sectorsize) will only
> be freed if the whole extent is no longer used by any inode.
> 
> Thus the truncate won't free any space.
> 
> This is quite different from XFS, as XFS is CoW-when-needed, while btrfs
> is CoW-by-default.
> 
> Thus btrfs frees its extent in a very lazy way.

When there hasn't been any preallocation, which is the most common case, I =
understand well that space can be wasted due to extents being still referen=
ced, and defrag can fix that (modulo snapshots...).

Is it really impossible to shrink an extent as long as the trimmed part doe=
s not contain any data ? Or at least as long as nothing's written to disk (=
with is the case for small files until ftruncate included).

Julien

