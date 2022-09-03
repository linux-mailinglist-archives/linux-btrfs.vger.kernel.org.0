Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A65ABE2C
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiICJhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiICJhZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 05:37:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBEAA2878
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662197831;
        bh=hWQEz6TJiqxbWkISnMr/Jc7lzw+urx2ARzxKm5CB0Hg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZTr3letuDMq4KKsgBlWtFsBHvohl71TVYbh4968CLecF/ak3WNP3eUoDY0m6aPH2I
         Ym+AZpv+nGFksX8B0NdjoYNpMrJWyCdT4cS+5ImioGA88msf5naszWG0SxL9XxbkG2
         RpSNg9dW1XP1e10bPni/DwUlEUhakUSU1sr6LUxk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ycl-1oVnZ71aAN-0032se; Sat, 03
 Sep 2022 11:37:11 +0200
Message-ID: <410234ec-1c4a-f683-6913-1df9757685ff@gmx.com>
Date:   Sat, 3 Sep 2022 17:37:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH PoC 1/9] btrfs: introduce BTRFS_IOC_SCRUB_FS family of
 ioctls
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <cover.1662191784.git.wqu@suse.com>
 <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
 <20220903172506.447E.409509F4@e16-tech.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220903172506.447E.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:80nraxnnFL4gj5e425UZh2xkCwaZX0tw93yBr7cMKWbGPOC+xAd
 Qko4DKMmLGX+EC0vAraVvTEp37r/p/g+PJxYsirVeFy6JDJuvBZ8Sb6TNLJUEYKd9aKC+WS
 dsUIQp7zRdm2cZNZbFzGTIRuJ9MTiK0jjYIqoH3cn5OwnzV8tJzKqUxqvC2uzaSQ9f/K7mj
 AKbusTBxZob/j2KIgdE5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VEHPmSPZq60=:slSNr/jnNS/3/4dwR7Axlk
 bkZqNv0LfbEDA8/qYvqiOsQ1trfK9brzQ5FKDTodyrUKJVV3/VgPJxD7CCiDEpulrgiPdidHA
 n55wyYUvdPVk0Oam9cmKwmL9REvK5Uo2MzAG3p8lJKC9kQJgzF3F1xXSeaUHm8LCUUlVRQC9d
 GS/jMeYM8k3RH/dRrt0LzhcZftBRzA8VdgafUx12+Z6Izm1pTqe4Os6bCALyIGXyhsIs/G4Py
 i1qLd4+rBBqnBQ3xT5zBzR3s2f2L/+2SKQ8drxsUzraRLUo49/aus/QW+SiI3uwdXea5LwVFD
 8C6D1p7fOmGluC8KsqVyfy8hXFysguEO3PkPebRcqzUALJzfezAhMzInrV/vrKkK3B2VwxvaA
 Ma0nwGYD0h9rQk5pInf/JXqwb9Gbl3FkhX+cLe+jy35bVzRFfuQQGDSFMqh/M9j1dtvDd/zw1
 JwmlgPr/6RPmDVe5oLgRT4OLvbbuRga2BUwjGEJCJxDttYkSfhPyCJuCf4J1+K/AGulKKr1eW
 48V5T/WA8giZVwtjDtJ+8KPTnkl6j/5hB/qbkcBgcBBPQQlPCzpcKUT/ja/6TnXNedXUZ0kn8
 9xjHCPUq65SQNnMry6+JYSm7GHQXtqq93cYSSGd5LXQAy8alD1v5SI52PLEWWKMMEanvMIK2n
 NJTfz/m41t4FyVUIx8Kl34nDBoKNQJ2VxvFeDKLDkKqnVLBeURzcrRbFOQksdT39h6Z1yJqGs
 Y02QdG1WMY7LVyR700T9AuqjpdkyabFlSQ9bGOuEdmVRgbVS7oIKcVUSlEUZ48DdOMzfhyJEG
 V/mTKaLK0kBD9VtE4OKzo9NVLq5FmQVfxzkGslVMbjHMqFxQDmuI8f4WHHGikUyBcJAsf5cl0
 F/pNRxrqVMf5+XonR+hj1YPNx4r3+n7CpMwFz8txwHwFK52eHIa4woqEfeUgBaCJzG0MMw6Z5
 PVOtp/n8rMTYGlpaSrO/yqhFq/uW3h1etiYSTzcOQqKrJUv4wjXJp1ytOnjh7zA2QqWq2jqfn
 84GYGVXikzr3kT61N4S7OH41928mDS5OQkJQqd40UeFSsoLTiEHHa0SbJL1gcXD+5gOVYGWfR
 ElniUp534sOONWKfQZDr3IpkDjlLz47+ZB7YbABtcqzImtBmcevmzHQFOaoV5jYF6YMeYsAYp
 Qwp14TDPv4WRmK2VnCZAZkez74
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/3 17:25, Wang Yugui wrote:
> Hi,
>
>> The new ioctls are to address the disadvantages of the existing
>> btrfs_scrub_dev():
>>
>> a One thread per-device
>>    This can cause multiple block groups to be marked read-only for scru=
b,
>>    reducing available space temporarily.
>>
>>    This also causes higher CPU/IO usage.
>>    For scrub, we should use the minimal amount of CPU and cause less
>>    IO when possible.
>>
>> b Extra IO for RAID56
>>    For data stripes, we will cause at least 2x IO if we run "btrfs scru=
b
>>    start <mnt>".
>>    1x from scrubbing the device of data stripe.
>>    The other 1x from scrubbing the parity stripe.
>>
>>    This duplicated IO should definitely be avoided
>>
>> c Bad progress report for RAID56
>>    We can not report any repaired P/Q bytes at all.
>>
>> The a and b will be addressed by the new one thread per-fs
>> btrfs_scrub_fs ioctl.
>
> CRC check of scrub is CPU sensitive, so we still need multiple threads,
> such as one thread per-fs but with additional threads pool based on
> chunks?

This depends.

Scrub should be a background work, which can already be affected by
scheduling, and I don't think users would bother 5% or 10% longer
runtime for a several TB fs.

Furthermore if checksum in a single thread is going to be a bottleneck,
then I'd say your storage is already so fast that scrub duration is not
your primary concern any more.

Yes, it can be possible to offload the csum verification into multiple
threads, like one thread per mirror/device, but I don't want to
sacrifice readability for very minor performance improvement.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/03
>
>
>
>> While c will be addressed by the new btrfs_scrub_fs_progress structure,
>> which has better comments and classification for all errors.
>>
>> This patch is only a skeleton for the new family of ioctls, will return
>> -EOPNOTSUPP for now.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c           |   6 ++
>>   include/uapi/linux/btrfs.h | 173 ++++++++++++++++++++++++++++++++++++=
+
>>   2 files changed, 179 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index fe0cc816b4eb..3df3bcdf06eb 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -5508,6 +5508,12 @@ long btrfs_ioctl(struct file *file, unsigned int
>>   		return btrfs_ioctl_scrub_cancel(fs_info);
>>   	case BTRFS_IOC_SCRUB_PROGRESS:
>>   		return btrfs_ioctl_scrub_progress(fs_info, argp);
>> +	case BTRFS_IOC_SCRUB_FS:
>> +		return -EOPNOTSUPP;
>> +	case BTRFS_IOC_SCRUB_FS_CANCEL:
>> +		return -EOPNOTSUPP;
>> +	case BTRFS_IOC_SCRUB_FS_PROGRESS:
>> +		return -EOPNOTSUPP;
>>   	case BTRFS_IOC_BALANCE_V2:
>>   		return btrfs_ioctl_balance(file, argp);
>>   	case BTRFS_IOC_BALANCE_CTL:
>> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
>> index 7ada84e4a3ed..795ed33843ce 100644
>> --- a/include/uapi/linux/btrfs.h
>> +++ b/include/uapi/linux/btrfs.h
>> @@ -191,6 +191,174 @@ struct btrfs_ioctl_scrub_args {
>>   	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
>>   };
>>
>> +struct btrfs_scrub_fs_progress {
>> +	/*
>> +	 * Fatal errors, including -ENOMEM, or csum/extent tree search errors=
.
>> +	 *
>> +	 * Normally after hitting such fatal errors, we error out, thus later
>> +	 * accounting will no longer be reliable.
>> +	 */
>> +	__u16	nr_fatal_errors;
>> +
>> +	/*
>> +	 * All super errors, from invalid members and IO error all go into
>> +	 * nr_super_errors.
>> +	 */
>> +	__u16	nr_super_errors;
>> +
>> +	/* Super block accounting. */
>> +	__u16	nr_super_scrubbed;
>> +	__u16	nr_super_repaired;
>> +
>> +	/*
>> +	 * Data accounting in bytes.
>> +	 *
>> +	 * We only care about how many bytes we scrubbed, thus no
>> +	 * accounting for number of extents.
>> +	 *
>> +	 * This accounting includes the extra mirrors.
>> +	 * E.g. for RAID1, one 16KiB extent will cause 32KiB in @data_scrubbe=
d.
>> +	 */
>> +	__u64	data_scrubbed;
>> +
>> +	/* How many bytes can be recovered. */
>> +	__u64	data_recoverable;
>> +
>> +	/*
>> +	 * How many bytes are uncertain, this can only happen for NODATASUM
>> +	 * cases.
>> +	 * Including NODATASUM, and no extra mirror/parity to verify.
>> +	 * Or has extra mirrors, but they mismatch with each other.
>> +	 */
>> +	__u64	data_nocsum_uncertain;
>> +
>> +	/*
>> +	 * For data error bytes, these means determining errors, including:
>> +	 *
>> +	 * - IO failure, including missing dev.
>> +	 * - Data csum mismatch
>> +	 *   Csum tree search failure must go above case.
>> +	 */
>> +	__u64	data_io_fail;
>> +	__u64	data_csum_mismatch;
>> +
>> +	/*
>> +	 * All the unmentioned cases, including data matching its csum (of
>> +	 * course, implies IO suceeded) and data has no csum but matches all
>> +	 * other copies/parities, are the expected cases, no need to record.
>> +	 */
>> +
>> +	/*
>> +	 * Metadata accounting in bytes, pretty much the same as data.
>> +	 *
>> +	 * And since metadata has mandatory csum, there is no uncertain case.
>> +	 */
>> +	__u64	meta_scrubbed;
>> +	__u64	meta_recoverable;
>> +
>> +	/*
>> +	 * For meta, the checks are mostly progressive:
>> +	 *
>> +	 * - Unable to read
>> +	 *   @meta_io_fail
>> +	 *
>> +	 * - Unable to pass basic sanity checks (e.g. bytenr check)
>> +	 *   @meta_invalid
>> +	 *
>> +	 * - Pass basic sanity checks, but bad csum
>> +	 *   @meta_bad_csum
>> +	 *
>> +	 * - Pass basic checks and csum, but bad transid
>> +	 *   @meta_bad_transid
>> +	 *
>> +	 * - Pass all checks
>> +	 *   The expected case, no special accounting needed.
>> +	 */
>> +	__u64 meta_io_fail;
>> +	__u64 meta_invalid;
>> +	__u64 meta_bad_csum;
>> +	__u64 meta_bad_transid;
>> +
>> +	/*
>> +	 * Parity accounting.
>> +	 *
>> +	 * NOTE: for unused data sectors (but still contributes to P/Q
>> +	 * calculation, like the following case), they don't contribute
>> +	 * to any accounting.
>> +	 *
>> +	 * Data 1:	|<--- Unused ---->| <<<
>> +	 * Data 2:	|<- Data extent ->|
>> +	 * Parity:	|<--- Parity ---->|
>> +	 */
>> +	__u64 parity_scrubbed;
>> +	__u64 parity_recoverable;
>> +
>> +	/*
>> +	 * This happens when there is not enough info to determine if the
>> +	 * parity is correct, mostly happens when vertical stripes are
>> +	 * *all* NODATASUM sectors.
>> +	 *
>> +	 * If there is any sector with checksum in the vertical stripe,
>> +	 * parity itself will be no longer uncertain.
>> +	 */
>> +	__u64 parity_uncertain;
>> +
>> +	/*
>> +	 * For parity, the checks are progressive too:
>> +	 *
>> +	 * - Unable to read
>> +	 *   @parity_io_fail
>> +	 *
>> +	 * - Mismatch and any veritical data stripe has csum and
>> +	 *   the data stripe csum matches
>> +	 *   @parity_mismatch
>> +	 *   We want to repair the parity then.
>> +	 *
>> +	 * - Mismatch and veritical data stripe has csum, and data
>> +	 *   csum mismatch. And rebuilt data passes csum.
>> +	 *   This will go @data_recoverable or @data_csum_mismatch instead.
>> +	 *
>> +	 * - Mismatch but no veritical data stripe has csum
>> +	 *   @parity_uncertain
>> +	 *
>> +	 */
>> +	__u64 parity_io_fail;
>> +	__u64 parity_mismatch;
>> +
>> +	/* Padding to 256 bytes, and for later expansion. */
>> +	__u64 __unused[15];
>> +};
>> +static_assert(sizeof(struct btrfs_scrub_fs_progress) =3D=3D 256);
>> +
>> +/*
>> + * Readonly scrub fs will not try any repair (thus *_repaired member
>> + * in scrub_fs_progress should always be 0).
>> + */
>> +#define BTRFS_SCRUB_FS_FLAG_READONLY	(1ULL << 0)
>> +
>> +/*
>> + * All supported flags.
>> + *
>> + * From the very beginning, scrub_fs ioctl would reject any unsupporte=
d
>> + * flags, making later expansion much simper.
>> + */
>> +#define BTRFS_SCRUB_FS_FLAG_SUPP	(BTRFS_SCRUB_FS_FLAG_READONLY)
>> +
>> +struct btrfs_ioctl_scrub_fs_args {
>> +	/* Input, logical bytenr to start the scrub */
>> +	__u64 start;
>> +
>> +	/* Input, the logical bytenr end (inclusive) */
>> +	__u64 end;
>> +
>> +	__u64 flags;
>> +	__u64 reserved[8];
>> +	struct btrfs_scrub_fs_progress progress; /* out */
>> +
>> +	/* pad to 1K */
>> +	__u8 unused[1024 - 24 - 64 - sizeof(struct btrfs_scrub_fs_progress)];
>> +};
>> +
>>   #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	=
0
>>   #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
>>   struct btrfs_ioctl_dev_replace_start_params {
>> @@ -1137,5 +1305,10 @@ enum btrfs_err_code {
>>   				    struct btrfs_ioctl_encoded_io_args)
>>   #define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
>>   				     struct btrfs_ioctl_encoded_io_args)
>> +#define BTRFS_IOC_SCRUB_FS	_IOWR(BTRFS_IOCTL_MAGIC, 65, \
>> +				      struct btrfs_ioctl_scrub_fs_args)
>> +#define BTRFS_IOC_SCRUB_FS_CANCEL _IO(BTRFS_IOCTL_MAGIC, 66)
>> +#define BTRFS_IOC_SCRUB_FS_PROGRESS _IOWR(BTRFS_IOCTL_MAGIC, 67, \
>> +				       struct btrfs_ioctl_scrub_fs_args)
>>
>>   #endif /* _UAPI_LINUX_BTRFS_H */
>> --
>> 2.37.3
>
>
