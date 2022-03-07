Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807FB4CF299
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiCGHcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiCGHcR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:32:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC562559E
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646638281;
        bh=m2ODlMzekvd5wfCfLUiNc6qhck7QAtVz4I+EH0QZb9U=;
        h=X-UI-Sender-Class:Date:From:To:Cc:References:Subject:In-Reply-To;
        b=SM3CyALVmkTOh8RZErDgFKdq+0YCkvPqfG3hgD4LycvC1teRNYeJpnHR2j5iqEozu
         n3wAYAwpOaGz58XFFBBPfdNYsyKUKj9/XcP0U299wx2WlPqf0i7SIFFpiYr4Porzjx
         tEULyxyhHxGfZYo30N6R3x4WsevDlIBWset6Y0Lc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXtS-1nZxWa0x60-00QTbg; Mon, 07
 Mar 2022 08:31:21 +0100
Content-Type: multipart/mixed; boundary="------------3WGve1r8U6j0HPbQ5yfr0P04"
Message-ID: <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
Date:   Mon, 7 Mar 2022 15:31:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
In-Reply-To: <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
X-Provags-ID: V03:K1:E4Tb7Dwm6CNAYdXR2QJP2U4yTLXu11gkjHeA6b08nVZFMmgosqj
 DLcZqC7lsY1YAwsjlStZFiFblrMZdx8vN4fkHFIvC7UAXr9uMkc9sxHdFQUMd6jdwGf5kje
 NhRGSaT86gI1/4HIz9otBerd/Q/gBGq9BgfZv6kNaBYCoNuXA28khCL9AkX+Rmw8yIeWJoZ
 oH57/K2wC6oAlmFmArXpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kNythEVZm8k=:7PLrWk8WPl77bXayFIitOG
 YDP/bNaLAeoj6nQC/SwcTVTwFeGqy1i0V33Ube8nokqG5SmTfmv5YRb/OcjaJ+melq7bjjdJe
 L196Jp4kMZaeu7odFjmXlHzVyKLByt+SKg70Vn4z9cz71wRkVBin6MnDG3hlMBQ9sdx6g14uD
 S/RxuKbTz2sHyNifpfUXE846+34QIkmv7o/0AJBAZtOB3xPNDINXxNNMDUmDub5aVMxM7SFDW
 3upEJWskk60FUQIhGz7cBiqvDPZIDWAJPiw7Vrb+pt64XrDs6gHiUq/EqXuuPFEhqmFykksDT
 Ajl6DNc8nG3+1nXCYv0IY0u/5wyjzNcVaB2dl/ljtb0yXj1vWkWKEnLqGZ3LlAlG5eDLTljb5
 N0zpMs34/XP3JUbC1s+IVcQxhx7Bk7YLcuaHUPi7kiC8vekaeOYx1+kZUve/RGAMu+8sGdXYO
 YALRHChPaJN3iar8uZWtNyHVnO3V9qMmqWksBmdD0SetBlhn4CSe2gnQ1HwGSxU1JKgyWJbfu
 A3U4iR/3OloSxnOfsI3h1yxYiF1pYqD68VU0nHoGUjTdBmjZ+Dt4p7iyc70IhBbkB+TG9hqzZ
 StI3nRKm7O7miYJSDfOXlvCHVkp+xw4eQmLCesn38dGkbCkBTCZgL3rOf2jYq3k7GqOl0dzO3
 pMRYn+SZWK6V2Am4bY/LQjEYS2tsna69rVDE7QMjfFpM3jumriJb9JbTThemZbjF58Otk0IC9
 p6zC8+QXLmeU85JK/C1l7ZTq00Dht/gJ7VyfTQBgHB/GizWqgthQt+ynG8bSUG6+kKWfIL5s1
 1lI5IaIN8+eXfZ0R5dZfHjrscG28ZPkW97B+nBL/dPQOcp8twRCtr7TwYCLKt4OoLZfLXVpBS
 waE5uPOl35ONZHcuD/GmX7cxQ31J6kDgGPEVN26NmfskgUZFA3RdnzFL4YH5I2gXm8TRydSwE
 4ePEA1szbj3hjIl7h55NjTauG0sk4Y5+dLkd9pdkeUEBurKs7454dHUTkqLlwa/2Rq8m4xU2e
 bXteBgMODlfUwuEeGzat4JNOgCLYZj3NtlACtGAh/+83XJDZ0RoJdLgQk0X7wZisXzbbajA+5
 G8S/tygMPriwk4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------3WGve1r8U6j0HPbQ5yfr0P04
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2022/3/7 10:39, Qu Wenruo wrote:
>
>
> On 2022/3/7 10:23, Jan Ziak wrote:
>> On Mon, Mar 7, 2022 at 1:48 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>> On 2022/3/6 23:59, Jan Ziak wrote:
>>>> I would like to report that btrfs in Linux kernel 5.16.12 mounted wit=
h
>>>> the autodefrag option wrote 5TB in a single day to a 1TB SSD that is
>>>> about 50% full.
>>>>
>>>> Defragmenting 0.5TB on a drive that is 50% full should write far
>>>> less than 5TB.
>>>
>>> If using defrag ioctl, that's a good and solid expectation.
>>>
>>> Autodefrag will mark any file which got smaller writes (<64K) for scan=
.
>>> For smaller extents than 64K, they will be re-dirtied for writeback.
>>
>> The NVMe device has 512-byte sectors, but has another namespace with
>> 4K sectors. Will it help btrfs-autodefrag to reformat the drive to 4K
>> sectors? I expect that it won't help - I am asking just in case my
>> expectation is wrong.
>
> The minimal sector size of btrfs is 4K, so I don't believe it would
> cause any difference.
>
>>
>>> So in theory, if the cleaner is triggered very frequently to do
>>> autodefrag, it can indeed easily amplify the writes.
>>
>> According to usr/bin/glances, the sqlite app is writing less than 1 MB
>> per second to the NVMe device. btrfs's autodefrag write amplification
>> is from the 1 MB/s to approximately 200 MB/s.
>
> This is definitely something wrong.
>
> Autodefrag by default should only get triggered every 300s, thus even
> all new bytes are re-dirtied, it should only cause a less than 300M
> write burst every 300s, not a consistent write.
>
>>
>>> Are you using commit=3D mount option? Which would reduce the commit
>>> interval thus trigger autodefrag more frequently.
>>
>> I am not using commit=3D mount option.
>>
>>>> CPU utilization on an otherwise idle machine is approximately 600% al=
l
>>>> the time: btrfs-cleaner 100%, kworkers...btrfs 500%.
>>>
>>> The problem is why the CPU usage is at 100% for cleaner.
>>>
>>> Would you please apply this patch on your kernel?
>>> https://patchwork.kernel.org/project/linux-btrfs/patch/bf2635d213e0c85=
251c4cd0391d8fbf274d7d637.1645705266.git.wqu@suse.com/
>>>
>>>
>>> Then enable the following trace events...
>>
>> I will try to apply the patch, collect the events and post the
>> results. First, I will wait for the sqlite file to gain about 1
>> million extents, which shouldn't take too long.
>
> Thank you very much for the future trace events log.
>
> That would be the determining data for us to solve it.

Forgot to mention that, that patch itself relies on refactors in the
previous patches.

Thus you may want to apply the whole patchset.

Or use the attached diff which I manually backported for v5.16.12.

Thanks,
Qu
>
>>
>> ----
>>
>> BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
>> (uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
>> file-with-million-extents" doesn't finish even after several minutes
>> of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
>> ioctl syscalls per second - and appears to be slowing down as the
>> value of the "fm_start" ioctl argument grows; e2fsprogs version
>> 1.46.5). It would be nice if filefrag was faster than just a few
>> ioctls per second.
>
> This is mostly a race with autodefrag.
>
> Both are using file extent map, thus if autodefrag is still trying to
> redirty the file again and again, it would definitely cause problems for
> anything also using file extent map.
>
> Thanks,
> Qu
>>
>> ----
>>
>> Sincerely
>> Jan

--------------3WGve1r8U6j0HPbQ5yfr0P04
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-trace-events-for-defrag.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-trace-events-for-defrag.patch"
Content-Transfer-Encoding: base64

RnJvbSA3NTdiZjBhYTM5YzQ0ZmM3YzNlOGU1N2YxYzc4NWFiNmM3Y2ZmYThhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NzU3YmYwYWEzOWM0NGZjN2MzZThlNTdm
MWM3ODVhYjZjN2NmZmE4YS4xNjQ2NjM4MjU3LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBTdW4sIDEzIEZlYiAyMDIyIDE0OjE5OjIw
ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IGFkZCB0cmFjZSBldmVudHMgZm9yIGRl
ZnJhZwoKVGhpcyBpcyB0aGUgYmFja3BvcnQgZm9yIHY1LjE2LjEyLCB3aXRob3V0IHRoZSBk
ZXBlbmRlbmN5IG9uIHRoZQpidHJmc19kZWZyYWdfY3RybCByZWZhY3Rvci4KClRoaXMgcGF0
Y2ggd2lsbCBpbnRyb2R1Y2UgdGhlIGZvbGxvd2luZyB0cmFjZSBldmVudHM6CgotIHRyYWNl
X2RlZnJhZ19hZGRfdGFyZ2V0KCkKLSB0cmFjZV9kZWZyYWdfb25lX2xvY2tlZF9yYW5nZSgp
Ci0gdHJhY2VfZGVmcmFnX2ZpbGVfc3RhcnQoKQotIHRyYWNlX2RlZnJhZ19maWxlX2VuZCgp
CgpVbmRlciBtb3N0IGNhc2VzLCBhbGwgb2YgdGhlbSBhcmUgbmVlZGVkIHRvIGRlYnVnIHBv
bGljeSByZWxhdGVkIGRlZnJhZwpidWdzLgoKVGhlIGV4YW1wbGUgb3V0cHV0IHdvdWxkIGxv
b2sgbGlrZSB0aGlzOiAod2l0aCBUQVNLLCBDUFUsIFRJTUVTVEFNUCBhbmQKVVVJRCBza2lw
cGVkKQoKIGRlZnJhZ19maWxlX3N0YXJ0OiA8VVVJRD46IHJvb3Q9NSBpbm89MjU3IHN0YXJ0
PTAgbGVuPTEzMTA3MiBleHRlbnRfdGhyZXNoPTI2MjE0NCBuZXdlcl90aGFuPTcgZmxhZ3M9
MHgwIGNvbXByZXNzPTAgbWF4X3NlY3RvcnNfdG9fZGVmcmFnPTEwMjQKIGRlZnJhZ19hZGRf
dGFyZ2V0OiA8VVVJRD46IHJvb3Q9NSBpbm89MjU3IHRhcmdldF9zdGFydD0wIHRhcmdldF9s
ZW49NDA5NiBmb3VuZCBlbT0wIGxlbj00MDk2IGdlbmVyYXRpb249NwogZGVmcmFnX2FkZF90
YXJnZXQ6IDxVVUlEPjogcm9vdD01IGlubz0yNTcgdGFyZ2V0X3N0YXJ0PTQwOTYgdGFyZ2V0
X2xlbj00MDk2IGZvdW5kIGVtPTQwOTYgbGVuPTQwOTYgZ2VuZXJhdGlvbj03Ci4uLgogZGVm
cmFnX2FkZF90YXJnZXQ6IDxVVUlEPjogcm9vdD01IGlubz0yNTcgdGFyZ2V0X3N0YXJ0PTU3
MzQ0IHRhcmdldF9sZW49NDA5NiBmb3VuZCBlbT01NzM0NCBsZW49NDA5NiBnZW5lcmF0aW9u
PTcKIGRlZnJhZ19hZGRfdGFyZ2V0OiA8VVVJRD46IHJvb3Q9NSBpbm89MjU3IHRhcmdldF9z
dGFydD02MTQ0MCB0YXJnZXRfbGVuPTQwOTYgZm91bmQgZW09NjE0NDAgbGVuPTQwOTYgZ2Vu
ZXJhdGlvbj03CiBkZWZyYWdfYWRkX3RhcmdldDogPFVVSUQ+OiByb290PTUgaW5vPTI1NyB0
YXJnZXRfc3RhcnQ9MCB0YXJnZXRfbGVuPTQwOTYgZm91bmQgZW09MCBsZW49NDA5NiBnZW5l
cmF0aW9uPTcKIGRlZnJhZ19hZGRfdGFyZ2V0OiA8VVVJRD46IHJvb3Q9NSBpbm89MjU3IHRh
cmdldF9zdGFydD00MDk2IHRhcmdldF9sZW49NDA5NiBmb3VuZCBlbT00MDk2IGxlbj00MDk2
IGdlbmVyYXRpb249NwouLi4KIGRlZnJhZ19hZGRfdGFyZ2V0OiA8VVVJRD46IHJvb3Q9NSBp
bm89MjU3IHRhcmdldF9zdGFydD01NzM0NCB0YXJnZXRfbGVuPTQwOTYgZm91bmQgZW09NTcz
NDQgbGVuPTQwOTYgZ2VuZXJhdGlvbj03CiBkZWZyYWdfYWRkX3RhcmdldDogPFVVSUQ+OiBy
b290PTUgaW5vPTI1NyB0YXJnZXRfc3RhcnQ9NjE0NDAgdGFyZ2V0X2xlbj00MDk2IGZvdW5k
IGVtPTYxNDQwIGxlbj00MDk2IGdlbmVyYXRpb249NwogZGVmcmFnX29uZV9sb2NrZWRfcmFu
Z2U6IDxVVUlEPjogcm9vdD01IGlubz0yNTcgc3RhcnQ9MCBsZW49NjU1MzYKIGRlZnJhZ19m
aWxlX2VuZDogPFVVSUQ+OiByb290PTUgaW5vPTI1NyBzZWN0b3JzX2RlZnJhZ2dlZD0xNiBs
YXN0X3NjYW5uZWQ9MTMxMDcyIHJldD0wCgpBbHRob3VnaCB0aGUgZGVmcmFnX2FkZF90YXJn
ZXQoKSBwYXJ0IGlzIGxlbmd0aHksIGl0IHNob3dzIHNvbWUgZGV0YWlscwpvZiB0aGUgZXh0
ZW50IG1hcCB3ZSBnZXQuCldpdGggdGhlIGV4dHJhIGluZm8gZnJvbSBkZWZyYWdfZmlsZV9z
dGFydCgpLCB3ZSBjYW4gY2hlY2sgaWYgdGhlIHRhcmdldAplbSBpcyBjb3JyZWN0IGZvciBv
dXIgZGVmcmFnIHBvbGljeS4KClNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2Uu
Y29tPgotLS0KIGZzL2J0cmZzL2lvY3RsLmMgICAgICAgICAgICAgfCAgIDYgKysKIGluY2x1
ZGUvdHJhY2UvZXZlbnRzL2J0cmZzLmggfCAxMjggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTM0IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9mcy9idHJmcy9pb2N0bC5jIGIvZnMvYnRyZnMvaW9jdGwuYwppbmRleCA1NDFh
NGZiZmQ3OWUuLjYyMmQxMGFjM2U5NyAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvaW9jdGwuYwor
KysgYi9mcy9idHJmcy9pb2N0bC5jCkBAIC0xMjcyLDYgKzEyNzIsNyBAQCBzdGF0aWMgaW50
IGRlZnJhZ19jb2xsZWN0X3RhcmdldHMoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwKIGFk
ZDoKIAkJbGFzdF9pc190YXJnZXQgPSB0cnVlOwogCQlyYW5nZV9sZW4gPSBtaW4oZXh0ZW50
X21hcF9lbmQoZW0pLCBzdGFydCArIGxlbikgLSBjdXI7CisJCXRyYWNlX2RlZnJhZ19hZGRf
dGFyZ2V0KGlub2RlLCBlbSwgY3VyLCByYW5nZV9sZW4pOwogCQkvKgogCQkgKiBUaGlzIG9u
ZSBpcyBhIGdvb2QgdGFyZ2V0LCBjaGVjayBpZiBpdCBjYW4gYmUgbWVyZ2VkIGludG8KIAkJ
ICogbGFzdCByYW5nZSBvZiB0aGUgdGFyZ2V0IGxpc3QuCkBAIC0xMzY2LDYgKzEzNjcsNyBA
QCBzdGF0aWMgaW50IGRlZnJhZ19vbmVfbG9ja2VkX3RhcmdldChzdHJ1Y3QgYnRyZnNfaW5v
ZGUgKmlub2RlLAogCXJldCA9IGJ0cmZzX2RlbGFsbG9jX3Jlc2VydmVfc3BhY2UoaW5vZGUs
ICZkYXRhX3Jlc2VydmVkLCBzdGFydCwgbGVuKTsKIAlpZiAocmV0IDwgMCkKIAkJcmV0dXJu
IHJldDsKKwl0cmFjZV9kZWZyYWdfb25lX2xvY2tlZF9yYW5nZShpbm9kZSwgc3RhcnQsICh1
MzIpbGVuKTsKIAljbGVhcl9leHRlbnRfYml0KCZpbm9kZS0+aW9fdHJlZSwgc3RhcnQsIHN0
YXJ0ICsgbGVuIC0gMSwKIAkJCSBFWFRFTlRfREVMQUxMT0MgfCBFWFRFTlRfRE9fQUNDT1VO
VElORyB8CiAJCQkgRVhURU5UX0RFRlJBRywgMCwgMCwgY2FjaGVkX3N0YXRlKTsKQEAgLTE1
OTEsNiArMTU5Myw5IEBAIGludCBidHJmc19kZWZyYWdfZmlsZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZmlsZV9yYV9zdGF0ZSAqcmEsCiAJLyogQWxpZ24gdGhlIHJhbmdlICov
CiAJY3VyID0gcm91bmRfZG93bihyYW5nZS0+c3RhcnQsIGZzX2luZm8tPnNlY3RvcnNpemUp
OwogCWxhc3RfYnl0ZSA9IHJvdW5kX3VwKGxhc3RfYnl0ZSwgZnNfaW5mby0+c2VjdG9yc2l6
ZSkgLSAxOworCXRyYWNlX2RlZnJhZ19maWxlX3N0YXJ0KEJUUkZTX0koaW5vZGUpLCBjdXIs
IGxhc3RfYnl0ZSArIDEgLSBjdXIsCisJCQkJZXh0ZW50X3RocmVzaCwgbmV3ZXJfdGhhbiwg
bWF4X3RvX2RlZnJhZywKKwkJCQlyYW5nZS0+ZmxhZ3MsIHJhbmdlLT5jb21wcmVzc190eXBl
KTsKIAogCS8qCiAJICogSWYgd2Ugd2VyZSBub3QgZ2l2ZW4gYSByYSwgYWxsb2NhdGUgYSBy
ZWFkYWhlYWQgY29udGV4dC4gQXMKQEAgLTE2OTAsNiArMTY5NSw3IEBAIGludCBidHJmc19k
ZWZyYWdfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZV9yYV9zdGF0ZSAq
cmEsCiAJCUJUUkZTX0koaW5vZGUpLT5kZWZyYWdfY29tcHJlc3MgPSBCVFJGU19DT01QUkVT
U19OT05FOwogCQlidHJmc19pbm9kZV91bmxvY2soaW5vZGUsIDApOwogCX0KKwl0cmFjZV9k
ZWZyYWdfZmlsZV9lbmQoQlRSRlNfSShpbm9kZSksIHJldCwgc2VjdG9yc19kZWZyYWdnZWQs
IGN1cik7CiAJcmV0dXJuIHJldDsKIH0KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9l
dmVudHMvYnRyZnMuaCBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL2J0cmZzLmgKaW5kZXggOGY1
OGZkOTVlZmM3Li45OGViOGY0YTA0YzYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdHJhY2UvZXZl
bnRzL2J0cmZzLmgKKysrIGIvaW5jbHVkZS90cmFjZS9ldmVudHMvYnRyZnMuaApAQCAtMjI2
Myw2ICsyMjYzLDEzNCBAQCBERUZJTkVfRVZFTlQoYnRyZnNfX3NwYWNlX2luZm9fdXBkYXRl
LCB1cGRhdGVfYnl0ZXNfcGlubmVkLAogCVRQX0FSR1MoZnNfaW5mbywgc2luZm8sIG9sZCwg
ZGlmZikKICk7CiAKK1RSQUNFX0VWRU5UKGRlZnJhZ19vbmVfbG9ja2VkX3JhbmdlLAorCisJ
VFBfUFJPVE8oY29uc3Qgc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwgdTY0IHN0YXJ0LCB1
MzIgbGVuKSwKKworCVRQX0FSR1MoaW5vZGUsIHN0YXJ0LCBsZW4pLAorCisJVFBfU1RSVUNU
X19lbnRyeV9idHJmcygKKwkJX19maWVsZCgJdTY0LAlyb290CQkpCisJCV9fZmllbGQoCXU2
NCwJaW5vCQkpCisJCV9fZmllbGQoCXU2NCwJc3RhcnQJCSkKKwkJX19maWVsZCgJdTMyLAls
ZW4JCSkKKwkpLAorCisJVFBfZmFzdF9hc3NpZ25fYnRyZnMoaW5vZGUtPnJvb3QtPmZzX2lu
Zm8sCisJCV9fZW50cnktPnJvb3QJPSBpbm9kZS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQ7
CisJCV9fZW50cnktPmlubwk9IGJ0cmZzX2lubyhpbm9kZSk7CisJCV9fZW50cnktPnN0YXJ0
CT0gc3RhcnQ7CisJCV9fZW50cnktPmxlbgk9IGxlbjsKKwkpLAorCisJVFBfcHJpbnRrX2J0
cmZzKCJyb290PSVsbHUgaW5vPSVsbHUgc3RhcnQ9JWxsdSBsZW49JXUiLAorCQlfX2VudHJ5
LT5yb290LCBfX2VudHJ5LT5pbm8sIF9fZW50cnktPnN0YXJ0LCBfX2VudHJ5LT5sZW4pCisp
OworCitUUkFDRV9FVkVOVChkZWZyYWdfYWRkX3RhcmdldCwKKworCVRQX1BST1RPKGNvbnN0
IHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsIGNvbnN0IHN0cnVjdCBleHRlbnRfbWFwICpl
bSwKKwkJIHU2NCBzdGFydCwgdTMyIGxlbiksCisKKwlUUF9BUkdTKGlub2RlLCBlbSwgc3Rh
cnQsIGxlbiksCisKKwlUUF9TVFJVQ1RfX2VudHJ5X2J0cmZzKAorCQlfX2ZpZWxkKAl1NjQs
CXJvb3QJCSkKKwkJX19maWVsZCgJdTY0LAlpbm8JCSkKKwkJX19maWVsZCgJdTY0LAl0YXJn
ZXRfc3RhcnQJKQorCQlfX2ZpZWxkKAl1MzIsCXRhcmdldF9sZW4JKQorCQlfX2ZpZWxkKAl1
NjQsCWVtX2dlbmVyYXRpb24JKQorCQlfX2ZpZWxkKAl1NjQsCWVtX3N0YXJ0CSkKKwkJX19m
aWVsZCgJdTY0LAllbV9sZW4JCSkKKwkpLAorCisJVFBfZmFzdF9hc3NpZ25fYnRyZnMoaW5v
ZGUtPnJvb3QtPmZzX2luZm8sCisJCV9fZW50cnktPnJvb3QJCT0gaW5vZGUtPnJvb3QtPnJv
b3Rfa2V5Lm9iamVjdGlkOworCQlfX2VudHJ5LT5pbm8JCT0gYnRyZnNfaW5vKGlub2RlKTsK
KwkJX19lbnRyeS0+dGFyZ2V0X3N0YXJ0CT0gc3RhcnQ7CisJCV9fZW50cnktPnRhcmdldF9s
ZW4JPSBsZW47CisJCV9fZW50cnktPmVtX2dlbmVyYXRpb24JPSBlbS0+Z2VuZXJhdGlvbjsK
KwkJX19lbnRyeS0+ZW1fc3RhcnQJPSBlbS0+c3RhcnQ7CisJCV9fZW50cnktPmVtX2xlbgkJ
PSBlbS0+bGVuOworCSksCisKKwlUUF9wcmludGtfYnRyZnMoInJvb3Q9JWxsdSBpbm89JWxs
dSB0YXJnZXRfc3RhcnQ9JWxsdSB0YXJnZXRfbGVuPSV1ICIKKwkJImZvdW5kIGVtPSVsbHUg
bGVuPSVsbHUgZ2VuZXJhdGlvbj0lbGx1IiwKKwkJX19lbnRyeS0+cm9vdCwgX19lbnRyeS0+
aW5vLCBfX2VudHJ5LT50YXJnZXRfc3RhcnQsCisJCV9fZW50cnktPnRhcmdldF9sZW4sIF9f
ZW50cnktPmVtX3N0YXJ0LCBfX2VudHJ5LT5lbV9sZW4sCisJCV9fZW50cnktPmVtX2dlbmVy
YXRpb24pCispOworCitUUkFDRV9FVkVOVChkZWZyYWdfZmlsZV9zdGFydCwKKworCVRQX1BS
T1RPKGNvbnN0IHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsCisJCSB1NjQgc3RhcnQsIHU2
NCBsZW4sIHUzMiBleHRlbnRfdGhyZXNoLCB1NjQgbmV3ZXJfdGhhbiwKKwkJIHVuc2lnbmVk
IGxvbmcgbWF4X3NlY3RvcnNfdG9fZGVmcmFnLCB1NjQgZmxhZ3MsIHUzMiBjb21wcmVzcyks
CisKKwlUUF9BUkdTKGlub2RlLCBzdGFydCwgbGVuLCBleHRlbnRfdGhyZXNoLCBuZXdlcl90
aGFuLAorCQltYXhfc2VjdG9yc190b19kZWZyYWcsIGZsYWdzLCBjb21wcmVzcyksCisKKwlU
UF9TVFJVQ1RfX2VudHJ5X2J0cmZzKAorCQlfX2ZpZWxkKAl1NjQsCXJvb3QJCQkpCisJCV9f
ZmllbGQoCXU2NCwJaW5vCQkJKQorCQlfX2ZpZWxkKAl1NjQsCXN0YXJ0CQkJKQorCQlfX2Zp
ZWxkKAl1NjQsCWxlbgkJCSkKKwkJX19maWVsZCgJdTY0LAluZXdlcl90aGFuCQkpCisJCV9f
ZmllbGQoCXU2NCwJbWF4X3NlY3RvcnNfdG9fZGVmcmFnCSkKKwkJX19maWVsZCgJdTMyLAll
eHRlbnRfdGhyZXNoCQkpCisJCV9fZmllbGQoCXU4LAlmbGFncwkJCSkKKwkJX19maWVsZCgJ
dTgsCWNvbXByZXNzCQkpCisJKSwKKworCVRQX2Zhc3RfYXNzaWduX2J0cmZzKGlub2RlLT5y
b290LT5mc19pbmZvLAorCQlfX2VudHJ5LT5yb290CQk9IGlub2RlLT5yb290LT5yb290X2tl
eS5vYmplY3RpZDsKKwkJX19lbnRyeS0+aW5vCQk9IGJ0cmZzX2lubyhpbm9kZSk7CisJCV9f
ZW50cnktPnN0YXJ0CQk9IHN0YXJ0OworCQlfX2VudHJ5LT5sZW4JCT0gbGVuOworCQlfX2Vu
dHJ5LT5leHRlbnRfdGhyZXNoCT0gZXh0ZW50X3RocmVzaDsKKwkJX19lbnRyeS0+bmV3ZXJf
dGhhbgk9IG5ld2VyX3RoYW47CisJCV9fZW50cnktPm1heF9zZWN0b3JzX3RvX2RlZnJhZyA9
IG1heF9zZWN0b3JzX3RvX2RlZnJhZzsKKwkJX19lbnRyeS0+ZmxhZ3MJCT0gZmxhZ3M7CisJ
CV9fZW50cnktPmNvbXByZXNzCT0gY29tcHJlc3M7CisJKSwKKworCVRQX3ByaW50a19idHJm
cygicm9vdD0lbGx1IGlubz0lbGx1IHN0YXJ0PSVsbHUgbGVuPSVsbHUgIgorCQkiZXh0ZW50
X3RocmVzaD0ldSBuZXdlcl90aGFuPSVsbHUgZmxhZ3M9MHgleCBjb21wcmVzcz0ldSAiCisJ
CSJtYXhfc2VjdG9yc190b19kZWZyYWc9JWxsdSIsCisJCV9fZW50cnktPnJvb3QsIF9fZW50
cnktPmlubywgX19lbnRyeS0+c3RhcnQsIF9fZW50cnktPmxlbiwKKwkJX19lbnRyeS0+ZXh0
ZW50X3RocmVzaCwgX19lbnRyeS0+bmV3ZXJfdGhhbiwgX19lbnRyeS0+ZmxhZ3MsCisJCV9f
ZW50cnktPmNvbXByZXNzLCBfX2VudHJ5LT5tYXhfc2VjdG9yc190b19kZWZyYWcpCispOwor
CitUUkFDRV9FVkVOVChkZWZyYWdfZmlsZV9lbmQsCisKKwlUUF9QUk9UTyhjb25zdCBzdHJ1
Y3QgYnRyZnNfaW5vZGUgKmlub2RlLAorCQkgaW50IHJldCwgdTY0IHNlY3RvcnNfZGVmcmFn
Z2VkLCB1NjQgbGFzdF9zY2FubmVkKSwKKworCVRQX0FSR1MoaW5vZGUsIHJldCwgc2VjdG9y
c19kZWZyYWdnZWQsIGxhc3Rfc2Nhbm5lZCksCisKKwlUUF9TVFJVQ1RfX2VudHJ5X2J0cmZz
KAorCQlfX2ZpZWxkKAl1NjQsCXJvb3QJCQkpCisJCV9fZmllbGQoCXU2NCwJaW5vCQkJKQor
CQlfX2ZpZWxkKAl1NjQsCXNlY3RvcnNfZGVmcmFnZ2VkCSkKKwkJX19maWVsZCgJdTY0LAls
YXN0X3NjYW5uZWQJCSkKKwkJX19maWVsZCgJaW50LAlyZXQJCQkpCisJKSwKKworCVRQX2Zh
c3RfYXNzaWduX2J0cmZzKGlub2RlLT5yb290LT5mc19pbmZvLAorCQlfX2VudHJ5LT5yb290
CQk9IGlub2RlLT5yb290LT5yb290X2tleS5vYmplY3RpZDsKKwkJX19lbnRyeS0+aW5vCQk9
IGJ0cmZzX2lubyhpbm9kZSk7CisJCV9fZW50cnktPnNlY3RvcnNfZGVmcmFnZ2VkID0gc2Vj
dG9yc19kZWZyYWdnZWQ7CisJCV9fZW50cnktPmxhc3Rfc2Nhbm5lZAk9IGxhc3Rfc2Nhbm5l
ZDsKKwkJX19lbnRyeS0+cmV0CQk9IHJldDsKKwkpLAorCisJVFBfcHJpbnRrX2J0cmZzKCJy
b290PSVsbHUgaW5vPSVsbHUgc2VjdG9yc19kZWZyYWdnZWQ9JWxsdSAiCisJCSJsYXN0X3Nj
YW5uZWQ9JWxsdSByZXQ9JWQiLAorCQlfX2VudHJ5LT5yb290LCBfX2VudHJ5LT5pbm8sIF9f
ZW50cnktPnNlY3RvcnNfZGVmcmFnZ2VkLAorCQlfX2VudHJ5LT5sYXN0X3NjYW5uZWQsIF9f
ZW50cnktPnJldCkKKyk7CisKICNlbmRpZiAvKiBfVFJBQ0VfQlRSRlNfSCAqLwogCiAvKiBU
aGlzIHBhcnQgbXVzdCBiZSBvdXRzaWRlIHByb3RlY3Rpb24gKi8KLS0gCjIuMzUuMQoK

--------------3WGve1r8U6j0HPbQ5yfr0P04--
