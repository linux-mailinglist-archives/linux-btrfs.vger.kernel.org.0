Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B1421A34
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 00:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhJDWli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 18:41:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:50449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234828AbhJDWli (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Oct 2021 18:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633387186;
        bh=0Ma5gDzre6O/sbSTTWF0ZkB4YiC0nnWkzVLO2QjwkIo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=G0lwblb2LpowOGVbgqJiPQOKVgeufR1ITDrNdfLacYXOBdCUpyL1rETZPzGjBiHvr
         7HSxX83ntD1P4xTG9ugLIWlBAcPPFpUXey+U0bHuayE2ukloT1Ltyh1GAEu2i71x8o
         NA+TMkZ9VpbZODK6ZXIC6jxb14oHVMyPNNl8pKwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzk3-1mHytk2BI1-00XNdc; Tue, 05
 Oct 2021 00:39:46 +0200
Message-ID: <2d70ae4e-2851-a8d4-9789-987c3a5df0dc@gmx.com>
Date:   Tue, 5 Oct 2021 06:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 05/26] btrfs: make add_ra_bio_pages() to be subpage
 compatible
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-6-wqu@suse.com> <20211004174529.GB9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211004174529.GB9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VpioSSJ2ZUOzeATlpWKyc4MIvoTyPX5lMyoKdORz2+oFt64kMHr
 TiDyt/blyDPZwORB7gjdXx8RGhNoizztI7Cmr0BLolox4Gr7++hAIfXeGNrm3ec3edNnf8E
 lIc6rqgMTM/tb4c0GVpdUHGCOq8m/K0NkSnhpmwNmHmkTzV4BmcBmC+f69cD5yd8bc6GFVj
 MTLUv/xnnyTTeTvbPvRzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8TEhVALHC/4=:RYMKxrmbqyP2Ftf4FPxLTf
 DGsMltioC/yIFyasUkvRitGMu+iFtJxzEPJ+IP2KfVTolTfzqQ0HQ9R6eeeTHUqmfjoH/yPlt
 bRTQZSZFl6l+68qU2XS57OX8zRJKgQWWItIA7+lx4IWRNSVJVqdo7U054CCNLWGlqbwZDoxGv
 VtAxuBx6I0ZX/9JbB295EP0wsrk92q20MMPdEQRI6jKdPLZzlnHXoLAVpdJZdCBCLv8b2894s
 X4FALMdsaiIZ4jnLiqJNwjaimAHidnSjwElinPStnlqEb9jkMS+d3gxQauzpCRuYAF8q7rIVU
 D+mdNqKCozyGjXjFlB8VbKn5J+cWCeGRuUq7iAOkeL2K6VJrRUmSgwFerLN44II+3GqUS0HbM
 Fa1YD5tdqeCfxx45ujvFrM7hRGnci32zrVW9UqG15Fuxhyg23V21zlCRnYGcK7PdcjGVaOhgJ
 oQTN/22/OnnxGJmolKZrG82i/4iL7pSpvvYet8prQlbuRKXNapg5tAPd5p1hzD29oy5CnmSK8
 DBCOUakrxK7R62Uq/kb7aZMUMu/Tunp6mbOdcxfczL/u8dcA03WzRq1ayhnUMg0i5uvrDt3Lz
 3nc4p3Gh5xd75/8mKDfhBlhU+mn1PVvSVOBwcyxVeEqFNyKMxT0cIJUq/71dWcjAN+JK6V+4S
 Jeejul/joRSGLL+m899GwIHnUbNEe25P/pkB7syHtR4jb/DqqPz/FGQTTrflpc+NfN1nhaxRg
 orXvx/KJu38Qa4RFdlu6TlqR0N7eCytOYBmQIzdfWowrxsYHHA5OjHCyzWppvnHETuVSIg4R0
 Ej/ZBOdCka0eIXHrobBiE+/G9OXdIYG8+XJyJ2HUft0P2fTHGXyECW8VNOgV1sDUKpDzCFM0Y
 U3nnv/xxfHjcHsMQ6rWrYIH036vq7cR1RGi63rQY7kR2J721zY7Eh5A5Q4Stj3YgkzbNkVwFQ
 6DbsxUhFBE2zIFJFbXtTjmBwj4cwRfJIvfGqHFVriP5Tk1T7eq9bQDRiKpkZoVl1lx0Q1fRsa
 DIM9goWI6pmGICdkXBSqJ2mQb7/Yy26LEJSAJ6UZfw5qq+5MPagCdTVKGw6bvUQWQkhvg6sAb
 AbIEfuhvA5JvEE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/5 01:45, David Sterba wrote:
> On Mon, Sep 27, 2021 at 03:21:47PM +0800, Qu Wenruo wrote:
>>   fs/btrfs/compression.c | 89 +++++++++++++++++++++++++++--------------=
-
>>   fs/btrfs/extent_io.c   |  1 +
>
>    CC [M]  fs/btrfs/tests/extent-map-tests.o
> fs/btrfs/compression.c: In function =E2=80=98add_ra_bio_pages=E2=80=99:
> fs/btrfs/compression.c:680:25: error: implicit declaration of function =
=E2=80=98btrfs_subpage_start_reader=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>    680 |                         btrfs_subpage_start_reader(fs_info, pag=
e, cur, add_size);
>        |
>
> Fails when compiled with that patch on top.
>
> Missing #include "subpage.h"
>
Oh, I added that in later patches, without doing a per-patch compiling
tests...

Sorry for that.

Thanks,
Qu
