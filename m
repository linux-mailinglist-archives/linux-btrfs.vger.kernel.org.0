Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0264B737AF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFUGAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 02:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFUGAx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 02:00:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E4C1733;
        Tue, 20 Jun 2023 23:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687327244; x=1687932044; i=quwenruo.btrfs@gmx.com;
 bh=/IFySJovnSKxAGnZWA1lIjZj5jNO4+MEPGiy2SGMLio=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=XiL1A9UwaeY1kMsMmXaFQ8v8gycCTkkipp8ZDEkWDNKrS5EamB0metrNNu59B86DPtdGJfi
 HFoPrbZ8htsIVMDtCXghTwUNi4EoyIjuN/cwEdtLVDAKctCylaKYkCBQ/o8+0thw2UV3WByMa
 W1w3A8Oby7itTA7obQscJLehwiptXRdSX7fIwipWJl+WT/DitzbPuTIP6I+lPxeHoYeZauCrN
 h7eHQ2OVCXtep+6m1clL6wLr1Nl5dA+g8uLexoi0UtCodJxLFWfxXPLlv2Vl0XOfQdGGrzMAr
 HAqT+tQ7P9TLte6nIjqrwQ2XcnxDt5J/+1lR4M4c+DU0ys8uvgqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1pplhz3yWu-00vOuY; Wed, 21
 Jun 2023 08:00:44 +0200
Message-ID: <790f7e19-a31b-c27c-570e-5e3125e4a1d9@gmx.com>
Date:   Wed, 21 Jun 2023 14:00:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add test case to verify the behavior with large
 RAID0 data chunks
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230621015107.88931-1-wqu@suse.com>
 <90714755-3b63-b95c-87dd-1a7ef785c461@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <90714755-3b63-b95c-87dd-1a7ef785c461@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XdJAtqeXnu2aiINzBq93qeUtBJFJE0g2P/sriJRD7Dtp/dmldZx
 wNFH7dzw4lTGTSnnbb83BAFrOumwg7Cb1ycnuisVh2Qb8b/QKy7XivA0kvJXKPDLnGiWcsS
 a5uXfL3itDqnubvkjZI/oUDxNgfJYoKUG/7XLqhyz26YpQbFC0DIurpxOgq8q6MloQ/fKHH
 H/VI3/5SGdYyXBPyQ257w==
UI-OutboundReport: notjunk:1;M01:P0:fMu6cngAFNg=;sXez1eZbKemgbpxXJOqM8hGSzbV
 8qCpDBHWQc/DGq4VoxEtL747STRDAarvUtnNoj1FIJD8isHj3VLaDNnCEytD5atPWtHYUN8L+
 D656W55iQf0fFXMa0UXkFUntKa96HJmRELvXrEgZsU5vthYHMP5CkC/tHWo/GVG28WdB7fRm7
 LZllJGHCt9qu0jr625ZuTeJcbR5Ka/izOsREdgL5wpJXdvRr/Ve4ZAwi34TX4qfDA0PxPlKKZ
 NhJeiwFx84sMr3KbqhKx28tgGh3zaou4fZ3dh1J0ZOqkKgiWbhtWPNHUF1ZreQLy95XZimaGU
 PVmmtNdgoQrqCCQzfa1BTQ17cYedKoTRK/VS5PF78Rt440tm1Va8ZmS4e2uX9A3k5U0qxhFow
 fK0cvqZ44d5fBV2HeD5p6Op4Bc1glZnAJoJCAEOUjCxfu7w2PdSwZHilF/Dd0arqi0uX1O01X
 xvtF7rU8bcKUHVu09cRc7HehcpbzJwgMzDaP0y8GsTUL/ARYJ8B/mdhSv/BOqfjbrN6kzBuz1
 bWS1kg/3Ol1x240Qv1Ezk79+4R2O4Eih4yTZDsnS1TYxmPrMEulGQ2YDaA+sGoh7V173PqRvj
 juCgWVizRkcNMPlX6Sta4ech9MrfF/afIPs645GY+1g8N+LH0w0wNmYfVJsU85gb4Lxks76Xt
 d4mtYouJLvowu8b1SVVDnkXbgVgvUQ4zd6abqvhj5xsLPu9n4wWN+mSDMvSVnlF9uJRSYB35y
 NthtiqsGiHgWIE9DYw/pdHYWjmNxcbFTlAChH4b8wEy5Dn/LrJVCkUb5aZgXQD1zKp1sWL2OP
 P3FMa3373q0kIofsFdhU3K7xlKwWxbN8bmGfvz+Notxe34JNjx5ZjN5vVhGobXn86K7t6GXjU
 q38pBSFCdsGmBBuqKSUeVfDVHoRXU66mUHkeh6znskWCzzN6+Fhm+AOpP6RDty5LHWuLseu7u
 pMUoqqPS3A5SAJGhw0kuf9BVe8A=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/21 13:47, Anand Jain wrote:
>
>
>
>> +for i in $SCRATCH_DEV_POOL; do
>> +=C2=A0=C2=A0=C2=A0 devsize=3D$(blockdev --getsize64 "$i")
>> +=C2=A0=C2=A0=C2=A0 if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; th=
en
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "device $i is too s=
mall, need at least 2G"
>
> Also, you need to check if those devices support discard.
>
> Uneven device sizes will alter the distribution of chunk allocation.
> Since the default chunk allocation is also based on the device sizes
> and free spaces.

That is not a big deal, if we have all 6 devices beyond 2G size, we're
already allocating the device stripe in 1G size anyway, and we're
ensured to have a 6G RAID0 chunk no matter if the sizes are uneven.

It's the next new data chunk going to be affected, but our workload
would only need the initial RAID0 chunk, thus it's totally fine to have
uneven disk sizes.
>
>
>> +=C2=A0=C2=A0=C2=A0 fi
>> +done
>> +
>> +_scratch_pool_mkfs -m raid1 -d raid0 >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +# Fill the data chunk with 5G data.
>> +for (( i =3D 0; i < $nr_files; i++ )); do
>> +=C2=A0=C2=A0=C2=A0 xfs_io -f -c "pwrite -i /dev/urandom 0 $filesize"
>> $SCRATCH_MNT/file_$i > /dev/null
>> +done
>> +sync
>> +echo "=3D=3D=3D With initial 5G data written =3D=3D=3D" >> $seqres.ful=
l
>> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
>> +
>> +_scratch_unmount
>> +
>> +# Make sure we haven't corrupted anything.
>> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full
>> 2>&1
>> +if [ $? -ne 0 ]; then
>> +=C2=A0=C2=A0=C2=A0 _fail "data corruption detected after initial data =
filling"
>> +fi
>> +
>> +_scratch_mount
>> +# Delete half of the data, and do discard
>> +rm -rf - "$SCRATCH_MNT/*[02468]"
>
> Are there any specific chunks that need to be deleted to successfully
> reproduce this test case?

No, there is and will only be one data chunk.

We're here only to create holes to cause extra trim workload.

>
>> +sync
>> +$FSTRIM_PROG $SCRATCH_MNT
>
> Do we need fstrim if we use mount -o discard=3Dsync instead?

There is not much difference.

Thanks,
Qu

>
> Thanks, Anand
