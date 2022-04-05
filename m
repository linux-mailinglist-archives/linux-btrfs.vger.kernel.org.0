Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576D14F2271
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 07:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiDEFLB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 01:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDEFLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 01:11:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C04B419
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649135327;
        bh=NDb03fTWvF3SLaZs4y6l1M4DIRKkBxydLd427/RNc7M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aX8XcI7pQh2bN4yypgMBYL+5tFNBMhjDyBYH/Vu83r7w8FN15572wppu3Toyf709k
         Oqfj+UewKlUFoWG3850BT61y11L/CbHv0v+LHsFhkE6/VkxqC4Gh+pOKyq1FRLR3Ji
         D23I/MqttjYn9FTJjPB85klU1nUecm3HgvY/pvIk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1fis-1nzcVK393Y-011yeQ; Tue, 05
 Apr 2022 07:08:47 +0200
Message-ID: <aee87ae7-bcf0-726e-b943-3499d4b142e8@gmx.com>
Date:   Tue, 5 Apr 2022 13:08:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <Yj3v+MnFOXeeAU9d@infradead.org> <YkvMcoK5m7tZ3GUM@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YkvMcoK5m7tZ3GUM@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2FmEZxtK4e+pkSfPhgRc2pRpfNEPn1qkxoTLYHtxhHpnsXiSWZZ
 xqye1Ig6EgS+Dee/I4UV2AULRMiWToh0yntc2pYTh4gSgzAGqXuapb3WaL6KaBhCbo8qeJS
 a99FYZRWibR0vvTS7xdWqtLx3LIWr0kgDdYxGI0g1NoimDzfN3dOmbuuF+HaBB6h33ABNBe
 0Nuv5aFLAv1TZBk+88Uxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UWkOV6p5UBs=:nekZshCRPFKtueppZ9pTG4
 eUpDPctxSjSFeVR3Hy0lGrWWR9zCslCEaecag9yorBNndLECvPq/ZwQm9iyD/dFS9MyMBIHYD
 ZovCX21QVwdb4ikohUc8y+FA1sz2U3DMU698aPuxNW5VfPc1cC0aPV51hOMC/znK344bOlyT0
 1lRPyvgPDUEJcc7TtTJr6eHNBAi7aPHJ6MhNQ5/wj1TW05HT0eVQnZyS66xGpkqwKvckgtJAZ
 QCWgnWpIXoeb7lzbAKRA1+Wp9aJulnIMGo6zov2c+FQ0yTQm5R++ntJ69QEwbl0LvMzZebIsw
 sDLuncVYRdLGaX8d85SH8j1reWgyNMR4HbdGGuz/0b7Q03Dc78UQkQlmyZGzlMaOKhAFNYnXo
 c7UILFeaC2GGju0c2vEmCpOLbFXoZwPgvxoq2USpGfSoQdk4B4lffsY73xZWQpqBCuhJyjN25
 5RJ1ox/5EdmF/PpZumiJ8CAzQysOvnEBLp+zdkTMYvv6KvygaRGX/chVuDXQk1lE7QP5csxXl
 USRN2cZb4HzkKZ7gRE3o3injku1IDcpVB5M3fCVMqwK0W904gzKwczzOa8yBR/XKyYbThCm1V
 2qknf2zbPEYeHWF8sIK8vze32d3E6BYtXkipA7T9K7C0pu0TA7GJX6dIRKAARSI6TgM67CwMR
 wan/XZgv9KK5tG8UgVIvn2USzvdy/+B3EBkjDSfCzyne0dRPquE/ISDTRnb5gDHeUnsKSEjOn
 /WRFP/YYoyPS9OvMIOoVgoQAXz2ZwAE6MbW20c/FqXdrIYdTTYGNuHhJi4/SYj5moRSeH9w3J
 1L/M5FHgiwF5PJbMWJ64tfVCaRAIR+IiGdoMw8fRebMX4xW7PSuTSyWfUlIqf/UHghwY71Zl1
 yEfyGi/ZViGI0/QzMNwluLqob0bjSqeyTflMa2Mc6CmTkn+ZwtSrP7cUZIvV+i+Imq0Tm4tzn
 GxoEhtrCaduWrJSiLQ6WHCZbC+DxKLC0MvMSJEWvV/VcQ5aj/10nUmKBp/MAtujFiv1+dQ8zo
 q7RLjkYvia5AdcMLZLjVqFSB1zGRKfyxOeaeprsfUJYtAv3POkd/skWeNAlpZ+tRvW5Oeo9VQ
 vV8P/MBMec4DcI=
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/5 12:58, Christoph Hellwig wrote:
> On Fri, Mar 25, 2022 at 09:38:16AM -0700, Christoph Hellwig wrote:
>>> -	memset(kaddr + pgoff, 1, len);
>>> +	memzero_page(page, pgoff, len);
>>>   	flush_dcache_page(page);
>>
>> memzero_page already takes care of the flush_dcache_page.
>
> David, you've picked this up with the stay flush_dcache_page left in
> place.  Plase try to fix it up instead of spreading the weird cargo cult
> flush_dcache_page calls.
>

Please drop this patch, as discussed with Filipe, the memset() value
0x01 could be a poison value to distinguish from plain 0x00.

Furthermore, we are not sure if we even want to zeroing out/poison the
content.

Thanks,
Qu
