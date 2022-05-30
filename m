Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8ED53733F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 03:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiE3BUm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 21:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiE3BUl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 21:20:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC67357A;
        Sun, 29 May 2022 18:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653873632;
        bh=D6D+aeEtd8BoRfqtLkDUJGfISoWXzfWwKrjihrUg9kM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=XpGyAiwTlvQhGdXHOsp9TTaZ0gMQwIhU9T46jD+lipQ9j6SeZzYHmlaJoi/F6hsAj
         aIPFvI5LHUDsd1lnPneyY14OuODDucSXhKhJAJT4WcjkFq/p1wkiHfG6IADTfodvPc
         68pI72GOBrdhnMz5cnMvYUz+o+SIPlGdggEnorHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXuB-1oJUBM1nmZ-00Z0Wp; Mon, 30
 May 2022 03:20:32 +0200
Message-ID: <289c77f4-a2b6-d7e1-0114-dcb111d57f91@gmx.com>
Date:   Mon, 30 May 2022 09:20:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-2-hch@lst.de>
 <8bdaa753-ae46-88ec-09ce-0a5f86ea5b9d@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
In-Reply-To: <8bdaa753-ae46-88ec-09ce-0a5f86ea5b9d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pb5oApCbY/DqZB2plYbdIfdFNgYQ9yJNKNdvX7JIhdtMU7kS2n0
 PCByQbf9xFmKcIvnf/78D/ZrfqavQDhk1XRvFvkCOAL3igsUVqN84Un5pSVI1bgyQ12RphX
 Rn6R9Xzr+ta1FHORIWxNpO/KzOn+4v/0q1C4U0WdtLnhN9uFSMfwO7xLL+OLk2FdPiru1Bw
 JLM292HJyStnhvWgJLLXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:coStBQ83sQw=:YI3QWI+CvEejpVlFaGfrzY
 fbS7WHlqbPyFcc9V+5LhEljUAKyFX9XDmLsTyH2ZX/6zDB44NiQmnjW98GCeEwTsmy1b9bkQV
 LD7FDH/ZaB7VIVgx7C/4ptxB19Hqm10lc5CvmH3Tnfs5VdI9FKYmkG/+ol5AcpDEXLhL5Z7w+
 p+1o83v5dSafdelA22HNt3MS2+qukqo3A+cq+ar8ThmzIvVj7jzh48xCP9zQrcNSURsI7PAbj
 l7ZXuQuvd6m5ETU+7qW047cBQv1ZYYA4NQfXH94Tkdr1n7YgkpkHhs+NF9LGuWxum0bxLxDci
 XTNTyuPZYzGoAYnnQujU2WMtfc9A5RBk60F9nwWQ5YDPPCrUOdS0g0GeKHxTZxGa/HUyRqswV
 6yVj65R9R0R6P/0Pgsrnz01sIBwXGpuS//Le7JJp6ePT9NG/pB8cUuLqseO0B6FECx4J+YlZB
 NDB9kQYtZ3O+pwFdIk2OHyblPCQvwuEv7brvbRZmSBjLNg5W4e9A2OWjJh7xD6ZaUxM08e12p
 DQMJ67rKbQ910hBwQbSAYtodyRU8DVPGIMyF0M1Byx2cF2uyQNCHAHvEIi0B8vjswVvByREuG
 g6NWjdzvAa9an5w+KiHqmwY2WHYebzGgBNoWJNTBG7MaODmXqvuBe+bqd78qZ/wjv1kEVZ19x
 Md03EsvCbtyLcoamqKiqIReV7+s/llUgJxzukmZWNGPS32RdbVFH4WxylZCcbzQgs2YC99PX7
 jb/9Sbik4JucfGVg7PKiqzMSrE8Ssro4YJjmzzjWoQ44dorJMdt7lkAoAnRRT1aA9MggR7fRv
 zsbO6ppDPZqn6mnjosm3Xbwf1IzVPmm8eLZ70MrPw7lgupZL65wOz4eEXim2QF0AwSbvaQ6RH
 2bGSGU//hB7AUGyoszbQtMGqS//AOEvwZUB2fGJn4K/UwKBvPa27zef8Xbs6zfbJZ8KGVJtiG
 IFJWDuVVaX0YEuB99ukzPmCRJ9YoCRARPYCQKhwZ4p01mM4fd++3SRxvivBMso/KpWcAm6wKE
 mh1YBhoSe5ANCs79vDxOXjNLNI3sZRl5/DyhV6OxWydLwS/vW3Tqyqz6Ah0PnlF8a+VJ8gkUP
 b1Qc18BlTxpWpG8LZVMBNQh76Bx5qk05YLMGwqHNJVOcO1rvLlSrCE+Zg==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/30 08:23, Anand Jain wrote:
> On 5/27/22 13:49, Christoph Hellwig wrote:
>> Add a few helpers to consolidate code for btrfs read repair testing:
>>
>> =C2=A0 - _btrfs_get_first_logical() gets the btrfs logical address for =
the
>> =C2=A0=C2=A0=C2=A0 first extent in a file
>> =C2=A0 - _btrfs_get_device_path and _btrfs_get_physical use the
>> =C2=A0=C2=A0=C2=A0 btrfs-map-logical tool to find the device path and p=
hysical address
>> =C2=A0=C2=A0=C2=A0 for btrfs logical address for a specific mirror
>> =C2=A0 - _btrfs_direct_read_on_mirror and _btrfs_buffered_read_on_mirro=
r
>> =C2=A0=C2=A0=C2=A0 read the data from a specific mirror
>>
>> These will be used to consolidate the read repair tests and avoid
>> duplication for new tests.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 common/btrfs=C2=A0 | 75 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>> =C2=A0 common/config |=C2=A0 1 +
>> =C2=A0 2 files changed, 76 insertions(+)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index ac597ca4..b69feeee 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -505,3 +505,78 @@ _btrfs_metadump()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_IMAGE_PROG "$device" "$dumpfile"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPR=
ESSOR -f "$dumpfile" &>
>> /dev/null
>> =C2=A0 }
>> +
>> +# Return the btrfs logical address for the first block in a file
>> +_btrfs_get_first_logical()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local file=3D$1
>> +=C2=A0=C2=A0=C2=A0 _require_command "$FILEFRAG_PROG" filefrag
>> +
>> +=C2=A0=C2=A0=C2=A0 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.=
full
>> +=C2=A0=C2=A0=C2=A0 ${FILEFRAG_PROG} -v $file | _filter_filefrag | cut =
-d '#' -f 1
>> +}
>> +
>> +# Find the device path for a btrfs logical offset
>> +_btrfs_get_device_path()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local logical=3D$1
>> +=C2=A0=C2=A0=C2=A0 local stripe=3D$2
>> +
>> +=C2=A0=C2=A0=C2=A0 _require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-ma=
p-logical
>> +
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | =
\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $AWK_PROG "(\$1 ~ /mirror/ =
&& \$2 ~ /$stripe/) { print \$8 }"
>> +}
>> +
>> +
>> +# Find the device physical sector for a btrfs logical offset
>> +_btrfs_get_physical()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local logical=3D$1
>> +=C2=A0=C2=A0=C2=A0 local stripe=3D$2
>> +
>> +=C2=A0=C2=A0=C2=A0 _require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-ma=
p-logical
>> +
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_MAP_LOGICAL_PROG -b -l $logical $SCRATCH_DEV=
 >>
>> $seqres.full 2>&1
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | =
\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $AWK_PROG "(\$1 ~ /mirror/ =
&& \$2 ~ /$stripe/) { print \$6 }"
>> +}
>> +
>> +# Read from a specific stripe to test read recovery that corrupted a
>> specific
>> +# stripe.=C2=A0 Btrfs uses the PID to select the mirror, so keep readi=
ng
>> until the
>> +# xfs_io process that performed the read was executed with a PID that
>> ends up
>> +# on the intended mirror.
>> +_btrfs_direct_read_on_mirror()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local mirror=3D$1
>> +=C2=A0=C2=A0=C2=A0 local nr_mirrors=3D$2
>> +=C2=A0=C2=A0=C2=A0 local file=3D$3
>> +=C2=A0=C2=A0=C2=A0 local offset=3D$4
>> +=C2=A0=C2=A0=C2=A0 local size=3D$5
>> +
>> +=C2=A0=C2=A0=C2=A0 while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirro=
r )) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec $XFS_IO_PROG -d \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c =
"pread -b $size $offset $size" $file) ]]; do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :
>> +=C2=A0=C2=A0=C2=A0 done
>> +}
>> +
>> +# Read from a specific stripe to test read recovery that corrupted a
>> specific
>> +# stripe.=C2=A0 Btrfs uses the PID to select the mirror, so keep readi=
ng
>> until the
>> +# xfs_io process that performed the read was executed with a PID that
>> ends up
>> +# on the intended mirror.
>> +_btrfs_buffered_read_on_mirror()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local mirror=3D$1
>> +=C2=A0=C2=A0=C2=A0 local nr_mirrors=3D$2
>> +=C2=A0=C2=A0=C2=A0 local file=3D$3
>> +=C2=A0=C2=A0=C2=A0 local offset=3D$4
>> +=C2=A0=C2=A0=C2=A0 local size=3D$5
>> +
>> +=C2=A0=C2=A0=C2=A0 echo 3 > /proc/sys/vm/drop_caches
>
>
>> +=C2=A0=C2=A0=C2=A0 while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirro=
r )) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec $XFS_IO_PROG \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c =
"pread -b $size $offset $size" $file) ]]; do
>
> I am confused if it should be BASHPID or PID?
>
> Next, it is ok if the xfs_io_prog fails and returns !=3D 0.
> (Part of the test).
> But then we will continue in the while loop. No?

The loop goes like this:

If "BASHPID % nr_mirrors" isn't mirror, then the whole condition inside
the $() part is already 0, no need to exec the xfs_io command.

Then -z 0 return true, we continue the while loop (aka, doing nothing).

Only when (BASHPID % nr_mirrors =3D=3D mirror) is true, we will try to exe=
c
c XFS_IO_PROGS in the same PID, and normally we will exit.


Some of your concern are valid.
Like if some code bug makes the pread failed, then we will continue the
loop, possibly lead to an infinite loop.

The pid-check-then-exec idea is pretty good, it allows us to only
initiate the read, without doing some unnecessary read then check the pid.

But putting the whole exec into the pid check is indeed hacky and can
lead to problems.

Can we make it less hacky?

Thanks,
Qu

Thanks,
Qu

>
> Sorry, I am sceptical about this. Could you please clarify
> how this works?
>
>
> Thanks, Anand
>
>
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :
>> +=C2=A0=C2=A0=C2=A0 done
>
>
>
>
>> +}
>> diff --git a/common/config b/common/config
>> index c6428f90..df20afc1 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -228,6 +228,7 @@ export E2IMAGE_PROG=3D"$(type -P e2image)"
>> =C2=A0 export BLKZONE_PROG=3D"$(type -P blkzone)"
>> =C2=A0 export GZIP_PROG=3D"$(type -P gzip)"
>> =C2=A0 export BTRFS_IMAGE_PROG=3D"$(type -P btrfs-image)"
>> +export BTRFS_MAP_LOGICAL_PROG=3D$(type -P btrfs-map-logical)
>> =C2=A0 # use 'udevadm settle' or 'udevsettle' to wait for lv to be sett=
led.
>> =C2=A0 # newer systems have udevadm command but older systems like RHEL=
5
>> don't.
>
