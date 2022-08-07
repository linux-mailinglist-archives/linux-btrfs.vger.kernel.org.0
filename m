Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9573258B8E1
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Aug 2022 03:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiHGBYT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 21:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiHGBYR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 21:24:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB94E0DC
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 18:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659835449;
        bh=1CPbgUlCkJu3WeVUCnpJvzTR1+WrqFUzXF7dAsSvKZw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Zh8hiKsZE/GcTjtZ7/TD1DIaTNQdmrWKXB4aFNW4l8RBGNoNlx35+MCHQledkSHPV
         r+E+z0rjOot6FiktCdZ7PTSgRfOrX7abUXP/HbajeVVT8gSPnKzw2qesw1BAPqGqWf
         uHVhIOCxHMyeUxCfNCQhOs3fHmZxooBkMxX83YAQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowKc-1ndDJ01pra-00qO68; Sun, 07
 Aug 2022 03:24:09 +0200
Message-ID: <80e1fe42-6c9e-0da3-fa1c-434e3577033d@gmx.com>
Date:   Sun, 7 Aug 2022 09:24:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: the 1st data chunk(8M) allocated by mkfs.btrfs can not be
 allocated again after full balance?
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220807091957.17D7.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220807091957.17D7.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IKhCBhHdYjjxkbG570SQ1oKq4KFMni46FiyGeKYoEpP6KX0DiVE
 ixa0XrHedVQ0fqCnNHAcohaypCv3Q+SSmTf1BRz11L1usNoIu7KMnvrAlMu7aSPhsYbZNoF
 AxD9baDUfo+3iqBHUPnt9GZlaQcPGcjA/WWUFoZTGcneldr27K9AF7XH+o6Piqi9B1ceZNl
 /5MTqlDc/RU2XBMpWmcTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Zik7Hyux74=:TXJPncVSIx7yfLEpaaW9eL
 AL58CW7ZsYYzEDjbKZdsmmYTlXd+ngDXwx/5jzhfVoLdJoeGmS3YrVpzDRBN6L6oVXw2dd8RS
 2ycfGv1k7GoVGPW1Rh19eetV5pWIicwihTp9K/GUZlkpWjiaryQe5Fudyymbg5h3uXwIpp6Sz
 CWH2jL9aGzF04LWhRlqML4DHcDStW4DG+CJnIwxcGSpl0pQCFERVcCaLEnoLBkkJPhnEl7K70
 6td8WMLNsKQ0/sSHhf7oCjHICvQLngC4l2bhxUk7ZS2uPQGPJo1260z1TYDzxTVf9aRhOSblE
 efsMQcfPDi5eKgeWHlXpCKuAua3dJ/vGIxAdEU3xsdTDy+O8auucGuSESnTZCJjGKY0Hgo+Vl
 Bh6CQCtWotHjcy/EUMlI6eKi6ELqFWT1y5NYsdMlHanfvd5JlclRsCeS8AVdNThSmQ0IUYlBp
 5EHbnvZKqJSa4/vRKKyu6iAy46Zc0nQ8AEwoCdYA82r+0d3i/0eQfqAcfv03Yhpx38lPl39B2
 VN5AV5rErpvs3L74g7p4/O1+xkL1ZN6GIshnYyj6nOTi6EQAkIfNU0DlCtTFo7qmUoO3uDAv8
 3fjthD7c4TCYdNZmezgKD7nhUMphSWwSJth5S2/JudCPY5TU6wqHiW2fcbomE+6XpiUt4W+MW
 dVJmCmrrp612X3vf4PBNo/JCyLyZ1S5nOKLmmR+JXkLqh71rGIwu6xJKrNKFUV2fTed/0Xxcq
 DBo0qP8fDEai8UMa+ypexVbnVi0/OW8rxUZMUN66899esIb9IXfZPjYF1yB4XWF2Zjdf4EZpf
 cRFQhgpjyHrYPHfFk16DoV1kBKjVZkxELcnV4u/VVcSU8nxXi5bWtxxXOsOW1nXcVAu/4e2Z9
 +pguWdb6J3vBHAi9MciNiSHpWm0whIooR8XzsxNcNJ22DEzCmFpT8Y1qelMMwd9WMbPkYpk6i
 nXuweDai8bGX8S6Dquk0M7aJ0O3S/W3nfb+ByXC3E/aHWY2skBSOzQkT+AF3Q95n4KfADGoLB
 e+Q9EmnpleHQudMt7tjN1/r7zC7CHSGOwWrcQ4ElKDLuZPf+Z/OfmnFBAZs4G56+BikjHbsPd
 nEuDGrF2EogL2rP/oNXHPxPuWx0SuULvxG4MJZf5kziT8gE4+bDfXptLQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/7 09:19, Wang Yugui wrote:
> Hi,
>
> The 1st data chunk allocated by mkfs.btrfs is 8M. After full balance,
> this 8M chunk is freed, and new allocated chunk size
> is changed to 1G.
>
> Then this 8M space can't be allocated again?

It can, but needs very complex relcation, e.g. relocate all chunks to
other devices (e.g. delete the device and add back).

Or run very low on unallocated space.

The reason why it can not be really utilized is, chunk allocator will
always use the largest unallocated range by default.

Thus such small 8M will not be utilized until no more free space.

> Or we should allocate 1G for 1st data chunk in mkfs.btrfs?

I think we should follow kernel allocation size, but I'm not confident
on small devices.

Thanks,
Qu
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/08/07
>
