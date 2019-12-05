Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158D8113CF4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 09:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfLEIUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 03:20:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:40831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEIUt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 03:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575534048;
        bh=eftQGTs5Y6V/78v79schWVX/CDhQ/2LaeGoT3030Jhc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=C8vZbx/l6tV3hcmP1Jue2oYgWqEt81XlAxmkMs3pG4+gTSk7s+ed6LbUtWky98jJf
         KIXxVVbHUONILx8KfA58jsJqzCHHA07gSdOPMjfszXyJdtkerb/ZgcXUr0Qr7NJsnh
         qEnGl0ecbP60lfwqXwV1B10OwWQ9PaNGBfXUOoCs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.169] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPXd2-1iQBR70SKA-00Mc8r; Thu, 05
 Dec 2019 09:20:48 +0100
Subject: Re: [PATCH 05/10] btrfs-progs: adjust function
 btrfs_lookup_first_block_group_kernel
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-6-Damenly_Su@gmx.com>
 <16783ea1-48e7-45ac-ea1a-3e9048aa2616@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <db7e530f-ca73-8eaf-8fb4-8383d5691f3d@gmx.com>
Date:   Thu, 5 Dec 2019 16:20:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <16783ea1-48e7-45ac-ea1a-3e9048aa2616@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9n9F/FyP3qmKMF8eWPXfioZHXviD/IbsyinhPCxbcJMxypemkNn
 6y/jx+NYkhCZIL5HUsvBhiQwTojKeJECdDNOpYcvYAZV6OPy2fdR8YcTcSA2VxJP7hMNo8x
 ZABnhKwrRTwOhnM2oh8c4Nml85KMPw/IxM9g72UoMqpS2/rNI0r0+8MSdvm30J2Cu2LfnZX
 Gxfoi1gXFePcwgj57c8Wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FxXxrnjXjSs=:i4gf+OuHfzOEOSViffnuW+
 KN49Pu/+aVHM/GLFpndUOlCZk26ZpX+AxYxJvkSeIebL0sj6vYYJgu6euzq5/49+js4vgMwuU
 76sOlGefHl89L1zBB14Ej5CWkASPmZ8IWiej0WuH6l77+2IQ4ta4uDOEaSiN5BkzmDgHkCOp0
 YgFqFk9TanTK9YrHpGegOSuC611Ri1Ts7cK/99jx11HFf//EmJ+qmLZro0CGf/55Jh3UsYp/j
 qeyDx6Ik3nIYKiBiWVKEcXHNPW7LUtXBQ8T/Se8ZafiJf3nuOByo/cimkFnJP3zuEnbsrFBHY
 KRTeT9BPW+bfdBXIZ+lSKWlXfLzXAH8TYS136qZvBNnbPEIAzYV1vcjTxSbk/tPNhDX5ySqH/
 zc9g4rL4M8HsUtWJc0mRgwnnfk96VEYvnh8ibhwe6CroLl6e4kFVFMZ8f8sScapG+54xBeD9c
 XP4avojhKcJ44IhfCRfnKgZ6Jq3q4LnFA1i+q07vS+YAfCPixkxmv8p5cxDSsE0C04hjcoCHB
 xUKFKDqiIu9vlEtk6r7g4mm2Ih5gWwzDnIA/uDLDWCgOcq2XvI2QKbD7RvLoWVdg2GHcPf7Up
 PzvUzpMu64CMidONZOiEDIbTJo6wXXfhp2Dz1yFXV3jVg0A7Y5pEmTIYlgMhv0UIllIn4byaQ
 C/Dwc+PaJZZ0CUVWdGedfi0MW070zGdsJZpnMBMc67S/lEkGtt1rGOliVDboECj53NjKu1LRo
 Dm+FdyeRqtCuQeIMGoyD/lYiSx+2nVoivz/i4wBxPKkyvOzBMi3eUlR/kp3/ZXOqbli0GPhdN
 85Om1LF4PkwH6mu8YOfFaa8pQJFk6hsOvWlnJkvjBrDq3/3l7R0u+HE3heNw/aiIoFwrcQF23
 HcLKFADpiJFTDbCe/awysO71TZnYz/oW6NNgjKvoZsqvAO+SpScWNB1mcHR78/yYfSx4iZJt3
 iXsZ6BfRhQ25PNt6I+o0O0eWHkvXJfUQhtKFjHwr5XBy405Z3xdhHYEx5la6XchaoHHsxwhgc
 U2w48yBqnFOX/LIqSCGjyxAzCzob0AQC31zi9XRtErn+O9ivWPNtSBXa+A7Thhny3hHqhzsng
 fSw+KC46XTP0GcquyUuTeWX9/CHUrLsvNXTJeH2qzyx1a3AAzMnIfKW9YofbVqajaoLRA1wev
 qu88Y8dT+SDr1q89vKYzsPYDUvZb+CcqUIUSHNmlzBeMCxpKYYOWEgxDZiSEX/ti79yLZUNPG
 Lv5o2dRyOwzNJcov5XYyeUBAcSiJ4195EpbeEtWk0fw6bHQ/7+Kt4AF1unjs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/5 3:40 PM, Qu Wenruo wrote:
>
>
> On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> The are different behavior of btrfs_lookup_first_block_group() and
>> btrfs_lookup_first_block_group_kernel(). Unify the latter' behavior.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>
> Is it possible to modify the specific callers in btrfs-progs to make
> them use the kernel behavior other than re-inventing some new behavior?
>
In technological viewpoint, absolutely say YES.
But, it requires logic changes in many places (callers, callers of
callers). I did tries and it pained me.
And the theme of the whole patchset is doing simple intuitive data
structure replacing. Touching the logic part is preferable for me in
another set.

Thanks
> Thanks,
> Qu
>
>> ---
>>   extent-tree.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/extent-tree.c b/extent-tree.c
>> index 1d8535049eaf..274dfe540b1f 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -243,12 +243,13 @@ static struct btrfs_block_group_cache *block_grou=
p_cache_tree_search(
>>   }
>>
>>   /*
>> - * Return the block group that starts at or after bytenr
>> + * Return the block group that contains @bytenr, otherwise return the =
next one
>> + * that starts after @bytenr
>>    */
>>   struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel=
(
>>   		struct btrfs_fs_info *info, u64 bytenr)
>>   {
>> -	return block_group_cache_tree_search(info, bytenr, 0);
>> +	return block_group_cache_tree_search(info, bytenr, 2);
>>   }
>>
>>   /*
>>
>
