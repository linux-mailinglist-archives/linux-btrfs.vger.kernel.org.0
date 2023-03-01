Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B26A6CB8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCANBC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCANAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:00:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2BE3E09C
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:00:19 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1oWD6G3i1G-011UsO; Wed, 01
 Mar 2023 14:00:15 +0100
Message-ID: <d9f2e86a-c4f7-3846-ce05-54a4113612bb@gmx.com>
Date:   Wed, 1 Mar 2023 21:00:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: Btrfs progs release 6.2
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     =?UTF-8?Q?Tomasz_K=c5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230228192335.12451-1-dsterba@suse.com>
 <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
 <7c04f236-a81c-8198-8e9e-d280d4b4127d@gmx.com>
 <20230301001504.GT10580@suse.cz>
 <a6fbb53a-f5bd-3d01-5944-1e7dfe60985e@gmx.com>
 <20230301013546.GU10580@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301013546.GU10580@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fK5TXq/RP1qJ8To9SH3Eq0yS252iiGOgdDpM8k0dU9F0y+CU/jD
 iJhrRU2wc4nBKY3qoumKlcmDFr4knYKihOA31QVelGQDoWZkv7H/v8c9pSfnGh4HucIF2Y9
 AD/v1WVPjRlpSPNSMr/LegMgFf3x3DRIBEq2tAUregvFU2sdKQirmTHNCPvdGyjECdNRoPW
 C9tWDeRioFVOe0v0S/qBg==
UI-OutboundReport: notjunk:1;M01:P0:+vf4j2h5cBY=;GG91wq9Kzy1m11rw4X9YIkc1InA
 uzyr4iv58CyOzalXmz0TyurE0iVqCVoTm4WkkA2qIU5IKfZj5pni4NUBrjUdPe3W1VG8sxzQv
 WyzC9/1fq1DXUMLugoGMKDNNUDrPk/VXkuWizdJ4FiSNlYxM4n2zogVHPD48WCSCAN1SQb4DV
 e9BRxwd/9KC4yt4YJ2GkdYHtcy38Xx1dVqBHSPnM5Qek0aUTrUa+UVKiUvX3xKmNda7jmWHmS
 okZOX2cLoFRF2eCCdXlmvDzTq2gj6R2p4A9T4Zd/8a0c4fG0aTlYecCxPRkuLl59K6//y2ecE
 vaPOif6JcsUuaL0/IMLMpdLnBb7xqszwUyKaYlpZpMVqm/kfsGosJJYtBMLQpTQIQEGlzNCdI
 keVUznX0Y2tHQr/7a+nLTEYcV3uOcFOHEC1RGSAK3iTzmTV+FqiU0SIYWSTTuIry3035vScWY
 468cn36epBuxEPeI2RevIShwNujCRAEKh1NeoD+lf9r6JB+KOcpd1rv/N4ICSofbQjkrT74y2
 /Q01U8fW3xXXewJ1VTzIQKDuITDxpcDVrZ1qxEeHo0IWFnLOcdJUFS84pS+1Yy4cbEdbs6JJ5
 Sfy3psardE2hwXvrWeRdawbPPNjzKjsflr8G3yvxX/tx5Poe+rvf3AWz0r5Nh9IqLSc0darrM
 5Z1MBgHdCgq4JP2chE6bzrzOtzmnpEyrHmDP7AB4eiu1/09Oi1KUazDtVPZje4z7ospwOSMG3
 SRxedG8PJUsKU+Cb8Q7qAZ9NX+7NaOCP9KI4NouO1/MIbwmjurFGwD3Lx1oZODBGPGCWh1yt/
 8jOOfICpLOKmWcW3jvTn3O9qgok+j2dwPleW9YczgHXE5bhw7ZJSs7PBKomBoLxegNcBX5XRC
 IApwMjj839xBA/vm39F7B7HBhwx4hCeldxE3bFgPEZ50FiURpIq0+q2E3JuzYznKNSKglDKuI
 HjmtapddVwi88bjLnVo8QIKTpoE=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 09:35, David Sterba wrote:
> On Wed, Mar 01, 2023 at 08:30:05AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/3/1 08:15, David Sterba wrote:
>>> On Wed, Mar 01, 2023 at 08:17:59AM +0800, Qu Wenruo wrote:
>>>> On 2023/3/1 07:07, Tomasz Kłoczko wrote:
>>>>> On Tue, 28 Feb 2023 at 20:07, David Sterba <dsterba@suse.com> wrote:
>>>> cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o
>>>> cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o
>>>> cmds/reflink.o mkfs/common.o check/mode-common.o check/mode-lowmem.o
>>>> check/clear-cache.o libbtrfsutil.a  -rdynamic -L.   -luuid  -lblkid
>>>> -ludev  -L. -pthread  -lz  -llzo2 -lzstd
>>>>
>>>> According to the Makefile, it looks like Fedora build is not using the
>>>> built-in crypto code.
>>>>
>>>> If using libsodium, I got the same error, as libsodium goes a different
>>>> name for its blake2b_init (crypto_generichash_blake2b_init).
>>>
>>> Oh right, thanks, I can reproduce it now.
>>
>> And bisection points to the following two patches:
>>
>> bbf703bfd3f68958d33d139eb22057ab397e6c68 btrfs-progs: crypto: call
>> sha256 implementations by pointer
>> d1c366ee42bd3d2abb4fd855ac4a496b720d8bb6 btrfs-progs: crypto: call
>> blake2 implementations by pointer
> 
> Yeah I know, I did some last minute changes to the commits because 32bit
> builds on intel and arm failed due to the flag and feature detection.
> The fix is not straightforward but now I have something that works.

Just one question, why we support external crypto libraries in the first 
place?

IIRC the built-in ones are already utilizing various optimization, and 
I'd argue that performance should not be the critical aspect for btrfs 
anyway, as only btrfs check and btrfs-restore are really involved for 
performance but they are all single-thread workload, far from 
performance critical.

For best compatibility, the external crypto libs can even be a problem.

So clues are appreciated for why we're supporting external crypto 
libraries for hash functions.

Thanks,
Qu
