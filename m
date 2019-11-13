Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CAFF9FF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 02:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKMBNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 20:13:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:51247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfKMBNq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 20:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573607544;
        bh=06B7h/QUU8f+7n5awd0tt1Csz+UIqPEsP+M9CCqlYMs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YwVWyM8pYXS0WPYGkzFIzWQY95FxwLJO2+Ep6/ghgqAC9aVqPSMA40ukBabGLwofp
         VBQnidISaU7hdLG8Fd84JysfE2fBk0rXi1yRNNgTSmxQGqLwWI4GJ6BME0HlF+0n8B
         DWCWpcEML/KgFW9PQVbmSVvHmks5b2ylrD/PqJXQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvrB-1hydlz0ffB-00hQeW; Wed, 13
 Nov 2019 02:12:24 +0100
Subject: Re: [PATCH] btrfs: mkfs: Make no-holes as default mkfs incompat
 features
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191111065004.24705-1-wqu@suse.com>
 <CAL3q7H5nA4JqKSj90pYjB2_1trRtWva_oCYst62zMGc_cLzTFQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5d0cb16f-73a9-2678-349f-5d19a59e54ca@gmx.com>
Date:   Wed, 13 Nov 2019 09:12:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5nA4JqKSj90pYjB2_1trRtWva_oCYst62zMGc_cLzTFQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8mH4GLdyRZWjZjb1e2VVbvHLtOqYtg7mn"
X-Provags-ID: V03:K1:7x4EC/cuA9d14iRu5bKws5c5MFcp1X1fvg0whRH6/oXQP0jdhml
 bzR4U6N17sUZMtNvWM4zw1DrGDjzaoxHJ6Xgv8HBjgJDi/oYaOgnQP9hs6OH0np6DSIuv5G
 cgAq+Fg9McxT63F2lamsqyp647ZPk+PUopPRnEA9iKefJXldtREzuDtcmYMa/GEpqidXky6
 9qrRWIJVEpv5gDbM3Ubwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U3fd/6Z51uU=:L0UEt2vTwsawxoIYsjHgIp
 7p4jZhOkvzWK04LzdQi5inuHz3hKRbSCJoskma4qEmw6chZFN9SoyAq+s1SzI3ghvZDlAN9IT
 btvLcckmDLD72/W3lxg1zbWVHjGLCvPyv/irPJVhp9KRrsgcaCTytiogNGf7Xze34qOIdsiJu
 vyJPNYlmMBfydbcEIUwI7VF/qGa5fY56t4MI3+ZkQpWNgt6jpIlLEHgPHcWyLsaQhe+3PscQa
 3l53ruCbkEepZ/IjuAPJdxu2ouqPay8s0gVbCjxgYnJIF7UKA6P/RMoEQAhVlFxsQN2/0VsWb
 b1SsFwxgPy8yYo+6HXxG+FoMSBfqUPwsVcgTRa1Y0h5BEPF2oOcfEbRb6P8eAANshrAqHSi6y
 2ImbQXe6ckGeeaPAmgnAfbHET3VLEqwJ4l8WFlZLQa5oEu+Nnlh+JEfkA4wyi6OsoMGC+fsSA
 jyFaXSbZ5dMJRc1mTUuYPm5VcDr9C6ZvPEGM67CgKtouLZyfISKfx4YGhrzH0qqkixbevirSE
 Ki1Z4aXG5b37tWNVL6uqKe1v8H8OnZl6k6sLY4T7ZvxQOz1j3kCAmsupONFXZR2aMqTbkFiiZ
 tqQKUe7s9E0UNkMXliNWjyB5VUiEtByL1F2/ZhFMzbDEphXgbPQREIVFYm4cUMy1GgH3X4sWG
 89h4JP7qBx07JhMUrtl2Zu27SCGaxef6Q/67eQA+R8NdhVwXh/AeUk2DLSnWmb6n6JYfJOC5k
 YTsjw7m4QmwvNPSl9LoKUP+k9zaoc+QvGBaLt7fu7VR9FEFv5q5x65qNmeBh1Cy8zL8RLp4N8
 H7Tiq+AxGIEQeyRuw3GmK6xJ506+exxUXsvjom5ayWCDjD+cVtkgmc/gh7yd9PgoHfd/h/XUL
 /X8VbtNTfPRdzgIy38l2PnaxOIZ+IhccmoLl4+9Fs3HbDHzKKw74NPSv8EA7bxHEROI95iIml
 PDxwDELCuCekVmPJsPootzi9Nj3oWh4in2PxJiHNrMqy7Y+ROFWXfNqOBQACjdkpli1YQLdY+
 gAFQgenEW4FI3WTlp8b6gIh0oNnV2+s7W84OFN85s24CvPrTve76tVtJhlzpeDEqmMconXfwl
 DEO4SjJ8+hfk/B9kXuGUWaif15zPUA281rORIpEdM5aQ3k3LrCugqkysgPSdVOZgNjKZqgVnI
 oyw7vtrrSxWuM/UaO2Frg+g2baAUdM12SEk2T93j3pCGfQ9Tm9rqigRSQeVLhVbnPIw4TW+Nt
 9arz+O062FNNK99wisSpSoZXoB0lopERzstd5yuQJK5droLnraNCu9DJAhQQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8mH4GLdyRZWjZjb1e2VVbvHLtOqYtg7mn
Content-Type: multipart/mixed; boundary="JZThNbmQSHIFeFAknGSZS1kXgD9k8jI6r"

--JZThNbmQSHIFeFAknGSZS1kXgD9k8jI6r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/12 =E4=B8=8B=E5=8D=8811:19, Filipe Manana wrote:
> On Mon, Nov 11, 2019 at 6:51 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> No-holes feature could save 53 bytes for each hole we have, and it
>> provides a pretty good workaround to prevent btrfs check from reportin=
g
>> non-contiguous file extent holes for mixed direct/buffered IO.
>>
>> The latter feature is more helpful for developers for handle log-write=
s
>> based test cases.
>=20
> So it seems your motivation is to get rid of the false fsck alerts.
>=20
> The good part of no-holes is that it stops using 53 bytes of metadata
> (file extent items) to mark holes. That's great.
>=20
> The not so good, but necessary, part is that fsck (btrfs check) stops
> checking for missing extent items, assuming that any
> missing extent item is because a hole was punched or as consequence of
> writing beyond eof.
> So any bug that causes a file extent item to be dropped and not
> replaced will not be so easy to detect anymore. That can make
> bugs much harder to detect, such as [1] for example, which is the most
> recent I remember.

Indeed, that would be much bigger problem than false alerts from btrfs
check.

>=20
> I have been testing this feature regularly since it was introduced way
> back in 2013.
> Since then I've fixed many bugs with it, mostly corruptions happening
> with send/receive and fsync. Last one fixed was for send/receive
> earlier this year in May.
> And I have yet another one for hole punch + fsync that I found last
> week and I've just sent a fix for it [2].
> As I don't recall anyone else consistently submitting fixes or bug
> reports for this feature, I don't know if I should assume people
> (users and developers) are testing it and not finding issues or simply
> not testing it enough (or at all).
>=20
> We started having a lot of false positives (fsck complaining about
> missing extent items) from fstests test cases that use fsstress since
> fsstress was fixed to
> use direct IO when the test filesystem is not xfs [3]. In an old
> thread with you [4], I remember pointing out that most of such fsck
> reports were due to mixing buffered and direct IO writes.
> So using the no-holes feature is a way to silence the tests. However,
> are we sure that at this point all such fsck alerts are because of
> that?

That means we need extra tool to not only to verify the data, but also
the extent layout, normally something done by btrfs check.
Not something we can easily handle in current test suites.

Thanks,
Qu

> When I looked at it after the fsstress change, I couldn't find any
> case that wasn't because of that, but since then I stopped looking
> into it, both due to other priorities and because it's very time
> consuming to check that.
>=20
> While I'm not against making it a default, I would like to know if
> someone has been doing that type of verification recently. I think
> that's the most important point.
> Just running fstests with MKFS_OPTIONS=3D"-O no-holes" is not enough IM=
HO.
>=20
> Thanks.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D609e804d771f59dc5d45a93e5ee0053c74bbe2bf
> [2] https://patchwork.kernel.org/patch/11239653/
> [3] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3D=
b669b303d02e39a62a212b87f4bd1ce259f73d10
> [4] https://www.spinics.net/lists/linux-btrfs/msg75350.html
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  common/fsfeatures.c | 2 +-
>>  common/fsfeatures.h | 5 +++--
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 50934bd161b0..2028be9ad312 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -84,7 +84,7 @@ static const struct btrfs_fs_feature {
>>                 "no_holes",
>>                 VERSION_TO_STRING2(3,14),
>>                 VERSION_TO_STRING2(4,0),
>> -               NULL, 0,
>> +               VERSION_TO_STRING2(5,4),
>>                 "no explicit hole extents for files" },
>>         /* Keep this one last */
>>         { "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
>> diff --git a/common/fsfeatures.h b/common/fsfeatures.h
>> index 3cc9452a3327..544daeeedf30 100644
>> --- a/common/fsfeatures.h
>> +++ b/common/fsfeatures.h
>> @@ -21,8 +21,9 @@
>>
>>  #define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
>>  #define BTRFS_MKFS_DEFAULT_FEATURES                            \
>> -               (BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF           \
>> -               | BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>> +               (BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |         \
>> +                BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |       \
>> +                BTRFS_FEATURE_INCOMPAT_NO_HOLES)
>>
>>  /*
>>   * Avoid multi-device features (RAID56) and mixed block groups
>> --
>> 2.24.0
>>
>=20
>=20


--JZThNbmQSHIFeFAknGSZS1kXgD9k8jI6r--

--8mH4GLdyRZWjZjb1e2VVbvHLtOqYtg7mn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3LWHAXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjIvgf/f3R2c9YG0JWJvd6gObJf9e7f
gUkNOHCPJ9h5ctTXSGskMPaed0odzjhZ47Z3XPUg1uLtO5RJd2dt0WVrRBNlE7w2
Vtexxd/qlHj1PbZ0JswoUGm9yQYiBCnzaKK7+vTU3h1EjhR4jN0gF7DFEF6Swcbr
L8Cby9KGd6gb1AXocbbPjyapRtyIp2CLN/XzLDQ5h3Z3HudbIJYB67IIXl4AZy6P
MTr3uE1wM7v2UY2vkycI8LeCovegIg4f4FZx3cGjvvwyQbqy2R4UrwJFZjTwrp1Z
vWy5/nwu4G3+C7isPKFCKeq+fqTMQt7BFt6vyyxmM7fFM1DyQpejnAJSfJqzcg==
=Au5f
-----END PGP SIGNATURE-----

--8mH4GLdyRZWjZjb1e2VVbvHLtOqYtg7mn--
