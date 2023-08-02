Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8512276CB18
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjHBKj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjHBKj3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 06:39:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E0421F;
        Wed,  2 Aug 2023 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690972583; x=1691577383; i=quwenruo.btrfs@gmx.com;
 bh=m1RBFzxal0+PdMFBKqdd6OxOYbb8mAoXl9J6+7RbTYs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bF+Ru2w3HExXbnJDMe2Qva26GMk02Pof1bk19V6G7gqbwGAiQwYfyIPkMBhwEqU1Gtrq/Mc
 lxoHxgY5J8a0M4FoqXNZhJrAL5RUP5XCXwIKH7SyWXKgzENac3kQ/UswOtGJCPWyTEqKIIMZE
 dd9ub79MbSm+5M3rS6KdkDJ6uTT1ForZTuiAHNj1wrlnJfRx/3V6JILkbdjMdKZse4vgDlUEd
 T8vA3ZsALpEB9ukW5rZOpiDSgmbCu/Bgp13Nvcx/UCi8cYp8sj1sCEhsNeOIFUEn2bt+adBcB
 NBqU33TKRAmFLdytjhmMPD1MoEBvq0BfmggPevQHuxg0xg7NhsfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1pgrBF3ht5-012q7a; Wed, 02
 Aug 2023 12:36:23 +0200
Message-ID: <26ccf055-8ca2-275d-627d-e8b6c2e12ffe@gmx.com>
Date:   Wed, 2 Aug 2023 18:36:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/276: allow a slight increase in the number of
 extents
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230801065529.50122-1-wqu@suse.com>
 <CAL3q7H7MbA5Vfwgu=8Xuhh2o-SMnSCg9CJQszMTgLfHzmuBFWg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H7MbA5Vfwgu=8Xuhh2o-SMnSCg9CJQszMTgLfHzmuBFWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:67qaA/2ipMGLaGXJnTdSp0leO6eKEsBu16nfPriAdfUJvBUrgaZ
 XdsvJhciBQhvRcUHuzl5dJGBRQuO8T2R64Z9so5YXtgGFGmRzjhIDRyEyWU0LvBHFL1tSil
 7smggZtJhNTrFRUwI/6/JIKTX9aEmvfRFsdX6E0ikyQHae/kZIq2+XtoncYeFjrM0YHhY/f
 /DDE94q6NXT56IBe/ajWA==
UI-OutboundReport: notjunk:1;M01:P0:idvt5/IrGtM=;9svKPfDiSNZBwxatRFOMuYNF0kh
 JqnbcCgqp88aszgq15D8Fa7Sn7TQvGMDTQjTqMvnKcUCO38H7VJvoqFobAkMYD1CzLKl+kt3q
 j86BppjjzD6Hx+oUjJ56bjk1Dc3uSkY96FQzwskRMdxRDdIaISrZRSfKj7KLUK1L3BQnUV3Jg
 z7xfvTpJ6VQixxVNr1aFwztazcpcHCL51BqDxQ7/6xky3tXkDkqAtlvkObNesmFZJl8xDAOoZ
 JjZ7ugYPU+IUmYcLDXd7clw2oPt7yX6PFqPSV0e/rD/ZiR8j2lUky3nuHICQ4IDPzgpEi3DJj
 BE/aMZ6a5S9/HH3CMLhjsDrgGQK2H5F/0IXn/C38eKJMiBxtZ7HQtR2UfcE9a9YORp6ovdEct
 7acb5z0xEeuKFJko36VnHyocNeolS7KybNeEMuaVxH4Jt9QQRcCof7/2Q8kzbOAOBUcE9LLaZ
 F4V19c6hsQcv5NQB5b+xU6pRZQ6elOUgt0+nN+y3Oy4BytdNbVtXyz8AMyrQRTs+9no53C7Ir
 OVBpkjxfVmz8gPQlv+FYdPWLamABDIYVcvK2q+AMNV2umDlXck4mRb9VcPJ6vJCTeNRDx2kAD
 7a0Y6CuVP3YSa+rMukI3IaUlpJJgU/U7kjoKr/7DcSPSS6L8w9OqYXtkCa7lEQX5sTynJaTZ6
 XlU5cv43xxwGO/f8GG/Y2bI7C1S+1rHOwnwZGbzLLuIVlvQgdsurq5GbhuTXP5jI6G/KDZZXR
 XnV0xBC8gQgC2OZsKRA+wg5cAA3oFd42Rw0yBqDJpxjJPFA6R+qYzi4yMSpSgPCCqNBoEOkjo
 2mPTX8v40IOLL7C/3UyZHfjKBfDpSEehcfUvCGUrE1QXFMv2o5JhFjU3yiSUpK12/x3iydUU5
 yxIeTmtFnbTFU7Mm9XOSuvhUdPipCKcbKcnjHMY1eM5H8Yq6PsDw4OMrFz516VSj3PqmB8kNo
 6ZFNJk/pC3CS1YM3meEqvxt7Ul8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/2 18:23, Filipe Manana wrote:
> On Tue, Aug 1, 2023 at 8:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Sometimes test case btrfs/276 would fail with extra number of extents:
>>
>>      - output mismatch (see /opt/xfstests/results//btrfs/276.out.bad)
>>      --- tests/btrfs/276.out     2023-07-19 07:24:07.000000000 +0000
>>      +++ /opt/xfstests/results//btrfs/276.out.bad        2023-07-28 04:=
15:06.223985372 +0000
>>      @@ -1,16 +1,16 @@
>>       QA output created by 276
>>       wrote 17179869184/17179869184 bytes at offset 0
>>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>      -Number of non-shared extents in the whole file: 131072
>>      +Number of non-shared extents in the whole file: 131082
>>       Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>      -Number of shared extents in the whole file: 131072
>>      ...
>>      (Run 'diff -u /opt/xfstests/tests/btrfs/276.out /opt/xfstests/resu=
lts//btrfs/276.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> The test case uses golden output to record the number of total extents
>> of a 16G file.
>>
>> This is not reliable as we can have writeback happen halfway, resulting
>> smaller extents thus slightly more extents.
>>
>> With a VM with 4G memory, I have a chance around 1/10 hitting this
>> false alert.
>>
>> [FIX]
>> Instead of using golden output, we allow a slight (5%) float in the
>> number of extents, and move the 131072 (and 131072 - 16) from golden
>> output, so even if we have a slightly more extents, we can still pass
>> the test.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/276     | 41 ++++++++++++++++++++++++++++++++++++-----
>>   tests/btrfs/276.out |  4 ----
>>   2 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/btrfs/276 b/tests/btrfs/276
>> index 944b0c8f..a63b28bb 100755
>> --- a/tests/btrfs/276
>> +++ b/tests/btrfs/276
>> @@ -65,10 +65,17 @@ count_not_shared_extents()
>>
>>   # Create a 16G file as that results in 131072 extents, all with a siz=
e of 128K
>>   # (due to compression), and a fs tree with a height of 3 (root node a=
t level 2).
>> +#
>> +# But due to writeback can happen halfway, we may have slightly more e=
xtents
>> +# than 128K, so we allow 5% increase in the number of extents.
>> +#
>>   # We want to verify later that fiemap correctly reports the sharednes=
s of each
>>   # extent, even when it needs to switch from one leaf to the next one =
and from a
>>   # node at level 1 to the next node at level 1.
>>   #
>> +nr_extents_lower=3D$((128 * 1024))
>> +nr_extents_upper=3D$((128 * 1024 + 128 * 1024 / 20))
>> +
>>   $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xf=
s_io
>
> Does adding '-s' (fsync after every write) to the $XFS_IO_PROG fixes the=
 issue?
> On my test vm, it doesn't increase runtime by that much (16 to 23 second=
s).

This indeed is much better, without dirty pages pressure we can go the
old golden output.

Thanks,
Qu
>
> I'd rather do that so that we can be sure fiemap is working correctly
> and not returning more extents than there really are - this approach
> of allowing a bit more allows for that type of bug to be unnoticed,
> plus that little bit more might not be always enough (depending on
> available rm, writeback settings, etc).
>
> Thanks.
>
>>
>>   # Sync to flush delalloc and commit the current transaction, so fiema=
p will see
>> @@ -76,13 +83,22 @@ $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MN=
T/foo | _filter_xfs_io
>>   sync
>>
>>   # All extents should be reported as non shared (131072 extents).
>> -echo "Number of non-shared extents in the whole file: $(count_not_shar=
ed_extents)"
>> +found1=3D$(count_not_shared_extents)
>> +echo "Number of non-shared extents in the whole file: ${found1}" >> $s=
eqres.full
>> +
>> +if [ $found1 -lt $nr_extents_lower -o $found1 -gt $nr_extents_upper ];=
 then
>> +       echo "unexpected initial number of extents, has $found1 expect =
[$nr_extents_lower, $nr_extents_upper]"
>> +fi
>>
>>   # Creating a snapshot.
>>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | =
_filter_scratch
>>
>>   # We have a snapshot, so now all extents should be reported as shared=
.
>> -echo "Number of shared extents in the whole file: $(count_shared_exten=
ts)"
>> +found2=3D$(count_shared_extents)
>> +echo "Number of shared extents in the whole file: ${found2}" >> $seqre=
s.full
>> +if [ $found2 -ne $found1 ]; then
>> +       echo "unexpected shared extents, has $found2 expect $found1"
>> +fi
>>
>>   # Now COW two file ranges, of 1M each, in the snapshot's file.
>>   # So 16 extents should become non-shared after this.
>> @@ -97,8 +113,18 @@ sync
>>
>>   # Now we should have 16 non-shared extents and 131056 (131072 - 16) s=
hared
>>   # extents.
>> -echo "Number of non-shared extents in the whole file: $(count_not_shar=
ed_extents)"
>> -echo "Number of shared extents in the whole file: $(count_shared_exten=
ts)"
>> +found3=3D$(count_not_shared_extents)
>> +found4=3D$(count_shared_extents)
>> +echo "Number of non-shared extents in the whole file: ${found3}"
>> +echo "Number of shared extents in the whole file: ${found4}" >> $seqre=
s.full
>> +
>> +if [ $found3 !=3D 16 ]; then
>> +       echo "Unexpected number of non-shared extents, has $found3 expe=
ct 16"
>> +fi
>> +
>> +if [ $found4 !=3D $(( $found1 - $found3 )) ]; then
>> +       echo "Unexpected number of shared extents, has $found4 expect $=
(( $found1 - $found3 ))"
>> +fi
>>
>>   # Check that the non-shared extents are indeed in the expected file r=
anges (each
>>   # with 8 extents).
>> @@ -117,7 +143,12 @@ _scratch_remount commit=3D1
>>   sleep 1.1
>>
>>   # Now all extents should be reported as not shared (131072 extents).
>> -echo "Number of non-shared extents in the whole file: $(count_not_shar=
ed_extents)"
>> +found5=3D$(count_not_shared_extents)
>> +echo "Number of non-shared extents in the whole file: ${found5}" >> $s=
eqres.full
>> +
>> +if [ $found5 !=3D $found1 ]; then
>> +       echo "Unexpected final number of non-shared extents, has $found=
5 expect $found1"
>> +fi
>>
>>   # success, all done
>>   status=3D0
>> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
>> index 3bf5a5e6..e318c2e9 100644
>> --- a/tests/btrfs/276.out
>> +++ b/tests/btrfs/276.out
>> @@ -1,16 +1,12 @@
>>   QA output created by 276
>>   wrote 17179869184/17179869184 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -Number of non-shared extents in the whole file: 131072
>>   Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>> -Number of shared extents in the whole file: 131072
>>   wrote 1048576/1048576 bytes at offset 8388608
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   wrote 1048576/1048576 bytes at offset 12884901888
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   Number of non-shared extents in the whole file: 16
>> -Number of shared extents in the whole file: 131056
>>   Number of non-shared extents in range [8M, 9M): 8
>>   Number of non-shared extents in range [12G, 12G + 1M): 8
>>   Delete subvolume (commit): 'SCRATCH_MNT/snap'
>> -Number of non-shared extents in the whole file: 131072
>> --
>> 2.41.0
>>
