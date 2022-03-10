Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E974D3EB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiCJB1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiCJB1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:27:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E083122226
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646875570;
        bh=R7hh0GSiG0nxXxH37OPpw2xnzBL3VIrXvWoZj2fVxTo=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=dyatjzZtk/jClj/QNRm1kFSe37VqU2QvHuI2MUr7s5x1XyIWQ65dCBTl2AQu7d8ik
         u1TPYTFvu4T85J5BNR4VZhMEuO9NH51KrzBErjLuFJ0zdKp8sX6GG2eV5oEWEHHY71
         T7viepEe+qnEXfMkaL9RAxQI9Cfewqy3P9W+rUQ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zFj-1oEsK20ufb-0155rb; Thu, 10
 Mar 2022 02:26:10 +0100
Message-ID: <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
Date:   Thu, 10 Mar 2022 09:26:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
 <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
In-Reply-To: <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FYgz8CBBtYcXhboaVPG9iipxQSuSiHjXzMNAbHh+Etbip2D6UJJ
 Cjb2X0IMBnj1UhpYRrLXi4OcE5fX/J7oDs8iZ1fQToHu1cN9m6fgacrzJYa3RJHFaxTAf9O
 nBzr8Ycsq+MDOlinQ3gu68PlkK1PWGrYwexKNMCdWRrVehKGrverbwe1cF4nnTPK0V+QGaC
 znUQhsoytPRm98R5lS/tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpuXkCpFiL8=:osBPgtG5jS84P1D8opymkL
 jiOoEa3LmRMhCvmedHjVxcG9/kkhqcTqdIg8eJdNwCmGvYSiyV/tzi+TlHdgv6JvEO1MfvtlJ
 LffYkr40Z1oXeD02+Qin7BbcKcupBWcQiI2UxfPSSLqovD8mXV0g6eOIdJYTayEVCMRmtNrop
 GJ8uLrxlM4xIysZV8780AkFHm1tBh7kpiQslzY6onVJ7Y4ijjF3f39LN1UaEb5W+liNKmE5m6
 NFeHUVMmNp7sXXgr6XfhvkW4JzDvMl+XjKYOPvwPMP6gebobkxLtL6CM0YcxoFHh15dOVNsWz
 WJEuGN1T+Us4BREn/8UD7lF+LCTzTz3TryeS8NjYXL0YWmE6tdLDWT6ylJ7FVkVc9KHIjC54t
 xg17IiLEgwWS0Ip2xmzYYMxCq1qHTMMNRAnjH54vNWR4feVuxEgTbKR4xDqQGzBw9cPnuVjwW
 vkNVhQjg0s58zf/9aHxiQmWRUnZp7jM720cwEK6K1DN2yxqeMfDeCZpqsLLjeZBcqb314SPiz
 a+PvX2urGSnpYSYXhByoQwNfanjZOFo3dEsx2JjxA+uBgYKjlne1Qy0gOt3znqlhpxrD64fkg
 OPOr9Dou0wa5iAN3Ql3LpUmxSiVJTAuYeann8YnxEQL+w1b+LW+ghV56dFYSCHCeRfdkt6KU/
 2LbjKYkMyy4nGkBD7LAV9jKgAv0CQvi03nxLGEywY50uPv5ZxMAWDT+5TNT5zFaJlvUbxx+xm
 OGse2Q33LbAir/BRrGRBJHuTInBfIB5vmfmuY2R8osJBbGd4CTUw/ELOMP6+67iaWlMMKvniD
 nk4krAcQd6bGkwV3FrlnOpC+jlFNbejfdR7VcPIme8ZDBt0qdfZW9Hj5W+dOjt6lhz07sbzD+
 ou0dx+hIOlEkxBnwzTDbQtW9tdEqzuNphHJRpa1JX5kvIOyH2+5FAhCopG94+2bflf3zzVfhi
 oKAbuW8xzpCcT+xOWIS0GaTNVaA+atDivBqaUuYxDTNvMw75p7bTDr/yHSDGfBefTKuQyxzPp
 fWfb3oB9KRMAWkiknRE9iYdlKwk6LJLTeglGYdvdIMPEnBQTES3RJ4o5xVNi2Tuje18FJwH+D
 AbrT4ia55sZLoQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/10 09:10, Jan Ziak wrote:
>> Or use the attached diff which I manually backported for v5.16.12.
>
> I applied the patch to 5.16.12. It takes about 35 minutes after "mount
> / -o remount,autodefrag" for btrfs autodefrag to start writing about
> 200 MB/s to the NVMe drive.
>
> $ trace-cmd record -e btrfs:defrag_*

You can go without using trace-cmd, and use sysfs interface directly.
(That's why sometimes trace-cmd is over-complicating things)

This would not only reduce the size of the file, but also provide a
readable result directly (all need root privilege)

cd /sys/kernel/debug/tracing

## To disable and clear current trace buffer and events

echo 0 > tracing_on
echo > trace
echo > set_event

## Reduce per-cpu buffer size in KB, if you don't want a too large
## event buffer

echo 64 > buffer_size_kb

## Enable those defrag events:

echo "btrfs:defrag_one_locked_range" >> set_event
echo "btrfs:defrag_add_target" >> set_event
echo "btrfs:defrag_file_start" >> set_event
echo "btrfs:defrag_file_end" >> set_event

## Enable trace

echo 1 > $tracedir/tracing_on

## After the consistent write happens, just copy the trace file

cp /sys/kernel/debug/tracing/trace /tmp/whatevername

Thanks,
Qu

>
> The size of the resulting trace.dat file is 4 GB.
>
> Please send me some instructions describing how to extract data
> relevant to the btrfs-autodefrag issue from the trace.dat file. I
> suppose you don't want the whole trace.dat file. Compressed
> trace.dat.zstd has size 324 MB.
>
> -Jan
>
