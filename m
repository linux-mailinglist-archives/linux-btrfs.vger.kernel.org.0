Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9037E3C1C40
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 01:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGHX42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 19:56:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:38907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGHX42 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 19:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625788423;
        bh=FBlXvfuxGgONt/7PcBByMMD402kvOx9sx/Z7o84cKmA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ge496Wf8v/xp2DBMFZGA9t2yP0mxpvuR/gxris4lEZLorcCypONPrlRdYtWPIjuJ5
         nGLKhoE93DqCMz697KD65XSIDkwmd6vGecxhuFDjmQD2nkINJaG4S5u/JqRRnYQg8x
         sHc9I/coTLXqajiscBm9fPFop1oItFvHvDU5hnFU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1lh7G92WXD-00XwOT; Fri, 09
 Jul 2021 01:53:43 +0200
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
To:     Neal Gompa <ngompa13@gmail.com>, David Sterba <dsterba@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1625043706.git.dsterba@suse.com>
 <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com>
Date:   Fri, 9 Jul 2021 07:53:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XWnR4T96w9VswbKgKDJ2KWbNwxXvBk0w0V5CIIR2raJjQ7LnJiW
 w2mDI+8BYgs1Uz36daKXnSvnnf1te55nPrXVHk4URX/SQeilxV7InUsxyA0J89H8QCaJIe3
 TXyxJwtOd5SZeCibYA/FGwyS0COlo5z1WtvXju9kDYqNmFPY3z0Xad4Wp/4S+AFxUXVY5hh
 s+47oHkZOxMt0GIO/lFsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VnD75eOeE98=:ZO01/7lF4dFMcpRTvx2Put
 mDYszamGf7tabzaffyh7rVNCqB5GPzigmYeIoCfp7R23L3oz3h2MPOSzNM+fJjmmaQw8gXAkT
 7UU1/MvTZ6USmTwa4Nirh5eAz/s+Dn6pSRPtleUTfBcat5RuikFCLuXZpKhP3pCILmceTBwm9
 2timkm7iOKw3QCKDNE1mcbhetQX/LBTVKlhV8lI/qQI2TDmZqDu7InjKRhyYnEWNmtiiENtA3
 8XZJRoSqcLXyXBsWC4l8zx9uYvKRfTsdqy+hVNA+cjNifqZUeyqr7eP71USd5mEFtg3ylQgsF
 Ibb0N64yRY6MKWlwEsz7exVlYHMwAQqe4bxEkv7XXvWw/RQDSUYimt7tXRjTWMYmPGrpuHdZ2
 D8jD0ChOKAKG49WU1gI3pwKVJjboZH7jCYK3UJnzF8GLasfKzb0IYIdK/EhRrtdKaWuA4pumi
 ZqWCszHOHmmOYtcUftNKykPJPA+A4Va+580PwLcFwbkH4tCC9gBouVCr6wu1vv1uA1GiCN6SP
 pfaF4ARq8elpQyBdTQqv6UJPD4Rs0GjgPw1wjFzEb+RUEyfTMr0Vvxiqb9IxkIe4N++znaMhy
 UlNoB//JpUMzA0r1DOnRchXbiyxPDRAuHzwnYiJ6eT1QjFwftdZ9LIkmGP4EtODGLklPjb7GV
 bkQ4h95zHliwkfLxSUuHM+HH0Qe2oeOdSW15SUtg3//uQxvYNnrWWNuNdHKuaa35//+vTcnhb
 BpP5HoXTj1iFJ6hmVMjbr5uyoZLEoCsW0GlpQAR2JzqnoFBEaxk3LnnRsDv2ywHd+y13VFQcs
 4N8U/+Xhu0HIWkGO6noU2kWv+u7jHPANzrlwc2IAeOnadhCbhqiQO36fHesVVmTHvpqN45zd3
 MQvVg3XEa+ka9UfAxJhm7j+pm8y3kAQr+WlyMe0as+9B6iIoSTCrXiPRRz5Z5vRyg++jFdkY9
 GBmoPxIMxlXjdiTkR59rGgWVwy3s929xrLoE3clOuCRRoXxhWlGTOBBXCa85GLS4sDZ9hbxxZ
 Very3rvyEjRfaReonJtlFmFvDsiVAl2Fc9AgxcRFEoNHfi/uQ2gnx98sAFHP/yyK94VChQW6p
 CzxgHGXUtt3UVmv6RkNydynqmOIB7z/IaP5M2Hyr3paHZatvjWupSXeoA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/8 =E4=B8=8B=E5=8D=888:45, Neal Gompa wrote:
> On Thu, Jul 8, 2021 at 7:48 AM David Sterba <dsterba@suse.com> wrote:
>>
>> The highmem was maybe was a good idea long time ago but with 64bit
>> architectures everywhere I don't think we need to take it into account.
>> This does not mean this 32bit won't work, just that it won't try to use
>> temporary pages in highmem for compression and raid56. The key word is
>> temporary. Combining a very fast device (like hundreds of megabytes
>> throughput) and 32bit machine with reasonable memory (for 32bit, like
>> 8G), it could become a problem once low memory is scarce.
>>
>> David Sterba (6):
>>    btrfs: drop from __GFP_HIGHMEM all allocations
>>    btrfs: compression: drop kmap/kunmap from lzo
>>    btrfs: compression: drop kmap/kunmap from zlib
>>    btrfs: compression: drop kmap/kunmap from zstd
>>    btrfs: compression: drop kmap/kunmap from generic helpers
>>    btrfs: check-integrity: drop kmap/kunmap for block pages
>>
>>   fs/btrfs/check-integrity.c | 11 +++-------
>>   fs/btrfs/compression.c     |  6 ++----
>>   fs/btrfs/inode.c           |  3 +--
>>   fs/btrfs/lzo.c             | 42 +++++++++++--------------------------=
-
>>   fs/btrfs/raid56.c          | 10 ++++-----
>>   fs/btrfs/zlib.c            | 42 +++++++++++++------------------------=
-
>>   fs/btrfs/zstd.c            | 33 +++++++++++-------------------
>>   7 files changed, 49 insertions(+), 98 deletions(-)
>>
>
> I'd be concerned about the impact of this on SBC devices. All Fedora
> ARM images have zstd compression applied to them, and it would suck if
> we had a performance regression here because of this.

Sorry, I can't see the reason why it would cause performance drop or
higher memory usage.

The point of HIGHMEM is to work on archs where system can only access
memory below 4G reliably, any memory above 4G must be manually mapped
into the 4G range before access.

AFAIK it's only x86 using PAE needs this, and none of the ARM SoC uses
such feature.

So it shouldn't affect those ARM boards at all.

Thanks,
Qu
