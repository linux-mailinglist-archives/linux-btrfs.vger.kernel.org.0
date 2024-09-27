Return-Path: <linux-btrfs+bounces-8300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6019882D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261F6B22946
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBD18951F;
	Fri, 27 Sep 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXqLRBYY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A85176231;
	Fri, 27 Sep 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434483; cv=none; b=LdrGN2huFds0fldH4sQz53jMS+t5zYZIY+dJ2wdeZnbrwDSuJ1W1z1Bj+TSlIzq3VRE1hQy1McidfCbZBzA6A503+PTj59fi3e/MRNnp1qqxnSqWntOSJuJ8WoKtB50NF4dFnop0/LWF8VIeqRuKbJWQI6j64E3ebCYERkn3kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434483; c=relaxed/simple;
	bh=zCOOOVSpivC/k/Wdl6RluDvXO+YTl9MX9Jdm/qTk9y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1VlYJaNsUF0qFZni5YxXdvAJTuGiI60S73pVNyd1VaXWDxixSAGSSMrs5R7i09hrkUE61L6w7JpIhIlqZ3HrwAqFDhIzDU//ifHbf3T+gUDNcWoFygy3jZPEoSQjFQmSBKqwaYlIg1TGp+E+QAUt9U2d50Pw/orROZbNf9H12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXqLRBYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B21C4CEC6;
	Fri, 27 Sep 2024 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727434483;
	bh=zCOOOVSpivC/k/Wdl6RluDvXO+YTl9MX9Jdm/qTk9y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RXqLRBYY9c964lMKDCyWPrEJ1o3EjI584SxIA7txbKjTJKaO6+8KXyGvF8ksvSKZ1
	 Ne0BqFFtRsBV0TvJ5JM+5g3Qq7jH0xnRb8qNFHdWI/o8FFhE/RXacqi1wzG6asry+T
	 PsBRbFW7hCdtF/eAVEt9TUs8IC1OgqNVIZ/6ylNt/QxOEvQXkFm4VVjiXqndnL8J4j
	 CSTaxb6N1e09IefsgpbIYxMglrKNUMQPKJfkNNQo5Z5hlHDVQhD109R2J0y+AtWE99
	 3+i9wwNsxeYsMtmLOKJTpS4dDspCnyt1AdNiWwUI8g1JpEAd4G6hgGDGZnrWbIZ1bo
	 UUhNXj9HqmoPQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so523579866b.0;
        Fri, 27 Sep 2024 03:54:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK+va16KSX4aai53hDPC8NOxpkXD5KrfVy4+KXu0FusEDMLNIq6eBMwr0rTfpKpIlKxuk7XGy+vo9nIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7ysK4BV2CTFk10CCjr2XoGftWtMbnCBpheEAho7en2Oiq7K4
	oFFNx0lJmSQBAopmHdzB/WUCZRYJsDJFeBIy+LcWZajQZ9D4ISRK6SjMxrfXTLseobHQZeLhybe
	E9H1xuW22pIkPV+23BJPsWIaXQdo=
X-Google-Smtp-Source: AGHT+IEoF80L4YzRDUxFWHHLCBJpZCOl+MLmZ767CBh5LWgzD3WElFi38aQsJJG3qurg39iQsNdhS7KKVv/nRKy+K7Y=
X-Received: by 2002:a17:907:3f17:b0:a86:8f9b:ef6e with SMTP id
 a640c23a62f3a-a93c30c3d8amr358290266b.13.1727434481718; Fri, 27 Sep 2024
 03:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76d94e63cec4cb04cbfbc0dcd0928f1fbdc27bdf.1727432832.git.fdmanana@suse.com>
 <32a28670-a5bc-4638-b576-1c756417b925@gmx.com>
In-Reply-To: <32a28670-a5bc-4638-b576-1c756417b925@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Sep 2024 11:54:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Smciyr-ZNsoL6qBK2SSz9nSNLkTUVjxVX63xqB+t76w@mail.gmail.com>
Message-ID: <CAL3q7H5Smciyr-ZNsoL6qBK2SSz9nSNLkTUVjxVX63xqB+t76w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test an incremental send scenario with cloning of
 unaligned extent
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:46=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/9/27 19:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that doing an incremental send with a file that had its size
> > decreased and became the destination for a clone operation of an extent
> > with an unaligned end offset that matches the new file size, works
> > correctly.
> >
> > This tests a bug fixed by the following kernel patch:
> >
> >    "btrfs: send: fix invalid clone operation for file that got its size=
 decreased"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just a small nitpick.
>
> [...]
> > +. ./common/filter
> > +. ./common/reflink
> > +. ./common/punch # for _filter_fiemap_flags
> > +
> > +_require_test
>
> Initially I thought test is not necessary, but later turns out that
> we're using TEST_MNT to store the two streams.
>
> May be we can just reuse $tmp.*?

Why?
The test device is always present, or are there any setups where there's no=
ne?

We use this pattern to store in the test mount because such files
could be big (not in this case however) and /tmp is usually much
smaller.
That's the recommendation I once got many years ago.

>
> Thanks,
> Qu
>
> > +_require_scratch_reflink
> > +_require_xfs_io_command "fiemap"
> > +_require_odirect
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: send: fix invalid clone operation for file that got its s=
ize decreased"
> > +
> > +check_all_extents_shared()
> > +{
> > +     local file=3D$1
> > +     local fiemap_output
> > +
> > +     fiemap_output=3D$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_=
fiemap_flags)
> > +     echo "$fiemap_output" | grep -qv 'shared'
> > +     if [ $? -eq 0 ]; then
> > +             echo -e "Found non-shared extents for file $file:\n"
> > +             echo "$fiemap_output"
> > +     fi
> > +}
> > +
> > +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > +full_send_stream=3D$send_files_dir/full_snap.stream
> > +inc_send_stream=3D$send_files_dir/inc_snap.stream
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> > +_scratch_mount
> > +
> > +# Create a file with a size of 256K + 5 bytes, having two extents, the=
 first one
> > +# with a size of 128K and the second one with a size of 128K + 5 bytes=
.
> > +last_extent_size=3D$((128 * 1024 + 5))
> > +$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
> > +             -c "pwrite -S 0xcd -b $last_extent_size 128K $last_extent=
_size" \
> > +             $SCRATCH_MNT/foo | _filter_xfs_io
> > +
> > +# Another file which we will later clone foo into, but initially with
> > +# a larger size than foo.
> > +$XFS_IO_PROG -f -c "pwrite -b 0xef 0 1M" $SCRATCH_MNT/bar | _filter_xf=
s_io
> > +
> > +echo "Creating snapshot and the full send stream for it..."
> > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> > +$BTRFS_UTIL_PROG send -f $full_send_stream $SCRATCH_MNT/snap1 >> $seqr=
es.full 2>&1
> > +
> > +# Now resize bar and clone foo into it.
> > +$XFS_IO_PROG -c "truncate 0" \
> > +          -c "reflink $SCRATCH_MNT/foo" $SCRATCH_MNT/bar | _filter_xfs=
_io
> > +
> > +echo "Creating another snapshot and the incremental send stream for it=
..."
> > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> > +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $inc_send_stream \
> > +              $SCRATCH_MNT/snap2 >> $seqres.full 2>&1
> > +
> > +echo "File digests in the original filesystem:"
> > +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> > +
> > +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> > +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> > +
> > +echo "Creating a new filesystem to receive the send streams..."
> > +_scratch_unmount
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> > +_scratch_mount
> > +
> > +$BTRFS_UTIL_PROG receive -f $full_send_stream $SCRATCH_MNT
> > +$BTRFS_UTIL_PROG receive -f $inc_send_stream $SCRATCH_MNT
> > +
> > +echo "File digests in the new filesystem:"
> > +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> > +
> > +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> > +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/322.out b/tests/btrfs/322.out
> > new file mode 100644
> > index 00000000..31e1ee55
> > --- /dev/null
> > +++ b/tests/btrfs/322.out
> > @@ -0,0 +1,24 @@
> > +QA output created by 322
> > +wrote 131072/131072 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 131077/131077 bytes at offset 131072
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 1048576/1048576 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Creating snapshot and the full send stream for it...
> > +linked 0/0 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Creating another snapshot and the incremental send stream for it...
> > +File digests in the original filesystem:
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> > +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
> > +Creating a new filesystem to receive the send streams...
> > +At subvol snap1
> > +At snapshot snap2
> > +File digests in the new filesystem:
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> > +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
>

