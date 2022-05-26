Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B345534BF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbiEZIta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346782AbiEZItZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 04:49:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC9EA888A
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653554959;
        bh=Bs4Qe5/Fvk3BsPwohYCXMn3CfJ+Uo8ojZ/I/O9sdHpc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JM2n754tXzswF0rqYlk4en+kWdanQFWW2r/laf/vcX5uxDFp1Dae+UqS3/VK7EZeD
         iZeXWcd1icmEjSo91gS2KmdBtlqaxJueqIx+UtotK9CubEMoIpPft/UzCacigFFD2m
         XHFqVQOwNaZ8ljttuQadujDuPY3bCkB1qUl3m8oI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QF5-1nslbP1KeD-001Tpr; Thu, 26
 May 2022 10:49:19 +0200
Message-ID: <f18c85ef-ff11-8308-4562-d68d4578d6f4@gmx.com>
Date:   Thu, 26 May 2022 16:49:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
 <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com>
 <20220526073022.GA25511@lst.de>
 <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com>
 <20220526074536.GA25911@lst.de>
 <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com>
 <20220526080056.GA26064@lst.de>
 <0cbbc3aa-a104-3d5e-ad13-a585533c9bcb@suse.com>
 <20220526081757.GA26392@lst.de>
 <78c1fb7f-60b7-b8fd-6e3c-c207122863aa@gmx.com>
 <20220526082851.GA26556@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220526082851.GA26556@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5HF73lpv09n3/FWL7H6gP9FbUD6J+wxGSZlv25xNa+gh4Hnri6A
 Hh1MXjq4RVXwgU7v3M2Sr7B2zrOQkhu5wi0UvQIHcl62TMuPiZQa26C2DPGEJPalyILW80t
 vMWaYfpO93mpMrfvhbLaQFpBVNo60Axc6ZglcywheenCV0u1L5i5/HE+ZyDr9JUbOWZ46qR
 LNk8+O9E8Avu2TMJQjQqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/AnvUvaKvxU=:FLfgaZv48SCQPgL0CuyIrl
 iJG03ogHe4oCzuV3KVnlAGU/02YEZHOkevYgUTB3Yg+KtZ3MGPwwYJjspf1AeElRKwmxRmyCy
 +nvSAsBSCZZnc1jSv9QyH+zhfaPnd0CwYxhkbtcy80LqAVJC74z2G7mr9Qwz0mmVr5w+Tbrs/
 J5G8EEK1bwvmvIyRRpkJyOrXLDSw7yAHLlsnxaqtwH2mrHCuiM4wPAsX6aufq3KlASXKH6axO
 epZcQNEONrpgmZyNlZczCrEpL4ISN9DJuIw6js3Mv5OZh2GcvDQZGweOrUsW9oMsgOHUAectP
 lQfjXWn+3ULaSbGJxYmKyOLNLGx1z52Urb+mod/Bd705QafwgJJCu2pr1531GMVeJjwB5Fiw+
 QYE3DmArmHeMlxfMkXgYFOAlAHlYoz4MTueTQrmY0beURhwx7CPeDXjCiTPz9E7hsET4of6H0
 lQcoU4jbcNuSpVQ9XiM0GJX+TV+8+7orEpTZMu8Mg+DnjwDJWzvG8mr3NJFfdXPuxoe8llLRy
 c8oo4vki+zvl208/ABq2+Pd/y19H7LsmYE4nqDuBjaBfy1KsOjE465AdGGL+/FS34Etb37/bF
 5ll8R6CP4+e5TvbWkCNOn6wkXV9yPn/F0LdzR0XqNs6ViV1vBFaXXULo6FC7R6HO7w53O6JYw
 gbI2pcMnJWSF0ZknunhRrrobRpFo+UlnSQYzn2YVuZpaZ3GvXy2sxEniLOGHk10W6A0LP5sCd
 j1V9L3EkyKRtbLLmv4QOpeVmXyyO79X3ccJEyDXeJ2V5TPxf5cpog9f3+DENRlW85hoUTJUUh
 8qfpB8Ipi+JELccgoFdIIucQ8dvYOWGPRcD4p1wKG6IGqK1BrVv+ypYToSL9lCxVET2cZ/WYt
 vA4WtT+nSnGkv5cU+e6fU/nCq+Nto7bSXLY44NBEOx69OQDajPdPr1vkYdM1RVcR+K9IlYCgD
 ZoYayzaRJsi2cRKNkGCnwsAghUTudHTtZlQBhKbtDBLvxlX4OKvgnpGTYFvXPRg0TtSsASQnY
 T+tKUDDbjsDhiO+QB8OztcBHziX5xjEUuwirSI+ndhdPypjuJZMQY/yw6ymHZz992dPKGJKO4
 lhzoVL2UJl5EItIl0ju4EveNZY+U04WXmUMU/FQwa9m6J4n16+HIsC5aQ==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 16:28, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 04:26:30PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/5/26 16:17, Christoph Hellwig wrote:
>>> On Thu, May 26, 2022 at 04:07:49PM +0800, Qu Wenruo wrote:
>>>> Then it can be said to almost all ENOSPC error handling code.
>>>
>>> ENOSPC is a lot more common.
>>
>> Sorry, I mean ENOMEM.
>>
>>>
>>>> It's less than 1% chance, but we spend over 10% code for it.
>>>>
>>>> And if you really want to go that path, I see no reason why we didn't=
 go
>>>> sector-by-sector repair.
>>>
>>> Because that really sucks for the case where the whole I/O fails.
>>> Which is the common failure scenario.
>>
>> But it's just a performance problem, which is not that critical.
>
> I'm officially lost now.

Why? If you care so much about the code simplicity, sector-by-sector is
the best.
If you care so much about the performance, the latest bitmap is the
best, no matter if it's the worst checker patter or not.
