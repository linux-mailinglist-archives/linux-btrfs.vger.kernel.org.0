Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2865A0785
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 05:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiHYDEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 23:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHYDEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 23:04:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDEA9E0F4
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 20:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661396673;
        bh=y/VoUoNnCMYR4HumiQy1ki44JOcolTTiCvywicucYo0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=IbLX+DeI6JhvOE6XYWuxyEWoXcXyG2BE2eb7GTynml+WlgbXFhufY7NVh0m4Qk/xO
         ZhWykm73qNuGkpzCdhIR/980aOHAF23yIuFfpQlhqQSS7rNHFOe4ZtU/kv2pjLbDlT
         hmruUnl8+YDRUjMRbpT4JQOM8OXxxYgcP0E/JGfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8obG-1pTAKE13Wo-015o6T; Thu, 25
 Aug 2022 05:04:33 +0200
Message-ID: <85617508-c958-985e-a017-021a72fb3cad@gmx.com>
Date:   Thu, 25 Aug 2022 11:04:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/4] btrfs: output more info for -ENOSPC caused
 transaction abort and other enhancement
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1658207325.git.wqu@suse.com>
 <20220824155321.GY13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220824155321.GY13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:43XLNQ5xGIrU1Rqzcqw7yYFWWsk1JX8TQY5eTfr1JSa+fSJnNIu
 zwK9kBVFbAi1kANX9g5RGH7cfPtfyqQ05rz1phQu8azfiX9ieVRjhatnEEDjWU3BuPfe2YA
 56dEUVVVFTAJXACYY1rU70IBEoUe+qnWtyk7w25wyHorZnAtGOCuri74XzRrezkE30K2Ume
 jzACFKY9tyLpfB2foW1UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/pewFZSd0r4=:GdFr7wxWCTWH4LpWgnakxQ
 HwT8HSiS0iE4CKNR47KovqiA2g0w5ChX/4i/KgY5O5goipVaFMIzxNxowv/65i7RbhN0j/Kfy
 iAgqwKXLmK9k0ZPCufbjXfM1WOIq/QDIKHUKYgS+MBVpF85gYfRpcYBPFWCZQev6xWPUh4ydH
 Q0yO96zGLbtz9dftF+nioYMoK23RCpEQAlhgYVQR6Ns6F/q7K8vf3jUPJNuWpS/1W8Csc/5J3
 rd11LNJ+iGypwaMmDdxfGp4mpUAl5ydX0wRnCk3n8yWgCfReWgN3MUk9cYiuhUByUdj0qqoaz
 erhOl1QxX1V/miPzEguAbW7ppbE6/r+N2FpxMUafCedOPTLsEPw1ayH9vzPc2DkEcD/QnS4uV
 U/5uMOYiRcUeUA6xG0CY8Kq12E2drgEXBKp7J/gxAkGU2NgRsKDYFnynZCyhN6SL3LGX/i04j
 nI2RxiEio5rc1OJy0dP2wyuR9dpix7kD4c/6WL2+Rs7WYJm91KECvDoVpV/OiY6Z3JyqcRi/w
 nzkkAujo7gmjYbe8tu7RjpwnlZVBAc8wYKQMTD7mALg1ZHFe/IJfVFjortXQyGyleOv7uVpP5
 oAYryv4tjBrX9Pm6q+7O8NCVv14cgP5UXqG6p2rgg2YEFuufj5AsAXfNgUrEDKr5i8qtDsJEn
 GP2MuGVLJhyMC2O99v+pFaIrxCLs4lCljgZ36BlFp50kBLUJyG3OfXHzUlE5I0IDTyHveZB4M
 kv1UBpG6l8iWrOzs6tfy8sYHiVzBda2E1dIyN0xflGTAvRE15mUeylnuwvdZ4H3pJ48CCEtsg
 FtJwN2Stzs6DVH5Ptst6++y2wXlaxqmuYkybAl9WIVYI3PZxg4sgM2BTf2gRAE5ne1Cm9Byiz
 d43qrDM9+QVqiVugqVehdFq/YiOVPNh//V+X1vsLOsuQKzh1EF0vqYrB7WEaeoLhefPCWSh2I
 WNmyCMg9wC3KjSM2QsRkCuEPe6nkmFl9ibf35OAx+/hw/vyjIBmCduycf2HD/McZNtQh9q6Vr
 LJ6qz3wbpMg7ha6OHtJokgj8jjQBtNhi7e24lGyqDw/edGOqgZDGS7vqaQbzVKMA1Gd+Xot8b
 izAkH/gLSDByEjVSl9o1W84ryq6sEjm8u1051aeA8yFRDeL+mZ+2Bm30g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/24 23:53, David Sterba wrote:
> On Tue, Jul 19, 2022 at 01:11:14PM +0800, Qu Wenruo wrote:
>> [Changelog]
>> v2:
>> - Add a new line to show the meaning of the metadata dump.
>>    Previous output only includes the reserved bytes and size bytes,
>>    but not showing which is which, thus still need to check the code
>
> There are some nontrivial pending changes for this patchset, so I can't
> merge it to for-next. Please send v3.

Thanks for reminding me of this series, I'll update them to address the
comments on the multi-line output format (aka, drop all the re-format
patches) and refresh them soon.

Thanks,
Qu
