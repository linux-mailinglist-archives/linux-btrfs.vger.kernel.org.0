Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AD40BB58
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 00:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhINWV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 18:21:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:34431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235754AbhINWVs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 18:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631658019;
        bh=GHiHqvHlE9FVXRvfz4x85/Cl9fFud602DGmTQdleiMA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RbZaJAf3KPKN9FTrrcGr2gUz3H2z5K/KKY4Lbpk0oeuDVJTFr/u+jfLQyrhOTzu24
         PCXOMQiJzrBQRBGAuvZttLp5AkxYVto7WeUnnIayM3jD1ivDLKrATnu2LUP6wlIG05
         TyDxrRGqLurgoaDw03EatYXimktVbWKXZ4i3y378=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3bWr-1mr7QX2gLr-010gNi; Wed, 15
 Sep 2021 00:20:19 +0200
Subject: Re: [PATCH v2 0/3] btrfs: btrfs_bio and btrfs_io_bio rename
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210914012543.12746-1-wqu@suse.com>
 <20210914162553.GE9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1bb216c9-27fb-f949-bc9b-d4ec129b9097@gmx.com>
Date:   Wed, 15 Sep 2021 06:20:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914162553.GE9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qtjHN1W/u9eI01EJehGiLwhHx2/O7XC3b93MhiDhRsnXTLxFvHz
 26NqhVn8jam+V6KVikK8GqID6nRZoFbMtD/Yp1D5NcZWPRWCbk+vLhzpPC4CjCxnmeMFtCP
 tE8mUxAnSg4PKMx+feJ4rqU4s9zLqZaJn+YcQOWrwguWcNdqn78y3O+oa1eQONQvwLKOAdZ
 UajNeb2JXwWhevyBmzPhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PasGUhARzEU=:KSCylrgBFp/aL1CRA3ZDHT
 uWBrdfxaMqe9lot5vc/zx9D8mFVpN/wOaqQeu8OCvl5qunBdKZuYnXReMuU8lt1OZQgo+B2ik
 8JB0EUdu50sQ3AAoDBEvAsKEmZLg4iq14AJVLpAgql2DKrWwAVp9qdIw/f9Ng+EBbIZXWvNlJ
 y+6pzpfGbyIjTeyEB/98zxajRMVaLLDNP77UL4CkZxteIMDYw0q+TPqzymx5SYn1VIJQsLFJt
 wsNld2bmZ+WY5K04WVOkMQX+mG6azYCHRRkwyKy0qKEwV61cTR/2MyUGx0B4/FslmuHWO5TAn
 qPKvqvLu1Cb8g35p8sOpOF1Wrn0A28RCeN2GM7nNXysf5IOwErFcPjerjvLEdAQH0pd7NOn65
 D9kRh7LCDJ3erKwX+XY3A4LRgDXFtRUGYNkg4Tcj2EwakTtv5EC8J73C/U0Wr20p1o23neStr
 bMmncDhx0FoC8gpTNqYAQMwXoPWpJMKQhcJ46djOr5/7wN9kLS43mXZrxRO0u0dE2nCrapyaH
 mn75QUwFWvALLXJz2JTamzuDKQYPUT5f2GT0yifkArv5PzMKJFLEDSDw56A03jPpWOS8JLbTU
 YnMTHimDwLBkvomEKTSe/vXiU3I1JGCIgm+dZxT/8FCRjdAhtLhRMDgiek0VDnDEzUOZjrFwx
 sTxFhQZkxD+aN/DTLEOq6mEVYwFJMStxpszn5hnAhOfR7We2wjUDIug4X5GKV9kV8VL0+fEP7
 s9/b5X5pYArYjUIqrPwEcKbcygDtmniRMpNz+Y9WRjfivyDJt2BFuPk6iEzqmf/0AT7oWJdnH
 VpdVVSbX1tNKleeR/KzRfd/BnNw5qSmaMZuccxwaW+0YmuLh6TKuWoYifvrUdY8xbYvMdjY46
 yAFqQZf8mFoavBAp/CqJi7GQtsr8+GI8Yd35bySK+jcxEyqrcwUkGeNaYjoH4dcEB/tzplnRg
 dAjTt2ZSBOdA8Huf8lnQkdAqB8LNkxlS3gapa3v97TV7OYc4lfLtzjCdVQjozGS2ACMT4BKzk
 75elNltEtGjjhK4FfZ0jT23pL/BFNfpUFVrEWSOFpYaKiyuAVdq0vdfa0aRFdaW/yDlnrTN8y
 1U0vuYr+4wAtuo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/15 =E4=B8=8A=E5=8D=8812:25, David Sterba wrote:
> On Tue, Sep 14, 2021 at 09:25:40AM +0800, Qu Wenruo wrote:
>> The branch can be fetched from github, and is the preferred way to grab
>> the code, as this patchset changed quite a lot of code.
>> https://github.com/adam900710/linux/tree/chunk_refactor
>>
>> There are two structure, btrfs_io_bio and btrfs_bio, which have very
>> similar names but completely different meanings.
>>
>> Btrfs_io_bio mostly works at logical bytenr layer (its
>> bio->bi_iter.bi_sector points to btrfs logical bytenr), and just
>> contains extra info like csum and mirror_num.
>>
>> And btrfs_io_bio is in fact the most utilized bio, as all data/metadata
>> IO is using btrfs_io_bio.
>>
>> While btrfs_bio is completely a helper structure for stripe IO
>> submission (RAID56 doesn't utilize it for IO submission).
>>
>> Such naming is completely anti-human.
>>
>> So this patchset will do the following renaming:
>>
>> - btrfs_bio -> btrfs_io_context
>>    Since it's not really used by all bios (only mirrored profiles utili=
ze
>>    it), and it contains extra info for RAID56, it's not proper to name =
it
>>    with _bio suffix.
>>
>>    Later we can integrate btrfs_io_context pointer into the new
>>    btrfs_bio.
>>
>> - btrfs_io_bio -> btrfs_bio
>>    I originally plan to rename it to btrfs_logical_bio, but it's a litt=
le
>>    too long for a lot of functions.
>
> This sounds all good. The only dangerous thing is that btrfs_bio now
> means something else, so that can become problem with backports or
> requiring to do a mental switch when reading before/after the version it
> appears.
>
So the original idea of btrfs_io_bio->btrfs_logical_bio would be better
in this particular case, right?

Thanks,
Qu
