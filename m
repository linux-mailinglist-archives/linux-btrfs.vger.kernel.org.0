Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3843675E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhDUXo0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 19:44:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:49369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237429AbhDUXo0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 19:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619048627;
        bh=hsumzPPcOG6LJYze2kTKKFG5D5DhKA2Ao09K70HIIbA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=LK/c7EgYH5QnTOL6p3kuUbqfo+8Yl0XAVrbYAjF9hxA+moHBSfCN7/p6MNzTlq20f
         aX/M6TvY3swy4A42gY31l7z0qGB5MZuHHdZyISebVttojp/kUbctO6tu2u41SXldG6
         yeHyJMtiBS8RHUOT79iO9IuznuBxNBufCs1tA5Go=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtwZ4-1lKzQE0jCm-00uHFK; Thu, 22
 Apr 2021 01:43:46 +0200
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     fdmanana@gmail.com, Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210421201725.577C.409509F4@e16-tech.com>
 <CAL3q7H6V+x_Pu=bxTFGsuZLHf2mh_DOcthJx7HCSYCL79rjzxw@mail.gmail.com>
 <20210421235733.9C11.409509F4@e16-tech.com>
 <CAL3q7H7j7eZ0r1xYJiQGr3+yuwnqkpbRoA3HxY=e8Ut8VDRCRA@mail.gmail.com>
 <9b4400ca-d0a3-621d-591c-dc377d0bed58@gmx.com>
Message-ID: <e8886729-6f82-eca9-d752-0e81145794fe@gmx.com>
Date:   Thu, 22 Apr 2021 07:43:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <9b4400ca-d0a3-621d-591c-dc377d0bed58@gmx.com>
Content-Type: multipart/mixed;
 boundary="------------D7DA0EE84EB426FF0D8F4E6F"
Content-Language: en-US
X-Provags-ID: V03:K1:lhf3SJqm6Yd/lgSzkKTNQJGs6Nq9eprYRoEqVE/igVhNSXAzNk4
 1ELnULYKe33HLF0LZj44MLOqumkX3sFnyROsJFkPoLaUGBTigWvPFi5PUZpgrbfVxPEU1Ux
 pmhvadzNCqQWGiyZXHC/+GLhPPgx6NJNYV/ZU8uv4faXttFZVdn607pvxFpooMaEq2OrlMm
 YEzxFTo5w8gae+BhCv1pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ed6SeAfHbdo=:IwhAvqgcb+vLYf2hniaFiM
 C5dt1TkVZtxWujogk6iPjHkG+FtV+VS8SuqwFADIm/eAC6sNRaUPHZFT10Z2yoK0TsXJp2fYn
 Gyln2kJtoOXhVPceS1LEbNEAygHWnQ4+UwbkBiGd6ZmJjD/zNBokk2M3E+yIXRzgGtup0eDHS
 qneqzKPqNyC5F3k9gpdECqVzlrYgXm8zDvrZa1tOdyqE6+YdV5pyBc+SIHLxErbgkFN+gpMue
 QKVCJmztjFrr4v9gdJTai1O3gZKdtQks0m5xm++NFOgOZo8CLTlQrDXRWhi2xr8ZTtIY/+m0+
 eTlsnKIKQXLyFHvK+UT5k8glKwyRzpoV/UFX2KurkZfir0jWh7o0vZSmiPTea9O7kSnLEnX64
 D2arvMsRurvDjfB8F0v/DT+T2ftmlYdqT2FE0hBhWjfk0LHR+hUyZUZjXvB6g8lh6rmWMEno4
 CUPFTyU+o95+F/z68Y1Yy+yN7vVzAZjQXh554ILGLxkLttSFifRjaa8vQN2RKx0oPow1lW7Dx
 J2X2R6IH5YOjNcU6QzZcnEG3KsXT6P58CyjoFlAnvQkl7OoRYW6hZaHC8FmknPtgwvraTxOeX
 CsXb2VIDSxSg/V5+HkxOwzaE8jWCZ8vvQFYPIAz48fL1Xb9tEBcdo9QrfPT1K1BmjI1gY9YAo
 pxL87JnHFA3emlKhtkFtmsplNnieuhSjVxq9X4pwJqSJxlrweTyHUo7gkeU39SSaegig6cfu4
 V2gDpoIElf9L5IcvwS18IJhfn3SfYIomySFGt9PqVFgU+CchGsD11eTqvPkdUTJuoIsDnjN9Z
 nUNG5Rp38h7Po02bsM9DUuHi3njUPuh7pou2kugGikk7X2TeYl5e48uitCgtXFkB7UAX69ESQ
 4WeCKtmS1Q72QziQhz9fgu9E2+t6iBvI8u5bzJyUk9WKmrB80/BlyiSXZpk6Te996Qv3RufKf
 MWcI6/EnpaePDsYD7KeqTL1piYqcZcYuHduL8vWWsRYo3fL15Upm9K/DVxGI4PgRVDZaG86+5
 soMrVKKJlRz/SYhBZxVX5ESLOuJsAgUjAvzR/p7i/6ecJCJvK7xkFlPqyDOAO3Li3G07OjVmY
 2+Ki4ZE6p5iomJD7lOyfxbWq4i8N8LQuMngClhlUepRCnhKusRZb5TKhleaE6wRJAj9xYK4Td
 PZmSs9xMKJB6zB83+OjqhCpz+ixdCJDQKSwWAm6fWOi+I9Wfpp22mCuVodkSLNUjKsUpO03J0
 5Y/y9+YWeu8G4+ugN
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------D7DA0EE84EB426FF0D8F4E6F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/4/22 =E4=B8=8A=E5=8D=887:19, Qu Wenruo wrote:
>
>
> On 2021/4/22 =E4=B8=8A=E5=8D=8812:03, Filipe Manana wrote:
>> On Wed, Apr 21, 2021 at 4:57 PM Wang Yugui <wangyugui@e16-tech.com>
>> wrote:
>>>
>>> Hi,
>>>
>>>> That's the problem, qgroup flushing triggers writeback for an inode
>>>> for which we have a page dirtied and locked.
>>>> This should fix it:=C2=A0 https://pastebin.com/raw/U9GUZiEf
>>>>
>>>> Try it out and I'll write a changelog later.
>>>> Thanks.
>>>
>>> we run xfstest on two server with this patch.
>>> one passed the tests.
>>> but one got a btrfs/232 error.
>>>
>>> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on
>>> /dev/nvme0n1p1is inconsistent
>>> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
>>> ...
>>> [4/7] checking fs roots
>>> root 5 inode 337 errors 400, nbytes wrong
>>> ERROR: errors found in fs roots
>>
>> Ok, that's a different problem caused by something else.
>> It's possible to be due to the recent refactorings for preparation to
>> subpage block size.
>
> This error looks exactly what I have seen during subpage development.
> The subpage bug is caused by incorrect btrfs_invalidatepage() though,
> and not yet merged into misc-next anyway.
>
> I guess it's some error path not clearing extent states correctly, thus
> leaving the inode nbytes accounting wrong.
>
> BTW, the new @in_reclaim_context parameter for start_delalloc_inodes()
> is already in misc-next:
> commit 3d45f221ce627d13e2e6ef3274f06750c84a6542
> Author: Filipe Manana <fdmanana@suse.com>
> Date:=C2=A0=C2=A0 Wed Dec 2 11:55:58 2020 +0000
>
>  =C2=A0=C2=A0 btrfs: fix deadlock when cloning inline extent and low on =
free
> metadata space
>
> We only need to make btrfs_start_delalloc_snapshot() to accept the new
> parameter and pass in_reclaim_context =3D true for qgroup.

Strangely, on my subpage branch, with new @in_reclaim_context parameter
added to btrfs_start_delalloc_snapshot(), I can't reproduce the nbytes
mismatch error in 32 runs loop.
I guess one of the refactor around ordered extents and invalidatepage
may fix the problem by accident.

Mind to test my subpage branch
(https://github.com/adam900710/linux/tree/subpage) with the attached diff?

Thanks,
Qu
>
> Thanks,
> Qu
>>
>> Will try to look into that later.
>>
>> Thanks.
>>
>>> ...
>>>
>>> Best Regards
>>> Wang Yugui (wangyugui@e16-tech.com)
>>> 2021/04/21
>>>
>>
>>

--------------D7DA0EE84EB426FF0D8F4E6F
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2N0cmVlLmggYi9mcy9idHJmcy9jdHJlZS5oCmluZGV4
IDBhNjZiNTdmNDBmMS4uN2ZhNzQ3ZjgxZDVhIDEwMDY0NAotLS0gYS9mcy9idHJmcy9jdHJl
ZS5oCisrKyBiL2ZzL2J0cmZzL2N0cmVlLmgKQEAgLTMxMTUsNyArMzExNSw4IEBAIGludCBi
dHJmc190cnVuY2F0ZV9pbm9kZV9pdGVtcyhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0
cmFucywKIAkJCSAgICAgICBzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLCB1NjQgbmV3X3Np
emUsCiAJCQkgICAgICAgdTMyIG1pbl90eXBlKTsKIAotaW50IGJ0cmZzX3N0YXJ0X2RlbGFs
bG9jX3NuYXBzaG90KHN0cnVjdCBidHJmc19yb290ICpyb290KTsKK2ludCBidHJmc19zdGFy
dF9kZWxhbGxvY19zbmFwc2hvdChzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwKKwkJCQkgIGJv
b2wgaW5fcmVjbGFpbV9jb250ZXh0KTsKIGludCBidHJmc19zdGFydF9kZWxhbGxvY19yb290
cyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgbG9uZyBuciwKIAkJCSAgICAgICBi
b29sIGluX3JlY2xhaW1fY29udGV4dCk7CiBpbnQgYnRyZnNfc2V0X2V4dGVudF9kZWxhbGxv
YyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLCB1NjQgc3RhcnQsIHU2NCBlbmQsCmRpZmYg
LS1naXQgYS9mcy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYwppbmRleCA0MDE4
MjBjN2UzODEuLjkxYzExNjI4OTNmYiAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvaW5vZGUuYwor
KysgYi9mcy9idHJmcy9pbm9kZS5jCkBAIC05NzMwLDcgKzk3MzAsOCBAQCBzdGF0aWMgaW50
IHN0YXJ0X2RlbGFsbG9jX2lub2RlcyhzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwKIAlyZXR1
cm4gcmV0OwogfQogCi1pbnQgYnRyZnNfc3RhcnRfZGVsYWxsb2Nfc25hcHNob3Qoc3RydWN0
IGJ0cmZzX3Jvb3QgKnJvb3QpCitpbnQgYnRyZnNfc3RhcnRfZGVsYWxsb2Nfc25hcHNob3Qo
c3RydWN0IGJ0cmZzX3Jvb3QgKnJvb3QsCisJCQkJICBib29sIGluX3JlY2xhaW1fY29udGV4
dCkKIHsKIAlzdHJ1Y3Qgd3JpdGViYWNrX2NvbnRyb2wgd2JjID0gewogCQkubnJfdG9fd3Jp
dGUgPSBMT05HX01BWCwKQEAgLTk3NDMsNyArOTc0NCw3IEBAIGludCBidHJmc19zdGFydF9k
ZWxhbGxvY19zbmFwc2hvdChzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCkKIAlpZiAodGVzdF9i
aXQoQlRSRlNfRlNfU1RBVEVfRVJST1IsICZmc19pbmZvLT5mc19zdGF0ZSkpCiAJCXJldHVy
biAtRVJPRlM7CiAKLQlyZXR1cm4gc3RhcnRfZGVsYWxsb2NfaW5vZGVzKHJvb3QsICZ3YmMs
IHRydWUsIGZhbHNlKTsKKwlyZXR1cm4gc3RhcnRfZGVsYWxsb2NfaW5vZGVzKHJvb3QsICZ3
YmMsIHRydWUsIGluX3JlY2xhaW1fY29udGV4dCk7CiB9CiAKIGludCBidHJmc19zdGFydF9k
ZWxhbGxvY19yb290cyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgbG9uZyBuciwK
ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lvY3RsLmMgYi9mcy9idHJmcy9pb2N0bC5jCmluZGV4
IGJlMTc0ZGM5YmNkMC4uOWIyYjI2OGViMDg4IDEwMDY0NAotLS0gYS9mcy9idHJmcy9pb2N0
bC5jCisrKyBiL2ZzL2J0cmZzL2lvY3RsLmMKQEAgLTEwMzksNyArMTAzOSw3IEBAIHN0YXRp
YyBub2lubGluZSBpbnQgYnRyZnNfbWtzbmFwc2hvdChjb25zdCBzdHJ1Y3QgcGF0aCAqcGFy
ZW50LAogCSAqLwogCWJ0cmZzX2RyZXdfcmVhZF9sb2NrKCZyb290LT5zbmFwc2hvdF9sb2Nr
KTsKIAotCXJldCA9IGJ0cmZzX3N0YXJ0X2RlbGFsbG9jX3NuYXBzaG90KHJvb3QpOworCXJl
dCA9IGJ0cmZzX3N0YXJ0X2RlbGFsbG9jX3NuYXBzaG90KHJvb3QsIGZhbHNlKTsKIAlpZiAo
cmV0KQogCQlnb3RvIG91dDsKIApkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvcWdyb3VwLmMgYi9m
cy9idHJmcy9xZ3JvdXAuYwppbmRleCAyMzE5YzkyM2M5ZTYuLjM2NmE2YTI4OTc5NiAxMDA2
NDQKLS0tIGEvZnMvYnRyZnMvcWdyb3VwLmMKKysrIGIvZnMvYnRyZnMvcWdyb3VwLmMKQEAg
LTM1NjIsNyArMzU2Miw3IEBAIHN0YXRpYyBpbnQgdHJ5X2ZsdXNoX3Fncm91cChzdHJ1Y3Qg
YnRyZnNfcm9vdCAqcm9vdCkKIAkJcmV0dXJuIDA7CiAJfQogCi0JcmV0ID0gYnRyZnNfc3Rh
cnRfZGVsYWxsb2Nfc25hcHNob3Qocm9vdCk7CisJcmV0ID0gYnRyZnNfc3RhcnRfZGVsYWxs
b2Nfc25hcHNob3Qocm9vdCwgdHJ1ZSk7CiAJaWYgKHJldCA8IDApCiAJCWdvdG8gb3V0Owog
CWJ0cmZzX3dhaXRfb3JkZXJlZF9leHRlbnRzKHJvb3QsIFU2NF9NQVgsIDAsICh1NjQpLTEp
OwpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvc2VuZC5jIGIvZnMvYnRyZnMvc2VuZC5jCmluZGV4
IDU1NzQxYWRmOTA3MS4uYmQ2OWRiNzJhY2M1IDEwMDY0NAotLS0gYS9mcy9idHJmcy9zZW5k
LmMKKysrIGIvZnMvYnRyZnMvc2VuZC5jCkBAIC03MTcwLDcgKzcxNzAsNyBAQCBzdGF0aWMg
aW50IGZsdXNoX2RlbGFsbG9jX3Jvb3RzKHN0cnVjdCBzZW5kX2N0eCAqc2N0eCkKIAlpbnQg
aTsKIAogCWlmIChyb290KSB7Ci0JCXJldCA9IGJ0cmZzX3N0YXJ0X2RlbGFsbG9jX3NuYXBz
aG90KHJvb3QpOworCQlyZXQgPSBidHJmc19zdGFydF9kZWxhbGxvY19zbmFwc2hvdChyb290
LCBmYWxzZSk7CiAJCWlmIChyZXQpCiAJCQlyZXR1cm4gcmV0OwogCQlidHJmc193YWl0X29y
ZGVyZWRfZXh0ZW50cyhyb290LCBVNjRfTUFYLCAwLCBVNjRfTUFYKTsKQEAgLTcxNzgsNyAr
NzE3OCw3IEBAIHN0YXRpYyBpbnQgZmx1c2hfZGVsYWxsb2Nfcm9vdHMoc3RydWN0IHNlbmRf
Y3R4ICpzY3R4KQogCiAJZm9yIChpID0gMDsgaSA8IHNjdHgtPmNsb25lX3Jvb3RzX2NudDsg
aSsrKSB7CiAJCXJvb3QgPSBzY3R4LT5jbG9uZV9yb290c1tpXS5yb290OwotCQlyZXQgPSBi
dHJmc19zdGFydF9kZWxhbGxvY19zbmFwc2hvdChyb290KTsKKwkJcmV0ID0gYnRyZnNfc3Rh
cnRfZGVsYWxsb2Nfc25hcHNob3Qocm9vdCwgZmFsc2UpOwogCQlpZiAocmV0KQogCQkJcmV0
dXJuIHJldDsKIAkJYnRyZnNfd2FpdF9vcmRlcmVkX2V4dGVudHMocm9vdCwgVTY0X01BWCwg
MCwgVTY0X01BWCk7Cg==
--------------D7DA0EE84EB426FF0D8F4E6F--
