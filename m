Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA55532B20
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiEXNT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiEXNTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:19:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A799CF01;
        Tue, 24 May 2022 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398337;
        bh=65EdXG8iYMrMIEQ7HLnTZMGlbH5pyG8cM0vD7JOgwbQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dX+xbz59PNh/LqkZcOD+E1JekEohA1uba5qTHLDScx+Plwo4duB+12m6xZi/xelTm
         iONwAgAlGow0SgIKcECsJd/BPAOEGwT/122cc4xdwnrnDHKd6RixBm43lA9zJguixZ
         ggbLkd4zGTApL8gKF0VJbNKPxnEvBJBu34mlwXKM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNh7-1nM3VH2vaJ-00hvo9; Tue, 24
 May 2022 15:18:57 +0200
Message-ID: <2f850377-0adf-cdf3-9fc6-02136b9a5282@gmx.com>
Date:   Tue, 24 May 2022 21:18:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/9] btrfs: add a helpers for read repair testing
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8pNVj46ee9TCixlNoMksNkxN/gqS8s+osICdMnc3Wxn2xYMOYg
 gQr6q9c5EGvuZjBbMsfd5FLgSZgWLyah7zWJtuXmegmtiqZh8+/42KkHWaeWKeZ6HYB5elp
 cIDDL0BWiuWQ8VPsJdq2ky7/wJbDKQyxgWcvInfySydDoKgwrxMUQaORbIJQpeNQjMuF0j7
 RSlGqDSTzGQxpHk10tXTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mAGPqYuaeok=:7PsQ9h2W992VoufJeJ90wW
 rPPnFyrA5C34P2n8SzJJcf9sDc+ly4mRoKO/ETk7QUfSGHrTGubXuAhG3rp+2s12kr8FetpPZ
 knToPVnRJ+9oNZdotA2W4q7UhG9kUZd339FOWZa8mur5tw0Pgybzu0vzpN+M0MYHmziAn9JuL
 A7V8Lhy6JzAnALW1tz0OGKWBndmSAuvy6FpOctxOmBG7WGrHq3Q6XUjOAD5/rwFTCAcqp4mTu
 uAecp84KGiyfiyI0hZlmF1fCgkMVO2LbJhv4IxW0yEFzlxRyqSgFmM6j2DxZN0D5dG0JfrTT9
 Im0Gb+4cPZSoV7NH7pV8KGDYybO7T08Jxow8TmBA3Y4LQ1xtkEiQe+E2PHyYga44ZOIaz3+rP
 kilaRfx2sTiFH8jxpNsX+LMH4KqUCBGYy3bgFTix3giVtVo6mVqbNK1xJ308VL6kCzIYIwnZ4
 YTjHkelMBOW9p+7NHkUOLfhguph9ejAcQhIFFldyr8SMEo+VRczTdMYmWdMeM1rNSd/j2j+sS
 fp3qCJx/S9gs9lIkX6aLv2zFZMXC16mLqwER9s4Phl6A4r7UlgjBWXYPmyahoePigJFaf7inS
 5dBBxk1Kdps0P4qsiqEGKumLYOhUegNlUr+tO73JCbAONf5okkTJYWUhJ3PUz76qvdp100xHR
 ManCPTqk/cU7GBACQvWgB3Sdvv9yDfBsLTzQQMLBvQMy1B7toG+jYLhqzgdelfUWKMHxzq161
 MIBEbMZ+G1rEQm+C0xUlHsEfMgLoWp1WeGv4j0m3ryT+Q/FXWhQMGeSiZVTn1hoA+86Njejh2
 z8N7HYJqAq+bBlu4NYog5+ZxFkRh7Fgvhj+sW7G+nCE7r0pJbI6OGvgzMk5KmYBziaBn9zcOi
 bkJqwsn7ECuWlrApjdBcWcI4e7zTSVmCB9Ezx7sWy2jfpEkYwI+5Rv2w1IzsgVOMShd9Gcdw+
 epM5fa8To6Lce1K/aYCMfO7yA6R0oesJ1vBopl5GUTAeSA8mNncku+z2mTB9afokXOmpo0vGS
 x7SMKZ1K5XMhbJg7fERrP2NpSxPRr7+EvVLYGgiBu9GndEeJjwvHrc7hCBMPqhuTl/sEkXbpP
 a1B1ZOh9X5p0pTFBZniKPwCPtA46qFhImMSvNMF+h1nKnaIV7Z7WcDKcQ==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:18, Christoph Hellwig wrote:
> Add a few helpers to consolidate code for btrfs read repair testing:
>
>   - _btrfs_get_first_logical() gets the btrfs logical address for the
>     first extent in a file
>   - _btrfs_get_device_path and _btrfs_get_physical use the
>     btrfs-map-logical tool to find the device path and physical address
>     for btrfs logical address for a specific mirror
>   - _btrfs_direct_read_on_mirror and _btrfs_buffered_read_on_mirror
>     read the data from a specific mirror
>
> These will be used to consolidate the read repair tests and avoid
> duplication for new tests.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Some some small nitpicks inlined below.
> ---
>   common/btrfs  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   common/config |  1 +
>   2 files changed, 76 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index ac597ca4..129a83f7 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -505,3 +505,78 @@ _btrfs_metadump()
>   	$BTRFS_IMAGE_PROG "$device" "$dumpfile"
>   	[ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &> /dev/=
null
>   }
> +
> +# Return the btrfs logical address for the first block in a file
> +_btrfs_get_first_logical()
> +{
> +	local file=3D$1
> +	_require_command "$FILEFRAG_PROG" filefrag
> +
> +	${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> +	${FILEFRAG_PROG} -v $file | _filter_filefrag | cut -d '#' -f 1
> +}
> +
> +# Find the device path for a btrfs logical offset
> +_btrfs_get_device_path()
> +{
> +	local logical=3D$1
> +	local stripe=3D$2
> +
> +	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
> +}
> +
> +
> +# Find the device physical sector for a btrfs logical offset
> +_btrfs_get_physical()
> +{
> +	local logical=3D$1
> +	local stripe=3D$2
> +
> +	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"

Since the map logical output is saved into seqres, maybe it's better to
add "-b <sectorsize>" parameters.

The default bytes is the nodesize (which is super werid), thus under
corner cases, like at the stripe boundary, it can return multiple result
groups and cause some confusion.

Although we will need another helper to grab the sectorsize of a mounted
btrfs though.

Thanks,
Qu
> +}
> +
> +# Read from a specific stripe to test read recovery that corrupted a sp=
ecific
> +# stripe.  Btrfs uses the PID to select the mirror, so keep reading unt=
il the
> +# xfs_io process that performed the read was executed with a PID that e=
nds up
> +# on the intended mirror.
> +_btrfs_direct_read_on_mirror()
> +{
> +	local mirror=3D$1
> +	local nr_mirrors=3D$2
> +	local file=3D$3
> +	local offset=3D$4
> +	local size=3D$5
> +
> +	while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirror )) &&
> +		exec $XFS_IO_PROG -d \
> +			-c "pread -b $size $offset $size" $file) ]]; do
> +		:
> +	done
> +}
> +
> +# Read from a specific stripe to test read recovery that corrupted a sp=
ecific
> +# stripe.  Btrfs uses the PID to select the mirror, so keep reading unt=
il the
> +# xfs_io process that performed the read was executed with a PID that e=
nds up
> +# on the intended mirror.
> +_btrfs_buffered_read_on_mirror()
> +{
> +	local mirror=3D$1
> +	local nr_mirrors=3D$2
> +	local file=3D$3
> +	local offset=3D$4
> +	local size=3D$5
> +
> +	echo 3 > /proc/sys/vm/drop_caches
> +	while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirror )) &&
> +		exec $XFS_IO_PROG \
> +			-c "pread -b $size $offset $size" $file) ]]; do
> +		:
> +	done
> +}
> diff --git a/common/config b/common/config
> index c6428f90..df20afc1 100644
> --- a/common/config
> +++ b/common/config
> @@ -228,6 +228,7 @@ export E2IMAGE_PROG=3D"$(type -P e2image)"
>   export BLKZONE_PROG=3D"$(type -P blkzone)"
>   export GZIP_PROG=3D"$(type -P gzip)"
>   export BTRFS_IMAGE_PROG=3D"$(type -P btrfs-image)"
> +export BTRFS_MAP_LOGICAL_PROG=3D$(type -P btrfs-map-logical)
>
>   # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>   # newer systems have udevadm command but older systems like RHEL5 don'=
t.
