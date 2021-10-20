Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C24435663
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 01:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhJTXUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 19:20:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:33811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTXUy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 19:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634771916;
        bh=1FZoDzPgmof4GmeQcKfQtNN8bETZjwd+s61Z6q3dFj8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GQfOPl7KNiMci7XSKy91r/5qEr+MskK2U74FNfFvjFMhLDGQ801FpwqBslbH6QE+u
         sdYTNA/eEwL9VBDlxyj9yQYxppQYkOSU+VcSkWGNiuvQZuML209TZb068GyIHjLJZ6
         JxbczolksHtaSP+0C/U8ciWBHIoEBJ1GwhoblpCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5iZ-1mNBPi105N-00J5DZ; Thu, 21
 Oct 2021 01:18:36 +0200
Message-ID: <be5ed653-e95b-351a-6946-6a9ff18491ee@gmx.com>
Date:   Thu, 21 Oct 2021 07:18:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/2] btrfs: move btrfs_super_block to
 uapi/linux/btrfs_tree.h
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211019112925.71920-1-wqu@suse.com>
 <20211019112925.71920-3-wqu@suse.com> <20211019161033.GV30611@twin.jikos.cz>
 <8e567e7b-e6ef-603e-c376-afd68bfa152c@gmx.com>
 <20211020171326.GB30611@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211020171326.GB30611@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Xe56aZOc8VpwZspt5H+Joxgvd7Nvdd/TvD2sFf04iFKkT31mo6
 CTj5UjmP0PXkm3W82lO1ruLBLwyfD8i4o6hw1tpJ/lA+YeylVEYBL/1C676cqFUPgxsxfdd
 aPUe6TRdpIrjlPgrrF37sxqXoZmPEV4N0OmV2Dyt3yop7rlWKJg/vPJKovUlu2I7nT7rZSG
 4h2DIOz6ykFEzyt0tk7Qw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MH6NUP/qBl0=:xffXmsv0tU/3sEFbBWnE3j
 NgLja+BJ6I0iSRsv9VwT1+1TJZoi/afdehGvAszvv1V+Vy0ssHAeo9Crd01WIO36yyuMUkwSZ
 hF8Rt0uietEx7sEgZgtszGa0MpMxNDovdyDG8GR5O/BX2hP79T0ylgNE4gyp7vXmQL36tGxRy
 eax2Ge1ih5ekqzinh38t/3qlBGHczJgggkcTJRCXGtdPmFFwqKroUJdejXD/dwb30fEuVIIwH
 EfzEia/cODrApt3eJVZNGtzfNq0Txo/OfFuFU1P76TCwDdySSL1+bzAUTh7Itb5oRyLoT23ja
 aRQTi+Dl3epCuuYBxkrmOcUIBrBrDOXGkGPKnjVfUr8Oia/T8MeVxxrP7KWEPWpW4S1B+QRK5
 G4drSI1/bPY19/RDVMnlwWij/2Sx8cYGroHgiDnzXv5o0KkYv+eMBeTVBCJqn+qyzMZso0AIj
 DFKzGq2QEBb3Dy3h7rKWLZNMWDU1Sybwk44bc1KZWezIE/kNWOOU38gOGRtrxbaodONjaHZ2Q
 lr7V27+DOhtpgvVr78xEW2ms4lCbINLH0QQ0mi0xz6ciqz9D9spC2qoiJEmjX48QNR+gYYwOO
 YHp0B5o4wozMhhoBh5XJH9nrjbrWHzgH8o+f0313cLyYg35BlphIVSpAEYoxoa7U6XsM81Vty
 OTivNwrsgaQcJ99EaGD0PauE8L0iNsknIudEQOslgyzwK2gZno0OhIYBwFcUUB54LwZg/puQa
 9+o6vm+I8rQvXRmuuk5deTcWHfg/sh/WKhCHVr0IucAPoNx1V0oWNrEkmi/4uuVz+2JIn7vdZ
 IQZnp+/KNNlpZ+WecbnkSouARQPMQ60Cz2IcM2pcQWDYTjT4eurkShZH5vUc/+uE/Lvu4b2ty
 /PXZLRs7ci2ZXVRKtL5vKjBbZW4cie/5vIJLkOvFKchfvKivsNyYkZAcdiFsgQmF11rO/dQ99
 QljkHSRLimBkPFKTnFtYg98zrDtwahQMkjkSLCttKKePUCLGWlII3pS7ZGpPYpxD+Glkih7xP
 Ry2QXTW/gQ/83YWSI7TAOk8H8Ac+wQO9ILXsP9WbqHHCMOFTM4mTxx7erPGfc4XyruOiZf2QM
 7uWORN6oSUzXkc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/21 01:13, David Sterba wrote:
> On Wed, Oct 20, 2021 at 08:19:30AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/10/20 00:10, David Sterba wrote:
>>> On Tue, Oct 19, 2021 at 07:29:25PM +0800, Qu Wenruo wrote:
>>>> Due to the fact that btrfs_tree.h contains all the info for
>>>> BTRFS_IOC_TREE_SEARCH, it's almost the perfect location of btrfs on-d=
isk
>>>> schema.
>>>>
>>>> So let's move struct btrfs_super_block to uapi/linux/btrfs_tree.h,
>>>> further reducing the size of ctree.h.
>>>
>>> The definitions of tree items are in the public header due to the sear=
ch
>>> tree ioctl, but why do you want to make superblock public? Ie. what us=
er
>>> space tool is going to use it?
>>>
>>
>> Well, for super block I'd say any user space tool can directly see it.
>>
>> My main objective here is to move all on-disk format to uapi.
>
> Why? You sent such patches in the past, I need to read again what we
> discussed but I don't think we should put everything to the UAPI
> headers.
>
Then we need a new header for on-disk format that is not exposed through
tree search API.

It's definitely not ideal to put everything into ctree.h.

This is especially useful when someone is crafting a new btrfs
implementation, no matter if it's something like winBtrfs or BSD (if
they really want) or something else.

In fact when I am trying to create the btrfs-fuse, one of the things I'm
doing is separating things from ctree.h.

Thanks,
Qu
