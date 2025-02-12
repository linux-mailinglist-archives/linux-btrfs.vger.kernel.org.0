Return-Path: <linux-btrfs+bounces-11392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426AA31C86
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 04:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDDB1882E2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 03:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D1F1D6DBB;
	Wed, 12 Feb 2025 03:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="f6RFv4n4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1FC148;
	Wed, 12 Feb 2025 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329330; cv=none; b=H/E9R0eziKKUTycikvp2XDNRcywe0yVC55kwF19JzLh5a78F9oSqL5gGWGMDgNdpZlZEIhIa9qfHoIIVp5F0520zBUZXnREcTbTORucQiuB6L0EpHmcHzmcb4Rq15gX8XSC4vD2lPCPGeA3J7pu+9jpJp0yYsLBtvmHmZQ3Spgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329330; c=relaxed/simple;
	bh=c9y7KP3Kvu+RjmbgFuHHJRueqDDPMIfLT4nPsWUO4NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACjPi2GkBCi7u0nTzQ0xp3Nbz2WlMD/zR3vuM9RLn9k32wy8P/6Yw1agDle9y/IjBnk1DvlSDl78yLV0Z799COxLxvtmpMkZbqZ20Iu2rcVtMOZcjyixbH022qPCQ1GmBaTDldLfFOGpm9co2uz8je/RG/FEKmv+c48wko+NXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=f6RFv4n4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739329326; x=1739934126; i=quwenruo.btrfs@gmx.com;
	bh=dDiHOcvPGO+cjZnBNEO8si0Q6wrtHWWiwL7SOfq7SS4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f6RFv4n4SK84HlMOJtJtsljYs81SfRQLU1pGubZmn+sBDt4UAIb2G2anKF1no0fP
	 ouqvMNwpIaxuUMyTMJqqw3LpAOdr4Sy2OG9j63bMZgrJ91/oItXrtqDaCun0xjPDL
	 DkcO6uPyKPVJqfoU1khqb48c+BwpDUOIb3P3Dr+ew4o2jFO/mQ8lhQZdAYF5IdcSX
	 PR7zPk6pJkcU4IYXmpRTdtAqBZYVZoaBobjHar0Xpg3AtQP17h/nJkl3GsSJsSCaE
	 jhfOCUiHS3tE88EgFCZ4FI2oV6wFR/X4NtecE12wly7AjBM8bzHY9d4QKl4CmQJaT
	 SZBVxgNA4FuuwACWbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpSb-1tBTDY0oS9-00qfFl; Wed, 12
 Feb 2025 04:02:05 +0100
Message-ID: <4bdf2790-4fe8-4451-9bc8-9aadc65fe5f5@gmx.com>
Date: Wed, 12 Feb 2025 13:32:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: add a generic test to verify direct IO writes
 with buffer contents change
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <d9c50aa0df6cde2cb39cb7c9f978dbc27dadb770.1739241217.git.wqu@suse.com>
 <20250212025503.cg5452r6swki6m3a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250212025503.cg5452r6swki6m3a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iKw9zB5TYn0tOtfPFhD2Po+8uYqFpJxtuISdiAu9VTxsoL+3OZU
 ir+1YTbIoTQvUFvUKqkSkfjtcIlBu+0/QbrNtVuFHqU0egZ9N04J4GUnYkj3J4pGrmCVLb+
 B5Z+S1EcLh7PLv7oxAmlUB3wcIXS9VJSA2jwbaKQVttnAPtnvuASKD1R0F7dFN8yNsi0pAf
 GCs9vXz62eaO3G8FOiWlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tlXSi40hn+Y=;ZMJdkErfhWdeOED49fiXxJI10C1
 nFDl7o00ySanepjRgWjU8OVtvhc/mR04ZXlFfXdwRVpOH4P04t+nzG3T5jQtnZPl5Sh/OVbEX
 /H6FxKANr95kC9XbbH7xiiENIP766JOyY1Zg3saq8U//zIhvFproujwi+4Y++YhIoTtSMkygH
 zZq0imd6Z3rt9FRnpa8p451ARTfXqUqQdIg7lzmeUQD+lgsn+h5V7zl9LEo0UPeDf/zr1BwF1
 QjANkl6KgC0yD1hHJsw84HEwTSJR9s3HkiUDtYLtbbEuUXlOsBIoeCgKVP65inDv5CmKWYzHE
 +LdzQangZFlIWa9jEByoWH3hMC1sB9VG1trMsb5/q/BhM+j7GlpATs6iMyPzBS89abih7DV+v
 r7FrCKgl5se3M3x3zlze2X12dLR5fYH/CEm93abPfoXBEK7iLX4vagKNsIOxHro4depNkOM2/
 v7E0HKZZcwm1xclXgNKt6STKvEf7M6PEnVV1MtDlQvBC5I89T8VkYUcKkoSx/Fh2ywTUOqXeo
 L6X3yeL24AkWWVPlxE8N+0WCJHxeXLZodN7WfU9heDdjafSvFKFCPhIiMpaqueoewiVJLLm8c
 oKJrmCVeAcu8z+C+BKgI20NuldggEDJF3bUlvKN/mNhaevN0UGvg0CIDKn+JW/10/cm2IzhPU
 ApId+WR355dEbz1zMC+3kwt2YJKKqFNEp+h+UW8v9lWLfLgWgdQ02Wv1RqcGjGiu/MNKQ//f4
 uQOlorM3UDAU3jw2V00dDOL4vACQK6Q4VMCff1XVRnaYEL04fGp1BZReL2r/JLcrqCfxqNuK3
 U9OT9kb11zRlsQDqBF5Et8pqrPQfAgIXHQUS9Khb0EUEYxfy0VDdTT38ayRi9AYgSYFPea+cm
 Y3vse4QpD4f8BvkIZU2hzdXUDtqi4LbfOuywpiT0v4J98UQ2htHELcPVFlOPZai37P0qfJau5
 d4AraGzgcuF9Vuiz35+3R4GactRF2MEpJDKHB/4V10NcekWdajcegDKOfXvuEJ6LR4CN6By0l
 2cQNSB77b3UwY/3CNa8UL58i+XNgmwak0AvyED6SO4Zb37CwhL4ukw0IgwZ7VsuZ2m+NYW50G
 rn87YQd8ya7V5maZmFYmwYKuYu7rtcgJlL7aXmHCfNLd6kLHXndgsYaqSdgQU/98PhSfHMBvR
 l7HweT/O4nvN+fQzHgFHjaA9tLEedDjerH1xjWdUa1e2xVldij8aRGuYagAr9IYv7dBNFvvn8
 LOo7njwy/jj1TztB7YwSZFLv2bmD1X5DCHMP7vpOg7iB1oOMg2KPUv0JSPubrpb2Az33fWCrO
 jOSFgOGXfvWTeuRW5n0EI2+XMMpLTy5VvVuRVNlWuqRs9GxtWzkBDh1eLqWKA7/Vp+ixus5oJ
 Up7OOnz+fihIVzkjW8Dke9p8ZEsdMLMl20e1wc5nz+G0nBbx2lVrPtin92



=E5=9C=A8 2025/2/12 13:25, Zorro Lang =E5=86=99=E9=81=93:
> On Tue, Feb 11, 2025 at 04:22:57PM +1030, Qu Wenruo wrote:
>> There is a long existing btrfs problem that if some one is modifying th=
e
>> buffer of an on-going direct IO write, it has a very high chance causin=
g
>> permanent data checksum mismatch.
>>
>> This is caused by the following factors:
>>
>> - Direct IO buffer is out of the control of filesystem
>>    Thus user space can modify the contents during writeback.
>>
>> - Btrfs generate its data checksum just before submitting the bio
>>    This means if the contents happens after the checksum is generated,
>>    the data written to disk will no longer match the checksum.
>>
>> Btrfs later fixes the problem by forcing the direct IO to fallback to
>> buffered IO (if the inode requires data checksum), so that btrfs can
>> have a consistent view of the buffer.
>>
>> This test case will verify the behavior by:
>>
>> - Create a helper program 'dio-writeback-race'
>>    Which does direct IO writes block-by-block, and the buffer is always
>>    initialized to all 0xff before write,
>>    Then starting two threads:
>>    - One to submit the direct IO
>>    - One to modify the buffer to 0x00
>>
>>    The program uses 4K as default block size, and 64MiB as the default
>>    file size.
>>    Which is more than enough to trigger tons of btrfs checksum errors
>>    on unpatched kernels.
>>
>> - New test case generic/761
>>    Which will:
>>
>>    * Use above program to create a 64MiB file
>>
>>    * Do buffered read on that file
>>      Since above program is doing direct IO, there is no page cache
>>      populated.
>>      And the buffered read will need to read out all data from the disk=
,
>>      and if the filesystem supports data checksum, then the data checks=
um
>>      will also be verified against the data.
>>
>> The test case passes on the following fses:
>> - ext4
>> - xfs
>> - btrfs with "nodatasum" mount option
>>    No data checksum to bother.
>>
>> - btrfs with default "datasum" mount option and the fix "btrfs: always
>>    fallback to buffered write if the inode requires checksum"
>>    This makes btrfs to fallback on buffered IO so the contents won't
>>    change during writeback of page cache.
>>
>> And fails on the following fses:
>>
>> - btrfs with default "datasum" mount option and without the fix
>>    Expected.
>>
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix the comment on the default block size of dio-writeback-race
>> - Use proper type for pthread_exit() of do_io() function
>> - Fix the error message when filesize is invalid
>> - Fix the error message when unknown option is parsed
>> - Catch the thread return value correctly for pthread_join() on IO thre=
ad
>> - Always update @ret
>> - Return EXIT_SUCCESS/FAILURE based on @ret at error: tag
>> - Check the return value of pthread_join() correctly
>> - Remove unused cleanup override/include comments from the test case
>> - Add the missing fixed-by tag
>> ---
>>   .gitignore               |   1 +
>>   src/Makefile             |   3 +-
>>   src/dio-writeback-race.c | 148 ++++++++++++++++++++++++++++++++++++++=
+
>>   tests/generic/761        |  41 +++++++++++
>>   tests/generic/761.out    |   2 +
>>   5 files changed, 194 insertions(+), 1 deletion(-)
>>   create mode 100644 src/dio-writeback-race.c
>>   create mode 100755 tests/generic/761
>>   create mode 100644 tests/generic/761.out
>>
>> diff --git a/.gitignore b/.gitignore
>> index efd477738e1e..7060f52cf6b8 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -210,6 +210,7 @@ tags
>>   /src/perf/*.pyc
>>   /src/fiemap-fault
>>   /src/min_dio_alignment
>> +/src/dio-writeback-race
>>
>>   # Symlinked files
>>   /tests/generic/035.out
>> diff --git a/src/Makefile b/src/Makefile
>> index 1417c383863e..6ac72b366257 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -20,7 +20,8 @@ TARGETS =3D dirstress fill fill2 getpagesize holes ls=
tat64 \
>>   	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>>   	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>>   	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-=
test \
>> -	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd
>> +	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
>> +	dio-writeback-race
>>
>>   LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_patter=
n_reader \
>>   	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
>> diff --git a/src/dio-writeback-race.c b/src/dio-writeback-race.c
>> new file mode 100644
>> index 000000000000..f0a2f6de531b
>> --- /dev/null
>> +++ b/src/dio-writeback-race.c
>> @@ -0,0 +1,148 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dio_writeback_race -- test direct IO writes with the contents of
>> + * the buffer changed during writeback.
>> + *
>> + * Copyright (C) 2025 SUSE Linux Products GmbH.
>> + */
>> +
>> +/*
>> + * dio_writeback_race
>> + *
>> + * Compile:
>> + *
>> + *   gcc -Wall -pthread -o dio_writeback_race dio_writeback_race.c
>> + *
>> + * Make sure filesystems with explicit data checksum can handle direct=
 IO
>> + * writes correctly, so that even the contents of the direct IO buffer=
 changes
>> + * during writeback, the fs should still work fine without data checks=
um mismatch.
>> + * (Normally by falling back to buffer IO to keep the checksum and con=
tents
>> + *  consistent)
>> + *
>> + * Usage:
>> + *
>> + *   dio_writeback_race [-b <buffersize>] [-s <filesize>] <filename>
>> + *
>> + * Where:
>> + *
>> + *   <filename> is the name of the test file to create, if the file ex=
ists
>> + *   it will be overwritten.
>> + *
>> + *   <buffersize> is the buffer size for direct IO. Users are responsi=
ble to
>> + *   probe the correct direct IO size and alignment requirement.
>> + *   If not specified, the default value will be 4096.
>> + *
>> + *   <filesize> is the total size of the test file. If not aligned to =
<blocksize>
>> + *   the result file size will be rounded up to <blocksize>.
>> + *   If not specified, the default value will be 64MiB.
>> + */
>> +
>> +#include <fcntl.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <pthread.h>
>> +#include <unistd.h>
>> +#include <getopt.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <sys/stat.h>
>> +
>> +static int fd =3D -1;
>> +static void *buf =3D NULL;
>> +static unsigned long long filesize =3D 64 * 1024 * 1024;
>> +static int blocksize =3D 4096;
>> +
>> +const int orig_pattern =3D 0xff;
>> +const int modify_pattern =3D 0x00;
>> +
>> +static void *do_io(void *arg)
>> +{
>> +	ssize_t ret;
>> +
>> +	ret =3D write(fd, buf, blocksize);
>> +	pthread_exit((void *)ret);
>> +}
>> +
>> +static void *do_modify(void *arg)
>> +{
>> +	memset(buf, modify_pattern, blocksize);
>> +	pthread_exit(NULL);
>> +}
>> +
>> +int main (int argc, char *argv[])
>> +{
>> +	pthread_t io_thread;
>> +	pthread_t modify_thread;
>> +	unsigned long long filepos;
>> +	int opt;
>> +	int ret =3D -EINVAL;
>> +
>> +	while ((opt =3D getopt(argc, argv, "b:s:")) > 0) {
>> +		switch (opt) {
>> +		case 'b':
>> +			blocksize =3D atoi(optarg);
>> +			if (blocksize =3D=3D 0) {
>> +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
>> +				goto error;
>> +			}
>> +			break;
>> +		case 's':
>> +			filesize =3D atoll(optarg);
>> +			if (filesize =3D=3D 0) {
>> +				fprintf(stderr, "invalid filesize '%s'\n", optarg);
>> +				goto error;
>> +			}
>> +			break;
>> +		default:
>> +			fprintf(stderr, "unknown option '%c'\n", opt);
>> +			goto error;
>> +		}
>> +	}
>> +	if (optind >=3D argc) {
>> +		fprintf(stderr, "missing argument\n");
>> +		goto error;
>> +	}
>> +	ret =3D posix_memalign(&buf, blocksize, blocksize);
>> +	if (!buf) {
>> +		fprintf(stderr, "failed to allocate aligned memory\n");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	fd =3D open(argv[optind], O_DIRECT | O_WRONLY | O_CREAT);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "failed to open file '%s': %m\n", argv[2]);
>> +		goto error;
>> +	}
>> +
>> +	for (filepos =3D 0; filepos < filesize; filepos +=3D blocksize) {
>> +		void *retval =3D NULL;
>> +
>> +		memset(buf, orig_pattern, blocksize);
>> +		pthread_create(&io_thread, NULL, do_io, NULL);
>> +		pthread_create(&modify_thread, NULL, do_modify, NULL);
>> +		ret =3D pthread_join(io_thread, &retval);
>> +		if (ret) {
>> +			errno =3D ret;
>> +			ret =3D -ret;
>> +			fprintf(stderr, "failed to join io thread: %m\n");
>> +			goto error;
>> +		}
>> +		if ((ssize_t )retval < blocksize) {
>> +			ret =3D -EIO;
>> +			fprintf(stderr, "io thread failed\n");
>> +			goto error;
>> +		}
>> +		ret =3D pthread_join(modify_thread, NULL);
>> +		if (ret) {
>> +			errno =3D ret;
>> +			ret =3D -ret;
>> +			fprintf(stderr, "failed to join modify thread: %m\n");
>> +			goto error;
>> +		}
>> +	}
>> +error:
>> +	close(fd);
>> +	free(buf);
>> +	if (ret < 0)
>> +		return EXIT_FAILURE;
>> +	return EXIT_SUCCESS;
>> +}
>> diff --git a/tests/generic/761 b/tests/generic/761
>> new file mode 100755
>> index 000000000000..422b716d31b6
>> --- /dev/null
>> +++ b/tests/generic/761
>> @@ -0,0 +1,41 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 761
>> +#
>> +# Making sure direct IO (O_DIRECT) writes won't cause any data checksu=
m mismatch,
>> +# even if the contents of the buffer changes during writeback.
>> +#
>> +# This is mostly for filesystems with data checksum support, which sho=
uld fallback
>> +# to buffer IO to avoid inconsistency.
>> +# For filesystems without data checksum support, nothing needs to be b=
othered.
>> +#
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +_require_scratch
>> +_require_odirect
>> +_require_test_program dio-writeback-race
>> +_fixed_by_kernel_commit XXXXXXXX \
>> +	"btrfs: always fallback to buffered write if the inode requires check=
sum"
>> +
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +blocksize=3D$(_get_block_size $SCRATCH_MNT)
>
> _get_file_block_size ? Others looks good to me.

Thanks for pointing out the helper, indeed there are some extra handling
for ocfs2 and xfs.

>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
> I'll help to do these changes from all review points when I merge it, if=
 you
> don't want to change it more.

No worry, I was just going to send out a v3, I will address the
_get_file_block_size() and add your tag in the newer version.

Thanks,
Qu

>
> Thanks,
> Zorro
>
>> +filesize=3D$(( 64 * 1024 * 1024))
>> +
>> +echo "blocksize=3D$blocksize filesize=3D$filesize" >> $seqres.full
>> +
>> +$here/src/dio-writeback-race -b $blocksize -s $filesize $SCRATCH_MNT/f=
oobar
>> +
>> +# Read out the file, which should trigger checksum verification
>> +cat $SCRATCH_MNT/foobar > /dev/null
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/generic/761.out b/tests/generic/761.out
>> new file mode 100644
>> index 000000000000..72ebba4cb426
>> --- /dev/null
>> +++ b/tests/generic/761.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 761
>> +Silence is golden
>> --
>> 2.48.1
>>
>>
>
>


