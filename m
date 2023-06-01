Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22988719284
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 07:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjFAFqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjFAFqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 01:46:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BA6133
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685598354; i=quwenruo.btrfs@gmx.com;
        bh=pFuPnsZF7xd/sNORMl95ndLUO4mxpb3NVXnN/a0dI5Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QeJ9UNPVT0oUjryJMgdhzVGSQUykl3baW7oJPdhpbG6z736k7eZx/gHl2+AkeuVL7
         kuJMpxvY6qSSDWn6rfOFzP5favlmc4F9Klf6JlC+ZiEAhRJ0/b1RoZzH9FTxCZdGLR
         LxJEM0RQL34FBYck7IjALb1qODttnbxq6YG/e4KoUcj03F4Ucnfu54K/cysG6M3Ey4
         2CRzbv7CdJPGoBwK1782Jr9iUfZEb26Akj1K+R3nBFg1BlhnXUsP8Pljvx0mcKPGl/
         hVn+O0PnIIbeH2XaUDSA4kh6LQcIiObueWt12mOq5SgYBzaQQt+CmIEHAtvNiM7kR6
         bExpiY1xd0kog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1qCCpm1ERn-012nbb; Thu, 01
 Jun 2023 07:45:53 +0200
Message-ID: <7939e360-27fb-119f-8339-36a86c2b3f94@gmx.com>
Date:   Thu, 1 Jun 2023 13:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: new scrub code vs zoned file systems
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de>
 <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
 <20230601044034.GA21827@lst.de>
 <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com>
 <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+fkLohLUgqdUSt1svAy+79eDnY1PW9KZm4zEET9dycx8eycLNaL
 llQTEb+of7oTbqMPVhYvvsFBiBvrJxu1L0kMX61kYAXnA4zjY6jfqSpWdb/NwPd2Cqfjfqz
 HdH1SlWXuSZzbv2efA3H30WmXI/sXCwPt8TTjWp8wvIL100Cgh9/UnDXcfS6Dt/x+1R++nL
 fIodkgI8eavN34+QCJrSA==
UI-OutboundReport: notjunk:1;M01:P0:Mm8STOh8DNY=;k7gSn+Z2F3FVNUsXiJQYbIh6+5U
 SMIPXiuRxwyEO6p73bKYcj+sO7GVZB3vf/1Edo9Qs9/xxa7dAtytrPEbXtCOPkd8y6fg4FdlQ
 OnBiF6jRWLsrLamDrNYY55X7VyfZlAsmLAiT/lSkvXToN5G1VtKfvj2JWjCfc/tu8waxLEgxg
 wcq8XiFuR3MXYoQs943VnLdp7ldtzSnZz/OeXpMltaorZOmG6Au1Hjt8+tCBjDxOgk48EG17j
 JZexSoIHxvgQjoCgqKmIUIOJHE4XoX8IJ70bQ5KnOlGE0Yg8pIVnoW404qJjkfNvI7GMM4oM9
 VMWMnGt/gN9pzmYWwUtnypCHdUQTGcJ2AG5dIFblFIMPkNR6hREHLADfCcGmBtXQtDowiS+bi
 d8chXB2BYFq6pml+HYa0lr8MeCFefWrWdpPMplk13NUbbNZ6HEjP8pcjcnSy3BQvqJyeTTfL9
 Eq1bTYwJGZxY0AdLwnYaARHdjFeu9KLuuEh6IIC+bD7nFSH8Ld3MOeLgu3qbd288pBhY1e0D3
 B8hNrkITYSK/XM5bBEEYMjrZlb6EGNhRtsw/DgBLM+l18L64yTI7je+MulNsZgGwG67EhT2MU
 ee3WLfVMfG3af6deQRnC7CmhJGSAXF/zLDBNUCKT9uhi7lZ6icFsf7bYVVCOKb6dZXQO5cMhp
 HTXu/UF0BKAuVxdKn5ShzQ7uR2Yk6pVxE8nvE+cQUxgqRbMwt4kW8cmxaUcposK3+e+6o1R5q
 Il6zmN2HUvHFXEbizvpo0ndAyXUaTf/SpKLMnYHXBwCHzY06lwu0HK25cq/nd/R+FMo1YD71R
 d4p2VukGKhfHummMAsZ1xoVjzsKn3slCiCU0IZ5/m78xsk7jiXbsjD+8nMTc8lqVsfRHgdG3x
 uMvJ2gxSZ4opSQhbRpkytyIDf1e6HZpvLlag0tkYj7bWgwRR34fF/1N1bSETIwhF4sJR6Qvm8
 isamWFQqywGc7pPaqmyPI+LT79Y=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/1 13:17, Naohiro Aota wrote:
> On Thu, Jun 01, 2023 at 01:00:40PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/6/1 12:40, Christoph Hellwig wrote:
>>> On Thu, Jun 01, 2023 at 10:09:24AM +0800, Qu Wenruo wrote:
>>>> So far the various wrapper around the write operations work as expect=
ed,
>>>> and hide the detailed well enough that most of us didn't even notice.
>>>>
>>>> E.g. all the zoned code is already handled in scrub_write_sectors().
>>>>
>>>> The crash itself is caused by the fact that end io part is relying on
>>>> the inode pointer, that itself is a simple fix.
>>>
>>> But the reason why it is relying on the inode pointer is that it needs
>>> to record the actual written LBA after I/O completion.  So it's not
>>> just a case of just add a NULL check, it needs a way to adjust the
>>> logical to physical mapping from the dummy added before the I/O.
>>
>> That's all handled by scrub.
>>
>> For scrub we're doing the writes just like metadata, with QD=3D1, aka,
>> always write and wait (and know where the write would land), and for th=
e
>> gaps we would call fill_writer_pointer_gap() to fill them.
>>
>> Thus we don't need to do any adjustment (unless you're talking about
>> RST, but I believe that's a different beast).
>
> True. For the dev_replace, we need to place the moved data at the same
> address on the destination device as the source device. Thus, we need to
> use WRITE command to ensure that.

Oh, that looks like the cause.

In btrfs_submit_repair_write() we set the bi_opf to ZONE_APPEND instead,
which later would trigger btrfs_record_physical_zoned().

So this means, we should not change the WRITE into ZONE_APPEND for
btrfs_submit_repair_write() for dev-replace case at all.

I stupidly thought zoned device can not accept WRITE command at all but
only ZONE_APPEND.

Let me try it locally first.

Thanks,
Qu
>
> So, calling into the record_physical function looks strange to me. It
> misses some condition to use ZONE_APPEND?
>
>>>
>>>> But I'm more concerned about why we have a full zone before that cras=
h.
>>>
>>> I think this is happening because we can't account for the zone fillin=
g
>>> without the proper context.
>>
>> I believe it's a different problem, maybe some de-sync between scrub
>> write_pointer and the real zoned pointer inside the device.
>>
>> My current guess is, the target zone inside the target device is not
>> properly reset before dev-replace.
>
> This must be a different issue. Are we choosing that zone for zone finis=
h
> to free the active zone resource?
