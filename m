Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC76259BB1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiHVIJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiHVIIn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 04:08:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A32CE35
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661155677;
        bh=1hLS3dzFYetSB6DjOSNw59zAuyD9PSpY/YNUr0mmYDQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=awZA6uC4MsXHbOrkaioVeUnyAr8fNbsUzDmIX59ew16Tl0iaClRMagHEGVko3m/ds
         b6pecxNfH6xxuZN9+Zh/Uhnzfln2UcmcAkyXD9LU2kSSi9y4a3+ymaF0aUa+M3cKnB
         IT4aR2Vf611hWM05D6+FV9m4U+6I0P7LgcJaAtlw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvY8-1our0O426K-00Uvam; Mon, 22
 Aug 2022 10:07:57 +0200
Message-ID: <ecfb1ac1-1b1d-e2da-82b8-fd6b0627acd4@gmx.com>
Date:   Mon, 22 Aug 2022 16:07:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs-progs: scrub: add extra warning for scrub on single
 device
Content-Language: en-US
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <7834c0cac7eaa195952b7450c4d4a150376ba21e.1661152421.git.wqu@suse.com>
 <8c703e22-3425-0e7a-23d3-41793d7ed6e7@cobb.uk.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8c703e22-3425-0e7a-23d3-41793d7ed6e7@cobb.uk.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Mrm9l6IaemAxvXv4cXLoeVs8k0M0uDVaJQv8zOvFuKt4qDzNqk
 wDUKxz60BpxixFEhcVYbTiyW5Qauq1gU+URwlJlPrrbp90qRNAysI14fdtW8YKV9bby3CmR
 UyGjn4EIfPExRfktEqKKg2GgKfcxaL8YT6A3+OLNA+IokWnZbS58JeQXc6X3G9FxCn7MoQ6
 nzZqGvW0ONe+xAdC+uUUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bg+ixwYCt2Y=:PK85pdaIKFpHIRHGEzMMlk
 OWooYbyuoaKZAGHlHGO76dsFyMSTu7rGIfZIuhAYCXL8E19dF9c1SpMhHY2SkTN+rmElkTn/X
 6Zk0HE4miKBIVelwYGQn0Q+NxwLHBbzM9ck9S25fPFN4m5KEZ0AqlMCQz94jKPTUVSf+eqtTE
 xvCZUIBDerePuz87Wg5evtbBqi+HmuEOm+bEDVC6bHlOsTbCzqaJ8uxK3mJb9uQXqs5QpGFwn
 OM2GguinPFT41kK3eMH2BN1np+pzziqFWh6CDDPqMYW8SUXFg/5mY25myd9iqN2PjXZNWlbkC
 nspKqYApwsVznfUGmtfWpZxfIqKKVeuByy9q+FDs3DlwBHKb8URZmzbTtcnJhxorn8v00+dRc
 C8cr7h2sz4ycqBCmevdHGC4jGiZc+KDgbiUzbUOZSTNvU1Nb80eStpPGYRvXTxQqJs3NqNTzy
 LxqhczlcbmKx40phKDjc3K2+VpwjxiUCBRHEcnN50TJnqVqWa6G3yB7bgniC5aW1Qf6i+zJOk
 1TTyasRwCZUyK2a9riNGaVWNQn/nj/k6b2RasqA6mDKUZDvTohxWOIAxIpAm6jY6oytkpP6GU
 Eyn2xe28EHnndEzRWuuyen7770nhubegV94u34I70IRT8yREEzr4sl5jbiht2YXUB3FQGn2Jj
 QSox4EjsqTdnlzMbiHbWa6QOtmKaH7b051XeRpBgYXvcuKM+pSHxN1B875YSxSUM0S1kQ3Gv+
 ZczesmMBWbSMJvfLfB9kz4dkQEHOfiYzfACYoNj3OVhZodFz9bj7isF31DE4eUlosa3pTKim8
 7q2znKhIpn0XCOxhM98rahXCjE/3BJAyvsiSWv8f/+qpDq+bFJgu2gBLAYhgR3UxyvoQhNVKs
 +IwCG9sAdgIynOpXosAzZurYPpdMFSO5XX8BCPCIdR6/rCfhnRdkIAvyLg8x2J1LfeXoE1smN
 SBaO+WSN1JGAVwNtFBkE1C9NDBmAsjlMylb9zJ5huclRlr5J2HsrHuYcSifQiYs0txH0P8buX
 +mQ07yeTRyZi0eqP+qwh3TJew7zHcVaNDfu9GR/uMZ5MHHX+oJ0/Q5uWFdOUGkb0nhB3ifOrz
 Aj9w+f17WKI3dIJ5Y/nYdMRpi3SHEqCfzs8+Ywi75EfaxDS7MeDceJb4g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/22 16:00, Graham Cobb wrote:
> On 22/08/2022 08:15, Qu Wenruo wrote:
>> [PROBLEM]
>>
>> Command "btrfs scrub start" can be executed with single device or a
>> mount point.
>>
>> If executed with single device, it will only start a scrub for that
>> device.
>>
>> This is fine for SINGLE/DUP/RAID1*/RAID10/RAID0, as they are all
>> mirror/simple stripe based profiles.
>>
>> But this can be a problem for RAID56, as for RAID56 scrub, data stripes
>> are treated as RAID0, while only when scrubbing the P/Q stripes or doin=
g
>> data rebuild we will try to do a full stripe read/rebuild.
>>
>> This means, for the following case:
>>
>> Dev 1:  |<--- Data stripe 1 (good) -->|
>> Dev 2:  |<--- Data stripe 2 (good) -->|
>> Dev 3:  |<--- Parity stripe (bad)  -->|
>>
>> If we only scrub dev 1 or dev 2, the corrupted parity on dev 3 will not
>> be repaired, breaking the one corrupted/missing device tolerance.
>> (if we lost device 1 or 2, no data can be recovered for this full
>> stripe).
>>
>> Unfortunately for the existing btrfs RAID56 users, there seems to be a
>> trend to use single device scrub instead of full fs scrub.
>>
>> [CAUSE]
>>
>> This is due to the bad design of btrfs_scrub_dev(), by treating data
>> stripes just like RAID0.
>> This means, we will read data stripes several times (2x for RAID5, 3x
>> for RAID6), not only causing more IO, but much slower read for each
>> device.
>>
>> At least the end users should be fully informed, and choose their poiso=
n
>> to drink (until a better ioctl introduced).
>>
>> [WORKAROUND]
>>
>> This patch will introduce the following workarounds:
>>
>> - Extra warning for "btrfs scrub start <dev>"
>>    If we detect we're doing single device scrub, and the fs has RAID56
>>    feature, we output a warning for the user.
>>    (But still allow the command to execute)
>>
>> - Extra man page warning.
>>    Now there is an extra section for scrub and RAID56.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> BTW there is a WIP new ioctl, btrfs_scrub_fs(), that is going to change
>> the situation for RAID56, by not only reducing the IO for RAID56, but
>> with better error reporting (including P/Q mismatch cases), and simpler
>> and streamlined code for verification.
>>
>> Thus in the future, we may switch to the new ioctl and in that case, th=
e
>> error message will no longer be needed for the new ioctl.
>> ---
>>   Documentation/btrfs-scrub.rst | 13 +++++++++++++
>>   cmds/scrub.c                  | 29 +++++++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/Documentation/btrfs-scrub.rst b/Documentation/btrfs-scrub.=
rst
>> index 75079eecc9ef..bbf342d4b6c8 100644
>> --- a/Documentation/btrfs-scrub.rst
>> +++ b/Documentation/btrfs-scrub.rst
>> @@ -48,6 +48,19 @@ start [-BdqrRf] [-c <ioprio_class> -n <ioprio_classd=
ata>] <path>|<device>
>>           configured similar to the ``ionice(1)`` syntax using *-c* and=
 *-n*
>>           options.  Note that not all IO schedulers honor the ionice se=
ttings.
>>
>> +        .. warning::
>> +                Using ``btrfs scrub start <device>`` on a RAID56 fs is=
 strongly
>> +                discouraged.
>
> It isn't immediately obvious to the reader that you mean to distinguish
> the single-device case from the mounted-filesystem case here. How about:

Well, I intentionally to avoid "single-device" mention until we mention
"btrfs scrub start <device>" first.

As I'm not confident enough for every reader to understand "single
device scrub".


>
> Using single device scrub on a RAID56 filesystem (``btrfs scrub start
> <device>``) is strongly discouraged.
>
>> +
>> +                Due to the bad design of RAID56 scrub, single device s=
crubbing
>> +                will tread the data stripes as RAID0, only for data re=
covery
>> +                (data stripes has bad csum) or P/Q stripes we do full =
stripe
>> +                checks.
>> +
>> +                This means, if running ``btrfs scrub start <device>``,
>> +                corruption in P/Q stripes has a high chance not to be =
repaired,
>> +                greatly reducing the robustness of RAID56.
>
> How about replacing both the above paragraphs with:
>
> The current implementation of single device scrubbing for RAID56
> filesystems will only check data checksums on the specified device, and
> will not check parity stripes on other devices, greatly reducing the
> robustness of RAID56.

The problem is, this ignores the tech details that, single device scrub
on RAID56 can still check the full stripe, if a) we're scrubbing the P/Q
stripes on that device or b), the data stripes on that device has
mismatched csum.

I still want to the end users to have some correct view of the RAID56,
knowing what single device scrub is doing, and what it doesn't do.

Above example would unnecessarily give a very bad impression on the
whole scrub idea.

Thanks,
Qu

>
> For full scrub and repair of RAID56 filesystems always use ``btrfs scrub
> start <path>``.
>
>> +
>>           ``Options``
>>
>>           -B
>> diff --git a/cmds/scrub.c b/cmds/scrub.c
>> index 7c2d9b79c275..a69de8c1402b 100644
>> --- a/cmds/scrub.c
>> +++ b/cmds/scrub.c
>> @@ -42,6 +42,7 @@
>>   #include "kernel-shared/volumes.h"
>>   #include "kernel-shared/disk-io.h"
>>   #include "common/open-utils.h"
>> +#include "common/path-utils.h"
>>   #include "common/units.h"
>>   #include "cmds/commands.h"
>>   #include "common/help.h"
>> @@ -1143,6 +1144,7 @@ static int scrub_start(const struct cmd_struct *c=
md, int argc, char **argv,
>>   		       bool resume)
>>   {
>>   	int fdmnt;
>> +	int sysfsfd =3D -1;
>>   	int prg_fd =3D -1;
>>   	int fdres =3D -1;
>>   	int ret;
>> @@ -1188,6 +1190,8 @@ static int scrub_start(const struct cmd_struct *c=
md, int argc, char **argv,
>>   	DIR *dirstream =3D NULL;
>>   	int force =3D 0;
>>   	int nothing_to_resume =3D 0;
>> +	bool is_block_dev =3D false;
>> +	bool is_raid56 =3D false;
>>
>>   	while ((c =3D getopt(argc, argv, "BdqrRc:n:f")) !=3D -1) {
>>   		switch (c) {
>> @@ -1242,6 +1246,9 @@ static int scrub_start(const struct cmd_struct *c=
md, int argc, char **argv,
>>
>>   	path =3D argv[optind];
>>
>> +	if (path_is_block_device(path))
>> +		is_block_dev =3D true;
>> +
>>   	fdmnt =3D open_path_or_dev_mnt(path, &dirstream, !do_quiet);
>>   	if (fdmnt < 0)
>>   		return 1;
>> @@ -1254,6 +1261,28 @@ static int scrub_start(const struct cmd_struct *=
cmd, int argc, char **argv,
>>   		err =3D 1;
>>   		goto out;
>>   	}
>> +
>> +	sysfsfd =3D sysfs_open_fsid_file(fdmnt, "features/raid56");
>> +	if (sysfsfd >=3D 0) {
>> +		is_raid56 =3D true;
>> +		close(sysfsfd);
>> +	}
>> +
>> +	/*
>> +	 * If we're scrubbing a single device on fs with RAID56, that scrub
>> +	 * will not verify the data on the other stripes unless we're scrubbi=
ng
>> +	 * a P/Q stripe.
>> +	 * Due to the current scrub_dev ioctl design, we can cause way more
>> +	 * IO for data stripes, thus full scrub on RAID56 can be slow.
>> +	 *
>> +	 * Some one uses single device scrub to speed up the progress, but th=
e
>> +	 * hidden cost of corrupted/unscrubbed data must not be hidden.
>> +	 */
>> +	if (is_raid56 && is_block_dev) {
>> +		warning("scrub single device of a btrfs RAID56 is not recommened.");
>
> Recommended
>
>> +		warning("Check 'btrfs-scrub'(8) for more details");
>> +	}
>> +
>>   	if (!fi_args.num_devices) {
>>   		error_on(!do_quiet, "no devices found");
>>   		err =3D 1;
>
> Graham
