Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826C844E12A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 05:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhKLEoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 23:44:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:55519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhKLEoh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 23:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636692101;
        bh=CyBnArZQuIzhs9Y4SnPoJj9splZKq+fcKJm62IE7KSE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XyjMkcpxYk8Y0FkxVHv2KHbdjlAEjphfrMJoutLfLX/fAxDElzUSsDmIaKIrSyFSt
         gzZsXiw9WiT13mV3Y3pxqBccY2BKNME2FzYf4yzCdo7XTaknd3EyTIzN/LYv9GAEP4
         IeKJoivoFjQg9938wlp6PTQlN84cG+1JFdG8uLmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1mcLtE3qoC-00zlCi; Fri, 12
 Nov 2021 05:41:41 +0100
Message-ID: <5424db53-a734-6fcf-6b1f-e2e11b50e624@gmx.com>
Date:   Fri, 12 Nov 2021 12:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs: fix a out-of-boundary access for
 copy_compressed_data_to_page()
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
References: <20211112022253.20576-1-wqu@suse.com>
 <YY3qvDNC6S/YVrkZ@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YY3qvDNC6S/YVrkZ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pzdVjZP67GMC1cetcCHEAgfriZmTEPOHsw/+WyE4o9s0ffGzSOr
 nf+dLBwOWX3x6C0mMocNoKqyNSINuB3ofJtE52FaXKQyNXxGZthpMiBijfU6XNfyS4hST/o
 van0HmlybopStI3QXqo8sjw3MQJL7I0VrmqKBY7QRtYZAoOuv5N2OFbqCSdi262Vf7jbM6k
 hettD54pYcTEIUfS/qLDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A40lt54DvU4=:AZ5LRg1zEKHZ/sj9Ix9cct
 YFydTI/QlqisbP6LQTgUrWRGokRT5Zt+ResiVZOrsGRHnCzK3RGypLm0x1Wllqasi9JcXb+Gs
 DvHjJ9ugtyuD5t0W/QzACr9ClhttixXRQjvWLt17QPMLJ+hZglTNFO1JEn5bJgxidHxgWWAJK
 L0R6SgOn4qFQBuu2bsrNH5rPlnNX1Js2pdgtIFYJGCCMYp8kQLABSbnLhoXtZx6ifzL+ZAhV3
 6RBs/T8nkXdlbWGWayv/JC2d+bA0uugGPvph8oWJiJmddeDZ4QyhcbFuC3/Km3DLQIBzpJ76x
 XOxoeYf2ZBb80gbSZ/VImxzFQ7HxVITG0/wvk69LG13GCB+516Law5a1YIqbRhRssSIJQRyOJ
 0bzvhpHNkKD8kfaPJFVqXcWPKmmHgX+6/6b0ar4K9WjHLat6JoWf7wImZKk6UEu5KLqwHEouz
 mS1UFNy0BfLMQ8sN1ARZ/yU2lDBe1CoxsaHcLmp7jn+j7zCF9AE+OHtTkJkNea6y4Z0hzrX4D
 NiXNdXH9SKzclODAU9apZzZ9G7yvR6d2dZnkFqd6ATrqvG5kTCfGl04hPEnFPHIW6yF1IxZ76
 Svurfw2cWOOAJXZbWtAHAaIABZRPfHtFoDDeBixe+RSn7Xe+0cHDznsA0uYFofukb6PfHdV9T
 9s+kxjkaE8ZeY1q60GegWMZkttEfNYeLs7MISy8+BK0Jk0BQ8HWbQqrrir7lXjG5j3Va/itvO
 B6+hRl4mGOOg8Qz4MNRPt22B+J+N2tRHzy4WoY1LOKuCJDDG/Bd2kkEVHe+Qa2cL9CONDnpGh
 fbw136qeA+ozBi0BFarBIl5gTUsIOk2GxI4+bOSwO1MbElwsE+4goxTUNJVS/mmcRI2gY8xJi
 rSPw7ZPVs73CA7OFAchwHSFIrl/55hRVxk/kPGC8HlUlZrPjaw2AD2FeNJNNBA1M9yoHn4dsl
 z1F5DW+aGxy9IltWGaZN+KqvCKQwm++4ANeMKDsL+Z1JtmcwYVYtfrTc2iKU0LrtI4suG6cgH
 k77j/aIJ8RwoAbvGQaPnMcf8biwA7XR0GPziaoYKEYx4+nbtm9ZaYUjVBg6Q0QDgivmWKwgSV
 giDNGYKC9UO3YU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/12 12:17, Josef Bacik wrote:
> On Fri, Nov 12, 2021 at 10:22:53AM +0800, Qu Wenruo wrote:
>> [BUG]
>> The following script can cause btrfs to crash:
>>
>>   mount -o compress-force=3Dlzo $DEV /mnt
>>   dd if=3D/dev/urandom of=3D/mnt/foo bs=3D4k count=3D1
>>   sync
>>
>> The calltrace looks like this:
>>
>>   general protection fault, probably for non-canonical address 0xe04b37=
fccce3b000: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 5 PID: 164 Comm: kworker/u20:3 Not tainted 5.15.0-rc7-custom+ #4
>>   Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>>   RIP: 0010:__memcpy+0x12/0x20
>>   Call Trace:
>>    lzo_compress_pages+0x236/0x540 [btrfs]
>>    btrfs_compress_pages+0xaa/0xf0 [btrfs]
>>    compress_file_range+0x431/0x8e0 [btrfs]
>>    async_cow_start+0x12/0x30 [btrfs]
>>    btrfs_work_helper+0xf6/0x3e0 [btrfs]
>>    process_one_work+0x294/0x5d0
>>    worker_thread+0x55/0x3c0
>>    kthread+0x140/0x170
>>    ret_from_fork+0x22/0x30
>>   ---[ end trace 63c3c0f131e61982 ]---
>>
>> [CAUSE]
>> In lzo_compress_pages(), parameter @out_pages is not only an output
>> parameter (for the compressed pages), but also an input parameter, for
>> the maximum amount of pages we can utilize.
>>
>> In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
>> compatible"), the refactor doesn't take @out_pages as an input, thus
>> completely ignoring the limit.
>>
>> And for compress-force case, we could hit incompressible data that
>> compressed size would go beyond the page limit, and cause above crash.
>>
>> [FIX]
>> Save @out_pages as @max_nr_page, and pass it to lzo_compress_pages(),
>> and check if we're beyond the limit before accessing the pages.
>>
>> Reported-by: Omar Sandoval <osandov@fb.com>
>> Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compati=
ble")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/lzo.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
>> index 00cffc183ec0..f410ceabcdbd 100644
>> --- a/fs/btrfs/lzo.c
>> +++ b/fs/btrfs/lzo.c
>> @@ -125,6 +125,7 @@ static inline size_t read_compress_length(const cha=
r *buf)
>>   static int copy_compressed_data_to_page(char *compressed_data,
>>   					size_t compressed_size,
>>   					struct page **out_pages,
>> +					unsigned long max_nr_page,
>
> If you want to do const down below you should use const here probably?  =
Thanks,

Right, max_nr_page should also be const.

Thanks for catching this,
Qu

>
> Josef
>
