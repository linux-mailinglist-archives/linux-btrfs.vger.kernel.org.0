Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5708A3C93FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 00:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhGNWtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 18:49:16 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:24166 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236958AbhGNWtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 18:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626302781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UZIf0edlpYiv+YtGA1b1QVtUGJVFawsUe7M6PhI2sI=;
        b=WVNSGgB2q0KxW8Tjtkb2SwCDhXuqMGqZhIHxm0Z4RjjuqdtdwjcKxLvNZHX6/cTGx4A1oK
        xPGIBXDIdMxgYxAEd2UbRQJIswkmeEwetg42FrgCisBeVyo5lOhSHXW+QPHHVh6SpwJUjl
        875KZno8tDKpkZ0g3QQglsdTrs/0HEc=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-e2f2R6ORNUK0Xi7OOgLzNA-1; Thu, 15 Jul 2021 00:46:20 +0200
X-MC-Unique: e2f2R6ORNUK0Xi7OOgLzNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhKTg/gdfmXuQLqBVMgESjzPUCcnGyXcrV7cdmRCnA4Fr17qXDRKiMbCt/mYpf234sCWGcqAqceeyb3KroGqC3GPqGqPSrpD7dOMKjlnkbObSE1jfsY4aC5eQXQ4sHtX1FKADQoh/JGbiNs1kglUNy8nEYcCwC1+R+RJU5Rppvq8Wks4bWT+VeSLnpIQ2YLvzMokK0jetYPG+Ei/YbuCVP427QYT5Y6f54/pgZxLZ8wOyW/CCz7mA5wprVkkPxaGlATniwmuMnaM+QsFP4KM7lR9ZgiFtHDQM3lBcbwxhlxuW4W1r3aUfN6ENNV2Q0w9eyvz6nnjnpBjRqpb6QhgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syx85kSjmv9Eoo9gq0BP0ts2lzTsFvpkIYhj2cdSQK4=;
 b=Cn4u4AXFIf//S4bQQi7QEiBcDM2Km6Tq8qXVT7yD8XV8nhNcRviu6ljSGiFwU1e5rKDGkKqu3+ecq9PfxrXIzXaqSnJvrIPKUr5/nvTLvpMY06zQdp0Qt2q1uVQUCOoJBZD7gjE4m9MfnuLvB6UXi8sQzjgyMTQsYmjCJgb8+ENjuMlHeH4i5nfq+z/9C917Qcc8oUAAkj76BknxA+j2pYKrXPohx3xo/zU9dHTJBE08Hu95el8KEFjq2krOA2wJh7qTFpfIAzS2kRQcqj4CNDQCjX6t1ATNH0bauvzodOjbHb+rhZgN1RqdIH3Vn8wT0ErhBvO3wgth8Yigux4oXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8310.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 22:46:18 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 22:46:18 +0000
Subject: Re: [PATCH v3 1/2] btrfs-progs: export util functions about file
 extent items
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20210714145437.75710-1-realwakka@gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <47ac7559-820a-6a32-3f2a-72f9cb633503@suse.com>
Date:   Thu, 15 Jul 2021 06:46:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210714145437.75710-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 22:46:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41087ff5-1f80-443d-058c-08d9471931a5
X-MS-TrafficTypeDiagnostic: AS8PR04MB8310:
X-Microsoft-Antispam-PRVS: <AS8PR04MB8310D876F0BB42AD7CFC409FD6139@AS8PR04MB8310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV+iJLatz/VisHLcxGtg4Z6HnuUqNHfmSPTdnZu8I4GZ2dTgiF8ZQe+vnuVBVYYe01Xx7+fYMu4tRNzoiBsg0/kzAIypsWZsjh0XrzaM8BGZ7TiC190G3SVJ6mRvuZsMAr33lQYYjA5nMZUAxjkDK1h7gbFVhLp0gTfDuPzFj7TmY/hngghTvmvAO9iQ9jEjD9ftmk/RDuuNnKsFxzQLy8R3pQRCkFhkYbAlHFRcEpRtfH6BA7od/ueEjv7sJqJox2GQNLRh3e++RBI7HmVNUlmzZ8u6MbnyawCATrMfi5sfsVZzKoHW4tJD4e0tCZDedk6MTEzHAZcsPiZumTO4IJAMYvKELZgeW559lGW0tbD6JkeXGfWa2pc1RGAW19OKU/CkYjQKlP4NlCL7Q0bCgrQFn4ZJMWytZeG0p9aqF2DhL+4S/opGfqPBt/x2QXD+aEXjIyHH30inudDEvRCsKYYnIONqJK6I7ZfRKhyPOemRWK7q7klsUAnebDmAMJBOLLr4XEpNsF/eTgPz+qGo5GLKuKyXTayWWC8G1dUIiCIpvmEpTogp30GxuZTXK+/GeFaqjR4UZVkgfmR5fiLqUNfjuKyWYJcS4MgvP4YuaXBqT0q0q9AwSZOAkQKF5G6IL+n60dON//d4GCXxOeviICgDLEU343dCT71udNzxwh1djUMT+LH7awy0I4JAULNQ7/xS2w6yyvSHhZ77tRNKEG2TKC9Lk9bqTOP3wwH0ugOdW96XicfD22K9o5LHI/mW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(8676002)(86362001)(6666004)(8936002)(66476007)(31696002)(66946007)(5660300002)(478600001)(6706004)(2616005)(6486002)(66556008)(31686004)(956004)(110136005)(316002)(2906002)(36756003)(38100700002)(16576012)(83380400001)(186003)(26005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oEvnhuH13Mv6stjzbcorR3KqkK+HKR6Ir3Qrr4lA3vbU1wP2GotCeglGpo79?=
 =?us-ascii?Q?OYAD8Y5IQS5Dhl4I8Da645Tw6LbjKRCOit5cYJkG2X4D4nB2tOCmhnnRAfTb?=
 =?us-ascii?Q?n7+vwXWin8WdotaSfdZ/seVdeKBGIUv6xG2UBghY04aIkK1EYxAIOZZQcROG?=
 =?us-ascii?Q?7xQtWHmitA8ODFeD84v4DRq1HU3SnfIAINrAlxVQyl5k8yVQf3T6MC3DA3Ok?=
 =?us-ascii?Q?v1mB2dtAi1cDlKSSWAyL23PLhCLyNw8VI3fOfwy/YCmrlbCVjzVuunETHIke?=
 =?us-ascii?Q?0r4rIwTJFVLsDw+sb6geHFjK5e5nDN7uf7PeNrQemhKu7DSSUF4DNLCFEFEW?=
 =?us-ascii?Q?ZdAZ+tTA9Sh35bL5kmDluXrtnPMX0oH+mXwWgQk+Y8OXfGaXFJn63s8yJme3?=
 =?us-ascii?Q?gmUpfa6mWQOXl7kfA861m7yWoU9ck4JpFYThJJmOTcD5EVILbXDm2oqRAtSk?=
 =?us-ascii?Q?a0NqpHdbZ1fI9kSUxEh25Uo4sNTmarcqGCqclWUxE74DFwXU0OV9prp8j3Xb?=
 =?us-ascii?Q?gvovWQavd/8qmGRZZml7nsKIYp+/AnMGeojirJ7LdHkVzAjLv/19woBjJHzr?=
 =?us-ascii?Q?iN1BQNEWyheRG+VM76qNzI6qY26I9iPvq9taqcg352/kIdGnwL56bSfPcoHx?=
 =?us-ascii?Q?s5hJ8S8rrCvY8/eh5f1LSA+CS3pBO87qdNlz5UqjdTXlt5smzxvCpGJgny2f?=
 =?us-ascii?Q?jdmkjsvqHioN3KGR+d0ozVRpWA4qAKTmRbOFBU3Ns0ncS9omCvJ02iT1KyqP?=
 =?us-ascii?Q?Rp2woxDG5hSJp8CrJD+twPpmacVUBgd7w1Aig39xbbDesZcoIszl8p+rZJgQ?=
 =?us-ascii?Q?su8n7SKZ/D2al5dNwfaREvUdQ6gJdlzPlZOwroMwwTFI6xewpGewa6TyJpja?=
 =?us-ascii?Q?Xf0zEsqTn8iGSCDL4aUb5zQCdOJrRzh2+u6skNMbzd+9EE8mUsmPHHK2rbNk?=
 =?us-ascii?Q?Yxrb5f9fhpt89UOzoHNejngz8NQ218DRyqouNjbUQ9tlZEclNqkk4sQxB9Bl?=
 =?us-ascii?Q?+vZFG4GM7XRXySr0j7z9scJGO5Bv7uiKpzOsWEbzqmyWOX3raozxWGAiJbKL?=
 =?us-ascii?Q?0jT3rjWzQyUwL0MRm/IyA3zyo8eqzk561Vc6lBxXPXtoRunPWFdR4LG7nsjl?=
 =?us-ascii?Q?85wW9fOYuwH720qpMsA7LGkFrF3eygAQUab5ZGax/pfVwX55qq+bz6UN9ohg?=
 =?us-ascii?Q?/eS1vU28LP0lgS8kUN2cy8Js1ogC78fgPVDG7hCMBGx3moIOPTZ5xh9eug56?=
 =?us-ascii?Q?n6o/yKbEHkIQrTjjsioznNpfvnNFGKAfWbtzVx0w0ekWVwgNYgXN8lLnsMGV?=
 =?us-ascii?Q?8Kj/CtkWwI/muEtRhTkYS/ye?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41087ff5-1f80-443d-058c-08d9471931a5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 22:46:18.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wivBER6VDgdEUfmLvWaVeQdSS6THGS1AY/mxDZBZQ3y7U/yuzK0rZ1HG67JZBemQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8310
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=8810:54, Sidong Yang wrote:
> This patch export two functions that convert enum about file extents to
> string. It can be used in other code like inspect-internal command. And
> this patch also make compress_type_to_str() function more safe by using
> strncpy() than strcpy().
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
>   - Prints type and compression
>   - Use the terms from file_extents_item like disk_bytenr not like
>     "physical"
> v3:
>   - export util functions for removing duplication
>   - change the way to loop with search ioctl
> ---
>   kernel-shared/print-tree.c | 18 ++++++++++--------
>   kernel-shared/print-tree.h |  3 +++
>   2 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index e5d4b453..bfef7d26 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -27,6 +27,8 @@
>   #include "kernel-shared/print-tree.h"
>   #include "common/utils.h"
>  =20
> +#define COMPRESS_STR_LEN 5

It's already too small to contain all the strings.

We have a default branch:

  	default:
  		sprintf(ret, "UNKNOWN.%d", compress_type);

In that case, our minimal value should be strlen("UNKNOWN.255") + 1,=20
which is 12 bytes.

Your old rounded up 16 bytes is in fact perfect in this case.

Despite that, this patch looks good to me.

Thanks,
Qu
> +
>   static void print_dir_item_type(struct extent_buffer *eb,
>                                   struct btrfs_dir_item *di)
>   {
> @@ -338,27 +340,27 @@ static void print_uuids(struct extent_buffer *eb)
>   	printf("fs uuid %s\nchunk uuid %s\n", fs_uuid, chunk_uuid);
>   }
>  =20
> -static void compress_type_to_str(u8 compress_type, char *ret)
> +void btrfs_compress_type_to_str(u8 compress_type, char *ret)
>   {
>   	switch (compress_type) {
>   	case BTRFS_COMPRESS_NONE:
> -		strcpy(ret, "none");
> +		strncpy(ret, "none", COMPRESS_STR_LEN);
>   		break;
>   	case BTRFS_COMPRESS_ZLIB:
> -		strcpy(ret, "zlib");
> +		strncpy(ret, "zlib", COMPRESS_STR_LEN);
>   		break;
>   	case BTRFS_COMPRESS_LZO:
> -		strcpy(ret, "lzo");
> +		strncpy(ret, "lzo", COMPRESS_STR_LEN);
>   		break;
>   	case BTRFS_COMPRESS_ZSTD:
> -		strcpy(ret, "zstd");
> +		strncpy(ret, "zstd", COMPRESS_STR_LEN);
>   		break;
>   	default:
>   		sprintf(ret, "UNKNOWN.%d", compress_type);
>   	}
>   }
>  =20
> -static const char* file_extent_type_to_str(u8 type)
> +const char* btrfs_file_extent_type_to_str(u8 type)
>   {
>   	switch (type) {
>   	case BTRFS_FILE_EXTENT_INLINE: return "inline";
> @@ -376,12 +378,12 @@ static void print_file_extent_item(struct extent_bu=
ffer *eb,
>   	unsigned char extent_type =3D btrfs_file_extent_type(eb, fi);
>   	char compress_str[16];
>  =20
> -	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
> +	btrfs_compress_type_to_str(btrfs_file_extent_compression(eb, fi),
>   			     compress_str);
>  =20
>   	printf("\t\tgeneration %llu type %hhu (%s)\n",
>   			btrfs_file_extent_generation(eb, fi),
> -			extent_type, file_extent_type_to_str(extent_type));
> +			extent_type, btrfs_file_extent_type_to_str(extent_type));
>  =20
>   	if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>   		printf("\t\tinline extent data size %u ram_bytes %llu compression %hh=
u (%s)\n",
> diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
> index 80fb6ef7..dbb2f183 100644
> --- a/kernel-shared/print-tree.h
> +++ b/kernel-shared/print-tree.h
> @@ -43,4 +43,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type=
);
>   void print_key_type(FILE *stream, u64 objectid, u8 type);
>   void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
>  =20
> +void btrfs_compress_type_to_str(u8 compress_type, char *ret);
> +const char* btrfs_file_extent_type_to_str(u8 type);
> +
>   #endif
>=20

