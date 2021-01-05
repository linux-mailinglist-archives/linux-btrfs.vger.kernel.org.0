Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2F2EA9DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 12:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbhAEL0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 06:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAEL0D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 06:26:03 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B11C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jan 2021 03:25:22 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id EFA809C220; Tue,  5 Jan 2021 11:24:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1609845875;
        bh=zTjLfrLMYV3jEqeL7EnVhtXJvqk9BUTDCDMmNe6wo3A=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Xu2isxyZDr1D8kyLVp+ROLv5O3gDouO8pvfOQ00fWWBSFJwJ1PD1YF6K9gx1V29Md
         cTQBiaJO1W3je6127f0oBDRYVnfGJyakdhsKygONhxtrWtr4wr9HtUXYdt1B27FZwM
         FU0NvgqNAn21Ziu26vtruGXRu4e9A1yotkJrT1XOnrb18NQsRGEdzqjHwYYgDE2deN
         bIL78p6cNpysWj3Ej5tCT9uEM/n7/J+Lbce4dNBjcFrshMUHI9HUrz4Uddwqfa3tKh
         6u5Hjb9tERSzXSLlnnm+sxogLnZks3cqeI/cbkpxeiXh75yXz7jmmUkV/nCA9Mw4qm
         6n7fqStox48OA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.2 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 379579BC02;
        Tue,  5 Jan 2021 11:24:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1609845867;
        bh=zTjLfrLMYV3jEqeL7EnVhtXJvqk9BUTDCDMmNe6wo3A=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SE6grJBEtvT06ZoBH0wTJJmX5k9ASvoG9fHiEldP9mWo55XauUrjNtUngaTJY6ew7
         XbimLIkcJ/WLawxZ0qchfeB4ZVK53Xt2atjV/f0qmWpPo/+7g2GOzI1F81jjzIkIMk
         1M8ah9JlnXrpTXteeD4JrbnqS8xsC9pIAvGyuoYmcTPnLfBVXSqn8zC7tiTnz1H9Bf
         RE42MKhAz0NmSG8a8v5YOu6r1c8GmlhXsJR/ZE7qtIC4uz60PLRU16usbFxoMBh8mC
         1obN0oigReaOoRKzx63ypPp6gFPQRYo+UKBusFiaMgx/jmg2cbh8XR5ijdYxt+Cso0
         UTwUy8GCXvL7g==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 5C52D1C8145;
        Tue,  5 Jan 2021 11:24:25 +0000 (GMT)
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
To:     Forza <forza@tnonline.net>, Cedric.dewijs@eclipso.eu,
        linux-btrfs@vger.kernel.org
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
 <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 mQINBFaetnIBEAC5cHHbXztbmZhxDof6rYh/Dd5otxJXZ1p7cjE2GN9hCH7gQDOq5EJNqF9c
 VtD9rIywYT1i3qpHWyWo0BIwkWvr1TyFd3CioBe7qfo/8QoeA9nnXVZL2gcorI85a2GVRepb
 kbE22X059P1Z1Cy7c29dc8uDEzAucCILyfrNdZ/9jOTDN9wyyHo4GgPnf9lW3bKqF+t//TSh
 SOOis2+xt60y2In/ls29tD3G2ANcyoKF98JYsTypKJJiX07rK3yKTQbfqvKlc1CPWOuXE2x8
 DdI3wiWlKKeOswdA2JFHJnkRjfrX9AKQm9Nk5JcX47rLxnWMEwlBJbu5NKIW5CUs/5UYqs5s
 0c6UZ3lVwinFVDPC/RO8ixVwDBa+HspoSDz1nJyaRvTv6FBQeiMISeF/iRKnjSJGlx3AzyET
 ZP8bbLnSOiUbXP8q69i2epnhuap7jCcO38HA6qr+GSc7rpl042mZw2k0bojfv6o0DBsS/AWC
 DPFExfDI63On6lUKgf6E9vD3hvr+y7FfWdYWxauonYI8/i86KdWB8yaYMTNWM/+FAKfbKRCP
 dMOMnw7bTbUJMxN51GknnutQlB3aDTz4ze/OUAsAOvXEdlDYAj6JqFNdZW3k9v/QuQifTslR
 JkqVal4+I1SUxj8OJwQWOv/cAjCKJLr5g6UfUIH6rKVAWjEx+wARAQABtDNHcmFoYW0gQ29i
 YiAoUGVyc29uYWwgYWRkcmVzcykgPGdyYWhhbUBjb2JiLnVrLm5ldD6JAlEEEwECADsCGwEG
 CwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBBQJWnr9UFRhoa3A6Ly9rZXlzLmdudXBnLm5l
 dAAKCRBv35GGXfm3Tte8D/45+/dnVdvzPsKgnrdoXpmvhImGaSctn9bhAKvng7EkrQjgV3cf
 C9GMgK0vEJu+4f/sqWA7hPKUq/jW5vRETcvqEp7v7z+56kqq5LUQE5+slsEb/A4lMP4ppwd+
 TPwwDrtVlKNqbKJOM0kPkpj7GRy3xeOYh9D7DtFj2vlmaAy6XvKav/UUU4PoUdeCRyZCRfl0
 Wi8pQBh0ngQWfW/VqI7VsG3Qov5Xt7cTzLuP/PhvzM2c5ltZzEzvz7S/jbB1+pnV9P7WLMYd
 EjhCYzJweCgXyQHCaAWGiHvBOpmxjbHXwX/6xTOJA5CGecDeIDjiK3le7ubFwQAfCgnmnzEj
 pDG+3wq7co7SbtGLVM3hBsYs27M04Oi2aIDUN1RSb0vsB6c07ECT52cggIZSOCvntl6n+uMl
 p0WDrl1i0mJUbztQtDzGxM7nw+4pJPV4iX1jJYbWutBwvC+7F1n2F6Niu/Y3ew9a3ixV2+T6
 aHWkw7/VQvXGnLHfcFbIbzNoAvI6RNnuEqoCnZHxplEr7LuxLR41Z/XAuCkvK41N/SOI9zzT
 GLgUyQVOksdbPaxTgBfah9QlC9eXOKYdw826rGXQsvG7h67nqi67bp1I5dMgbM/+2quY9xk0
 hkWSBKFP7bXYu4kjXZUaYsoRFEfL0gB53eF21777/rR87dEhptCnaoXeqbkBDQRWnrnDAQgA
 0fRG36Ul3Y+iFs82JPBHDpFJjS/wDK+1j7WIoy0nYAiciAtfpXB6hV+fWurdjmXM4Jr8x73S
 xHzmf9yhZSTn3nc5GaK/jjwy3eUdoXu9jQnBIIY68VbgGaPdtD600QtfWt2zf2JC+3CMIwQ2
 fK6joG43sM1nXiaBBHrr0IadSlas1zbinfMGVYAd3efUxlIUPpUK+B1JA12ZCD2PCTdTmVDe
 DPEsYZKuwC8KJt60MjK9zITqKsf21StwFe9Ak1lqX2DmJI4F12FQvS/E3UGdrAFAj+3HGibR
 yfzoT+w9UN2tHm/txFlPuhGU/LosXYCxisgNnF/R4zqkTC1/ao7/PQARAQABiQIlBBgBAgAP
 BQJWnrnDAhsMBQkJZgGAAAoJEG/fkYZd+bdO9b4P/0y3ADmZkbtme4+Bdp68uisDzfI4c/qo
 XSLTxY122QRVNXxn51yRRTzykHtv7/Zd/dUD5zvwj2xXBt9wk4V060wtqh3lD6DE5mQkCVar
 eAfHoygGMG+/mJDUIZD56m5aXN5Xiq77SwTeqJnzc/lYAyZXnTAWfAecVSdLQcKH21p/0AxW
 GU9+IpIjt8XUEGThPNsCOcdemC5u0I1ZeVRXAysBj2ymH0L3EW9B6a0airCmJ3Yctm0maqy+
 2MQ0Q6Jw8DWXbwynmnmzLlLEaN8wwAPo5cb3vcNM3BTcWMaEUHRlg82VR2O+RYpbXAuPOkNo
 6K8mxta3BoZt3zYGwtqc/cpVIHpky+e38/5yEXxzBNn8Rn1xD6pHszYylRP4PfolcgMgi0Ny
 72g40029WqQ6B7bogswoiJ0h3XTX7ipMtuVIVlf+K7r6ca/pX2R9B/fWNSFqaP4v0qBpyJdJ
 LO/FP87yHpEDbbKQKW6Guf6/TKJ7iaG3DDpE7CNCNLfFG/skhrh5Ut4zrG9SjA+0oDkfZ4dI
 B8+QpH3mP9PxkydnxGiGQxvLxI5Q+vQa+1qA5TcCM9SlVLVGelR2+Wj2In+t2GgigTV3PJS4
 tMlN++mrgpjfq4DMYv1AzIBi6/bSR6QGKPYYOOjbk+8Sfao0fmjQeOhj1tAHZuI4hoQbowR+ myxb
Message-ID: <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
Date:   Tue, 5 Jan 2021 11:24:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/01/2021 08:34, Forza wrote:
> 
> 
> On 2021-01-04 21:51, Cedric.dewijs@eclipso.eu wrote:
>> ­I have a master NAS that makes one read only snapshot of my data per
>> day. I want to transfer these snapshots to a slave NAS over a slow,
>> unreliable internet connection. (it's a cheap provider). This rules
>> out a "btrfs send -> ssh -> btrfs receive" construction, as that can't
>> be resumed.
>>
>> Therefore I want to use rsync to synchronize the snapshots on the
>> master NAS to the slave NAS.
>>
>> My thirst thought is something like this:
>> 1) create a read-only snapshot on the master NAS:
>> btrfs subvolume snapshot -r /mnt/nas/storage
>> /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m)
>> 2) send that data to the slave NAS like this:
>> rsync --partial -var --compress --bwlimit=500KB -e "ssh -i
>> ~/slave-nas.key" /mnt/nas/storage_snapshots/storage-$(date
>> +%Y_%m_%d-%H%m) cedric@123.123.123.123/nas/storage
>> 3) Restart rsync until all data is copied (by checking the error code
>> of rsync, is it's 0 then all data has been transferred)
>> 4) Create the read-only snapshot on the slave NAS with the same name
>> as in step 1.

Seems like a reasonable approach to me, but see comment below.

>> Does somebody already has a script that does this?

I don't.

>> Is there a problem with this approach that I have not yet considered?­

Not a problem as such, but you could also consider using something like
rsnapshot (or reimplementing your own version by using rsync
--link-dest) instead of relying on btrfs snapshots on the slave NAS.
That way you don't need btrfs on that NAS at all if you don't want. I
used that approach as the (old) NAS I was using had a very old linux
version and didn't even run btrfs.

> One option is to store the send stream as a compressed file and rsync
> that file over and do a shasum or similar on it.

I have looked into that in the past and eventually decided against it.

My main concern was being too reliant on very complex and less used
features of btrfs, including one which has had several bugs in the past
(send/receive). I decided my backups needed to be reliable and robust
more than they need to be optimally efficient.

I had even considered just saving the original send stream, and the
subsequent incremental sends (all compressed) - until I realised that
any tiny corruption or bug in even one of those streams could make the
later streams completely unrestorable.

In the end, I decided to use a very boring (but powerful and
well-maintained), widely used, conventional backup tool (specifically,
dar, under the control of the dar_automatic_backup script) and I copy
the dar archives (compressed and encrypted) onto my offsite backup
server (actually, now, I store them in S3, using rclone). They are also
convenient to occasionally put on a disk which I can give to a friend to
put at the back of their cupboard somewhere in case I need it (faster
and cheaper to access than S3)!

In my case, I had some spare disks and plenty of bandwidth so I also use
rsnapshot from my onsite NAS to an offsite NAS. But that is for
convenience (not having to have dar read through all the archives) - I
consider the S3 dar archives my "main" disaster-recovery backup.

> btrbk[2] is a Btrfs backup tool that also can store snapshots as
> archives on remote location. You may want to have a look at that too.

I use btrbk for local snapshots (storing snapshots of all my systems on
my main server system). But I consider those convenient copies for
restoring files deleted by mistake, or restoring earlier configurations,
not backups (for example, a serious electrical problem or fire in the
server machine could destroy both the original disk and the snapshot disk).

Your situation is different, of course - so just some things to consider.


