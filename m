Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58B3D7336
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhG0K3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:29:23 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:31244 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236212AbhG0K3W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627381761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Va8Q1E0zrQqMztnUPAeaduCex1ELHSQBdxxCNfrriQo=;
        b=MFE0KrN+s7RQRJHVk1dWm2kr7W+M90n0ON2uLyQsMvnc9+hDaeiCWWzEhwA7ioEfPqzAh4
        fzCjD11MJ10XXrx+VMDVT7ChrDx/YLzqN7pMsKK2UgVAQbXz40Xn8i4yAr5uzXGb/Lf2/0
        6cv3RBaJxTlBjaTjnixPBtFz93aJOuQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-1-MMhW4Q7WN72Bstygm4cHyg-1; Tue, 27 Jul 2021 12:29:20 +0200
X-MC-Unique: MMhW4Q7WN72Bstygm4cHyg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHIl3CIIAGblss26i9BUZfFL3Pi5BjvNXoMnT5tM5BpB/2727bvntW43r+9+9OHaYcTzPjIqKAqAY8pbI/J8/0tVnhpw7N9Ow3/EjcFej9Y8He2SO//5Rb2HkdLWBsJ3sEfqwB8Zfl3NGsfna66hBbZPjGi2o9ZwpvGVE7IVHtRO8HWdnkX/9ZaWDZkGASfi2BpGVWcdv9DVB2MjVL3KALG30RKtjnHt1k67Y+LjIlxbM1zeyFTFRICtH0Fm63bYKU9RpEP8A6Xs+BWYZDXPJeHRUa+eCz/TANwAox9EgkQJkjGFHrR02fBRiMVXkoS0Ek3BXhkiK90ggK2srTBiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSy/iZfrvyb2nH265ACmLsL8MoXXma+HFoABPIp6xVg=;
 b=hKDreNkDLjcz1tMdaJCGm59lXiUsVdCbWcB+Bl42dk+iv7SpabZXZ9Rc0twfev0vY7AT4TG4i0CpFh6GI8zfYNbeT1jbH9+bnlVbulW9/RKVY8pbAc9c4gpO9Wbz8dqeIqMInlNuUQhhYA7ofMVand2gdz+XVd9NXpxkfBxtdVKy2knHR/OtCBakM1m2adMfFCD3oS/p7/usHDuVcltdEB0TM8/NhFE2FAWPxMB8tCcUeZaVwJvsZwva0kRMhOsUlZBwFhx243r8dpAxYE3JpPTDb6btbQgu+HbBQ6k9X4hJWJYHgc9Jsdl6IrWoddFjyILWycm6a+CjTo30/86R6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3894.eurprd04.prod.outlook.com (2603:10a6:209:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 10:29:19 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 10:29:19 +0000
Subject: Re: [PATCH] btrfs: change the set_page_extent_mapped() call into an
 ASSERT()
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210727013942.83531-1-wqu@suse.com>
Message-ID: <68e6284c-3bac-8fb8-af82-1f717bffd3dc@suse.com>
Date:   Tue, 27 Jul 2021 18:29:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210727013942.83531-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:510:e::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by PH0PR07CA0054.namprd07.prod.outlook.com (2603:10b6:510:e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 10:29:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c2f5b31-bf1f-4d92-5cf6-08d950e9645a
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3894:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB38946A8F4BAFF002E0E743BFD6E99@AM6PR0402MB3894.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqg2aRpCof2TIi0m+YzKsz/e/sYCHPQeKMBnLJhzh3su5zzNKYFLLgrAuD25gt+cegH/Kd1TKg6+AK5zmo1ib1chVO1km+Lhi3+/Rhk+WBI5032oR8GzWWow0tJYhVNlfAPAoq9JGKapcmmGAfwUOuKx/2fq4i5OZ67rqJm9p0o6/DrOjEHWooowB5nqHvEyE5GgSE0RYfVeaYdnjBHYK9+BjtFl8ZTPvSMkkF8B1CWZyUqze9DVrVOLKDhlAVXOuD+bZypWgMqbPkZ61gXmFAh9T6Nrs9lS9L82+hL9Fm8NV277fcs5iqItTFmKUIuEZRf8LyKlFzDBfJ7jOPi9kN1eQq4P8JaLN/xqZZ1pOKqtyifqtLqzBqtY9vMbK/yigAOywD/IgZEqorBRGdIGfBqDAYDyUkuX4kFC3U2euELcPC4C1I7qM6+KHiDFBFW2xQBRKtj5k2CB8F2FJ7pjpAMaBNGP+ODoSnecjgmHnTc4ldrv9RvwyvfpqiRncVZyOBE5viNESSDBdzyepqNcKnfLwgmTPUOclfCIj3gPfp5D2GYghGvtoKGb+PXA9FwyFhskZ1YCsJT3/DyiMYHXJiHqGLkvNabhX6WJ/fIFMjPQXA+X/+5DvT1wAngAJkNKvWaslQZyRBKaXIp0YYkUAU8PDTNOsUdRu+ZIVJpmhMIEsxx4z9skoAnqO+ZUxSA+VkTJ/rhainBRWyPjZNiNNSy7P3LJXoF7aikcr2MsuaG7XDRFGr+zBQ/j0G3xB6JD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(36756003)(6666004)(66556008)(478600001)(5660300002)(6706004)(31686004)(8936002)(6916009)(8676002)(66476007)(66946007)(6486002)(16576012)(38100700002)(186003)(83380400001)(86362001)(31696002)(2906002)(956004)(2616005)(316002)(26005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XwQ3CVXHWpjmp3ujVkmlaRKyxccCkrLTqPr7ZplA6k0+m/dye/VZpSiRAwRV?=
 =?us-ascii?Q?FTapomLPbuFBfv08Nk6cc3XJew4bDyXzjTtlI9vqDK+dzmoyfPdaoPo8toqj?=
 =?us-ascii?Q?+VQONTP9jvbZ8M9z3bqMY1XTDczVychzECeMQVv8+WeQdyqBTICqaRJdv1CY?=
 =?us-ascii?Q?7R6g/BRV9JD31mBgZRkGKlZktqiIFCfFw+uBOxLtgKwHen7oj8UYltdWU/dT?=
 =?us-ascii?Q?AhvJnzWkTREwP0PPj3PvglsjAJMynMNQcyXak5AzcZLC+Ud9dyqunnbcmenm?=
 =?us-ascii?Q?oaIycGrU6ofmhZdF8vUTGlGRMbKlrMHAs4x+NAWFxW11NBuC0o7vPa4joFqo?=
 =?us-ascii?Q?UAVLkW/K2jSq/JG8375PZ2JxzwBvdVte1Am6UVG82DbfiQ4fPNYE5WtAahvk?=
 =?us-ascii?Q?ie7l+B5IJ5PdwzVXkGDq9Dc7nkNULhkDGh2omwhQ0GzjtpsdOO2QzTAXjBxq?=
 =?us-ascii?Q?CuvQt8OTTzzga5N19rn/HuGqSLgXMoq8XJeS+Yp58WAWbmsyp3gAXDE/DaRY?=
 =?us-ascii?Q?TsQEHosKmVXnps//c8DNKXE/6h5c1OZN9SeasVtXbP5i2Nj3VB0iUXVaWdfG?=
 =?us-ascii?Q?Bsad0+q23n1UXs3ZUClqDCytevDhFcqkwoluci7SX/YQakz4kRdYlE4OuVeO?=
 =?us-ascii?Q?rLKdl+9icq2rvHT4pQx3y8ZWxpqkv2sZYkihbnyTy+o0718lsgg4sOM5ehdr?=
 =?us-ascii?Q?KsuARQX7mcqNGicQfcOJQP2S8TJsJOfeQE4NBnUCbAcE+VPU4NvCu/VbTWJE?=
 =?us-ascii?Q?cZsnUT2NNA0NRNyhyt5CdYb33cbPC5H9g7uvpGPo3AUY0Qst/5Fv2tQE3oAB?=
 =?us-ascii?Q?xj2AM/dNA6HJjPOYiq356xazuEcY/dj4Mwu5Xmx2ncr0GbLfmek3TvplRU+C?=
 =?us-ascii?Q?LL3PJ+lVqijJLq4KMxwhI0UnJenLtno27kcSzZ562rGTY7yKxYlPAj7x95Uc?=
 =?us-ascii?Q?HiRptT/4npzmH3LwVnzs2P47l/1V78IqBcuT/u+YzPS0f05Ys+dtyy6tzNBI?=
 =?us-ascii?Q?G9HPmCW3UpYFFQRgMiu6KaTd5Fzdnq6jWQXXlZjvqEpNDMfbCFminS6OjE2m?=
 =?us-ascii?Q?KiFCG59mLy/PckPRqVpQwlOsF32KR4obcHhlLwL5byGUdgU42X8mauK32TAZ?=
 =?us-ascii?Q?ng1zTsueiZRVhkQaVrGCdO70E+zHp82R5MXCLM4iUPnOqOcvMgLHYCfUr3GK?=
 =?us-ascii?Q?bidyEz5K3d32XaZPB888lxNRCvgdzdASaNEHcaV9Xr89xGKYh886nfwYVxfI?=
 =?us-ascii?Q?xQOqatTMkJDj/XMO2+ma+CI3yIZSq4QXS5mbefxrNiaXmn5435pPKL/oc9c4?=
 =?us-ascii?Q?bU9rBPdTESkwQkVZ2L5egoYZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2f5b31-bf1f-4d92-5cf6-08d950e9645a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 10:29:19.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7RFaI2vt2Dj0ewFRF4BlIqZKR4edxDKsDMPmywpDix0/fz7YEKDYXuxrUyaOaWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3894
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8A=E5=8D=889:39, Qu Wenruo wrote:
> Btrfs uses set_page_extent_mapped() to properly setup a page.
>=20
> That function would set PagePrivate, and populate needed structure for
> subpage.
> The timing of calling set_page_extent_mapped() happens before reading a
> page or dirtying a page.
> Thus when we got a page to write back, if it doesn't have PagePrivate,
> it is a big problem in code logic.
>=20
> Calling set_page_extent_mapped() for such page would just mask the
> problem.
> Furthermore, for subpage case, we call subpage error helper to clear the
> page error bit before calling set_page_extent_mapped().
> If we really got a page without Private bit, it can call kernel NULL
> pointer dereference.
>=20
> So change the set_page_extent_mapped() call to an ASSERT(), and move the
> check before any page status update call.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please discard the patch.

Although I haven't hit any problem testing the patch, it's still=20
possible that we have a special page that would need cow fixup.

Such page will be:

- Dirty

- Not Private
   Thus no page->private, this could still cause problem for subpage case
   though

- No EXTENT_DELALLOC flags set for any range inside the page
   Thus writepage_delalloc() will not find a delalloc range inside the
   page.

Such page will be caught by btrfs_writepage_cow_fixup(), but it will=20
trigger the ASSERT() added by this patch.

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 62f0ed2de2b9..219add264acf 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4099,6 +4099,12 @@ static int __extent_writepage(struct page *page, s=
truct writeback_control *wbc,
>  =20
>   	WARN_ON(!PageLocked(page));
>  =20
> +	/*
> +	 * All dirty page to be written should have PagePrivate set by
> +	 * set_page_extent_mapped() when creating the page.
> +	 */
> +	ASSERT(PagePrivate(page));
> +
>   	btrfs_page_clear_error(btrfs_sb(inode->i_sb), page,
>   			       page_offset(page), PAGE_SIZE);
>  =20
> @@ -4115,12 +4121,6 @@ static int __extent_writepage(struct page *page, s=
truct writeback_control *wbc,
>   		flush_dcache_page(page);
>   	}
>  =20
> -	ret =3D set_page_extent_mapped(page);
> -	if (ret < 0) {
> -		SetPageError(page);
> -		goto done;
> -	}
> -
>   	if (!epd->extent_locked) {
>   		ret =3D writepage_delalloc(BTRFS_I(inode), page, wbc,
>   					 &nr_written);
>=20

