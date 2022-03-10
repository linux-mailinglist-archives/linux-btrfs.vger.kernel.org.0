Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698A4D414D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 07:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiCJGnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 01:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiCJGnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 01:43:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FE55F90
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 22:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646894558;
        bh=HyJvFgJyMCaDRw0K4cp2ZDB4rSuB8j7zZNu8TQ9LSkw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kiDg5okG6Wyf4oGIn9M65yDDWJ2RL7diTDF4m1HD57+20lkLPMu0xvu27Woe8OSkm
         oyxyQgRvzSXWzE2OLBs6iHWLazT3UMNFqAK03EAouz4ueUORkxk0BtEJYuE7ccngE1
         h+Y3ewYL7gqmZcjLKQwcUKfPzHihVeL3iiaUz/hM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiHl-1nnPiE1ohr-00QA9E; Thu, 10
 Mar 2022 07:42:38 +0100
Message-ID: <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
Date:   Thu, 10 Mar 2022 14:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gQTpqhuSDT7YI/icrSTQyDdRzSpmf44ZcmZuxCFdYNfg/+CBk2/
 zQ5wHlI7UzFXYcdWmZlXzU93IaPhFq76zsODmqKzhKy4ixvpwx0B/L/B4WQGTPcHl0e51cC
 Lu/kzl6XyKgve4gsRmq2Hu0QGFPRzZdc5vP4XBZaHQinp67vVrjaO356rVj/qk7TITpk1uG
 KyFAg09X31WeZtTHsw/5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jYAdEEBpITI=:5wj1Zei+TyOwyZsccVKqHA
 MQaPUF0/rhzqls28Yd5f0uEWbZ8gYFvasmVH4ikTsVB3sSKS+JBJxAfVul5dJD6g5GWoc5Np+
 2ECVwIRX4lutv43qQo/k/LeXtHoHx6sgfKMOVWBnoB+sjxnK/Rb+4/P5DITVZNo+jY2AAHye4
 GAGcA74nZ/qOIbXDs/LXluYQrDtXM8WXJtTVWKRqEpMvTPkGfuKF8JzXtUYuCGdOaLe+YqKPK
 V4WOlvbBR0BpX40d/GoHydrYsea4e77HRBS4wA6WzcnTIY40YGd+2Xwh3KkmwOHuVk6uqZGjP
 k33yx7X9RPgs4OqCJxTNoAK7bRBwZj5ngICGQc9fWjpmJmFFVsbgBd+eYUuzGgsSjJa69/E3z
 OuIjlngumishxqeeWwDHUZaocvdj1B5PUGmJ08W/7MHTss302FgXLXljDjQCY2ZG+sWw8VyfL
 coMp/Tahd/4DMUtqFs6gdiAa3BsslqTu8rJwlS5a0MN2V+mqh3RD7cTyCwsp14OZV3hDXrbYp
 geqx4yD3K2bFEdX3fWRMKFRtjJq03xtL2TQgHUmyrLdy8hyQydD7jZGeLShx+WLhNEDgYNYGn
 KZpQXNwl8nvxGaY8dgCxZJX/u/Ls+M8ovZNRGF9M6jfEjQZqGBKxB3Sls3/DC6UQZwhepZPpW
 Ex3tYkuEPlBnxdNs/waLPvQBNszn0YElpU9qf6HGVJsz4D2L1XEFnMPGq4HplSlrc4W08k44Y
 xEweBW6thW5Ym6TVkIWqpvrVE4dvI6dzcTWva4pVA4Zdu8Wvq2uVvYnQpHufVlK/f2MgQramS
 8xBAqhHX6BQib9bRWtiEBMb6uK2CzSY21dUnQ2YdWR7CeI8k/lPqQX6oFcRVjP1AFSH5EziCe
 T2fWj7SxBBkQjS2zy1Ve9g7rktIIzGRMqeBgdzoNKabEEh0/bce7rWGnVAUQTts5pSFu/NgL1
 z2iuBwuC02AjML7W7m+E619QvFsL0sbCBMkQ0S3CAY/0abrpJ6eDq4rKSdPSDmgso/kDmPuEd
 dmqYxDr08o0nNbDR2mzrUAgT3kpHGWRFFCwXgEAMdZodXtuS3L5dDzuOP9YzL8ujbgCubx1g9
 4JSSrIo1MnnSmQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/10 12:33, Jan Ziak wrote:
> On Thu, Mar 10, 2022 at 2:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>> ## Enable trace
>>
>> echo 1 > $tracedir/tracing_on
>>
>> ## After the consistent write happens, just copy the trace file
>>
>> cp /sys/kernel/debug/tracing/trace /tmp/whatevername
>
> The compressed trace is attached to this email. Inode 307273 is the
> 40GB sqlite file, it currently has 1689020 extents. This time, it took
> about 3 hours after "mount / -o remount,autodefrag" for the issue to
> start manifesting itself.

Sorry, considering your sqlite file is so large, there are too many
defrag_one_locked_range() and defrag_add_target() calls.

And the buffer size is a little too small.

Mind to re-take the trace with the following commands?
(No need to reboot, it takes effect immediate)

cd /sys/kernel/debug/tracing
echo 0 > tracing_on
echo > trace
echo > set_event
echo 65536 > buffer_size_kb
echo "btrfs:defrag_file_start" >> set_event
echo "btrfs:defrag_file_end" >> set_event
echo 1 > $tracedir/tracing_on

## After the consistent write happens, just copy the trace file

cp /sys/kernel/debug/tracing/trace /tmp/whatevername

Thanks,
Qu
>
> -Jan
