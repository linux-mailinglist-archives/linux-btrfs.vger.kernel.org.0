Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146907465CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jul 2023 00:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGCWlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCWlt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 18:41:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68BAE5F
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688424100; x=1689028900; i=quwenruo.btrfs@gmx.com;
 bh=4ogWzy0hTkseTI0QdAeOqhMZoZCqSes+OjIQ/x0F/FE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=A21i0RXY9LTP73YA2/s4kk3plTT7/Pd0lsShxZGC45sNmeNYCOWd53tW1BhNQ1NvMNUKAsS
 kv00iioB52mB6DYPVi3/SWW6c3mwKrfZCeSFbRJ6xJbjBDOkgXN5ygNmVgExOhBoew3IKDCVL
 qVyhTAeS/oj62EXY8GIMpFE7OR9+VdR87yFzMRL3zBfImB6jRQrd2NvtobkhBasjoA4WUW1i3
 qfe+b+c1ciWy1jAUTeSUkRRtmnp6bt0gxjWPyEzsvMgV2TlhdSdJyHlkJQkyNN8+gtjN4kV2i
 bktoMyUdkDx3eRl4fXSYjRuEyzn8V0Bq9m3eHPeY1P0+/Ft+IohQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1pfmRB3B6s-00qTM3; Tue, 04
 Jul 2023 00:41:40 +0200
Message-ID: <1513dfe3-8d58-a511-5279-c6bf1ecd0e0e@gmx.com>
Date:   Tue, 4 Jul 2023 06:41:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>
References: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
 <1449f988-b5f6-3a21-eea0-44298ed7dd42@gmx.com>
 <96a5d8e6-8905-231a-b55a-876919c60694@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <96a5d8e6-8905-231a-b55a-876919c60694@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hsJeItmitzsYKXg7WAe0hL/PrVrriP6rURpdGYhMf1OwuxfIy8/
 K4S/rJyN8KwapEYtTmFOX5ES7v6hutrwpfiYPSRjmZd8elAW8jQD/0m+Pvlmaz1ZbA5wIBG
 8a3O895CfZM+iErw7zVRAALohVSeVJmHVCUcJyAxk3jNeaVQlhe9WT4CPBj8xnE+24Q9ZEZ
 9bYKZJc8lakmFmMA+5m6Q==
UI-OutboundReport: notjunk:1;M01:P0:Cs12PjU2P2Y=;N4IauEiOLB4FgjMee+gM+zdVqMe
 VM639wzm/o8R7A4dme0p2zSwagdpQF7mxUrNkermk5B9Uof1bBRmRUwJnP86LN709ZmHtEnEA
 kF2M3lLa7Mlxx0bbirNCyNCLpmK3fs9CRpb7Q67xsSKeFE3ZKFxSHaMHNFPNSnmA++tViB87Z
 RFPjea4iw4ZOsdP59dZzutqKKqO7Up33Zot85XCmnbuRSBZVPSe4z9Q1qU6i4Z86Src6tbU02
 SHiRAfD/HtF6/FNZVU2to5DHJT1tHaIXEkifl+boDduVhgesnvguSBObR8HO/b0CxYCEa0J6d
 6dqHyYeP3KspnQ8SxnUjXGejV+YKOnb64rUE5JkVA/cj51e6/71QWxTpKqCkGjKmzq3eCvn5A
 //Ug5XbA9bVVLuSqHmCVJe6iTgFFXCFenj/Ufs3gI3gY7HYXscD9fICGA83hrAl891UqyYBw8
 qBnaBUiIfRUtJrTwcCe2AzwEHJOGxQBGyyFzEWQns+dauozC7ZxN7XEi4/2Jg/RuMYNrqQVef
 CEL1JTMPf+ttCpWosEzOP7TnZy+Z1UCGvbdU2TpPdyo6yGqpJZYW5Bdqhjvs4anrS/Y7pT/IK
 4UFPmsn5/PCIjCvBfcO5q6BfMnBRckQ0FIuCmKW0V2WtV4NPPDaIJfeCE1nfEtRtNi45DTVKY
 qoT5na1XwWb/pUe1EY6R3qccAfTWIYU58TrGD/pjfJ5XqqhyXcgLolq3mYJY3+pm0w1+jz3La
 zu7G9XAlkgpVhVStjToTYo98rpDF9AW2WVguec0vGZGeF4q+KH+swtSWmNu9xobtpZgvfk+WP
 ZSOASarjJVgz1H3dNDp8ZXilA6efbHKH+vkVLdv2oxXL+B0PND7y6jkNpQwiCprtr4IQmishb
 cs9U8+jR3nA/zYO5P3jQfbw/HQOd2Rq+KyK8PHI9YP7WuBwunNufUECCMFGywnKs6/f1hKMdf
 qMAgYyt9em1dBJTyI9+wu/pZSA4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/3 23:48, Johannes Thumshirn wrote:
> On 03.07.23 14:03, Qu Wenruo wrote:
>>
>>
>> On 2023/7/3 19:47, Johannes Thumshirn wrote:
>>> As an optimization scrub_simple_mirror() performs reads in 64k chunks,=
 if
>>> at least one block of this chunk is has an extent allocated to it.
>>>
>>> For zoned devices, this can lead to a read beyond the zone's write
>>> pointer. But as there can't be any data beyond the write pointer, ther=
e's
>>> no point in reading from it.
>>>
>>> Cc: Qu Wenruo <wqu@suse.com>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> ---
>>> While this is only a marginal optimization for the current code, it wi=
ll
>>> become necessary for RAID on zoned drives using the RAID strip tree.
>>> ---
>>
>> Personally speaking, I'd prefer RST code to change
>> scrub_submit_initial_read() to only submit the read with set bits of
>> extent_sector_bitmap.
>> (Change it to something like scrub_stripe_submit_repair_read()).
>
> I'll look into it.

I can craft an RFC for the use case soon.

Thanks,
Qu
>
>> The current change is a little too ad-hoc, and not that worthy by itsel=
f.
>> Especially considering that reading garbage (to reduce IOPS) is a
>> feature (if not a selling point of lower IOPS) of the new scrub code.
>>
>> I totally understand RST would hate to read any garbage, as that would
>> make btrfs_map_block() complain heavily.
>
> Yeah I've started to skip ranges that return ENOENT from btrfs_map_block=
()
> in btrfs_submit_bio(). I /think/ that's also needed for holes.
>
>>
>> Thus in that case, I'd prefer the initial read for RST (regular zoned
>> are still free to read the garbage) to only submit the sectors covered
>> by extents.
>
