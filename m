Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91450131D69
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 03:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgAGCFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 21:05:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:39897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgAGCFK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 21:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578362704;
        bh=Bi5WFVO40ObgVviKYpxAahSW2hZeWNRxt762Ix+IPTg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fyitYVIqVGqEdW4g2iuZPSdS2Tfkk0nlI6Bplk8/ePGOLMYzLWhV1HyznDcbthaE8
         +j1UejEOPtGoBIR1ZlEbvHzmeH3oHDBMY6nxtn5SUjDjoJClxDOp1zGvFldcPiJ/ce
         z4R9AXi44mRzMxewsB01ixLFl1h178fIUQ1xetP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJhU-1jXZNb3l48-00jIlT; Tue, 07
 Jan 2020 03:05:04 +0100
Subject: Re: [PATCH v3 0/3] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106140615.GE3929@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <fd099bc6-512d-ace3-3f57-b532f4fc7479@gmx.com>
Date:   Tue, 7 Jan 2020 10:04:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106140615.GE3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ggpLIjCIuqnBAq9Ttq2m8SOmhQO6kPUz4"
X-Provags-ID: V03:K1:N92fwlmUJ3cUiXIpMVyKTsxtgZMsry3QnxWPV0fbtEiUeC341K3
 Y5Msv1YJZEtQs4yn75Jj+SsX/Bw1shBT9npzx+CkA8tQJajuQw/u7bLm4rp2jEKED26LSWV
 29EyyHFL9HDVIHRTq+d9e9KLWUTWePSFLIN+X3mXd13a/gLgANA0cLLLRl8UjnHe7poetl5
 PnjF5HIq6/D5h28dK+TfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YSHS6TMN0LQ=:eGcQBJlYhq8al6R9sucvwD
 I33zVbMeNH6bwK4qUJta03Gf14ijluFFETn08QZi+GkKS/dpzmYC1dkj+KY8wjZLl+UW3nvfv
 m8hirS0tEQDOihRRrtx6EpbV4Pkc2eO6GLa6GA6eSruG2ZnbMin8s3DnfOHgciJVdBC+laHsM
 Vvqhcfi/HPzl/feU6tDgMNnTs232OEezEylb8S8FGDpjjxL6a64a3j8Hjp0CKZLEPE6UVG5ff
 0V8ypTwV2qWFVM1aaLBvLliT8T690vvt1kjnZkzWOrssW3qA+oBVWmkhJC1AtzePztpJ2a3cY
 KfAVWmOv2UBaaUlw1knaBZi1E/xl4HvqT9RTbzlT979up0pOw9TSZmURXN+Q6sjCmGxZk83Zd
 Qvg3qg60q0v+9JCSNpit7mYxJ/jum/+Dsdt1EU6KDz/ZwfifL0kD2vO+PJlYaWoTe2+DR5iI5
 uPC/Eaf3uLZQORV0fyS3AuLDOZ9NcXwE2g4wS355DgV0bSjVXlxbu0OQYnaxzra5yOV073MK2
 f4v3fNc2lyidvxfrKNWiW/yqE23y229uUHb12MjcuiVYtOFY1OtxyfLdQm+ni/GRyz7gwxRff
 3Tsr/GekQhOcw4wSng1M5hnhe4JBxgwmIQo3HdCTuuyRdeqtblbz70a//tqK9DUb1LLWeqBqf
 +ph7dDGLdyjJ/WhfNQuS9hi2r/B3V2Hq8ckaz5Lg2hEsIhjIClq0X4xKs7gDfUGK3oQl6t2fs
 XnymNMtJQRU/C9TolepGoQylZmZL68cRavkqfJDN3NRL0PTL2uHNPS4t26myFMjTCywruA95S
 7oqEuffsgtHYY9pSEFs3EyZk/pDcq7fSMpdgVIDTsxRiGBreANGYduKmBkrOho/2ojMAkj4OZ
 DEXAutxCF6qyX0F4uB41gwHR27psZmzrO9TUc5R3neoItmOzhtcjGcOZBc3Ziw60jNapob41B
 G2aILGaqGuuRPhdup5lqUDhM3onBaNc2PaI9TvYkvfiEbxOIG9Pm3v8cbCwaVwF7nmjZguDYn
 BszQb0nOkVpJJmCszF8JrVqLeHvhRViKrGfO9bNhag7GLwCiRr7OsyhqEcvxyqC9WBS1ybU9i
 duDETa4PouhwlX7vbVdsaItylemzcBdX4XwozI7t/Su1OTcuBMxST2HU/De59xDa+DikVrHTL
 46U6/yMF7wbdeBm+S+WlgyrAFkf5cy3qdbI+52JAtX+s15G+zdNar7xOHu2vx3lfH92do9nGK
 gYqw5rogPAmVmQ/EJrqmet3/2GEon/9THvz6nHQDX7FdZld9J6tqt8S8i3FM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ggpLIjCIuqnBAq9Ttq2m8SOmhQO6kPUz4
Content-Type: multipart/mixed; boundary="6ZGkKmaAvj0g7AzdQfbQa2O65JyxFT247"

--6ZGkKmaAvj0g7AzdQfbQa2O65JyxFT247
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/6 =E4=B8=8B=E5=8D=8810:06, David Sterba wrote:
> On Mon, Jan 06, 2020 at 02:13:40PM +0800, Qu Wenruo wrote:
>> The execution time of this per-profile calculation is a little below
>> 20 us per 5 iterations in my test VM.
>> Although all such calculation will need to acquire chunk mutex, the
>> impact should be small enough.
>=20
> The problem is not only the execution time of statfs, but what happens
> when them mutex is contended. This was the problem with the block group=

> mutex in the past that had to be converted to RCU.
>=20
> If the chunk mutex gets locked because a new chunk is allocated, until
> it finishes then statfs will block. The time can vary a lot depending o=
n
> the workload and delay in seconds can trigger system monitors alert.
>=20
Yes, that's exactly the same concern I have.

But I'm not sure how safe the old RCU implementation is when
device->virtual_allocated is modified during the RCU critical section.

That's to say, if a virtual chunk is being allocated during the
statfs(), then we got incorrect result.
So I tend to keep it safe by protecting it using chunk_mutex even it
means chunk_mutex can block statfs().

Another solution is to completely forget the whole metadata part, just
grab the spinlock and the pre-calculated result, but that may result
more available space than what we really have.

If the delay is really a blockage, i can go the pre-allocated way,
making the result a little less accurate.

Thanks,
Qu


--6ZGkKmaAvj0g7AzdQfbQa2O65JyxFT247--

--ggpLIjCIuqnBAq9Ttq2m8SOmhQO6kPUz4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4T50kXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg6RQgApDCR9BHncIU1vJz8vC5IDXyI
bweJYI98l5iARkWCJVncTNd0PCYwPL2aaR+PHzckPhOIsEoVAmHbfcvZxiGuXnNp
pxILw1zpDlOyHFHhJlTBwzni1r7920tnWZ7/X29BmNGGOGS2BMv9N9w88JBxEirQ
uOOs+oDZKxf8FVZowFPW3n4wIQWNcnblYQoEqhjTfTe1t9sqN+NkCh3zr7XCbGYD
YOZcFjEX3NdfVzgp5yvzeSQCFNrKeX2in7z5uwVGxhhRrXIzKo8DVsJyY560DetT
iCUHbLngE54FEc1gT5AykaPKbRdigrk0TJAr8j5CoPh5UAFY1+Y6c/wBer+GSQ==
=qm0D
-----END PGP SIGNATURE-----

--ggpLIjCIuqnBAq9Ttq2m8SOmhQO6kPUz4--
