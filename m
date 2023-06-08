Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C235727CA4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjFHKUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjFHKUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:20:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9792D43
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686219583; x=1686824383; i=quwenruo.btrfs@gmx.com;
 bh=di1rynrrCqZZooER2RF/+rR8QqyIhMmup1e/7OIvW5Q=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=o8+bPoLriysQcNzhjV5YKU7zwyuEh1qA3xgAwgHrQBUmDyVF7wz+uEuFIF6lH/P3FJ2xtZH
 RnvSQfzmApydTXvVGrGlxfr0uF0Tf43c9teyUDIIMGRq/8IXcpUMtagcklIKRctas/o1/rudw
 xIfiCRrHbon0ZKNf6f82+OQX1P9yqre8qudnRyDKcM31/RLvfcgffWA1Mt7bDyNMIxAvTZNqO
 Pi3koTbC3DDIUQV51K8n6uosmbszxupT8w7pou0bRwIgk9s8s2PsvDfLO8AzrC+/rvNjUF+CR
 Ssy9TX6AViyrE9TZm75rg+khIgEzuxv6E+JebgKtQeL9Vu+brUOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0XCw-1pv3hi2gLc-00wVT5; Thu, 08
 Jun 2023 12:19:43 +0200
Message-ID: <56d993e5-6fab-9d73-34a0-5265b16cf9d1@gmx.com>
Date:   Thu, 8 Jun 2023 18:19:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 10/13] btrfs: do not BUG_ON() on tree mod log failures at
 push_nodes_for_insert()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <3dfd1a4c01795433444b45268da1ae75563642c1.1686164820.git.fdmanana@suse.com>
 <4c9456f8-1ea5-a5b5-855a-65d3c9ffdf1d@gmx.com>
 <CAL3q7H4SnrVrFVG9FhSsJc5ie8JbHFnMcFbnJn61h5RDv9dvdA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H4SnrVrFVG9FhSsJc5ie8JbHFnMcFbnJn61h5RDv9dvdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2qmfYxMQCHAh4rv+yRSh+1diBva48NEeWry2DN1CCkaBzWcJx92
 I3U6+svv02LcEcmvvWRDFU+jVLE2r72mom3i7y713m64r0Gqqz6UPLEeMujGl7SVGmW4iRL
 imK8T3lnqjOPVWMJZww24AVVpQnGNGiZx7rTAxx4sqw+VXdN4gKXSB9GnChhK2jFEQiRBMU
 i6lPLWvBaavNtruA0Pfuw==
UI-OutboundReport: notjunk:1;M01:P0:jqpKpL4qJQk=;usIsxoPRfICxzvhVHRZWiAJIAZO
 sg15w9Ky0NLI/apL85gsDQ60eHnEIOEAHrwBupNwOavD15PUDXS/DURgUEgFUkjFNSIDKDCr0
 zieYTA4TrFWQZXO55IKtfbq4328eE0Em7y6lHrFb5Eyi8IIJWso40Ze31W0zjM5P5V6xUL9bX
 NcqY9U7HLnr69yNtmoeRBXQv/g4tr52WrAEbqgKNd3frWSKHuSPB3w2r04n2JJYw6DscUZ838
 zx245Q+XxYFkyLy7mIyxHU+rSe1iZT4g4Y2SVeyw2EruGme0nOtIEXKTVgYJXRTZr+rzVTVbA
 UCTppIkCx3lFf/vWCLxc6LEbj6M8FeGsnDaefpuUm7AGcpNyhIn4jhWc13/MJGeOiBlCDAt1v
 Nj8yHfM0IxJ7UXKAeq0Np+RfeX2w06jMgWv23i45J1md6KRfvKKZ5tJO2/YE37krRWk/DfNoX
 JtvxsGgrspG5ys/iGOLIwpPzb6r59O97/BjVXBUZYn+uEEyNZqpJJQ9ksZPWZZTmib5Uq+vGE
 dtleBtfAiGp0+AwB0WFAgp8+AtmQ9ETKUK71tV7vKRsqjjUjz7h2QrufUOSgNHnw1ctHHuOny
 HdqgurCkyspirX4DFQQjekbHiIN+75NOLeUUbHNv6GnhqGi1rrOqrUhcx7HpTE+o7T7CuI1Rp
 W4dTY9RMF/u9TldHAY6KhzLy8BKwWe8GKV0pwjyddWhIBEYcM3wwK4N4SANvsTRITOuwvDAtZ
 wL+g5kTuQ8xFjfP7B4sODvbaK7tl9HR8raBT8Z4aL3asdnYqeoFQnJfZPOAZq2ESSAlYQYC3A
 jRUflTLy+B+lnEMVbCqPXuu1xTjk7VJFskqdf25trHb7p27yX7JKaVXEdDO83PQKUPRpMHxPK
 t+GIBNE5MC7Ki3X+kN1l5k3XiHyORNSMd/2Tbxe3v7Kun3D7/jN79CR8+0Pp1FzGmLIgFPffg
 7SVq7eX9YKmSJ+v3zMgnjr4q1VE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 17:46, Filipe Manana wrote:
> On Thu, Jun 8, 2023 at 10:02=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> On 2023/6/8 03:24, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> At push_nodes_for_insert(), instead of doing a BUG_ON() in case we fai=
l to
>>> record tree mod log operations, do a transaction abort and return the
>>> error to the caller. There's really no need for the BUG_ON() as we can
>>> release all resources in this context, and we have to abort because ot=
her
>>> future tree searches that use the tree mod log (btrfs_search_old_slot(=
))
>>> may get inconsistent results if other operations modify the tree after
>>> that failure and before the tree mod log based search.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/ctree.c | 14 ++++++++++++--
>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>> index 2971e7d70d04..e3c949fa136f 100644
>>> --- a/fs/btrfs/ctree.c
>>> +++ b/fs/btrfs/ctree.c
>>> @@ -1300,7 +1300,12 @@ static noinline int push_nodes_for_insert(struc=
t btrfs_trans_handle *trans,
>>>                        btrfs_node_key(mid, &disk_key, 0);
>>>                        ret =3D btrfs_tree_mod_log_insert_key(parent, p=
slot,
>>>                                        BTRFS_MOD_LOG_KEY_REPLACE);
>>> -                     BUG_ON(ret < 0);
>>> +                     if (ret < 0) {
>>> +                             btrfs_tree_unlock(left);
>>> +                             free_extent_buffer(left);
>>
>> I'm not sure if we only need to unlock and free @left.
>>
>> As just lines below, we have a two branches which one unlock and free @=
mid.
>
> mid is part of the path, so we shouldn't touch it at this point.
> It's released by the caller doing a btrfs_release_path() or btrfs_free_p=
ath().
>
> Those branches unlock and free mid because they are replacing it in the =
path.

Thanks for the detailed reason.

Then this looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>
>>> +                             btrfs_abort_transaction(trans, ret);
>>> +                             return ret;
>>> +                     }
>>>                        btrfs_set_node_key(parent, &disk_key, pslot);
>>>                        btrfs_mark_buffer_dirty(parent);
>>>                        if (btrfs_header_nritems(left) > orig_slot) {
>>> @@ -1355,7 +1360,12 @@ static noinline int push_nodes_for_insert(struc=
t btrfs_trans_handle *trans,
>>>                        btrfs_node_key(right, &disk_key, 0);
>>>                        ret =3D btrfs_tree_mod_log_insert_key(parent, p=
slot + 1,
>>>                                        BTRFS_MOD_LOG_KEY_REPLACE);
>>> -                     BUG_ON(ret < 0);
>>> +                     if (ret < 0) {
>>> +                             btrfs_tree_unlock(right);
>>> +                             free_extent_buffer(right);
>>> +                             btrfs_abort_transaction(trans, ret);
>>> +                             return ret;
>>> +                     }
>>>                        btrfs_set_node_key(parent, &disk_key, pslot + 1=
);
>>>                        btrfs_mark_buffer_dirty(parent);
>>>
