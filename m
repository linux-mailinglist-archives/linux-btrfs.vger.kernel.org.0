Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22B7501E47
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 00:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiDNWbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbiDNWbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 18:31:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88913C31EE
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649975319;
        bh=bQA/snTXhVQ4Gy7t56yLWP7a7Jb/QIbH1SXJw2ac5Tc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jGDegcAgkyszJfOXCKuTB3vrHRmYisIpvxPE+12aF6w0wX3OKBxFiSjsLn+OfQlvP
         mM7KvHVM1ukbQ7meC2XZYnf7nUNyoxkKwsCezQ1/OuWfS68Nb2jEa0vb+g5t5lAHYT
         zNLPBNxvPsLsYSjSOcF9Y7N0tfFPR3omCI3L0cm4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1nRAXj3zdl-00YUYn; Fri, 15
 Apr 2022 00:28:39 +0200
Message-ID: <ec6b3ca4-87bc-64a3-075e-a2e2dcf6461a@gmx.com>
Date:   Fri, 15 Apr 2022 06:28:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
 <20220413191456.GN15609@twin.jikos.cz>
 <5b296828-65fb-b684-dedc-6f018e5ece4e@gmx.com>
 <5b190bf5-892c-0856-e623-f6f716985b28@gmx.com>
 <20220414154341.GP15609@twin.jikos.cz> <20220414175122.GR15609@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220414175122.GR15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTmYDB94XBkzvxyK4IKXuUuUE3tMBwFXjxib9JW4qji87Wolr31
 F19pIA+GPRO/n0H2qkSK4H9FjNQZ7gZXzuQp5ZqzNASdYkdTJQgyTvJ6h07FczdUNxekr1k
 pX5WCxxisFP9yhDR22SJ4VXvylV6xQ2fWsOemALxh9SBgO8fIMGjLdxsSet1jU6TnEGF+wO
 /hYrxEMO1uoRl58bWK/2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8q3DyRUOEAM=:l7V8se3mKPzRBT3lGoh+w5
 ArdTUgMFqBWIkTluY7ib7lgavDtDbPLPulSwsydD8VdN4OqQ8OWSRs4S0x5xjJI0bHqZOHGoR
 XAgfQ+qavgk6/teUsceKPlICghzXDqaCzejsgZW6HL5YkUERtWHqSalPt1RjeiElEJYlfrXrF
 wmxEOyU1HqeLom+mUhOA0fNJk+FIL3tURmHeKvjl5mGz2u1fcy2OnRbPo2qEd1te6T2X7CDdl
 LKtBwTGXqXEqLJdq9Q5iheQ+c88oXtkKQW5lwSYtCgm2LYSkiE2ESTnNu7XdEfuEISyuXGJ3j
 LPTvW2gIFePcEHYSXygTebg4RNcinkkMzcIEO5GMhXzHdO6S2/S2zfEvJJ2A2E9cxuSTn+b40
 YAmZ9jKyaALWpO+nI2kPg37SpVnAgwLjbJFK3jaYpbR0NbDxyYDsF0ZWvkBBbpHgNx0rrrzB5
 oAgkQ8qM4rT8corYYR+sR3KagkiL4SPHkfyg+f+WcUD5Y/bFWrmCzQGQ5sLJ8wSaZ5lbcjCUg
 C6joU0Ey7KxXkfZUF8sLoJhN8T+FQuHFd28/yAcd4YS+rU99TMRB5FdOZZoE1lAL/yF8mwtie
 fMr1P/xlMvvox3yNHQ30TRI0IwgCGSsjwiONsI/BSTk3gSRn/VwdCiRVMuhgp4CsjdHJ5VDt5
 Ej3jrLTO3ENCMb4SSMI6R206YEG6pob/SOlLMkT2xWR3yT6B4kl28ro26Ak8xBPMMTze8ki8K
 zMGuetaWbIurPlMIwc99es+GFP+nqSDd7Hqk8h03s3cqSJ1YWBKdZUlXcO/Unx7MKAYhK5JSM
 2asiFpko761Sw3mQ4h88RCBZ69d+YHqwOFxgvemSQD+Gx0rUHRyhUpbicJLvINwWyhPHg4xKO
 f15dQnW2ApDUjRg8yofhKlK+FIcS6Z8Zy3Y2YBO3R9wrzhCUof1//KKDEdKmjycspPYxt5XfD
 x5KzX6lVG0laswAUOY+GALJ0WdIc1nC4H9M6EWycTghesQSSiilwyCtqOtZVckZwSFGwhNm5Z
 VZ6F1ar0Oq1OmBzqjNaDZxNtHAJPs7kybWFU7ZypqBPizgIfclK0n3FrB0stVtw09gCxnQNmf
 zwjfJEkQodfPXI=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/15 01:51, David Sterba wrote:
> On Thu, Apr 14, 2022 at 05:43:42PM +0200, David Sterba wrote:
>> On Thu, Apr 14, 2022 at 08:43:45AM +0800, Qu Wenruo wrote:
>>>> Failed to reproduce here, both x86_64 and aarch64 survived over 64 lo=
ops
>>>> of btrfs/023.
>>>>
>>>> Although that's withy my github branch. Let me check the current bran=
ch
>>>> to see what's wrong.
>>>
>>> It's a rebase error.
>>>
>>> At least one patch has incorrect diff snippet.
>>
>> Ok, my bad, I did not do a finall diff check, I'll update the patchset.
>
> I should have done that, there are way more code changes that I missed
> when going through the patch difference manually. I'll try to port it
> again but uh.

Mind me to do the rebase?

Just base all the changes to the last commit just before the branch.

As doing manually diff check would also give me a deeper impression on
what I should do in the first place to reduce your workload.

THanks,
Qu
