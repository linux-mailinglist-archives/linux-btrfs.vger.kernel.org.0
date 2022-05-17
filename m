Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B9529F99
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbiEQKhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbiEQKhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 06:37:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B214B431
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 03:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652783822;
        bh=j31AlwbxoJE+WoukyIta+c12ZTyL7f6F8QhVPaEDXA0=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=jNB16f1habQVGoZe293HmUriyOo537u8KvKGLliVlHXXnwE4OHEMCgElUr4VNOKNB
         5NgDCJk1UgkNJjFpPca+x8ej1Yrs7AtntX0OEMqYcwIX+StgWCq551gz2yHD48Dr3K
         3yBZT5VtrVLjSRaLXHcsRyUk3jjE8W6IcrkLH0os=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7K3Y-1nyabx0MW4-007ohH; Tue, 17
 May 2022 12:37:01 +0200
Message-ID: <4174cbc9-6321-4055-6824-a43f7d222846@gmx.com>
Date:   Tue, 17 May 2022 18:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651770555.git.fdmanana@suse.com>
 <41782eb393b3a3ba47f4a7fce1cbb33433c3f994.1651770555.git.fdmanana@suse.com>
 <50994099-b70e-8307-dd41-ac88784e552c@gmx.com>
 <8ded3794-1a2e-605e-e01a-6c2ecbab1b7e@gmx.com>
 <20220517093906.GA2606208@falcondesktop>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 2/2] btrfs: send: avoid trashing the page cache
In-Reply-To: <20220517093906.GA2606208@falcondesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+MDHBClKqt84TodVT6uP2dm3rO2HGGD9ZewWfbZtcmMRBsPHRoM
 5SmK6pKuAK6BzT8qUVWYrc/FZHsYf/Ws95NsLb/sY15cATev3hZqIv0oinY6CMVggAzgfY+
 8FC7AMSxZ4UxdYikC+brrVnKx2ON0mzjH4M7LhVTKlQenHHiarSNb0ZLuHAzRF3wgZCZ14b
 z/6Y0mh2UWvNceztDOd+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JfevhrBNhB0=:PzTT0K/AQz8GS/RmnBV1Fo
 lACn8278/zBoJM1md9CJF2KZF7GFPLKLsmdOlM+Wq000U4fwSQKly/WeIeqmWJAkfkyNUQW1o
 /wIQ+uJNIIu2T0poTCqyjxClF0S/NLCXF04mYZ0pWLAf9VLiK0mWxV25bpyUtTxcNQxgQ3Gvw
 EvP7lM764XsT3JMqjcmcIn2Cwg42TSzQbHOpYOaPOfLHJPBkBIrlLhISYvf3SvZzQVc7EalGp
 O7CCmirq0NLlX+WccRguZfpI39J1SvrzEn5f81q6xDY4/M5Z3MZ1n/deZPqWQPmOc4JQl80kN
 7KIbrhuEDg1TasMA7qpqSiqFRUCV/LcplJBqxO98iDM5dwVEgznPsnQTqrNLGTJpTNwl1HKlI
 q+zKUxcll0QX3ExHQxCxwG3rf3xXjZiLpV0L6/NdO75swp6gGLZFLWp+dyYn2yVjfKAeHnC8s
 5rnkPudNNomGqmgHSl1+Bdn5O11kib65nBKh/PhlULImgtTY/rW5e+4jz75Yel6QAKFuQG6lY
 JYqFisoJ0Nd5JieBRlcUDqJsy5VyQwlhFkWGjSXGDlR6aG2jpBeGXw5d/M/NrAuDmI777EQlR
 QyYuQdqO7a6jYUhgOtNLjQ//FLkyRuvxIurDJheZf2b3EEEEJDAj8Lwjzn8L5U5UAAiYwn+un
 K+ydMETlffOBqiP46zmu3ZQ4wFpZWfJrPct1fbkpFEZPcngq5eCx7UhdNIP0HefswttRoU3yl
 Iz8j0XivWb8QNAxTwOU0HyFc/lVERiRS76vG6BX6pc4di/+DEPMx5ezGc7pCtTxBNSVo/FbDR
 +6no6chXsyCf0dGreDLzJcDnT2bTzDktEwVWZFaHFvI62li7ykZBk+uqLOrvfoqepD7Q2WxcC
 tyGzWO1fkGYjL4si2rxLIW+9xmzVKc62RWiD5SuEfEuVHoJdyGpQ2pc0U8igJcQVA8QDq9ta7
 DHJ7ric4e4cT9Ty//SdpQJomp/oaYashiNYyCuZBHGJDUwGGi/lDm2rAmjgc6rHuBZs+++7jw
 GeF2qhvX/N1rG/bLEuUbm+BxhCEMu32PgeG3ruTdR+T6LReZ1SuF9jxhk8l1uopdxbVAXD6Vz
 fmSb7toYKPlppw=
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 17:39, Filipe Manana wrote:
> On Tue, May 17, 2022 at 03:26:14PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/5/17 14:35, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/5/6 01:16, fdmanana@kernel.org wrote:
>>>> From: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> A send operation reads extent data using the buffered IO path for get=
ting
>>>> extent data to send in write commands and this is both because it's
>>>> simple
>>>> and to make use of the generic readahead infrastructure, which result=
s in
>>>> a massive speedup.
>>>>
>>>> However this fills the page cache with data that, most of the time, i=
s
>>>> really only used by the send operation - once the write commands are
>>>> sent,
>>>> it's not useful to have the data in the page cache anymore. For large
>>>> snapshots, bringing all data into the page cache eventually leads to =
the
>>>> need to evict other data from the page cache that may be more useful =
for
>>>> applications (and kernel susbsystems).
>>>>
>>>> Even if extents are shared with the subvolume on which a snapshot is
>>>> based
>>>> on and the data is currently on the page cache due to being read thro=
ugh
>>>> the subvolume, attempting to read the data through the snapshot will
>>>> always result in bringing a new copy of the data into another locatio=
n in
>>>> the page cache (there's currently no shared memory for shared extents=
).
>>>>
>>>> So make send evict the data it has read before if when it first opene=
d
>>>> the inode, its mapping had no pages currently loaded: when
>>>> inode->i_mapping->nr_pages has a value of 0. Do this instead of decid=
ing
>>>> based on the return value of filemap_range_has_page() before reading =
an
>>>> extent because the generic readahead mechanism may read pages beyond =
the
>>>> range we request (and it very often does it), which means a call to
>>>> filemap_range_has_page() will return true due to the readahead that w=
as
>>>> triggered when processing a previous extent - we don't have a simple =
way
>>>> to distinguish this case from the case where the data was brought int=
o
>>>> the page cache through someone else. So checking for the mapping numb=
er
>>>> of pages being 0 when we first open the inode is simple, cheap and it
>>>> generally accomplishes the goal of not trashing the page cache - the
>>>> only exception is if part of data was previously loaded into the page
>>>> cache through the snapshot by some other process, in that case we end
>>>> up not evicting any data send brings into the page cache, just like
>>>> before this change - but that however is not the common case.
>>>>
>>>> Example scenario, on a box with 32G of RAM:
>>>>
>>>>  =C2=A0=C2=A0 $ btrfs subvolume create /mnt/sv1
>>>>  =C2=A0=C2=A0 $ xfs_io -f -c "pwrite 0 4G" /mnt/sv1/file1
>>>>
>>>>  =C2=A0=C2=A0 $ btrfs subvolume snapshot -r /mnt/sv1 /mnt/snap1
>>>>
>>>>  =C2=A0=C2=A0 $ free -m
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 used=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 shared
>>>> buff/cache=C2=A0=C2=A0 available
>>>>  =C2=A0=C2=A0 Mem:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 31937=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 186=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26866=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>> 4883=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31297
>>>>  =C2=A0=C2=A0 Swap:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8188=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8188
>>>>
>>>>  =C2=A0=C2=A0 # After this we get less 4G of free memory.
>>>>  =C2=A0=C2=A0 $ btrfs send /mnt/snap1 >/dev/null
>>>>
>>>>  =C2=A0=C2=A0 $ free -m
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 used=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 shared
>>>> buff/cache=C2=A0=C2=A0 available
>>>>  =C2=A0=C2=A0 Mem:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 31937=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 186=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22814=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>> 8935=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31297
>>>>  =C2=A0=C2=A0 Swap:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8188=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8188
>>>>
>>>> The same, obviously, applies to an incremental send.
>>>>
>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>>
>>> Unfortunately, this patch seems to cause subpage cases to fail test ca=
se
>>> btrfs/007, the reproducibility is around 50%, thus better "-I 8" to be
>>> extra safe.
>>>
>>> And I believe it also causes other send related failure for subpage ca=
ses.
>>>
>>> I guess it's truncate_inode_pages_range() only truncating the full pag=
e,
>>> but for subpage case, since one sector is smaller than one page, it
>>> doesn't work as expected?
>>
>> It looks like that's the case.
>>
>> The following diff fixed the send related bugs here:
>> (mail client seems to screw up the indent)
>>
>> https://paste.opensuse.org/95871661
>
> That may seem to work often, but it's not really correct because prev_ex=
tent_end
> is already aligned to the page size, except possibly for the first exten=
t processed.

You're right, my snippet is really just a dirty hack.

>
> For the case of the first processed extent not starting at an offset tha=
t is page
> size aligned, we also need to round down that offset so that we evict th=
e page
> (and not simply zero out part of its content).
>
> Can you try this instead:  https://pastebin.com/raw/kRPZKYxG ?

Tested with btrfs/007 and it passed without problems (8 runs).

Also tested it with the full send group, no regression found here.


And with his fix, the following subpage failures now all pass.

- btrfs/007
- btrfs/016
- btrfs/025
- btrfs/034
- btrfs/097
- btrfs/149
- btrfs/252

Thanks,
Qu

>
> Thanks.
>
>
>>
>> Thanks,
>> Qu
>>>
>>> If needed, I can provide you the access to my aarch64 vm for debugging=
.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> ---
>>>>  =C2=A0 fs/btrfs/send.c | 80 ++++++++++++++++++++++++++++++++++++++++=
+++++++--
>>>>  =C2=A0 1 file changed, 77 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>>> index 55275ba90cb4..d899049dea53 100644
>>>> --- a/fs/btrfs/send.c
>>>> +++ b/fs/btrfs/send.c
>>>> @@ -137,6 +137,8 @@ struct send_ctx {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode *cur_inode;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file_ra_state ra;
>>>> +=C2=A0=C2=A0=C2=A0 u64 prev_extent_end;
>>>> +=C2=A0=C2=A0=C2=A0 bool clean_page_cache;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We process inodes by their in=
creasing order, so if before an
>>>> @@ -5157,6 +5159,28 @@ static int send_extent_data(struct send_ctx *s=
ctx,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&sctx-=
>ra, 0, sizeof(struct file_ra_state));
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_ra_state=
_init(&sctx->ra, sctx->cur_inode->i_mapping);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It's very likely =
there are no pages from this inode in
>>>> the page
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cache, so after r=
eading extents and sending their data,
>>>> we clean
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the page cache to=
 avoid trashing the page cache (adding
>>>> pressure
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to the page cache=
 and forcing eviction of other data
>>>> more useful
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for applications)=
.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We decide if we s=
hould clean the page cache simply by
>>>> checking
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if the inode's ma=
pping nrpages is 0 when we first open
>>>> it, and
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not by using some=
thing like filemap_range_has_page() before
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reading an extent=
 because when we ask the readahead code to
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * read a given file=
 range, it may (and almost always does) read
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pages from beyond=
 that range (see the documentation for
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * page_cache_sync_r=
eadahead()), so it would not be reliable,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * because after rea=
ding the first extent future calls to
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * filemap_range_has=
_page() would return true because the
>>>> readahead
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * on the previous e=
xtent resulted in reading pages of the
>>>> current
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * extent as well.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sctx->clean_page_cache =
=3D
>>>> (sctx->cur_inode->i_mapping->nrpages =3D=3D 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sctx->prev_extent_end =3D=
 offset;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (sent < len) {
>>>> @@ -5168,6 +5192,33 @@ static int send_extent_data(struct send_ctx *s=
ctx,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sent +=3D siz=
e;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (sctx->clean_page_cache) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u64 end =3D round_u=
p(offset + len, PAGE_SIZE);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Always start from=
 the end offset of the last processed
>>>> extent.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is because t=
he readahead code may (and very often does)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reads pages beyon=
d the range we request for readahead. So if
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we have an extent=
 layout like this:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ extent A ] [ extent B ]=
 [ extent C ]
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When we ask page_=
cache_sync_readahead() to read extent A, it
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * may also trigger =
reads for pages of extent B. If we are doing
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * an incremental se=
nd and extent B has not changed between the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * parent and send s=
napshots, some or all of its pages may end
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * up being read and=
 placed in the page cache. So when
>>>> truncating
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the page cache we=
 always start from the end offset of the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * previously proces=
sed extent up to the end of the current
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * extent.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 truncate_inode_pages_rang=
e(&sctx->cur_inode->i_data,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sctx->p=
rev_extent_end,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end - 1=
);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sctx->prev_extent_end =3D=
 end;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>  =C2=A0 }
>>>>
>>>> @@ -6172,6 +6223,30 @@ static int btrfs_unlink_all_paths(struct
>>>> send_ctx *sctx)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 }
>>>>
>>>> +static void close_current_inode(struct send_ctx *sctx)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 u64 i_size;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (sctx->cur_inode =3D=3D NULL)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 i_size =3D i_size_read(sctx->cur_inode);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If we are doing an incremental send, we m=
ay have extents
>>>> between the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * last processed extent and the i_size that=
 have not been processed
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * because they haven't changed but we may h=
ave read some of
>>>> their pages
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * through readahead, see the comments at se=
nd_extent_data().
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (sctx->clean_page_cache && sctx->prev_extent_e=
nd < i_size)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 truncate_inode_pages_rang=
e(&sctx->cur_inode->i_data,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sctx->p=
rev_extent_end,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 round_u=
p(i_size, PAGE_SIZE) - 1);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 iput(sctx->cur_inode);
>>>> +=C2=A0=C2=A0=C2=A0 sctx->cur_inode =3D NULL;
>>>> +}
>>>> +
>>>>  =C2=A0 static int changed_inode(struct send_ctx *sctx,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enum btrfs_compare_tree_result result)
>>>>  =C2=A0 {
>>>> @@ -6182,8 +6257,7 @@ static int changed_inode(struct send_ctx *sctx,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 left_gen =3D 0;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 right_gen =3D 0;
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 iput(sctx->cur_inode);
>>>> -=C2=A0=C2=A0=C2=A0 sctx->cur_inode =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 close_current_inode(sctx);
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sctx->cur_ino =3D key->objectid;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sctx->cur_inode_new_gen =3D 0;
>>>> @@ -7671,7 +7745,7 @@ long btrfs_ioctl_send(struct inode *inode,
>>>> struct btrfs_ioctl_send_args *arg)
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name_cache_fr=
ee(sctx);
>>>>
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iput(sctx->cur_inode);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close_current_inode(sctx)=
;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(sctx);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
