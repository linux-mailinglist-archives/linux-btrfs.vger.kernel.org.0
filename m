Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914AF6B9175
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 12:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCNLUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 07:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjCNLTc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 07:19:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6D21A01
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 04:18:52 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt75H-1qVOAy2cob-00tVXy; Tue, 14
 Mar 2023 12:18:18 +0100
Message-ID: <e326b931-4da5-a291-3e01-57aa75f1ab5f@gmx.com>
Date:   Tue, 14 Mar 2023 19:18:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1678777941.git.wqu@suse.com>
 <25f5bf6b-7c90-b114-b903-1fb9a78ec971@wdc.com>
 <accc9636-bf5f-c20c-22c0-57760433eb21@suse.com>
 <b453b6df-529b-a356-096b-2817e965d5b4@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b453b6df-529b-a356-096b-2817e965d5b4@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1cSm9ZC7Q43PVms5yZPZ/fSxOnxIHzDk1LrExOheYRwk0qT6vAI
 PKWqoiVmzu5qAD92CR+x2KIsyb49laIrQ3/2CJLdGEQ/0QpJj+B4oGsCST/julvLHF9XRRo
 KI9pPl2+S10WpyxUHXgdsAbU6HJ4jhSHIrXwixEeRmHvSic/6YXAR1J7UEnUZAlAnK4M9/p
 gQFgkZogwM/ut/r78EX1g==
UI-OutboundReport: notjunk:1;M01:P0:2YVJpgU7cC4=;pW8C4hcgxSSi1hlSa/WboKIgyRt
 RMYlDdxH38ebTYWiihATQ+py1IKrz9TLMdX6FufRtBe2qwN0L08GbPIORIuvpfhhw+G6GjT3K
 U0Gg148j2OFT2barMiIdsouJJlIkst1AjtITdXicO0GReq6Ini+SWZnWytpH0Yx26e/usqP7F
 MSG32A7ApikYTMXeHlnE4ZJZAO0U2A25bjcvYZo6kaex9J/HMCp1DhnGS/HOPfkL7UwyRQLzZ
 Xqt/7xW1MiIrIW/usJQ9ZzcZ74NPTLtznUL7z75+kYeKcMh595HvQEgz27/2qnBv5hpdT0S69
 rsO1IPpQLOcnCFNfhozlMWbgF/1zE+8nITsDNCelu1eyfzO/snrLpYxVzI2I1sBBzb/6KNJB7
 a8mDqPZmXWLiPqkMH1X0yx5r/dQr17lTZEnNCblcyAoFIRmUEexNq9xqU+wMn7z1d585DkeBD
 Pq1Lyr0GomJOVx+tULNM7usoCfez79s05lH1FJ1lKKcS28wSrdYPSPswKlFhb0zt0EcIi5F2i
 n8vLXHTJ+WjCvIOQ+AfFdenaqHGrBWb1O4bu3nRigqqNR2Ma36bHf2XLD/rG/i0+oDazeYO9R
 xnTSilsjMPxBPoiyg9fKVtBFGmIDo4UBGJG1NlWwr7msVCEyHy4hiciBmlj2sYxHqEhXHA+rM
 hHFL19NtF0NzyDgRvEW4ceNAdppk5mxDU7kn7Td+ga48F8iP0JDIDr5eK83UOrN7WtZ782nsS
 Ht1lnbEkccCZPFhsdxrBlhOP3mpmE8P+KrmxRHl+IYhoAIGO9EXiQ5OvpM7xl8QXkO+6ka1wX
 RaaNK+5Ru7tpptSIQNyGjbSBLBmhc5Ij+HR3MkH1L2RPYH36GrMsrH67HJVOuiO9DeklzI/QB
 lK2x1thkvhHuIieL6Ql1cdOfrDSjaApr14mDjEbNJG7m7ug6A3/MbuYor1fq16qFMOdF+iPAq
 wK8ttvxnYVj9a2j/wxdgALqHeIA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/14 19:10, Johannes Thumshirn wrote:
> On 14.03.23 12:06, Qu Wenruo wrote:
>>
>>
>> On 2023/3/14 18:58, Johannes Thumshirn wrote:
>>> On 14.03.23 08:36, Qu Wenruo wrote:
>>>> - More testing on zoned devices
>>>>     Now the patchset can already pass all scrub/replace groups with
>>>>     regular devices.
>>>
>>> While probably not being the ultimate solution for you here, but
>>> you can use qemu to emulate ZNS drives [1].
>>>
>>> The TL;DR is:
>>>
>>> qemu-system-x86_64 -device nvme,id=nvme0,serial=01234        \
>>> 	-drive file=${znsimg},id=nvmezns0,format=raw,if=none \
>>> 	-device nvme-ns,drive=nvmezns0,bus=nvme0,nsid=1,zoned=true
>>>
>>> [1] https://zonedstorage.io/docs/getting-started/zbd-emulation#nvme-zoned-namespace-device-emulation-with-qemu
>>>
>>
>> Is there a libvirt xml binding for it?
>> Still prefer libvirt xml based emulation, which would benefit a lot for
>> all my daily runs.
> 
> Not that I know of, but you can add qemu commandline stuff into libvirt.
> 
> Something like that (untested):
> 
> <qemu:commandline>
>    <qemu:arg value='-drive'/>
>    <qemu:arg value='file=/path/to/nvme.img,format=raw,if=none,id=nvmezns0'/>
>    <qemu:arg value='-device'/>
>    <qemu:arg value='nvme-ns,drive=nvmezns0,bus=nvme0,nsid=1,zoned=true'/>
> </qemu:commandline>

I guess that's the only way to go.

I'll report back after I got it running.

If everything went well, we will see super niche combination, like 64K 
page size aarch64 with ZNS running for tests...

Thanks,
Qu
