Return-Path: <linux-btrfs+bounces-18516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01419C296D8
	for <lists+linux-btrfs@lfdr.de>; Sun, 02 Nov 2025 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A4F188D6D3
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Nov 2025 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CFA1DD543;
	Sun,  2 Nov 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VjmE05Td"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C514B663;
	Sun,  2 Nov 2025 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762117258; cv=none; b=UhD9bIgy8ZRkAIo9YzcwrFwUYHEGwVZ2M+gcQRVbxvQFjd2Ps5WdUI3WGFWwNwQ3JxQHfuNNXxOmqnphBIyKAMwOcfT4knTi4o25bnz0/yUjzDdLbwQ52OXSUE2qZRgxPaCUYdj3LoUB4ts/ulWX7W0NV9c6aSY4FvsS5LIs+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762117258; c=relaxed/simple;
	bh=kNd2AEyzXf7OZEn8GMIDi/ecmQIrj6bQRD/V6rI7/Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJ50OOvLTObdW6dzwYwLoVki7/rpPZ6mlfXLalr048bt9gI3xdwQj71kwHf96zr0GOEV2YW7CSmzKIsr0bcIcUlR1uBgIKr3aN+UzkhdOHN+H9iU6w5/uNpp552nJNAw/9Lo0Ql2qZh9ac/y/38P7hZpb8V/b+QXa3JsWaxVqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VjmE05Td; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762117252; x=1762722052; i=quwenruo.btrfs@gmx.com;
	bh=70KXv7diIvZPyg/XsNhP+UUg9/mMhY03gTulDi1Quxw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VjmE05TdhOUFCLhU4OGr3aoFl4KBwWDUE+V27GzVfK+C8dQ6SjlL37nNTbRQMjx6
	 oZyQR628Wvlj5b/sU9lRWlRBegp+/9rl4voblM6uNl0/K2kMQVmSG/LFxsqIyd7tB
	 4vhSbzk+S97PaM/OSKHDEI6uuH6b4seI+LyTMvIBsW7C98P3+Nn4+zMOKO9JnscJi
	 i3hLbGdhKFpvu8Kjo5DcVafbkMUy4RGotsstkuYdZoOP0p9Y64fwknqBT/VpMpcxm
	 rLbmf7Foq08TzpzRQfyvUzTIY/Nt4eeTW2+fUWg/kefGzEU4UQnCaLdxDHwgo/0nj
	 hYF8RCaa9puvNZ98xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mj8qj-1vrlIn09Qb-00cS4Z; Sun, 02
 Nov 2025 22:00:52 +0100
Message-ID: <8068a2bf-293a-4821-8748-6eefac702935@gmx.com>
Date: Mon, 3 Nov 2025 07:30:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: add a new generic test case to verify direct io
 read
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250926095013.136988-1-wqu@suse.com>
 <20251101155702.5e2g42ixg3qvh5b5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <9acb730d-6174-4ae6-a5d8-d1bca947462b@suse.com>
 <20251102100805.qfxyd6zuyobjy6j6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20251102100805.qfxyd6zuyobjy6j6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6MaQPVxO9D9JJc4hfsDFkrNlfEnE1vwBxXMrqMX7wfdmgDbow4q
 kxB+Hrrsv2Th7dMkmKwjDnBrTYnOtcSxASt0WQTTmTb+7+ImeWxXlpEZGkysBrq3/l6IXMm
 I5APa6AdUK3l7u3KQNAnsTcLsafdfIgDGnaKC1P6kyNMZJCsyPFkWbIT30MPdAswqV2hPkT
 Mgbl0AgnC6mHuUNex6UjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9pEKVouhnqo=;nTohwv9XPb5vO/q/6osG3O140Cd
 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
 2i5T4zzexY2vpTAsNy+Ke8SyQbDQUEX1kBLEfW



=E5=9C=A8 2025/11/2 20:38, Zorro Lang =E5=86=99=E9=81=93:
> On Sun, Nov 02, 2025 at 07:42:45AM +1030, Qu Wenruo wrote:
[...]
>> I'll keep pushing the fix so that the test case can be merged with an
>> upstream fix.
>=20
> Oh, thanks for this information! I didn't get any response from btrfs li=
st, I
> thought we've missed this one :) I haven't pushed this test case offical=
ly.
> If the kernel fix is awaiting approval, I don't mind delaying this patch
> merge. Anyway, it's good to be merged into fstests side, if only btrfs s=
ide
> would like to treat this test failure as a bug. If they don't, this case=
 is
> meaningless.
>=20
> What do you think?
>=20
> 1) You can send this patch with my RVB later, after your kernel patch be=
 acked.

I'd prefer this path. It's not a good experience if we merge some test=20
case that we don't have fix, and have to revert the test case later.

Thanks,
Qu

> 2) Or if the btrfs list has treated this as a bug, just need to talk mor=
e about
>     how to fix it, then fstests can merge it to uncover the bug at first=
.
>=20
> Thanks,
> Zorro
>=20
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>>>    .gitignore            |   1 +
>>>>    src/Makefile          |   2 +-
>>>>    src/dio-read-race.c   | 167 ++++++++++++++++++++++++++++++++++++++=
++++
>>>>    tests/generic/772     |  41 +++++++++++
>>>>    tests/generic/772.out |   2 +
>>>>    5 files changed, 212 insertions(+), 1 deletion(-)
>>>>    create mode 100644 src/dio-read-race.c
>>>>    create mode 100755 tests/generic/772
>>>>    create mode 100644 tests/generic/772.out
>>>>
>>>> diff --git a/.gitignore b/.gitignore
>>>> index 82c57f41..3e950079 100644
>>>> --- a/.gitignore
>>>> +++ b/.gitignore
>>>> @@ -210,6 +210,7 @@ tags
>>>>    /src/fiemap-fault
>>>>    /src/min_dio_alignment
>>>>    /src/dio-writeback-race
>>>> +/src/dio-read-race
>>>>    /src/unlink-fsync
>>>>    /src/file_attr
>>>> diff --git a/src/Makefile b/src/Makefile
>>>> index 711dbb91..e7dd4db5 100644
>>>> --- a/src/Makefile
>>>> +++ b/src/Makefile
>>>> @@ -21,7 +21,7 @@ TARGETS =3D dirstress fill fill2 getpagesize holes =
lstat64 \
>>>>    	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
>>>>    	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test \
>>>>    	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-f=
d \
>>>> -	dio-writeback-race unlink-fsync
>>>> +	dio-writeback-race dio-read-race unlink-fsync
>>>>    LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pat=
tern_reader \
>>>>    	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
>>>> diff --git a/src/dio-read-race.c b/src/dio-read-race.c
>>>> new file mode 100644
>>>> index 00000000..7c6389e0
>>>> --- /dev/null
>>>> +++ b/src/dio-read-race.c
>>>> @@ -0,0 +1,167 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * dio-read-race -- test direct IO read with the contents of
>>>> + * the buffer changed during the read, which should not cause any re=
ad error.
>>>> + *
>>>> + * Copyright (C) 2025 SUSE Linux Products GmbH.
>>>> + */
>>>> +
>>>> +/*
>>>> + * dio-read-race
>>>> + *
>>>> + * Compile:
>>>> + *
>>>> + *   gcc -Wall -pthread -o dio-read-race dio-read-race.c
>>>> + *
>>>> + * Make sure filesystems with explicit data checksum can handle dire=
ct IO
>>>> + * reads correctly, so that even the contents of the direct IO buffe=
r changes
>>>> + * during read, the fs should still work fine without data checksum =
mismatch.
>>>> + * (Normally by falling back to buffer IO to keep the checksum and c=
ontents
>>>> + *  consistent)
>>>> + *
>>>> + * Usage:
>>>> + *
>>>> + *   dio-read-race [-b <buffersize>] [-s <filesize>] <filename>
>>>> + *
>>>> + * Where:
>>>> + *
>>>> + *   <filename> is the name of the test file to create, if the file =
exists
>>>> + *   it will be overwritten.
>>>> + *
>>>> + *   <buffersize> is the buffer size for direct IO. Users are respon=
sible to
>>>> + *   probe the correct direct IO size and alignment requirement.
>>>> + *   If not specified, the default value will be 4096.
>>>> + *
>>>> + *   <filesize> is the total size of the test file. If not aligned t=
o <blocksize>
>>>> + *   the result file size will be rounded up to <blocksize>.
>>>> + *   If not specified, the default value will be 64MiB.
>>>> + */
>>>> +
>>>> +#include <fcntl.h>
>>>> +#include <stdlib.h>
>>>> +#include <stdio.h>
>>>> +#include <pthread.h>
>>>> +#include <unistd.h>
>>>> +#include <getopt.h>
>>>> +#include <string.h>
>>>> +#include <errno.h>
>>>> +#include <sys/stat.h>
>>>> +
>>>> +static int fd =3D -1;
>>>> +static void *buf =3D NULL;
>>>> +static unsigned long long filesize =3D 64 * 1024 * 1024;
>>>> +static int blocksize =3D 4096;
>>>> +
>>>> +const int orig_pattern =3D 0x00;
>>>> +const int modify_pattern =3D 0xff;
>>>> +
>>>> +static void *do_io(void *arg)
>>>> +{
>>>> +	ssize_t ret;
>>>> +
>>>> +	ret =3D read(fd, buf, blocksize);
>>>> +	pthread_exit((void *)ret);
>>>> +}
>>>> +
>>>> +static void *do_modify(void *arg)
>>>> +{
>>>> +	memset(buf, modify_pattern, blocksize);
>>>> +	pthread_exit(NULL);
>>>> +}
>>>> +
>>>> +int main (int argc, char *argv[])
>>>> +{
>>>> +	pthread_t io_thread;
>>>> +	pthread_t modify_thread;
>>>> +	unsigned long long filepos;
>>>> +	int opt;
>>>> +	int ret =3D -EINVAL;
>>>> +
>>>> +	while ((opt =3D getopt(argc, argv, "b:s:")) > 0) {
>>>> +		switch (opt) {
>>>> +		case 'b':
>>>> +			blocksize =3D atoi(optarg);
>>>> +			if (blocksize =3D=3D 0) {
>>>> +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
>>>> +				goto error;
>>>> +			}
>>>> +			break;
>>>> +		case 's':
>>>> +			filesize =3D atoll(optarg);
>>>> +			if (filesize =3D=3D 0) {
>>>> +				fprintf(stderr, "invalid filesize '%s'\n", optarg);
>>>> +				goto error;
>>>> +			}
>>>> +			break;
>>>> +		default:
>>>> +			fprintf(stderr, "unknown option '%c'\n", opt);
>>>> +			goto error;
>>>> +		}
>>>> +	}
>>>> +	if (optind >=3D argc) {
>>>> +		fprintf(stderr, "missing argument\n");
>>>> +		goto error;
>>>> +	}
>>>> +	ret =3D posix_memalign(&buf, sysconf(_SC_PAGESIZE), blocksize);
>>>> +	if (!buf) {
>>>> +		fprintf(stderr, "failed to allocate aligned memory\n");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +	fd =3D open(argv[optind], O_DIRECT | O_RDWR | O_CREAT, 0600);
>>>> +	if (fd < 0) {
>>>> +		fprintf(stderr, "failed to open file '%s': %m\n", argv[optind]);
>>>> +		goto error;
>>>> +	}
>>>> +
>>>> +	memset(buf, orig_pattern, blocksize);
>>>> +	/* Create the original file. */
>>>> +	for (filepos =3D 0; filepos < filesize; filepos +=3D blocksize) {
>>>> +
>>>> +		ret =3D write(fd, buf, blocksize);
>>>> +		if (ret < 0) {
>>>> +			ret =3D -errno;
>>>> +			fprintf(stderr, "failed to write the initial content: %m");
>>>> +			goto error;
>>>> +		}
>>>> +	}
>>>> +	ret =3D lseek(fd, 0, SEEK_SET);
>>>> +	if (ret < 0) {
>>>> +		ret =3D -errno;
>>>> +		fprintf(stderr, "failed to set file offset to 0: %m");
>>>> +		goto error;
>>>> +	}
>>>> +
>>>> +	/* Do the read race. */
>>>> +	for (filepos =3D 0; filepos < filesize; filepos +=3D blocksize) {
>>>> +		void *retval =3D NULL;
>>>> +
>>>> +		memset(buf, orig_pattern, blocksize);
>>>> +		pthread_create(&io_thread, NULL, do_io, NULL);
>>>> +		pthread_create(&modify_thread, NULL, do_modify, NULL);
>>>> +		ret =3D pthread_join(io_thread, &retval);
>>>> +		if (ret) {
>>>> +			errno =3D ret;
>>>> +			ret =3D -ret;
>>>> +			fprintf(stderr, "failed to join io thread: %m\n");
>>>> +			goto error;
>>>> +		}
>>>> +		if ((ssize_t )retval < blocksize) {
>>>> +			ret =3D -EIO;
>>>> +			fprintf(stderr, "io thread failed\n");
>>>> +			goto error;
>>>> +		}
>>>> +		ret =3D pthread_join(modify_thread, NULL);
>>>> +		if (ret) {
>>>> +			errno =3D ret;
>>>> +			ret =3D -ret;
>>>> +			fprintf(stderr, "failed to join modify thread: %m\n");
>>>> +			goto error;
>>>> +		}
>>>> +	}
>>>> +error:
>>>> +	close(fd);
>>>> +	free(buf);
>>>> +	if (ret < 0)
>>>> +		return EXIT_FAILURE;
>>>> +	return EXIT_SUCCESS;
>>>> +}
>>>> diff --git a/tests/generic/772 b/tests/generic/772
>>>> new file mode 100755
>>>> index 00000000..46593536
>>>> --- /dev/null
>>>> +++ b/tests/generic/772
>>>> @@ -0,0 +1,41 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2025 2025 SUSE Linux Products GmbH.  All Rights Rese=
rved.
>>>> +#
>>>> +# FS QA Test 772
>>>> +#
>>>> +# Making sure direct IO (O_DIRECT) reads won't cause any data checks=
um mismatch,
>>>> +# even if the contents of the buffer changes during read.
>>>> +#
>>>> +# This is mostly for filesystems with data checksum support, as the =
content can
>>>> +# be modified by user space during checksum verification.
>>>> +#
>>>> +# To avoid such false alerts, such filesystems should fallback to bu=
ffer IO to
>>>> +# avoid inconsistency, and never trust user space memory when checks=
um is involved.
>>>> +# For filesystems without data checksum support, nothing needs to be=
 bothered.
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest auto quick
>>>> +
>>>> +_require_scratch
>>>> +_require_odirect
>>>> +_require_test_program dio-read-race
>>>> +
>>>> +
>>>> +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>>>> +	"btrfs: fallback to buffered read if the inode has data checksum"
>>>> +
>>>> +_scratch_mkfs > $seqres.full 2>&1
>>>> +_scratch_mount
>>>> +
>>>> +blocksize=3D$(_get_file_block_size $SCRATCH_MNT)
>>>> +filesize=3D$(( 64 * 1024 * 1024))
>>>> +
>>>> +echo "blocksize=3D$blocksize filesize=3D$filesize" >> $seqres.full
>>>> +
>>>> +$here/src/dio-read-race -b $blocksize -s $filesize $SCRATCH_MNT/foob=
ar
>>>> +
>>>> +echo "Silence is golden"
>>>> +
>>>> +# success, all done
>>>> +_exit 0
>>>> diff --git a/tests/generic/772.out b/tests/generic/772.out
>>>> new file mode 100644
>>>> index 00000000..98c13968
>>>> --- /dev/null
>>>> +++ b/tests/generic/772.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 772
>>>> +Silence is golden
>>>> --=20
>>>> 2.51.0
>>>>
>>>>
>>>
>>
>=20
>=20


