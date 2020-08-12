Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B982425B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHLG6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:58:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:52073 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgHLG6a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597215506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouEhUXf3v8SjThwI38Sfz1wsgkgGPwtkQkHGu0AEpeU=;
        b=AA8PonzcvMGnsLZI2xF0PsE6LisqBTeV6VhiAIdIFVyxOJN+nhyKFnQzWbdeH3TbEpw8pm
        /P8iicK45i/8OrFT8cnPNb2M944CH40q9bRc/dgI9hxdI3PCvWTqHs00mG1Cej0KLy3PQw
        if9aF+rbWmahxUNUtH5fYzOjtGZV0t8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-KcNPc6Q-Pge76FQ2W8832Q-1; Wed, 12 Aug 2020 08:58:25 +0200
X-MC-Unique: KcNPc6Q-Pge76FQ2W8832Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9qIZbK71IU9qZ904WGwnSb1J1pHovG5LSdAPHseX9TSUv08AM8Zl9fchRHjef4w8uuOKMqnehRXydMR+CdOSm6z28MfADBkBFe0z1QBotdBV+HNQhR53OdEStR06rlKUPrCwspVzV/vMef83uJxMXd/njbba6KBdJ3FoNuDklBlDsEA1gh3M+sR/AhcTfb+1WAMkl/UqYROIVDIEFnZldCGA36pqxWWBQjliswetMecFurozP7OAWxf+pGnammpnetGsg8XfNiFyiYqCjA5YOlRRqRwysKSaKLlQzCF+6dED0Q3k/EB7BumIIPYj9pwp0ORAWi0StlVm2YLg4ePsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6DbNJe+AJ5M0NODy8Cm77T6F11R0qqL3TB4IhaoUks=;
 b=mV5nwlI0jxwTiD53aeV690ZCaTkhn4W7hdLSTsmMl3zIcCGbMXJHxOA+8c4FPWF7cynNrso7REy4zgHlOAPHEHGvWsNfWv8e/6lNSOZa6rJHTI9o7nQh1letyu4w+CnMijuvs2ynUWb1sGzvLIutBaw1mXrfNXqTTyDS05A8ORib/tgNZUIdsrUcL7qvMqavgMFEpgSubb/qulwI54LIgxEvbC4IVJ6Pl1h113wR8eCzUnQg5Jrh1jSkWtjZmoRadygAXuq7dsVWTqQCPo+ci8FfhzCEE05VP5Pv57HwQLmAXNzgV+ZGoYxVmQN/46UVu0lANDLxpw5BTqERnMmyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3523.eurprd04.prod.outlook.com (2603:10a6:208:1b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Wed, 12 Aug
 2020 06:58:22 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 06:58:22 +0000
Subject: Re: [PATCH v5] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>, nborisov@suse.com
References: <20200731112911.115665-1-wqu@suse.com>
 <20200812064312.GW2026@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <6ac6741f-ffe8-f1fb-3ae7-80aca4e61b0d@suse.com>
Date:   Wed, 12 Aug 2020 14:57:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200812064312.GW2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY2PR0101CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::26) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TY2PR0101CA0014.apcprd01.prod.exchangelabs.com (2603:1096:404:92::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 06:58:19 +0000
X-Originating-IP: [45.77.180.217]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ff19fdf-72cb-422f-71b1-08d83e8d1a3e
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3523:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3523830106D15F06147C7F2CD6420@AM0PR0402MB3523.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuqskXbJM+Q+JT4h/7qD/jNWukV0opzncViuO76RZ3cMYT/RoFcLfcRderKbFgX2GCV5LVSO2076eh2tDVVImeotj3eJsRculCHL8wHDmkBsCO0HySc3qSdmP/YmPvKBen2q/wrZ7EhqpZhS8Wc9ivJEhyZbYnxNa/MyrBhT11XFEfWIiexTf8HRC0DWDnD28D7aKQthsy7RsDaqdZI2G1lAOcHTwEkJKs2Z1ArJv2Idi6aoA7clx3C9xOCQiCmA/YIpkmpw9s2Hi89OwOYsqevU0T5Af2QaVWmSyV4z7rqQ5XddmHyNmzkXOu2+/hXCqaFGXNN5y0gGEvX2BEyPcfh6D187N3z4v69QzOWnUjBVfNsvy/SF1rDv/HatmYH/61HjsHRn5DoJXMTW4jRHdXdla75d/AppKI/S6N57WKP1DGdmTCtMdV81vw7nP4bY8IfdYj3orlb+gptRzgRFSIA2mS9+ctsO6He+xIffD68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(396003)(366004)(39850400004)(376002)(6486002)(16526019)(8936002)(5660300002)(83380400001)(6666004)(186003)(966005)(956004)(8676002)(26005)(31696002)(2616005)(2906002)(6636002)(16576012)(52116002)(6706004)(478600001)(55236004)(316002)(66476007)(66556008)(86362001)(36756003)(66946007)(31686004)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: adMcJwGZbLmI0vNQGyWtebvdxdeUk6Bp21TpZcBLSOmyDBhGOELF7TBhII1KGlf1VqHJcPBTqkXHm51nD12iQQxX/oUenue+sV8ZEuhIA/kFbmb0UfAiC6vEHEhnckZ3HeLDtG5loFnW096gW60AEBSE8DA6iaVEUqrzV80rwVqYdW/n3wt+4oYfIOHGFdEFs9qEk+szUcDabAL2WM097RkVYjc90KS46uXGzr7tk3sbX5ckJxdKzPl9Etd8lUcCEt0Sph/IZs+UOp/0px6HNG60oekFm59lvCnIS/3VAeBV1ZO6sGsgmwwPt3UGTkg5oKYq9R9sIiMmh9K9P/HDIv2xFX9/og51OQQXKjgyvEN4LRSVjjb3GenJsjshqi0kFhxULh2wcTl7l8U39qU5wkEDRWpPD9+M4Kj7/1tgmmJKK56C4O7rqUTL+RCqbGJlPbUXO2Hy3YkdgsXmMGKMLcscRQ8wsqK7dB+0payZyBjiF2CJDCrs4XeoMCG3PAWMLmhILtVKwG1mXNgZErPmTx97GvNaStSZmTIdhB6l4edWimvSgfBnU9cFNUucLZlRby7as6MZMv7pfn/ZXu0MddDydwJ7RV+AxqYLND+ys7Q0fXwIlCnd52SCw1EJrbyllAKizTZS6sbRcUJ/bQ1fBA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff19fdf-72cb-422f-71b1-08d83e8d1a3e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 06:58:22.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2122NpXT4UaiIibiyrDtQl1rtcSbspHDdSuzXuNY4hGUoeqSnDGcfDhd6l7/ZBiA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3523
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/12 =E4=B8=8B=E5=8D=882:43, David Sterba wrote:
> The v5 changes were discussed but were not all trivial to be just
> committed. I need to add the patch to pull request branch soon so am
> not waiting for your v5
>=20
> v5:
>=20
> - add mask for chunk state bits and use that to clear the range a after
>   device shrink; on a second thought doing all ones did not look clean
>   to me
>=20
> - removed assert after clear_extent_bits - make it consistent with all
>   other calls where we don't check the return value for now
>=20
> - reworded comments

Looks good to me.

Like to give a reviewed-by but that won't make any sense...

Thanks for your effort!
Qu

>=20
> ---
>=20
> From: Qu Wenruo <wqu@suse.com>
> Subject: [PATCH] btrfs: trim: fix underflow in trim length to prevent acc=
ess
>  beyond device boundary
>=20
> [BUG]
> The following script can lead to tons of beyond device boundary access:
>=20
>   mkfs.btrfs -f $dev -b 10G
>   mount $dev $mnt
>   trimfs $mnt
>   btrfs filesystem resize 1:-1G $mnt
>   trimfs $mnt
>=20
> [CAUSE]
> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
> already trimmed.
>=20
> So we check device->alloc_state by finding the first range which doesn't
> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>=20
> But if we shrunk the device, that bits are not cleared, thus we could
> easily got a range starts beyond the shrunk device size.
>=20
> This results the returned @start and @end are all beyond device size,
> then we call "end =3D min(end, device->total_bytes -1);" making @end
> smaller than device size.
>=20
> Then finally we goes "len =3D end - start + 1", totally underflow the
> result, and lead to the beyond-device-boundary access.
>=20
> [FIX]
> This patch will fix the problem in two ways:
>=20
> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>   This is the root fix
>=20
> - Add extra safety check when trimming free device extents
>   We check and warn if the returned range is already beyond current
>   device.
>=20
> Link: https://github.com/kdave/btrfs-progs/issues/282
> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first=
_clear_extent_bit")
> CC: stable@vger.kernel.org # 5.4+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent-io-tree.h |  2 ++
>  fs/btrfs/extent-tree.c    | 14 ++++++++++++++
>  fs/btrfs/volumes.c        |  4 ++++
>  3 files changed, 20 insertions(+)
>=20
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index f39d47a2d01a..219a09a2b734 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -34,6 +34,8 @@ struct io_failure_record;
>   */
>  #define CHUNK_ALLOCATED				EXTENT_DIRTY
>  #define CHUNK_TRIMMED				EXTENT_DEFRAG
> +#define CHUNK_STATE_MASK			(CHUNK_ALLOCATED |		\
> +						 CHUNK_TRIMMED)
> =20
>  enum {
>  	IO_TREE_FS_PINNED_EXTENTS,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fa7d83051587..597505df90b4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -33,6 +33,7 @@
>  #include "delalloc-space.h"
>  #include "block-group.h"
>  #include "discard.h"
> +#include "rcu-string.h"
> =20
>  #undef SCRAMBLE_DELAYED_REFS
> =20
> @@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>  					    &start, &end,
>  					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
> =20
> +		/* Check if there are any CHUNK_* bits left */
> +		if (start > device->total_bytes) {
> +			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +			btrfs_warn_in_rcu(fs_info,
> +"ignoring attempt to trim beyond device size: offset %llu length %llu de=
vice %s device size %llu",
> +					  start, end - start + 1,
> +					  rcu_str_deref(device->name),
> +					  device->total_bytes);
> +			mutex_unlock(&fs_info->chunk_mutex);
> +			ret =3D 0;
> +			break;
> +		}
> +
>  		/* Ensure we skip the reserved area in the first 1M */
>  		start =3D max_t(u64, start, SZ_1M);
> =20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d7670e2a9f39..ee96c5869f57 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4720,6 +4720,10 @@ int btrfs_shrink_device(struct btrfs_device *devic=
e, u64 new_size)
>  	}
> =20
>  	mutex_lock(&fs_info->chunk_mutex);
> +	/* Clear all state bits beyond the shrunk device size */
> +	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
> +			  CHUNK_STATE_MASK);
> +
>  	btrfs_device_set_disk_total_bytes(device, new_size);
>  	if (list_empty(&device->post_commit_list))
>  		list_add_tail(&device->post_commit_list,
>=20

