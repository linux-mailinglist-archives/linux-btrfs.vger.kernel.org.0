Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9C3C40D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 03:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhGLBTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 21:19:23 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:30358 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229598AbhGLBTW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 21:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626052589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6oBzpnlrubtbgP0Us/X7tiQ3GyQotFu4EwVR+P4iW5w=;
        b=YjTZg+taEAIPKyrQAlyEQSr5bWlPBr4KxulgrCdLVKTxwBSifjhssKt/ZZBH5qG7u5Nz8R
        G2RfAz7lGuJyCiJtnCOX1+Dw5/OidQJKBfZFfzP6tA+Dn4AjBYMfrQgpgJbx4CUeqqIe0s
        zBarhTUwbqLq4+SyORKisLLPGWmTEAE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-3-xH6z7TPgPwSGh2nrJPrBRg-1; Mon, 12 Jul 2021 03:16:28 +0200
X-MC-Unique: xH6z7TPgPwSGh2nrJPrBRg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itrGJJZkqDoOdBfbatCcn2nTrQCpIeao0f6UXDYltkdBE6ZjKqDFz8fd0OT/07P+tlZn6PeVuUenYHzPFwkxcyr5u26UEt0hTsffpvxauWHINlw5VdBWQ+Dh45R5VRrkntoYZ3Nf3raZn+MD7iGElrffWKqJ4Jbm/FN3VQ4FgumUbyiUV90yii2RBu5N9pGuu6w6XF3F2lJ8KLq461oOpCh+jc/ipQBkVWsA4acJtFdxDmiCivzwEvjS7u+1dtePbGgAKtyCPswHUgjkHKynVdSZeICS9N3vNyBenSu1LBI8xuxGl5crJ6NZbRkJSCSR5CZgQLTTe1kyP3woQJGklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzOLFkAKUfCq03zYMaXqyeWLixD5M2fciTafLAMWrp4=;
 b=cgjHq79zO0L8T6VF+dz8V1vhHQyyAmXqz6WYKI8oVdvEk9ohGKZkYuIb8xE5XK0bj+tCAwNtmGL+enRXvYiLsNmLbre2M9iGvj0ob/L1dMvWhsZ71n1m+tN7+vYgn289dUHjyfGpfSCBz9iFWbNhLz1VDcLn3HoSs+pmIYqE/ffm4sLcWhh/PIMyWqWU8b9yIXPW3ar+IxEnsMtB41aqS6Yx8aniKHk3LCkNFczcwvyX0AVAFVjUg7xFZ5vVfH7TVQ7ir+Xhs3DA6JfHnH9f4gKq9SdlmgsyVvz3POVdqhNG8yLoS/h+tDrc+vnKzYMYcZCTmqNbpncieZyjMyXhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8311.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Mon, 12 Jul
 2021 01:16:27 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 01:16:27 +0000
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
References: <20210711161007.68589-1-realwakka@gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20d7b0a8-8e1c-c13a-6a94-525a110a6b0e@suse.com>
Date:   Mon, 12 Jul 2021 09:16:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210711161007.68589-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0026.namprd07.prod.outlook.com (2603:10b6:a02:bc::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 01:16:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd03183-bcf8-45fd-d99c-08d944d2ac34
X-MS-TrafficTypeDiagnostic: AS8PR04MB8311:
X-Microsoft-Antispam-PRVS: <AS8PR04MB8311134D177CC216E88694E9D6159@AS8PR04MB8311.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ry/jM48Wu09EYYvqqtF5u3WkOmrRCPX+nnBQsFIbgAGy8cr1fCz67sDmeiyoY5F9JZ/Ja+Tx1uMAvXkA0oh6fTy76+KoUgFi+nT9GxobSfv0A4g+YxtRWCyzvNTjE0XKKNqOFpJcuEJRhaeTeHeXMZ/s/LlNzf86mw8uJBSBgMpz4XyozvrDjLojvegrMutkevZ+KRsot1wwjXHbQiGS5iOvBnDslxdG3QxJvIV1iw7vqTqfkdwVovrzEaJ6Dg7sS3r12pwH3pJcGbozf1jcBQiA4R4jfGqUyzjMCGcPBxZqkhRGoyamw7r6XdFtE+21I9YxvCZ7o9oqLCmDTpXJJm9Iyjq8cQ7CJloF2fAU3LgznJQIkeLdnSvYH2DUwCUsTOUUeIfBlOtBKJSDw7Geep39/l8JRXBehmP1hKI/rynnlyHMFSKYdxFcwn7H4bEpvsFAFvGrqfcLeEjcyDekIInv+LK8Bna+Uwg2E9o93MKdJGxWQxsnjycHg7HrqYjkRO4Zfy1HR9XrYU7/iDx4iqW8vo+rvwFsQ1VaAXu4AAg7KWi/3T7J0BHoqpM/KEFn0d8979o8r1+ijNe6oIB7F0S8Xfd/vCcH8oIak/kZfQ3cREQEB8VrRSvwqmfwX7iNcjqjVXwJwyjGT2zdvocZZlT9ZPuH6I08hAZvQ5BkOj9WTXvF1RKQVyw7ouFsjn7cKAnJvXx3PHnk2sbtbXwCZPcvT8gkDLTJiYhuZvrak6ayiQVi52JZ/gcpsVr3ZTcQzmF6RV9i+9ljT3bl0GDOTTLuRN/m0usL3yNzTG4Ow+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(376002)(136003)(366004)(346002)(8936002)(478600001)(8676002)(6666004)(26005)(2906002)(83380400001)(66556008)(186003)(66476007)(38100700002)(6706004)(6486002)(316002)(86362001)(956004)(66946007)(31696002)(31686004)(2616005)(16576012)(5660300002)(36756003)(110136005)(2004002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NU/cHoo0fLvaFCNLYsYpOvaMQPLNv3Udb1oqK0Wt5DaBOeIMIaBW660JYVBM?=
 =?us-ascii?Q?evgdowVszoM2A+QebVxOjd3EQ+k/qnMKcpjDwekhnd8pQwyL4tVnwISumM4B?=
 =?us-ascii?Q?MRb0CN01rgq2U1f17lfv6BzvFgw0JIWgmCX7pgTaLPo+nB3+gBugRvmEZOLn?=
 =?us-ascii?Q?VHAeaRSS5ShB5vfhXlhA9HWXlCJQPB7jGk+OyIeU2/pO5wNYXG4E7eyY8X1x?=
 =?us-ascii?Q?L+2Y0cBapM5+eW2CYQ/UUFG9oL1cOSfqIQpceaRa4XXJH0czNFjdbxWp9igB?=
 =?us-ascii?Q?zxsvKEf3K7Q6IR6tx4T8C73Bbz/vWDv986DbB2vKiwlcKYAtb/nLdHnlTja1?=
 =?us-ascii?Q?LsD7/jZH324I1aiD7qhWsBuXX6T8F+KVQ3czj9I4DtcG6gfrSvekDmkjUQdy?=
 =?us-ascii?Q?A6QPBbVggC0XUH65AEaHAJOO6F1GJbmGJbwLn60wd0klNY3W4I/8SY98mjGo?=
 =?us-ascii?Q?Y0Z7I8HdtrFBALr78HRp/g5L2d7TozKqp2QgYHoHAqqdHZnc/Yu8+vUykIN1?=
 =?us-ascii?Q?y97iFB0iT7cFaLjHkAdaf9xkd64TCIiN+idTX0q0+94n1z/uVV45ecs4vHjf?=
 =?us-ascii?Q?rioHxm7s+5PV+m4kAMomhH4P43XG9lNcLXnNhsocZlB+2hJr57EsEmXF91R2?=
 =?us-ascii?Q?sa1N6K3yhp5W7bs/B0fhghTVZHzx0d8KKwmBjzAl3AZFVAt5reToP5hhHFwo?=
 =?us-ascii?Q?rV/XYPKAe4gy+MmtBeyxwaiAo5jJV4a9bBS/0yx4/ruLuP41MNtJK7T9hQlO?=
 =?us-ascii?Q?oPmxyYb8NzuLuVNUqaJoj7yfflnzKirsXmqnmXCHG8yGQrsml4b3XzN6mCeU?=
 =?us-ascii?Q?PYcjRdMZdCNaCRGnsfH14vJK8dW0ou7vU1kZNvXzFIi26t/YDgfJZKuJRnNV?=
 =?us-ascii?Q?x/l7/iV0T+6L96WA0qFLbpqO4y+/KswMCmgBcMxzPbpWBHeUMGPkuXnezi6D?=
 =?us-ascii?Q?cehx+3TGQNGKd1bWk3RB3iDjwGhpZa1dtvYKj7kpnyomMhj2PSTwges5LL5W?=
 =?us-ascii?Q?UIc3RS9eZbDfi+l5ei2DJu8u04gOROuihYd4zsxgMOsmUBf0NnzB+IbnzyR5?=
 =?us-ascii?Q?a/kKM2Ggfxz5T5QDu7Wo0yZhw1WCR0qeIaAtg3r3l3873LJjIUUN/FmH3+Sm?=
 =?us-ascii?Q?R4/Uid1kq4bbnxOH1WBXnsdTWQlHdJcEeG7M1OTeym0RLWYLuuK48qOXHZkK?=
 =?us-ascii?Q?GZuVTzmB7ogEB0u36mr7FpRTHyvit8s+xM6MHUPriPQ4c3Pz+AxzFTstIUM5?=
 =?us-ascii?Q?8V2tmlZRXct2JMlrOztZ6HomIyiKQpiHqZkuFGS8Hp2D3PYkC6Am2HLGPUK5?=
 =?us-ascii?Q?+r5OfD2RmehBYoZ2/oZK5GUK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd03183-bcf8-45fd-d99c-08d944d2ac34
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 01:16:27.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F00tRL/985BevZ9smAB10QLOam/fxT1JRS3RYpy9Ydh3HCIpPE82dGVJQ3zVrOrF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8311
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/12 =E4=B8=8A=E5=8D=8812:10, Sidong Yang wrote:
> This patch adds an subcommand in inspect-internal. It dumps file extents =
of
> the file that user provided. It helps to show the internal information
> about file extents comprise the file.

Despite the comments inlined below for the technical details, I'm not=20
determined if we really want the tool.

On one hand, fiemap doesn't provide all detailed btrfs specific info,=20
and it's common to utilize the tree search ioctl to do the work, just=20
like "compsize".

But on the other hand, I'm not sure if it provides enough info compared=20
to things like "btrfs ins dump-tree".

For now I don't have any objection nor preference.

Thus it's again David's call on this.

>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
>   - Prints type and compression
>   - Use the terms from file_extents_item like disk_bytenr not like physic=
al"
> ---
>   Makefile                         |   2 +-
>   cmds/commands.h                  |   2 +-
>   cmds/inspect-dump-file-extents.c | 165 +++++++++++++++++++++++++++++++
>   cmds/inspect.c                   |   1 +
>   4 files changed, 168 insertions(+), 2 deletions(-)
>   create mode 100644 cmds/inspect-dump-file-extents.c
>=20
> diff --git a/Makefile b/Makefile
> index a1cc457b..911e16de 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -156,7 +156,7 @@ cmds_objects =3D cmds/subvolume.o cmds/filesystem.o c=
mds/device.o cmds/scrub.o \
>   	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
>   	       cmds/rescue-super-recover.o \
>   	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.=
o \
> -	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesys=
tem-du.o \
> +	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/inspect=
-dump-file-extents.o cmds/filesystem-du.o \
>   	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
>   libbtrfs_objects =3D common/send-stream.o common/send-utils.o kernel-li=
b/rbtree.o btrfs-list.o \
>   		   kernel-lib/radix-tree.o common/extent-cache.o kernel-shared/extent=
_io.o \
> diff --git a/cmds/commands.h b/cmds/commands.h
> index 8fa85d6c..55de248e 100644
> --- a/cmds/commands.h
> +++ b/cmds/commands.h
> @@ -154,5 +154,5 @@ DECLARE_COMMAND(select_super);
>   DECLARE_COMMAND(dump_super);
>   DECLARE_COMMAND(debug_tree);

Off-topic here.

Those "dump_super" and "debug_tree" makes me wonder, do we need to=20
cleanup them?

I mean, we have inspect_dump_super for "btrfs ins dump-super", but=20
what's "dump_super" here for?
And what's the "debug_tree" here for?

>   DECLARE_COMMAND(rescue);
> -
> +DECLARE_COMMAND(inspect_dump_file_extents);

I would be better to put this line where the other "inpsect" subcommands=20
are.

>   #endif
> diff --git a/cmds/inspect-dump-file-extents.c b/cmds/inspect-dump-file-ex=
tents.c
> new file mode 100644
> index 00000000..8574a1d0
> --- /dev/null
> +++ b/cmds/inspect-dump-file-extents.c
> @@ -0,0 +1,165 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public
> + * License v2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public
> + * License along with this program; if not, write to the
> + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> + * Boston, MA 021110-1307, USA.
> + */
> +
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +
> +#include <sys/ioctl.h>
> +
> +#include "common/utils.h"
> +#include "cmds/commands.h"
> +
> +static const char * const cmd_inspect_dump_file_extents_usage[] =3D {
> +	"btrfs inspect-internal dump-extent path",
> +	"Dump file extent in a textual form",
> +	NULL
> +};
> +
> +static void compress_type_to_str(u8 compress_type, char *ret)
> +{
> +	switch (compress_type) {
> +	case BTRFS_COMPRESS_NONE:
> +		strcpy(ret, "none");
> +		break;
> +	case BTRFS_COMPRESS_ZLIB:
> +		strcpy(ret, "zlib");
> +		break;
> +	case BTRFS_COMPRESS_LZO:
> +		strcpy(ret, "lzo");
> +		break;
> +	case BTRFS_COMPRESS_ZSTD:
> +		strcpy(ret, "zstd");
> +		break;
> +	default:
> +		sprintf(ret, "UNKNOWN.%d", compress_type);
> +	}
> +}

It would be better to just export the function with the same name in=20
"kernel-shared/print-tree.c" so we don't have duplicated code.

> +
> +static const char* file_extent_type_to_str(u8 type)
> +{
> +	switch (type) {
> +	case BTRFS_FILE_EXTENT_INLINE: return "inline";
> +	case BTRFS_FILE_EXTENT_PREALLOC: return "prealloc";
> +	case BTRFS_FILE_EXTENT_REG: return "regular";
> +	default: return "unknown";
> +	}
> +}

The same here.

> +
> +static int cmd_inspect_dump_file_extents(const struct cmd_struct *cmd,
> +										 int argc, char **argv)
> +{
> +	int fd;
> +	struct stat statbuf;
> +	struct btrfs_ioctl_ino_lookup_args lookup;
> +	struct btrfs_ioctl_search_args args;
> +	struct btrfs_ioctl_search_key *sk =3D &args.key;
> +	struct btrfs_file_extent_item *extent_item;
> +	struct btrfs_ioctl_search_header *header;
> +	u64 pos;
> +	u64 buf_off;
> +	u64 len;
> +	u64 begin;
> +	u64 disk_bytenr;
> +	u64 disk_num_bytes;
> +	u64 offset;
> +	int ret;
> +	int i;
> +	char compress_str[16];
> +
> +	fd =3D open(argv[optind], O_RDONLY);
> +	if (fd < 0) {
> +		error("cannot open %s: %m", argv[optind]);
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	if (fstat(fd, &statbuf) < 0) {
> +		error("failed to fstat %s: %m", argv[optind]);
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	lookup.treeid =3D 0;
> +	lookup.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
> +
> +	if (ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup) < 0) {
> +		error("failed to lookup inode %s: %m", argv[optind]);
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	pos =3D 0;
> +
> +	sk->tree_id =3D lookup.treeid;
> +	sk->min_objectid =3D statbuf.st_ino;
> +	sk->max_objectid =3D statbuf.st_ino;
> +
> +	sk->max_offset =3D UINT64_MAX;
> +	sk->min_transid =3D 0;
> +	sk->max_transid =3D UINT64_MAX;
> +	sk->min_type =3D sk->max_type =3D BTRFS_EXTENT_DATA_KEY;
> +	sk->nr_items =3D 4096;

You may want to do the tree search ioctl in a loop, as it's pretty=20
common for super large or heavily fragmented inode to have way more=20
items than one ioctl can return.

> +
> +	while (statbuf.st_size > pos) {
> +		sk->min_offset =3D pos;
> +		if (ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args)) {
> +			error("failed to search tree ioctl %s: %m", argv[optind]);
> +			ret =3D 1;
> +			goto out;
> +		}
> +
> +		buf_off =3D 0;
> +		for(i=3D0; i<sk->nr_items; ++i) {
> +			header =3D (struct btrfs_ioctl_search_header *)(args.buf + buf_off);
> +
> +			if (btrfs_search_header_type(header) =3D=3D BTRFS_EXTENT_DATA_KEY) {
> +				extent_item =3D (struct btrfs_file_extent_item *)(header + 1);
> +				begin =3D btrfs_search_header_offset(header);
> +
> +				printf("type =3D %s, begin =3D %llu, ",
> +					   file_extent_type_to_str(extent_item->type), begin);
> +				switch (extent_item->type) {
> +				case BTRFS_FILE_EXTENT_INLINE:
> +					len =3D le64_to_cpu(extent_item->ram_bytes);
> +					printf("end =3D %llu\n", begin + len);
> +					break;
> +				case BTRFS_FILE_EXTENT_REG:
> +				case BTRFS_FILE_EXTENT_PREALLOC:
> +					len =3D le64_to_cpu(extent_item->num_bytes);
> +					disk_bytenr =3D le64_to_cpu(extent_item->disk_bytenr);
> +					disk_num_bytes =3D le64_to_cpu(extent_item->disk_num_bytes);
> +					offset =3D le64_to_cpu(extent_item->offset);
> +					compress_type_to_str(extent_item->compression, compress_str);
> +					printf("end =3D %llu, disk_bytenr =3D %llu, disk_num_bytes =3D %llu=
,"

For "end" we normally mean inclusive end.
E.g, for @start =3D 1M, @len =3D 4K, then the @end should be 1M + 4K - 1.

Thus it would be better to just output the length, not the end.

(I know this sounds a little nitpicking, but trust me, when you have=20
seen too many bugs caused by such offset-by-one behavior, you will be as=20
sensitive as me on this)

Thanks,
Qu

> +						   " offset =3D %llu, compression =3D %s\n",
> +						   begin + len, disk_bytenr, disk_num_bytes, offset, compress_str)=
; > +
> +					break;
> +				}
> +
> +			}
> +			buf_off +=3D sizeof(*header) + btrfs_search_header_len(header);
> +			pos +=3D len;
> +		}
> +
> +	}
> +	ret =3D 0;
> +out:
> +	close(fd);
> +	return ret;
> +}
> +DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 2ef5f4b6..dfb0e27b 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group =3D {
>   		&cmd_struct_inspect_dump_tree,
>   		&cmd_struct_inspect_dump_super,
>   		&cmd_struct_inspect_tree_stats,
> +		&cmd_struct_inspect_dump_file_extents,
>   		NULL
>   	}
>   };
>=20

