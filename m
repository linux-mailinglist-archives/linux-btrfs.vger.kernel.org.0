Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89F9E0080
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbfJVJQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:16:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:59337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388006AbfJVJQr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571735793;
        bh=2xgZ6O5sqITkIlwR7zRSNHPfCTZFpFdqyf2nOYWzMq8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AGzJOTU5ikCrjgDnAX/34/+TOqKy/7Harzmg1EqMby6Req5NPfH4yQffkVccMCG56
         zTY6DfogI3FUKFVYf2aNATrgy0Of2G/3hnq005LUjHTK58NbxJwiuowd+V6ECU+r+Q
         m4or/o6jhlc19NdoE4CIojYnZSR7j7l4cBkOAFzc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1iY5jC3Egj-00XMj0; Tue, 22
 Oct 2019 11:16:32 +0200
Subject: Re: [PATCH 2/2] fstests: btrfs: dm-logwrites test for fstrim and
 fsstress workload
To:     Amir Goldstein <amir73il@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <20191022075806.16616-1-wqu@suse.com>
 <20191022075806.16616-3-wqu@suse.com>
 <CAOQ4uxigD20UtLwa8fvmAQVSkYtLxN2J71oYzw5pGXr1hTkn5w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <99063466-0b73-2f99-b696-beffab26583c@gmx.com>
Date:   Tue, 22 Oct 2019 17:16:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxigD20UtLwa8fvmAQVSkYtLxN2J71oYzw5pGXr1hTkn5w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zyYohtR3f7YecA2Jkv9iMP9uhjIwxg77s"
X-Provags-ID: V03:K1:qbr0mxaHjSenx6NXa+go015X0TnR4YnnP9mmybtKkcJGDr+YW2Y
 WDnM1f2zFa2KnQMK0wrCMuNzRjjFcWu0HgcTPNSu6OmFF4NzM4l/7pzBQEwDDMS3bGlIu6+
 nGkJD7TJTruO2Bx9xtLKq2HsOvbhkTXePHEz7omAC+/suNSePcAaE024v5D1tj0p8SRWgvz
 htMakO/+O6UUq6BUhVdrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BnYMCgP0zmw=:MY9LH876SKATtm8xGLmUA1
 0e7NQjcdBToJJF7/NGSHlHkFIxL8olsTFaqaQKbMiF5ID5Sma/7xo2swtlHBqy6nApT+QCgl7
 zUfemD2gwN1eH/X3nf2XFkShEoW1A12HoULY3LmZWbrvHdkIdc+ToqQyW1wcnZ1dHiom2WSIC
 kf8M1dJzSKoAwOICColsY5dOxwL1owiJqQ3Ew5afyecowermYqZ6CXkN+TfhTEdns1bZNatcF
 tjZFhFwEj2TmPLpilav1i3envdWSuN6R0WD2l2OGuswZTbCGTglh9i6NKe15uz34JDkx0A4f/
 fivVAWsHvpbFraVE4vLdaz1WlfV6plqMEFMpekNaEIvaUsfYHv1ugpuWfdCZYXVgYnOEP6InK
 u5flZ19NCr6VoT99JexReWvkKJE3NwCB5prfPBo/+qGap0fVLWYYD1Xv07F8yo+Zs+5hTQWbI
 r7N0syEhRRU06HpiPu1/uRCCWXJJQy6WSAOi8yqW2585ukXgG1iIjVsOA14uUKtCfq2B8qU/+
 zZy87C+yB4sSsbrksPF3CuqMcPGkvi6ks2410uB2kT7rdUQAmAmA7Phasbq827zWjs7BhF39R
 7LI//1ViDC58KPWf4BJg0K4m1WDK+E5eKO/Sj1HVq+s+Ea9blETVbjkn0dm8oBd67SJKIyRLV
 u9MHbRNYJYpr8iS69WUIBiEECfDxdIH+ANGzFdJ8/nam5Gk9+brHgTSgi8knE0W6FyLNkFOkn
 TmAWy47ke0j5xQCjW/fJPPslTC5n0LfhBcPQmQD89W/zJOeK7v+7pB42CTLcoIDUH4R5v67zY
 fQu3KcSupiD0jhdhHUK/2nyiZOAlBs5u9U33rTXalvdqr41rlNvv8+aUaPyKRROlJktLkrv96
 XciiV5Tz/S/p6IY93Qw0KU01iCETIAkC1iU0hxugX5QawO8cDLDxwrU+oc7R6naAb4uW6xG6P
 mbFRqn4NvWPqEsV2cp7b/+iFiTRDumQfc1YMxu6tfQRfXaF4Opg50eqK+dWpJFH6GbZKUScDV
 9cdLM3pDzunimRjUGMkOtnMye5tKwMwsXJvI/yXCkmt7OOeEMZx6fryo8hb5SSqIqaYZPMEWW
 tE94YMMteJJ1bfXvcM2EIEObXzs06wpxVzGPA9/7/OtANCy0yRcjKwHcXgTcZNMAbM4WrhxRb
 aPa2T8tTmNw0ZtZyjPckO33DtToVsQQ4G/li9Mmtu6Bs7BzybWsNyCJQ/iCUD0US4ylpmnWU7
 sEC24IN8fmIgl5Ob+gf1eU1I/jS9ykegqj0poNMOU6KXyOpD3Syrqj4CmOuQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zyYohtR3f7YecA2Jkv9iMP9uhjIwxg77s
Content-Type: multipart/mixed; boundary="RsiAaoISdgfxpVfNsoanRhZ5wm4HgrzVp"

--RsiAaoISdgfxpVfNsoanRhZ5wm4HgrzVp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/22 =E4=B8=8B=E5=8D=885:09, Amir Goldstein wrote:
> On Tue, Oct 22, 2019 at 11:00 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a fs corruption report of a tree block in use get trimmed, an=
d
>> cause fs corruption.
>>
>> Although I haven't found the cause from the source code, it won't hurt=

>> to add such test case.
>>
>> The test case is limited to btrfs due to the replay-log --check|--fsck=

>> hack to reduce runtime.
>=20
> I am not sure why this is referred to as a hack?
>=20
>> Other fs can't go with the replay-log --check|--fsck hack as their fsc=
k
>> will report dirty journal as error.
>=20
> This doesn't make the test btrfs specific.
> The helper you use log_writes_fast_replay_check() is already dupliacte
> code from btrfs/192 and it should be in common/dmlogwrites.
> The helper itself would be quite generic if it didn't hardcode btrfs ch=
eck
> tool.

>=20
> I think a better solution would be to _require_fast_check_fs and it is
> possible that other fs will have a future flag for fsck to not fail if
> journal needs to be replayed, but the check whatever is possible to che=
ck
> in that state (e.g. the super block and the consistency of the journal)=
=2E

That's the best case, but we're not yet at the stage, so I'll keep the
test in btrfs group for now.

>=20
> However, regarding requiring no_holes, I am not sure how you would
> encode that in a generic test???

That can be kinda worked around, as btrfs is soon to default to no-holes
feature.

But for now, the explicit no-holes mkfs option is still needed.

Thanks,
Qu

>=20
> Thanks,
> Amir.
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Due to recent change in btrfs side, already trimmed tree blocks won't
>> get trimmed again until new data is written.
>>
>> This makes things safer, and I'm not sure if it's the reason why the
>> test never fails on latest kernel.
>> ---
>>  tests/btrfs/197     | 131 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/197.out |   2 +
>>  tests/btrfs/group   |   1 +
>>  3 files changed, 134 insertions(+)
>>  create mode 100755 tests/btrfs/197
>>  create mode 100644 tests/btrfs/197.out
>>
>> diff --git a/tests/btrfs/197 b/tests/btrfs/197
>> new file mode 100755
>> index 00000000..c86af7b6
>> --- /dev/null
>> +++ b/tests/btrfs/197
>> @@ -0,0 +1,131 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +
>> +# FS QA Test 197
>> +#
>> +# Test btrfs consistency after each DISCARD for a workload with fstri=
m and
>> +# fsstress.
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       kill -q $fstrim_pid &> /dev/null
>> +       "$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
>> +       wait
>> +       _log_writes_cleanup &> /dev/null
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/dmlogwrites
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_command "$KILLALL_PROG" killall
>> +_require_command "$BLKDISCARD_PROG" blkdiscard
>> +_require_btrfs_fs_feature "no_holes"
>> +_require_btrfs_mkfs_feature "no-holes"
>> +_require_fstrim
>> +_require_log_writes
>> +_require_scratch
>> +
>> +runtime=3D30
>> +nr_cpus=3D$("$here/src/feature" -o)
>> +# cap nr_cpus to 8 to avoid spending too much time on hosts with many=
 cpus
>> +if [ $nr_cpus -gt 8 ]; then
>> +       nr_cpus=3D8
>> +fi
>> +fsstress_args=3D$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p=
 $nr_cpus \
>> +               $FSSTRESS_AVOID)
>> +
>> +fstrim_workload()
>> +{
>> +       trap "wait; exit" SIGTERM
>> +
>> +       while  true; do
>> +               $FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full
>> +       done
>> +}
>> +
>> +# Replay and check each fua/flush (specified by $2) point.
>> +#
>> +# Since dm-log-writes records bio sequentially, even just replaying a=
 range
>> +# still needs to iterate all records before the end point.
>> +# When number of records grows, it will be unacceptably slow, thus we=
 need
>> +# to use relay-log itself to trigger fsck, avoid unnecessary seek.
>> +log_writes_fast_replay_check()
>> +{
>> +       local check_point=3D$1
>> +       local blkdev=3D$2
>> +       local fsck_command=3D"$BTRFS_UTIL_PROG check $blkdev"
>> +       local ret
>> +
>> +       [ -z "$check_point" -o -z "$blkdev" ] && _fail \
>> +       "check_point and blkdev must be specified for log_writes_fast_=
replay_check"
>> +
>> +       # Replay to first mark
>> +       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
>> +               --replay $blkdev --end-mark prepare
>> +       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
>> +               --replay $blkdev --start-mark prepare \
>> +               --check $check_point --fsck "$fsck_command" \
>> +               &> $tmp.full_fsck
>> +       ret=3D$?
>> +       tail -n 150 $tmp.full_fsck > $seqres.full
>> +       [ $ret -ne 0 ] && _fail "fsck failed during replay"
>> +}
>> +
>> +_log_writes_init $SCRATCH_DEV
>> +
>> +# Discard the whole devices so when some tree pointer is wrong, it wo=
n't point
>> +# to some older valid tree blocks, so we can detect it.
>> +$BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
>> +
>> +# The regular workaround to avoid false alert on unexpected holes
>> +_log_writes_mkfs -O no-holes >> $seqres.full
>> +_log_writes_mount
>> +
>> +$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full || _notrun "FSTRIM not s=
upported"
>> +
>> +_log_writes_mark prepare
>> +
>> +fstrim_workload &
>> +fstrim_pid=3D$!
>> +
>> +"$FSSTRESS_PROG" $fsstress_args > /dev/null &
>> +sleep $runtime
>> +
>> +"$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
>> +kill $fstrim_pid
>> +wait
>> +
>> +_log_writes_unmount
>> +_log_writes_remove
>> +
>> +# The best checkpoint is discard, however since there are a lot of
>> +# discard, using discard check point is too time consuming.
>> +# Here trade coverage for a much shorter runtime
>> +log_writes_fast_replay_check flush "$SCRATCH_DEV"
>> +
>> +echo "Silence is golden"
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
>> new file mode 100644
>> index 00000000..3bbd3143
>> --- /dev/null
>> +++ b/tests/btrfs/197.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 197
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index c2ab3e7d..ee35fa59 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -199,3 +199,4 @@
>>  194 auto volume
>>  195 auto volume
>>  196 auto metadata log volume
>> +197 auto replay trim
>> --
>> 2.23.0
>>


--RsiAaoISdgfxpVfNsoanRhZ5wm4HgrzVp--

--zyYohtR3f7YecA2Jkv9iMP9uhjIwxg77s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2uyOsXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjHUwf9F2Yu7BXbxpKpJCTWnwsplRAb
eAWW2gH9C2wGw9C9blBb+9O2e8hi//CVJk0CaguZjqcOl7EKBO6G2YDDwzfbIKWG
0NZdJvuAECynrsZ6dGuQaaMfB50Imtby39RX/wY8HF0jm//ScuHP0u5SVryNIfZs
ep6bYmkJeW3wOcwPV09mABqA5r2oJyxwhaHD0zUo6P77YaKmKp2T5WNhBrUSv+wo
z/QOXZ/mjh+c+VmuuKgsDnPTME6aR683Rq9fwJW6AgNTAKfFy6w0KRURNmZYE+vl
HBL3E88EMmsyghlc+00zqbRk+qIetdgIzXzn2dsmim29FXW5XzKuRfTgZsU8OQ==
=6tI8
-----END PGP SIGNATURE-----

--zyYohtR3f7YecA2Jkv9iMP9uhjIwxg77s--
