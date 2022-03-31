Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589D4ED11B
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 02:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352183AbiCaAzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 20:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352182AbiCaAzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 20:55:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6774D26118
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648688028;
        bh=2/re6fsTixoBhU/bNX5pDZcvyry3oufIK9S3JDMAyZ0=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=hQ9ilbpgDLOVOoqc29CAUmOcLr33Nc5Dd08yvNZRXBEdaIo0V/gjU0+snhSxUYcnn
         t++8WTgyJw8VKS1hRTxSH7WI/Ycg0lKLmzM2eSW7VJExwUOLhEBI5korwZNu5oPdKw
         KCdFoQ4ILcyEwEuygI9ScE6FsbZLTC5JC+f7FWNM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGhyS-1nnQBl3G4I-00DohH; Thu, 31
 Mar 2022 02:53:48 +0200
Message-ID: <144a9886-b273-ea80-72f3-e569026ccc01@gmx.com>
Date:   Thu, 31 Mar 2022 08:53:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220324160628.1572613-1-hch@lst.de>
 <20220324160628.1572613-2-hch@lst.de> <20220330144358.GF2237@twin.jikos.cz>
 <bcb7b671-6c82-1914-7442-a96fcc460b71@gmx.com>
 <a2973c8d-0c8b-368f-1733-b4326eed121c@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: fix direct I/O read repair for split bios
In-Reply-To: <a2973c8d-0c8b-368f-1733-b4326eed121c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZvxU45dnWywJpY0pToE0otYKWCQvj/jSQfjUUN4pefZNzYMvjXG
 cZ/zDRF7nrz1XaxzimVgKMEskwOuiidh1XKFl0pzNKv4SltBONBYnNdH7YVx+DvbkJZjASN
 jN5sy5flrC2hxX5B2tXeCeA1GRV4w3ios30PVHdoMc/Y0TVktzt4ROfzF+wTMdWqFnJ2WYU
 PC9VyzqBzZCPY9Cxmo6DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7cXNLKKhXY=:zsRQlbU7o80jFNVp17J9kX
 HjF/EViVJRXuvE/6P7BPDYMHePoa+JsBgeTOfo189K+Z9TZatot7SQ5keaJjfpaRfSmJ1U1Z2
 D9on6bZACL8ak8PCrUHsYwjXFk9hVg4nrJf3BHHytbKzgGjBowDt5uRHGVOj748FccF/iA9Sn
 3zBvCMieFnH0hegEkQvhrMNNw8cnF6nB8NSLMygkONFD0ADlJhu00K+a1825+KrLtDJvb9luH
 MjONrn2m6nTEDBqOXNN7qZerHw/Qqhu9ZrJZ5sSCBvTl8065BMBeD52cJGGAt85q2gJOvufc7
 peLifWPf1tHHSEeVRmSPvB0JfD6p7xuKW5LhNdc/+8z3+5K9uyF5Nyuo0EoqMKVGcN2Hp1O6G
 YN3bPtJZDcqsYpT/l5BJphlwCZI++d+1pfgHyFO0Dr4vnl1z+ErHXoebJuugFal79TOymn3m/
 CJ8mUYm/iPpD9ZJX5pDXkILAInVanhH/0CVRySBCjgBrF8cHmZ5zvVcs/6+8h02ZesEeRBj9n
 ubL6+nqbtJbACKKK+iJKMVNZRCNMg+uoItXYCPv3NhQfv+eolYeuhzkR25DfR5shCCD3AgU6v
 QvBT0wXJ5qJxBxzfRUdVM1xzEUi9gDGbvBy6W9/TzsWPslzVaNCgUVmfFOcPipk7/u77HcM+C
 VnTFjDdvoQecaYKYTTh2aTkPxl99/08aFBXZQUSMnyZgfdhpVop1FuGOfA6ktak4/KpQxZ0WH
 1p05oukvcxhtwPnAb+tFZHKo0IQJdHBVqf0wijxMX3sdTgtjBGUDcUIufnH2ofDCx5AdodvvC
 LvehcluMUJ3XCrnQjM3e2YAjDPO03z1KiChUxEqhcPi+GX/ymxvtFa3j1ya36mnHrLFW6yY1H
 AGvi2BqxdNM+Y8hVi4r+8ogvEFQFLaQ7B01xkVq683QHk1UyTQ/9D4aFwfz0srS1pWtKYHX+0
 18mOFk9Gt413GN95tZemmiIhA47N18r/FGeQabiIogQoqrcrMcTqhtx7mWA7WCwJDSP6AKbB8
 hvjKtVemPvJqFVRJ2fQMxmwvTUSaknfTVQChTxkypu0E7c3vmtkPMfcEsb+njLPofPr6t7ToP
 d0xivTM9sfPhEU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/31 07:14, Qu Wenruo wrote:
>
>
> On 2022/3/31 06:24, Qu Wenruo wrote:
>>
>>
>> On 2022/3/30 22:43, David Sterba wrote:
>>> On Thu, Mar 24, 2022 at 05:06:27PM +0100, Christoph Hellwig wrote:
>>>> When a bio is split in btrfs_submit_direct, dip->file_offset contains
>>>> the file offset for the first bio.=C2=A0 But this means the start val=
ue used
>>>> in btrfs_check_read_dio_bio is incorrect for subsequent bios.=C2=A0 A=
dd
>>>> a file_offset field to struct btrfs_bio to pass along the correct
>>>> offset.
>>>>
>>>> Given that check_data_csum only uses start of an error message this
>>>> means problems with this miscalculation will only show up when I/O
>>>> fails or checksums mismatch.
>>>>
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Qu, you've removed the same logic in f4f39fc5dc30 ("btrfs: remove
>>> btrfs_bio::logical member") where it was a different name for the same
>>> variable. What changed in the logic that we don't need to store it alo=
ng
>>> the btrfs_bio and that btrfs_dio_private can't provide anymore?
>>
>> All my fault, I didn't realize that in btrfs_submit_direct() what we
>> really do is splitting the iomap bio.
>>
>> Thus we still need that @logical member as dip is only allocated for th=
e
>> whole iomap bio, not for each split btrfs bio.
>>
>> Thus we need the fixes: tag.
>>
>>>
>>> I'm a bit worried about your changes that remove/rewrite code, silentl=
y
>>> introducing bugs so it has to be reinstated. We don't have enough
>>> review coverage and in the amount of patches you send I'm increasingly
>>> worried how many bugs I've inadvertently let in.
>>
>> Normally it should be caught by test cases. But test case coverage is
>> not that better than our review coverage, especially for read repair, a=
s
>> it's a btrfs specific feature, and almost impossible to do stress tests=
.
>>
>> The good news is, for most of my subpage related rewrite, the existing
>> test cases are pretty good catching the bugs.
>>
>>
>> I don't really have better way other than adding regression tests cases
>> until we found some regression.
>
> While crafting the test case for this particular case, I found all the
> existing tools, like dd (iflag=3Ddirect) or xfs_io (pwrite -d -i), are a=
ll
> reading the content using 4K block, even block size is specified.
>
> Thus unable to reproduce the bug (no split will happen).
>
> Any good tool to cause a large direct IO read?

OK, all these tools (including a new md5sum_direct I crafted) are
working as expected.

The always sectorsized read is from btrfs, not those tools.

In btrfs_dio_iomap_begin(), if the operation is read, we always limit
the size to sectorsize:

	if (!write)
		len =3D min_t(u64, len, fs_info->sectorsize);

This behavior saved my ass, as all our direct read will only cause one
single sector, thus it will never be split, thus read repair will never
need to both the dip->file_offset mismatch.

Furthermore, write path doesn't need to bother file offset in the split
bio anyway.

So no fixes: tag is needed, I am saved by a weird behavior there.

Thanks,
Qu



>
> Thanks,
> Qu
>
>>
>> Thanks,
>> Qu
