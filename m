Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04953014CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbhAWLA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 06:00:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:53325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbhAWLA2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 06:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611399534;
        bh=xkv99fZAucZ3tYsKqUqWWbET7N3pjUFCWDxs9SX7Z6c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PNLvoJhw+iY85QUDpQ0RtpZXKVzIcfFpHzITJsi49xCVoG+w9hVNv0G2avgnAceWb
         EOiwKeWk7DTNXuDbBgvtbRqMIGQYN03lBoe2QSRjl7emVqEosDeGoCnr6VpR/z5b1L
         SAOFuGfTJ4YfQqAU6ggwwx+FFlTjMnqWIjgMKtvA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWASe-1lWXup0czS-00Xa9N; Sat, 23
 Jan 2021 11:58:53 +0100
Subject: Re: Unexpected reflink/subvol snapshot behaviour
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Dave Chinner <david@fromorbit.com>, linux-btrfs@vger.kernel.org
References: <20210121222051.GB4626@dread.disaster.area>
 <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
 <20210123153933.534a43ea@natsu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <aece4c0c-c0a1-accd-d7b2-99ff1327de72@gmx.com>
Date:   Sat, 23 Jan 2021 18:58:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123153933.534a43ea@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YJCgSHnBCbjU+efMxJomsvuF2BjFDJkRu/9d2gHlA1eXE55xy2c
 1bWU4LG7e/yxMybZ2iZbpjGHrVKEgJ14VVaq4qD8FsueRB3/PSC0E0/9yS/JiCiuKQLLcGW
 cyC1FuPg92Nn1Hmx313AWTtfv+Jj5Lg4P4UF5qTeVgkKqGNzrfQykPtNYIXCPX56g6jGhG3
 XS22fUhVeSUTj+sybn5Rg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3gmwWl2lMZM=:ZBnDqQqmQcENmLciHNRUcr
 QwcDGAsKDj7aiFDSsoSCSqq5MxRb5/8Z+kRhD8jMN+YKyQoF9QNU7IAuLhUIO4UmVL75LzWpZ
 lyuQaLc+DpMrwInyOXHiK4BAiilU8xyM6T4NoV4+PyHraI6QPeicRDfPHpJOkokHY1lfOf7lF
 NENqHRuwxmblOiUVo72nfY2W1NF7FoW9T5MiraZq0whb79pS3MuRAYOnlL5BGoUfnU3l9RTTJ
 yS2lrova46qYxdKepiWC8LL8zjzTF6dZYYulRqFOi70mT48fYPfoTyI7SkGLyQsMGmbD8AYJ1
 njWX7nuYrZNuFzZ7OCG+Qct1x3COl08DBALh/fNHnRndRiOIUD09IJ6It+JWfBTNjwan6wuyZ
 6SB/96o5oD9Ig0+Q7hjH+SE5yfvtF+C4NJycjD8yn7VdKEHa6btbNB6AWmruUhZ5c6xa55rY5
 /bhBJxO5TryYFHQxfwERw3Ob2lV3KybTgyzexjskhau+4PNqw94ZiEsJcIzreLDcBnd1z0baK
 imzk9kM2R8OuULeAT+co0Zqjhasbm1QijOprUfcScBL9VorF7xnTriLpPfhZO6j0AyTEZKN90
 PA4lFUUu1v18VKpiOecXBiCXBvOGo5/3LJOeakjHuQ3/ok4BP5E8eMwMSiAtZYexQ2+9BZNmD
 /QdPFrACRYgMa3GWbn/bKGVzllg+6coiXtzctAeh3gD1enELIclvATWF5h1lVlQKnaGPon9YW
 a5BlusV/QjtJGOTnFTXNIGi+jTCy9LesiQ5+N76zZxkhYV/MQ18y7/v/fUr81/D3+brB8K7CE
 KTBX3lRwxGBflqSxBkoqhbGLuwKipYMHMJ+LxXPNCm4HDYLbxuG5e6GlyWcpBSxoqXY/OYTSZ
 IF0AtkQ3vg/L6OCK6LvA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/23 =E4=B8=8B=E5=8D=886:39, Roman Mamedov wrote:
> On Sat, 23 Jan 2021 16:42:33 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>> For the worst case, btrfs can allocate a 128 MiB file extent, and have
>> good luck to write 127MiB into the extent. It will take 127MiB + 128MiB
>> space, until the last 1MiB of the original extent get freed, the full
>> 128MiB can be freed.
>
> Does it mean enabling compression actually mitigates this issue as a
> side-effect? Since each extent will be limited to only 128K.

Yes! Compression brings the side effect of reducing the maximum data
extent size, thus mitigates the problem by 1024.

But the problem is still there.

Thanks,
Qu
>
> What are the typical extent sizes without compression?
>
