Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163C14CEFAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 03:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiCGCkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 21:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiCGCkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 21:40:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD71DA4A
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 18:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646620758;
        bh=iIgEFUxj9r9fhgsrt1Hcq50hyZKPHwm8zp4CXupcnlU=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=bmzdrRP/JmCXYUhrvDfIfKsuQ9MZ2JyEkqIRRzaHoGgdeQw8s/xt0HAogKCt7awzP
         tJhWn4Fg0ALCtLfacx83iPEQ6e38iuskMJ4GKTpDDae/eiJqPUnEFNOqGjcW0eoihA
         YmAJ4GDj3X4EqatCk+uMDa0A+U5NGTU1u4/rkQ8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiaY9-1o3x7y4AEh-00fiC3; Mon, 07
 Mar 2022 03:39:18 +0100
Message-ID: <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
Date:   Mon, 7 Mar 2022 10:39:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
In-Reply-To: <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prndpclWy5QSW9lQzRrk26oq9BBpjW4sovhDpx+QP6UQi9pZlaH
 mpGSO/isVGx3I1NYk94xrctlVBqvpW+CZL3gjDQfnczKPrxYiy5gv2EP2Xmv5gEdj7CL2Dj
 KokcMXwSQbsvIdU5wDIr1SQy4sXZh0pcWRR6IcPSF0j2PfQWILf7V8QwbTVdrJXshJxB9BM
 QCbDOagN46HllSSaToDdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dcJh7ErCUIE=:oQrcc8MyEnDBmsyxmRxU3L
 eIBzzbX4APOM7d5O0yDszgQfKPM3FmRZsxw62FPnFDD2flnxA5ifzr6rxha8X8VnqClW1qXiW
 Ov9rT3lRXy6ObvwtkYPp2DZxZWo7gEszHzqbN2GDllu/CIVn+s1D3Nt/pauiCiODv3GPHKry0
 VmNlRls8KgviKoLVwbjThEOEx0MA2Eg8KWOzZeLivDtgkVKeWoS2+NYvBbF+UNa/dlvaj2reo
 I5zOf3KNa2K4vjCI6MywlnMpM9KuDnFALv3kq9Hod7/QnXQvQU2XsuZaYc8Ljx+6lZGxKCx5a
 yG/odRnRm/wezFpSRqlddC80sxiZstzqNQn55CFTF55hcZp2Z8DXz8s1rJOo72Lcdp3uQwiaa
 xOvYW6RpVZuyhB9WqgoDcaVISgdHbf/WrotSGtwtGo1A2Y3Zmu2PFgpgFohvpJsydaMCfS8dZ
 VSQb59WlHJZBC3vic6MH8MjKAZtbZvuzYf4Jy6foBo1b8XjBYtA5oIKxrbCJa6oteo41R9GfO
 NYyzCELXGAfjEH9FTRABsmzM6gw8sJIuyvN8y+pa3if1U+wA8n/8w//IFMm0gijP9rcy6qdGD
 TXutprWGHN+GKZyBr0aFIHBSeNSYSLP5PaCgr3/w4EfXZXsvSdl7nNdaH764JCXONspM2WtPd
 gXUsiDWMmjnklByV39WQ/KdyXEbkDR5KOs1jwGVYrK5+pfyD3kqDODbAK+9GXhn8pYGP1pLC+
 b+jtw+uAQhn2FVqS+kntVrFJyZWXSfJVsJ7FUOLvpm8b5tdh5YjJzdEVVUCJwD3flpCdN3S46
 xrXcUqNvvPj4NihQFajQRz6XNcPzk02RtKn4leTjBrvEQza6Qs+mQo+BCCjCB20EGXCIPcJxN
 jChAhdEX+zkuvUpQWQpQoy421B8LPacIOmstyY3MCxmoxtUDd/05my/L4nLbjob2u3Ia4qmGT
 xPU259hWHYP5cXb6Nkf0KrSknFrNYDcghI4PeDLUGRVlR2vXqbpfPlkyROzLhLIHG92ikgilM
 DVGsH6xcNH+RudFa3WwdzWJJML30tnswyr1JV4srFYL5Ybg985Bw6tICwUZuQY375jBKb90jB
 yt5dVdXVnmeLHg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/7 10:23, Jan Ziak wrote:
> On Mon, Mar 7, 2022 at 1:48 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> On 2022/3/6 23:59, Jan Ziak wrote:
>>> I would like to report that btrfs in Linux kernel 5.16.12 mounted with
>>> the autodefrag option wrote 5TB in a single day to a 1TB SSD that is
>>> about 50% full.
>>>
>>> Defragmenting 0.5TB on a drive that is 50% full should write far less =
than 5TB.
>>
>> If using defrag ioctl, that's a good and solid expectation.
>>
>> Autodefrag will mark any file which got smaller writes (<64K) for scan.
>> For smaller extents than 64K, they will be re-dirtied for writeback.
>
> The NVMe device has 512-byte sectors, but has another namespace with
> 4K sectors. Will it help btrfs-autodefrag to reformat the drive to 4K
> sectors? I expect that it won't help - I am asking just in case my
> expectation is wrong.

The minimal sector size of btrfs is 4K, so I don't believe it would
cause any difference.

>
>> So in theory, if the cleaner is triggered very frequently to do
>> autodefrag, it can indeed easily amplify the writes.
>
> According to usr/bin/glances, the sqlite app is writing less than 1 MB
> per second to the NVMe device. btrfs's autodefrag write amplification
> is from the 1 MB/s to approximately 200 MB/s.

This is definitely something wrong.

Autodefrag by default should only get triggered every 300s, thus even
all new bytes are re-dirtied, it should only cause a less than 300M
write burst every 300s, not a consistent write.

>
>> Are you using commit=3D mount option? Which would reduce the commit
>> interval thus trigger autodefrag more frequently.
>
> I am not using commit=3D mount option.
>
>>> CPU utilization on an otherwise idle machine is approximately 600% all
>>> the time: btrfs-cleaner 100%, kworkers...btrfs 500%.
>>
>> The problem is why the CPU usage is at 100% for cleaner.
>>
>> Would you please apply this patch on your kernel?
>> https://patchwork.kernel.org/project/linux-btrfs/patch/bf2635d213e0c852=
51c4cd0391d8fbf274d7d637.1645705266.git.wqu@suse.com/
>>
>> Then enable the following trace events...
>
> I will try to apply the patch, collect the events and post the
> results. First, I will wait for the sqlite file to gain about 1
> million extents, which shouldn't take too long.

Thank you very much for the future trace events log.

That would be the determining data for us to solve it.

>
> ----
>
> BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
> (uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
> file-with-million-extents" doesn't finish even after several minutes
> of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
> ioctl syscalls per second - and appears to be slowing down as the
> value of the "fm_start" ioctl argument grows; e2fsprogs version
> 1.46.5). It would be nice if filefrag was faster than just a few
> ioctls per second.

This is mostly a race with autodefrag.

Both are using file extent map, thus if autodefrag is still trying to
redirty the file again and again, it would definitely cause problems for
anything also using file extent map.

Thanks,
Qu
>
> ----
>
> Sincerely
> Jan
