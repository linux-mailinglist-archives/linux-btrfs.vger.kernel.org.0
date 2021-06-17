Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B941F3ABF14
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 00:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhFQWtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 18:49:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:40759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhFQWtH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 18:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623970015;
        bh=Dn/Oc8B6qJsgBQvhDWwbGMfVBf4cK4vDgghSsy6WqX4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=H3EPUD4eLCA/J89rBxP4cfACB0bQaMF+1S33TiGbYbW08JDdGkm0SbJbYqIL96FyN
         BiqeVy4/GhtS9KUlz5iPV7u7vRYc1Nf655+qDXD9DdzJtAQhmRRH6BTjlBwE6IItaa
         w3O3mmtGufHXttVn8qaF0hUxf4gxDbvNBSGRn/hQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5rU-1lgj5a35km-00M3qq; Fri, 18
 Jun 2021 00:46:55 +0200
Subject: Re: [PATCH v4 0/9] btrfs: compression: refactor and enhancement
 preparing for subpage compression support
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210617051450.206704-1-wqu@suse.com>
 <20210617164703.GW28158@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d184445f-a1a1-3f17-c33d-ffe3fc066c66@gmx.com>
Date:   Fri, 18 Jun 2021 06:46:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617164703.GW28158@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5csoI25Syf6U3E9KJD02z3x6jDYVIcgtnqSUFBquwlFfVSPKPen
 g4+ArFebnqAizKERmXPBcu3OVxHIfRluQK+i/ou5wKwishyoSgAC7FlvIyCrf0Xu5npz4jN
 4D0DP9ES38lpZ8rjp7EZ0GgU8j5sd5OZNuwKo/nJrRMJSrhMGI753nzxvC2zWnApA57iKn1
 53LiGzkK4r45DLgbKNLvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MI86MD2jD28=:A1UZWf9Wffc4XoG/g8C3Gv
 +HvYSiF4we+NPr4/QVW8yWhAR7zrNU0sRskcrUpKeIQu5KeIK0s4Piang4GgjSXbJcPuAKooJ
 B9Iqr8pxlTiKTz+7jB6ic3bKPjnlFtI6cuE7pMrqW1yC1jpl/AUZhZ/uPgFCvnjMrAoJbN7cI
 8rH9g9N2HWxGNywL5PqrurohtFHJwfmffDzu6/sT3c8o0E/LqS2q541zm8hw2XRIMyzdUur/q
 CiqGwHVb3JErOaAKWx9y3roV4NHmP5ciiWmzzeV573hJr3eZlCYVrtQRXPzL5iJvuE3I1jzYZ
 ha2YKDmvh7i/9A9yNz0BnRhJPhKSJEQXweVg5E6w1sALLl2EmlszlY3oprN15WniLzQWIz3kg
 3qDMQdBJOAmLttXmiTneUU2uj2nVG8eGhiaFGkFFhNDkXrdXkY2djVTbBdCyjsha9XTUg2liu
 PI3YSrgj4j2f3iPOJ4Pe5PDTrtGPlocNTqkjDf4BL3fRvNJ+zRAfrej6CXZV2VgW6RMT/ZSc3
 taBKG7izkWFnb5jw8MRz8J4/g7ITF0Jh/Y76ISFrZVxM0E9b6KN3fec9ZqTS7p3b01Uihd+rG
 5tsg9lZK1G8/ZHvTcJ3Mypg62lhLbXmPrYPpjAL3wrckRG2jxoMlL6BWCNr5BDIpPAKwqKDhc
 n/BymBZMqN3t6VJC7fnOJq18yWbLeAdhxzCe2i9uUw6w3YHI5QTzdV8iRS4e7hXKMR6/mEaJm
 XPIfAJ4X3Ku75sH00iARqZhAzTtSDwpdTL4aWF8f0MkaEM/v3LZuCJez0aQrXAgFGwvWhwVaN
 DzH/mlsDtSDnmqvuP3bBJliyy+CdNa6k8D5S0WfaRAo1VJClRHtQ3dwyCKgojOVbEDaypC6wB
 JSZx3nQ8pR1BBSThdMnG4jNFtGSlaTvdnBxXEVl/VKM6yTYH4jOJWZqro2vBmnEFXA78ZWSjB
 fUFj3PqrdEm+dl80ri2iROev41G22UQFHRZ7lQ2eknHxRd93CGiPVgPI6AbMgietmoWt4E5xW
 uctzctYfTtE/kAfCCjERuCeVQVCyB1rEJ84v43uu3BBIjQMkSH8loHeVlBgVTpHxY7K66QBzc
 YZHsNaGYmdHch6ZM0gHcZdT81JV+6a96L2SKGMCW2s+hpwTLwZwZylA2g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/18 =E4=B8=8A=E5=8D=8812:47, David Sterba wrote:
> On Thu, Jun 17, 2021 at 01:14:41PM +0800, Qu Wenruo wrote:
>> There are quite some problems in compression code:
>>
>> - Weird compressed_bio::pending_bios dance
>>    If we just don't want compressed_bio being freed halfway, we have mo=
re
>>    sane methods, just like btrfs_subpage::readers.
>>
>>    So here we fix it by introducing compressed_bio::io_sectors to do th=
e
>>    job.
>>
>> - BUG_ON()s inside btrfs_submit_compressed_*()
>>    Even they are just ENOMEM, we should handle them.
>>    With io_sectors introduced, we have a way to finish compressed_bio
>>    all by ourselves, as long as we haven't submitted last bio.
>>
>>    If we have last bio submitted, then endio will handle it well.
>>
>> - Duplicated code for compressed bio allocation and submission
>>    Just small refactor can handle it
>>
>> - Stripe boundary is checked every time one page is added
>>    This is overkilled.
>>    Just learn from extent_io.c refactor which use bio_ctrl to do the
>>    boundary check only once for each bio.
>>
>>    Although in compression context, we don't need extra checks in
>>    extent_io.c, thus we don't need bio_ctrl structure, but
>>    can afford to do it locally.
>>
>> - Dead code removal
>>    One dead comment and a new zombie function,
>>    btrfs_bio_fits_in_stripe(), can be removed now.
>
> I went through it several times, the changes are scary, but the overall
> direction is IMHO the right one, not to say it's fixing the difficult
> BUG_ONs.
>
> I'll put it to for-next once it passes a few rounds of fstests. Taking
> it to 5.14 could be risky if we don't have enough review and testing,
> time is almost up before the code freeze.
>
Please don't put it into 5.14.

It's really a preparation for subpage compression support.
However we don't even have subpage queued for v5.14, thus I'm not in a
hurry.

Thanks,
Qu
