Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B666E17C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 00:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMWzp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 18:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDMWzo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 18:55:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335992
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 15:55:43 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1qQwxO2jLt-014Xfx; Fri, 14
 Apr 2023 00:55:40 +0200
Message-ID: <b646d7bb-2160-39d3-9d40-c2358b416a4f@gmx.com>
Date:   Fri, 14 Apr 2023 06:55:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] btrfs-progs: move block-group-tree out of
 experimental features
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <20230413162057.GG19619@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230413162057.GG19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B/gFwJewWoXj2XBp7yxkWTpV+VEP/PWgZwW9ilR74R9fWxMtykY
 p3oXyXDv78dheM9yz0WJpfcg/20YcKX2aJRqW/QwdzuzvFOrtEXbpqGd1/5omfbaOfbXnvN
 cgXsdcq4dzAyp39Y1PGv1JjyV2KUF5ksc1isVcd5VY0BG/Kjj++zsVT667X3qT/3bxbOOOW
 ws82TvU8G65F4P8QJV0zA==
UI-OutboundReport: notjunk:1;M01:P0:9KMTeHQdasA=;gzfqlhbkkn4O3Vcfelitp2HkTrL
 nYW2dMWFq+kXOttbzf0kNGAwaNTARLoHchygN+5xH+5442MzyxiOIrb1BLIvsq8p5XmT7IfdP
 L8Yhk/jTDAMpec2f4Dnyy0PBkwDdkondXaxrEvdF5YYBRlXhBkMGxKEwjKs5mHtYmh5h3jxuU
 kLy1ykVaTco5juo+Lum88GYNRTAIez3CQrWGcuILOxZkVPYMT9Nq4o9mRKOM2bILWTinb8QS5
 KsqybhTmp42AUVbPsCI2FIm/fvuhlNGaBLAGm/llDlf5IDBzICkUXs4VqZMmG1SyYoeFpMST9
 APM2cf8PW3DpI8kahKPcmwUtXxeI7eIbCFDmyDy8RL7f/jTs8CKwC2meXMT/acfP5wlIkYTh3
 4YYKH/XPHt2jYtYTYl7prtVxUm1+bYP5IzlQ0376HX8h4NVeb5PCKDDSUWiNJHwip4rpcLmH1
 IaaIDP91xwJQwDpojhKz+0jgbM8Eou8X0fiaAShRAdbys8XgpFgGCPns615VFL2jonKpSigqn
 UEXMrCtsJ1iMJxEJ7vH8H577cU67eIEdbEpTN22LE0BaxUshgXIF3wq8DsZFmVRIvMfpeZIGY
 oTabH8Du7udHEEpbrGmyFD03Qlhpg/nyODJm2fferpCPKtaEKgjIqa84oXW518zdgj36+RPZj
 JtpEpkHAXqtbIn7USlFT2+U6SL2Ae1ZKt1f77+6BRJTyvAGo+4w1/EPcQO128/CxSp2F1kDBl
 epsw3C5TNvnl73gXdgeoR6NlmOYn6RAyxOXkxWZF0ZnRKnDpCV6fuBtU+7Oyb1Vqis9EmJpL4
 HIzMXZwu5KQdoHimPw1bGUvDozfI8ye4C78Jd9P/spuZQ/H1oxRxu3nXOl5vmy/8QwNw9hZjB
 o2si4Fi2w9orJajGZwSwsSuoMWHhO7cqvBjBqhYocrpfZI80NvFwZhBEN9VhjnUw5qlnB60Ir
 Av/+bZMBWAUvOfwmKlkmavb8aMw=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/14 00:20, David Sterba wrote:
> On Tue, Apr 11, 2023 at 10:31:04AM +0800, Qu Wenruo wrote:
>> People are complaining block-group-tree features are not accessible for
>> non-experimental builds.
>>
>> So let's make it a stable feature.
>>
>> Since we're here, it's also a good time to deprecate
>> -R|--runtime-features option.
> 
> As a major release is near it's a good time to do such changes. Merging
> -R back to -O is OK. I looked again how robust the conversion to bgt is
> wrt to a crash in the middle. If the process is restarted it should be
> fine, though I'm not sure what happens when the fs would be mounted and
> written to with the ongoing conversion.

It would be rejected by kernel, as I intentionally introduced a super 
flag which kernel is not aware of (SUPER_FLAG_CHANGING_BG_TREE).

> 
> We don't have any test coverage of the feature, at least what is
> possible from user space. Mount and other things need kernel 6.1 which
> is not in CI.

Yeah, that's one of the problem unfortunately.

Thanks,
Qu
