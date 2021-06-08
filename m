Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8639EC33
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 04:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFHCht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 22:37:49 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:49499 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230377AbhFHCht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Jun 2021 22:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623119756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/H7ZzELD4DsEsOPQrSKKMUMBzgpVM9OpoUBHBRgsrhA=;
        b=fB0NFAvLtRSd1B1C/T1hVjCupzEQVHbU+QX8sfAq7YapHRonc9/EKdsN2qbwlmppSTtLEO
        TzCyMbCNEV369grtPahtRY4bEXaNuKTiU/DE8nGu87p00UBqqZL8VwoTd3o5sxeJgIuOT2
        vPyi+I8CfLaW8vLe7J9yWKfxl3eCImg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-7-riHrSV1mMRSOTKwzwdFhEQ-1; Tue, 08 Jun 2021 04:35:55 +0200
X-MC-Unique: riHrSV1mMRSOTKwzwdFhEQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4cqSfH/e/KdiQFC/ppnXqkhTqzdiEnuNmWc6KZ1qQeCGJC8DykNRRrv8fx5MwUJRRfb7kdxOl0DRrFnnEMOeAdLVO4fqK5ko7DJ5SmeFJLruHH4X2A42CsVwmAgZSkC1wujjJj67TxgR/W/BZ13lH6edTajxUa1wTGsd+/0D5NBJjxZJU8qK4zIeDoINEPV65RGMyeFqXLR41nIF1k+sjpel9o+O6EW0ZdLR5e2xsJnUyLD3iw80xnWNjGvHxwrnsBrppMdGzycoVwoWP6Lrp/nbK2R1sCld2QKlZmKebOygF0eX+5832UimXOhDUf9bKGy1BmU7CDXZfD5liYz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Nplr57sFwZ28hZGe/jNJN/H62LipUZN9aC9IGLZxxE=;
 b=NDUyzQ7tE264fLqmprWSoluNzZESsLCOjsC4ZqAsNaXWvhd0ao1sKoGEtMuRJ834I2Xzlqo+RNxn4YfcTShPVCXIPKUl3bhLED30H5bRb54WjaaknBlYCwk0T7SiDOBjKKi0X8d1Zg1W1F0rDDm0tCUcezs2GTjY/e6+WyHTIYsQNfDMXY6rRXetIP47uZIqQ9hSFU6KF6B7cZJ5j9+xydSSdd/mEVLVJo2XDbs2A8pD4m3bv3tVDmuu6pLU8Pw1sDktLQkhYkAUNK/CPV+Rogol9mN8wQVn+UPwjtMG4yczXUQTj4p51QR3wB/2XmWW9MO4cl+Mo679Nr6AAYanDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (10.141.172.86) by
 AM7PR04MB6776.eurprd04.prod.outlook.com (10.141.171.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Tue, 8 Jun 2021 02:35:54 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 02:35:54 +0000
Subject: Re: [PATCH v2 06/10] btrfs: defrag: introduce a helper to defrag a
 range
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210602021528.68617-1-wqu@suse.com>
 <20210602021528.68617-7-wqu@suse.com>
Message-ID: <99f42f62-bb75-a4a9-9360-a5ff25bd8f03@suse.com>
Date:   Tue, 8 Jun 2021 10:35:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210602021528.68617-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0055.namprd11.prod.outlook.com (2603:10b6:a03:80::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 02:35:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85196993-983a-460e-000e-08d92a26238e
X-MS-TrafficTypeDiagnostic: AM7PR04MB6776:
X-Microsoft-Antispam-PRVS: <AM7PR04MB6776013EAFE4E2F2BD3DE0C8D6379@AM7PR04MB6776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUIbkBQjwslEORqVG1/wCWvt0O9tTqNTXz167HIGd08PozK8erBo4JCFglW5vNTCshtte3mpJazvGtFIPJr8PFGzqD5qUVJNWQ/H1aOod3/INUOabvBM5hU8y8121vhi/8ALaLVfmMOhyctaSZxftZKYsuhUivEQBdCcTdkh+DPPq/hRmi7pOBjlPH0bCkiNc2GrtsdIOxX7WjOglIPgXwjPQ+p+9OcMfU+aWHahkm4LL9dJ/PzaCiAO/QE4Ok1ySsBIVHTd39xa6b71+3IImKM0tzmEhfq2HeNUKCBHBGLaiL28WQo+ef5rgYDF0XVrkebUHSuhjPzzlxicTW74ys1a8GAwJz+LCfZTVT+sjeHuJE0CJE0kgfba2ilJaUrb6d2YLli7VpLQl7xq1x4ejPBc8xh8pYy4hAry5axYNHRwhnrE0fD2nO0PkGakh4XeXvrMxdwJOP9SIdzmjtnJ4mNrk++pk0IZfrjvyY1npk8T7Uzp9J3HAHumBOnhvCLdK0bHlRXaKHX3Yrd5bHa/UCvi9aJbd3uMSZGwsYGyTP4j2Tw7eY15qZVAsiuy5VK/G6zylMcE0rNIqD72CyLi+j5BWsHJwtUlKNAoLa+M5yt/JHvOwm+118qbvmV7AcS5X0U0GZFZtJhaJlB6dkFu1kUAP8ipdbcfLhKT949opBsPq3UZrC8dARbXZDAA1WN+tyoAF4a57CzWr1+M5uR6Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(346002)(136003)(366004)(396003)(6666004)(83380400001)(316002)(16576012)(38100700002)(186003)(16526019)(5660300002)(66946007)(956004)(2616005)(36756003)(8936002)(6916009)(6706004)(8676002)(31696002)(2906002)(26005)(6486002)(31686004)(66476007)(478600001)(86362001)(66556008)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b4hKBLeSyXvkyvD91BfLciK+kTQ1IXWpQ23gda19zJaanQKxEKsb8DoodlAn?=
 =?us-ascii?Q?vP3nbLjWltuMzrVofXx2+PEpcyO66ATWB1V1SbBFCxHVgRGvPTLz8czE19ca?=
 =?us-ascii?Q?tVizoYdmta38WzInR1TQVkNddBRR0rdYNP9jD/RCVU8JSRyAPAnWN1BEFYJq?=
 =?us-ascii?Q?AGGSa60T2c3I2fSe/D4WyZAZdix9r8mufy2+2nj28lu7rVe4kAPTguGSCQhK?=
 =?us-ascii?Q?6wctFHF+ETPOT9soN9nYUPRQ7j96m9QtFozPp/8KAHi9vyKHr+JACwTHjpzM?=
 =?us-ascii?Q?m6vKGloZPDdDidHo0IdlMFS/3n7t/NZXUnQxV+IzTEiNSMIm/Y9e32yJcSuO?=
 =?us-ascii?Q?EJuSQ5z/l3bupCQ2DsnkITUZeayU1wIg50U3nvmi+2lm8YiBH2p+p8BlIivP?=
 =?us-ascii?Q?sk2LtlCVdnoi1ENRrDENWeRgKKA/+1HifZKd29WpHJo+GfdDgZvrHsc2I0C1?=
 =?us-ascii?Q?pGbkJp9wL5Hx3/Q4BtEqDTjx8Et00ZBV4vyZk24O0hPiL9mXyLzfrHqkBqST?=
 =?us-ascii?Q?pUGp6pWMcgsWQlX8l7eEu1Wrd77Hyu1Qh7eap6e/pc4LJ6Bljpxo/vjzDere?=
 =?us-ascii?Q?5Xxyy7ZdtJDS6KxLLMKIH8BLi1AfGH4gPs5vLdbrk3mItHfUXJzDSJxtksnJ?=
 =?us-ascii?Q?hAx9iaExeN3iJyA6Z11w9srp36MNiXtIjJ0LwnfpJ6DqGbe3fSg4yx1IDf2t?=
 =?us-ascii?Q?thmfyI+y+gS27MMfX/Tmk9uwfgBhympI9fWIOvqadga4coLuNr8s3p0+aSfx?=
 =?us-ascii?Q?sGpDenlGi7N7LEagEHL34rrNQ7d+6Jm3tV8fP3HXvfn1CJtbuoIMXOhxsNBx?=
 =?us-ascii?Q?+0wZfv7Mt+qU2w66HCsBKXPFH+zwHTRY45RXQwAn+j2im6BlESmJ9A7nGIvx?=
 =?us-ascii?Q?IufijqvtRggmWtM9bonOOhbk4MfKRFuemYw4xznT25iiVznUBbbR0op/70Dc?=
 =?us-ascii?Q?F1A2bxzffP9DzbKGh4Hum4bwLLn9BeBrEjQ6pvsdN9Yyv+h80aArBhNBQ/6U?=
 =?us-ascii?Q?H77SKSb+yGqPMJDfJLfxFLS8p09M/YDOOIPpGcUjBoJ/4gsfzuk4Oxthv2ue?=
 =?us-ascii?Q?kOZS0scEmQGXCnGVjO49OA8tGsEiXHcJVRsyKwhilT28wx53LrG0CKNSC8IB?=
 =?us-ascii?Q?+0dq6s2Mgb9QBApgxz7T4lHTWqyhRCJKrND7x9fjOyfKG4c7uKWVdoMOzXSh?=
 =?us-ascii?Q?j+zbuWbCK/lReMUPXb0TfxyTU36JJLkmwQQw3OdJ8O26gOBdJX/AUQ3r05oL?=
 =?us-ascii?Q?3+Y6+66B2bdAdVjY/21E2supOmdil0JhviTL8tb/UZyizHA/piQAb4VEZfZv?=
 =?us-ascii?Q?/ch49js5+1vAgKIoA9AcRjUN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85196993-983a-460e-000e-08d92a26238e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 02:35:54.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejUYOv6FEz+IFC/zg0ImfSL0bSy4YUOm+j4QzUbhDC6cdSt3AXGVnciXtc7qjWiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/2 =E4=B8=8A=E5=8D=8810:15, Qu Wenruo wrote:
> A new helper, defrag_one_range(), is introduced to defrag one range.
>=20
> This function will mostly prepare the needed pages and extent status for
> defrag_one_locked_target().
>=20
> As we can only have a consistent view of extent map with page and
> extent bits locked, we need to re-check the range passed in to get a
> real target list for defrag_one_locked_target().
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ioctl.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 26957cd91ea6..a5ca752bcda8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1548,6 +1548,77 @@ static int defrag_one_locked_target(struct btrfs_i=
node *inode,
>   	return ret;
>   }
>  =20
> +static int defrag_one_range(struct btrfs_inode *inode,
> +			    u64 start, u32 len,
> +			    u32 extent_thresh, u64 newer_than,
> +			    bool do_compress)
> +{
> +	struct extent_state *cached_state =3D NULL;
> +	struct defrag_target_range *entry;
> +	struct defrag_target_range *tmp;
> +	LIST_HEAD(target_list);
> +	struct page **pages;
> +	const u32 sectorsize =3D inode->root->fs_info->sectorsize;
> +	unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
> +	unsigned long start_index =3D start >> PAGE_SHIFT;
> +	unsigned int nr_pages =3D last_index - start_index + 1;
> +	int ret =3D 0;
> +	int i;
> +
> +	ASSERT(nr_pages <=3D CLUSTER_SIZE / PAGE_SIZE);
> +	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
> +
> +	pages =3D kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	/* Prepare all pages */
> +	for (i =3D 0; i < nr_pages; i++) {
> +		pages[i] =3D defrag_prepare_one_page(inode, start_index + i);
> +		if (IS_ERR(pages[i])) {
> +			ret =3D PTR_ERR(pages[i]);
> +			pages[i] =3D NULL;
> +			goto free_pages;
> +		}
> +	}
> +	/* Also lock the pages range */
> +	lock_extent_bits(&inode->io_tree, start_index << PAGE_SHIFT,
> +			 (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
> +			 &cached_state);
> +	/*
> +	 * Now we have a consistent view about the extent map, re-check
> +	 * which range really need to be defraged.
> +	 */
> +	ret =3D defrag_collect_targets(inode, start, len, extent_thresh,
> +				     newer_than, do_compress, &target_list);

And this defrag_collect_targets() call can cause random hang for tests=20
like btrfs/061, which issues both defrag and fsstress.

defrag_collect_targets() call defrag_lookup_extent(), which will try to=20
lock the extent range.

If the desired range mismatch from the locked range, we will wait for=20
the extent bit to be unlocked.

But in this case, we have already locked the larger range, thus we wait=20
for ourselvies, and cause a dead lock.

In next update, I'll pass a new parameter to teach=20
defrag_lookup_extent() to skip the lock for this call site.

Thanks,
Qu
> +	if (ret < 0)
> +		goto unlock_extent;
> +
> +	list_for_each_entry(entry, &target_list, list) {
> +		ret =3D defrag_one_locked_target(inode, entry, pages, nr_pages);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	list_for_each_entry_safe(entry, tmp, &target_list, list) {
> +		list_del_init(&entry->list);
> +		kfree(entry);
> +	}
> +unlock_extent:
> +	unlock_extent_cached(&inode->io_tree, start_index << PAGE_SHIFT,
> +			     (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
> +			     &cached_state);
> +free_pages:
> +	for (i =3D 0; i < nr_pages; i++) {
> +		if (pages[i]) {
> +			unlock_page(pages[i]);
> +			put_page(pages[i]);
> +		}
> +	}
> +	kfree(pages);
> +	return ret;
> +}
> +
>   /*
>    * Btrfs entrace for defrag.
>    *
>=20

