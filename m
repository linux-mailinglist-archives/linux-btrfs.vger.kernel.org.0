Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF2719412
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 09:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjFAHVf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFAHVd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 03:21:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14909184
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685604086; i=quwenruo.btrfs@gmx.com;
        bh=wNPkFl2bA/MqghvLgYqSVAeCtLNaFqr0/VYmrWFXNZc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WX0z/nsPYIUtJ3SCFaHMIUmUSjjorNSMYf/CPEoPw0iY+EBjaSAWGrYnSAwxbG4eR
         t4kFhSAHWavIqWevifP+Ww1NZz1ZPd2oMgEy/wskcUXVV7+qCW5etBKEprX5TG7PNT
         dw2v8Vet0t3pavbVryB22tePPbAv3jPlDJUzOcRSAWvCursWhyp/UbzP5gT7da1qZ2
         Tf/x9iYsL6So7wkk26KZH1gMLY67i5Vc0B6Qp0GVXhoTUdbjoiJdswNOLtCIy7+jxU
         /RTKIRCMSx1wckmEbG7PfAJARhgbWcJ3rWCN/MAT1YceJWUm4MRNGnOjtPtIU7GJ14
         pISV/5Kzk4Ccw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOREi-1pi1Wt3qJC-00PyWO; Thu, 01
 Jun 2023 09:21:26 +0200
Message-ID: <37a62c6c-ca9a-a6d2-37ba-249605427d08@gmx.com>
Date:   Thu, 1 Jun 2023 15:21:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: new scrub code vs zoned file systems
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de>
 <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
 <20230601044034.GA21827@lst.de>
 <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com>
 <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
 <mmttvfirtcp32ruvodutdw2vnvxqdnad2gywwb6jxl7gtkzqta@xw75lfxofsso>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <mmttvfirtcp32ruvodutdw2vnvxqdnad2gywwb6jxl7gtkzqta@xw75lfxofsso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bovZTaXuXp85eIBmCVzErOCocI5I6xJXTVDx4zoEhyYMXqaU5PF
 7b8hr8sFWVq0RztVySQa2081INxz+InAO2tTsib0V9l5OM77BPJhCPsSg2T+wOlSsse3y/g
 6HasMMxyGoouhUSWlsyWaw+sOFj8Mz4Lu+bCk4lykFlIDouGZDA3iAyAd60E4lXcxlP3qgV
 jBSdzFXfm06eRCHz2AUdQ==
UI-OutboundReport: notjunk:1;M01:P0:+7QKhVDbAmc=;TBl29NNaLRnG3qXnzWabLxpios9
 V/G7hXZV1QPhpksGHxA7NwS52DOuH9FSv7/7uhRLEUUQ9FLENY/OkR5cbi/qnWBvcGn5dpGL9
 ke1Jzic77NMDPGWOPPPM9/Ga6+SliPM+IdVw0Xat3oQHxTJ2e6nRIze0vrDBb6rdOKH7oPOcG
 j6hfafRR8T1rpzxL1VrrO5DtbuEIAHGeFeCFyZdFeh0SSA0vkOWNznfyDEY6hjt+v4rtI8msu
 awfrEHJz9fDK/cww9aNd0L1t/oLqXRfdVF/Yp0NjaEPwVSVQEyjML8zzEcbcEIhZoBgj+B/+/
 wU8ZjdKnmSikOREC8No4qg2XQKY7j8+hMwnnkwL19EHnun2iJ3sHBXvxc4y+h5Hdpq0xpVMpG
 YmUbiWg6zQEdZDQc/VaX0G0vUHoFfkGx35yIOHzObQPq5VN4/3Ol3VcGXW8Y9lZ7M7G4SjPJb
 5kdLDZGbaj7p+iharzi73SJVHe/9Mh/AJAwfKCw7BGEqO4b9nf7rZauOaaSjF4VfRU6RQSGJh
 XYhG79LpWccBKasiFG2WexET3t4o7oMC+jmwa1OQuqvOzBoqWo8OATSsnnhYHNnAEoKCinup3
 nRrCtZ12TEpdP+ze/QAr05JjwyOZai/dDeWKSQrW/B7wxVgTJUcae6NkKywy1Gk1/I9Ikadj6
 23vVAngYTEO2LjPd/Xbxt7dgYb+FQ7Knk/qVwrWlu8872N59Qn8DeFmQDnXoKC6rtEf5R8Y3i
 XsBp7kbzHS67QcjaBZK29wTQORDkEsQkuypO+XHoKWc6pn7Wu9YY7ZDEWajhRW3ez0OE9OS4/
 8VJm3GxY934+ejyA30X/aNeTTMLmB/+r6hKYAiPJJf35W2f7rIwxYn0CmPj8LkTD8hrXMGLmA
 LtKUQkdMqaOur9u+mfVnOFlMX/Jsfg/vX+E0fBrz1KgqrZOHT4pTi01lGWWRfAFDCYc5/VJnv
 TEyqzk9Mpt4+bzFHI9PBrqzqFnE=
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



On 2023/6/1 13:21, Naohiro Aota wrote:
> On Thu, Jun 01, 2023 at 02:17:22PM +0900, Naohiro Aota wrote:
>> On Thu, Jun 01, 2023 at 01:00:40PM +0800, Qu Wenruo wrote:
>>>>> But I'm more concerned about why we have a full zone before that cra=
sh.
>>>>
>>>> I think this is happening because we can't account for the zone filli=
ng
>>>> without the proper context.
>>>
>>> I believe it's a different problem, maybe some de-sync between scrub
>>> write_pointer and the real zoned pointer inside the device.
>>>
>>> My current guess is, the target zone inside the target device is not
>>> properly reset before dev-replace.
>>
>> This must be a different issue. Are we choosing that zone for zone fini=
sh
>> to free the active zone resource?
>
> BTW, you may want to use this patch to track zone finishing.

Is there any function that I can go to grab the current writer pointer?

The new trace events only output the flags and used bytes, or the used
bytes is the write pointer already?

Thanks,
Qu

>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index dbac203ea54a..5b4ab12368c9 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2015,6 +2015,7 @@ static int do_zone_finish(struct btrfs_block_group=
 *block_group, bool fully_writ
>   		btrfs_dev_clear_active_zone(device, physical);
>   	}
>
> +	trace_btrfs_zone_finish_block_group(block_group);
>   	if (!fully_written)
>   		btrfs_dec_block_group_ro(block_group);
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 8ea9cea9bfeb..594e4aca0a02 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -2057,6 +2057,12 @@ DEFINE_EVENT(btrfs__block_group, btrfs_skip_unuse=
d_block_group,
>   	TP_ARGS(bg_cache)
>   );
>
> +DEFINE_EVENT(btrfs__block_group, btrfs_zone_finish_block_group,
> +	TP_PROTO(const struct btrfs_block_group *bg_cache),
> +
> +	TP_ARGS(bg_cache)
> +);
> +
>   TRACE_EVENT(btrfs_set_extent_bit,
>   	TP_PROTO(const struct extent_io_tree *tree,
>   		 u64 start, u64 len, unsigned set_bits),
