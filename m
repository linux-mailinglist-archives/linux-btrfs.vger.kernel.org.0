Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C245434283
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 02:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhJTAVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 20:21:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:48851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhJTAVu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 20:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634689174;
        bh=wWLRpWPF9UlQA/ZPBUSC4U38iw18699to4GBrKOOroE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=a2K5VVFiXJZ1R+OjfKMV4jokoaQmwOgWDYARt+QF5/6JmmyoYsR60MAwG96fWNXuX
         r6RdC6+3+iDGdy2zsu29C1Xr1hjIJL2VyXQoQA5O/HHh/XPdDJfz60ofV2bZRNhXC6
         oxs2vEkrzBIglfQZwDldjDiis0mi2WCwaI2ed4i4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7K3i-1me7Nx46Cy-007ljb; Wed, 20
 Oct 2021 02:19:34 +0200
Message-ID: <8e567e7b-e6ef-603e-c376-afd68bfa152c@gmx.com>
Date:   Wed, 20 Oct 2021 08:19:30 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211019161033.GV30611@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:az9APJsBRdCCRScIxEDFrzkoIeIGOKtEhLnDKauEXwmwz0s5oQb
 7qttg91ZOrmqQm2N7vWM4iZbr7rD1ucig8UaNnWD5tgIoWwfb9rdTAtd5qJfpjIGl8YTXs1
 ZVOBVZunNuGWjphkkJqKM/x01lZrGMPotp38y9H97t7BQLeI56rElRFim2+Bh+ttC0ABiK9
 esiV6TXi97M+aUheDvmnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U44qm5CnFns=:PF1wCS2LT9o9Tls+dZKgEX
 zKsC5kmiM4/J29CJGIzLeoPu/1LdUr1tCmDx5eTtBSmPs1Uz1F+39uQlW8ZVoUehs/P8iPdZg
 dw6vhnYklLmUGiIOTM3YxrtZIj8yYvz+PUXiAUBNwDEdz0tRh1kR9OIYVOf6B9uqLXqHcnk6h
 VHGCOdEDlMLf1gI/eRZ+Xe53Z/rfnDIdQTUzzGFnU7OXuZRfY92jVYR3judJwC9kB5eDfhqX/
 MhpJgkG4elMf9hLyTwFpioSuDs3Ho+Xns5ZOcRqOoPUFH6tjDDb64uuy62yruPokdHXfMpLyE
 P0rd7yTWmsMzOw1rnE3E+HjJzMOkU0QkqT5irEszwQatvGW5RYw8Trp8gtVtMWEG5H/0Pf3wT
 awjMWVwXS33WSTj3Zemg97/rXSZe0Fs9HwsqXp2Fa84p4eZCBzuAaYorAR/D1KAWZKtTVTo3N
 /u0Z0uwL48rWuIqY3ORBcHgnNCqNN6E0vCFH7R1A7torngiwZT7mIjFrUU5Em97U0a6POcyhR
 ov4gx6QzU0pM5dtq26VWCcUvpGQv6SLN3S5zaxnhJh8lYQEGbvVMT6iPYzlRNJpSWIy5YuPzw
 LBu+5vh/8AKvQxWlIm3L969sGXa5O3XNGYxh7T7dgtA6tp+x0Jokfu03NzKNGbe2GHqiIa3FD
 wxiHiUvfBCAuE3wLoGm5nilf3EQg34dOKWZC0k00616irY+AEcGrLsq+alq0aI5u3ZTyPxEqS
 ujDYSGHFmpvg0BwS4aVhfwN/GnuAIZtqzQfUlcKYs7oX9pb2oWuizbfPo43P3Jwq2D+fcdVwu
 4aJABHx5UjiIvDE+cOKh6+G59QfhS+A1VMcq8ufbUxzGk2NVaECgcEVkZQeCrf2VmgrB8UYdf
 yyYF8Gsh0/2T0YC0tdyhCYy+HHytaMNP9WH/7lEn5BkeXFMPsHhpyJk1FBO7xn5xeokW1hOLo
 Py8caEkqPuwBDAX/zLAbXac5kOBb8P2lsVoAhjx6T5Kj2HeWv12bHXh9eOJjRwjuTVWimJuOK
 +TPWfgDylULPpW9uzinLMTQOC7M/g9XsQ0r2xueM8Za6zjJlCPEJrR1sfHWOOf7mM9shSG1b1
 R8XV399rYdEcOk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/20 00:10, David Sterba wrote:
> On Tue, Oct 19, 2021 at 07:29:25PM +0800, Qu Wenruo wrote:
>> Due to the fact that btrfs_tree.h contains all the info for
>> BTRFS_IOC_TREE_SEARCH, it's almost the perfect location of btrfs on-dis=
k
>> schema.
>>
>> So let's move struct btrfs_super_block to uapi/linux/btrfs_tree.h,
>> further reducing the size of ctree.h.
>
> The definitions of tree items are in the public header due to the search
> tree ioctl, but why do you want to make superblock public? Ie. what user
> space tool is going to use it?
>

Well, for super block I'd say any user space tool can directly see it.

My main objective here is to move all on-disk format to uapi.

And I don't have better idea than reusing the existing btrfs_tree.h.

Thanks,
Qu
