Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7224D11A9CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKLYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 06:24:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:59592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727469AbfLKLYm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 06:24:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD8FDAC66;
        Wed, 11 Dec 2019 11:24:38 +0000 (UTC)
Subject: Re: [PATCH 2/3] fstests: btrfs/14[23]: Use proper help to get both
 devid and physical offset for corruption.
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <20191211104029.25541-1-wqu@suse.com>
 <20191211104029.25541-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67bd6079-830f-ba62-d4e4-83d537572236@suse.com>
Date:   Wed, 11 Dec 2019 13:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211104029.25541-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.12.19 г. 12:40 ч., Qu Wenruo wrote:
> [BUG]
> When using btrfs-progs v5.4, btrfs/142 and btrfs/143 will fail:
> btrfs/142 1s ... - output mismatch (see xfstests/results//btrfs/142.out.bad)
>     --- tests/btrfs/142.out 2018-09-16 21:30:48.505104287 +0100
>     +++ xfstests/results//btrfs/142.out.bad
> 2019-12-10 15:35:40.280392626 +0000
>     @@ -3,37 +3,37 @@
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      wrote 65536/65536 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
>     ...
>     (Run 'diff -u xfstests/tests/btrfs/142.out xfstests/results//btrfs/142.out.bad' to see the entire diff)
> 
> [CAUSE]
> Btrfs/14[23] test whether a read on corrupted stripe will re-silver
> itself.
> Such test by its nature will need to modify on-disk data, thus need to
> get the btrfs logical -> physical mapping, which is done by near
> hard-coded lookup function, which rely on certain stripe:devid sequence.
> 
> Recent btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid
> order to the stripe index") changes how we use devices in mkfs.btrfs,
> this caused a change in chunk layout, and break the hard-coded
> stripe:devid sequence.
> 
> [FIX]
> This patch will do full devid and physical offset lookup, instead of old
> physical offset only lookup.
> 
> The only assumption made is, mkfs.btrfs assigns devid sequentially for
> its devices.
> Which means, for "mkfs.btrfs $dev1 $dev2 $dev3", we get devid 1 for $dev1,
> devid 2 for $dev2, and so on.
> 
> This change will allow btrfs/14[23] to handle even future chunk layout
> change. (Although I hope this will never happen again).
> 
> This also addes extra debug output (although less than 10 lines) into
> $seqres.full, just in case when layout changes and current lookup can't
> handle it, developer can still pindown the problem easily.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Tested-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  tests/btrfs/142     | 50 +++++++++++++++++++++++++++++++--------------
>  tests/btrfs/142.out |  2 --
>  tests/btrfs/143     | 48 +++++++++++++++++++++++++++++++------------
>  tests/btrfs/143.out |  2 --
>  4 files changed, 70 insertions(+), 32 deletions(-)
> 
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index a23fe1bf..9c037ff6 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -47,30 +47,45 @@ _require_command "$FILEFRAG_PROG" filefrag
>  
>  get_physical()
>  {
> -        # $1 is logical address
> -        # print chunk tree and find devid 2 which is $SCRATCH_DEV
> +	local logical=$1
> +	local stripe=$2
>          $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> -	grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 }'
> +		grep $logical -A 6 | \
> +		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
>  }
>  
> +get_devid()
> +{
> +	local logical=$1
> +	local stripe=$2
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> +		grep $logical -A 6 | \
> +		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
> +}
>  
> -SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
> +get_device_path()
> +{
> +	local devid=$1
> +	echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
> +}
>  
>  start_fail()
>  {
> +	local sysfs_bdev="$1"
>  	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
>  	echo 2 > $DEBUGFS_MNT/fail_make_request/times
>  	echo 1 > $DEBUGFS_MNT/fail_make_request/task-filter
>  	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
> -	echo 1 > $SYSFS_BDEV/make-it-fail
> +	echo 1 > $sysfs_bdev/make-it-fail
>  }
>  
>  stop_fail()
>  {
> +	local sysfs_bdev="$1"
>  	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
>  	echo 0 > $DEBUGFS_MNT/fail_make_request/times
>  	echo 0 > $DEBUGFS_MNT/fail_make_request/task-filter
> -	echo 0 > $SYSFS_BDEV/make-it-fail
> +	echo 0 > $sysfs_bdev/make-it-fail
>  }
>  
>  _scratch_dev_pool_get 2
> @@ -87,17 +102,23 @@ _scratch_mount -o nospace_cache,nodatasum
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>  	_filter_xfs_io_offset
>  
> -# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
> -# one in $SCRATCH_DEV_POOL
> +# step 2, corrupt the first 64k of stripe #1
>  echo "step 2......corrupt file extent" >>$seqres.full
>  
>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>  logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> -physical_on_scratch=`get_physical ${logical_in_btrfs}`
> +physical=`get_physical ${logical_in_btrfs} 1`
> +devid=$(get_devid ${logical_in_btrfs} 1)
> +target_dev=$(get_device_path $devid)
> +
> +SYSFS_BDEV=`_sysfs_dev $target_dev`
>  
>  _scratch_unmount
> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
> -	_filter_xfs_io_offset
> +$BTRFS_UTIL_PROG ins dump-tree -t 3 $SCRATCH_DEV | \
> +	grep $logical_in_btrfs -A 6 >> $seqres.full
> +echo "Corrupt stripe 1 devid $devid devpath $target_dev physical $physical" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /dev/null
>  
>  _scratch_mount -o nospace_cache
>  
> @@ -106,8 +127,7 @@ echo "step 3......repair the bad copy" >>$seqres.full
>  
>  # since raid1 consists of two copies, and the bad copy was put on stripe #1
>  # while the good copy lies on stripe #0, the bad copy only gets access when the
> -# reader's pid % 2 == 1 is true
> -start_fail
> +start_fail $SYSFS_BDEV
>  while [[ -z ${result} ]]; do
>  	# enable task-filter only fails the following dio read so the repair is
>  	# supposed to work.
> @@ -117,12 +137,12 @@ while [[ -z ${result} ]]; do
>  		exec $XFS_IO_PROG -d -c \"pread -b 128K 0 128K\" \"$SCRATCH_MNT/foobar\"
>  	fi");
>  done
> -stop_fail
> +stop_fail $SYSFS_BDEV
>  
>  _scratch_unmount
>  
>  # check if the repair works
> -$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV |\
> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev | \
>  	_filter_xfs_io_offset
>  
>  _scratch_dev_pool_put
> diff --git a/tests/btrfs/142.out b/tests/btrfs/142.out
> index 0f32ffbe..2e22f292 100644
> --- a/tests/btrfs/142.out
> +++ b/tests/btrfs/142.out
> @@ -1,8 +1,6 @@
>  QA output created by 142
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 91af52f9..b2ffeb63 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -54,30 +54,48 @@ _require_command "$FILEFRAG_PROG" filefrag
>  
>  get_physical()
>  {
> -        # $1 is logical address
> -        # print chunk tree and find devid 2 which is $SCRATCH_DEV
> +	local logical=$1
> +	local stripe=$2
>          $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> -	grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 }'
> +		grep $logical -A 6 | \
> +		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
> +}
> +
> +get_devid()
> +{
> +	local logical=$1
> +	local stripe=$2
> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
> +		grep $logical -A 6 | \
> +		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
> +}
> +
> +get_device_path()
> +{
> +	local devid=$1
> +	echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
>  }
>  
>  SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
>  
>  start_fail()
>  {
> +	local sysfs_bdev="$1"
>  	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
>  	# the 1st one fails the first bio which is reading 4k (or more due to
>  	# readahead), and the 2nd one fails the retry of validation so that it
>  	# triggers read-repair
>  	echo 2 > $DEBUGFS_MNT/fail_make_request/times
>  	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
> -	echo 1 > $SYSFS_BDEV/make-it-fail
> +	echo 1 > $sysfs_bdev/make-it-fail
>  }
>  
>  stop_fail()
>  {
> +	local sysfs_bdev="$1"
>  	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
>  	echo 0 > $DEBUGFS_MNT/fail_make_request/times
> -	echo 0 > $SYSFS_BDEV/make-it-fail
> +	echo 0 > $sysfs_bdev/make-it-fail
>  }
>  
>  _scratch_dev_pool_get 2
> @@ -94,17 +112,21 @@ _scratch_mount -o nospace_cache,nodatasum
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>  	_filter_xfs_io_offset
>  
> -# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
> -# one in $SCRATCH_DEV_POOL
> +# step 2, corrupt the first 64k of stripe #1
>  echo "step 2......corrupt file extent" >>$seqres.full
>  
>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>  logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
> -physical_on_scratch=`get_physical ${logical_in_btrfs}`
> +physical=`get_physical ${logical_in_btrfs} 1`
> +devid=$(get_devid ${logical_in_btrfs} 1)
> +target_dev=$(get_device_path $devid)
>  
> +SYSFS_BDEV=`_sysfs_dev $target_dev`
>  _scratch_unmount
> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
> -	_filter_xfs_io_offset
> +
> +echo "corrupt stripe 1 devid $devid devpath $target_dev physical $physical" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /dev/null
>  
>  _scratch_mount -o nospace_cache
>  
> @@ -118,18 +140,18 @@ while [[ -z ${result} ]]; do
>      # invalidate the page cache.
>      _scratch_cycle_mount
>  
> -    start_fail
> +    start_fail $SYSFS_BDEV
>      result=$(bash -c "
>          if [[ \$((\$\$ % 2)) -eq 1 ]]; then
>                  exec $XFS_IO_PROG -c \"pread 0 4K\" \"$SCRATCH_MNT/foobar\"
>          fi");
> -    stop_fail
> +    stop_fail $SYSFS_BDEV
>  done
>  
>  _scratch_unmount
>  
>  # check if the repair works
> -$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV |\
> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev |\
>  	_filter_xfs_io_offset
>  
>  _scratch_dev_pool_put
> diff --git a/tests/btrfs/143.out b/tests/btrfs/143.out
> index 66afea4b..a9e82ceb 100644
> --- a/tests/btrfs/143.out
> +++ b/tests/btrfs/143.out
> @@ -1,8 +1,6 @@
>  QA output created by 143
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> 
