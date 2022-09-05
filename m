Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C5C5ADB77
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 00:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiIEWh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiIEWh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 18:37:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E559253
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662417473;
        bh=eGpHqHHE3Flbp4vTh08LdoP1ns/k6tPV7Y75zXTo8l0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ys1Gf+KcoTJBCZnzITsQUhNTFikFZMJl8NE7RbLqINzZaxpS8cyhyAWqVfrIvxN59
         X6FjPQi4ObLe07q5CtyGRh0biMBNxy+em15DTLGJMWVfN0VKZ24P8c3tO3Syc0z4Bo
         qwmM6rrwhypuScPOmKBqk3OWnAkI7lp2Yxz2u5dk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQjH-1ob3N73a7J-00GpAZ; Tue, 06
 Sep 2022 00:37:53 +0200
Message-ID: <67b45a55-058e-55ca-9327-deb23e6ee7c0@gmx.com>
Date:   Tue, 6 Sep 2022 06:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 3/3] btrfs: separate BLOCK_GROUP_TREE compat RO flag
 from EXTENT_TREE_V2
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1660021230.git.wqu@suse.com>
 <5c396cb280e441bf37df48e05f406424859a03d3.1660021230.git.wqu@suse.com>
 <20220905150127.GG13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220905150127.GG13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nb+Lc6dAokEfFS86a+yzfRfG4OE5IJx6c4TWEwNl+OqRzYP0LzR
 B1wSUZqymuaa+R9vh3kynUyFm5SlG5QW8EZqK9tK5P4rh/VH23TsFKoS/WhmdYVLKb5hNgJ
 egoLm5BPD/Lt4F7KfTTfUggKyvxEEJKKCd5+iVRAw/BFmylS81ChAIQnGuhLhsE6TCJ366r
 WFwp8kXkTaMybqSvku+3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jGyDFG5yixc=:MfjeO1tVEsEsizolVgJ9CJ
 euEQpxHCG9WaVjgusGuHApn74wYAc1jbf39rie6ar6ZE45xbsmnr2AKZUKOFg6wE2WQzWionB
 7OtskS9uQMp6na71rPrr01L60WdW47Ycxdy6elX2f6hPxX9zffliXTq6dONCZXUdRPJheTLh4
 TOJOMMRTsRL86WSTP0D/ya0p2cof5tfmZ/4KdzaqE7iHEQMoMPsreggHQhegOOF6TQuWC+D2Q
 mlGeyVCrbFOB56ABPFnu0YiiX01VpFYbKyQ5xaXQ7omKCpq9bGuTBlP5WVg0bdZDNFec6kOSr
 GX2VXw+du0OxIPmBrGk0ajckEv05sJoaS8w2LuQkfOlIKu/0qTUjYtzfyaQBEvDM7fC5iTEmU
 FohBZtOEaRGb9fMQU4u6H/AHeZihted5okrJRO8j7mHCjuwzunX/vbtVsTGjZPu0rtAeWkCJw
 JJGfOhJRwJtxRTU4r7V/Q5IHm1/JrXQ5qvG1rVv9skuGjpAvT7EVOa36OUTCF4XN74fpNBdOo
 hEXnpGkKXr/9WQE95EiLAMy5Gquz6FKYKmCwpo8PfETUHcI4KnR9W1i82PcttXO5YtzvRKY7U
 TaKi6ZQAJo6MrCq6IScspVlaQSEZInSgCHPlGKVNLjH1nvFisVplLoE6lSHKSPaLYhHsQAKbE
 VkRLrliviLjf+J4t/KirVBSjpp2SQziN5svFsTCyadFVgOp4lwZloULAZjJmACyFPM+THIv1Y
 oD30DYBobBkPukQ4ePlhKUgTHguLWeRtalMfuVENDz9XOlOxSWnbC9tbJEqP6s+EISExGRDTR
 w4+qXsUcC3pQwZzMiBUgsoL4RAm5f7JTX4NCw9NrNhdCk2lznrWyvABtv+XwHakFjDjSV2IzB
 VCJFPmuffi8EAAhAK9No8ivJZeECsD2Nf2l+fAFkSbz5UZfwdzgpYNR5btFpiumP9RTezAk4e
 FSfu6M4JtYc7+H19iIeCslDX7xnN/8flIKd4pVG7O4a6cLd6flmYVlvoKk7pvkmOaE9tfDUBG
 F7NMbzaWah5DAfDTHUPSDw8QwNkRYeHo1Oh7GeYYWalAvRIYr6fkOlsjj2Ql0Q/4HaljKlyEA
 7XHuOV5NsEWWgwBMrbrrgYbOg18HwufgdaDVUvDpYxhKc5rinNL2SH4t1AIQBzsmFBmwtGPZP
 bThVLZPJ/Aw7jlshoNKekGOOQ5
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/5 23:01, David Sterba wrote:
> On Tue, Aug 09, 2022 at 01:02:18PM +0800, Qu Wenruo wrote:
>> --- a/include/uapi/linux/btrfs.h
>> +++ b/include/uapi/linux/btrfs.h
>> @@ -290,6 +290,12 @@ struct btrfs_ioctl_fs_info_args {
>>   #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
>>   #define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
>>
>> +/*
>> + * Put all block group items into a dedicate block group tree, greatly
>> + * reduce mount time for large fs.
>> + */
>> +#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 5)
>
> Is there a reason to skip the bits 3 and 4? Ie. why isn't this (1 << 3) =
?

I was saving 3 and 4 for EXTRA_SUPER_RESERVE (extra reserved space after
1MiB, needs a new member in super block) and WRITE_INTENT for raid56.

But obviously bg-tree is way easier to push, so would you mind to change
it (1<<3)?

Thanks,
Qu
