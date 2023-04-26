Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F8F6EF0EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjDZJSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbjDZJSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 05:18:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FE49E7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 02:18:12 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1qPHT62E9r-00cS96; Wed, 26
 Apr 2023 11:17:24 +0200
Message-ID: <414d15aa-0260-b41f-1fea-0466cefdbd21@gmx.com>
Date:   Wed, 26 Apr 2023 17:17:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     =?UTF-8?Q?Lauren=c8=9biu_Nicola?= <lnicola@dend.ro>
Cc:     linux-btrfs@vger.kernel.org
References: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
 <a0f6195f-e6d1-f633-9cd7-310fe5786546@gmx.com>
 <f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com>
 <1e917ae3-71fd-b684-12b0-044e49d22afa@gmx.com>
 <974307f3-7cd7-4221-8ba2-30ce0d7bb49e@betaapp.fastmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corruption and error on Linux 6.2.8 in btrfs_commit_transaction
 -> btrfs_run_delayed_refs
In-Reply-To: <974307f3-7cd7-4221-8ba2-30ce0d7bb49e@betaapp.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tKBvgqGrtDjlsKWpnZAo1xUvVVLuc31o4V2D5rNCy0e0GxDzDci
 EAPzvSBjVRNNWDEPPA9AYIZxoiKP09zwECjJEoOChzGO8n7d0DX0Q1AoPfVnF/+klbgc0yQ
 6kUZ51lmiNo7Tb9Rv5Ph5ZoF4azfpcj24AzBeFyiM9p6ZmhdIwRbHRbsBGicx+JQB/nLcMB
 L07JJ+ILclhwun44LgBCA==
UI-OutboundReport: notjunk:1;M01:P0:zVHG2NgCA7c=;fl64dXqFp/U5ahXYX5fAT4mHUc8
 uWTL7PhwGBf61IYjbKSp8D53W04pqRStsD6pibLL54/tBOf9Jj9KdAUr2cup+Ic7J6RaF9x2z
 QB/EUKXy9pmFfoon3XzByznHnacZmU3tezrMl3Z3Z1ZjbC02M1K0vKVT+puyLfasMmC7TK34L
 Fc7+OEHRXml4lWxImR0moVuQ6l4c7jr5TJm60BEOD0upB98bkOfjr15NIIp+C/lYBHU/KDPQM
 tgTss0x//zBKfDdUm4iLmmbZYoPdmQCml7FxsMWxMg0bJU0UNp9eRn4z7+31ApgQAGihoZTw7
 Vv2J9C1SI6KUfpFhUTPS6BTMYUc0PgXyNAL0lLfJ8TEvqICfPNumaENbLm1Cy9RXNHyCotHns
 IJD3eJ3GSe1mAl2R8eafgajcA+uet59WbSnNsXXP1Ssfy2W/Smtik8cmnZkJsvZCMCznSpCmB
 411Ogaw/XM64vXtB5i6NMZtOWMSHlEYwF2d4VUs4p6CjLU9IcqJWAXI1dVK5YCFcXFuGa7tBB
 wAcXUAtdqjWpMgl5KcDJpc7R+9ivqCCtCt0kjRvuN431zj1z1WFzF3ePQHQuBBRYeZIwtYHyt
 KTyRUJlblVuInBuj/2pCoAposuJIawd791gGznMCSJbwWdFG4uFN4CVyly9uqLrhDuqqEd0gz
 wpj+fryiyChh6yZcIRTJMh581oVNgt2cKpL6auPKq8oLzy2Wfi/q9zA6t5w7bHmU6IH5AeM8O
 M2LRoj4EVSrhitK3z7vV6mKre/ic+ZUZbAX4r5yRWjWK+xmMKaPml8oLTZjhyxQSZObVf0YtF
 jijgFi9ec+0L0RdpsCDFi0rfbAIeyFqk/7Mp2SLDk6D4WE0FpMN8J5xkzlm12uJeriNrMoezg
 8kfXloERz+ybn5P4VO6ALXUmlAnHqyfY06/A3pvKsOlZxdoNaV4bU2tS5sVyHjkyPMpc17sAI
 AyjO7zjqBoJPZCXWXbcJZEsivHc=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 17:05, Laurențiu Nicola wrote:
> Hi,
> 
> On Wed, Apr 26, 2023, at 11:50, Qu Wenruo wrote:
>> Thanks for that link, it shows a pretty good dmesg of that RO flip.
>>
>> It in fact shows a case where there is no EXTENT_ITEM but an invalid
>> type key (40). (file "2", item 29)
>>
>> Furthermore, that item 29 has a size of 37, which matches a inline
>> extent backref to a parent.
>>
>> And the determining evidence is the following:
>>
>> bin(168) = 0b10101000	(EXTENT_ITEM key type, expected)
>> bin(40)  = 0b00101000   (Bad key type from the dmesg)
>>
>> So a bit flip is causing the problem, unfortunately tree-checker is not
>> strict enough to detect it (for now).
>>
> 
> Thanks, I see what you mean after cross-checking with btrfs_tree.h.
> 
>> If you can still reproduce the problem, and keeps the original dmesg of
>> the RO flips, then I may have a chance to determine if it's really bitflip.
> 
> I have this full dump I got after I rebooted https://paste.centos.org/view/21560210, but it only has METADATA_ITEMs. Unfortunately I didn't save the original one.

I believe the one after reboot is also good enough.

It shows a completely different situation.

The target bytenr is 693637414912, but the extent tree only has the 
following keys in the range:

[   61.329002]  item 206 key (693637402624 169 0) itemoff 9452 itemsize 33
[   61.329002]          extent refs 1 gen 56673 flags 2
[   61.329003]          ref#0: tree block backref root 2
[   61.329003]  item 207 key (693637419008 169 0) itemoff 9419 itemsize 33
[   61.329004]          extent refs 1 gen 56673 flags 2
[   61.329004]          ref#0: tree block backref root 10


However the target bytenr is between the above two keys:

  693637402624 (A) < 693637414912 (A+12K) < 693637419008 (A+16K)

Thus A+12K is definitely something wrong.

Another thing is, the target bytenr (A+12K) is for root 10, while the 
on-disk A+16K is also for root 10.

In that case, it may be a bitflip:

hex(A+12K) = 0xa180030000
hex(a+16K) = 0xa180031000

But I'm not 100% sure, because all the bytenrs are also not 16K aligned, 
which may or may not be a problem.

BTW, for such unaligned case, it's impossible for tree-checker to 
properly check...

Thanks,
Qu


> 
> Laurentiu
