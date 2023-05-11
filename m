Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A476FE851
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 02:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjEKAIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 20:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjEKAIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 20:08:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6023ABE
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 17:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683763668; i=quwenruo.btrfs@gmx.com;
        bh=PIivfTw98jGITJf+DVj4atGIdq7IpcRxikBtUolkYrg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qAwIfndhw7ZlcBlANDkCXP7QBTMdYjOq2YZw4skA+4XJs/U/P03XdaJ/ESfHTqPAl
         K6JeN2+8lNmXnSw4QNFr417vswUBNguMcIPCAJbTMBTOqcfm2j9d7+J5Or8ZNz9TNS
         2MYpD+rFJwSIvT+B87jl3/xzG2sYt8Z855ZZ2bpgQcBnCb3VITeRki1wjSQbe3/IqT
         xtkQrWchZzWdJEYA1nvmn6Q/C7t0T5QfTeePM941WS4jckKftlqYGht4f6/WRJuMGR
         6y0hS+yJEbkXU1iaizIKiSSQ79gnf4RssaxW3oqfuQakTpz31/xC73Z6YIaZHHV1sR
         GIBn99rvtgPlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1qXZNp0g0L-00qERW; Thu, 11
 May 2023 02:07:48 +0200
Message-ID: <70eaeae9-ec51-d033-4810-9ed0699fbc76@gmx.com>
Date:   Thu, 11 May 2023 08:07:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/9] btrfs: track original extent subvol in a new inline
 ref
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1683075170.git.boris@bur.io>
 <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
 <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
 <20230510165705.GV32559@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230510165705.GV32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mk3ca9uuhKS2dGt53p7HskT+6gcUuIAuBclPsmPbg4nldUr4zOk
 SjXimhohUzreBQ6R9gMJfm113NXfksfSDLOvtvVOI+oHXOm/7Jo+0cgR2cs1R3LQbSvP3MY
 QuYLSIEW5CzPw05U9QAi9Z5y7ZGyJtpNNxn/x2DsKKOYOTTfzLDCakH1oihpUwHxpnwcegz
 3BX14keDURowhb70fgmIw==
UI-OutboundReport: notjunk:1;M01:P0:LTNLdx1ZeUc=;pk77VxHfFbnArVU7q56N4XGzrZC
 kaIyhzzkEScxucKElCZLuj6n2AIoyH+daVo2DPlLR4dLL+SpPRZXuk9gz31Yij5zDlYJ+YkOE
 wLbzQPDYb065ll+6THbtJY7mobpTzNbQvMBACGf9rp/B9NhmKMsIIztzpyhZCLcrtQKOXBKSC
 JvHvMHt8jGlQp/C2MrX7pa5Mh1GY1gIvBTKVpf3sSH6sdr+wmJtRGsGCmn3rdn/zkbQI6MGby
 Dta5qZjQjzLXbv/vvOnJZkCS5J7tKPm1u6Mg3Zvi1Odux/kXrxLjZ8kwQPnw29nNtk6zmq3qC
 FoiUSnlO40K53XSFEWhaRjbUZ7Yh13zl45fSbCg53MvU9fGzSpNMB5CGSOsezY6MOPsQhgY7w
 WnsUhOy/3Ku75LezhzRj7izYf+lRH7RAL0yDhCTh56LTPf8BejzzOh6RNnDk6x6gOm1Jv1KbR
 dp2bXPX/eKycqrEouzo2hDryvhrvr3ZN5E6NOP+1xE4ObVe8TJcsaW9Zo/me6/Aa6yD4/v266
 WgLyi1LOFbNr6VY4nfY4tE9TgCj1To25ZQThRT9LiL27B3f0kaKcCEv6sRKFBkeKZ/3xPc+fc
 +3fEk8PwsVeMBdDrtLjSe+9TbNIOTVvY6QNhOhnX5+tFuQtB2bzubIQuCudv9ZRC6kLBZH84y
 AzrgiJQGhII6dYezzXiRUwjtDhwO3CBgSZ9LCUJZvUBr8ucjFNUnsJuQLMT7prCNy+UdT0m10
 6bIwLl+q0hdy5OdlCvxezcMFssfw/DiMOB8uJ8Io/cRaEjDCKgx3j024sysfwuyKDYjnZGATc
 X6n3b77Ac16Caa8oJwn7EBrQcTAFP6t+T7hXkvvt0eAsxomz2KXmnxH9IAfWfC/rco+fC+PFQ
 xT0gllXmFtZM+jKQwaFQgTirWNHHbCVLKbqazJlHPv5vBafM7ANu89AxkCALcMamm/Jq3zemH
 yzvdr6JDI0sjrliC6bpaArmnybs=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/11 00:57, David Sterba wrote:
> On Wed, May 03, 2023 at 11:17:12AM +0800, Qu Wenruo wrote:
>> On 2023/5/3 08:59, Boris Burkov wrote:
>>> In order to implement simple quota groups, we need to be able to
>>> associate a data extent with the subvolume that created it. Once you
>>> account for reflink, this information cannot be recovered without
>>> explicitly storing it. Options for storing it are:
>>> - a new key/item
>>> - a new extent inline ref item
>>>
>>> The former is backwards compatible, but wastes space, the latter is
>>> incompat, but is efficient in space and reuses the existing inline ref
>>> machinery, while only abusing it a tiny amount -- specifically, the ne=
w
>>> item is not a ref, per-se.
>>
>> Even we introduce new extent tree items, we can still mark the fs compa=
t_ro.
>>
>> As long as we don't do any writes, we can still read the fs without any
>> compatibility problem, and the enable/disable should be addressed by
>> btrfstune/mkfs anyway.
>
> There a was a discussion today how the simple quotas should be enabled.
> We have 3 ways, ioctl, mkfs and btrfstune. Currently the qgroups can be
> enabled by an ioctl and newly at mkfs time.
>
> For squotas I'd do the same, for interface parity and because the quotas
> are a feature that allows that, it's an accounting layer on top of the
> extent structures. Other mkfs features are once and for the whole
> filesystem lifetime.

OK, ioctl is still better than mount option, so it's acceptable to me.

The other concern is, would this be compat_ro or incompat?

I want to ensure extent tree change still to be compat_ro, which may
requires us to make sure unsupported compat_ro flags would not cause any
extent tree read.

We have already skipped bg items search, but we still read the extent
tree root.

Thanks,
Qu
>
> You suggest to avoid doing ioctl, which I'd understand to avoid all the
> problems with races and deadlocks that we have been fixing. Fortunatelly
> the quota enable ioctl is extensible so we can add the squota
> enable/disable commands and built on top of the whole quota
> infrastructure we already have.
>
> In addition the mkfs enabling should work too, like for qgroups. I think
> we should support the use case when the need to start accounting data
> comes later than mkfs and unmounting the filesystem is not feasible.
>
> This also follows the existing usage of the generic quotas that can be
> enabled or disabled as needed.
