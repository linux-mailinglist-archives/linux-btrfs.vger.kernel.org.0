Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A634D6EF073
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjDZIuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZIuL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 04:50:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310DE30D6
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 01:50:09 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpru-1qcCBs3mTC-00pM01; Wed, 26
 Apr 2023 10:50:03 +0200
Message-ID: <1e917ae3-71fd-b684-12b0-044e49d22afa@gmx.com>
Date:   Wed, 26 Apr 2023 16:50:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     =?UTF-8?Q?Lauren=c8=9biu_Nicola?= <lnicola@dend.ro>
Cc:     linux-btrfs@vger.kernel.org
References: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
 <a0f6195f-e6d1-f633-9cd7-310fe5786546@gmx.com>
 <f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corruption and error on Linux 6.2.8 in btrfs_commit_transaction
 -> btrfs_run_delayed_refs
In-Reply-To: <f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:owMuj66rTohZljzytOXwVEJt2ShVW5C8mQILEEgGdi7838v97hO
 UnIVOTyhE0SBqTTXhozkj5VOGXBNXIlcFp1ot9SF9dmokAuG8EtMGDTw6dK9KrtTyz41MVt
 z596XHEya3SjmKdEzrzE4RTIGGTpeQDtDRbJTQuEi2A2OqZ5O9x5jIJg8LA0rhjliQcJEtW
 E9MzKqKKXD32/t1cCWQ3Q==
UI-OutboundReport: notjunk:1;M01:P0:6I2B7s2AyyY=;tAXWvqqC3ADTaDEUyl00+pVSdsN
 vRraeqDz8Wsehhp/j3JoGQZRm/25jeexvHrBxdCq7oJHi/8KomwS98MW1HYI78rynOySn87UP
 qUtw1qfsYmcl5RcrCtD6IY4Tx0s1uzKg1zBxoMDyVlHO+WRvk11Xh6eXAJxR8nvtdj4mW6gBR
 Bz9Dbo225aFXxbVG/wnigzeoYWnOuP8bsEAyAuBWSwsyXKr3yf6ev2SeEs4IuZC6tF0VQ3Jo+
 UH4jyYFU1ESPwGvLzcJNTCza7MTms8kZC1wQLZOFrUV2MK83ZsMHTc0cmMKNu/A4HC11Qk2Xz
 X4b453+CIf840OiueWCLMGELY7VCR6CJHQFoMPiXlhu6CzzMPNEkvV+tZBtiilUi8lIlJynle
 tFS73SL6AXliLwtBBctkyST+CepkrPcvub7+ywgTepEUdpjc5g6N6xztiB/tcHksOE1VDgeiz
 5g+nfEDR/s0gh3pmfGp8jbNanVSNGQR4+/euNeSgKf2GQma0BR70Nw5mNs7jmPMeljpDrDxkK
 CY0CUYOEJ/mN8B9U7QgdCGQWPc0zBLu/YVOSS0c/xwfrAKDU0Va6TGXkxsdEgB3MjL1+aJWqm
 Fftizy1O4wpi38oAo3ym2G+hatI0ddDXaj/+GCAJ17bH+DZBreKGtogNiiZkAm5oIevOElmbb
 y+5fReW4ri9FyeRBj5RHSFSnxc/ukNhyrYSkU58Akdx/QHFjp3W85dIEH9iiycygtTy2eArtC
 5nt+E3QVJvVhBVP5ocL1izpmyaSbys4FKgZa/0ltVxlpySRM1pfbQvlNevkmMcZcDFV/SZCIk
 UVrtj5DGbjthZBrtEkoZggp1v/FDi9ZiiLDOJWO4MEMA7iUo4RPwCR5HBRFwJU3ZelBMSu3Vy
 iCb4peGZ0QLhkIPeh0Fv/MYJZ0K9KvpR/DvAYUc+CDcmPfTnQVpqLGKbqajD/Uv0t+pjJbizD
 3pGr53zlt7FVHox3Qw1TY6SAgDf+tor+l1MDfNK8TrxrEH20rju1j9CSjZO4H1q7yEdGBQ==
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 16:27, Laurențiu Nicola wrote:
> On Wed, Apr 26, 2023, at 11:11, Qu Wenruo wrote:
>> On 2023/4/26 15:35, Laurențiu Nicola wrote:
>>> Hi,
>>>
>> [...]
>>>
>>> WARNING: tree block [693902610432, 693902626816) is not nodesize aligned, may cause problem for 64K page system
>>
>> This is already werid as newerly converted btrfs shouldn't have such
>> tree blocks.
> 
> Hi,
> 
> I had it for about two weeks and probably did some heavy writes (100 GB - 1 TB) to it in the meanwhile, more if you count the uncompressed size.

In your case, all the problem happens in extent tree, and it indeed 
needs quite some data (especially small files) to bump the extent tree.
[...]
>> Do you still have the initial RO flip kernel messages? That would be
>> helpful.
> 
> No, unfortunately https://imgur.com/a/aJgCTw8 is all I have. If there was a more informative message, I must have missed it.

Unfortunately the photo lacks some more important info, like the full 
tree dump of that leaf.

> 
>>
>> Another thing is, I'd like to have memory tested on that machine.
>> Normally some obvious bitflip can be caught by tree-checker, but extent
>> tree things are much harder to detect (as mostly of them needs cross
>> checks).
>> Thus it may cause some problems.
> 
> I did test it recently, but will try again and report if I encounter any errors.
> 
>>
>> The bg tree feature usage may be involved and interesting.
>> Have you ever tried without bg tree?
>> Bg tree feature only makes a difference for huge filesystem to reduce
>> mount time, otherwise not that different.
> 
> Yeah, I've reformatted the two volumes without it and been using them for about 3 weeks and 1.5 months without any issues. However, I didn't do any heavy writes except a btrfs send/receive which gave me a NULL deref that's probably unrelated: https://bugzilla.redhat.com/show_bug.cgi?id=2189091.
> 
> I mentioned in my previous message an IRC user with a similar problem, they have some pastes at http://cwillu.com:8080/73.151.80.76. They've also reported some checksum errors, so the hardware might be suspect. In any case, perhaps you'll spot something.

Thanks for that link, it shows a pretty good dmesg of that RO flip.

It in fact shows a case where there is no EXTENT_ITEM but an invalid 
type key (40). (file "2", item 29)

Furthermore, that item 29 has a size of 37, which matches a inline 
extent backref to a parent.

And the determining evidence is the following:

bin(168) = 0b10101000	(EXTENT_ITEM key type, expected)
bin(40)  = 0b00101000   (Bad key type from the dmesg)

So a bit flip is causing the problem, unfortunately tree-checker is not 
strict enough to detect it (for now).

If you can still reproduce the problem, and keeps the original dmesg of 
the RO flips, then I may have a chance to determine if it's really bitflip.

Thanks,
Qu

> 
> Thanks,
> Laurentiu
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> Could this be some data corruption bug introduced around the 6.2 release?
>>>
>>> Thanks,
>>> Laurentiu
