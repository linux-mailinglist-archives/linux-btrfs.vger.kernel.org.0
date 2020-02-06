Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61668153DE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 05:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgBFEfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 23:35:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:36247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgBFEfl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 23:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580963739;
        bh=TCX1o+QrUjjt86kO6uhMWnvWCTfa+U1NSxB5TWslkn8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kGPQr77pxrf4CGvmIUf5Q21HZjbT9j629/EYvh6z/mJh6Kv/rqZye6H/3ipmoS0b+
         TTR5qt8T+dk8JqvWzYriJmawac9X1YZVvbOMCliuvCynpIMBwy26tWrq8/dSQLNZhk
         wq7sP7zgIcCX3IBLCxTID6cunlKxK+KDsd06FdWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGvG-1j2OrE3Ft8-00Ylqm; Thu, 06
 Feb 2020 05:35:39 +0100
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chiung-Ming Huang <photon3108@gmail.com>,
        Btrfs <linux-btrfs@vger.kernel.org>
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
 <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com>
 <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
Date:   Thu, 6 Feb 2020 12:35:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T4d5K43vOTaBtzFW7HtK3gQxOTnTT4kIH"
X-Provags-ID: V03:K1:3yB9fLYOyZXtDO6kdnYM9OJjxOnI5bZQ8hDwr4YY2r1nLsYwJXV
 XuMCxVQmndcz4pWYsWBitpF1WO5MMLpO4CywUSjAWHBHKRHrNynIP+klm0EttGU3V5Grpm5
 w7jhNTsFSS9+4/RIL/dlYDlQHTr+Lw2F8OoKcNczpgpCKufMw3FJ3NYmR1j6cbWnoHbSOSO
 bqtnCd/nu2z0G9f/s6S0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vjLR8u+E8gM=:nvMRarh0GsoSl2PLhuqGGq
 Nr1fwi8zKWW7YdLb65QPoAK6T/gLHwQaPHeDgY37dR9yC+LQFsmiFk9Fous2MIYnis8e0TZlj
 p//ZeJq+5NUAE8HzwZNQaODHgXlIkahYzuud20frqMR5b9l7UkBMoM8dZ5x0d8r/qh/mmjhkh
 JGuvKHE5K35sBGxqba66tLYR7z01Kx/eQqI5m+oWszw+s4+vmfkjWQoKngcUVpltrIYz8oFtT
 PbXya9j+9/fWSkpj3Uyd7lYlAcb6l9AGr3v912ID/qhLKbnSR8OJEyUY7Fr0xUW8XnNWjSXlA
 wu35l25aCULR7mA9KX2EP7OMK+TIku7IRC7WB9t1mEQccqJH7SlG7wejmMXmiyB6BwBCkeaoP
 vXBc359EfRkn/P520JvqWOVpQVOLk9jNtzvmQ+i7c6WXShc8O73084ILDWhur0IzZVrjOji3p
 MqB4kCqDVP/1ZevWRC0yQ+Tr9AfkNyVwLAo17Y9MKzn6/JikiSRQzcw4xHihzEPzSG/qQoepH
 z4T/HKTyFOnfjYe51ceW/NeqhJLdpnwkidlWNo60QRnOrmlQwn0gaaydBoOhQotFQPDqqQ6vA
 Ug/2ACOoAAJHcNSraCeWkT4gcz96MPmHSyTAQVnEEstDzmwTPHxyK7G+Bch+3oQVfZh44Bzzs
 cu7zn8+S8nH6NniUdlojBIjxXheJOM2Qgi1nJPUMrfkvuoV1monR/187wBpk6Bts/VQdWBrNG
 qTXjabGpz3AjPhnPGahCIm//QMMhp+BInCzPuhEyPyCx7R4HIUO0jV8TfvsBpDZ4/+XLQb/9/
 fKUKWdRYTG+82lR6Kr2F7DaL7gpBQwb1oK2dBETfHTB8a5UourVFHFT6b8PyTy2wc1IGnJALE
 vJhLI+AI+vz/Wh/td+O0nbpN4J8n7lKTyCmBB/ZqZ8vsbybPkEL49Zjxx+rMWtxk1WpMtBPrv
 coo7Tr9A8MCpjxWblyygRMgUHhSlEcQ1jrHSHZqvIVXBj1b+lhnXR4tA3y5Ur048tzxG2LbNt
 MYeXCqC9l+gAPDKD/DTmrElPHvTzOsi5I6WK1y3cRsq0FZy0ilkNekLrzd8Iqu2/JyEfAVcTf
 6cfry19wsycMXtYfuikVhMSTqpUbREEW2Eka1rexwu+fm34odXymZ1061yMykUAS9hVp2KCoA
 Pyp64AeNPkTzvpmEHAVNpfC/6Fen8mEbu3c6SdipT/e3CzA/Z+1WILS0Zmh2lfJahRfWNLQP1
 RPoOCyZMGq4LB7C+D
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T4d5K43vOTaBtzFW7HtK3gQxOTnTT4kIH
Content-Type: multipart/mixed; boundary="CoApCurPb80nQtfbUtpS697buciUGPafJ"

--CoApCurPb80nQtfbUtpS697buciUGPafJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/6 =E4=B8=8B=E5=8D=8812:13, Chiung-Ming Huang wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:13=E5=AF=AB=E9=81=93=EF=BC=9A=

>> Please keep in mind that, if you post dmesg, the first time such error=

>> happens is the most important.
>> Not something after you modified the fs by btrfs check --repair.
>=20
> Thanks for your advice. I'll keep in my mind. :)
>=20
>=20
>>>
>>> Feb  3 15:38:24 rescue kernel: [ 8731.172674] BTRFS critical (device
>>> bcache2): corrupt leaf: root=3D23146 block=3D19498503094272 slot=3D8,=

>>> invalid key objectid: has 18446744073709551606 expect 6 or [256,
>>> 18446744073709551360] or 18446744073709551604
>>
>> This is message is even earlier than your initial report, and it's mor=
e
>> important.
>> This means you have a bad inode item with objectid EXTENT_CSUM_OBJECTI=
D.
>>
>> This is a bigger problem.
>=20
> It sounds bad. Is it possible to save the data or part of them?

Metadata is already screwed up.

Data maybe partly saved for btrfs-restore or if you can mount it read-onl=
y.

>=20
>=20
>> Are you sure that is the very first error message you hit?
>=20
> My .bash_history doesn't show timestamp so I'm not really sure which
> critical/error
> message is exactly right after the first `btrfs check --repair`. I
> tried to make log file
> smaller and excerpted only btrfs messages before the first critical
> message in the
> attachment. I'm not so familiar with mailing list. Could you see `btrfs=
_.log`?

Got the attachment.

The first strange part is, I see several mount failure with is caused by
4 or more devices missing.

Then it mounted with devid1 missing.

After reboot, you got the the full fs mounted without any missing.
So far so good, but I'm not sure how degraded mount affects here.

Soon after that, there is already problem showing some degraded mount is
causing problem, where num_devices doesn't match.

Further more, around 14:16 Feb 3, there are metadata transid mismatch,
which means some metadata is already way older.

At that point, btrfs can still try to read from the other copy, thus
it's not a big problem yet.

But that's already poisoning your fs, reducing the stability
step-by-step. It's the RAID1 of btrfs barely saved your fs.
The normal way to handle it is, trigger a full fs scrub to
resilver/resync all RAID1 copies.

And finally, you hit the last stage, where around 15:38 btrfs can't
repair the metadata mismatch caused by multiple brain-split RAID1
situation, causing tons of transid error where btrfs can't fix.


So from the full dmesg, it looks like the abuse of degraded is causing
the problem.

This shows one shortcoming of current btrfs RAID implementation, it
doesn't do automatic re-silver. Unlike mdraid which will do re-silver
before it can be accessed.
Btrfs doesn't have a record of which blocks are written before some
device go missing.

Thus degraded for btrfs should really be considered as a last-resort
method. And manual scrub after all devices go back online is really
recommended.

Thanks,
Qu
>=20
>=20
>>> rescue ~$ btrfs check /dev/bcache4
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/bcache4
>>> UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
>>> [1/7] checking root items
>>> Error: could not find extent items for root 257
>>> ERROR: failed to repair root items: No such file or directory
>>
>> This part is from a special repair for a regression in 3.17.
>>
>> I guess we should not enable it by default.
>> That will be another patch for btrfs-progs.
>=20
> Is this patch safe for saving my btrfs? If it is, I can build btrfs-pro=
gs.

Here is the diff, should be pretty safe:
diff --git a/check/main.c b/check/main.c
index 7db65150048b..bcde157c415d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10373,7 +10373,8 @@ static int cmd_check(const struct cmd_struct
*cmd, int argc, char **argv)
                        ctx.tp =3D TASK_ROOT_ITEMS;
                        task_start(ctx.info, &ctx.start_time,
&ctx.item_count);
                }
-               ret =3D repair_root_items(info);
+               if (repair)
+                       ret =3D repair_root_items(info);
                task_stop(ctx.info);
                if (ret < 0) {
                        err =3D !!ret;


Thanks,
Qu
>=20
>=20
> Regards,
> Chiung-Ming Huang
>=20


--CoApCurPb80nQtfbUtpS697buciUGPafJ--

--T4d5K43vOTaBtzFW7HtK3gQxOTnTT4kIH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl47l5cACgkQwj2R86El
/qhQ/QgAi9I9Wgmaek5VOhU0pukoANOuyWTlpCbi2xxVkObv1e+FpAC2gK58cJrr
xfKhEuskseNw1ECveSk7SLET62BS940Tfx5qZ9DV7kue0GgD+VeAj/7G6E+uJE53
dpohEVdBh2fx1GzVExhn+6azEYqXA+Df4X8vCSSiSnfBoWvTesdqkt9ucI7yUvHE
A0Hde/gsg2CZlfFme7qzxRPvtcjGyzmO6hFO8O1mL9z79A4UThklZjancvJvEiar
pr0XoZc/Xy2CkS2qhawaHOpGf1n3VgKYw0K+AzFWgyCibm8EYJ50DFL7MYQPygZi
E5vLFy+76kj09b8+3m5qp+4esxTL0g==
=x0D6
-----END PGP SIGNATURE-----

--T4d5K43vOTaBtzFW7HtK3gQxOTnTT4kIH--
