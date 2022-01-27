Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53649EE03
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 23:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbiA0WUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 17:20:22 -0500
Received: from mout.gmx.net ([212.227.17.22]:40805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238336AbiA0WUW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 17:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643322016;
        bh=eiAp96NFjiopoh8o6AW0OF1VSUttaNTObzdacMhEm7w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NDvebvpK/vDF2KjOAPV9unpBnldeyGskrxaFJNM0QFfLl2mjmuOeQ/dbBOZkUf91P
         9hO6cJrdGnDGQOmeGLJsnkxW2sVnMzlmx+nd+e5ZT5BsjHFPMnNnVHBXd+2YZQqMHw
         mp/bnWmTXmNT8toSttGrYnnMqRQ2zFx1bo8j0AyM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9uU-1mv82f0K82-00IDmg; Thu, 27
 Jan 2022 23:20:16 +0100
Message-ID: <92343b23-cf6c-e138-9cfe-79336cd1bb54@gmx.com>
Date:   Fri, 28 Jan 2022 06:20:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
Content-Language: en-US
To:     Ritesh Harjani <riteshh@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220127055306.30252-1-wqu@suse.com>
 <20220127153806.vufsbus447s2tdib@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220127153806.vufsbus447s2tdib@riteshh-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jrW16DZ5vuDGIpME7lEIkn+EzPRNK701YRHXkz3I9ubcYME+cWB
 c5bd2n4IKYAy4X/ClTNFQf9/SZ2hofEGl6/+Op54bDgNOpPxT6nrxLjb0B0Ea/NmKjeLDef
 n7NUDkOrZq266hjk/vffAZipfxagIevDQ1hHh9tRD+WlEqmyCfbMxEiPyhHMBI/RpkOl3Ft
 rrquOeIz2+rl5ewJ3WquA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ZXpSBxsgwI=:hdzyoAf7xGpp8sErr5ZNv4
 4o5AWij4ECx88bl1n2MdAWaJaJKDqBzRQjHzqlWP5jUhhAGxlxhxgMpYWGm5a+uBZOudkbECZ
 gRT1Ih3/NBJlLdylGSetUi8tTKSDdz0M/uABNJIXJG1HiWqTZ7lmYT5Zif0Pi8rBB9NECRv8O
 4zfelWWEDwxfqY8Eu5Jeo4jcqouVaS3Lg0jYnWYaREnyUmI2PQLNPvIvASQcqd9qJgnE32ypU
 QgsLsZromfoOXhSqrwznbQyajtxKNC0ZM2kk3rFIKs/+MF9toeqNjBMs62++UsB1ZltbQj/++
 EYRo2dI4TqkpfyGPm11wGljfPZlm9GnRrPVm+RjTcbFTlpO9t5YceByMA3+XaAdNWS102Z1GG
 lWqmtcqqy2AwXJBSNd9D7KMukLHf1MKJZwADJzZkgE8cQeJzUodlgykzmWhJLwO5ORPrAph80
 K5qlUr6T+13Kc2UKvrOl+PrUvPv8Bcnsc08ycjCdAiSqyIoPrInLJ9vt0B5Q3MjRyWPHRenFf
 JfnxKqOdgdCjVvRiyOgmxnJly6X3jojo+g5ZAQ4vM4p/n7JrLVXfYdW+ma6aTERufye/52NIp
 44TumyjYmVGr0lUePxcLBn7caaXR43xss5z+BDIoHfF7AeBvnZ82MMOUwuRwQfZTb5JwugwSj
 42FeBOTJ3LZUHh/oUHewjvjzQ/X33UdB4EWmM8n0N9Y4FQMMatrFCtOQkQSiovs432WW8D49z
 vZ5DIlG78cNdbNHknuAHDourjJVmY5uOLG17KPoewPog6/MbiZOKVMjI1xunk4MDxzCk6yEL/
 bYCK9ued0GqACiLEHmi/sKc3aUjM2TNbyuHpLq4XOEeih9XDKDMj7uCTLUjNOgI1p9Yi9JX/p
 Ff4rNjgPu3gtwd7NBx33ziO+cJqw7ETwdD7lZ1YOiTqBnBiA3oor3KD+0TGNOC1YKjMVZ0jbj
 IFt2ra25cMQKz4i26PJJYlvzvV7Y+uIBiPprNeOy8mfKDKyDfGCG5RBDr+PrbG2KsstkgT8/L
 ImMKSnNXyknK6zOHvNbyvU/Z59Xb7zoiCjHDFTdLeAD0YVUfWM7oNE8ugrO5Iuw40hdMWGPMG
 /QOpRtnhGrxa8M=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/27 23:38, Ritesh Harjani wrote:
> On 22/01/27 01:53PM, Qu Wenruo wrote:
>> There is a long existing bug in btrfs defrag code that it will always
>> try to defrag compressed extents, even they are already at max capacity=
.
>>
>> This will not reduce the number of extents, but only waste IO/CPU.
>>
>> The kernel fix is titled:
>>
>>    btrfs: defrag: don't defrag extents which is already at its max capa=
city
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/257     | 79 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/257.out |  2 ++
>>   2 files changed, 81 insertions(+)
>>   create mode 100755 tests/btrfs/257
>>   create mode 100644 tests/btrfs/257.out
>>
>> diff --git a/tests/btrfs/257 b/tests/btrfs/257
>> new file mode 100755
>> index 00000000..326687dc
>> --- /dev/null
>> +++ b/tests/btrfs/257
>> @@ -0,0 +1,79 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 257
>> +#
>> +# Make sure btrfs defrag ioctl won't defrag compressed extents which a=
re already
>> +# at their max capacity.
>
> Haven't really looked into this fstest. But it is a good practice to add=
 the
> commit id and the title here for others to easily refer kernel commit.

Isn't that already in the commit message?

Thanks,
Qu
>
> -ritesh
>
