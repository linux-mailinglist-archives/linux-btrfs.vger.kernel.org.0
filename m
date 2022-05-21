Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964AB52F74A
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 May 2022 03:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352830AbiEUBN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 21:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiEUBN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 21:13:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE21B12D8
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 18:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653095600;
        bh=xQgqz9+KaWgpk4EK1ZJpPF98VCoL6jPihl5dq/VTnoE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=dAe610rH0FehEBAvcQ/qnWkf5LAQt6C/llofsq6BozmR5E8UIHPMbgnwBGwXLFVe6
         Wjt7pfHrwJToewE+4IYk9kUkIblmTfsKkLvneHvqkfm1VZgmWoqR22+v0PtAvG4LZE
         rKfe6/qkEUU1cKLMjepG3dgye+HKMZ7IFMrBHl6g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNNy-1oNaSz49II-00VRsi; Sat, 21
 May 2022 03:13:20 +0200
Message-ID: <47554e1f-0cd5-0439-3f63-1173d2d4973d@gmx.com>
Date:   Sat, 21 May 2022 09:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs-progs: introduce inspect-internal map-logical
 command
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <ff62eb10cbf38e53ac26f458644257f82daba47c.1653031397.git.wqu@suse.com>
 <20220520181220.GS18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220520181220.GS18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AoVOS1kzLC0meCcdoQObTDwvBQt5gRdzmfQ98GxQEPRV2nPFdY4
 W4PwsosV6RygF0ZnhoqPqZlNYYZQL8xxkDhGLGyxCncNbKHKoXxPDHEM7vBB9+kgF9Hq63F
 L8mHlh/yA03Rh+kJMF7AMpggmb4fKMhaL0Kft1I09BRxTWESrgWrFML59W/PWie9dTPk9Pd
 uttoNjv4vhu9ZBHqWVC9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jstSqwKOn3o=:vtCDH+AftJiQegv02zQcDz
 mF9k2mA+mvZ8wdoEYUQYu3UNMp4A9ZChOuR24I4gQciZbF1yio4Y0feDOMVSqEcEGs5+wPh/V
 2QptiMzvpmyn7xY24+qLrIMPKGZEAOWIkjJqAczk7imdtZWcUJQh6K9l/UaI8FGEmFP5K91xO
 z9PC00A4HeHfyILS1jPq0mvV4AyYwgCw5Au4V+2zY6vbb7w2eyIrv9zJaQuCGqcdwwXIDRk57
 kZh60uKe6amOdse7InQi4eWcdtq7veJOjBAw4d9MnYhs9mfeFJsUkqiDkHmJ8utuhxMyEd2kt
 jsV6ZdEp2ynMxMuhbMhrrJJR2+P3FbSj9bRoOGXyCnaWoxxL4PRPm0xtdWF4GKn/oIk0NQvrA
 4rIM851RK/rCL2/+ZgoA/SNE4PvuMvaRfhRlns9z8CD3bPCpauGbj3MsEFxv1vPjrgtFY13xz
 wi75r+K4qkZo3PX14Q2IdG4iSzEoId+7h0IW5Aky2zzQ9fjNMdQ87CSv3bFxSHDTMSXkufNUM
 bWuPU/vwnOSTqZtjkCa39C8eJN9glAx0nq5jYpZXi49MfaIxz044yqvMqvlxDttieSV9PYCdn
 SFMWh8JkluTLWcQBP1rC3YBThF4EOpnyT61NfWNEbfv3s2t1hBn0AGECXbScPu6jAYj0pjqvz
 ko1NvBJ1pJ1xKNaj+84LAZoy7BFboMa/qowvXcyaLvt6pDsSuP3P2OtoF28YoHp9X0WDg15uJ
 AGZV1Q4Bw0Xj8XMn+AnPoGyjoYdecaHhgsYUz3v99d1texkXBMdJW7DYXa6ZLE+Vp7AGdTkIY
 gfkAWaUF20O6MSAvSnvs6k1MSWV3PiD6L8ikNjfZpAMqitjGr39itinpE17mF+zAA5S8rHBwd
 bypgkLoFSwSvuPvG07pwuQpXFoLPy07RBuUdaTNASvBEIXKme8ccKXUBLgQ8rz0CySD1PSV6K
 TNluEwj83v1Ai+cpvy4cewFUfqEvzYO4sglvq9/GDu2RaMv9f2sQPXGTg/hCrK/LE4ZGPiERK
 ldLa0MbfmYVnxYyYUpdLNeRgFp4vZgyzlj3lDdqxskJShECWpSIP+ltJSugoq90dXwp/NuMPV
 b1A9JX7kEB7IZYtvyPx5n3sqZaMEbfgwzpVw2tWxV7UR3a5gP7Ymi4VOw==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/21 02:12, David Sterba wrote:
> On Fri, May 20, 2022 at 03:23:26PM +0800, Qu Wenruo wrote:
>> This is a simpler version compared to btrfs-map-logical.
>>
>> The differences are:
>>
>> - No extent check
>>    Thus any bytenr which has chunk mapping can be mapped.
>>
>> - No length specification
>>    Now it's fixed to sectorsize.
>>    Previously we use nodesize in btrfs-map-logical, which would only
>>    make the output more complex due as it may cross stripe boundary
>>    for data extent.
>>
>>    Considering the main users of this functionality is data corruption,
>>    thus we really just want to resolve a single sector.
>>
>> - No data write support nor mirror specification
>>    We always output all mirrors and call it a day.
>>
>> - Ignore RAID56 parity manually
>>
>> We still keep the old btrfs-map-logical, just in case there are some
>> usage of certain parameters.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfs-inspect-internal.rst |  7 +++
>>   cmds/inspect.c                           | 78 +++++++++++++++++++++++=
+
>>   2 files changed, 85 insertions(+)
>>
>> diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/b=
trfs-inspect-internal.rst
>> index 710a34fb0cb9..8a9264d3dc5b 100644
>> --- a/Documentation/btrfs-inspect-internal.rst
>> +++ b/Documentation/btrfs-inspect-internal.rst
>> @@ -169,6 +169,13 @@ logical-resolve [-Pvo] [-s <bufsize>] <logical> <p=
ath>
>>           -v
>>                   (deprecated) alias for global *-v* option
>>
>> +map-logical <logical> <device>
>> +        map the sector at given *logical* address in the linear filesy=
stem space into
>> +        physical address.
>> +
>> +        .. note::
>> +                For RAID56, this will only map the data stripe.
>> +
>>   min-dev-size [options] <path>
>>           (needs root privileges)
>>
>> diff --git a/cmds/inspect.c b/cmds/inspect.c
>> index 1534f2040f4e..271adf8c6fd4 100644
>> --- a/cmds/inspect.c
>> +++ b/cmds/inspect.c
>> @@ -29,6 +29,7 @@
>>   #include "kernel-shared/ctree.h"
>>   #include "common/send-utils.h"
>>   #include "kernel-shared/disk-io.h"
>> +#include "kernel-shared/volumes.h"
>>   #include "cmds/commands.h"
>>   #include "common/help.h"
>>   #include "common/open-utils.h"
>> @@ -125,6 +126,7 @@ static int cmd_inspect_inode_resolve(const struct c=
md_struct *cmd,
>>   }
>>   static DEFINE_SIMPLE_COMMAND(inspect_inode_resolve, "inode-resolve");
>>
>> +
>>   static const char * const cmd_inspect_logical_resolve_usage[] =3D {
>>   	"btrfs inspect-internal logical-resolve [-Pvo] [-s bufsize] <logical=
> <path>",
>>   	"Get file system paths for the given logical address",
>> @@ -348,6 +350,81 @@ out:
>>   }
>>   static DEFINE_SIMPLE_COMMAND(inspect_subvolid_resolve, "subvolid-reso=
lve");
>>
>> +static const char * const cmd_inspect_map_logical_usage[] =3D {
>> +	"btrfs inspect-internal map-logical <logical> <device>",
>> +	"Get the physical offset of a sector.",
>> +	NULL
>> +};
>> +
>> +static int print_mapping_info(struct btrfs_fs_info *fs_info, u64 logic=
al)
>> +{
>> +	struct cache_extent *ce;
>> +	struct map_lookup *map;
>> +	int num_copies;
>> +	int cur_mirror;
>> +	int ret;
>> +
>> +	ce =3D search_cache_extent(&fs_info->mapping_tree.cache_tree, logical=
);
>> +	if (!ce) {
>> +		error("no chunk mapping found for logical %llu", logical);
>> +		return -ENOENT;
>> +	}
>> +	map =3D container_of(ce, struct map_lookup, ce);
>> +	/* For RAID56, we only return the data stripe. */
>> +	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>> +		num_copies =3D 1;
>> +	else
>> +		num_copies =3D btrfs_num_copies(fs_info, logical,
>> +					      fs_info->sectorsize);
>> +
>> +	for (cur_mirror =3D 1; cur_mirror <=3D num_copies; cur_mirror++) {
>> +		struct btrfs_multi_bio *multi =3D NULL;
>> +		u64 len =3D fs_info->sectorsize;
>> +
>> +		ret =3D btrfs_map_block(fs_info, READ, logical, &len, &multi,
>> +				      cur_mirror, NULL);
>> +		if (ret < 0) {
>> +			errno =3D -ret;
>> +			error("failed to map logical %llu: %m", logical);
>> +			return ret;
>> +		}
>> +		/* We're using READ, which should only return one mirror. */
>> +		ASSERT(multi && multi->num_stripes =3D=3D 1);
>> +		printf("mirror %d logical %llu phyiscal %llu device %s\n",
>> +			cur_mirror, logical, multi->stripes[0].physical,
>> +			multi->stripes[0].dev->name);
>> +		free(multi);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int cmd_inspect_map_logical(const struct cmd_struct *cmd, int a=
rgc,
>> +				   char **argv)
>> +{
>> +	struct open_ctree_flags ocf =3D {0};
>> +	struct btrfs_fs_info *fs_info;
>> +	u64 logical;
>> +	int ret;
>> +
>> +	clean_args_no_options(cmd, argc, argv);
>> +
>> +	if (check_argc_exact(argc - optind, 2))
>> +		return 1;
>> +
>> +	ocf.filename =3D argv[optind + 1];
>> +	ocf.flags =3D OPEN_CTREE_CHUNK_ROOT_ONLY;
>> +	logical =3D arg_strtou64(argv[optind]);
>> +
>> +	fs_info =3D open_ctree_fs_info(&ocf);
>
> So this is for images, not for mounted filesystem. The inspect-internal
> group has both but for the map-logical we could do both.

I'm afraid the map-logical tool will have the same requirement for
dump-tree, the preferred method is to run on unmounted device/image.

Running on mounted device is possible, but not recommended.

>
> I'd expect the primary use to be for the mounted fs.  The question is
> what for am I supposed to use map-logical for?

Mostly for fstests, to corrupt extents.

Thus we're completely capable to run it unmounted.

Thanks,
Qu

> See where a file is
> located, ok, that I'd like to see on a mounted filesystem. Running that
> on the block device while still mounted is unreliable.
