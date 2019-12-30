Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A1212CE36
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 10:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfL3J1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 04:27:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:46183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfL3J1X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 04:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577698041;
        bh=od8+L1obIA7zZdraiDNBImVMsV3uJwmpwCBTqsn6JGI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Cw6FdmRu7qRhXchQPIDbQTQuz+oyLAl1+Mlm9BMIMGNYFdRdg3hJw8hbTmf/WxmOa
         ylMRwzxNBflHqpZa1hB1ON+tsKNimS7D7zXt3cyNUE0WUkMMBfHL/27o/3oXG1TwNN
         tOfqvxyqEDpPzjHcPVD10RjMiGrrAQfd9p4Up5w0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXGrE-1jG6HW0shy-00YfuP; Mon, 30
 Dec 2019 10:27:21 +0100
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
 <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
 <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com>
 <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
 <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com>
 <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
 <27a9570c-70cc-19b6-3f5f-cd261040a67c@gmx.com>
 <CAOB=O_hMPVfmFqumfcdS8LxG0tZXR2AiccDwgN1f6Lomntg9uQ@mail.gmail.com>
 <4a28f224-a602-61e7-3404-68a4414df81c@gmx.com>
 <CAOB=O_i9cjtZD3LxvfN6eg31uzab6PE1E=Gh_4C3KLeMeeZX0g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <278545c8-3267-b6d2-8e0e-5de6be572946@gmx.com>
Date:   Mon, 30 Dec 2019 17:27:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOB=O_i9cjtZD3LxvfN6eg31uzab6PE1E=Gh_4C3KLeMeeZX0g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2ybBKaRA6UvcAJQvyHGG2ySNRy2A1hYZf"
X-Provags-ID: V03:K1:GhP8z+K0MjHq2gHW0zeg6ZWudXBNzVwfTkkQSjtfkn+7q4BbtSu
 2GTufmthdioFNnqBBhe1ye/TYwe5RMRUGAVkrh6aYfEVjHL+QpTpmI62PlsM1bYPlkN9qM9
 I4AG6S08IacMUhp/rGEEAezekmyS2w8T7So83Lai5TUBDZY99E6xKNpdtKoqjcrCZ1B6BxG
 hg8jj30aZQL6w/KIHuWEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yaBkLRUCO9Y=:Ub2vKD/tUkZEpxBrEneApQ
 PuNfJFOfFU39hc4H8eokwPVWV/GTCp8aKsMr/X+7g1fUX30VhqATTP2N29Wle3FHocdy8J5Vw
 qwIOL0RNKTA8p/OPPKqC5ClsRqdWtcJzPBvSWfdHZYqqZo+PrFnVAHLl1lPuEXPNSHI7Cee6+
 +2+kIo1YeRo7cMjy0dgmjJ7zISodGqoazu3lhYImJmtLKRXwPuguaQcVcHde7mpNRmuS6eu3g
 eLhUVKdPYtL/7VhG38CB/cS1P4XlGdVUYhJAKJhKHtgqunWSCDY5kDqF4qAfSHXCp2i4kmkIU
 uDBmmOYdJ1iQB9b+xXzM/xyTwODIlQkRMwzdu9I1diLK1HfggkJxl/Z0f8r/DWEW8L0mETIsy
 3AuPZN+01CODoOX+/jVx8BmZZVOnTzidPK8zNczgMmbfwClTH4H/f0uac0XAYontYAXbKVm6M
 y6jbyM9OsAY066fORfZXdWtTBvF1bHTPhjdjjqF9BdT9IdB+hsrxqPxS0h8VkOHDN7nHIqEyX
 Qx0HqppIZtOcw7qi2SB9ORJozXpzH3zcXman/C7ccBtLF2MD06SuIQZAtsRCI7J5UDeYUc51h
 ErKS2w1YRkJt3+/XMcWTaUJJanL7AHe9IAhZdoicfEnTI33IDiaHG05r+HmuCUJgUsI43fqb/
 yJ/kAaGhw0lAVs/p6erIebvAgFzXDcBljMAV7cD3RgR7AtBgLKNUUY6WaY5jTY6fHreC0mrBJ
 nAVk5u+idfFJQkQ2IU5kEl7W+aTkXanq8NxUB88zVIZqIVz4ISsz4lSee+FUvUNI1HlGqPP9R
 oyZ0DgWUnmi7PX94Idjxj3XUqts2acjyg6k0mI2ouImo8ErqtQewy9h17u0aD1a2Gu4nMbgwq
 3XYm+gO0tPUeEkAddXAtNKUDuzROIUueaoLMJF6E6cw1o4DfJqH+mF8AiGHiXnUtHFIn3kkIQ
 ZrePUPtiplfnrIlxHFrQthbbgd6tFgtYhX9UbwD+tfpH36zcJICRSDi6GBy9c1021nqZ/KZAF
 141XS8AEqeS5k3BjxxOJV4X72TKE+XgmwY4Jl52jS4or9XFE3CMtA0QL2lQ1JDzsvrbWOTCnY
 slDxnYpwdxTEWGcl6jOdZI28nZKpmnm2w2FqlxpfQ/uhNEGICGeD9lti3Uq1ef18jZMtKdVVM
 OcIgF6L0IzvrJKrcPYXylZk9OACaAjrdiIeQCTQuKQi60FOH65xnAh61jVRKv9qW2+JD99ziK
 jWc4p2/pCkh7rhoEnO2xcMVj8jo8qO0LLZ006lmdSBGfvN1/4f9v7IIoah4s=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ybBKaRA6UvcAJQvyHGG2ySNRy2A1hYZf
Content-Type: multipart/mixed; boundary="ve8TPAXPIv27QC4SOENaZu9s6H23pY2AG"

--ve8TPAXPIv27QC4SOENaZu9s6H23pY2AG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8B=E5=8D=885:21, Patrick Erley wrote:
> On Mon, Dec 30, 2019 at 9:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2019/12/30 =E4=B8=8B=E5=8D=885:01, Patrick Erley wrote:
>>> On Mon, Dec 30, 2019 at 8:54 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>> On 2019/12/30 =E4=B8=8B=E5=8D=884:14, Patrick Erley wrote:
>>>>> On Mon, Dec 30, 2019 at 6:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>
>>>>> Should I also paste in the repair log?
>>>>>
>>>> Yes please.
>>>>
>>>> This sounds very strange, especially for the transid mismatch part.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>
>>>
>>>
>>> enabling repair mode
>>> WARNING:
>>>
>>>     Do not use --repair unless you are advised to do so by a develope=
r
>>>     or an experienced user, and then only after having accepted that =
no
>>>     fsck can successfully repair all types of filesystem corruption. =
Eg.
>>>     some software or hardware bugs can fatally damage a volume.
>>>     The operation will start in 10 seconds.
>>>     Use Ctrl-C to stop it.
>>> 10 9 8 7 6 5 4 3 2 1parent transid verify failed on 499774464000
>>> wanted 3323349 found 3323340
>>> parent transid verify failed on 499774521344 wanted 3323349 found 332=
3340
>>> parent transid verify failed on 499774529536 wanted 3323349 found 332=
3340
>>
>> This message is from open_ctree(), which means the fs is already corru=
pted.
>>
>> Would you like to provide the history between last good btrfs check ru=
n
>> and --repair run?
>>
>> Thanks,
>> Qu
>=20
> In theory, all I did was boot back into 5.1 and continued using the
> system.=20

If that's the only thing before --repair (if there is only one repair
run, and output is exactly what you pasted), then I guess something
didn't go right in that 5.1 run?

Is that pasted output from the first --repair run?

If there is another run before the pasted output, then it could be
previous --repair.

Either way, I'm very sorry for the data loss...

> After you said I should go ahead and try to --repair, I
> rebooted into initramfs and ran the repair, then continued
> booting(which failed spectacularly, due to almost all of / being
> missing).  I then rebooted back into initramfs to assess what was
> going on, and made a liveusb (from which I'm sending this on that
> system).  Some 'background' on the FS: It was migrated from ext4 ~7?
> years ago, and has been moved between multiple discs and systems using
> dd.  Interesting point: The only files/folders that still exist in /
> were created after I migrated the filesystem.  If I can get /etc and
> maybe /var back, I'm golden (there are a few bits in each I don't
> include in my hot backups, so will have to go to offline storage to
> fetch them).

I'm afraid the only chance we left is btrfs-restore.

And normally for transid error, the chance is pretty low then.

Thanks,
Qu

>=20


--ve8TPAXPIv27QC4SOENaZu9s6H23pY2AG--

--2ybBKaRA6UvcAJQvyHGG2ySNRy2A1hYZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4JwvQXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiRqQf+L6uDmikFBQw/03K7EB/v2u/n
O+txPiGxfgo75L41Eeoj2PeUV9Om4pL3PpW3nNh7WCryy1n9cKLBW3pqSH/codjb
2+KPDQrrdVdZij4Eeo93q0YK/dsmMBcH0mTQNvtBSt56OcztGoSujqDaSXZlgZZ/
Ms5li6G8f0JbOl1mkpbK8PV+byesJc5XZkMkecMy4RyQZdM1K09snBJKgQepSsI5
LlkLKwkDf+u79dWY3OOYd6Ul3R/FsQubf/hNp15FpDVNzwaUNfr7vH3NSBWB/cr3
7HZRK4CWbc+hTJ5mIAW1SPrZ7cJXP/PqDwzD2JOpPjl2z8gy2YzWcBQ8qfbpFw==
=6dLJ
-----END PGP SIGNATURE-----

--2ybBKaRA6UvcAJQvyHGG2ySNRy2A1hYZf--
