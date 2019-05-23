Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB59A28223
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfEWQG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 12:06:57 -0400
Received: from tty0.vserver.softronics.ch ([91.214.169.36]:44298 "EHLO
        fe1.digint.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfEWQG5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 12:06:57 -0400
Received: from [10.0.1.10] (unknown [81.6.39.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by fe1.digint.ch (Postfix) with ESMTPSA id 777A530ACB;
        Thu, 23 May 2019 18:06:53 +0200 (CEST)
Subject: Re: Used disk size of a received subvolume?
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <20190516171225.GH1667@carfax.org.uk>
 <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
 <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>
From:   Axel Burri <axel@tty0.ch>
Openpgp: preference=signencrypt
Autocrypt: addr=axel@tty0.ch; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f5df69f6-300e-25c7-3d0d-0798f140dc8d@tty0.ch>
Date:   Thu, 23 May 2019 18:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bXCVF6mrgh7pFql7SwEk8M6epbsJC8Hvj"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXCVF6mrgh7pFql7SwEk8M6epbsJC8Hvj
Content-Type: multipart/mixed; boundary="wMBiUFeJGD68BEVut32JRsYNQkgaB8vOh";
 protected-headers="v1"
From: Axel Burri <axel@tty0.ch>
To: Graham Cobb <g.btrfs@cobb.uk.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <f5df69f6-300e-25c7-3d0d-0798f140dc8d@tty0.ch>
Subject: Re: Used disk size of a received subvolume?
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <20190516171225.GH1667@carfax.org.uk>
 <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
 <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>
In-Reply-To: <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>

--wMBiUFeJGD68BEVut32JRsYNQkgaB8vOh
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 17/05/2019 17.28, Graham Cobb wrote:
> On 17/05/2019 14:57, Axel Burri wrote:
>> btrfs fi du shows me the information wanted, but only for the last
>> received subvolume (as you said it changes over time, and any later
>> child will share data with it). For all others, it merely shows "this
>> is what gets freed if you delete this subvolume".
>=20
> It doesn't even show you that: it is possible to have shared (not
> exclusive) data which is only shared between files within the subvolume=
,
> and which will be freed if the subvolume is deleted. And, of course, th=
e
> obvious problem that if you only count exclusive then no one is being
> charged for all the shared segments ("Oh, my backup is getting a bit
> expensive. Hmm. I know! I will back up all my files to two different
> destinations, and make sure btrfs is sharing the data between both
> locations! Then no one pays for it! Whoopee!")
>=20
> In my opinion, the shared/exclusive information in btrfs fi du is worse=

> than useless: it confuses people who think it means something different=

> from what it does. And, in btrfs, it isn't really useful to know whethe=
r
> something is "exclusive" or not -- what people care about is always
> something else (which is dependent on **where** it is shared, and by wh=
om).

Agreed. Sadly btrfs-filesystem(8) does not give much information on how
"exclusive" should be interpreted.

> The biggest problem is that you haven't defined what **you** (in your
> particular use case) mean by the "size" of a subvolume. For btrfs that
> doesn't have any single obvious definition.
>=20
> Most commonly, I think, people mean "how much space on disk would be
> freed up if I deleted this subvolume and all subvolumes contained withi=
n
> it", although quite often they mean the similar (but not identical) "ho=
w
> much space on disk would be freed up if I deleted just this subvolume".=

> And sometimes they actually mean "how much space on disk would be freed=

> up if I deleted this subvolume, the subvolumes contained with in, and
> all the snapshots I have taken but are lying around forgotten about in
> some other directory tree somewhere".
>=20
> But often they mean something else completely, such as "how much space
> is taken up by the data which was originally created in this subvolume
> but which has been cloned into all sorts of places now and may not even=

> be referred to from this subvolume any more" (typically this is the cas=
e
> if you want to charge the subvolume owner for the data usage).
>=20
> And, of course, another reading of your question would be "how much dat=
a
> was transferred during this send/receive operation" (relevant if you ar=
e
> running a backup service and want to charge people by how much they are=

> sending to the service rather than the amount of data stored).

I actually meant "how much space is taken up by the data compared to the
previous received subvolume", or any similar question which gives
insight on how much disk space is being used over time by send/receive
backups of snapshots of a source subvolume.

After a couple of years of running btrbk I have many backup subvolumes,
and I want to be able to get some statistics on which ones eat up how
much space on disk.

> That is why I created my "extents-list" stuff. This is a horrible hack
> (one day I will rewrite it using the python library) which lets me
> answer questions like: "how much space am I wasting by keeping
> historical snapshots", "how much data is being shared between two
> subvolumes", "how much of the data in my latest snapshot is unique to
> that snapshot" and "how much space would I actually free up if I remove=
d
> (just) these particular directories". None of which can be answered fro=
m
> the existing btrfs command line tools (unless I have missed something).=

>=20
>> And it is pretty slow: on my backup disk (spinning rust, ~2000
>> subvolumes, ~100 sharing data), btrfs fi du takes around 5min for a
>> subvolume of 20GB, while btrfs find-new takes only seconds.
>=20
> Yes. Answering the real questions involves taking the FIEMAP data for
> every file involved (which, for some questions, is actually every file
> on the disk!) so it takes a very long time. Days for my multi-terabyte
> backup disk.
>=20
>> Summing up, what I'm looking for would be something like:
>>
>>   btrfs fi du -s --exclusive-relative-to=3D<other-subvol> <subvol>
>=20
> You can do that with FIEMAP data. Feel free to look extents-lists. Also=

> feel free to shout "this is a gross hack" and scream at me!
>=20
> If you really just need it for two subvols like that
>=20
> extents-expr -s <subvol> - <other-subvol>
>=20
> will tell you how much space is in extents used in <subvol> but not use=
d
> in <other-subvol>.

Thanks a lot, your scripts are very useful and answer my question.

While I love their bashyness, I re-hacked parts of it in perl last
night, so that I can use it within btrbk (not sure though if I want to
unleash this to the masses, as many people will mis-interpret the data
and shout at me on how slow this is).

Here's what I got by now:

  # git clone -b extents-diff https://github.com/digint/btrbk.git
  # ./btrbk extents-diff /home --dry-run
  # ./btrbk extents-diff /home
  # ./btrbk extents-diff <subvol>...

If called with a single argument, btrbk looks for all related subvolumes
and prints the difference to the previous one, sorted by gen (transid).
While this is usually fine for snapshots, parent-uuid chains get broken
for received subvolume as soon as an intermediate subvolume is deleted
(and thus need to be passed as additional arguments).

The hacky perl module is here:
https://github.com/digint/btrbk/blob/extents-diff/lib/Linux/ExtentsMap.pm=



--wMBiUFeJGD68BEVut32JRsYNQkgaB8vOh--

--bXCVF6mrgh7pFql7SwEk8M6epbsJC8Hvj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEGhZyjCOMCiVqHcFZjQOnykvjzX0FAlzmxRAACgkQjQOnykvj
zX3vJRAAmbp325w7NpgicJKK0HRmG7z4gP4tcTLiPDXdUfe+RkOa/W++sJgyUHc7
MdQrJbNQ7lme5fiY0+lf5XNjsN3RvglD8H/LgBYSJ35Y1wtfwsV+ozpN6UR7CcYa
raEDgGzrbCjVDTlpEgBaaDjodXBdkzFixMRRJSW+5QuYT2VuSvgT4XGPjL1OI+up
g8pUUfI3gy8lGvOMcx4QgT+ljw7Nbeg/4ZEQ58XzO94pk2C0HZirR9FZVZy0Uz7F
nzzw5ej9vdr5nO+8kG3PLBImKHIYZxnf1MPKAUDaRlBgrjXBDRcguzunB7jlOJuw
LSnBc4qa2wRwkLP7Fjd6zKZBrcA9ga746Eiev74QFvVzH84JWLqtzvlHUqTLqL1n
r7rfSskN4rzXdf9pr1BpLstpfNc6f4+9CO0ZpF7mHgMWwAwcDvCk2U3vhAq35X+G
S5tpvCCEpMz6sCVllES3qsOSj75oH7W4fcMP2f4+dv1dtZx3+Js0B75ixDzzcWlO
bNQ71V9fyyfbvq+/uCo6oIGvLBaxqUfW1aAz23QLmldNV+Hi4Y4S8gVjKKev2G1X
JN4hcTbT6SwxlCvUf/M+RbmNRdT9gsLQGVy33TkFNz3ziEczIWueBLUmCJ7t6tJd
dvm3bCfVwdDRJbHeDF2y5IHhXqP9Buw2giBi8FDp4EdzMl+R4BM=
=Skxb
-----END PGP SIGNATURE-----

--bXCVF6mrgh7pFql7SwEk8M6epbsJC8Hvj--
