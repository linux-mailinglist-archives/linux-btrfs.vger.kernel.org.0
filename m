Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4CF5E7886
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIWKjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiIWKjn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 06:39:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D4625C48
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663929575;
        bh=LJ+DUuz75ZmIk6HOQE1yB+wzMDFGYyQ4TCChjFH7W94=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=dZCjn0Rqhtndlxik+qBpY4P3JAxSdRUHmCw89pHjTISJollqOMdHhf98enwL8P3Ae
         qZVhfzWpnA+1xsmBgeBS7zbwRkdJgPel1n5wkI/74DB42zn3Ty5h6xPxOXq+46wVjA
         tpFOPu/cwVfusd6XAO7xyPjIvoCsd0Z7ncmQbNlo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1p9MLi0OPN-00aliu; Fri, 23
 Sep 2022 12:39:35 +0200
Message-ID: <4d8f3ce4-f488-d065-ef7e-c7705ac4efee@gmx.com>
Date:   Fri, 23 Sep 2022 18:39:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: call trace when btrfs-check tries to write on ro-blockdev
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <70591e96d9dbc46cfaa44316f0eb1bcccc7017f5.camel@scientia.org>
 <6d72763c-d024-3224-be8e-0ade32540883@gmx.com>
 <52bf0daaa1f88fe1069f4871e28ca18a90d1d5c1.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <52bf0daaa1f88fe1069f4871e28ca18a90d1d5c1.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/GbnxzYvNPm6DZJeRPdmW269sfKARO1kco5WMTDkOVaNqTeRezU
 LJVcZlunoV5UyXmXj/KIz25kNnXGThnaJ0M3aL+GQdcEn7FOQmXbq9YX32QV5SVUVOWk3o2
 xAG+V+jFFAnx+MkITwosmOAntAw6w3XLY/9iBFPKhM3D2675T0x2B7HXPdRv+USkgmpJIZ6
 +l7AXQDDzFA54VwEr/SNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3B6B8xljFV8=:WnFQNU2++Bc+czy6l6SEVL
 cAG/5QXfuV2wtKbnojjNCTBynv8sXVeEpopCXGu6QoLnKmm4+5ozSzH75UXfdu0pRAC0CvlB9
 lLxybJBB/4dpcbttDDk7kIg3sd/JflnhjPDibldOtMMzzYoLzFE1iNk1aUrYhktqRuJ23Gdxi
 ssk7BE2ErnQZshjkJsXw6nCmXHGdimu8+iOMXO2eK3IC6F1ijicu2UXzaoS2XWIeueegKK1QK
 5DHK3pGAHTnP3v1Y5RMm3X8LxvrkhTp261/rSvi8kYYOK5YDTRj0FRsItlkE5dd9a/EZeIPyX
 zx3IVDi64qXVZz/CB8PiZbSjrKgCH08Oxu6xQKwL/iAFhPXiEjZor0ooPhFci2n0bMlPgeZ73
 NfU8LHta8N/Bd8EkBqRSkTcThjBgHnJTctBqOH9a+W63UH0F60gVAE6/uMqdauaSuby5z1NOy
 5ruEb3bLsLHXDsVkRjdVRnyzos2i0nnsOABOonbB0pvbsuMxnjFdLXgBusl2pVHfPN+yQW6ko
 86WRf6I6MOGfrpwiGkJbn4HB+OlsyFK9UTK+ftUvgS6yTM+yhhTmmcK3wA+BEHfFozh0LsOUu
 EDtVKXL1XZbPTJ7NU73Ju9Vs3rY0yaWAgL/rISe+vZeHNd4FMSXFkCJ7amG8JUwvkGl0xL7+9
 8SytqivM5wkjOsEb/EA1ZnCD3UDoLQcquz7qkj0HrzHJsHUJo5M/FRdTMtfIxkdPaIxeileT1
 nzpEG5kPjFd7s7JlSteo6sfqXcx/hnRYQ9z4TWI9HREGbSHKw7yQtHLtIBkew5Eo37wKRVEkT
 no/7/VSO2JkdUgrF+nRXTfbTc61xU2XpHcwmK8J6pxOlSStFTe7tdEbwSviKkKOPo0ZO52BMB
 GXBSPKfP4jFs5Az9AfbzfYCSqRQcuFyMlP9Lh6c54vzC3Hs/B6Fx7GBL6kv2FnArB25IW8Sj8
 1aJSHzLHF5f00Uo4esX7lQ2ss0l23BQcJis0wWhGhybYNHynv+rn6PbL1TwCOUR/tBBy1s3dk
 Ny+nIx4Qpn/6v/h2TyNYigr8l0KYB49zt4EF7CVZXKMuymowoZoCpB/V0ksdaTB0pSASFCK1M
 +9yBDAijT8pQWmFFUy2KxoIzMPrMHIYmde7KO6Sls/mJQf1B9Rw7wqLW6rDEcPGJOiuH9z93Y
 7hWxGKkFknKhn0jSQhQL4bDZNf
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/21 11:43, Christoph Anton Mitterer wrote:
> On Wed, 2022-09-21 at 10:40 +0800, Qu Wenruo wrote:
>> But my concern is, why this is not reported at fs open time?
>
> At first I also wanted to suggest to not even do the (possibly lengthy
> opening) if it's anyway "clear" that it would fail (because of the --
> clear-space-cache request and the blockdev being ro).
>
> However... if e.g. --clear-space-cache is used, but the device wouldn't
> have any space cache... then it could still succeed, even if it was ro,
> right?
> So maybe for that case it would make sense to try.
>
>
>> Let me dig deeper into the case.

Got the reason.

With block device set to RO (blockdev --setro), we can still open it RW,
only when we decides to write it, it return -EIO.

Thus the open() call with O_RDWR doesn't ensure we can write it, and we
should handle the BUG_ON() during metadata writeback.

Thanks,
Qu

>
> Thanks.
>
>
> Chris.
