Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9469D628C34
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiKNWkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 17:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiKNWki (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 17:40:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF117A9B
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 14:40:37 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNct-1pSQG63f0J-00htEP; Mon, 14
 Nov 2022 23:40:34 +0100
Message-ID: <1f48d516-4016-d81a-78d9-62b34f7142c7@gmx.com>
Date:   Tue, 15 Nov 2022 06:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/5] btrfs: use btrfs_dev_name() helper to handle missing
 devices better
Content-Language: en-US
To:     kreijack@inwind.it, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1668384746.git.wqu@suse.com>
 <3382bb8f7ab90e52ffa86cb39253ab5bdb78026e.1668384746.git.wqu@suse.com>
 <516619f0-2111-a259-6685-823ea48c959b@libero.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <516619f0-2111-a259-6685-823ea48c959b@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2aeHr+B4YvoCsbPbyXNtRhRvirafMsW3deFmZbSoHKq2x0jujrM
 amq/7dXpdzd/bmD9vRgUCqKbGQNOzQw9q3qTg7OHtGEb4sb8TDw9DUiPwbczdG9LOtzJ0gf
 PnjF8swFID1uU/mGDaaxz6HCcRlXgdII4DUEzZOm8r/GOj5FpPaWI6EKAcJNXDQ8+scd023
 L26ss0CKsiGbmh7kjUKng==
UI-OutboundReport: notjunk:1;M01:P0:g4qprCYlXdc=;hQLV/XaOiOx3K47TKCjJBC22VUT
 j6mNxsSBqBrVI2LCTj5U0T5Vjg+qFfBplgYiHIw/BmeoUkHXKiOFJgDZbl8bSEe9emL79sHM7
 lieeOE8n5D7fDbOLDDFVE9nFUftzZwXzxX2pnoGuPAjOxcQKnbfrT4ltG46iTmcvkt3933RVU
 xBYRVwME2NI4ETTbUGa6cOnwGIz4i2+lb2hIh0djciNlehq0e7H7MCOnuXphFbTYwmYcOXZ56
 yqKiDxnXkqVXXCS0AvhC3K2O0sEH7citWIkX2H4FaZNTswMkYc25oBV1MhQboWma1AD+o5zRx
 pXl+RqRtbOkJDuJeZLisg+Zjl2+LxYcG/pNEqx4dBwmY5SYDVnxI7St8IeDY9EdDGZsDkek5I
 Kh/MydeUFJL2Dt8YlNxzuBjSImViH6oNsCXftOp2gUCy9WChlJuFbEqJgnY0ncvJORQb3ueq5
 LPnLFxgKjUEQOqCYblXyJq9yQercNZh8lAVtYvOjeUCOIjCRslAbJWiUBkanr0uHG64irA/31
 6260XvBCJTb8fSD3+7d+thWhGH82+73o4UnwLvbOax2DkDHBXiJyjCdp4YRzS8jPg/lHqkw8o
 kyRus+hAj+8+pStDoBB065ComOGTaUo+JUt5lPLQQHn31BYHetUq0zjlJ9t2FAxAc+Tex6UM+
 dW2FwBDkoDc1t+V/8Py7dxXoZKHfEWptaFCC3p8JqMqmlB1LKaAN94uSoyMQyF22chrSkg0Bz
 ERuzAL0d8/9Yx29D9gRlML2bfXSTLjSlGn2F4OXkOX0Roegaeqz9eyKdKyOrR/Y87cEEAA2Gs
 aWjf6uCyuqBT+KjxDIPUhGEbuob719WGVQJPE2EO0XAlbzsPlp5t7uxX98J70MQz3rD8JY5RZ
 +i4A3e5YP6L9K3x4fUVLJD4xcV7s2MWGlVpZC19iCpGZlZSBOwu6DF9EiUpwR9xDUnbA/W6iD
 iZMuLoDBmLJ3sj2v/353O9RJI9w=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/15 00:06, Goffredo Baroncelli wrote:
> On 14/11/2022 01.26, Qu Wenruo wrote:
> [...]
>> @@ -770,6 +771,14 @@ static inline void btrfs_dev_stat_set(struct 
>> btrfs_device *dev,
>>       atomic_inc(&dev->dev_stats_ccnt);
>>   }
>> +static inline char* btrfs_dev_name(struct btrfs_device *device)
> 
> Because we are returning a static char*, should we mark the return
> values as "const char*" ?
> 
> static inline const char* btrfs_dev_name(struct btrfs_device *device)

Right, that would be more accurate.

Not sure if David can fold this change during merging.

Thanks,
Qu
> 
>> +{
>> +    if (!device || test_bit(BTRFS_DEV_STATE_MISSING, 
>> &device->dev_state))
>> +        return "<missing disk>";
>> +    else
>> +        return rcu_str_deref(device->name);
>> +}
>> +
>>   void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
>>   struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
> 
