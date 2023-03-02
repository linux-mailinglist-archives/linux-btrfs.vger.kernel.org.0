Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D56A81D2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCBMBS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 07:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBMBR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 07:01:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7972E0FC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 04:01:15 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1qfmxR39KR-018Nh5; Thu, 02
 Mar 2023 13:01:08 +0100
Message-ID: <30b5bfdb-a614-be74-bbe9-b4553df95b9c@gmx.com>
Date:   Thu, 2 Mar 2023 20:01:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lfQqyPwpd7fn+Yai8Vhzyqfw5pauOalXPQdlSQNM1oz9oQ9+vPk
 lsnARbXiZZzOOSJtjA07JlTym9O8YO9kepjqC/UbHJP8HwwwyGvWghvSGYZONyrtc1Gp1RW
 I+kFBsxeYOSJkK+4AqJ/PjGOxWQ/LFQ0ujCkteJlcTMH99AxQJijBFhDo8ek6wrHVwO0hgi
 0zMvjX10rrXxCrl4ADzKg==
UI-OutboundReport: notjunk:1;M01:P0:kl1sD1j0+nQ=;MnPSyQDYKIIhLTNAIg2MY5o9rFy
 CM1YPf6NLJHug1KWIxZx18FG175wWJTnIXXn4AfM+uLN14QlCUjckrFXX6ppo/sYFt7YEMq5Y
 wKrEXa4MShstwcuhUD7oSpxK6p5WGdFfYHJL7/zg3WowwO2WquvkM/EQzTiFoWUO40NeM052n
 K31c12z4gIeqCa9qNLy7EB/idy0xFvvb6+P4LbQkAtCUVjyQ1/2JzFpYb4IExF7f6EP1E327a
 lyMq7VAOxd4/Ub3dZL3jrAEpnpN5COmVy/uhymnvlRXVg60zwiwhwaxHH6M5FnujwfW9gQPo/
 ykmAuR1o4XUhssY/SJPsxe0hAlBqTat4C5+EHILdp8RshvxAwmvCbA/jaEkifrPbwdL/Y4Fvf
 qX0pMNASIRs0iS7BHHz023NC3pUytnKeto9Gb4z/iu/RDfXjd0aoewq4tjvsrTjKZfvgXRCah
 w5Z+JyNj4sKXZ9Xsxx2zqtvcOrsmIB+81f6VpRd9rbVY4t8OSxGfXl7xGDw3gQzQ8sOjnda1b
 tKmWeH/W14kEWQQEbDzuT3ZWaeYUkca5oRv89GH7YVUuTB2dbAVwPH6AtOOKSzbA+6onaI55D
 Tk9NaOWCQ0NvS6gPlBokl2BqSc2CjGtoVSYjyaghVeQYKzj/nEkBoiCWOxUV3lkv3nB8K2Mpf
 kZ32m91pLNHrF69jwPkiIlzj1m14UDgKFpux46YxItVELcj3w06RwNas0iUVpqK3ihM33GeJ/
 SWbDw9H9Rjw0nfyeI4FP+Z5j95uk3X1BFExftVLdA4lIeZC80Bwwht6FolBY53WBQHhVnZ5he
 RXC8YETqgmdqPk5OmYW/E5S1I2QlaAr3/A5fv+yqz3A+dxWXEiCXT2YVLYFPIK9zlyiW3zbZ8
 f9p+HE/4HPo9ubNuDRX22V6iSzUjhA/iNt5UiZVtcCjdMlVOBD/tZUudxACor8539AWk9EIv+
 jc9cq2ZXYjCsppEl7PFUc2zg868=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/2 19:58, Johannes Thumshirn wrote:
> On 02.03.23 12:45, Qu Wenruo wrote:
>>>
>>> How about adding a completion, or something like a atomic_t
>>> ordered_stripes_pending for the RST updates and have
>>> finish_ordered_io() waiting for it?
>>
>> That's also a feasible solution.
>>
>> Although I'm a little concerned about the fact that the RST delayed work
>> is also going into fs_info->endio_workers, which is also used by
>> finish_ordered_fn().
>>
>> Thus it can cause deadlock if the workqueue has one max_active, and the
>> running one is finish_ordered_fn(), which then can be waiting for the
>> RST work.
>>
>> But the RST work can only be executed if the endio_workers has finished
>> its current work, thus leading to a deadlock.
> 
> How about adding a new workqueue for RST updates? That should mitigate
> the deadlock.
> 
My bad, the finish_ordered_io() go endio_write_workers, not 
endio_workers, thus it should be fine.

Thanks,
Qu
