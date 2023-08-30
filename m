Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A478DA5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Aug 2023 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjH3SgK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjH3STJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 14:19:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD5198
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1693419537; x=1694024337; i=jimis@gmx.net;
 bh=u3qLto2RhCCQHa4DegebNACGbUXrBMHlBylOLqeybJA=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=toHkWxbrRJ2nuo32fpe9hBrgZJ2/Q0B1J7kxuguFuoHUadzHQqeDlD1UMZSKKmYsMvhjnZd
 9JsRUozBNq7h+4S2Q9Qxk74fSKQyPwPNc2fdSUwb2f9Q4PQ3f/koHoIdlh18NKndH3tmXUuAR
 hlWtwtuvhK/5cecZKKkzwHrGAIOZah3k7XhieWIkmLPDaWIw9UlzZ9LB6wIOex9qvT4AOQVqs
 TDT9TkSFpUMTMcjSMYiN/+83Rrxw2K3SmPWzgA/w3dkQTHmnjrmKShEPqBr5I88IeOkO08TJ6
 pAQyVW0nVG9gbZBb+be7l22xjJ6xmIb9D3L7mSp8xcSbnZPj/CAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.65] ([185.55.107.82]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1qJKxn0KCA-00IHgU; Wed, 30
 Aug 2023 20:18:57 +0200
Date:   Wed, 30 Aug 2023 20:18:56 +0200 (CEST)
From:   Dimitrios Apostolou <jimis@gmx.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: (PING) btrfs sequential 8K read()s from compressed files are
 not merging
In-Reply-To: <da72818c-6327-44d3-aee8-a73e7ee42b65@gmx.com>
Message-ID: <ea6bde1e-1181-6bea-bc82-12d8225952ef@gmx.net>
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net> <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net> <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net> <ZMEXhfDG2BinQEOy@infradead.org> <62b24a0c-08e9-5dfd-33a6-a34dd93b1727@gmx.net>
 <da72818c-6327-44d3-aee8-a73e7ee42b65@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-873968584-1693419537=:12568"
X-Provags-ID: V03:K1:TH/wGteEAMEr5bfi9rw7z1Rq1jigVHDE7DuUOxl2KwpKfi1ApkC
 LJqidgoWqYj0V5lBMsNANDkjXSyAoKJRKi4JI+gXv0VGaKvXvg01MQbRCci2ibSFC4cxo9v
 q3OcJjYywuspJPq5zwQLgsHArED+7YuoLHoyhoFFRv3wgCUWsiH23prNyFAsG+4TLt/z5RZ
 89CocdWqbgvqzJ7XH9oKA==
UI-OutboundReport: notjunk:1;M01:P0:EVFShTwR0mc=;507GOkkaGx3nm1v9eqOQ8x0DiAb
 BkEAqmORx+A+FE+NczDFMPSAwzGKRBQRvrRGkvPtd1NqbVTzJDME/9Dn7jISZ5VBjIcgxC2c2
 HKpzJ645eIO8IBC4hYgXmL+IVKio/BDYdUAVrQXsMxBuVSSw7t58AekAbqqH1YrLWhfgiLy6E
 C4GQq0Z2BGEKuBNHMV0Gm8hIHgce5j8wd0nZ/oSBFFMynzz4mscLuMTz8O6w5MfKbsJXvQ7hb
 eUkNK2D4Po9S59+ISuxJznAi5pjqUPDfSEw6/CTupL7R8RcLoNqGoBW3iKAuYT3BCIFXYFiKH
 BCDfVow1+ctIl9zZCu4l0o0X+QEYhipCEnjDyY2Fx57fpUpyvGYs9OWhgxOXfQ+ir94Ksfh4y
 XRW7pyXflXSRRoN9/MtU8rPCbsVBwqjHEDE9rAZ2h4ZdEYrshQPaFxrL2GD9RgW4lKW+4XOtj
 lU2bi5MTeFE5VmSor/T4f96CG7eMHk9Zy4LuU4l1QiBZi9NBCT+8R38Oe6QZF+/wiWJ+rBooL
 HHA0NeKgKekwXUAoQp5TSyf6BdlpNK2SjRBsJlSRN1RysdQYDzhp+EQJCUW3Yd1j4jC4FuQfD
 47st+d2pwzKJgEqZgGd89QgeF7kpmJgVV55gpX4Dl98K7LgfmiwLRUFpbxjpo2DSV5KiIVeJO
 eYHIL9Z8tl+qGYdRcEfq1FqrvyPVCpTgq6LxZloLJA0uSFg669sa7CFN6wivKSBe91wnq+uNa
 DUpuUNkHdORhQtZh1VouG79kyUc13nChWBJC7qnZME6ITkMHLZQ/D1MzcGF5WoD6Rh0PjhM1/
 BFiw8jVbdNRqOfmW1OfCPGmjg9KqV9tN+J994D6NHtEipHULe+yoAfAy6ckKncy2IoSr0hONo
 wzF7BuAuJQ929yhW6zfsqMNNFuEqNg16Qr7ZCW5BWQGSmDtdl3V68nNz9WbtSYqmAhFWRh9ck
 Puyabw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-873968584-1693419537=:12568
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback!

On Wed, 30 Aug 2023, Qu Wenruo wrote:
>
> On 2023/8/29 21:02, Dimitrios Apostolou wrote:
>
>>  a. Does it store only the specific 8K block of decompressed data that =
was
>>   =C2=A0=C2=A0 requested?
>
> If it's buffered read, the read can be merged with other blocks, and we
> also have readahead, in that case we can still submit a much larger read=
.
>
> But mostly it's case a), as for dd, it would wait for the read to finish=
.

This is definitely not the case in other filesystems, where I see blocking
8K buffered reads going much faster. But I understand better now, and I
think I have expressed the problem wrong in the subject. The problem is
not that IOs are not *merging*, but that there is no read-ahead/pre-fetch
happening. This sounds more accurate to me.

But this brings the question: shouldn't read-ahead/pre-fetch happen on the
block layer? I remember I have seen some configurable knobs on the
elevator level, or even on the device driver level. Is btrfs circumventing
those?


For the sake of completeness all of the read()s in my (previous and
current) measurements are buffered and blocking, and same are the ones
from postgres.


> One thing I want to verify is, could you create a big file with all
> compressed extents (dd writes, blocksize doesn't matter that much as by
> default it's buffered write), other than postgres data bases?
>
> Then do the same read with 32K and 512K and see if there is still the
> same slow performance.

I assume you also want to see 8KB reads here, which is the main problem I
reported.

> (The compressed extent size limit is 128K, thus 512K would cover 4 file
> extents, and hopefully to increase the performance.)
>
> I'm afraid the postgres data may be fragmented due to the database
> workload, and contributes to the slow down.


=3D=3D=3D=3D Measurements

I created a zero-filled file with the size of the host's RAM to avoid
caching issues. I did many re-runs of every dd command and verified there
is no variation. I should also mention that the filesystem is 85% free, so
there shouldn't be any fragmentation issues.

# dd if=3D/dev/zero of=3Dblah bs=3D1G count=3D16
16+0 records in
16+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 14.2627 s, 1.2 GB/s

I verified the file is well compressed:

# compsize blah
Processed 1 file, 131073 regular extents (131073 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        3%      512M          16G          16G
zstd         3%      512M          16G          16G

I'm surprised that such a file needed 128Kextents and required 512MB of
disk space (the filesystem is mounted with compress=3Dzstd:3) but it is wh=
at
it is. On to reading the file:

# dd if=3Dblah of=3D/dev/null bs=3D512k
32768+0 records in
32768+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 7.40493 s, 2.3 GB/s
### iostat showed 30MB/s to 100MB/s device read speed

# dd if=3Dblah of=3D/dev/null bs=3D32k
524288+0 records in
524288+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 8.34762 s, 2.1 GB/s
### iostat showed 30MB/s to 90MB/s device read speed

# dd if=3Dblah of=3D/dev/null bs=3D8k
2097152+0 records in
2097152+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 18.7143 s, 918 MB/s
### iostat showed very variable 8MB/s to 60MB/s device read speed
### average maybe around 40MB/s


Also worth noting is the IO request size that iostat is reporting. For
bs=3D8k it reports a request size of about 4 (KB?), while it's order of
magnitudes higher for all the other measurements in this email.


=3D=3D=3D=3D Same test with uncompressable file

I performed the same experiments with a urandom-filled file. I assume here
that btrfs is detecting the file can't be compressed, so it's treating it
differently. This is what the measurements are showing here, that the
device speed limits are reached in all cases
(this host has an HDD with limit 200MB/s).

# dd if=3D/dev/urandom of=3Dblah-random bs=3D1G count=3D16
16+0 records in
16+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 84.0045 s, 205 MB/s

# compsize blah-random
Processed 1 file, 133 regular extents (133 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       15G          15G          15G
none       100%       15G          15G          15G

# dd if=3Dblah-random of=3D/dev/null bs=3D512k
32768+0 records in
32768+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 87.82 s, 196 MB/s
### iostat showed 180-205MB/s device read speed

# dd if=3Dblah-random of=3D/dev/null bs=3D32k
524288+0 records in
524288+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 88.3785 s, 194 MB/s
### iostat showed 180-205MB/s device read speed

# dd if=3Dblah-random of=3D/dev/null bs=3D8k
2097152+0 records in
2097152+0 records out
17179869184 bytes (17 GB, 16 GiB) copied, 88.7887 s, 193 MB/s
### iostat showed 180-205MB/s device read speed





Thanks,
Dimitris

--0-873968584-1693419537=:12568--
