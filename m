Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF25381BC5
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 May 2021 01:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEOX4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 May 2021 19:56:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:44981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhEOX4p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 May 2021 19:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621122929;
        bh=jBCc2XuVchhP+UAMvCYzvFb/DTkUaKi7Rxb9fnhS53I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a8wFFTSZKxCSUxkz6R41PDu93N7tDU4TY8jNFOdeepoTYd0IrizyHOCMzmjW9v/9J
         LgAksqeMD5saG5HUmmtgsQnem+r3IiqZr+6GuKw2u8bMpCp4gM4XLbC84G7aG8ZliV
         AuZCQyIcOzRhivWdBrl8mItweq2wsm2ycDegMiTM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1lq0c91w57-0086Z3; Sun, 16
 May 2021 01:55:29 +0200
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
To:     dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210515023624.8065-1-realwakka@gmail.com>
 <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
 <20210515133523.GC7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f52f74ad-d0e9-babe-b555-455fc185dbd7@gmx.com>
Date:   Sun, 16 May 2021 07:55:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515133523.GC7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7L7tcEsP0jvCpyxDA12IdGAwz24DJgPvLd1yRmVpjJjRC92Ptwo
 TpWbsQUbrzCghS8IV4yRiABAJegAXZWSYDU3sGwxs84Vusl6Yvs9695TyReNhHA4XlK1EmL
 dpn3l1jGyEWBN+sFEUm+tB+O9e8dhchAiH2d2W2r07F74qora48FI1PpTjOujhP8fQSKhHH
 0JyS88yb9TtH3mLJqyw+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qpzTlM0hFHg=:0R8tug0Gz9NaxVCawdsO3I
 tPi/+PL21hgcpUbzh6wvX2cUjjnXv0FptZ1fIv4xakXIW7IeeGgeJmZQkF3P+11L/Dzmy6po7
 DeJk7265fRZI+2OSFo580wnl7xygaF9BQgD7QK9PO2Nncx36JI96M/byAKPVNbJyYVcZKADLW
 S8v70o0/hwPZ1ReXD5KqzZJkOU2rAdrVlxCV2XowRw54Rjeqn+lZwQ2KVZN1LLGP9pjYx/pvx
 RkDXQY5doJFOMq2+HlW1lLrPp3tfiQ/cYiaDiRERKHqfj35QmlCP0CTE/I4gNm5McuDHzHmXt
 FzjdGdczCOLGQWzigR20KQTPDyqI3lNWaM6H+5/t7361FMyDKvlZKslK2x4MyDQy8TXVCx00R
 9q001LQQw1t7kbWke8zh138Jf3EbQcrn0X2BbHMM/M7J5ALYpHY6ng8PHVypANbEtdkVrDOsK
 KFdXwjK3D94Uc0ap++L03uepx024PzWkQTaC/qcdWOSSsf1jRhUMjLhDftIivtvdevQRumcD5
 qMDKW2dDTEtL2V0B+F2Lt0JV7+eeQ/d8u3Q4eI1PoRss7d1ZWNjGUiTiWZLqFWv16Ydm9kjKT
 Q2NuZeFKNED5+8f9OeoHdzAt2oShYN2ubu8ObbP+fUWlwoZoh0aaSww620fz1vV29lmKoB5DT
 EKd4mApwXwBfi6lDyCwLBErnQVqZCde4A9PFgZcH/030HpJhcE2/fAtf8fD5eDikMYTvNeXtX
 olFHOn4Tv78wfyWHmNx9AYDyfS2Y3HwBOY1yqQOPG8d2iN1C70bn+ofxGHLH7NcL8EGdW8PKo
 CceIj4nOTJ/NbE6DT3ZU3bZ7zhelJgDQ8Co4ixuSPiDQf7YLwLxRh78hPn/giiCLUrwMgC1zx
 3x6Nfqj5yiDBl0ij/M7xOQm0zpyy1oC2BoQL2lZq1VYj1gNyHY6qwkfMI2plPBh9xdkPkZk/6
 48mhOZgcxklwqIVyBm0gKHQd39Y3juUKkHVjFiuqO8h/gQlKqd4ktJcrdMqXwf0piTbFR4SiD
 l11nt/S9YkygLHCVedwmyV6jhr4EHeaDAnSfJ11J3Cu27CoPVLHZVVHV78dn8LoPhR35/k92u
 hGy4Rg6d789KCw08Cpq4fyT/xyiQSJmvCvqGsZy0/sapgJv5PrF0WM+J1IrXHgh7wZ4HVHtSH
 eTUXF8sbKVBzj1NATHEeA3q+kplelct3T5DHZMeYLpSDPzKUcUZfObv2UVW06fEDSWBquHJBn
 8t+eOK6Kta9qO5RYm
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/15 =E4=B8=8B=E5=8D=889:35, David Sterba wrote:
> On Sat, May 15, 2021 at 10:42:15AM +0800, Qu Wenruo wrote:
>> On 2021/5/15 =E4=B8=8A=E5=8D=8810:36, Sidong Yang wrote:
>>> This patch adds the options --delete-qgroup and --no-delete-qgroup. Wh=
en
>>> the option is enabled, delete subvolume command destroies associated
>>> qgroup together. This patch make it as default option. Even though quo=
ta
>>> is disabled, it enables quota temporary and restore it after.
>>
>> No, this is not a good idea at all.
>>
>> First thing first, if quota is disabled, all qgroup info including the
>> level 0 qgroups will also be deleted, thus no need to enable in the
>> first place.
>>
>> Secondly, there is already a patch in the past to delete level 0 qgroup=
s
>> in kernel space, which should be a much better solution.
>
> I've filed the issue to do it in the userspace because it gives user
> more control whether to do the deletion or not and to also cover all
> kernels that won't get the patch (ie. old stable kernels).
>
> Changing the default behaviour is always risky and has a potential to
> break user scripts. IMO adding the option to progs and changing the
> default there is safer in this case.
>
Then shouldn't it still go through ioctl options?

Doing it completely in user space doesn't seem correct to me.

Thanks,
Qu
