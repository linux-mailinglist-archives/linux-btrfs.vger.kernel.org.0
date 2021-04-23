Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE736912F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhDWLhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 07:37:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:44009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242029AbhDWLhN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 07:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619177793;
        bh=gJOXXFEpGTxdLOjqs/RPme9hY7dALfjTyREx9GgU7VM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Gj7QLQT1JZD7xWcSz5W0X+ZsQHiJuq6tBYxPc/KXReexiB8Fx8zykKSB2Hj6OCHc4
         UH8XmtUlwwlBFC45NBrC7HywZF4HkLlbcXlkKO5+17bgvgPUaeO1GoWlxgR3kMIq6v
         g2kzQudH89xSM51jHuLyr3tlOD+FmZoHTKpL8qpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1lTD6O1vT6-011xJt; Fri, 23
 Apr 2021 13:36:33 +0200
Subject: Re: [PATCH 0/4] btrfs: the missing 4 patches to implement metadata
 write path
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210406003603.64381-1-wqu@suse.com>
 <20210423112938.GG7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <af78885d-b9a3-7629-d659-812121696bab@gmx.com>
Date:   Fri, 23 Apr 2021 19:36:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423112938.GG7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2yhD5BpWK4jJF8Zfyqur4JdohQ3uynH+WbZbNrsqG+Oln/zgNJD
 wMfsOVrZUgqR8Idp76470SaF4FGQlmWZ2y6eP5mBxBLYgVP2p8LBXdEJ3yI+KnWYDFNoeqY
 N5+tHrtRRAJuoYnepVJye6wEabnDzE6BAsITfOKnW8eiGv+LdHDzmq0lJDwNLYsXXhs3kAt
 T5CGXJ5IMLOZC/WKXv7Xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2na/RDjs/7E=:yrB3ST2GmUBH11SxueSB98
 esrtYLSZvgffAmSKxnB5u42Qp+tietGRE23FXzqYd3X4lu3fRTH+35KQT+e9GHzB1wTDrwdiN
 YVcj2v+Pq0/jz3EGzLAOk15xqhMNW9D8EsaZ+koCqyhgbx8id7TU6xXPiAMh/m7PPone5UTH8
 taaPaJImqiOETjeZ46EFs/mVUDXR7leu/07v+0rXcN/AfToPmVFqjROem/v3hx/oRJXaG9GxJ
 UcsWwq2zv1Gc/77gGaX9gFTHavvYeIviRqGPa5jHaOVAsEfDwNHAObkAD38Ty8mMa8htyPvXm
 gCO9ao7Wwiuewb4Mg3kAOBpWIj4CFXN65A6NWlquY8gDiDv/pMRx+ds+p3CeY7+aO0yoGAHia
 R5Ut4T0mIs+2T6nfnSWzpyLox450GZcjYDMN3KPwRO9d4iMhqhPaHGSX159kLGgW8l3CGO8mS
 18pzBed3GeOHdPVfKAKg6KmGLmPZ93MufHD+g/zib4tjrsIIv1MwOccNA4KivJKTm8VVWBKDI
 Av+eu7xPaSyLdwUqhH9904cK06d0cAH8KF4wtx/l8tMCxqgcGi+8GWIDgytyqvwYALRrMx9s6
 9zKi5OpKp/WITiP7U4gm5sWkJpwQbnQgtJlpCO9yHoZ7oGx9n+Phg8mntvbJWE9HbQw+Jchtg
 5y58KFOt3eRyXOpvFmpHuszWBZjs74H41YNl716VVQh4byEj2P0yoBxIcDhOxbY6fbtjt5gKt
 ieLW1ZHjmLDTLWW3Hbh9S/w/ejPgqg2xuj4zCOJXMAUdnmeAqfLTfebeHM1VPInGZQ2fTGJOz
 9sXTJ4sO9YK/6Bolor4MeP1wrMxwWOiukTfA/8WRP8BPtJ4o04LwJIeoi6zn1fSRCqrfZ72AT
 m7j9mYUj3xV1gglTRgLtM87K2WQP/UmFXvtCI+6EET6N81e1wv0pvm/CDPiNOqEFaXeROLS0/
 ctPnreBSFmjmB0NVfhjbrqOCT3aNJlvMzOS7A+gL1FqLO3j115lKmPxSGpzokLKWnlBPdYn6D
 OVi4Ba63N/n6e2SOT7B0TlEyA01YTYSA0VQOtuQpr6Q7wQqm2Hmpa7zOeYcFu9hXABfncSUGh
 wUD0T1PY7qDfCqxP6v63thQfX1bRpRPEgGN7i8tJa4zOud4xFq9bMZ8sGT80e4KbMy25i2F17
 Jzc2Gx5LKc1q2hlL9E/alTCraYWvKp9jL2Fs3qRoqF8/jbF6eBWY4C2mSgSbgulTG1J8IAHLZ
 pNPb4CsPliGHK80X+
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/23 =E4=B8=8B=E5=8D=887:29, David Sterba wrote:
> On Tue, Apr 06, 2021 at 08:35:59AM +0800, Qu Wenruo wrote:
>> When adding the comments for subpage metadata code, I inserted the
>> comment patch into the wrong position, and then use that patch as a
>> separator between data and metadata write path.
>>
>> Thus the submitted metadata write path patchset lacks the real function=
s
>> to submit subpage metadata write bio.
>>
>> Qu Wenruo (4):
>>    btrfs: introduce end_bio_subpage_eb_writepage() function
>>    btrfs: introduce write_one_subpage_eb() function
>>    btrfs: make lock_extent_buffer_for_io() to be subpage compatible
>>    btrfs: introduce submit_eb_subpage() to submit a subpage metadata pa=
ge
>
> For the record, the patches have been added to 5.13 queue a few days
> ago.
>

Josef had some comments on them, most of them are just related to
introducing a new subpage specific endio function other than reusing the
existing one.

So I guess if I go that direction, I should just add new patches as a
refactor?

Thanks,
Qu
