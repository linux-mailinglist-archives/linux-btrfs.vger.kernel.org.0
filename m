Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057E72533CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 17:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHZPfs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 11:35:48 -0400
Received: from mail.xmyslivec.cz ([83.167.247.77]:55808 "EHLO
        mail.xmyslivec.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgHZPfp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 11:35:45 -0400
Received: from [IPv6:2001:1488:fffe:6015::128] (unknown [IPv6:2001:1488:fffe:6015::128])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.xmyslivec.cz (Postfix) with ESMTPSA id F0320402A5;
        Wed, 26 Aug 2020 17:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xmyslivec.cz;
        s=master; t=1598456118;
        bh=9D7XRXTObRqq+Gw5blKKBibYH3iu9Y0v0mEq7EDUaoM=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=VYDGnD0oHHqfdONTEdJEHe5cHp6nD7vrNxcnxsa05CEcmZvDxIWiOBEF9oEgJaIOm
         rKaK6J9O6+kPXy21d4X83gfqvY47DEGIN+2m0DrBTRBuUd+pFa0R1dLIVFKclagmde
         gkTqjwHm6j8eZWJwtq4ydWO/SErUQBANLI93goY/vbkrPZ6ifJuHnNPxScLL2F7MiE
         jlJaaFrW0QLXUVskaz+/FmAzI4o+eDofvAfmOnzIksloTA9yo/FwtTwpR+RTDeTDu2
         XEwHooyhdXVckkQF3NfIoinECBz4NKF1Ar3BtlIZg1B/q866/V672PkQs2Zg9ZNxeP
         La+YyMAsTpDIQ==
To:     Chris Murphy <lists@colorremedies.com>,
        Song Liu <songliubraving@fb.com>
Cc:     Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz>
 <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz>
 <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz>
 <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
From:   Vojtech Myslivec <vojtech@xmyslivec.cz>
Autocrypt: addr=vojtech@xmyslivec.cz; prefer-encrypt=mutual; keydata=
 mDMEXDk3FBYJKwYBBAHaRw8BAQdAxYGS4sOZd1kASDXgtvBZa7SMJqicmc0FaSpmSZh9S420
 J1ZvanRlY2ggTXlzbGl2ZWMgPHZvanRlY2hAeG15c2xpdmVjLmN6PoiZBBMWCABBAhsDBQkD
 wmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEcy0E0v45eOJcDrwyzG9czj6y/JMFAlw8
 uhkCGQEACgkQzG9czj6y/JMKtQD9Fe633NqvTgifhCogsl3u6nYbOprbqyH9YVPniWhBRioB
 APNejTQYM1gvWAWhtV0rtDjER8i1tIHwq4sJUw594HQDuDgEXDk3FBIKKwYBBAGXVQEFAQEH
 QDR6xHA2ZcMD6DRi7xqX5spgU+7EJJI03zmAE6936SJtAwEIB4h+BBgWCAAmFiEEcy0E0v45
 eOJcDrwyzG9czj6y/JMFAlw5NxQCGwwFCQPCZwAACgkQzG9czj6y/JPF6wEAz8Um0I7iFLGI
 kxHnWDeYKFgnkRyQgShZWm0/xmBToCYA/iT0Ug9beOLu/pbptwA9V5QQ//78SZ7R0PoXwxTf
 MqIIuDMEXDy4fRYJKwYBBAHaRw8BAQdAsd+asyPI2WagjyIEmoDI7mjcy45kZs3LEU0LgXeG
 4IKI9QQYFggAJhYhBHMtBNL+OXjiXA68MsxvXM4+svyTBQJcPLh9AhsCBQkDwmcAAIEJEMxv
 XM4+svyTdiAEGRYIAB0WIQTRAYeGgCc08YdlVnm4uGCQpsyH1wUCXDy4fQAKCRC4uGCQpsyH
 106rAQDZjQVT6qDwg5WNk4DTZmbzg4usw7Q08gs0hDazIz0H9AEAmEj8bg68fvjJUMO3GYY0
 HzfSH0m6wiJpNrPPbQunhQ1vpwEAwkISc77KHnx3pKeZ6Ilx5O6w5S8uJetnQIiNuUZkkcMB
 AIXDxrKP3h8c416yo4gjtRH4bdtsMkgv8jtRXXSty+YA
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
Message-ID: <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz>
Date:   Wed, 26 Aug 2020 17:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------D605EAC5F71D09F4A604177C"
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi again,

On 20. 08. 20 0:58, Chris Murphy wrote:
> The problem here I think is that /proc/pid/stack is empty. You might
> have to hammer on it a bunch of times to get a stack. I can't tell if
> the sysrq+w is enough information to conclusively tell if this is
> strictly an md problem or if there's something else going on.
> 
> But I do see in the sysrq+w evidence of a Btrfs snapshot happening,
> which will result in a flush of the file system. Since the mdadm raid
> journal is on two SSDs which should be fast enough to accept the
> metadata changes before actually doing the flush.

We were lucky to dump some stacks yesterday, when the issue happened again.


In `sysrq.log`, there is an dmesg/kern.log output of

    echo w > /proc/sysrq-trigger

command, when `md1_raid6` started to consume 100% CPU and all
btrfs-snapshot-related commands stuck in the *disk sleep* state.

We had issued sysrq+w command several times and I have included all
unique tasks appeared there.


In `stack_md1_reclaim.txt`, `stack_btrfs-transacti.txt` and
`stack_btrfs*.txt`, there are outputs of

    cat /proc/<pid>/stack

of given processes during the same time. The output is still the same
when we issued this command several times.


In `stack_md1_raid6-[0-3].txt`, there are outputs of the same command
where pid is `md1_raid6` process id. We issued that several time and the
output differs a bit sometimes. If I get it right, differs only in
instruction offset of given functions. I include all the combinations we
encounter for case it matters.

We have dumped stack of this process in a while-true cycle just after we
perform a manual "unstuck" workaround (I described this action in the
first e-mail). I can send it to the mailing list as well if needed.



I hope these outputs include what you, Song, requested on July the 30th
(and I hope it's ok to continue in this thread)

On 30. 07. 20 8:45, Song Liu wrote:
>> On Jul 29, 2020, at 2:06 PM, Guoqing Jiang wrote:
>>
>> Hi,
>>
>> On 7/22/20 10:47 PM, Vojtech Myslivec wrote:
>>> 1. What should be the cause of this problem?
>>
>> Just a quick glance based on the stacks which you attached, I guess
>> it could be a deadlock issue of raid5 cache super write.
>>
>> Maybe the commit 8e018c21da3f ("raid5-cache: fix a deadlock in
>> superblock write") didn't fix the problem completely.  Cc Song.
>>
>> And I am curious why md thread is not waked if mddev_trylock fails,
>> you can give it a try but I can't promise it helps ...
>
> Thanks Guoqing!
>
> I am not sure whether we hit the mddev_trylock() failure. Looks like
> the md1_raid6 thread is already running at 100%.
>
> A few questions:
>
> 1. I see wbt_wait in the stack trace. Are we using write back
>    throttling here?
> 2. Could you please get the /proc/<pid>/stack for <pid> of md1_raid6?
>    We may want to sample it multiple times.
>
> Thanks,
> Song


Thanks,
Vojtech and Michal

--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_md1_raid6-0.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_md1_raid6-0.txt"

WzwwPl0gb3BzX3J1bl9pbysweDQwLzB4ZDgwIFtyYWlkNDU2XQpbPDA+XSBoYW5kbGVfc3Ry
aXBlKzB4YzMyLzB4MjIzMCBbcmFpZDQ1Nl0KWzwwPl0gaGFuZGxlX2FjdGl2ZV9zdHJpcGVz
LmlzcmEuNzErMHgzYjgvMHg1OTAgW3JhaWQ0NTZdCls8MD5dIHJhaWQ1ZCsweDM5Mi8weDVi
MCBbcmFpZDQ1Nl0KWzwwPl0gbWRfdGhyZWFkKzB4OTQvMHgxNTAgW21kX21vZF0KWzwwPl0g
a3RocmVhZCsweDExMi8weDEzMApbPDA+XSByZXRfZnJvbV9mb3JrKzB4MjIvMHg0MAo=
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_md1_raid6-1.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_md1_raid6-1.txt"

WzwwPl0gb3BzX3J1bl9pbysweDQwLzB4ZDgwIFtyYWlkNDU2XQpbPDA+XSBoYW5kbGVfc3Ry
aXBlKzB4MTM2LzB4MjIzMCBbcmFpZDQ1Nl0KWzwwPl0gaGFuZGxlX2FjdGl2ZV9zdHJpcGVz
LmlzcmEuNzErMHgzYjgvMHg1OTAgW3JhaWQ0NTZdCls8MD5dIHJhaWQ1ZCsweDM5Mi8weDVi
MCBbcmFpZDQ1Nl0KWzwwPl0gbWRfdGhyZWFkKzB4OTQvMHgxNTAgW21kX21vZF0KWzwwPl0g
a3RocmVhZCsweDExMi8weDEzMApbPDA+XSByZXRfZnJvbV9mb3JrKzB4MjIvMHg0MAo=
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_md1_raid6-2.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_md1_raid6-2.txt"

WzwwPl0gb3BzX3J1bl9pbysweDQwLzB4ZDgwIFtyYWlkNDU2XQpbPDA+XSBoYW5kbGVfc3Ry
aXBlKzB4YzMyLzB4MjIzMCBbcmFpZDQ1Nl0KWzwwPl0gaGFuZGxlX2FjdGl2ZV9zdHJpcGVz
LmlzcmEuNzErMHg0ODUvMHg1OTAgW3JhaWQ0NTZdCls8MD5dIHJhaWQ1ZCsweDM5Mi8weDVi
MCBbcmFpZDQ1Nl0KWzwwPl0gbWRfdGhyZWFkKzB4OTQvMHgxNTAgW21kX21vZF0KWzwwPl0g
a3RocmVhZCsweDExMi8weDEzMApbPDA+XSByZXRfZnJvbV9mb3JrKzB4MjIvMHg0MAo=
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_md1_raid6-3.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_md1_raid6-3.txt"

WzwwPl0gb3BzX3J1bl9pbysweDQwLzB4ZDgwIFtyYWlkNDU2XQpbPDA+XSBoYW5kbGVfc3Ry
aXBlKzB4MTM2LzB4MjIzMCBbcmFpZDQ1Nl0KWzwwPl0gaGFuZGxlX2FjdGl2ZV9zdHJpcGVz
LmlzcmEuNzErMHg0MjAvMHg1OTAgW3JhaWQ0NTZdCls8MD5dIHJhaWQ1ZCsweDM5Mi8weDVi
MCBbcmFpZDQ1Nl0KWzwwPl0gbWRfdGhyZWFkKzB4OTQvMHgxNTAgW21kX21vZF0KWzwwPl0g
a3RocmVhZCsweDExMi8weDEzMApbPDA+XSByZXRfZnJvbV9mb3JrKzB4MjIvMHg0MAo=
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_md1_reclaim.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_md1_reclaim.txt"

WzwwPl0gcnFfcW9zX3dhaXQrMHhmYS8weDE3MApbPDA+XSB3YnRfd2FpdCsweDk4LzB4ZTAK
WzwwPl0gX19ycV9xb3NfdGhyb3R0bGUrMHgyMy8weDMwCls8MD5dIGJsa19tcV9tYWtlX3Jl
cXVlc3QrMHgxMmEvMHg1ZDAKWzwwPl0gZ2VuZXJpY19tYWtlX3JlcXVlc3QrMHhjZi8weDMx
MApbPDA+XSBzdWJtaXRfYmlvKzB4NDIvMHgxYzAKWzwwPl0gbWRfdXBkYXRlX3NiLnBhcnQu
NzErMHgzYzAvMHg4ZjAgW21kX21vZF0KWzwwPl0gcjVsX2RvX3JlY2xhaW0rMHgzMmEvMHgz
YjAgW3JhaWQ0NTZdCls8MD5dIG1kX3RocmVhZCsweDk0LzB4MTUwIFttZF9tb2RdCls8MD5d
IGt0aHJlYWQrMHgxMTIvMHgxMzAKWzwwPl0gcmV0X2Zyb21fZm9yaysweDIyLzB4NDAK
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_btrfs-transacti.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_btrfs-transacti.txt"

WzwwPl0gd2FpdF9vbl9wYWdlX2JpdCsweDE1Yy8weDIzMApbPDA+XSBfX2ZpbGVtYXBfZmRh
dGF3YWl0X3JhbmdlKzB4ODkvMHhmMApbPDA+XSBmaWxlbWFwX2ZkYXRhd2FpdF9yYW5nZSsw
eGUvMHgyMApbPDA+XSBfX2J0cmZzX3dhaXRfbWFya2VkX2V4dGVudHMuaXNyYS4xOSsweGMy
LzB4MTAwIFtidHJmc10KWzwwPl0gYnRyZnNfd3JpdGVfYW5kX3dhaXRfdHJhbnNhY3Rpb24u
aXNyYS4yMysweDY3LzB4ZDAgW2J0cmZzXQpbPDA+XSBidHJmc19jb21taXRfdHJhbnNhY3Rp
b24rMHg3NTUvMHhhNTAgW2J0cmZzXQpbPDA+XSB0cmFuc2FjdGlvbl9rdGhyZWFkKzB4MTQ0
LzB4MTcwIFtidHJmc10KWzwwPl0ga3RocmVhZCsweDExMi8weDEzMApbPDA+XSByZXRfZnJv
bV9mb3JrKzB4MjIvMHg0MAo=
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_btrfs32445.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_btrfs32445.txt"

WzwwPl0gZG9fd2FpdCsweDFjNy8weDIzMApbPDA+XSBrZXJuZWxfd2FpdDQrMHhhNi8weDE0
MApbPDA+XSBfX2RvX3N5c193YWl0NCsweDgzLzB4OTAKWzwwPl0gZG9fc3lzY2FsbF82NCsw
eDUyLzB4MTcwCls8MD5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4
YTkK
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_btrfs32277.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_btrfs32277.txt"

WzwwPl0gcndzZW1fZG93bl93cml0ZV9zbG93cGF0aCsweDMyOS8weDRlMApbPDA+XSBidHJm
c19kZWxldGVfc3Vidm9sdW1lKzB4OTAvMHg1ZjAgW2J0cmZzXQpbPDA+XSBidHJmc19pb2N0
bF9zbmFwX2Rlc3Ryb3krMHg1YjMvMHg2ZjAgW2J0cmZzXQpbPDA+XSBidHJmc19pb2N0bCsw
eGE1Zi8weDJlZjAgW2J0cmZzXQpbPDA+XSBrc3lzX2lvY3RsKzB4ODYvMHhjMApbPDA+XSBf
X3g2NF9zeXNfaW9jdGwrMHgxNi8weDIwCls8MD5dIGRvX3N5c2NhbGxfNjQrMHg1Mi8weDE3
MApbPDA+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5Cg==
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_btrfs31357.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_btrfs31357.txt"

WzwwPl0gcndzZW1fZG93bl93cml0ZV9zbG93cGF0aCsweDMyOS8weDRlMApbPDA+XSBidHJm
c19kZWxldGVfc3Vidm9sdW1lKzB4OTAvMHg1ZjAgW2J0cmZzXQpbPDA+XSBidHJmc19pb2N0
bF9zbmFwX2Rlc3Ryb3krMHg1YjMvMHg2ZjAgW2J0cmZzXQpbPDA+XSBidHJmc19pb2N0bCsw
eGE1Zi8weDJlZjAgW2J0cmZzXQpbPDA+XSBrc3lzX2lvY3RsKzB4ODYvMHhjMApbPDA+XSBf
X3g2NF9zeXNfaW9jdGwrMHgxNi8weDIwCls8MD5dIGRvX3N5c2NhbGxfNjQrMHg1Mi8weDE3
MApbPDA+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5Cg==
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_btrfs31094.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_btrfs31094.txt"

WzwwPl0gcndzZW1fZG93bl93cml0ZV9zbG93cGF0aCsweDMyOS8weDRlMApbPDA+XSBidHJm
c19kZWxldGVfc3Vidm9sdW1lKzB4OTAvMHg1ZjAgW2J0cmZzXQpbPDA+XSBidHJmc19pb2N0
bF9zbmFwX2Rlc3Ryb3krMHg1YjMvMHg2ZjAgW2J0cmZzXQpbPDA+XSBidHJmc19pb2N0bCsw
eGE1Zi8weDJlZjAgW2J0cmZzXQpbPDA+XSBrc3lzX2lvY3RsKzB4ODYvMHhjMApbPDA+XSBf
X3g2NF9zeXNfaW9jdGwrMHgxNi8weDIwCls8MD5dIGRvX3N5c2NhbGxfNjQrMHg1Mi8weDE3
MApbPDA+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5Cg==
--------------D605EAC5F71D09F4A604177C
Content-Type: text/plain; charset=UTF-8;
 name="stack_btrfs30168.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stack_btrfs30168.txt"

WzwwPl0gd2FpdF9mb3JfY29tbWl0KzB4NTgvMHg4MCBbYnRyZnNdCls8MD5dIGJ0cmZzX2Nv
bW1pdF90cmFuc2FjdGlvbisweDE2OS8weGE1MCBbYnRyZnNdCls8MD5dIGJ0cmZzX21rc3Vi
dm9sKzB4MmU5LzB4NDUwIFtidHJmc10KWzwwPl0gX19idHJmc19pb2N0bF9zbmFwX2NyZWF0
ZSsweDE2Ny8weDE3MCBbYnRyZnNdCls8MD5dIGJ0cmZzX2lvY3RsX3NuYXBfY3JlYXRlX3Yy
KzB4YzUvMHhlMCBbYnRyZnNdCls8MD5dIGJ0cmZzX2lvY3RsKzB4ZjYxLzB4MmVmMCBbYnRy
ZnNdCls8MD5dIGtzeXNfaW9jdGwrMHg4Ni8weGMwCls8MD5dIF9feDY0X3N5c19pb2N0bCsw
eDE2LzB4MjAKWzwwPl0gZG9fc3lzY2FsbF82NCsweDUyLzB4MTcwCls8MD5dIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkK
--------------D605EAC5F71D09F4A604177C
Content-Type: text/x-log; charset=UTF-8;
 name="sysrq.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="sysrq.log"

[Tue Aug 25 16:41:16 2020] sysrq: Show Blocked State
[Tue Aug 25 16:41:16 2020]   task                        PC stack   pid f=
ather

[Tue Aug 25 16:41:16 2020] md1_reclaim     D    0   806      2 0x80004000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  ? __switch_to_asm+0x34/0x70
[Tue Aug 25 16:41:16 2020]  ? __switch_to_asm+0x34/0x70
[Tue Aug 25 16:41:16 2020]  ? wbt_exit+0x30/0x30
[Tue Aug 25 16:41:16 2020]  ? __wbt_done+0x30/0x30
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  io_schedule+0x12/0x40
[Tue Aug 25 16:41:16 2020]  rq_qos_wait+0xfa/0x170
[Tue Aug 25 16:41:16 2020]  ? __switch_to_asm+0x34/0x70
[Tue Aug 25 16:41:16 2020]  ? karma_partition+0x1e0/0x1e0
[Tue Aug 25 16:41:16 2020]  ? wbt_exit+0x30/0x30
[Tue Aug 25 16:41:16 2020]  wbt_wait+0x98/0xe0
[Tue Aug 25 16:41:16 2020]  __rq_qos_throttle+0x23/0x30
[Tue Aug 25 16:41:16 2020]  blk_mq_make_request+0x12a/0x5d0
[Tue Aug 25 16:41:16 2020]  generic_make_request+0xcf/0x310
[Tue Aug 25 16:41:16 2020]  submit_bio+0x42/0x1c0
[Tue Aug 25 16:41:16 2020]  ? md_super_write.part.70+0x98/0x120 [md_mod]
[Tue Aug 25 16:41:16 2020]  md_update_sb.part.71+0x3c0/0x8f0 [md_mod]
[Tue Aug 25 16:41:16 2020]  r5l_do_reclaim+0x32a/0x3b0 [raid456]
[Tue Aug 25 16:41:16 2020]  ? schedule_timeout+0x162/0x340
[Tue Aug 25 16:41:16 2020]  ? prepare_to_wait_event+0xb6/0x140
[Tue Aug 25 16:41:16 2020]  ? md_register_thread+0xd0/0xd0 [md_mod]
[Tue Aug 25 16:41:16 2020]  md_thread+0x94/0x150 [md_mod]
[Tue Aug 25 16:41:16 2020]  ? finish_wait+0x80/0x80
[Tue Aug 25 16:41:16 2020]  kthread+0x112/0x130
[Tue Aug 25 16:41:16 2020]  ? kthread_park+0x80/0x80
[Tue Aug 25 16:41:16 2020]  ret_from_fork+0x22/0x40

[Tue Aug 25 16:41:16 2020] btrfs-transacti D    0   893      2 0x80004000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  io_schedule+0x12/0x40
[Tue Aug 25 16:41:16 2020]  wait_on_page_bit+0x15c/0x230
[Tue Aug 25 16:41:16 2020]  ? file_fdatawait_range+0x20/0x20
[Tue Aug 25 16:41:16 2020]  __filemap_fdatawait_range+0x89/0xf0
[Tue Aug 25 16:41:16 2020]  filemap_fdatawait_range+0xe/0x20
[Tue Aug 25 16:41:16 2020]  __btrfs_wait_marked_extents.isra.19+0xc2/0x10=
0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_write_and_wait_transaction.isra.23+0x67=
/0xd0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_commit_transaction+0x755/0xa50 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? start_transaction+0xd5/0x540 [btrfs]
[Tue Aug 25 16:41:16 2020]  transaction_kthread+0x144/0x170 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? btrfs_cleanup_transaction+0x590/0x590 [btrf=
s]
[Tue Aug 25 16:41:16 2020]  kthread+0x112/0x130
[Tue Aug 25 16:41:16 2020]  ? kthread_park+0x80/0x80
[Tue Aug 25 16:41:16 2020]  ret_from_fork+0x22/0x40

[Tue Aug 25 16:41:16 2020] btrfs           D    0 30168  30162 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  wait_for_commit+0x58/0x80 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? finish_wait+0x80/0x80
[Tue Aug 25 16:41:16 2020]  btrfs_commit_transaction+0x169/0xa50 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? btrfs_record_root_in_trans+0x56/0x60 [btrfs=
]
[Tue Aug 25 16:41:16 2020]  ? start_transaction+0xd5/0x540 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_mksubvol+0x2e9/0x450 [btrfs]
[Tue Aug 25 16:41:16 2020]  __btrfs_ioctl_snap_create+0x167/0x170 [btrfs]=

[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_create_v2+0xc5/0xe0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xf61/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f273259b427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffe48178418 EFLAGS: 00000206 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f273259b427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffe48178458 RSI: 0000000050009417 RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 00005637741dc260 R08: 0000000000000008 R0=
9: 0000000035322d38
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000206 R1=
2: 00005637741dc2b0
[Tue Aug 25 16:41:16 2020] R13: 00005637741dc2b0 R14: 0000000000000003 R1=
5: 0000000000000004

[Tue Aug 25 16:41:16 2020] btrfs           D    0 31094  31088 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7ff3fa6a3427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffe92fc4058 EFLAGS: 00000202 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007ff3fa6a3427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffe92fc4090 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 000055b4e34ab2ca R0=
9: 00007ff3fa72de80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000202 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007ffe92fc4090 R1=
5: 000055b4e34ab2ca

[Tue Aug 25 16:41:16 2020] btrfs           D    0 31357  31351 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f9c14290427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007fff4c9f8ed8 EFLAGS: 00000206 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f9c14290427
[Tue Aug 25 16:41:16 2020] RDX: 00007fff4c9f8f10 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 000055ea83aa82c8 R0=
9: 00007f9c1431ae80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000206 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007fff4c9f8f10 R1=
5: 000055ea83aa82c8

[Tue Aug 25 16:41:16 2020] btrfs           D    0 32277  32271 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f0b35736427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007fff96ad7c48 EFLAGS: 00000206 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f0b35736427
[Tue Aug 25 16:41:16 2020] RDX: 00007fff96ad7c80 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 000055e2598b62c8 R0=
9: 00007f0b357c0e80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000206 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007fff96ad7c80 R1=
5: 000055e2598b62c8

[Tue Aug 25 16:41:16 2020] btrfs           D    0 32451  32445 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f0517ff8427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffc862d3c98 EFLAGS: 00000202 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f0517ff8427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffc862d3cd0 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 0000555d6d7872ca R0=
9: 00007f0518082e80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000202 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007ffc862d3cd0 R1=
5: 0000555d6d7872ca

[Tue Aug 25 16:41:16 2020] btrfs           D    0   596    590 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7ffa2b954427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffc88d95748 EFLAGS: 00000206 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007ffa2b954427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffc88d95780 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 0000558d2b97f2c8 R0=
9: 00007ffa2b9dee80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000206 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007ffc88d95780 R1=
5: 0000558d2b97f2c8

[Tue Aug 25 16:41:16 2020] btrfs           D    0   792    786 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f74f06d2427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007fffbb878738 EFLAGS: 00000202 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f74f06d2427
[Tue Aug 25 16:41:16 2020] RDX: 00007fffbb878770 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 000055f062e442c7 R0=
9: 00007f74f075ce80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000202 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007fffbb878770 R1=
5: 000055f062e442c7

[Tue Aug 25 16:41:16 2020] btrfs           D    0   833    827 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f65fee13427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffc45aa0508 EFLAGS: 00000202 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f65fee13427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffc45aa0540 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 000055d819de32c6 R0=
9: 00007f65fee9de80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000202 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007ffc45aa0540 R1=
5: 000055d819de32c6

[Tue Aug 25 16:41:16 2020] btrfs           D    0 10542  10515 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f48b0d4a427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffdf1ab4fd8 EFLAGS: 00000206 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f48b0d4a427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffdf1ab5010 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 00005631cce8a2c8 R0=
9: 00007f48b0dd4e80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000206 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007ffdf1ab5010 R1=
5: 00005631cce8a2c8

[Tue Aug 25 16:41:16 2020] btrfs           D    0  1667   1661 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f759eff1427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffcc4fb06c8 EFLAGS: 00000202 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f759eff1427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffcc4fb0700 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 00005584f7c5a2ca R0=
9: 00007f759f07be80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000202 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007ffcc4fb0700 R1=
5: 00005584f7c5a2ca

[Tue Aug 25 16:41:16 2020] btrfs           D    0  2473   2467 0x00000000=

[Tue Aug 25 16:41:16 2020] Call Trace:
[Tue Aug 25 16:41:16 2020]  __schedule+0x2dd/0x710
[Tue Aug 25 16:41:16 2020]  schedule+0x40/0xb0
[Tue Aug 25 16:41:16 2020]  rwsem_down_write_slowpath+0x329/0x4e0
[Tue Aug 25 16:41:16 2020]  ? kmem_cache_alloc_trace+0x15e/0x230
[Tue Aug 25 16:41:16 2020]  btrfs_delete_subvolume+0x90/0x5f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? d_lookup+0x25/0x50
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl_snap_destroy+0x5b3/0x6f0 [btrfs]
[Tue Aug 25 16:41:16 2020]  btrfs_ioctl+0xa5f/0x2ef0 [btrfs]
[Tue Aug 25 16:41:16 2020]  ? ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  ksys_ioctl+0x86/0xc0
[Tue Aug 25 16:41:16 2020]  __x64_sys_ioctl+0x16/0x20
[Tue Aug 25 16:41:16 2020]  do_syscall_64+0x52/0x170
[Tue Aug 25 16:41:16 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Aug 25 16:41:16 2020] RIP: 0033:0x7f278ea1a427
[Tue Aug 25 16:41:16 2020] Code: Bad RIP value.
[Tue Aug 25 16:41:16 2020] RSP: 002b:00007ffd784d5318 EFLAGS: 00000206 OR=
IG_RAX: 0000000000000010
[Tue Aug 25 16:41:16 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RC=
X: 00007f278ea1a427
[Tue Aug 25 16:41:16 2020] RDX: 00007ffd784d5350 RSI: 000000005000940f RD=
I: 0000000000000003
[Tue Aug 25 16:41:16 2020] RBP: 0000000000000000 R08: 000055b8f4d412de R0=
9: 00007f278eaa4e80
[Tue Aug 25 16:41:16 2020] R10: fffffffffffffb66 R11: 0000000000000206 R1=
2: 0000000000000003
[Tue Aug 25 16:41:16 2020] R13: 0000000000000003 R14: 00007ffd784d5350 R1=
5: 000055b8f4d412de

--------------D605EAC5F71D09F4A604177C--
