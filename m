Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2187B1586C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 01:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBKA3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 19:29:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:59723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbgBKA3k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 19:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581380967;
        bh=TsNAss+VdzjiFyu8CuioGEhEuF7gt4AtEvXUX0XTv6c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HG/JBM//Oxy/P0Uc+lJMhGTyafzLgNmdOmOrnxuSv8NZcdRQWJn/cMcu3ICyAECP/
         EhuUGZFdkNS9XlNQooCa/HiWci5BA4z/oJOJzbENylnSAGSTpaTku4bRCaZGhI3qjz
         eWd696/mIVmI9C4BYUWlIi0Ai9+DOvclQJp5/v5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17Ye-1jUEN232jK-012X3o; Tue, 11
 Feb 2020 01:29:27 +0100
Subject: Re: [PATCH] btrfs: Doc: Fix the wrong doc about `btrfs filesystem
 sync`
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20200210090201.29979-1-wqu@suse.com>
 <20200210160929.GJ2654@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <a853cd2a-2752-d3ea-4fc7-80a1ec7e1180@gmx.com>
Date:   Tue, 11 Feb 2020 08:29:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210160929.GJ2654@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0fbHa2T0DM9VE59hPYHRHdEEXZMzOVdchUciyW7qOm12JCeVdSa
 sQzfWP1abgEo06VU8Zix6ChZ4nq5fVjwgZls4GtHSvglhRr6HwrkyKbVtdojpgxxW+x508r
 ciGQHC9Y0Ff8Wz9n4TuKIt+6nzpGHno5toVIMYukMBSlJYnuak8caJOXrd1Zplwu3yALWT7
 ONWfUoVHu357fdLecSNdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9wNQ7WKGW8Q=:OTjYIFo3Telby30d9mH1tH
 mlNnshThsHGb6c1Xz+h2cbZY9/2bQAltT/s1iO5mbmqeDFt3QQEdFcOpCUUA0TMi0ZxWux/dJ
 BTZQ96hdtUZJ128FiVXJOAwRce5zNQFms3JLe/j6tZMnmkNadTN0uqo+CuJQ1PMObVZaRUaOR
 4mCnfx8493urRMqsy0JEwiqeRZWw/Y7BabX352/WZiNvvg4EUOAJJGT0QsBXywH4TBWQvAjLU
 fXwtpfeE/dGRyeDKJ1SSDzQuZHboLpDtr2u7KU6Av1WBraWk58nGhJuOOuRIw6tNLJaqCz7Oc
 YhoU+5nlD4fyl4hwkPIs1ExGLAGrrWB70XsmecGWyLmATRim27NZBqu9Ub9Dl/BdT0MVlrwKx
 VF7pMS1DwhIy5OrOHiI4a9qa7p8JJ4mFzMBi8yDU0gSWi9Sn90MsXe5aK5tu/14MVhNj/v6d4
 dEZ5IVDcDqV44XJur7zjfeElu2chHYOVsECXuIcRgulKpFS733dch6ouctwq1sqd8N1bz1SpZ
 6+MNg/k2Wl7Ss4aBJIaVj59Zv8g2uFcUgw7ulhYQHoe5bysa2gyyC5kWixI0UQcyS5DDDWOUb
 zCloaQWUfVGqAFnbYR/SPAfYqHuuq7r9KKMGicyExaf1QL2EbDGAX9CyJzStck43GDU2OHEyq
 Rz8RkUjODll5/SVaEW0vVYhiMy56PcLvX7/QteWN4R7B7+HUYnUTyR4TVeCtvZdNrC17ZHFb1
 tMcmjg4JSmE0P8/zhTzODE9RMBF8Rp4Xu0OIiCe+UnPDNcR829Ag3PLUNKNf4yG03mjFLKZJN
 DssLIwa7jDA2pT8PIRInXcoqhInToIk/mQbGX0HacnyIknWGzUZbbUHZnyDevvUOCjvbQb0Tu
 cFMEEXxSgZkgH0p6AWP8MJKHsny/XfxHwFFeCdkCl3RX7O7V+JiQ2c7W3N077zfxOe1I8xLkf
 8Kyha55RUxk6fBSVMELNwQilC4h/k4hvMTR5OIwah4Qebw8dMdaJk3/kI3kebxy39KhWSOT4z
 b3WeRaalvEjrXVo3s7cXpaBK2us+dnaXIMw+3dA+1ZO122ypcH8JjyroFVyaszq1s1MfquHu5
 2W36wogjb3v8FB9N12IGxifqU8iYXGA4LHPCbn48i2gw43wQ3Bj3szocuUiFAe83nPFFRkTLF
 /s5Vdx2IuVm6WN8kS5F9XFd5oeB1GYUVQZSDvGrqoR7XE145la7qwZh9Q3xdSEJHME2Y3LBLu
 lqtpU6rrAAXDtzD73
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/11 =E4=B8=8A=E5=8D=8812:09, David Sterba wrote:
> On Mon, Feb 10, 2020 at 05:02:01PM +0800, Qu Wenruo wrote:
>> Since commit ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem
>> manual page"), the man page of `btrfs filesystem` shows `sync`
>> subcommand will wait for all existing orphan subvolumes to be dropped.
>
> But this is not what the docs say, nor what the ioctl claims to do.
>
> 'trigger cleaning of deleted subvolumes' means that it just starts the
> process in some way (eg. by waking up the cleaner kthread that does the
> actual cleaning).

Then at least we shouldn't really confuse the end user (me included)
about the cleanup.

In fact the cleaner wake up doesn't really have a user-observable impact.
We should at least avoid mentioning such thing.

Thanks,
Q

>
> For waiting on the subvolumes there's 'btrfs subvol sync' and that works
> as expected.
>
