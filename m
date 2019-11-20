Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6752410307E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKTACv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 19:02:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:52539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfKTACv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 19:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574208168;
        bh=m000vPuOyQcRNIplTVxTSP8pyJgZwiFtkzjYvhbyY8I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZPlnjjzkAHBQgeZK9lE3jyar9Eoekrl2BrsnBrg/vrCHiKaRNKiJeSdFrC8wOtmkq
         sQy2XdA3jorRPJPeX4/Clgf8KjWVBRQKR43oaxoPfm6mmwTDpIFh5KNjIo9ROx8/Zf
         60aDfvIGosVuTEL8/cPG6xz1szR33IRk07IQnmcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXUD-1iFPkm2duh-00JZOu; Wed, 20
 Nov 2019 01:02:48 +0100
Subject: Re: How to replace a missing device with a smaller one
To:     dsterba@suse.cz, Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
 <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
 <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
 <20191119143857.GU3001@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0a8fd2a8-12fe-f899-5a53-b5f584a35878@gmx.com>
Date:   Wed, 20 Nov 2019 08:02:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119143857.GU3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T2XdEFfP1HKXPZLrM1ezgnv1jqzNxo75r"
X-Provags-ID: V03:K1:0hkOvvlt3VNLZQiWxeOipC68Kz3yHopShK/IjJCrBlT1LQ0KotT
 dEhqhvggl4U84IWowxPnAXTzub9cRLiaAwpcuNDjfqlIa3vPl0x1vIFjmSBi72/tttB6W89
 JHzmuSm8IslHf7D1gr89NaDJ+sRA+h/wGhLnEc+2TuPcmkFj9UtL09LL61w+ANlxTu3BusC
 MCASJG825rMDxhDk/dTJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LuPvqm9/+i0=:Teb4yZPfg3wha9eZJGMBi8
 sbaqP3ZlRCadAV9xcO91bGnwxA6ICI5MfMRzM30R75vFrRDsBnTZwEH2FLg2I2hOrG3szL3Xv
 4BB7KhHrkn5smQnEoHkP9vdrOZbNMzazl+vcLNMZ/dqk3c8N0U2Wzbt2kx0i1Vw/qOJ0GY/KH
 HFrnQueE7IJ9SyKZSJ4rsmQkmKJQWgOlfQFbzb5c0mwSOAIphvU22zwklZJl8Cz+WHRUJVAgE
 tCrURvpheiFvwPvDl4PHkm8n83/0F9wo0V88dPNhd8d7M6iGQpa0uTfEgqeFFKV3iY83bsZ1+
 WNYXxX/UH/kPtZjRT9fT1AgfYxpF2X/FzfMojujjB7IZw1P905JAVL2cRwBxAaK7/mCbCRe+Z
 qSa8I75G7JUSCCOljBsWEK9a7g1mOhyJmMtkIN4T+6JpiZasyvy/Jx0gEZubX1FeDcg1Wi9UL
 xncAdSOI39zoFcYEK28qbq1TRfwQkllQUAfD9aFmzGrAg4uEd83V8ojQDPCkiIsBEb+ywYkpv
 gqWBnI9fKXD5Ssp2NcMP+62Oj+vdkU4Zh5gWOe4Fam0tg9b1rHpp3IWtHx+cOcINHQb8EYVjR
 fuRsQKZfRW68ZU3bpOAxob4fz/dR1arrju2FnDGjBIb+BnZXyRVW4oael7xLBby4sU8G8ybcs
 +3wMgFCEXZ1z8E9D74U+kjjJ5YbkXSEG59U5iS9aKyTgSMREEM7kDB3YU6OHTWpNwmtcy9Jro
 3qvh6scqWLYDCt59wiNsGnkALPe778ElzDmEXeB4QX5YfinW31x/cKhg7YujnwvaAogvgfzRK
 J96lhA3WJ5H9zTaLX4ICj9pHVuhBFvbqJTWhKeJe0kLAWupPEgvYnJUXS+vSZR4G07Mk8NE2T
 0u5IiH/fLS/4yChBiSSqOUOlrbZO6WNheR86/Hg2Hz8sWX4f89XF3wx6eZwbIWprQuifsPOaB
 LTKpFRfWT+cyok0JB0SrVf38Eaqeev61LKsfu5WeKG3HXlm9BT1hs9uLwRGG8s+zgEEKxI9eQ
 XmSiBg5w+L93sIe77tPN1Rj4Mk4ussPzEmL8nhEigmoDeGM32Haiaon5Bq5j9nF5tf5dCYrCI
 tsxi7+PWpSbMDwrwJFyl1BGe9zynh+dqTKgNjuqa/uQhB31CXgBaHTzpfDwm+csWWU5L11odt
 s1TxYL2mcE3MvXd5ltJIB9IgNH7sdyi2wTFVRXzDBGgcA8n1tvbpgPga4zmxvzuos/VgNYvc8
 N7lHV2uCWTG9OVc6Qz92DMolVhFwZ2AHgzmUEmT8sEOzd0+IMICYs4Csv8es=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T2XdEFfP1HKXPZLrM1ezgnv1jqzNxo75r
Content-Type: multipart/mixed; boundary="NbkAbiZU3PlaknRaCgi0PDGG9iLxDcFvX"

--NbkAbiZU3PlaknRaCgi0PDGG9iLxDcFvX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/19 =E4=B8=8B=E5=8D=8810:38, David Sterba wrote:
> On Mon, Nov 18, 2019 at 03:08:00PM +0800, Qu Wenruo wrote:
>> On 2019/11/18 =E4=B8=8B=E5=8D=881:32, Qu Wenruo wrote:
>>> On 2019/11/18 =E4=B8=8A=E5=8D=8810:09, Nathan Dehnel wrote:
>>>> I have a 10-disk raid10 with a missing device I'm trying to replace.=
 I
>>>> get this error when doing it though:
>>>>
>>>> btrfs replace start 1 /dev/bcache0 /mnt
>>>> ERROR: target device smaller than source device (required 1000203091=
968 bytes)
>>>>
>>>> I see that people recommend resizing a disk before replacing it, whi=
ch
>>>> isn't an option for me because it's gone.
>>>
>>> Oh, that's indeed a problem.
>>>
>>> We should allow to change missing device's size.
>>
>> I have CCed you with a patch to allow user to *shrink* the missing dev=
ice.
>>
>> You can also get the patch from patchwork:
>> https://patchwork.kernel.org/patch/11249009/
>>
>> Please give a try, since the device size is pretty small, I believe wi=
th
>> that patch, we can go quick shrink, that means "btrfs fi resize" comma=
nd
>> should return immediately.
>=20
> So it can be recteated eg. on loop devices, where some of them are
> slightly smaller, then go missing and replace is started, right?
>=20

Replace will still be rejected, but we can do resize of that missing
dev, then replace, as a workaround.

I haven't do the auto-resize for replace yet, since I'm not sure if that
could make cases like replacing 1T device with 10G driver happening.

Thanks,
Qu


--NbkAbiZU3PlaknRaCgi0PDGG9iLxDcFvX--

--T2XdEFfP1HKXPZLrM1ezgnv1jqzNxo75r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3UgqMXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgfIgf+IXYXtuwCRVivc6tQFhbrhZbZ
ikMa+a0ECRFM6B6I/FxHxdrddNvirv6U2y8G+R/hKBFrsfaJXAEjNEpvY7aG/ytA
CrZVI60FSW+6ktv6/q0VaFopoE0Bxx7N7GnWXS4WRvpXu2ra2liZUQ7k6Dxz9mhp
Tg+T8rROgjL51aq5LEM8w38OjHXbg35l5VPUmHNhL7466DZs7lkvfvmPPir6exJ3
J6DZ8DsQ9YbOTtvDGgI/a+/71tYCWWSGSvSXAy3OeCbe55fG3QxMXLmgsCzRP08O
rTVoFY1/fTxiqYXZv1wyavX99WYyz63vHqEOfm/6HVBvSP954A6qEgYibd2Mrw==
=OWpO
-----END PGP SIGNATURE-----

--T2XdEFfP1HKXPZLrM1ezgnv1jqzNxo75r--
