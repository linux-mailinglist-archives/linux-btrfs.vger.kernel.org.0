Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4983436214
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUMwM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 08:52:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:56783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhJUMwM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 08:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634820593;
        bh=mAX9jj0epBSfXQCSQOhVuhDmfwd5aEcSc6EQ7bWAM68=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Udh8XsjTQeO5aXrFZIHyYBgGte/5HQ99+0Hu/j95BRy+ycEBj6a9CSepLyu5N0SGy
         TqPIeSA9vyfQvL7rdD+DAgYYqv/5hDrqUfR2gjdfCIVF0/zVlHUYtyS5MLa5N27uf8
         tf4ZAoK2vqsdAf8MTBm8Hlq3vgR3ejv92YqCfrx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOREc-1mLM0U2KXW-00PvjU; Thu, 21
 Oct 2021 14:49:53 +0200
Message-ID: <7b059d05-191a-e914-b55e-df437586ff6e@gmx.com>
Date:   Thu, 21 Oct 2021 20:49:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] btrfs-progs: unify sizeof(struct btrfs_super_block)
 and BTRFS_SUPER_INFO_SIZE
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211021014020.482242-1-wqu@suse.com>
 <20211021014020.482242-2-wqu@suse.com> <20211021124042.GA6400@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211021124042.GA6400@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lE9UdeA9+w6ZIT9Y2rjwZeQ8Xa8hWapPszBfkd6TKbf3/vq/hNs
 vT9AAYa4O5TE3HiWTPqY5YC/GJMQ++xT2aUN2bQkgKcXhi+IljclbAZQAClFmSYdW+UHQxE
 9p2VqBxJ9SwX6Y0OMQSwTVWKt8X+lXcsxyLagR0Rn0fuDP/iPqYIpLaFosFQzitp1tMmo/F
 9H8pGZiQOoNpn2RFQTDuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SucjKwFIJrM=:geHJnFS7rO3I8u8Q47LqCi
 whKRHXfvZYH2TeRyFsipv3dzx18mXbHyCwMKtEiyHjBPNWZt6X+6MqucOXWunITVTtxTcEGtj
 Z3kZyFSmB9JUiqjrH7MldSSkSsFOHXNTCP/45ahaDLtBk0zqXNlblujXNSnZ3MKEXBjGEEMEQ
 EhmB8sp0guyh/GfE2wcoPkAIhgh9YaI3x1y5OS75GqhRH2RMw0jzEtwV9kj6yRL3x2mYTm/nU
 9iuQ+tZFZdIHv+K93ZCAm22xtV7r+KWqTWVSkk5T9XNLcCVOSS0Hq8xSw04QQ2PLsKo9zyDKx
 xAUhHpcpr07gGXK0Nkvpv1+ge5/BAxk4/E514jvQoKZRZUVsroB9+iv4W3mpCDPR228IBIXel
 /YTlF6WTSeG7jQqiXt8Xdrhi3jZtBP7jtAQzZ7Umb9L5D6/v6TBrxk2w7kd32jMZ0KkapKhfP
 6AYcXQlf0f8PuWOPcwxB49bI+3kQIHxnUZ+d3No+Bae4pKCyu1ubhUarYyXkqFZ03b1XMxey1
 SKrNm3QBnBJR+hSmKKpM8tmohMoYfLP1l0ZRR6UrFZ0WpKsHZHIJiuBvl1d58Wz1L0jVDCCCx
 dwoC87FSyndJqDSY7xRKJ7V9atidBWUx2e5DxoLniOPzpqs+/redcl+GkQfXGHJz277aqMj3I
 +rXdZMjDKOJ7LHoxaPTzdyUCKOD4N+P9bF01fUdkhA7/ZmS+tEhiTeMWb2oP+Z4Dqxg7t/fSm
 RAHffvxqblh8vJAVN/mQZXwcHzCAKCMFxsVrvNJiyRu8JM6/VQSApvg6T7rWCnDQ6s0HjWze+
 ZBph3yfn0L+gVXnx2Pp19H8t3aBnk6GfBXvbwZOHzWUnUjFZpGvxvzQ7Nb9Oe1aoqFYeKHCfu
 81CULZFaeyYlan6fZA0ev2bOjZ1auM5fv3eUeGAlfo9J6D+njWI18hXNiEFNepC18KAp99lEK
 Rp0Wuc0YDBvkEVVjE0FAeWdQ26DB+wlJ0qY2QuQa5pgp3btg7GF1rlG/TnHIaQs6Bb3IubQ8U
 yDCKOumIO61W8IoxU9VW1RJEdEQ+MaNxlWrqWA6Q2aa6be6XD7L6VaWOITHcX4x5Vd0a/RQ3Y
 dAWkWYQswGXVd8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/21 20:40, David Sterba wrote:
> On Thu, Oct 21, 2021 at 09:40:18AM +0800, Qu Wenruo wrote:
>> Just like kernel change, pad struct btrfs_super_block to 4096 bytes.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   kernel-shared/ctree.h   | 7 +++++++
>>   kernel-shared/disk-io.h | 3 ---
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
>> index 563ea50b3587..6451690ce4fa 100644
>> --- a/kernel-shared/ctree.h
>> +++ b/kernel-shared/ctree.h
>> @@ -406,6 +406,9 @@ struct btrfs_root_backup {
>>   	u8 unused_8[10];
>>   } __attribute__ ((__packed__));
>>
>> +#define BTRFS_SUPER_INFO_OFFSET SZ_64K
>> +#define BTRFS_SUPER_INFO_SIZE 4096
>> +
>>   /*
>>    * the super block basically lists the main trees of the FS
>>    * it currently lacks any block count etc etc
>> @@ -456,8 +459,12 @@ struct btrfs_super_block {
>>   	__le64 reserved[28];
>>   	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>>   	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
>> +	/* Padded to 4096 bytes */
>> +	u8 padding[565];
>>   } __attribute__ ((__packed__));
>>
>> +static_assert(sizeof(struct btrfs_super_block) =3D=3D BTRFS_SUPER_INFO=
_SIZE);
>
> Using static_assert breaks build on musl (you can verify that by running
> ci/ci-build-musl if you have docker installed and set up).
>
> There already is macro BUILD_ASSERT used in ioctl.h, eventually we can
> copy the static_assert from kernel or use _Static_assert directly.
>
Mind to fix that on your side?

As I don't yet have any building environment for musl to verify the
failure or fix.

Thanks,
Qu
