Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D59315F2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 06:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhBJFtW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 00:49:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:53839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhBJFtT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 00:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612936064;
        bh=nKaIucAjSiSXNkp+7YaTc7M7+sfnup1/R54InuPNUYY=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=DPcM44kufyXancJK3rqYY4hWfYtidPvhIphEfeqRTCf5hskv/D1XI0cm4sQwx/a0v
         g00X60ChWUt2GilZ+h1eeKNfNVnJZWtydodWrxbOlgyQvKYA+bs5Y11CPni8eh8JyK
         FzEN2rSxDa4Q99FnBBoSrGahrT8QL5lNilUR/hpc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3se8-1lrkJb0wnQ-00zkO7; Wed, 10
 Feb 2021 06:47:43 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>, Su Yue <l@damenly.su>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
 <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
 <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
 <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
Date:   Wed, 10 Feb 2021 13:47:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------94C901CDC2AD527EDD671115"
Content-Language: en-US
X-Provags-ID: V03:K1:B4MddodfKg7PCnalGoZBecCEpYU6FLcrzeLpq3ierFpZkxJTs2Z
 bWUWYHCX51P32q5sdlLqD2om4fjrU61TveCw8ZQD0AXOmrzMKV1TEz0CQCacEqGw+QSypTu
 opL4FplIc86oN5odsmWeBeHJfRXOnlM9Kt72XcPydaa9s6c9cyVxyCCvSdIfnKMWiNPmwCA
 OSYbR5lGe+Xp6GWknbAJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s5LreduPXwM=:sQcnMk8li4WRE6IkyO/g9T
 nBdgIZXQHYimwlZJ55rRV1awX1Uh/QfPrSyWlxeoBwdWxHoCDov1t/IZJkigUMIe7nl7feGZW
 Aiyyfmu2UUnqAOm1TZ9dIxnQlE5DwghThuDmAKFlRed+LLoF5P5X9ZAazbWfTIBjcsn5qte74
 auAEW6NHcEdYuQtmD4KrMMF8y7DP6v1K4jucZIYf81g57OLqN+uibYfDQ+m4s/+/do+OzRN29
 Sf6nR0FwhWEiI5zazS6R5nzZ8S0yuaOj5iDyTxyAybUAJlJ6bYKjeBu+TV5KjG/23p2pvucTI
 jjzkRaAR2jRuYj4dz11CqP0f6titbsZpsrnmFI+TfVFOT+KYQqZEzmVRi1oqDXO3Gkn98HDAz
 5WB3yQQW5HtgpkhNPI8DpzW7EkF1Gg3kuHB5htlia1WoWDTxacVEajdRxS69WJZLaBPZYKGzB
 CsNNSvHi2oTgaJ5JZKxlH1NndiZKy8iV9QpoVaqIP2+Shg2DVG+OAX99rG/cb2fAbKufJXYn6
 L6USd2GIWa+RqhQS8zpOTd1RbF0jaRs8JbDIuBAo2eUHajuq/ZAGIQh/+QXYTw6yCA3cWj92S
 kAVbxaNAgLlwfg00XAhDdXLISUYERQd679eemgoXIOd74nmVc4nG6wvFtUbLBZ7/ih6OWmAfR
 0pl38YHTY8g24FC39tlcyulwxyu/QkK7KoW7YViQoOwl/dq88nA3Y7WFeuF7b/0n0t8ch4TE1
 kHGy+4x3tSxB3jv+E2831RxXO1x5oL5/76zEBiXSQtNpsgKXNGBPF6mvkV0CyQMtQGBN3K3ed
 /QOoNIQkOpwNdOna0cHO/Uf6vpelzRvB4RyIm5ijsRSnORswHhrHZmYYPcL67gXMn1929pAgy
 K3Kg5sQ0gMPYSZmJ/D0w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------94C901CDC2AD527EDD671115
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/2/6 =E4=B8=8A=E5=8D=889:57, Erik Jensen wrote:
> On Wed, Feb 3, 2021 at 10:16 PM Erik Jensen <erikjensen@rkjnsn.net> wrot=
e:
>> On Sun, Jan 31, 2021 at 9:50 PM Su Yue <l@damenly.su> wrote:
>>> On Mon 01 Feb 2021 at 10:35, Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> wrote:
>>>> On 2021/1/29 =E4=B8=8B=E5=8D=882:39, Erik Jensen wrote:
>>>>> On Mon, Jan 25, 2021 at 8:54 PM Erik Jensen
>>>>> <erikjensen@rkjnsn.net> wrote:
>>>>>> On Wed, Jan 20, 2021 at 1:08 AM Erik Jensen
>>>>>> <erikjensen@rkjnsn.net> wrote:
>>>>>>> On Wed, Jan 20, 2021 at 12:31 AM Qu Wenruo
>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>> On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
>>>>>>>>> On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
>>>>>>>>>> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen
>>>>>>>>>> <erikjensen@rkjnsn.net>
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen
>>>>>>>>>>> <erikjensen@rkjnsn.net>
>>>>>>>>>>> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> The offending system is indeed ARMv7 (specifically a
>>>>>>>>>>>> Marvell ARMADA=C2=AE
>>>>>>>>>>>> 388), but I believe the Broadcom BCM2835 in my Raspberry
>>>>>>>>>>>> Pi is
>>>>>>>>>>>> actually ARMv6 (with hardware float support).
>>>>>>>>>>>
>>>>>>>>>>> Using NBD, I have verified that I receive the same error
>>>>>>>>>>> when
>>>>>>>>>>> attempting to mount the filesystem on my ARMv6 Raspberry
>>>>>>>>>>> Pi:
>>>>>>>>>>> [ 3491.339572] BTRFS info (device dm-4): disk space
>>>>>>>>>>> caching is enabled
>>>>>>>>>>> [ 3491.394584] BTRFS info (device dm-4): has skinny
>>>>>>>>>>> extents
>>>>>>>>>>> [ 3492.385095] BTRFS error (device dm-4): bad tree block
>>>>>>>>>>> start, want
>>>>>>>>>>> 26207780683776 have 3395945502747707095
>>>>>>>>>>> [ 3492.514071] BTRFS error (device dm-4): bad tree block
>>>>>>>>>>> start, want
>>>>>>>>>>> 26207780683776 have 3395945502747707095
>>>>>>>>>>> [ 3492.553599] BTRFS warning (device dm-4): failed to
>>>>>>>>>>> read tree root
>>>>>>>>>>> [ 3492.865368] BTRFS error (device dm-4): open_ctree
>>>>>>>>>>> failed
>>>>>>>>>>>
>>>>>>>>>>> The Raspberry Pi is running Linux 5.4.83.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Okay, after some more testing, ARM seems to be irrelevant,
>>>>>>>>>> and 32-bit
>>>>>>>>>> is the key factor. On a whim, I booted up an i686, 5.8.14
>>>>>>>>>> kernel in a
>>>>>>>>>> VM, attached the drives via NBD, ran cryptsetup, tried to
>>>>>>>>>> mount, and=E2=80=A6
>>>>>>>>>> I got the exact same error message.
>>>>>>>>>>
>>>>>>>>> My educated guess is on 32bit platforms, we passed
>>>>>>>>> incorrect sector into
>>>>>>>>> bio, thus gave us garbage.
>>>>>>>>
>>>>>>>> To prove that, you can use bcc tool to verify it.
>>>>>>>> biosnoop can do that:
>>>>>>>> https://github.com/iovisor/bcc/blob/master/tools/biosnoop_example=
.txt
>>>>>>>>
>>>>>>>> Just try mount the fs with biosnoop running.
>>>>>>>> With "btrfs ins dump-tree -t chunk <dev>", we can manually
>>>>>>>> calculate the
>>>>>>>> offset of each read to see if they matches.
>>>>>>>> If not match, it would prove my assumption and give us a
>>>>>>>> pretty good
>>>>>>>> clue to fix.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Is this bug happening only on the fs, or any other btrfs
>>>>>>>>> can also
>>>>>>>>> trigger similar problems on 32bit platforms?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>
>>>>>>> I have only observed this error on this file system.
>>>>>>> Additionally, the
>>>>>>> error mounting with the NAS only started after I did a `btrfs
>>>>>>> replace`
>>>>>>> on all five 8TB drives using an x86_64 system. (Ironically, I
>>>>>>> did this
>>>>>>> with the goal of making it faster to use the filesystem on
>>>>>>> the NAS by
>>>>>>> re-encrypting the drives to use a cipher supported by my
>>>>>>> NAS's crypto
>>>>>>> accelerator.)
>>>>>>>
>>>>>>> Maybe this process of shuffling 40TB around caused some value
>>>>>>> in the
>>>>>>> filesystem to increment to the point that a calculation using
>>>>>>> it
>>>>>>> overflows on 32-bit systems?
>>>>>>>
>>>>>>> I should be able to try biosnoop later this week, and I'll
>>>>>>> report back
>>>>>>> with the results.
>>>>>>
>>>>>> Okay, I tried running biosnoop, but I seem to be running into
>>>>>> this
>>>>>> bug: https://github.com/iovisor/bcc/issues/3241 (That bug was
>>>>>> reported
>>>>>> for cpudist, but I'm seeing the same error when I try to run
>>>>>> biosnoop.)
>>>>>>
>>>>>> Anything else I can try?
>>>>>
>>>>> Is it possible to add printks to retrieve the same data?
>>>>>
>>>> Sorry for the late reply, busying testing subpage patchset. (And
>>>> unfortunately no much process).
>>>>
>>>> If bcc is not possible, you can still use ftrace events, but
>>>> unfortunately I didn't find good enough one. (In fact, the trace
>>>> events
>>>> for block layer is pretty limited).
>>>>
>>>> You can try to add printk()s in function blk_account_io_done()
>>>> to
>>>> emulate what's done in function trace_req_completion() of
>>>> biosnoop.
>>>>
>>>> The time delta is not important, we only need the device name,
>>>> sector
>>>> and length.
>>>>
>>>
>>> Tips: There are ftrace events called block:block_rq_issue and
>>> block:block_rq_complete to fetch those infomation. No need to
>>> add printk().
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>
>> Okay, here's the output of the trace:
>> https://gist.github.com/rkjnsn/4cf606874962b5a0284249b2f2e934f5
>>
>> And here's the output dump-tree:
>> https://gist.github.com/rkjnsn/630b558eaf90369478d670a1cb54b40f
>>
>> One important note is that ftrace only captured requests at the
>> underlying block device (nbd, in this case), not at the device mapper
>> level. The encryption header on these drives is 16 MiB, so the offset
>> reported in the trace will be 16777216 bytes larger than the offset
>> brtfs was actually trying to read at the time.
>>
>> In case it's helpful, I believe this is the mapping of which
>> (encrypted) nbd device node in the trace corresponds to which
>> (decrypted) filesystem device:
>> 43,0    33c75e20-26f2-4328-a565-5ef3484832aa
>> 43,32   9bdfdb8f-abfb-47c5-90af-d360d754a958
>> 43,64   39a9463d-65f5-499b-bca8-dae6b52eb729
>> 43,96   f1174dea-ea10-42f2-96b4-4589a2980684
>> 43,128  e669d804-6ea2-4516-8536-1d266f88ebad
>
> What are the chances it's something simple like a long getting used
> somewhere in the code that should actually be a 64-bit int?
>
That's what I expected, but I didn't find anything obviously suspicious ye=
t.

Unfortunately I didn't get much useful info from the trace events.
As a lot of the values doesn't even make sense to me....

But the chunk tree dump proves to be more useful.

Firstly, the offending tree block doesn't even occur in chunk chunk ranges=
.

The offending tree block is 26207780683776, but the tree dump doesn't
have any range there.

The highest chunk is at 5958289850368 + 4294967296, still one digit
lower than the expected value.

I'm surprised we didn't even get any error for that, thus it may
indicate our chunk mapping is incorrect too.

Would you please try the following diff on the 32bit system and report
back the dmesg?

The diff adds the following debug output:
- when we try to read one tree block
- when a bio is mapped to read device
- when a new chunk is added to chunk tree

Thanks,
Qu

--------------94C901CDC2AD527EDD671115
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2V4dGVudF9pby5jIGIvZnMvYnRyZnMvZXh0ZW50X2lv
LmMKaW5kZXggN2Y2ODlhZDc3MDljLi5hOTczOTlmNWFjNmIgMTAwNjQ0Ci0tLSBhL2ZzL2J0
cmZzL2V4dGVudF9pby5jCisrKyBiL2ZzL2J0cmZzL2V4dGVudF9pby5jCkBAIC01NTczLDYg
KzU1NzMsOCBAQCBpbnQgcmVhZF9leHRlbnRfYnVmZmVyX3BhZ2VzKHN0cnVjdCBleHRlbnRf
YnVmZmVyICplYiwgaW50IHdhaXQsIGludCBtaXJyb3JfbnVtKQogCWlmICh0ZXN0X2JpdChF
WFRFTlRfQlVGRkVSX1VQVE9EQVRFLCAmZWItPmJmbGFncykpCiAJCXJldHVybiAwOwogCisJ
cHJfaW5mbygiJXM6IGViLT5zdGFydD0lbGx1IG1pcnJvcj0lZFxuIiwgX19mdW5jX18sIGVi
LT5zdGFydCwKKwkJCW1pcnJvcl9udW0pOwogCW51bV9wYWdlcyA9IG51bV9leHRlbnRfcGFn
ZXMoZWIpOwogCWZvciAoaSA9IDA7IGkgPCBudW1fcGFnZXM7IGkrKykgewogCQlwYWdlID0g
ZWItPnBhZ2VzW2ldOwpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdm9sdW1lcy5jIGIvZnMvYnRy
ZnMvdm9sdW1lcy5jCmluZGV4IGJhZGI5NzI5MTllYi4uMDNkZDQzMmI5ODEyIDEwMDY0NAot
LS0gYS9mcy9idHJmcy92b2x1bWVzLmMKKysrIGIvZnMvYnRyZnMvdm9sdW1lcy5jCkBAIC02
Mzc0LDYgKzYzNzQsMTEgQEAgc3RhdGljIHZvaWQgc3VibWl0X3N0cmlwZV9iaW8oc3RydWN0
IGJ0cmZzX2JpbyAqYmJpbywgc3RydWN0IGJpbyAqYmlvLAogCWJ0cmZzX2lvX2JpbyhiaW8p
LT5kZXZpY2UgPSBkZXY7CiAJYmlvLT5iaV9lbmRfaW8gPSBidHJmc19lbmRfYmlvOwogCWJp
by0+YmlfaXRlci5iaV9zZWN0b3IgPSBwaHlzaWNhbCA+PiA5OworCisJcHJfaW5mbygiJXM6
IHJ3ICVkIDB4JXgsIHBoeT0lbGx1IHNlY3Rvcj0lbGx1IGRldl9pZD0lbGx1IHNpemU9JXVc
biIsIF9fZnVuY19fLAorCQliaW9fb3AoYmlvKSwgYmlvLT5iaV9vcGYsICgodTY0KWJpby0+
YmlfaXRlci5iaV9zZWN0b3IpIDw8IDksCisJCWJpby0+YmlfaXRlci5iaV9zZWN0b3IsCisJ
CWRldi0+ZGV2aWQsIGJpby0+YmlfaXRlci5iaV9zaXplKTsKIAlidHJmc19kZWJ1Z19pbl9y
Y3UoZnNfaW5mbywKIAkiYnRyZnNfbWFwX2JpbzogcncgJWQgMHgleCwgc2VjdG9yPSVsbHUs
IGRldj0lbHUgKCVzIGlkICVsbHUpLCBzaXplPSV1IiwKIAkJYmlvX29wKGJpbyksIGJpby0+
Ymlfb3BmLCBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yLApAQCAtNjY3MCw2ICs2Njc1LDggQEAg
c3RhdGljIGludCByZWFkX29uZV9jaHVuayhzdHJ1Y3QgYnRyZnNfa2V5ICprZXksIHN0cnVj
dCBleHRlbnRfYnVmZmVyICpsZWFmLAogCQlyZXR1cm4gLUVOT01FTTsKIAl9CiAKKwlwcl9p
bmZvKCIlczogY2h1bmsgc3RhcnQ9JWxsdSBsZW49JWxsdSBudW1fc3RyaXBlcz0lZCB0eXBl
PTB4JWxseFxuIiwgX19mdW5jX18sCisJCWxvZ2ljYWwsIGxlbmd0aCwgbnVtX3N0cmlwZXMs
IGJ0cmZzX2NodW5rX3R5cGUobGVhZiwgY2h1bmspKTsKIAlzZXRfYml0KEVYVEVOVF9GTEFH
X0ZTX01BUFBJTkcsICZlbS0+ZmxhZ3MpOwogCWVtLT5tYXBfbG9va3VwID0gbWFwOwogCWVt
LT5zdGFydCA9IGxvZ2ljYWw7CkBAIC02Njk0LDYgKzY3MDEsOSBAQCBzdGF0aWMgaW50IHJl
YWRfb25lX2NodW5rKHN0cnVjdCBidHJmc19rZXkgKmtleSwgc3RydWN0IGV4dGVudF9idWZm
ZXIgKmxlYWYsCiAJCXJlYWRfZXh0ZW50X2J1ZmZlcihsZWFmLCB1dWlkLCAodW5zaWduZWQg
bG9uZykKIAkJCQkgICBidHJmc19zdHJpcGVfZGV2X3V1aWRfbnIoY2h1bmssIGkpLAogCQkJ
CSAgIEJUUkZTX1VVSURfU0laRSk7CisJCXByX2luZm8oIiVzOiAgICBzdHJpcGUgJXUgcGh5
PSVsbHUgZGV2aWQ9JWxsdVxuIiwgX19mdW5jX18sCisJCQlpLCBidHJmc19zdHJpcGVfb2Zm
c2V0X25yKGxlYWYsIGNodW5rLCBpKSwKKwkJCWRldmlkKTsKIAkJbWFwLT5zdHJpcGVzW2ld
LmRldiA9IGJ0cmZzX2ZpbmRfZGV2aWNlKGZzX2luZm8tPmZzX2RldmljZXMsCiAJCQkJCQkJ
ZGV2aWQsIHV1aWQsIE5VTEwpOwogCQlpZiAoIW1hcC0+c3RyaXBlc1tpXS5kZXYgJiYK
--------------94C901CDC2AD527EDD671115--
