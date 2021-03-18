Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CF133FC43
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 01:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCRAdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 20:33:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:41289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhCRAdB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 20:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616027556;
        bh=7BOnls/q5YoPCACZel63r/xbtNyIIi7mobj32uwgYB4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IjU26H3qU99qSyaSDnN7Wx18x+f7CAZvd9zBfTXRBX3Fv8U9LwreMubBIbOytmRlf
         B3husx8oaZflsN4st0cGrHJ5uiUcKZBVld+P4vVIPdGBb1QU+zlq0q5Mg+eqEVQI4g
         s+4F7YGszaMLsxbW43+rKwXcschBV2p3+6m4xbBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDywo-1lWcCt2sp2-009uIb; Thu, 18
 Mar 2021 01:32:36 +0100
Subject: Re: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
To:     Neal Gompa <ngompa@fedoraproject.org>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20210317200144.1067314-1-ngompa@fedoraproject.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <012ab078-c026-6894-80e0-ba5bbe697dc6@gmx.com>
Date:   Thu, 18 Mar 2021 08:32:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317200144.1067314-1-ngompa@fedoraproject.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zGlSpvo5w4/Tk1I48x0Y9Yw39bYslP/9GxDhYfog0QHXAH6yTOt
 c6D4w18P+7YG4IqoaKP5aIelPLAa2Qn1xHUg47oF5L9tZueCOBgS5nEm6evfVqRxLaGLxox
 /++01F2QU0ahFURm1mqg23jvvdNLNssWMk9zwL3LD1dQFjICtoYekUKJJzsqsfu5PvTnp2W
 1OdaN7IBqmwKXu6NFKmVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XAAiSjBHITk=:qE4MYwAEyVaYfMYI2jrCJ/
 N0ukGNUhd/Nbn/RgBJzXix/N/ESeVQAVAaDbvSKUfmDyLgCGlc0QrypB0N6Z6+D0XZnvjIoPV
 1vSLRvUnvRmIbMJwMz1CKznxzEfo/6QzVUqkCy52HQpYb/t4RYaigEcZrEDMoR5fa84wZMvQb
 HS5OLNZ42Jfsg4OLcwZh44Gsy+4uBPEmAdXy0LXbvlI6/pjwnFFe4Rb2iCbzRknIKMDKMouch
 VASy/wrxI1CKYeKDop1zyRkRaAeD5kn1jqQNeGHxmvWWZZphCGopxBgRdG+qOpa0i9ZYfaseV
 OCuL1LUOar2wOWKcZOnRznjPOdmNHN0WSlYrnCFFspWRs68o+Xo1MDy9N9CmA33LMvwvmeBtu
 +eCQbKM7ZDrKb4NWwnYrs8zIOYo5Hsgz6ZgqGMYUiM7QKTw4HKi8HLWnpN3gwvM4Y5diEYumc
 Fn5DScgqbKpMu0QSCi8AvZkf0iEivD72HS4ylEn+uJb7SWEWFu6rwN/wVYWk1zqAcSp8h800v
 4/l3Wr/DCoT7SHaIrn0xHdfDPUwZMc7HfDtI3mTu1f/vxbcYdNnJynV8JYZmJSIT9kW2kviO9
 QboBaKsJITXfZen7csGH+92cNFumo9+FB3y1lX91paLDL5CixBqnhZ1DTJnEXsDbJOskgZPhl
 srCaZ5PgE2amX/0dsxFQVHVIVHSV58dV3oVL8ijUYuqazl/Zle0zx3R+tnv6icPA9r3OvSV7O
 fpFLvxBZo4rR0OvUowaJGNo96R69u4D2/tnJRN18GtYx7FPHZz6yQkDvdVC4hzsx7SEJgHhpH
 oPWnDQbXYEhkSnn/gPJL2Y820PSCk9TLOB8WdJeFXgP1F87jXf77q8UlTpxtpi7MKBaeTQhM5
 nHPsr/tl1NYpYAU52joQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/18 =E4=B8=8A=E5=8D=884:01, Neal Gompa wrote:
> This is a patch requesting all substantial copyright owners to sign off
> on changing the license of the libbtrfsutil code to LGPLv2.1+ in order
> to resolve various concerns around the mixture of code in btrfs-progs
> with libbtrfsutil.
>
> Each significant (i.e. non-trivial) commit author has been CC'd to
> request their sign-off on this. Please reply to this to acknowledge
> whether or not this is acceptable for your code.

I'm a little surprised that I got CCed, as I can't remember any
contribution from me to libbtrfstuil.

But still the license change looks OK to me.

Acked-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Neal Gompa (1):
>    btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
>
>   libbtrfsutil/COPYING              | 1130 ++++++++++++-----------------
>   libbtrfsutil/COPYING.LESSER       |  165 -----
>   libbtrfsutil/btrfsutil.h          |    2 +-
>   libbtrfsutil/btrfsutil_internal.h |    2 +-
>   libbtrfsutil/errors.c             |    2 +-
>   libbtrfsutil/filesystem.c         |    2 +-
>   libbtrfsutil/python/btrfsutilpy.h |    2 +-
>   libbtrfsutil/python/error.c       |    2 +-
>   libbtrfsutil/python/filesystem.c  |    2 +-
>   libbtrfsutil/python/module.c      |    2 +-
>   libbtrfsutil/python/qgroup.c      |    2 +-
>   libbtrfsutil/python/setup.py      |    4 +-
>   libbtrfsutil/python/subvolume.c   |    2 +-
>   libbtrfsutil/qgroup.c             |    2 +-
>   libbtrfsutil/stubs.c              |    2 +-
>   libbtrfsutil/stubs.h              |    2 +-
>   libbtrfsutil/subvolume.c          |    2 +-
>   17 files changed, 495 insertions(+), 832 deletions(-)
>   delete mode 100644 libbtrfsutil/COPYING.LESSER
>
