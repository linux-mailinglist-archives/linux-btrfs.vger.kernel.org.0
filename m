Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD14E3EF5B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhHQWWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 18:22:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:46609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHQWWe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 18:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629238918;
        bh=v74K2et05XkBEvzgfNbw9FesZEcNVX3/5QRh87vZrAY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dNPWA2ug2JTWYt0v+Ua0vHji5kxRl7zoQrgxs5bmm0a6GrBw9qs+3pzBfZd4ZZDMP
         A5W2vYNQzvRmK5LbZRu+wvGTtDCYZd89M4R0Xi3nCa+yWa4GxS9t7zXdj7N8Xk4s/f
         KM4TPttv5A5dpY0pWM86Odsmfom37I7MFpprLFy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72oH-1m9ENu1RJX-008aRS; Wed, 18
 Aug 2021 00:21:57 +0200
Subject: Re: [PATCH] btrfs-progs: cmds/subvolume: try to delete subvolume by
 id when its path can't be reoslved
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210628102628.354173-1-wqu@suse.com>
 <20210817133244.GN5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a6f697bd-99f8-0732-a3ee-1992b5dcd004@gmx.com>
Date:   Wed, 18 Aug 2021 06:21:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817133244.GN5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6gHxYcQ4KotjLP/nSUdIi9PiwAybRPCW1S5tMIsvEF5VFg4Q30o
 /1sejunUsWsf8gWLybN5XHh0jO76OhgbPjSGW9jkmq3v9/NYzSWyG7Qr9vryLyk0zfCJ5LO
 +86Bd87CwceEsZZQl/ds9tMgQHo70A/L0bm9xjdPcdHyYLG5TUvNXJYCEaQ7dK3fA1DHSo1
 YW6tcB135EOehBABxefqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QfRZaXxv/84=:zqCJrouoNKYsGJd3Nh7AQ3
 K02c/Y1JMY2ZdxzmNhWg8eQS8Dqwvao2dvOQrMnO4JRjATyfYjD3JCQewisw8xvqgvE+jAxKl
 oT9fS5TI/eKUpvYgB5y2MS9w+/zQcccX8kuYIy8rcwBC0tr4uF8NyPJUQT1/AXRqmedladlyE
 ou6Lf1kyyGqhM77iZvqOPV+Ma/cE/JrMIHNfsEBYxitXwTj1+T0WDgjMyztwPx5J7LwdMd6KO
 jvNWE+Caq+Cq/k5efEHa4VhiC/mv7aBt1sDD0UvPa/qeI7NEf5O8JhH2uZnXi5sVaNILwTvRN
 TyrfOlcmpsd14mbtCatrYPSmyghydYUDznRMx/h5Krxfflk24+z93qGH4Bp/EPEclfsIHJ4ui
 7bWB5Hd6MNL9DF2KnYnPH7yRoZFPc2QlM7K/LsnHlKWAmBFrg5KaYUEx9Oif3INcKu+t9FBNy
 vmGpmGKkCZMUUeiKQu1NLf0rq4susujSc5/1Zsfq9ohqBb82gxp3MPipPUgaqqTK4J5ZA7XVO
 4Aqi38+wyqgc77C/WOQHFwriWi072tl9of3+0z02MCVMUER9i5vYcDiZovHmWDUZxRB1XGCZ5
 KrWyWSw4P4XgzYADKPogjp7rBOiyYKkrDyv5y0tkekQNiciVH4v4/tGIrFndfjP2ijqiFSVoK
 6nt13AhI1iADEJ3xgII7tdmBG5SA0shxeat/MHaLZZowDN0MOm6gHER7u95rzrxG9GdtGeNbi
 Q54jQ7K4lHeYWr5EM2YVBWWVir4Ljm9WKhSZ9+dBsNGHWFFtZ44TddquzlSjYTtzqlioZ+YBW
 w+mDUkdrIaa2C9bxxqEAGHU4w7/JcD4n+HO1E+zGBFpiCS1pVtxOJ/YnMrrNG72tyPpdfPw2P
 p/4gj+YA7zuRbCU1aWPuMrfu+n/D17uQ+6zzHF3dAUqPzhTnTEZ4e7HLiIiKWBkX414fd2zNI
 uIkF5UiCRhBxm9z/a/rnhDJ8dmNg9S48XFsczNeWjWW7LP8DvcvBh2lE0ui1YoQutRNYAim+Z
 3Dtt7bym2k34jrlht02FliPPflaI3UxVs4qCE5snh0zSmIxpHzImALcBECmRacBq0Qpygv4aG
 Y0DahZQtxBjt+i1wWenOB+FZmaNhqzkywWRSjUrEtT2vaPAjQB8Z8vgWg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/17 =E4=B8=8B=E5=8D=889:32, David Sterba wrote:
> On Mon, Jun 28, 2021 at 06:26:28PM +0800, Qu Wenruo wrote:
>> There is a recent report of ghost subvolumes where such subvolumes has
>> no ROOT_REF/BACKREF, and 0 root ref.
>> But without an orphan item, thus kernel won't queue them for cleanup.
>>
>> Such ghost subvolumes are just here to take up space, and no way to
>> delete them except by btrfs check, which will try to fix the problem by
>> adding orphan item.
>>
>> There is a kernel patch submitted to allow btrfs to detect such ghost
>> subvolumes and queue them for cleanup.
>>
>> But btrfs-progs will not continue to call the ioctl if it can't find th=
e
>> full subvolume path.
>>
>> Thus this patch will loose the restriction by allowing btrfs-progs to
>> continue to call the ioctl even if it can't grab the subvolume path.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to devel, thanks. Please send a test case.
>
That needs kernel support, and I didn't see kernel patch get merged yet.

Thanks,
Qu
