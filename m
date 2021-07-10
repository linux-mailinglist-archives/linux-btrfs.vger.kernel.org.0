Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6E3C3460
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhGJLky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 07:40:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:35819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230468AbhGJLky (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 07:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625917075;
        bh=tv1GAnOndqiRbiMR3QGymvwkJtKTnOmUEU/vJwGr9ls=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jN/8rLmogt5Bgb4wkk+T+arKJ3r9MOPoQPi1h6PQ7fgCVUG8Uuqa9W3kFqiSmP5CL
         2mb9oPYqR/8TPepay9E92LTZzIrqz/UsGpBGp9IeFeL67z/FhAUrJV8oC4S9XBRO2O
         mJFOYTyWLpl4VpSHTPMts7koP0gsYMf7vzpdOEVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnakX-1lKu0d3YkH-00jYr6; Sat, 10
 Jul 2021 13:37:55 +0200
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Neal Gompa <ngompa13@gmail.com>, David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1625043706.git.dsterba@suse.com>
 <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
 <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com>
 <YOfwuQPtXScmFULF@infradead.org>
 <dbddba2c-9242-d8ab-3969-86e7b2974727@gmx.com>
 <CAEg-Je9ESQ+Qvq7uVvV_K3ZGgNrD-kYzJMJif=3e5cCe8p6aXg@mail.gmail.com>
 <95974239-b63e-75af-0720-7fdb10e9fbe5@gmx.com>
 <YOmBPOYfsuNtV1jK@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b163061c-7435-85ad-94a5-c26db1b5dab7@gmx.com>
Date:   Sat, 10 Jul 2021 19:37:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOmBPOYfsuNtV1jK@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tH8ltvauYxg1PCTYvzR/SYBtfllkrKlx4qpIds/vTrjfDbvsJSw
 q2xgPnlFI/h7RetDfOe2zql7ZRyvvdyJxPiTV5Iqw3bShsCU85hRaQ2fB7cRkvdVlBqjB5f
 LPpH350axE1GpGMkSD7nAF6fAlZ3C2ayBYAPr+iRGSpg7n6kwioBiA2dRR1IN3yJ8Es07uO
 BOaN7hyQUCMZva9rffLWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z3omi/6af+g=:iVXLDrixLXF/yGZCdLE16H
 Rm+0edkK1esdJLZ6WKGXvpavN5JcaW67FvNxQQE9INuSP3uiQy2nqp1eSG0N6uiX+kC0+gS09
 H2nkxPM79VVl4lsAKMABNTXb3zwKXkurd56vc+FcmAwGoB2PMJv4Ux3YPbgYGbCi8Zkw9IInk
 T/yz0aPih2CXM1QquoyNtaBGIc1XlRiq9x4TSC9q8dsNlC3evR6WGXQ0auAb3iH7hQBIW0I4X
 k+sak5g+FtBvlY4FId1gGK5UvGrc3RMcNwsBIOvW9O9arJwIUcHJISlpv88ci803wNMvM5IAv
 bzO5lCEd2PZ4/H2unkclZlp+yflOOzHBGIBsaZDjc/B5Rr97suiOe4BWGoLtLQWKaBuNzxFaK
 /tcKcaeBn2L4lSM/5zaUMKjmr48ijfvNeEfCreTrIqbZQmzg57bHqGWbt6TF4HXF10lsHAMNN
 nOSnLDl3dIg/GmddSp6ney+S6sIrSBlbFwaDf6EsUUr2XbtpZBDGmkQT4IJ2wQOyrlFWkgXtx
 bd8HaEDYFpmiJXo5jyAYgnnZyUDmcEp2OoGCyAuJwXgi5Dil/qFsIq7gnJe6O5TbfpPyrWloZ
 vtBOvnBtXCgEAF1HPsA1PXorednTEc1K8arjtYwLmQRrU/lf0hRYkyrvn7qL59qnxtxfmwlmm
 bEg5lAJNPrV83m86QWvrrF2OwxX46V8yp5ubBvKgO4rhvuzhXsoOPzWu3Yv8Jnlh0v57VRdBo
 fCvmpUNEIbxKE8e75pHtq/w+jcfX/Ln/Zq+op4Pq6TzPRAJMHX2rXVk3cQw0k8fQsgu0Rhv1I
 QzuUrbnNQgg73Kc1Lpn4mqb69VzET8DJw1j28ofv3/dt3UyRGTxsh9G83ya3KA7MtEJFWezTd
 f8PA9MzplHlUtf+slYZFkHDRRz4Qa+V3Tdh/wU65RCcTm2E4e2fWWKJTAkeQbra0jFn118kbt
 ENsHzJuEwgzk/eLhwt9MAoFkGIvR4zwmp7RqQ9vBHFGS7YbHa1MdqHeMdyR8UHzQQIcR8Twfv
 8RjDN9FXfC+XEBlEApjcI6vdNCSv5zAuwKpvlFeHJ//T1lHnldvqCJZ7mbJKiJ+y2PbAqPbCb
 Y/JcEPSBHQR+k6vCVyD9hJ/aS2UYmqnIj4Qbrc0Js8g+zK0CbSCIlsZLw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/10 =E4=B8=8B=E5=8D=887:15, Christoph Hellwig wrote:
> On Sat, Jul 10, 2021 at 05:50:47PM +0800, Qu Wenruo wrote:
>> Don't forget that, our biggest memory usage, inode pages are all
>> allocated without HIGHMEM, just like XFS.
>> If it's causing problems, then it would have already caused more series
>> performance impact.
>
> What do you mean with "inode pages"?  The actual page cache data,
> which should be the biggest users of memory in most file system
> workloads is allocated using highmem for basicaly every file system.
>
My bad...

I just did a quick grep for HIGHMEM, forgot that we get the gfp mask
from the address_space, which could have.

In fact I just checked the default address_space::gfp_mask, even on
x86_64 it indeed has HIGHMEM.

Thanks for pointing out this,
Qu
