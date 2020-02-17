Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66880160F4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgBQJxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 04:53:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:53261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgBQJxN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 04:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581933189;
        bh=XieleQsLlNm3lvzBqZ95OS4fQCofivGJhBCNx2TTzy4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QEdE8BJx/52CRhZGsEIY38VMePUIlApxZVxMit2Bk/hzEsViQSON9B5EZbSa7O6Gk
         IXMcqxZVejX5DRXmMPj68s4aDgQ7OEJoXhTDiGz9X8Yh7595wwaRjM5Vbb3741FgYD
         LhflyVABjtYNBzBwRCuz+gy7TBBMwjhYDPYsrR0c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1jUc8Q2eQA-011UrG; Mon, 17
 Feb 2020 10:53:09 +0100
Subject: Re: [PATCH v3 0/3] btrfs: Make balance cancelling response faster
To:     Graham Cobb <g.btrfs@cobb.uk.net>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200217061654.65567-1-wqu@suse.com>
 <d4161c6c-7629-3d64-fdf9-51a8841b193b@cobb.uk.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <efb5f007-7d25-468e-6b35-329a9e625dfe@gmx.com>
Date:   Mon, 17 Feb 2020 17:53:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <d4161c6c-7629-3d64-fdf9-51a8841b193b@cobb.uk.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KQoFB5wIvIieQ4mxVzeaoqZPyceDooo1a"
X-Provags-ID: V03:K1:bHeaFCYptT84CR2Sg3SZ7znapLC9Ie7OasUkwJqJfKUcVe/sxT0
 WewoviA3HrLB24IzALapxZ7bMuRy3bo2RUO/cKcGfq2IheuIOFbpheOFHts4RGKE0VYHZ8M
 03FtLQ8MTHBLQY7xlL4BrIbV2b4ZviKuGlDuO9ASdJc0Fjkvl2dCpkmkan18jHV6jOQutRV
 g+rgBs8bURk976ql6EjAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HIJWQmmiw7o=:cmF/yf7PtkybRAhLQllI7o
 gNQzVKFY/pKBjrePWXPZyIiVqVlK9Zgg6jiElpmDqO2LNFRmEJqSoa4SyPpz/QjS2idqiWLUu
 EvVP2BD/gpoSFadTDpAUnNTVk9tqWPvtI14WtSJAmW9ChkVgE8bJGW6xFM7LVlNHpSkfXEv/N
 9WQnWXdyYqhVOolbQ9cpQ2IyZ7FK73WveXNtGuKJ/qicEquorpl1YFysSCu/FmTS94CVrHOD3
 NpyOGGiOIP44CcWsNEfJV0lu03XKxARlAII1A4BRqeGVlfJGOF6kUYPtismaIGUOE3CbnSNPj
 FU/YclIiK7/ivCL1IKbIqBAypr8GAveYSBy8uNY4SI7HnXDV9EmqvICYdYQYcNWFYK+m9DFz7
 Bd14VyErmTmPGZGYJ/qzCxTrFhmYQVdfWq5UqFRxOEtLlgk1SVlJAaKx1qJD4YK6+CB2F3+TE
 rN5NpAeGbOEnFChFGOHDq4HOLH2oa2+shknCV0/hVjZLcpVVPOjhldJUNMMPi610uKOYsh2Uo
 NStf8eeZxpw/KT4+8J5XS0MUZzD6e6/M9f6H/qvUX6uMd1erUHbHWoysCX9cchT4fW6V9FUuB
 lRfbhltW6XM2+NT2PW82A08GpOgHH5g3JB0I2hABhMS6bYK6whwqEqoCOP2sLg7d1nBbyKjcB
 yPdSmCja5IHOi3miXbvXqWK+zQextxX6Jz82YTGJDmCBnOUGn3K5wE8osO3w8OAPw+JyFW5En
 /YyF5GiVwlLWQ7wYsVo2qE59cougi2yYiUEwYs+UWGtkifyf5I6CZV4cwIQEg1KDJJBzWuZpW
 iCNrCBgAqndXB5FOEEEhbi12V+IPuPOcS1G6rfCt4cdPcGF9uuAcMrFfVR+jLr5S8/BjCuN23
 CQLpp7lqnLFovXO6ecMy4D1ot0tttzmpztuLMh7geUtOpA9TPcdEtHVALdgOPxuoQC/kVNj11
 HZVBVS3cSODGoUl+ZpH9sXicqiuqKOfw1w9IUG17KDxVm2VVDlCPhMaiVfe5wDh+H1ZBNNmzM
 6+KEZy6nqyBeobvImpOuVgn9BhB5kAtMoDI/dHr4URR5rKVvOCEkIhVG/tLsrqIpK4eiiWKrl
 JpMZ3jDgQzhbQQqDtSD9IfofeEjfaZITYZyWb0VS6q/QvG16JesErW9Dmlpcqs5gFEt9pdEZh
 jwVAcHYjpPsAuOqArzlklvNUgDXJnI5jGmWEtebkUJPIRb9dtftOA1JW2mcyl0Gph+hhuqwsP
 GB44OzGsEDo8S857d
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQoFB5wIvIieQ4mxVzeaoqZPyceDooo1a
Content-Type: multipart/mixed; boundary="fMl1LfwGDKJFQt5tXVpN7PUVcrDgulIDq"

--fMl1LfwGDKJFQt5tXVpN7PUVcrDgulIDq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/17 =E4=B8=8B=E5=8D=885:39, Graham Cobb wrote:
> On 17/02/2020 06:16, Qu Wenruo wrote:
> ...
>> [FIX]
>> This patchset will add more cancelling check points, to make cancellin=
g
>> faster.
>=20
> I have a question on what this means for users of the balance ioctl.
>=20
> I *think* that, today, there is a guarantee that if I issue the ioctl t=
o
> start a balance, and then immediately (or, some time later) cancel it, =
I
> will be guaranteed that at least one block group will be balanced.

Nope, even for the original behavior.

The original check happens before we relocate one block group, so even
for the old behavior, you can still cancel the balance before it even
starts.


> In
> particular, if I repeat that behaviour, the balance will eventually
> complete.
>=20
> Is that true?
>=20
> If so, what happens to this guarantee with these changes?
>=20
> I think, from your description, that the cancel can complete without
> even one block group being balanced. Is it guaranteed to have made
> progress on that bg so that if I repeat the behaviour that bg (and
> eventually all eligible bgs) will be balanced? Or is it now possible to=

> cancel before any progress has been made sp that process never finishes=
?
>=20
> If the latter, how long do I have to wait before cancelling to make sur=
e
> that progress has been made? Is there any way to know whether progress
> has been made when the ioctl completes with the cancelled status?

The ioctl itself already has the status recording how many block group
has been relocated, and the bytenr of the last relocated block group.
These behaviors haven't been changed by this patchset.



Thanks,
Qu

>=20
> This is a real question because I have some filesystems where balancing=

> a single block group can sometimes take tens of minutes, and the system=

> is impacted during that time. I already have my btrfs-balance-slowly
> script which allows me to control impact by not trying to balance the
> next bg for a while, so the system can recover and progress other tasks=
=2E
> And it would be great to be able to limit the impact further by
> cancelling during a single bg, but only if I can be sure that progress
> has been made and that by repeating the process I am guaranteed that it=

> will eventually finish.
>=20
> In any case, I suggest that the patch cover letter (and maybe code
> comments) explains what guarantees (if any) userspace is given.
>=20
> Graham
>=20


--fMl1LfwGDKJFQt5tXVpN7PUVcrDgulIDq--

--KQoFB5wIvIieQ4mxVzeaoqZPyceDooo1a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5KYoAXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjIZwf8CRnUoFgNwTNI5xN/6wFDyTY+
nWB8Jgsgnwn4pYE/mwhDSpXFVIdNmxP/luRviNa8ic/wRGrWEE5Idr/M8r3D7a9A
zLBE7NTclyA8kZ5k62GrmfAQzZzVk/YbPY1rWNt9SK57hD/8XUgTB4Gr1bx1OqVD
Dvn1eLROxlWLrzJtwpFyvY3brt9NfBTuZeqqgfxIik0KLuL8nJXG+5VFPqWW2wxU
PpJMaPwb/YissH8l6t5SuovXgGnj2BM4StaEGBn12ftmdjzRSmtxqWLZmsM8WKZc
VwBUMbD93S6/6otYdQJqcVlvsgubpi5BK5JKPEam2MxxGkFcsqA3TpaDa8g4GQ==
=VTBH
-----END PGP SIGNATURE-----

--KQoFB5wIvIieQ4mxVzeaoqZPyceDooo1a--
