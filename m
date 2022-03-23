Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7924E5BCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 00:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbiCWXcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 19:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbiCWXcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 19:32:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F5C6C933
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648078235;
        bh=02qukdPyR5QytITySTaaD76TX9Y9AJMEJqDdLAeAbjM=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=D0Hhwi1FXTqANCfIpvXtwCiftg57/McZVcUBq/PhqpQEov0JGMqLGVR4jarpIgGcK
         GLiYq6ODrqeh3oCsc98cTsljgx9NyX/pow75UdDRgEY99uB2W2QGGvdy1JZHqzcqEu
         UlnAngZlH70mTSnOBGDKO74eQj+l+hXRsvyDKsCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGRA-1npNoC1o6I-00JLtm; Thu, 24
 Mar 2022 00:30:35 +0100
Message-ID: <15fcb764-d25a-6424-2560-25e4ce3baf7b@gmx.com>
Date:   Thu, 24 Mar 2022 07:30:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646009185.git.wqu@suse.com>
 <20220323171759.GB2237@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/2] btrfs-progs: add check and repair ability for super
 num devices mismatch
In-Reply-To: <20220323171759.GB2237@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:inHIiXadzugoo/IVIR6yVdUupJLkB9MBp1kA4zdtS7r9yebMvz8
 WRmU7Fqt0JF88gmVq5te7kME4YISDgYBzs9Lt8B9Ok9aX1oqcFzs6YiB2UuEKW1/gc56OYL
 2NSeaTmE2fBgbRYL3oxnwclvncW8ypMLmzDU6FYPBgPZhIXn8BkvYCFsl2dl7tJGnfX2/vV
 Z2ATIZKnoWVgEM4WT3fuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kRxg7d3GMUU=:d3tSYJNu6aF1HjntBIYLUq
 dMud3WYep0t/z0A7OaMTYrdg8JF+XMCEK2AFAHosS6igpmhuSfE+qKPjzaMm68a3NEo/9sGnE
 4NWg/s3xhQAudFx0njvIsy6qYBtqOT1fktImZ30mkJUAVVQ/LWtTvaRcxddKpqWIIgvQrXvXc
 kc5q6H3XRPQiq6r3zkxzphWwWJ2K0raHkdPVCLPqeU8K0do6L2UkQYUB8+y2oxRzOdl9yMG8R
 hs834eKL5dLmaHAkAc7h7SUvk2hOrTQIjeiUWF/j1uB7HjnUcKX/Ww05suHUy4wCQm6C/aWA2
 y3vo5Id1WySyaL7H7Y3LCbEQdf0jxbVA5hdxa3cp1NQw9Tn/wbKGNFZ6WaUswUVsHf8rVBSCu
 lpzdcIviMxNq68yaNdw5x6jyM/+H+PyTIGVqPTjqvKpljtbProlIWAYkxZYjGGlsYKFOqi1sq
 /am3WwBAGIvM5mFulm7on12efS5PIgPDcLkxYxpGvhdYTe0TzeaPJa4IfO1lrVh4Q8Tdczk9l
 +7TVC4ItckoHIijW93KTk+n+Y9d9DfH/cLXaamoDx5xIfVFN3ibwDDXl/gtfSACiUjgXcu/pP
 XG7Y3DiMxe7VuUB75JS4vPPAeW95FCo5qNYoFy5jjTWKOpfHlRmoTee/QVFF/KYruJDpyky78
 WNJEqbN+k32u/ItrnQt9Fgwx0aQ02bqXZWMOhIdAo+qOHL3UcwrF+bufeWE1wI96WPtI4PCnH
 VG1EX5Gq3T1KnrbTrplIafng6GnCA8TpcDAlNNoZoR9HjKn4HJRyEZk0Ss5wlNAt/5m5+s3yt
 kwsS5eo6ArjIG4ek6eNLcmoVaQHcoU0wb0lsSaIcAdefWrUvohinV4b7rWfzZBynKz7y1jGxz
 OKOCP111gYn1eEELAyPoti4G78CZlLncC16Vw8RSKL4Pn00GAgHcg3ADaUqzRC9GnEqowmos4
 oT4VUMUn2QRC8UXkQQgSAHj7QNJRUy004hSBNsIDlr9O8f1y8xADvSb5n/PzJmyyqOLKsCXeS
 R8FYA9Burq7ePsmpGguvszW9Bww8AgBzwO5mPUaywLJ2AIqSzWSHxfyV5YIY4ZY+6N+SA+Q5w
 /LGdN8/2XWDBiw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/24 01:17, David Sterba wrote:
> On Mon, Feb 28, 2022 at 08:50:06AM +0800, Qu Wenruo wrote:
>> The patchset can be fetched from github:
>> https://github.com/adam900710/btrfs-progs/tree/super_num_devs
>>
>> The 2nd patch contains a compressed raw image, thus it may be a little
>> too large for the mail list.
>
> The compressed size is 22K, that's fine. I've recompressed it with 'xz
> --best -e' and it shaved a few hundred bytes but that was just out of
> curiosity.

I'm also a little interested in why things like zstd/xz is not that
efficient in compressing raw btrfs images.

Especially when creating the image I have created the image with all
zero (fallocated) file in the first place, thus most space should just
be all zero, and any compression method should be super efficient on them.

My current guesses are:

- DUP metadata is not fully detected by the algo
   Especially when they are mostly quite some ranges away

- Some older tree blocks from mkfs

So for further raw image size reduction, we may want to:

- Use SINGLE metadata/data

- Fstrim the image first

Thanks,
Qu
