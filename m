Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BEB25A900
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgIBJ5w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 05:57:52 -0400
Received: from mailrelay3-3.pub.mailoutpod1-cph3.one.com ([46.30.212.12]:10543
        "EHLO mailrelay3-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgIBJ5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 05:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:references:
         in-reply-to:message-id:cc:to:from:date:from;
        bh=2ekd+92+ARnOudVrvF0afe26A1cKXuYq7OOcZEN/CEM=;
        b=QivfN6Nn851ighN4te57nT0zF1RthHzUc0Zy9xQwK/uponbQzyveM7c5Sdg+Atyg8Jj1EJDTyzk1k
         icM1jzwJNnF3yZ5BOCffKKmKh9lPdLuzAKeeUHHuwl0VxhBrqwe1cEUBdiIZF+DAOAwXpDMXNh+CYn
         BPASY9WZL0d+MybDVupD4RINjACn6LB7suOCakiMjfSGOW3tqZy40B/b+avr8XLw4VLGCP94Nozkrh
         f+31njK4uAKcBK8en80Fki2eMuAQKUIuJUSPr/4IU1QRNPQBiTFlhVk8garAFUO95d1nzlunbMdZai
         xiSss2xm1TXzzGNtqlqs9ABNNv8qG0w==
X-HalOne-Cookie: 7d2fd4ac4af2abd224999d89e9c3bd5539333645
X-HalOne-ID: c02f33ee-ed02-11ea-86ee-d0431ea8bb03
Received: from [172.16.0.2] (unknown [8.40.140.108])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c02f33ee-ed02-11ea-86ee-d0431ea8bb03;
        Wed, 02 Sep 2020 09:57:47 +0000 (UTC)
Date:   Wed, 2 Sep 2020 11:57:41 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Nikolay Borisov <nborisov@suse.com>,
        Hamish Moffatt <hamish-btrfs@moffatt.email>,
        linux-btrfs@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <dede53e.d98f7053.1744e402728@lechevalier.se>
In-Reply-To: <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email> <20200831034731.GX5890@hungrycats.org> <baadab71-61a7-704e-86f7-3607895df663@moffatt.email> <20200831161505.369be693@natsu> <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email> <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com> <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email> <0bf29a8c-23b2-26f4-2efd-2e82f38c437d@suse.com> <4c3d4141-4452-bb79-b18e-f32c8e35cb13@moffatt.email> <d0399ea6-f198-b58f-8b34-f8ba95ef400f@moffatt.email> <03ec55ee-5cf3-54fa-1a81-abc93006ca7b@suse.com>
Subject: Re: new database files not compressed
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Nikolay Borisov <nborisov@suse.com> -- Sent: 2020-09-02 - 07:57 =
----
>>=20
>> I've been able to reproduce this with a trivial test program which
>> mimics the I/O behaviour of Firebird.
>>=20
>> It is calling fallocate() to set up a bunch of blocks and then writing
>> them with pwrite(). It seems to be the fallocate() step which is
>> preventing compression.
>>=20
>> Here is my trivial test program which just writes zeroes to a file. The
>> output file does not get compressed by btrfs.
>=20
> Ag yes, this makes sense, because fallocate creates PREALLOC extents
> which are NOCOW (since they are essentially empty so it makes no sense
> to CoW them) hence they go through a different path which doesn't
> perform compression.
>=20

Hi,=20

This is interesting. I think that a lot of applications use fallocate in th=
eir normal operations. This is probably why we see weird compsize results e=
very now and then.=20

A file that is nocow will also not have checksums. Is this true for these f=
allocated files (that has data written to them) too?=20

I would really like to see that Btrfs was corrected  so that writes to an f=
allocated area will be compressed (if one is using compression that is).=20

Thanks.=20

