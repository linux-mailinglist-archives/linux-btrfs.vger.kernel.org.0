Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E170238C5A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 13:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhEUL2J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 07:28:09 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:38449 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230186AbhEUL2I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 07:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621596404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbmJera0PGF5bD1NutuJrFUOrhRwip627EPN6Z3bOoU=;
        b=A7KWqY+ObwOVuSwd5ga0b60BpYnoLE8NRVpDicxMFvu+FguVDQV7AZRwddyEK+7IuHV9AZ
        2asce/z1d0PtNu3HJlBUCSs/9XWzL6kznNBSQ0KapPeGrz029FSpU6eykapKhXaGrlXyie
        vJMNyThnMv4LwXdjs2DP8P8l1QqVIVs=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-FfV30ZvxNXS5ZozK6nzEnw-2;
 Fri, 21 May 2021 13:26:43 +0200
X-MC-Unique: FfV30ZvxNXS5ZozK6nzEnw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeGOIY9UHe80sAmVgH7gPMFKdXbpeL4By6n7ATbS0KtgtjRgFxjpvbxWik/sOov/woeP0qrpeEIcpr88ngKSWpOTAF8NIw/zkcSqoX2bvYVhzZuUnvEJw/fAFKcHkr6N8rm4SH4x+Uzda6+UJFcuIfmjY/VBF0AD4eSrcEB0Qgvd78DApDfZxLgtbV8pfBHwsDd6gwmtfS6lLdKkRJrX6OL6A59gvgzrYBRKXs40d+zU0mg4JyQ8DgpcTRlMgOIrViaIsMnSh2ZQ+s/xBUTq/R97NrbgvjhOWS0/SGoLWgcE1/E0NGItU+825KpO9W77KOImEKYnvAFvfJSplVWNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLWjjaca/yIMYMDMhRRMBJbFrHcYMIFe2A0uHjhfrS8=;
 b=IYzBNr8RojGY51xOuEQX/uYCIBJMNqtsteOIWhswoEQaqky9mtD571+2bwn8V5b4DyuQcLApOOlEgiWQXI4jNq9wbGsxtP38W36ELm6sK7/q7MssszzYNaDztgH9XPwmkr7A2NZkieDBwnE9BLoLbDjtQDTIeYGOKp6e4Metp7/Y2igRcQH9YvVMcuRM4CfUY/ZPBGiEWU14gb+Fc/jqiZ+bZHwzo5/5gnR52GUT59iQR5M4fH8dntXjtG3Oo8ucCUQWm7sRTQXTsHzWE2i/Gt6FYzJL21tLnrSv+RSN2qlMTdLWJ2LonOWW+TyHauHL+YzciP4hrVug8NwpgTPiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4039.eurprd04.prod.outlook.com (2603:10a6:209:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 21 May
 2021 11:26:40 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 11:26:40 +0000
Subject: Re: [Patch v2 05/42] btrfs: refactor submit_extent_page() to make bio
 and its flag tracing easier
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-6-wqu@suse.com>
 <PH0PR04MB74164E271935D134458F6C289B299@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <a08bab53-4240-83ec-897f-23e1083f8ad6@suse.com>
Date:   Fri, 21 May 2021 19:26:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <PH0PR04MB74164E271935D134458F6C289B299@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:a03:40::46) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0033.namprd04.prod.outlook.com (2603:10b6:a03:40::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Fri, 21 May 2021 11:26:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4df10699-bc4f-41f6-0033-08d91c4b4dd0
X-MS-TrafficTypeDiagnostic: AM6PR04MB4039:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB40399B102645A6949FA3E2A0D6299@AM6PR04MB4039.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Se7yneXkBQQnl/Ns7DI7Mh2/9r0/Afb5Yzth9Z4Vh2n8ZgsSEmdqnPNf6xNV8tUf0bSbSqXh85Nl9f8abpUGACUy3thfJq0Z2xVED9bqOZEDbhJMSNg/SmPZcHi7JKwIUNVX/9PG+9lqd9bw0/PT/FPCh/Ufib55dU491lu8024toc8rgM3JRzLCj5ML1oNMxfc9yg0Eh8TubT7D1DrU9RH6aTAyXk9SJh1FsXUDYp5nmbWI37KeEwMpLosLn8i9JE9unzhROVG4AbsDvxbBZuVAGu6OVTWZVy2O5kbF5jRZGcuSPLsY1WYAscPk98jDjV7HUfpd6JFsru5RnZP3YMHwxAMEmuOq/U9Z642E1AiPRPmquAX0wOCxXPVBaSGWgBsG0ObbLmiLj2/j3F99RrusYTqHEeibsYOi9frY5mCFy8r9O5mNPYX1TbGmsnyYSpav+IODWNVlDAlvqnxvezq3zCUvqPUFSf+RtW0NP3Cjb+WTKQBDYx6LknqEfLR6iCO7JYEEtIl0fl4D6WkXHdgcfCNUMAO7w8JgBz8lcTGLte8enqd7DN5SBtOLpYtPe2s9staIuaYR1/PYfIH8Su+2BujqJDWNMNylt3PNFAgk8BSaxX3zGc/SLSD8SDy5rCdw3wHbxlrTTfE6MqBVszT5ZU6TKljJD1pJD54GEHFp79zTMhav+pwCQF4zsKorJ80IMppDQZPfjxABO1Z+Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(16526019)(36756003)(186003)(8936002)(26005)(31686004)(53546011)(16576012)(4326008)(31696002)(956004)(6636002)(2616005)(8676002)(2906002)(66946007)(83380400001)(6666004)(86362001)(66476007)(6486002)(5660300002)(110136005)(6706004)(316002)(38100700002)(66556008)(478600001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RRPCNYrY1tAaQdHiAW1JLS9kzDqdnN6jOuRFKU5hw/jP/Q8Msa/OpvCY/pFm?=
 =?us-ascii?Q?e9KcF16gxueRA/sTffGh1LF2qts6sixI4N0mcXWjZfwVMHarc716XJcS7b0X?=
 =?us-ascii?Q?D2YUQW17HzeZ/01WEfkKoeu/ee6+6wqkNidEYql8UgrIqMKBqexgVaxqtBJv?=
 =?us-ascii?Q?ZML7JtuqaOC19jVZAEhYUFelBM7sN8AuZo2i9cr0t9mQwTyC1AaeVktr4hvq?=
 =?us-ascii?Q?bmOAfzvDOVUidiPXYfileQlxsloxrxXHUIvVo4sbhpGZVXw7YtoF+d7NB71z?=
 =?us-ascii?Q?Adj2hsA5QWO0j4T9ItbIghvX8Vkdc+thE59B31IQ5nSD+PjjdCNn7cKOWHhT?=
 =?us-ascii?Q?wAB4TcuxRypwVsFfcxSJY/iJRDQjY4ROAXpO/qvZ4IDLp8/z7F9tnRzHlj/O?=
 =?us-ascii?Q?DRO2XSDJccqobSQlUNuz0QXk9HuhCgeHmSIzhHFiugzDS/wKqD5GkKep9MYy?=
 =?us-ascii?Q?aDZNYfTpd5rObCVAhu9xmgD1IlnCuMwJRxeviFolTEGLYFC4Wl69WDnCF/4e?=
 =?us-ascii?Q?VGppBfHyGo4OyO+w/r7LjVwGA1YZ4GZUtoGxFMavPwYSqcf13ZNCFJBh6ALY?=
 =?us-ascii?Q?A0xdqScawilBH92y1JhoALiguUeNP9r1lANIRKH9IDY936+0z5U/7B6AsVWh?=
 =?us-ascii?Q?t7VqphyVmoZvb0ddA4DW//G2yxUb3vfHVBe2a5akG1ZieajyvPmAmvqCeerr?=
 =?us-ascii?Q?2/7FCh9i3jbdMHBD9snwJaqEea9ZR9kWyr1n1eprjEo36pAXzw2q9i17xYSy?=
 =?us-ascii?Q?6fwsJRi3yqdBZHCcdUHW+uvudWeBap72Ezm196+2BTKTZAyjA6dLXfghArXh?=
 =?us-ascii?Q?E4YjFZW1C6EHKMYOp2B8jbtiPYPnTgn6yzCnMQW0HdcWYSkPxFYaRT4gdfb5?=
 =?us-ascii?Q?HZHaY1lugWtNl/UGi+uHLTDzdvYGhVwQKVobrwq8QCpQmoTdu+oVormAqDC6?=
 =?us-ascii?Q?CHiVECTo3uotje4Qaob3slDUGqZ5nUJLlXXq9Z0IBna1LckZydbVsDXPOyNK?=
 =?us-ascii?Q?hI1IKJwlyh84toy9urQ/Vh1pdJwB7Ri1ixtMuLupf0S8V2svGQaoMEVSFoOW?=
 =?us-ascii?Q?6REjRgLKBIeRJTdlM6usDP5PIsoyXImokpX16bN2+M9D0BrIaF/mJ3v+8gFg?=
 =?us-ascii?Q?/85JiQIC2mBEUyaD8cGg80a0EdWW2cgPS2O3si/Q/soy5I+FQ01HUsPy8I7B?=
 =?us-ascii?Q?NkoPR9oyPJZMOzxup4sxAXRHPCS/opuic/FWdlOp8yfBU3UFtBqYfpnZRwgw?=
 =?us-ascii?Q?tI8WR288yGu4KF37UaTKeGbrrr4qgkA1mqp5ax8XyctSLwA+qpoyq38ASRXE?=
 =?us-ascii?Q?ksuPnDXCmisiw7RCr7XZulSo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df10699-bc4f-41f6-0033-08d91c4b4dd0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 11:26:40.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebJue8LJfjQ0pljlkA1wtdVO0B1p5VEKWqRDECRYlIFsKRjCMAI+92mF6tsuJ0fZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4039
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/21 =E4=B8=8B=E5=8D=887:06, Johannes Thumshirn wrote:
> On 28/04/2021 01:04, Qu Wenruo wrote:
>> +static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>> +			       struct btrfs_inode *inode)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> +	struct btrfs_io_geometry geom;
>> +	struct btrfs_ordered_extent *ordered;
>> +	struct extent_map *em;
>> +	u64 logical =3D (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
>> +	int ret;
>> +
>> +	/*
>> +	 * Pages for compressed extent are never submitted to disk directly,
>> +	 * thus it has no real boundary, just set them to U32_MAX.
>> +	 *
>> +	 * The split happens for real compressed bio, which happens in
>> +	 * btrfs_submit_compressed_read/write().
>> +	 */
>> +	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED) {
>> +		bio_ctrl->len_to_oe_boundary =3D U32_MAX;
>> +		bio_ctrl->len_to_stripe_boundary =3D U32_MAX;
>> +		return 0;
>> +	}
>> +	em =3D btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
>> +	if (IS_ERR(em))
>> +		return PTR_ERR(em);
>> +	ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
>> +				    logical, &geom);
>> +	if (ret < 0) {
>> +		free_extent_map(em);
>> +		return ret;
>> +	}
>=20
> I have kmemleak reports on misc-next for each mount and git bisect points=
 to
> this patch. Aren't we leaking 'em' here?

Oh, you're completely right!

>=20
>> +	if (geom.len > U32_MAX)
>> +		bio_ctrl->len_to_stripe_boundary =3D U32_MAX;
>> +	else
>> +		bio_ctrl->len_to_stripe_boundary =3D (u32)geom.len;
>> +
>> +	if (!btrfs_is_zoned(fs_info) ||
>> +	    bio_op(bio_ctrl->bio) !=3D REQ_OP_ZONE_APPEND) {
>> +		bio_ctrl->len_to_oe_boundary =3D U32_MAX;
>> +		return 0;
>> +	}
>> +
>> +	ASSERT(fs_info->max_zone_append_size > 0);
>> +	/* Ordered extent not yet created, so we're good */
>> +	ordered =3D btrfs_lookup_ordered_extent(inode, logical);
>> +	if (!ordered) {
>> +		bio_ctrl->len_to_oe_boundary =3D U32_MAX;
>> +		return 0;
>> +	}
>> +
>> +	bio_ctrl->len_to_oe_boundary =3D min_t(u32, U32_MAX,
>> +		ordered->disk_bytenr + ordered->disk_num_bytes - logical);
>> +	btrfs_put_ordered_extent(ordered);
>> +	return 0;
>> +}
>=20
> This hunk makes kmemleak happy again (for the range I've tested):

David, mind to fold this fix?

Thanks,
Qu

>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3c920ca0ffa7..dfa8e5435ab7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3233,10 +3233,10 @@ static int calc_bio_boundaries(struct btrfs_bio_c=
trl *bio_ctrl,
>                  return PTR_ERR(em);
>          ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bi=
o),
>                                      logical, &geom);
> -       if (ret < 0) {
> -               free_extent_map(em);
> +       free_extent_map(em);
> +       if (ret < 0)
>                  return ret;
> -       }
> +
>          if (geom.len > U32_MAX)
>                  bio_ctrl->len_to_stripe_boundary =3D U32_MAX;
>          else
>=20
>=20

