Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC3327DD9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhCAMHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 07:07:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:59841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhCAMHi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 07:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614600365;
        bh=vlJyLsArbyOsm2FxJMVKzPbh/mbpy4D+d4kdU+wgQU8=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Prj4GRsOm7YBV216KYtOo+NjRJsF2yU97kWA4vTBVr5KazU5VsgQaZ0bhbHKkgxB1
         kJ0iZuXGjd7PGKGDawYhenzBLes7JzgJdy4r3ZucoLoxiv3qRsFLAPFUTFpUR5KACd
         vWMuYBdhlO4BQVwyxEgxFgylj4Jl11fbYDN1mPKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqJqD-1ldP4h1EdH-00nSOn; Mon, 01
 Mar 2021 13:06:04 +0100
To:     =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>,
        linux-btrfs@vger.kernel.org
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Adding Device Fails - Why?
Message-ID: <0a746faf-6c3c-542b-ac71-8d5012e998bc@gmx.com>
Date:   Mon, 1 Mar 2021 20:06:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
Content-Type: multipart/mixed;
 boundary="------------86D23B36A730E8D5CB1FF3CC"
Content-Language: en-US
X-Provags-ID: V03:K1:JXC9gbuWkf0II5+1YZrWQPsjeY7ELt+lgxFkOtLHEgNoD15Jfts
 WmNppfROY/pg08zkTew6h1DrspaT3fgIbFn4d6LJ3/w/Fh+dosrF+P3r/01KZzESJgsu710
 7ZMvfS366re3Rc2h8TU5ozmVas6YATqwZGH1eRUAJ0L9hdiNYV0HWYyVRunC7iTTtb/oGL8
 QQk2wX/cUyNT8fF2qBVyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6RSqrDP5mU=:Kc+e8j6o3sCXqccIuX1Urd
 4nt13zwZZxkdbFlHPXSGjod5ImwhfOMX3qAc1/cnkd0qOSdlM6X6jhmPSJgmdNPRUfhSJblse
 M4637NmiD1FxKynEHVc833wog5+Md9tQeFuItAHkaTNaL3EHbkR0kGQWQa0qi5JQW/tXXA9Sp
 y+Jq81n7gniJQm0os6iBSKFoqcbar5ljZLciyvd6W5K+aFcVJj9RvMHQS7VsIedyeCyUjhFRO
 QFKj+WIuFyjoCNpiczdJTgZm712UJA/qyVwOOLEJ0P0MPeAdiA6PUyBY36UexZcQN3JuoE+U+
 Tqeeo1dkWqgff8tCrsWqsB884BGS9UQi+Ic2vZVbTWSsG16bZtaHqopq/m9ko/4e21Vpmvdr8
 FlmiAKUNr8hkynnz6+f0LtB6cAQ1Wnb5x9hl0bc/e7uupi+l2zIswYvov2JTZglEKmEchw2PE
 kxZT/z7GLEMpkPkLBC1Umj6+Axu8rwO0mV6ako5j7kzG+1XfCeEGq5rJTvuDxz7J9Ec8w6674
 XqKSK/2Y5yUiKNa7G5P1H7vgHkGBAf0NLZt7R6zTYHAL3gZkI1skHoXKobAneq6C3CLpaW7As
 aw2mqPWX4S1ynBSzrLmFXKp/w52owJljvvr8wZ31HAxVxnT770cx4w+MZ6I/0d7LSOqw2ORn1
 C7V9n/cW6fsVTEfVUZHuusLPiJqMZHkHLGQcUOC55ykmVfPwY8oF9hEX7Bnw01sWoS9ya/KQQ
 GX/FzLHZk5MUELjWwKlQJQ6ezeQN0X2hcsh2XOk0d6WytsQfPm88yD/yJmu61rJiPZRrFyDm7
 l9zPaLPU9MxK6OgiZhIiDvYG7Fx3PCdnyW1q7UaACeHWjyZYZfAIN3rsSsGJ2Fn3sCGGfDQle
 VYRuMHyEVoMEOH7EnGcQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------86D23B36A730E8D5CB1FF3CC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/3/1 =E4=B8=8B=E5=8D=887:19, Christian V=C3=B6lker wrote:
> Hi all,
>
> I am using BTRS on a Debian10 system. I am trying to extend my existing
> filesystem with another device but adding it fails for no reason.
>
> This is my setup of existing btrfs:
>
>  =C2=A02x DRBD Devices (Network RAID1)
>  =C2=A0top of each a luks encrypted device (crypt_drbd1 and crypt_drbd3)=
:
>
> vdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 254:16=C2=A0=C2=A0 0=C2=A0 1,1T=C2=A0 0 disk
> =E2=94=94=E2=94=80drbd1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
47:1=C2=A0=C2=A0=C2=A0 0=C2=A0 1,1T=C2=A0 0 disk
>  =C2=A0 =E2=94=94=E2=94=80crypt_drbd1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 253:3=C2=A0=C2=A0=C2=A0 0=C2=A0 1,=
1T=C2=A0 0 crypt
> vdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 254:32=C2=A0=C2=A0 0=C2=A0 900G=C2=A0 0 disk
> =E2=94=94=E2=94=80drbd2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
47:2=C2=A0=C2=A0=C2=A0 0=C2=A0 900G=C2=A0 0 disk
>  =C2=A0 =E2=94=94=E2=94=80crypt2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 253:4=C2=
=A0=C2=A0=C2=A0 0=C2=A0 900G=C2=A0 0 crypt
> vdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 254:48=C2=A0=C2=A0 0=C2=A0 800G=C2=A0 0 disk
> =E2=94=94=E2=94=80drbd3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
47:3=C2=A0=C2=A0=C2=A0 0=C2=A0 800G=C2=A0 0 disk
>  =C2=A0 =E2=94=94=E2=94=80crypt_drbd3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 253:5=C2=A0=C2=A0=C2=A0 0=C2=A0 80=
0G=C2=A0 0 crypt /var/lib/backuppc
>
>
>
> I have now a third drbd device (drbd2) which I encrypted, too (crypt2).
> And tried to add to existing fi.
> Here further system information:
>
> Linux backuppc41 5.10.0-3-amd64 #1 SMP Debian 5.10.13-1 (2021-02-06)
> x86_64 GNU/Linux
> btrfs-progs v5.10.1
>
> root@backuppc41:~# btrfs fi sh
> Label: 'backcuppc'=C2=A0 uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 1.83TiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 si=
ze 799.96GiB used 789.96GiB path dm-5
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 si=
ze 1.07TiB used 1.06TiB path dm-3
>
>
> I can create an additional btrfs filesystem with mkfs.btrfs on the new
> device without any issues:
>
> root@backuppc41:~# btrfs fi sh
> Label: 'backcuppc'=C2=A0 uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 1.83TiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 si=
ze 799.96GiB used 789.96GiB path dm-5
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 si=
ze 1.07TiB used 1.06TiB path dm-3
>
> Label: none=C2=A0 uuid: b111a08e-2969-457a-b9f1-551ff65451d1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 128.00KiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 899.96GiB used 2.02GiB path /dev/mapper/crypt2
>
>
> But I can not add this device to the existing btrfs fi:
> root@backuppc41:~# wipefs /dev/mapper/crypt2 -a
> /dev/mapper/crypt2: 8 bytes were erased at offset 0x00010040 (btrfs): 5f
> 42 48 52 66 53 5f 4d
>
> root@backuppc41:~# btrfs device add /dev/mapper/crypt2 /var/lib/backuppc=
/
> ERROR: error adding device 'dm-4': No such file or directory
>
> This is what I see in dmesg:
> [43827.535383] BTRFS info (device dm-5): disk added /dev/drbd2
> [43868.910994] BTRFS info (device dm-5): device deleted: /dev/drbd2
> [48125.323995] BTRFS: device fsid 2b4b631c-b500-4f8d-909c-e88b012eba1e
> devid 1 transid 5 /dev/mapper/crypt2 scanned by mkfs.btrfs (4937)
> [57799.499249] BTRFS: device fsid b111a08e-2969-457a-b9f1-551ff65451d1
> devid 1 transid 5 /dev/mapper/crypt2 scanned by mkfs.btrfs (5178)

If you can recompile btrfs module, would you mind to test the following
diff to help us debugging the problem?

Of course, after applying the diff and recompiling the module, you still
need to use the new btrfs module to try add the device again to trigger
the error.

Thanks,
Qu
>
>
>
> And these are the mapping in dm:
>
> root@backuppc41:~# ll /dev/mapper/
> insgesamt 0
> lrwxrwxrwx 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 28. Feb 21:=
08 backuppc41--vg-root -> ../dm-1
> lrwxrwxrwx 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 28. Feb 21:=
08 backuppc41--vg-swap_1 ->
> ../dm-2
> crw------- 1 root root 10, 236 28. Feb 21:08 control
> lrwxrwxrwx 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7=C2=A0 1. M=
=C3=A4r 12:12 crypt2 -> ../dm-4
> lrwxrwxrwx 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 28. Feb 20:=
21 crypt_drbd1 -> ../dm-3
> lrwxrwxrwx 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 28. Feb 20:=
21 crypt_drbd3 -> ../dm-5
> lrwxrwxrwx 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 28. Feb 21:=
08 vda5_crypt -> ../dm-0
>
>
> Anyone having an idea why I can not add the device to the existing
> filesystem? The error message is not really helpful...
>
> Thanks a lot!
>
> /KNEBB
>
>
>

--------------86D23B36A730E8D5CB1FF3CC
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3ZvbHVtZXMuYyBiL2ZzL2J0cmZzL3ZvbHVtZXMuYwpp
bmRleCBiOGZhYjQ0Mzk0ZjUuLjllNzU5YTBmOWMxMCAxMDA2NDQKLS0tIGEvZnMvYnRyZnMv
dm9sdW1lcy5jCisrKyBiL2ZzL2J0cmZzL3ZvbHVtZXMuYwpAQCAtMjU4Niw4ICsyNTg2LDEx
IEBAIGludCBidHJmc19pbml0X25ld19kZXZpY2Uoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZz
X2luZm8sIGNvbnN0IGNoYXIgKmRldmljZV9wYXRoCiAKIAliZGV2ID0gYmxrZGV2X2dldF9i
eV9wYXRoKGRldmljZV9wYXRoLCBGTU9ERV9XUklURSB8IEZNT0RFX0VYQ0wsCiAJCQkJICBm
c19pbmZvLT5iZGV2X2hvbGRlcik7Ci0JaWYgKElTX0VSUihiZGV2KSkKKwlpZiAoSVNfRVJS
KGJkZXYpKSB7CisJCXByX2luZm8oIiVzOiBmYWlsZWQgdG8gZ2V0IGJsa2RldjogJWxkXG4i
LCBfX2Z1bmNfXywKKwkJCVBUUl9FUlIoYmRldikpOwogCQlyZXR1cm4gUFRSX0VSUihiZGV2
KTsKKwl9CiAKIAlpZiAoIWJ0cmZzX2NoZWNrX2RldmljZV96b25lX3R5cGUoZnNfaW5mbywg
YmRldikpIHsKIAkJcmV0ID0gLUVJTlZBTDsKQEAgLTI2MTcsNiArMjYyMCw3IEBAIGludCBi
dHJmc19pbml0X25ld19kZXZpY2Uoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIGNv
bnN0IGNoYXIgKmRldmljZV9wYXRoCiAJaWYgKElTX0VSUihkZXZpY2UpKSB7CiAJCS8qIHdl
IGNhbiBzYWZlbHkgbGVhdmUgdGhlIGZzX2RldmljZXMgZW50cnkgYXJvdW5kICovCiAJCXJl
dCA9IFBUUl9FUlIoZGV2aWNlKTsKKwkJcHJfaW5mbygiJXM6IGZhaWxlZCB0byBhbGxvYyBk
ZXY6ICVkXG4iLCBfX2Z1bmNfXywgcmV0KTsKIAkJZ290byBlcnJvcjsKIAl9CiAKQEAgLTI2
MzcsNiArMjY0MSw3IEBAIGludCBidHJmc19pbml0X25ld19kZXZpY2Uoc3RydWN0IGJ0cmZz
X2ZzX2luZm8gKmZzX2luZm8sIGNvbnN0IGNoYXIgKmRldmljZV9wYXRoCiAJdHJhbnMgPSBi
dHJmc19zdGFydF90cmFuc2FjdGlvbihyb290LCAwKTsKIAlpZiAoSVNfRVJSKHRyYW5zKSkg
ewogCQlyZXQgPSBQVFJfRVJSKHRyYW5zKTsKKwkJcHJfaW5mbygiJXM6IGZhaWxlZCB0byBz
dGFydCB0cmFuc2FjdGlvbjogJWRcbiIsIF9fZnVuY19fLCByZXQpOwogCQlnb3RvIGVycm9y
X2ZyZWVfem9uZTsKIAl9CiAKQEAgLTI3NDEsOCArMjc0NiwxMCBAQCBpbnQgYnRyZnNfaW5p
dF9uZXdfZGV2aWNlKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBjb25zdCBjaGFy
ICpkZXZpY2VfcGF0aAogCQl1cF93cml0ZSgmc2ItPnNfdW1vdW50KTsKIAkJbG9ja2VkID0g
ZmFsc2U7CiAKLQkJaWYgKHJldCkgLyogdHJhbnNhY3Rpb24gY29tbWl0ICovCisJCWlmIChy
ZXQpIC8qIHRyYW5zYWN0aW9uIGNvbW1pdCAqLyB7CisJCQlwcl9pbmZvKCIlczogZmFpbGVk
IHRvIGNvbW1pdCB0cmFuczogJWRcbiIsIF9fZnVuY19fLCByZXQpOwogCQkJcmV0dXJuIHJl
dDsKKwkJfQogCiAJCXJldCA9IGJ0cmZzX3JlbG9jYXRlX3N5c19jaHVua3MoZnNfaW5mbyk7
CiAJCWlmIChyZXQgPCAwKQpAQCAtMjc1Myw2ICsyNzYwLDcgQEAgaW50IGJ0cmZzX2luaXRf
bmV3X2RldmljZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgY29uc3QgY2hhciAq
ZGV2aWNlX3BhdGgKIAkJCWlmIChQVFJfRVJSKHRyYW5zKSA9PSAtRU5PRU5UKQogCQkJCXJl
dHVybiAwOwogCQkJcmV0ID0gUFRSX0VSUih0cmFucyk7CisJCQlwcl9pbmZvKCIlczogZmFp
bGVkIHRvIGF0dGFjaCB0cmFuczogJWRcbiIsIF9fZnVuY19fLCByZXQpOwogCQkJdHJhbnMg
PSBOVUxMOwogCQkJZ290byBlcnJvcl9zeXNmczsKIAkJfQpAQCAtMjc3MSw2ICsyNzc5LDcg
QEAgaW50IGJ0cmZzX2luaXRfbmV3X2RldmljZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNf
aW5mbywgY29uc3QgY2hhciAqZGV2aWNlX3BhdGgKIAkvKiBVcGRhdGUgY3RpbWUvbXRpbWUg
Zm9yIGJsa2lkIG9yIHVkZXYgKi8KIAl1cGRhdGVfZGV2X3RpbWUoZGV2aWNlX3BhdGgpOwog
CisJcHJfaW5mbygiJXM6IGZpbmFsIHJldDogJWRcbiIsIF9fZnVuY19fLCByZXQpOwogCXJl
dHVybiByZXQ7CiAKIGVycm9yX3N5c2ZzOgo=
--------------86D23B36A730E8D5CB1FF3CC--
