Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5B424BBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 04:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhJGC01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 22:26:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:55459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhJGC01 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Oct 2021 22:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633573471;
        bh=/0tdPuNXbEdy59mtIDeFMiR1K49G2ppf2oT5rs8IeV0=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=DhRkn7Q6Y0DGDd/0ekvf/ye3rWNjKarmjIMZ73a3lV8Lxx73NAcEE+qXOlzhXkqjs
         bNC1YzrONzvXr6VNAYKP0aOnqC+xkApql8o+HdTjSz+QoBZkKV6CqiO6p6ViZpdn6Q
         ANyaq9JmVL4zPYDJL3aSmrf5PXXbwGTnuSwBVe1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdvmY-1n5zjs2hC2-00b3WG; Thu, 07
 Oct 2021 04:24:31 +0200
Message-ID: <945ebdbf-658e-5a36-87d8-9367e2f9a005@gmx.com>
Date:   Thu, 7 Oct 2021 10:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210922082706.55650-1-wqu@suse.com>
 <20211006193826.GX9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 0/3] btrfs: refactor how we handle btrfs_io_context
 and slightly reduce memory usage for both btrfs_bio and btrfs_io_context
In-Reply-To: <20211006193826.GX9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ryA0DX3To0FE4+qV60HJecFa6g21bCNE5nh8JQeTTJlZmFdVTpe
 ah1SN2PaYeKPSBbYNeCxZGIw8jlJGbyM5ox5Pausfi5IWAIv4bmyotrOBOSzcM5gdVsl7I5
 MDmx/sHbDFW7pcSpaVeO30ETOkuy9UxGDPOz+UPw4GnbYldoMZilVIYsCue+EC205t45xEn
 W3YC7dWHX/kB/SG1/US1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tfRO1k3u/Z8=:oZHXtNQ5IAXpmNZO7FSBb2
 FRsggCDZ5HCxHj2cGn9etXiKFcXWb7EIaE+wyesKDlFU/YEOlOxz1ZJcMp2cRnxQ91vfHVI5M
 DqKGtoZSni+SI7fPfWjiBjsvNCxwHO2CAhdUYPFJkTUB4gOoBtBtuj8D3JYo1e/vJf1k5xRwR
 40rpTCcXZwSyQLLJN7DPDKO6xZ3MyL8W8F4Mq3gHlzSo9vqgDUue04hjt+Fka2qL8SIZ3Xs2S
 i6zzyWFw8fvi8AfOTGwQHIl2QLf30v91Fz57MDoZ3nmAy5EsVf3ZG5i/1/2dDt1wGEpdDlRx/
 TNBlI6GVjBBWyY7Ykd1kW+emXmIU4ecXJeQy/A4Lt1NsjE8lMO5WZhVNErvZGKNqxxARPSXhG
 nb8SvLbDtSYgiRty4ep0s4GD9a4uIyYpEG2YyAJ0hw4bmb7FCd0vzbTswQsLYI0pgBBL2maBT
 YmXcX3MgcYGNEnpqCltWmb2CgDlm/t7UYtW/xohxV8pixR4PV/OwVn4EgDm/zy/a/wUP/d9kk
 +uCLVjKtSK82Usgh+y0VuJp1SXra93H018+2I34EOgQiXamc91yiguvTV6grIu8Dv1F3ZTA/S
 G/I8JkLXGe8Ev64VVYookipZnfgu4/8nu0izc2b4jXrYnEPErXEpzZuZrz0wsAdzaGQawCAun
 568kc4VhGcLU5azOur9Z6V5SQeMNKOdgxYu8hxz0N7+Dksaxw2XN/9YjP27l+HSwYzTP9YafL
 zu3NiRkfkYmJWy4tI7UhimuAc2ULAuA0VlpSac3NQ2DUXglDu5wtwc4xRm0pgl9n4oDoiczSp
 gEh0WT0LgCgy+72J9efoznXNN6nB59LddEqp/v3TreC1zfAZmXNIY2WbNOOU7qr2B2wUWmMPM
 P53cObHHy3L+LtoDw/MuC+JkcaGhNiEmuU0cm72HFi0Y1bCGYlslCygDhAnhwz0pKSdrgCtM6
 9XPy4CtFggxA2OAC3HTvxM/WODIP4GwHDaJTdcnk9X/DGxBMrcfSfXiBzBTb29mSjAbEf/4K+
 AM7yHkEAZh69tcUDeeL/2by4hdYZHX62/mvcqtvakshyZFIdFDkHvM2k2UaWSg92VIRGHnf90
 HtBLltJCjV55UA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/7 03:38, David Sterba wrote:
> On Wed, Sep 22, 2021 at 04:27:03PM +0800, Qu Wenruo wrote:
>> Currently btrfs_io_context is utilized as both bio->bi_private for
>> mirrored stripes, and stripes mapping for RAID56.
>>
>> This makes some members like btrfs_io_context::private to be there.
>>
>> But in fact, since almost all bios in btrfs have btrfs_bio structure
>> appended, we don't really need to reuse bio::bi_private for mirrored
>> profiles.
>>
>> So this patchset will:
>>
>> - Introduce btrfs_bio::bioc member
>>    So that btrfs_io_context don't need to hold @private.
>>    This modification is still a net increase for memory usage, just
>>    a trade-off between btrfs_io_context and btrfs_bio.
>>
>> - Replace btrfs_bio::device with btrfs_bio::stripe_num
>>    This reclaim the memory usage increase for btrfs_bio.
>>
>>    But unfortunately, due to the short life time of btrfs_io_context,
>>    we don't have as good device status accounting as the old code.
>>
>>    Now for csum error, we can no longer distinguish source and target
>>    device of dev-replace.
>>
>>    This is the biggest blockage, and that's why it's RFC.
>>
>> The result of the patchset is:
>>
>> btrfs_bio:		size: 240 -> 240
>> btrfs_io_context:	size: 88 -> 80
>>
>> Although to really reduce btrfs_bio, the main target should be
>> csum_inline.
>>
>> Qu Wenruo (3):
>>    btrfs: add btrfs_bio::bioc pointer for further modification
>>    btrfs: remove redundant parameters for submit_stripe_bio()
>>    btrfs: replace btrfs_bio::device member with stripe_num
>
> Can you please refresh the patchset on top current misc-next?
>

Please discard the patchset for now.

Unfortunately I have found one critical member abuses making such
refactor unfeasible (at least for now).

- btrfs_bio::logical abuse
   Direct IO uses btrfs_bio::logical as file_offset, while no other
   call sites really utilize btrfs_bio::logical at all.

   This means, we can't simply rely on btrfs_map_bio() to verify if
   btrfs_bio::logical is correctly initialized.

   This is a big alert, if we can't do ASSERT() to verify if one member
   is properly initialized, then it's just going to happen.

   This also means, for direct IO, we can't use @mirror_num with @logical
   to grab the device with IO failure.

So for now, although it may save 8 bytes, unless we solve the DIO mess,
we can't continue.

Thanks,
Qu
