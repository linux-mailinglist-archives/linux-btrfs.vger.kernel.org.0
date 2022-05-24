Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ACF53338D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiEXWb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiEXWb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 18:31:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2E237DD
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653431479;
        bh=LJ77Pb+9tSQ7K0Hnon/JDEXa3bZXeLwDf0mrok4XFtE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=R7b4QEbsV1rHpQlIfRR2xguCQBe41RccWnpwkQem0OdXPqIQ5bQMbpU6wvTs1b4R8
         K0l245coozmcMZ7dc1cLZq87aLv3K3nuSUbBBLmBuWZv/skW1kwdb6/dTraeGr2Zv0
         lqhhvuXqBs9jY6p9ds4nPokmnAB3BDkZIgPbFbxg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1nsWav47XA-0019lN; Wed, 25
 May 2022 00:31:18 +0200
Message-ID: <ccfb3604-dd84-7784-2c12-2b0b2b1a5d65@gmx.com>
Date:   Wed, 25 May 2022 06:31:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524170234.GW18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rxdFoGzqk+CHiSh8Pbymi2VMOY5ait9YDK1sBY/AKrp76AV+JEr
 VG62b1qF88oK5gdgWL3uku7NVfM9VupFsfLmz6p/LtNRDnS9bpVZUyqckzuJDiodhOsDgAv
 CPI/bwocWkYZuX4StL6hQ01PL0iCLNrLlXkLzmMw5lHWMjwKus0yfrMv360Vb66m67TXDnQ
 A3fKZkvnDnX0QvELvoU4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LgQo64/qBUU=:bUo0qyLn18jEZrr5JA/xsY
 Oeb8yU7nHjji6UYjJJJ7vIj5cShGTUmw2KsyFIdfbCoDLsIbbFa1Xavw6UAXwtB1ntlZd9hTF
 sg+RVzF43PH5WqIdzd4peXi9RNetmBLPsZEf7P/mnryBOFoYDQkVvnvdbjljMnjF1yZo7Qhub
 qBVHujt4t00rbiLisaRD/y62R+nxOT8bgljQ7Z21YlePxPmJO7DDEMV9Pvnfa5ky/4BYsiuLp
 Jcl+YsK2FjIYn2sXvuZ8LENOcbKNMRl8VuvbcFnB54/uXEpG/LPbV8r6ysgmOU34yJIoyegW/
 73IWnqPA3gLma54JRp8COb2aM24lubEQVaKof3fxuGV45ms6VaMLHggDuMIbLKA9hVi2k/UsR
 Rj85x8abM9MtUt3BEeSrgmu1EY0o/6Z+MpUBVsY6L9Fukyfz1w61ceroZidFInyO1s5Zp78GZ
 MAvH439q7kONuYy5Xu0IbDVO2UsV/c0dJTbExJFhaY44VXXVzorkeU5LgMoh6+r6/rm+0zvdu
 ty2aGNnK3f84vci2XZwxWkZd4x3kOg7WEJZgPnbMInslVuQXzMOIw63cB5nFN4+7ilk/U42EJ
 o12w878FP2l7WuXBdcANGCcPwqiONJMjzEznYCjuIL452OpgZKC0L9bAeYawOo2zbeCNM0FrT
 DOaBswXLlyrarSKU2ht0mdMAEIQkM47a3yuX9+FS9xKqmupgtiBaiyVwGoiX+yBckjvA184BF
 cc0SqZ2ErqoDds4hTAnVDMTJahpOln2oIyjUpxLn07+67bvU00Pz/BLwSbFbK9AtVOyH6ILHP
 8mQ8Ss8CVqzYvvinJEcuuax23dSFqDqOksdQffQOdMnznXR7PfgDz5JzhqZK40F/iuYSDGUmz
 LSDVKtGgGpQaaj+XJ1N0DeDshu4EtPAqQmPDKdA6CZdRvBbbcNqWftSWh8r9+xOqkC1qF8YkS
 l2hb8jQsOaT8aSxGXO47ndt4JovEMc2JUr9+icVN2VdNA0LRrZO8qbL63uWyH8lWzy1XzboNh
 qwptJ5L7XVhggrvb5KbyhWEGQdeXfLqjN8pctqR9sTu3ut+dd05slHGstm7vS/LxvPIZHx972
 aqyoa9w8GzaOUkPQoC+x30faQCCcZJuD3KzLKd6TsrfyAfLucOUjrY9jg==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/25 01:02, David Sterba wrote:
> On Tue, May 24, 2022 at 02:13:47PM +0800, Qu Wenruo wrote:
>> This is the draft version of the on-disk format for RAID56J journal.
>>
>> The overall idea is, we have the following elements:
>>
>> 1) A fixed header
>>     Recording things like if the journal is clean or dirty, and how man=
y
>>     entries it has.
>>
>> 2) One or at most 127 entries
>>     Each entry will point to a range of data in the per-device reserved
>>     range.
>>
>> 3) Data in the remaining reserved space
>>
>> The write time and recovery workflow is embedded into the on-disk
>> format.
>>
>> Unfortunately we will not have any optimization for the RAID56J, every
>> write will be journaled, no exception.
>>
>> Furthermore due to current write behavior of RAID56, we always submit a
>> full 64K stripe no matter what, we have every limited size for the data
>> part (at most 15 64K stripe).
>>
>> So far, I don't believe we will have a fast RAID56J at all.
>
> Well, that does not sound encouraging. One option discussed in the past
> how to fix the write hole was to always do full RMW cycle. Having a "not
> fast journal at all" would require a format change and have probably a
> comparable performance drop.
>
That's why the next step is to improve the RMW cycle, to only write the
vertical stripes first.

Which can help a little on the performance front.

Thanks,
Qu
