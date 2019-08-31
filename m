Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42020A4691
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfHaXnh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 19:43:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:36587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfHaXnh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 19:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567295007;
        bh=E4341sGpcZp+zCH1W5mA+n8QM3tb+K834Uhh44Vd+OE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JDfu9iMDn92944DlKqWalFfINgj7/AAf7qX6i+sDyFAy+LAtoeYvibUsgxj+nKle6
         O8lnp/5GN66o/x/bFFCuS2uDSQaCbMNjVCOrxD4GSstw7AokCU2pdUomiCiI9u+uhH
         APOE/HvwAVDdbSLtsRczwYqPEIrK84oOl+HrypUI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lb5GD-1iSJZn47FB-00kfBS; Sun, 01
 Sep 2019 01:43:27 +0200
Subject: Re: [PATCH v3] fstests: btrfs: Check snapshot creation and deletion
 with dm-logwrites
To:     Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190826062045.18670-1-wqu@suse.com>
 <20190831181008.GD2622@desktop>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <d3d46438-98a8-5697-4f81-334dc6f4ee34@gmx.com>
Date:   Sun, 1 Sep 2019 07:43:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190831181008.GD2622@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3tvHtXIlroUnRCu8Jx0kThw9FKzY89IwU"
X-Provags-ID: V03:K1:4CCFSFE8g5mxGtuNAKzJUjwmSRxDIEC12Ms7Vpayxd6yG4mAO79
 TbH5mSwyKnjjrO4xoXm7cLDfy7TGSCTXn2wnWQLWO+Q6JRANN1aP1ptDcWTpjGCwA28TaJ3
 ygQoeTvxUXirMxfiRVDIBYbdpjBXzU9daeuXlrxPT3YX520cTWTl0ei8a0o+Z5nZOidzBpT
 H8O52hXzJHYPwdl+5k2ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bBv36Vr85Cw=:e/qSbU2eqHphNFs8fAiP69
 wnzwYrQfsKJCrNJYg+bP8gynvNYcXRZgwKDoKn28jsH+0a9kl9QCx045qdt3c5W9imsEH9r4x
 OpXS1KOvE9dKTka3s3GJ8tfCQvea/Oi1ksUh0TOiV99nb4eE2U2MCbMUbQW/QPEL1TR79X/xU
 3X3gvWzQ13YZ5ATqZ0s6RlBGjntV6Rjn1Kc0ZUp6bIsSEsFpzkyP8j6DnNivHSe3DdI17AfAr
 x+pCreI+kelfvEj6rfThgi/a2KUXgdaa++pcjrBPQfLpFYdKvWGPSpX1G5jnDx3xPXfW8SVDz
 pWwZ7yhgmbAkB22zW0dFTd6lhRUMzoP5PYC5RsL9ypHCCjbvaClVe3HAx64WYOAfjk1uTNofB
 BIB8SUMfZ02+ZYUjlxT+6gwLp6Di1cGejyxr3SmS0wvvM7z/fiftUeWB0VXCtAYySHc9wFTiK
 r9MCNXV/OTiL0pi+eTMTzLxbXck/FxZ6ckitwG7RwYKJR9gpgA6epGC+P/qUBAV+8WIXWUSKq
 W1Mv4nRXmmTkDIu+99ueTauNHJRL2mtsfClcYdo5Nrb91Bk8+iso9lkXHY2ryG9febTtPEi4h
 XTxRcKT+rbMa78tTWhWb1s7EcY5cncEtpHSCQcesf8LE9ZdRBz6mFB63grAIGRRPPfh5DKwo8
 ExKHk6vijeCNDZhNhJ5UFu0qmZX5qeSTTm7VCaThBEEV8uYwExXioD7xQFbTb+bh/ee+2N2CS
 0O82xvi7b2c+ozXjLglHAXNHlKH30lf7lp4xC1ftzl/YVlOvPbqZG4aRhS/UUYyayynfYNfjw
 qSZCr01+DRni0RQDGQbLL40tNQIAJC/NatjTE6x7iXQmEMpHaksx0o/W7BcplVjUtoFVYocrR
 pgQ8JCcAiRmh0fiais1sc/cjSJy1tql7pbUw1jhW/4IZr2lTSicqCbHJAWLGsdGU1YyUuToOF
 LW3VLa0AuQKxEZzbXh3E75NwtzHlhrPBOXgUcJUHBMhwGZZGKRiW2IQW/G517o8+FvX2qEHtw
 BnU4VJ8IM3k1bgKJT/E6s0ae4VXr+A+s7bDdqT4q1xLJIJXcLySauSFlXX7k47CNnMeNH2EEp
 BUTQG8z/Bq6DNVAydjQYR9FKpwLG5BegUQLubRQHylYv8Tm2bW+fzv78WPKiuf9aj/nLo3A0w
 rgSNq/O1E1VJynmZcWYmWWMxX2dG6KcbdqnQHZZ0hFtuOUpg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3tvHtXIlroUnRCu8Jx0kThw9FKzY89IwU
Content-Type: multipart/mixed; boundary="IXKVUnwIo4DLgcno6wg6U7ItuyCoFHMdB";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <d3d46438-98a8-5697-4f81-334dc6f4ee34@gmx.com>
Subject: Re: [PATCH v3] fstests: btrfs: Check snapshot creation and deletion
 with dm-logwrites
References: <20190826062045.18670-1-wqu@suse.com>
 <20190831181008.GD2622@desktop>
In-Reply-To: <20190831181008.GD2622@desktop>

--IXKVUnwIo4DLgcno6wg6U7ItuyCoFHMdB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/1 =E4=B8=8A=E5=8D=882:10, Eryu Guan wrote:
> On Mon, Aug 26, 2019 at 02:20:45PM +0800, Qu Wenruo wrote:
>> We have generic dm-logwrites with fsstress test case (generic/482), bu=
t
>> it doesn't cover fs specific operations like btrfs snapshot creation a=
nd
>> deletion.
>>
>> Furthermore, that test is not heavy enough to bump btrfs tree height b=
y
>> its short runtime.
>>
>> And finally, btrfs check doesn't consider dirty log as an error, unlik=
e
>> ext*/xfs, that's to say we don't need to mount the fs to replay the lo=
g,
>> but just run btrfs check on the fs is enough.
>>
>> So introduce a similar test case but for btrfs only.
>>
>> The test case will stress btrfs by:
>> - Use small nodesize to bump tree height
>> - Create a base tree which is already high enough
>> - Trim tree blocks to find possible trim bugs
>> - Call snapshot creation and deletion along with fsstress
>>
>> To utilize replay-log --check and --fsck command, we fix one bug in
>> replay-log first:
>> - Return 1 when fsck failed
>>   Original when fsck failed, run_fsck() returns -1, but to make
>>   replay_log prog to return 1, we need to return a minus value, so
>>   fix it by setting @ret to -EUCLEAN when run_fsck() failed, so that
>>   we can detect the fsck failure by simply checking the return value
>>   of replay-log.
>=20
> Sorry, I didn't quite get this. run_fsck() already returns a negative
> value (-1) on fsck failure (thus @ret is -1 in this case), and
> replay_log exits with 1 if @ret < 0. All seem fine to me, setting
> -EUCLEAN doesn't seem necessary to me. Did I miss anything?

My bad, it looks like so.

>=20
> Anyway, I think this bugfix could be in a separate patch.
>=20
>>
>> Also it includes certain workaround for btrfs:
>> - Use no-holes feature
>>   To avoid missing hole file extents.
>>   Although that behavior doesn't follow the on-disk format spec, it
>>   doesn't cause data loss. And will follow the new on-disk format spec=

>>   of no-holes feature, so it's better to workaround it.
>>
>> And an optimization for btrfs only:
>> - Use replay-log --fsck/--check command
>>   Since dm-log-writes records bios sequentially, there is no way to
>>   locate certain entry unless we iterate all entries.
>>   This is becoming a big performance penalty if we replay certain a
>>   range, check the fs, then re-execute replay-log to replay another
>>   range.
>>
>>   We need to records the previous entry location, or we need to
>>   re-iterate all previous entries.
>>
>>   Thankfully, replay-log has already address it by providing --fsck an=
d
>>   --check command, thus we don't need to break replay-log command.
>>
>> Please note, for fast storage (e.g. fast NVME or unsafe cache mode),
>> it's recommended to use log devices larger than 15G, or we can't recor=
d
>> the full log of just 30s fsstress run.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> For the log devices size problem, I have submitted dm-logwrites bio fl=
ag
>> filter support, to filter out data bios.
>>
>> But that is not yet merged into kernel, thus we need a large log devic=
e
>> for short run.
>>
>> For reference, if using unsafe cache mode for all test devices, on a
>> system with 32G dual-channel DDR4 3200 RAM, 5G log device will be
>> filled up in less than 15 seconds.
>> So to ensure dm-log-writes covers all the operations, one needs at lea=
st
>> 15G log device, and even more if using RAM with more channels.
>>
>> Changelog:
>> v2
>> - Better expression/words for comment
>> - Add requirement for no-holes features
>> - Use xattr to bump up tree height
>>   So no need for max_inline mount option
>> - Coding style fixes for function definition
>> - Add -f for rm to avoid user alias setting
>> - Add new workload (update time stamp and create new files) for snapsh=
ot
>>   workload
>> - Remove an unnecessary sync call
>> - Get rid of wrong 2>&1 redirection
>> - Add to group "snapshot" and "stress"
>>
>> v3:
>> - Add '_require_attrs' and source common/attr
>> - Introduce '_require_fsck_not_report_dirty_logs_as_error'
>> - Add comment for the replay-log code fix
>> - Wait after killing all background fsstress
>> - Use $BLKDISCARD_PROG instead of plain 'blkdiscard'
>> - Add trap for snapshot and delete workload
>> ---
>>  common/config               |   1 +
>>  common/dmlogwrites          |  44 ++++++++++
>>  src/log-writes/replay-log.c |   2 +
>>  tests/btrfs/192             | 156 +++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/192.out         |   2 +
>>  tests/btrfs/group           |   1 +
>>  6 files changed, 206 insertions(+)
>>  create mode 100755 tests/btrfs/192
>>  create mode 100644 tests/btrfs/192.out
>>
>> diff --git a/common/config b/common/config
>> index bd64be62..4c86a492 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -183,6 +183,7 @@ export LOGGER_PROG=3D"$(type -P logger)"
>>  export DBENCH_PROG=3D"$(type -P dbench)"
>>  export DMSETUP_PROG=3D"$(type -P dmsetup)"
>>  export WIPEFS_PROG=3D"$(type -P wipefs)"
>> +export BLKDISCARD_PROG=3D"$(type -P blkdiscard)"
>>  export DUMP_PROG=3D"$(type -P dump)"
>>  export RESTORE_PROG=3D"$(type -P restore)"
>>  export LVM_PROG=3D"$(type -P lvm)"
>> diff --git a/common/dmlogwrites b/common/dmlogwrites
>> index ae2cbc6a..474ec570 100644
>> --- a/common/dmlogwrites
>> +++ b/common/dmlogwrites
>> @@ -175,3 +175,47 @@ _log_writes_replay_log_range()
>>  		>> $seqres.full 2>&1
>>  	[ $? -ne 0 ] && _fail "replay failed"
>>  }
>> +
>> +# Require fsck not to report dirty logs as error
>> +#
>> +# This is a special requirement to use _log_writes_fast_replay_check
>> +# The reasons are:
>> +# - To avoid unnecessary seek when there are a lot of entries
>> +#   replay-log doesn't have a tree-like structure to do fast index,
>> +#   thus it iterate all entries one by one, this can be very slow
>> +# - No way to revert the log replay for next check
>> +#   A lot of fsck will replay the log, which will pollute the replay =
device
>> +#   for next entry
>> +_require_fsck_not_report_dirty_logs_as_error()
>> +{
>> +	if [ $FSTYP !=3D "btrfs" ]; then
>> +		_notrun "fsck of $FSTYP reports dirty jounal/log as error, skipping=
 test"
>> +	fi
>> +}
>=20
> The rule name seems ugly :)
>=20
>> +
>> +# Replay and check each fua/flush (specified by $2) point.
>> +#
>> +# Since dm-log-writes records bio sequentially, even just replaying a=
 range
>> +# still needs to iterate all records before the end point.
>> +# When number of records grows, it will be unacceptably slow, thus we=
 need
>> +# to use relay-log itself to trigger fsck, avoid unnecessary seek.
>> +_log_writes_fast_replay_check()
>> +{
>> +	local check_point=3D$1
>> +	local blkdev=3D$2
>> +	local fsck_command
>> +
>> +	_require_fsck_not_report_dirty_logs_as_error
>> +
>> +	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
>> +	"check_point and blkdev must be specified for _log_writes_fast_repla=
y_check"
>> +	case $FSTYP in
>> +	btrfs)
>> +		fsck_command=3D"$BTRFS_UTIL_PROG check $blkdev"
>> +		;;
>> +	esac
>> +	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
>> +		--replay $blkdev --check $check_point --fsck "$fsck_command" \
>> +		2>&1 | tail -n 128 >> $seqres.full
>> +	[ $? -ne 0 ] && _fail "fsck failed during replay"
>> +}
>=20
> And I think we could make _log_writes_fast_replay_check(), which seems
> only useful to btrfs, a local function in the test, so we avoid all
> these $FSTYP =3D=3D btrfs checks.

Yep, that's much better.

Thanks,
Qu
>=20
> Thanks,
> Eryu
>=20
>> diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c=

>> index 829b18e2..1e1cd524 100644
>> --- a/src/log-writes/replay-log.c
>> +++ b/src/log-writes/replay-log.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <stdio.h>
>> +#include <errno.h>
>>  #include <unistd.h>
>>  #include <getopt.h>
>>  #include <stdlib.h>
>> @@ -375,6 +376,7 @@ int main(int argc, char **argv)
>>  				fprintf(stderr, "Fsck errored out on entry "
>>  					"%llu\n",
>>  					(unsigned long long)log->cur_entry - 1);
>> +				ret =3D -EUCLEAN;
>>  				break;
>>  			}
>>  		}
>> diff --git a/tests/btrfs/192 b/tests/btrfs/192
>> new file mode 100755
>> index 00000000..db9bc40e
>> --- /dev/null
>> +++ b/tests/btrfs/192
>> @@ -0,0 +1,156 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 192
>> +#
>> +# Test btrfs consistency after each FUA for a workload with snapshot =
creation
>> +# and removal
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	kill -q $pid1 &> /dev/null
>> +	kill -q $pid2 &> /dev/null
>> +	"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
>> +	wait
>> +	_log_writes_cleanup &> /dev/null
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/attr
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
>> +
>> +_require_command "$KILLALL_PROG" killall
>> +_require_command "$BLKDISCARD_PROG" blkdiscard
>> +_require_btrfs_fs_feature "no_holes"
>> +_require_btrfs_mkfs_feature "no-holes"
>> +_require_fsck_not_report_dirty_logs_as_error
>> +_require_log_writes
>> +_require_scratch
>> +_require_attrs
>> +
>> +# To generate 3 level fs tree for 64K nodesize, we need 32768 xattr i=
tems.
>> +# That will cause too many transactions, bumping replay check time
>> +# from ~60s to ~300s. (VM alreayd using unsafe cache for the test dev=
ices)
>> +# So here we skip non-4K page size system, in favor of a shorter defa=
ult
>> +# test time
>> +if [ $(get_page_size) -ne 4096 ]; then
>> +	_notrun "This test doesn't support non-4K page size yet"
>> +fi
>> +
>> +runtime=3D30
>> +nr_cpus=3D$("$here/src/feature" -o)
>> +# cap nr_cpus to 8 to avoid spending too much time on hosts with many=
 cpus
>> +if [ $nr_cpus -gt 8 ]; then
>> +	nr_cpus=3D8
>> +fi
>> +fsstress_args=3D$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p=
 $nr_cpus \
>> +		$FSSTRESS_AVOID)
>> +_log_writes_init $SCRATCH_DEV
>> +
>> +# Discard the whole devices so when some tree pointer is wrong, it wo=
n't point
>> +# to some older valid tree blocks, so we can detect it.
>> +$BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
>> +
>> +# Workaround minor file extent discountinous.
>> +# And use 4K nodesize to bump tree height.
>> +_log_writes_mkfs -O no-holes -n 4k >> $seqres.full
>> +_log_writes_mount
>> +
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null
>> +mkdir -p $SCRATCH_MNT/snapshots
>> +mkdir -p $SCRATCH_MNT/src/padding
>> +
>> +random_file()
>> +{
>> +	local basedir=3D$1
>> +	echo "$basedir/$(ls $basedir | sort -R | tail -1)"
>> +}
>> +
>> +snapshot_workload()
>> +{
>> +	trap "wait; exit" SIGTERM
>> +
>> +	local i=3D0
>> +	while true; do
>> +		$BTRFS_UTIL_PROG subvolume snapshot \
>> +			$SCRATCH_MNT/src $SCRATCH_MNT/snapshots/$i \
>> +			> /dev/null
>> +		# Do something small to make snapshots different
>> +		rm -f "$(random_file $SCRATCH_MNT/src/padding)"
>> +		rm -f "$(random_file $SCRATCH_MNT/src/padding)"
>> +		touch "$(random_file $SCRATCH_MNT/src/padding)"
>> +		touch "$SCRATCH_MNT/src/padding/random_$RANDOM"
>> +
>> +		i=3D$(($i + 1))
>> +		sleep 1
>> +	done
>> +}
>> +
>> +delete_workload()
>> +{
>> +	trap "wait; exit" SIGTERM
>> +
>> +	while true; do
>> +		sleep 2
>> +		$BTRFS_UTIL_PROG subvolume delete \
>> +			"$(random_file $SCRATCH_MNT/snapshots)" \
>> +			> /dev/null 2>&1
>> +	done
>> +}
>> +
>> +xattr_value=3D$(printf '%0.sX' $(seq 1 3800))
>> +
>> +# Bumping tree height to level 2.
>> +for ((i =3D 0; i < 64; i++)); do
>> +	touch "$SCRATCH_MNT/src/padding/$i"
>> +	$SETFATTR_PROG -n 'user.x1' -v $xattr_value \
>> +		"$SCRATCH_MNT/src/padding/$i"
>> +done
>> +
>> +_log_writes_mark prepare
>> +
>> +snapshot_workload &
>> +pid1=3D$!
>> +delete_workload &
>> +pid2=3D$!
>> +
>> +"$FSSTRESS_PROG" $fsstress_args > /dev/null &
>> +sleep $runtime
>> +
>> +"$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
>> +kill $pid1 &> /dev/null
>> +kill $pid2 &> /dev/null
>> +wait
>> +_log_writes_unmount
>> +_log_writes_remove
>> +
>> +_log_writes_fast_replay_check fua "$SCRATCH_DEV"
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
>> new file mode 100644
>> index 00000000..6779aa77
>> --- /dev/null
>> +++ b/tests/btrfs/192.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 192
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 2474d43e..cab10d19 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -194,3 +194,4 @@
>>  189 auto quick send clone
>>  190 auto quick replay balance qgroup
>>  191 auto quick send dedupe
>> +192 auto replay snapshot stress
>> --=20
>> 2.22.0
>>


--IXKVUnwIo4DLgcno6wg6U7ItuyCoFHMdB--

--3tvHtXIlroUnRCu8Jx0kThw9FKzY89IwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1rBhoACgkQwj2R86El
/qgd+Qf/RQJ6ZeE/iCApMUuh/0foiKD4RaYi4cp2b1/1gaVPAjUhUR/S/+emjeBJ
vm3OLIzg762jyRBc32dZTS7EJDUc2cR9raDA04eCt1Y1bSrnrfnBOJL7hhI2ZPcA
CA5m+wdz/AXrJskw0IljgyXYLwXx2PhSDjClAMqjV8rhNhP+SySI0z1YT0CptCWr
AYBJRLRfTEnzRHt0C3nqzLdMnJoTii1Im81GQA0HueM3dIwDlHcnKr1E+A0tDX8/
Yd0KiLiPUuXX4pRrENxO+rQKZpmSYbN8qDePuoSHbtqL14wd3uB/XDS5+QjVt9uZ
chqG0C3eZC8T9VwsQe872egNoplXew==
=XuHw
-----END PGP SIGNATURE-----

--3tvHtXIlroUnRCu8Jx0kThw9FKzY89IwU--
