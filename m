Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186FD72A9D1
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jun 2023 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjFJHZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jun 2023 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFJHZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jun 2023 03:25:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3C43AA5;
        Sat, 10 Jun 2023 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686381928; x=1686986728; i=quwenruo.btrfs@gmx.com;
 bh=QM0tTvmFEhJ+GkH/S1MQHk4ekROqIAIwT56z2eHMY10=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kA7p7u7isUX29FrshrWrCaKfsOY/1izYca2o3LyVShlbSC5yMtj+xGk8H9ACaYLS6z2xMFc
 Dlof+NE/eV4PlX3ZyfEnYdWP68IL05VFlhR6//C79fiFD/SsQNOpJmLayI0+PXW5vXOSaJTJC
 IOD27/8Afn0Z1V5eutbsqrE2ICE8h8+uW9kH8UCb4SOjt7JU0NNrZtIFRKKpBKs9mPymbIzgS
 KfnSQOQDpGj2JwDMhz8fgebigZnl0A0PT5NziyjLiyAiBcZsvP1hFztmxe2gjBp7SmQYPqL6E
 nIpgHs6hK1t67GU+rJQyCjeJSpF/p63QuKVFGI+aLcSfDCOCZ/OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXhK-1qUWQv3Uva-00MfeE; Sat, 10
 Jun 2023 09:25:28 +0200
Message-ID: <24cfe56a-9d06-4db6-73ab-e413fee3d61f@gmx.com>
Date:   Sat, 10 Jun 2023 15:25:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all
 page caches are dropped
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230608114836.97523-1-wqu@suse.com>
 <ZIHGb+KyYW72MVzp@infradead.org>
 <5790cd5a-04d9-bfe9-a8cc-0c09f784222d@suse.com>
 <20230610064620.4ovt52l4lcvrijyn@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230610064620.4ovt52l4lcvrijyn@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:njmNLXrcosAKKG75cDJR1NC2Z3YXb5/4cwVULZi7Swjk1TKfNed
 IoDUi1GIHwQWMPaUP0U3+f3TcQ4AA7KwwIPQek9jF1LFj+qgDF46CRj7cJYr76HEv4N6HXo
 j3Kl1iG7J6EaBZEbrWOQAHTw0FaGjjzVRAaBFtC/wRMUNcoQYnPXxECmzgSynCEBpluDjpe
 pIjszdkusmXAPPrjpRvBg==
UI-OutboundReport: notjunk:1;M01:P0:cbVLP+IuwX0=;/4z094ZhUWN4KHuGFM5lquiYEax
 y1xyFn7aWM1t0mDpx4qi/8wvg0jdzcafONRhxskHmULVCkEkpASANbd0wI1COzCq67a270bYS
 PAISHcsLoAVDAOnNp9aAnIUGdMfTUwFkJ5mZfQz0uwmF7SeGAO2ZsCBmZYVyVMSO9o3wlOID0
 iBwJOxFzl2qHvWZRywf5W/1fJx/VsPxjXtG5L62MlpqkmSn8DdkOTiLxCIM88bydhP3xSLVRJ
 i8TfkNBnD2LDB04exprX3FJBR1s88iBzm3Sp+ryaSzCqWE0Nl4ZR54MprbJnlhY3sxYf0ZgQo
 c2gUXvwLbfrKLb+MPZztzUoIO62JTd1yb6/Oa8HSQ4A7FzsCWqgfvXRGOKgS+jAZOEK05/mh+
 y9Ar2YHq8Gm5PyREBTrz5EWBYj0TVBRjzecHd6blUk3PA3gy1AA2HrlHhzYgmhoNGYuHLKxIU
 P1jZ9MmkD+4gWgzpn50do/SDom8qemQt/qUM9RYIbk5uz9EBTDZjX7bD6S57Ut4Twga0yBOGP
 /P46EXIexHnFyEXIrz8WAprcInO5MW/6X811ST/SdrFGht4e49bstWnOM1LeAs/ENAVXhpp/t
 Wdpb9QmUnNg/sRQEhbR/+8NmULn9rWoIGqz+1FYT5Z7ytnIM7lcz18IHu4wijMVq5fG96+IVd
 ztwlMg/5R7DbWey2B3cDMxpC+heTqQBMidPA3ePwtRmtRuc+5Yi6VxraJpHoffb79XvNdxG6H
 cra/LBhqj3pBVZt+hG4aOTw02L9MEAw85Tn4d2OP77U3uEBOZCBinfgqMTyG+6iccZgv9ERIC
 cJPhQ90+dnZaehjU2EDPiYGhBWBoXRnMc1TFEUOdImMfTYjUp6xw5VAd/EtgfE5KpDJ0WEFEU
 PmJSp9NqtZ29LYGqUbXm52TCcUYq7dQ6sHRWZ9iqMv6m1Lw0dthVdeCajC3Ae7yj1iTSMEDPf
 x4NVHpMqABWGE3/OutvLxfuLLhc=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/10 14:46, Zorro Lang wrote:
> On Fri, Jun 09, 2023 at 07:57:37AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/6/8 20:15, Christoph Hellwig wrote:
>>> On Thu, Jun 08, 2023 at 07:48:36PM +0800, Qu Wenruo wrote:
>>>>    	echo 3 > /proc/sys/vm/drop_caches
>>>> +	# Above drop_caches doesn't seem to drop every pages on aarch64 wit=
h
>>>> +	# 64K page size.
>>>> +	# So here as a workaround, cycle mount the SCRATCH_MNT to ensure
>>>> +	# the cache are dropped.
>>>> +	_scratch_cycle_mount
>>>
>>> The _scratch_cycle_mount looks ok to me, but if we do that, there is
>>> really no point in doing the drop_caches as well.
>>
>> Yep, we can remove that line. It's mostly a reminder for me to dig out =
why
>> that drop_caches doesn't work as expected.
>
> How about leaving a reminder/explanation in comment, remove that real dr=
op_caches
> line. If no objection, I'll merge this patch with this change.

We can reuse the comment in the patch, which is already mentioning
drop_caches doesn't always work at least on aarch64.

I'm fine dropping the "echo 3 > drop_caches" line.

Thanks,
Qu
>
> Thanks,
> Zorro
>
>>
>> Thanks,
>> Qu
>>
>
