Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917464D555C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 00:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbiCJX3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 18:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiCJX3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 18:29:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACE45058
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646954876;
        bh=tqSrD7cCAWnZn050gNmwPfcUTDJiuL+DJwMs+qeQDIs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=CXyIImC9ij4HR59CfvLoF4BVvfd+iq+hl6pd5J0AQE4C0SG6UOfBT+iYc18Mvn8fI
         9V3hAopokyotptz+RAKJIqmJxU8GCOgHxfSrgK0IeMYVyrKVI7mx7DnmI/UErtaJJW
         ecLZ5NuvHWGXlLKCkXybN1H2SQiIn/VbR8Y8FLjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwfai-1oKqIL1f9G-00yCuS; Fri, 11
 Mar 2022 00:27:56 +0100
Message-ID: <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
Date:   Fri, 11 Mar 2022 07:27:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
 <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
In-Reply-To: <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/kIlhi9U5Fqf8o0S+Ub9KDwEM+ArjAcRrWQ0FfwSeEKYG7/s5ef
 9PMnQANMuzOCRtC+zO9PgaZPaL1Hwt1ze3u81S7Omwb7qXzMNEkWsD0OQUh/inMkzjUpeoP
 dOa2CG6iNMOkVYcjVmtymC7mWV+KyVHKJechT/C4BS9tkdKsysC3JENhRxyJLjzRs2PnB10
 zvbdh5JQFD7mnkRom7hCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K4tp0U7bJTM=:9zvUe8MsPTTbWwIn4MtVqt
 kw0KZKpflf6wzmbroUJTIqTQbFYnVnIGeXiJKO92esJsSeXk05jzeSLIAR+PCuuc4MeMEDq2Q
 DEIoleVe/+d3+x11JXtaz69dsgujJVGT+4Z+/zeiXhnxqSxMQsOymamTX/Hss1tsSZL9zIIFR
 gDzeAd0V7cXQW5+fOhzoFLXaTa0LpCdaxHixcyzomBP43rBxBAte+fYrTOHubM+uSXiGij5zX
 gbchdj+UrhNevSttDkbVdzQJAE+r7OauB56Ao0pIi3ST3Emza82YTxzzEPa1zcdK20yrAjotA
 J07cUk4PJ1p6WGgRfIWCfL7QJH04d1VwCVGgzoXP/SEBOpbUfJPnKcYlzsESaec0OkPo28tqt
 ZmtdiCW+RaunTeN1DwYkVMNxLJ52dAhMNv0ZAFB79v8FiFB+knYSPp2+929ET/W5gXi2QTRHK
 HT8oiM0WA1ck36Zbu0cef8V4bxFn7O+oME4Y6jbgbQfUHAfF8fzapcFYmzjFqbRXYWRSu/Eur
 +bYZLWTvRodZ04agJOm5cFayteTwQdxtLyapN72mttNcVmcolNRmgQix+eHCvHy9KNcmQZv1C
 Vr6Kerh3cLuqEf7a+Nb1j7nLyHsDXx2aDvfTsQQLxjauZT4gipjhlHet/rCMUtFNz43uuwlXy
 0e3fG15xPOFhYj0K0S9lqLi/QsmdznSdHZdDCyRjmV7gB2dpxTZe5bcQSNEkYqD1EDUapxOa3
 auC1x+r4rbSijGRc6k0WO6OnW9CifT6aKJMSvG5RDwpgIbOl2v/mr4FhmAespajNoKF0Nckra
 nvBSo8pbostI2I00qziX0zQzQmaGj1u4EIOzTYNRIwvHk5a10U+bVufPB0Tn2u/3GzOzlaJvX
 RAYQsTsUUmwVTcp0xIj8L0G1XUtpOvRpiRwlRdDc/J9LWXLxlBhRGWMSIjs+i4D2+WqXAl7wR
 vp524KjSbnUtyGHQe4dyQHwpa2MvO1cSa2MSDLmgZ8h5iDplQKCZfDEGpuxnWLEzF4oq/r6ba
 jKPoi2NtF1IsyLUnSLj4hGFc8P5rl5AXXOuXSDBt2lxQeR7QMtib2pEZ0VHkxbQaLNy6s/JaZ
 Zl92bCB3F6huJM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/11 05:31, Jan Ziak wrote:
> On Thu, Mar 10, 2022 at 7:42 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>> The compressed trace is attached to this email. Inode 307273 is the
>>> 40GB sqlite file, it currently has 1689020 extents. This time, it took
>>> about 3 hours after "mount / -o remount,autodefrag" for the issue to
>>> start manifesting itself.
>>
>> Sorry, considering your sqlite file is so large, there are too many
>> defrag_one_locked_range() and defrag_add_target() calls.
>>
>> And the buffer size is a little too small.
>>
>> Mind to re-take the trace with the following commands?
>
> The compressed trace (size: 1.8 MB) can be downloaded from
> http://atom-symbol.net/f/2022-03-10/btrfs-autodefrag-trace.txt.zst
>
> According to compsize:
>
> - inode 307273, at the start of the trace: 1783756 regular extents
> (3045856 refs), 0 inline
>
> - inode 307273, at the end of the trace: 1787794 regular extents
> (3054334 refs), 0 inline
>
> - inode 307273, delta: +4038 regular extents (+8478 refs)

The trace results shows a pattern in the beginning, that around every
30s, autodefrag scans that inode once:

  67292.784930: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42705735680 extent_thresh=3D65536
  67323.655798: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42706268160 extent_thresh=3D65536
  67354.126797: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42706268160 extent_thresh=3D65536
  67358.865643: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42706268160 extent_thresh=3D65536
  67385.190417: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42706554880 extent_thresh=3D65536
  67415.960153: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42706554880 extent_thresh=3D65536
  67446.798930: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42707038208 extent_thresh=3D65536

This part is the expected behavior.

But very soon, the autodefrag is scanning the file again and again in a
very short time:

  69188.802624: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42720563200 extent_thresh=3D65536
  69189.235753: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42720563200 extent_thresh=3D65536
  69189.896309: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42720563200 extent_thresh=3D65536
  69190.594834: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42720563200 extent_thresh=3D65536
  69191.185359: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42720563200 extent_thresh=3D65536
  69191.543833: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42720563200 extent_thresh=3D65536
  69192.275865: defrag_file_start: root=3D5 ino=3D307273 start=3D0
len=3D42720563200 extent_thresh=3D65536

That inode get defragged 7 times in just 5 seconds.
There are more similar patterns for the same inode.

The unexpected behavior is the same reported by another reporter.
(https://github.com/btrfs/linux/issues/423#issuecomment-1062338536)

Thus this patch should resolve the repeated defrag behavior:
https://patchwork.kernel.org/project/linux-btrfs/patch/318a1bcdabdd1218d63=
1ddb1a6fe1b9ca3b6b529.1646782687.git.wqu@suse.com/

Mind to give it a try?

>
> Approximately 85% of lines in the trace are related to the mentioned
> inode, which means that btrfs-autodefrag is trying to defragment the
> file. The main issue, in my opinion, is that the number of extents
> increased by 4038 despite btrfs's defragmentation attempts.

Well, this is a trade-off between the effectiveness of defrag and IO.

Previously we have a larger extent threshold for autodefrag (256K vs 64K
now).
However that larger threshold will cause even more IO.

In the near future (hopefully v5.19), we will introduce more fine tuning
for autodefrag (allowing users to specify the autodefrag interval, and
target extent threshold).

Thanks,
Qu

>
> -Jan
