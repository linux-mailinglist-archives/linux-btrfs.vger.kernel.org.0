Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE86C8C92
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCYIV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:21:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA517CE2
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:21:53 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1qWiKm0hns-00qwbP; Sat, 25
 Mar 2023 09:21:44 +0100
Message-ID: <9581646d-380f-2b55-07ac-2abd37822577@gmx.com>
Date:   Sat, 25 Mar 2023 16:21:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for
 scrub
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
 <ZBmc3ZqDVzb/hVDD@infradead.org>
 <0ee1de5c-9cb2-cecf-c4be-02cc16bd505c@gmx.com>
 <ZB6sQGoP9dbsgvX7@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZB6sQGoP9dbsgvX7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:j2CyiQncsOreVn0rE9cxk40COqTPdbKd/LKVj6VI71vYmjp6QWl
 aW2o2kpKn2sj613woydmWK5wBYJ0WovYtkEhM/v44LvLZojfnvuqhKHqTFbSupuy748RSdK
 te/ivRAKSAPKZhS1a5puSDZseWOyJ+tt+bgcOgPqnSblJWm3mPEpT8gdY7baeYLbFXTZZFd
 dXSLSy44jA0K2pY0/R66Q==
UI-OutboundReport: notjunk:1;M01:P0:21Q/3wzbUHY=;lWvERFvWAk9hbz/zmWo6RaHEf2k
 U9vv/JLuoKAbC4nMv1k/w/lwnTmnD90FX1YzCN1Sft8IaRVccTttVlrBQVPut5WdcLzBtvfKA
 7/iulAp8uYX5hV5vQS8izcBl+vaVIVR8l875/8XcxITP+2+VqMclu3x653UMB2q04WjtIDv8L
 lpIQmBnvTr7NTScDgtWucTXnvS0St506p1RoBelxlEVXxgy6lJGc8m+ohC9VcfSVfNngO0IQO
 ugjRrTgZWWrYU9BYrP+0ba5mp/lFcFI8Bn+YCud4qOJ0FcjHvNpVdttEhJHqTLOH9GacwPokZ
 oNxeQICLbw64iuQIRfjjiq8m1snydccU2G6yKDiomo1kFILihJd2WCUzTcBrpUisAzeex3SZ1
 MHHjYgVW/4W7kgQ9HtGetSoapuXM3NszQX2hQ+4mbCP88DKT1DiSKFwBZ+GPuQlnfgobNQlnO
 Ghr4DwPd/hCZg/NmfrIfwV4CehtYB0xSPB1PvENE6pkUrS9fijT3mbpBKko50c2IVYciJgUlr
 HHPTN1qeMIVOXCUtnfTsWxCnhvv4C0idk2F6XJ4w8nNbN8HOCipwURoyVKK0KaSkRCrB82/Nh
 p96Nli71jFkKobMxsXqBCCe6TbGqmlFmWWax1td/LBw7XsS9kaN/iIHZmUoPHvhvZ19C5udUF
 3B4CL7RtBZlJgMUvgqPPSD6iAYCxPZAI+UfSZTkonKhG6yQR819t2cXtTPQRkPef8eW/iIQ8R
 6v6yZwq3PX1WB34OJKblswoH5MxLcag5OlPAUpmJvgb1L0FYoaHu357knIRsVfloKaC2bNh4y
 NG/RaxGysLrlFdHJ7daUnC8NUUZF8dkKGX2ygodpm7goYzfWEyvKkdh2eOOBiqRxNiLWPrLMK
 /0YWIW9VioktmupEOJ5Q3iQD3tmjn8f3jSp8RcP9kdBDfAlqhQ9nvL4URGRwelpznT7R+t4q9
 9AhAwwXoR25JM9v2dUZ/ejA/8YI=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/25 16:09, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 05:58:57PM +0800, Qu Wenruo wrote:
>> I have updated the branch, with a dedicated btrfs_bio::fs_info,
>> btrfs_scrub_bio_alloc() and always populate that new fs_info.
>>
>> Mind to have a pre-check?
>>
>> https://github.com/adam900710/linux/commit/0f6a419f035787546eec6f51b0430a05a345d4c5
> 
> I'd prefer to just pass a fs_info to btrfs_bio_init and btrfs_bio_alloc
> instead of duplicating the allocator.  With my "simplify extent_buffer
> reading and writing" series and another tiny change we'll only need the
> inode for data inodes.  But given that we've not made too much
> progress on getting that series merged I guess we'll have to add
> the duplicate allocator for now and just revert it later.

No big deal, I can go with the extra fs_info parameter for 
btrfs_bio_init() and btrfs_bio_alloc().

The main reason I go with the duplicated allocate is to remove the need 
for nr_vecs, but that's pretty minor, thus not a critical one.

> 
> I'd drop the ASSERT in btrfs_submit_bio - all allocators initialize
> the field, no need for the extra check.

OK, sounds reasonable.

> 
>> Although the next two patches are also slightly updated to take the
>> advantage of that always populated fs_info:
> 
> I think you wanted to add links here, but they are missing.
> 
>> Since the modification, I'm a little more dependent on that always populated
>> fs_info now, thus not sure if going back to a union and conditionally
>> grabbing that fs_info is a good idea.
> 
> I don't think the union is a good idea at all.  Maybe in the future
> we can move the inode into a union, but right now the csum for data
> read is the upper bound on the btrfs_bio, so I'm not sure we'll
> ever get to a point where that would help.

Yeah, let's avoid union and let fs_info always populated.

Thanks,
Qu

> 
>> Although I'm more interested why there is a super big gap between work and
>> bio (32 bytes), while the compiler still refuses to put the pointer into
>> that hole...
> 
> I don't think there is one.  pahole just reports structs strangely
> sometimes.
