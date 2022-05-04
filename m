Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B117851B206
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 00:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352441AbiEDWoX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 18:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEDWoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 18:44:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA7C48888
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651704036;
        bh=RN63m0DGGqfYlQ9ECV9b1BoYKYtB30F8m/8QvnI1EwQ=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=JQjLBh1QTJyVYC6js7JBBw+sgUMXMkULuAIH0Wx7MDpdqrrpXyt/ZOB3wzQGDXdYV
         xcNXETMs6cspVvvqXE55A3QCozNtKhlvO/PJzAd2SwYya8tR1R/njxWNN8POFEySf5
         JjhP8TcpjkI72hkC9QJYY0MMWFJsUSWZbhfGQjUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N79uI-1nuLlv1IBI-017SLB; Thu, 05
 May 2022 00:40:36 +0200
Message-ID: <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
Date:   Thu, 5 May 2022 06:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
 <YnKIM/KBIJEqU/6b@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
In-Reply-To: <YnKIM/KBIJEqU/6b@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cehFvGmGdMsv6Y/zqBXzbxSQ+IETLJH2cJ8m6UpvkSeV2DBhsSi
 yCMQKRXw+DhbRnTh3POWa4mfq4nmOYJU7CzEgDPPYvBj6866LZgd7EPIlPdZK3ivhCphZ/I
 K7tgPn1hskyfe2/dBCVjbkz1zzhNSdQUQfWvn1MoFMLYQlhJlj3nBK7TXwkTzWw88VvHNT1
 nCnibByM+uy+lGmckFnxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:om/IPemMYnI=:1GvTw1caSJmW7GrlSyWumV
 2cxalO8nrKmM0jIKy96BDyXZtrNAEVSJN+7ZOopYxTH7Aqzmlft/rt4fOfedBgbwKAMd35gt2
 r+01ArP+9vd6XiylhrOTg8+Wri23CBbAcd1/EVG5v3/yPuwXomBkDGANtHeB2FY1sMUXDJOKD
 9v/nJe0Egj4IOHITzXoL4DQFrB34dqwqQCJSdBnVcQIX6sN255OGXEPeBEAKvMEPEx4AwVIr8
 9RyaGyzBcl5X4e9vLZiWrWoBaBEPas7U2rxDhxaGl1aVrJpoNQh4/DfDR+IYBj1K3UKVg+/F7
 4HUi4eYppxAckDe7EcI5JBKc2X50mIZjqfpy/j9EGisfhU50XPupnYbwR8gSqliyO9MdFErmE
 evBYRJ8yL0DODt5tnPO4yraV+OLQhBRenaBevEZE/3r6Uw2MkKkVc/H91jXK6hF/vZMWqXst0
 igHI5wiyUxujWkCVVZN7dCZaKz5p/gW4XmYc2++Melqjycp2El7N8jWke9X9oE6UcucNrmTK0
 SxdlKwoYxpBy4Xfua8b1EMsUj5sCQtLXZlRPRCloQEegtoqHvmFuynb0wbXfJcWEkONsLdJ2d
 b6eTjMxZWrio2rhuw/iCteEzBGiUdtRlzNs6gsNVoc3r+RrZb4kbcP4f6SdYzdD0fu9ZXsQmQ
 wjqhWlmqYraaDoKIgkozMnN5Z2FG5Ky8BdUwznxReE1u6uI6TUQnM4doeC09gvcRSjGm7a4/x
 PH465TSHimapVVPyxGttggvUr8y9dBR5C58bpj/91eai6WDi/r8ljxYZyzHLuCqNGm6f03GKp
 Z89ehbXe71sDxakIddfUHXHY7WgwebLAYSCfEJTKELDvf1PbzORKuKUHxpXknwKcYVkD4Vjaa
 cUFsrP0Mr8CR51ZmVbhvGUWtJNVF7JG8XnEW7kQSpT+1a3MeZm81Vtc9Sv/H8zEwdbI1vbGOj
 WUWNx+5iFrjhJQX+Ilee/Cf87D5T0sGThrPVc5SxBcAyUFsGAx7soSco0NXxkPQ9MYIq+aT9e
 /PYa2byxSVVbZUongQ9hdScytrk9kJbwbaIUMrkpXbqlyb2jMpcsp/tAtAKFqnZrkt14tekPS
 35PQrsadWPi+VI=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/4 22:05, Christoph Hellwig wrote:
> On Wed, May 04, 2022 at 09:12:50AM +0800, Qu Wenruo wrote:
>>> This is a really bad idea.  Now every read needs to pay the quite
>>> large price for corner case of a read repair.  As I mentioned last tim=
e
>>> I think a mempool with a few entries that any read repair can dip into
>>> is a much better choice here.
>>
>> The problem is, can mempool provide a variable length entry?
>
> It can't.  But you can allocate a few different bucket sizes as a
> starter or do a multi-level setup where you don't have a bitmap that
> operates on the entire bio.

That sounds way more complex than either the original method (just fail
to repair) or the current pre-allocation method.

We need to cover a pretty wide length variable, from the minimal 4K
(only need one bit), to much larger ones (observed bio over 16M, but
only for write).

It would make sense if we have a hard limit on how large a read bio can
be (I have only observed 4M as the biggest bio size for read, and if
limited to 4M, we only need 128bytes for the bitmap and can go mempool).


In fact, the original one (just error out if failed to allocate memory)
is way more robust than you think.

The point here is, if a large read bio failed, VFS will retry with much
smaller block size (normally just one page or one block), and if we even
failed to allocate memory for an u32, we're really screwed up.

Do we really need to go down the rabbit hole of using mempool for
variable length situation? Especially we're not that eager to ensure the
memory allocation.

THanks,
Qu
