Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8337A529C6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbiEQI3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243562AbiEQI2i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:28:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29D48313
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652776106;
        bh=kyz3wbcTrIRX/ccdYhrrIQ+NV85wOBADocq/6uAYiJ0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Q9UoF/czbGibmMFEpYH2kMbdKxr2TfxR5roiWmewdG4K8TnMf8MWyQT5TNXg4kPGJ
         cfa0v2RMJqL+Uz+oQ/qBwbOSq/PelAORZkmsblla21Ww5M48WgUMf/En2SJIeY0FN8
         TJ1E1OeJZjBfyKyxVGG+saLtiQ3FA5CEJs9hEI4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3DJv-1nttMz3h1x-003gfM; Tue, 17
 May 2022 10:28:25 +0200
Message-ID: <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
Date:   Tue, 17 May 2022 16:28:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2wWrV+a+kb2/Ci3TE+VR3LaTQY5PPQ4XZOW5jUbiWf/7haQLs7z
 3fFkdbLG5xvV1BN445+NcQdoxTc644cf+/e3F7sbLJVTrFZZlNltO4DmtgAXERrLrjcpcwl
 kB7tvCNiTS3clxOj/g3NCsLtt/u8Pk+rWR5OrQivBmXtERvLpTfDPSCARhlYpB3jtuJz+UK
 X5cmDrZaPCTbj76k03f5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ayi30lZeJfw=:ghIILWML9MBiDUKRbe8ObN
 x7ewyihHblloHRnRltgUGKlSZFDR30zAQsIuEEO56Y/kZ7uw6A5ThDD6ZRJaS6GJto5mHWRqW
 ex2/KilqRG+1cJY2BSk0k8F/Zh6MZXSCDU7tWojRjrrRipfRTsuAzzhvtXrJpWDhgTjg3Q9Ai
 +DG0KHWrqTwaQbX98SQAWnp00o8xa9k3Xw3cOQaNcNBeyK7Wplr2w16XET0w62kILAiuOn9q+
 mDvCBfWN4d8FxgH5xrL3M0igTwJ+9N6+wIFgRtaLsnNbiU9uQ6yfzrwJc1kSpCzMoo6W36EGJ
 SpNF0yySl5yxWkDNPVHsQPkzkguwpO77bL+cEFkTQck1VHsXugGYCGWMfZNmpo7EOF8Wj7n+K
 /puCJE4zs0ZBORLgGGpKdqTUR3ALnUCvTBaLIEcfAu3Sr0dqF7cwIViE3TF8rxdplrqOmv/fE
 BqeWpz9T/PZ+fgYtTheOiUxLAPH/pM1Sc3nMyRl4yA0gIvnqO2Ce8+2jitxat8ZzaVLjMjHrv
 13UgYAHYWJ4+NQqOTxzifZlMabs7BH1A2R+IlNyG/D6LSpLpnBpEyWraeRq3f0RxExQ9rkmO7
 UOJiq/YVpl7IFHsz7rEQos5TO0qM04cvdpup8tAJveCWxosqBywaJgTM0xLIZ5U1sWpGTQAhK
 LmL5jOtet4GkAtmByKg7Q1VxeFg5dHKarSoFtFDhUBEQh46NgY+7V73R3oKngushNNJvdjawb
 Z2MfD9dU8E7Ip0h0UessVDttRPa+iLP+OAETwj+86KFdk4WG1RTLlNuJJI/36YQNLTU4y19k+
 LnE4+C2vCwf7R6DnLNPnnmXQwBCCnj0hssTtOwr0l+tYlIq7IgSu16TcS6FUMX4rCNQH5l3p1
 o0w0ePUMDuzVyfoAqgfhVrngj07bwUZYOtaXlqSYNTXxY6gTB8jGPGN5B63VGnl1H3E6WpG1d
 tZ8/XmkoiD0RpPIVgivxWSQZ1WuYRZJGn37o9vKM7apgPolV+sAplAnMiFjtnRBjXZSqkdUR0
 6wH28KTi7/OLZ8uyWKVNBqbTr652M7xgv1wUtgcTWE77h2UiY2nQWLlwjIUZ8s6pJ2JpWr9ot
 PLHkjmrWPM8XDc=
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 16:13, Johannes Thumshirn wrote:
> On 17/05/2022 10:10, Qu Wenruo wrote:
>>
>>
>> On 2022/5/16 22:31, Johannes Thumshirn wrote:
>>> If we're discovering a raid-stripe-tree on mount, read it from disk.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>    fs/btrfs/ctree.h           |  1 +
>>>    fs/btrfs/disk-io.c         | 12 ++++++++++++
>>>    include/uapi/linux/btrfs.h |  1 +
>>>    3 files changed, 14 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index 20aa2ebac7cd..1db669662f61 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -667,6 +667,7 @@ struct btrfs_fs_info {
>>>    	struct btrfs_root *uuid_root;
>>>    	struct btrfs_root *data_reloc_root;
>>>    	struct btrfs_root *block_group_root;
>>> +	struct btrfs_root *stripe_root;
>>>
>>>    	/* the log root tree is a directory of all the other log roots */
>>>    	struct btrfs_root *log_root_tree;
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index d456f426924c..c0f08917465a 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -1706,6 +1706,9 @@ static struct btrfs_root *btrfs_get_global_root(=
struct btrfs_fs_info *fs_info,
>>>
>>>    		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
>>>    	}
>>> +	if (objectid =3D=3D BTRFS_RAID_STRIPE_TREE_OBJECTID)
>>> +		return btrfs_grab_root(fs_info->stripe_root) ?
>>> +			fs_info->stripe_root : ERR_PTR(-ENOENT);
>>>    	return NULL;
>>>    }
>>>
>>> @@ -1784,6 +1787,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs=
_info)
>>>    	btrfs_put_root(fs_info->fs_root);
>>>    	btrfs_put_root(fs_info->data_reloc_root);
>>>    	btrfs_put_root(fs_info->block_group_root);
>>> +	btrfs_put_root(fs_info->stripe_root);
>>>    	btrfs_check_leaked_roots(fs_info);
>>>    	btrfs_extent_buffer_leak_debug_check(fs_info);
>>>    	kfree(fs_info->super_copy);
>>> @@ -2337,6 +2341,7 @@ static void free_root_pointers(struct btrfs_fs_i=
nfo *info, bool free_chunk_root)
>>>    	free_root_extent_buffers(info->fs_root);
>>>    	free_root_extent_buffers(info->data_reloc_root);
>>>    	free_root_extent_buffers(info->block_group_root);
>>> +	free_root_extent_buffers(info->stripe_root);
>>>    	if (free_chunk_root)
>>>    		free_root_extent_buffers(info->chunk_root);
>>>    }
>>> @@ -2773,6 +2778,13 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>>>    		fs_info->uuid_root =3D root;
>>>    	}
>>>
>>
>> I guess in the real patch, we need to check the incompatble feature fir=
st.
>
> Or at least a compatible_ro. For regular drives it should be sufficient,=
 for
> zoned drives mounting with raid without a stripe tree will fail.
>
>>
>> Another problem is, how do we do bootstrap?
>>
>> If our metadata (especially chunk tree) is also in some chunks which is
>> stripe-tree mapped, without stripe tree we're even unable to read the
>> chunk tree.
>>
>> Or do you plan to not support metadata on stripe-tree mapped chunks?
>
> I do, but I have no clue yet how to attack this problem. I was hoping to=
 get some
> insights from Josef's extent-tree v2 series.

Personally speaking, a per-chunk flag/type allowing us to know if a
chunk has stripe mapped is much better for testing, and can bring you
much needed time for further improvement.

>
> Metadata on the stripe tree really is the main blocker right now.

That's no doubt.

Thanks,
Qu
