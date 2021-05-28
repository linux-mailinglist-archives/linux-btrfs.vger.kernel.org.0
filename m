Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272D239410A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhE1KiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 06:38:09 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:40788 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236519AbhE1KiH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 06:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622198191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NRT/t5HWCD1JymYftwXclxYdDDRYR2O384M8yYUfhA=;
        b=f24XIVDjc/MMaM1dKlfUsX+NJmZAKfui37UT53Np25K+YO7taPJThLTg/yM4DDGu9qHp2w
        z5s01nhk+7qTjCJZOF7HT8/TvjRbMyshJSb8SUQGhuB0+JlATJoIjecYQveG88AwVF96CA
        +QbdvfEHfvOhq83Tb4xjcQYHycWbuJY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-kI6pH2GfPbmfpRqebHdMJA-1; Fri, 28 May 2021 12:36:29 +0200
X-MC-Unique: kI6pH2GfPbmfpRqebHdMJA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwqFz+CoLlkrNlecr29Mxv5L2Xb9ZCIfewTAVQWoi/h9TXqMhOwoHU/V0MJkuSKpmcQFHloEE29nyLZqlKpSDSLA212Y6cJkA9dmNmgQDan5XhK4fxtJY6lKnYgUQeJeV8ZdGNPDkpscxJ6n4SXO+sUFwiVRxPk9NemY2bqdJvEaDSlInPyVf4DniVQzQtFjQtEvemdWgAJmV0GIvozlDNHR1QSswpqV2jC03cR5iCAMmR0peMBAgYQmYCYhQ8KXMLsd+yF4zLeqootC/ZlgUKW2/PAETkORVPWMJJO7MSvur2fiE+waWjWp91Pi0JPDbSxElxxfvMCgx1lB+WytRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bi0vUpNNL6N2etp28RVgcl657ZXLLFyc79dI7eqhcI=;
 b=JF/Mxi9LBF67jnR5deNSibmzAozYGetqJ1iu5UV0ZWfnMT4NNfnyYNPb+8xRgoxhDXjAcZh/cHuaCdRSSg+MW3Fy1umLLu63xoBxqHdxKDXSGz+64e0WFl73cbie3HX0TnAti3bNG9y7vudviRqr3979FL5uXKs1tvsllpOxk2YEFeg7QzujFfT6P7T+sOBwHpJHa6qnk/yUiU17P9TCZUOCcRSSRPvlZM2DLZ11/sFjz/W0LuPfyOYlZr2cdNk8MmEVKAiha22cbHlDtbUsSG1GP4QqpMEa7Xgc6IP/003GAWMw2sbe6cSK/sjKRWDQHH4tdADeP1LllNVgID+PAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4680.eurprd04.prod.outlook.com (2603:10a6:20b:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 10:36:28 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 10:36:28 +0000
Subject: Re: [PATCH 2/7] btrfs: defrag: extract the page preparation code into
 one helper
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210528022821.81386-1-wqu@suse.com>
 <20210528022821.81386-3-wqu@suse.com>
 <PH0PR04MB7416FBCA389AE72610B6DEB29B229@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <7008c54d-d5c9-3649-a03c-3f69bcedf255@suse.com>
Date:   Fri, 28 May 2021 18:36:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <PH0PR04MB7416FBCA389AE72610B6DEB29B229@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Fri, 28 May 2021 10:36:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9894d2-57e8-4a7a-7e06-08d921c4735a
X-MS-TrafficTypeDiagnostic: AM6PR04MB4680:
X-Microsoft-Antispam-PRVS: <AM6PR04MB46802B93F03214AEA0C6AF2FD6229@AM6PR04MB4680.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cg4SF8oN0jlIpFJ4XpH2bs+2DI3gDQrffC09oVStXtlWZuw72CfSwXpGd5PE/tAZ+a+yb315Inwb/M3Bz9ZGJwBk4HAjXl5Uppuaur6P3H9r37V7YP/VaZOAadmwh4jtYf3vnTqfav/gS6Lmr0dQuEEPsXQTObZpt4COmeHwgFffPAeD1OzCzh6TpjVtDnaZ/3qg3/SLDVJirByg+wWFEkAttG3QxOtiRZT9EGvhXE7YApi7v73Gk493g8tNLjIycpNj3QG0EkJbZ/fO/lHN9BLlovN111eqhB/mWdpisHUPfidwA7YMCLBO9hSHjg/7raw5YZFqjGc6srPMxPWLsyoNwqdBVJ82CE6QexJi07HBP2Mf0Voz9s3a34YLA9ZJUJ0c4mm46+EbfWYHrSEulTeicSY3PucQwaZkUQGllQBx7WkmtJ2W2kF3caWpMJXknU6Lq9joXXIKiV7g0+2w2Aoea5q68qbp3fIbrlwM5XKeQEMevvl0u0GOpyQ3nfiybfpIki0IzgpNVMlNnC2Y6ga/toQyvcpHFAQiH8cABpZQnI0Es5QV4XGITgMGetaL87quTK7rAHLPfrYvrSiAfqtzZgFKBDaj0HVXxChIHqW0L7+ulC6w6qgqbOEU047EjJNVq5qgq6te0FDIM4225Ao3B3owk0OfUdIle35m6X5Loa329DM8A1ddK8N+oo6D5uqYnbXlsAA+nIkqhqR3UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(136003)(366004)(86362001)(110136005)(2616005)(956004)(83380400001)(16526019)(186003)(31696002)(478600001)(5660300002)(6706004)(316002)(16576012)(36756003)(6486002)(26005)(66476007)(53546011)(31686004)(66556008)(2906002)(8936002)(66946007)(6666004)(8676002)(38100700002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AETDKk2woV2Tg+GbwcTgSepxgdmiWrmBUEXxtSBZbi8Kzo98NlGNgzMyAy6x?=
 =?us-ascii?Q?u0a1ypT48ORw9mOWpOzJkVDVYmC2LFye/BovoCvmXcD6IIaILHBfaHVgkk0K?=
 =?us-ascii?Q?nAafNfIEILNKphfnX1oDaZPOM+t2gJb21K8513Qrw2nJ82fC4ZbgIzBDFvbY?=
 =?us-ascii?Q?WBop8vJyuKRog5EBakNa8Y4Vk/Qdx/YBL5uKN7+kCaUVgttrNWkFfHMxUFzj?=
 =?us-ascii?Q?XITQWMp0AtdPoavSbV1BFO0Rc13sRH185HbrGJ2ZJ7z91NaQgr6cKp5WlSPW?=
 =?us-ascii?Q?1Sg0HhYqIyxq9cdIL+eAXLISNpMtjPfbYq0TVhieT1xJ+DOrDA1IgZ7WGCQj?=
 =?us-ascii?Q?ewliOI1JuzQV+HNdvq+0FLvl1gguIiRxG65RJVkvreDqKbEx0kcJCEdGJZxK?=
 =?us-ascii?Q?oShUbOQ5ATbqWZ3RuQWS3vJinbeRP2/DokHIpKgsErp18zLAtKo8TEwy7x76?=
 =?us-ascii?Q?iFQKrDniuqrQ24AbkaTS+VZfPajbDY4oB/AKcBNj1y25zUiX1zfnsX9rRcKX?=
 =?us-ascii?Q?Tqy87xsvxBBStHQ9OuKmCEz0cGp1bg5qIq3zm/XaFmc4jO3q3p8ErsALDJN/?=
 =?us-ascii?Q?uC/WCgZ1i1nJ2NTaZjYmzoVKYen6djPuaw22G+b/uteCj2aH72eGLpTjLMX9?=
 =?us-ascii?Q?Rdz+0nTEcAlJEhlEtjuP/nmwx59G7OCI/rLTlZUYPqtl4qjadmaoAo4eP4Ya?=
 =?us-ascii?Q?dYNxgFqXpnaohF6cQCuNJyEuv/HNV1waDEsOL49RkNfWCtTI1vyENVFFxi0j?=
 =?us-ascii?Q?g3noyj2j9Dwd1q6xF/Jwcv8NkUKXbr3KDOorS4qEZ33sgHqN4UbGsTfQPfFv?=
 =?us-ascii?Q?55l3JACtD5JtXvJZtVUdNLYmOTR5sHl1msLkiK+IqJ8S1RB/tWsUJQAauk7b?=
 =?us-ascii?Q?0f8+ZVjxI7iNHsx5gHtEBJ8NoB0cElOEterLa8oaaFK+c7ALjC73sa7MuDpe?=
 =?us-ascii?Q?zriweDoetKzsoU68K9HRZWItMotQISKLsvh99hrGlM4/E347qXvsVXcRAJFm?=
 =?us-ascii?Q?b6Em8zNQjtNzPNRlKYNgLCyctxpEkbEeRiehTKc3bzP9RrLR/Vk21P0wI2Vt?=
 =?us-ascii?Q?uuG2UqFXSJ+gbQop0nQhWmhCYTLe94ahpOLYBG8fi8ugFlh5poxhH0zexE/r?=
 =?us-ascii?Q?Mu0yfYZP5lEaJhAvUB2/CHOyPlL+Ksg4Nw2QB86Kmnb4PGaIsUaMqlnvHqTn?=
 =?us-ascii?Q?8ZhlyC3UBKwcf8Jb6wX5DciG2UlriO/Qqa4/nViXdQ9uvS2bs70tnzcOvGpj?=
 =?us-ascii?Q?esGw/3eHDxPP47C3V1XbBA9eDUB6M7d2Ncy7SYw4oJrmOKrTk2bEDZvcgaOc?=
 =?us-ascii?Q?Q4xpWobWVBtAG5U68Hu696e6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9894d2-57e8-4a7a-7e06-08d921c4735a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 10:36:28.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUOvghe94DSocxPkN/ycH/EVOP5X3v32xOaHM4zeAg8UxYBRsfVFXKI0okXa2Zbt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4680
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/28 =E4=B8=8B=E5=8D=886:23, Johannes Thumshirn wrote:
> On 28/05/2021 04:28, Qu Wenruo wrote:
>> In cluster_pages_for_defrag(), we have complex code block inside one
>> for() loop.
>>
>> The code block is to prepare one page for defrag, this will ensure:
>> - The page is locked and set up properly
>> - No ordered extent exists in the page range
>> - The page is uptodate
>> - The writeback has finished
>>
>> This behavior is pretty common and will be reused by later defrag
>> rework.
>>
>> So extract the code into its own helper, defrag_prepare_one_page(), for
>> later usage, and cleanup the code by a little.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c | 151 +++++++++++++++++++++++++++--------------------
>>   1 file changed, 86 insertions(+), 65 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 67ef9c535eb5..ba69991bca10 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1144,6 +1144,89 @@ static int should_defrag_range(struct inode *inod=
e, u64 start, u32 thresh,
>>   	return ret;
>>   }
>>  =20
>> +/*
>> + * Prepare one page to be defraged.
>> + *
>> + * This will ensure:
>> + * - Returned page is locked and has been set up properly
>> + * - No ordered extent exists in the page
>> + * - The page is uptodate
>> + * - The writeback has finished
>> + */
>> +static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
>> +					    unsigned long index)
>> +{
>=20
> 	struct address_space *mapping =3D inode->vfs_inode.i_mapping;
> 	gfp_t mask =3D btrfs_alloc_write_mask(mapping);
>=20
>> +	gfp_t mask =3D btrfs_alloc_write_mask(inode->vfs_inode.i_mapping);
>> +	u64 page_start =3D index << PAGE_SHIFT;
>> +	u64 page_end =3D page_start + PAGE_SIZE - 1;
>> +	struct extent_state *cached_state =3D NULL;
>> +	struct page *page;
>> +	int ret;
>> +
>> +again:
>> +	page =3D find_or_create_page(inode->vfs_inode.i_mapping, index, mask);
>=20
> 	page =3D find_or_create_page(mapping, index, mask);
>=20
> While you're at it?
>=20
>> +	if (!page)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret =3D set_page_extent_mapped(page);
>> +	if (ret < 0) {
>> +		unlock_page(page);
>> +		put_page(page);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	/* Wait for any exists ordered extent in the range */
>> +	while (1) {
>> +		struct btrfs_ordered_extent *ordered;
>> +
>> +		lock_extent_bits(&inode->io_tree, page_start, page_end,
>> +				 &cached_state);
>> +		ordered =3D btrfs_lookup_ordered_range(inode, page_start,
>> +						     PAGE_SIZE);
>> +		unlock_extent_cached(&inode->io_tree, page_start, page_end,
>> +				     &cached_state);
>> +		if (!ordered)
>> +			break;
>> +
>> +		unlock_page(page);
>> +		btrfs_start_ordered_extent(ordered, 1);
>> +		btrfs_put_ordered_extent(ordered);
>> +		lock_page(page);
>> +		/*
>> +		 * we unlocked the page above, so we need check if
>> +		 * it was released or not.
>> +		 */
>> +		if (page->mapping !=3D inode->vfs_inode.i_mapping ||
>=20
> 		if (page->mapping !=3D mapping ||
>=20
>> +		    !PagePrivate(page)) {
>> +			unlock_page(page);
>> +			put_page(page);
>> +			goto again;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Now the page range has no ordered extent any more.
>> +	 * Read the page to make it uptodate.
>> +	 */
>> +	if (!PageUptodate(page)) {
>> +		btrfs_readpage(NULL, page);
>> +		lock_page(page);
>> +		if (page->mapping !=3D inode->vfs_inode.i_mapping ||
>=20
> 		if (page->mapping !=3D mapping ||
>=20
>=20
>> +		    !PagePrivate(page)) {
>> +			unlock_page(page);
>> +			put_page(page);
>> +			goto again;
>> +		}
>> +		if (!PageUptodate(page)) {
>> +			unlock_page(page);
>> +			put_page(page);
>> +			return ERR_PTR(-EIO);
>> +		}
>> +	}
>> +	wait_on_page_writeback(page);
>> +	return page;
>> +}
>> +
>>   /*
>>    * it doesn't do much good to defrag one or two pages
>>    * at a time.  This pulls in a nice chunk of pages
>> @@ -1172,11 +1255,8 @@ static int cluster_pages_for_defrag(struct inode =
*inode,
>>   	int ret;
>>   	int i;
>>   	int i_done;
>> -	struct btrfs_ordered_extent *ordered;
>>   	struct extent_state *cached_state =3D NULL;
>> -	struct extent_io_tree *tree;
>>   	struct extent_changeset *data_reserved =3D NULL;
>> -	gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);
>>  =20
>>   	file_end =3D (isize - 1) >> PAGE_SHIFT;
>>   	if (!isize || start_index > file_end)
>> @@ -1189,68 +1269,16 @@ static int cluster_pages_for_defrag(struct inode=
 *inode,
>>   	if (ret)
>>   		return ret;
>>   	i_done =3D 0;
>> -	tree =3D &BTRFS_I(inode)->io_tree;
>>  =20
>>   	/* step one, lock all the pages */
>>   	for (i =3D 0; i < page_cnt; i++) {
>>   		struct page *page;
>> -again:
>> -		page =3D find_or_create_page(inode->i_mapping,
>> -					   start_index + i, mask);
>> -		if (!page)
>> -			break;
>>  =20
>> -		ret =3D set_page_extent_mapped(page);
>> -		if (ret < 0) {
>> -			unlock_page(page);
>> -			put_page(page);
>> +		page =3D defrag_prepare_one_page(BTRFS_I(inode), start_index + i);
>> +		if (IS_ERR(page)) {
>> +			ret =3D PTR_ERR(page);
>>   			break;
>>   		}
>> -
>> -		page_start =3D page_offset(page);
>> -		page_end =3D page_start + PAGE_SIZE - 1;
>> -		while (1) {
>> -			lock_extent_bits(tree, page_start, page_end,
>> -					 &cached_state);
>> -			ordered =3D btrfs_lookup_ordered_extent(BTRFS_I(inode),
>> -							      page_start);
>> -			unlock_extent_cached(tree, page_start, page_end,
>> -					     &cached_state);
>> -			if (!ordered)
>> -				break;
>> -
>> -			unlock_page(page);
>> -			btrfs_start_ordered_extent(ordered, 1);
>> -			btrfs_put_ordered_extent(ordered);
>> -			lock_page(page);
>> -			/*
>> -			 * we unlocked the page above, so we need check if
>> -			 * it was released or not.
>> -			 */
>> -			if (page->mapping !=3D inode->i_mapping || !PagePrivate(page)) {
>> -				unlock_page(page);
>> -				put_page(page);
>> -				goto again;
>> -			}
>> -		}
>> -
>> -		if (!PageUptodate(page)) {
>> -			btrfs_readpage(NULL, page);
>> -			lock_page(page);
>> -			if (!PageUptodate(page)) {
>> -				unlock_page(page);
>> -				put_page(page);
>> -				ret =3D -EIO;
>> -				break;
>> -			}
>> -		}
>> -
>> -		if (page->mapping !=3D inode->i_mapping || !PagePrivate(page)) {
>> -			unlock_page(page);
>> -			put_page(page);
>> -			goto again;
>> -		}
>> -
>>   		pages[i] =3D page;
>>   		i_done++;
>>   	}
>> @@ -1260,13 +1288,6 @@ static int cluster_pages_for_defrag(struct inode =
*inode,
>>   	if (!(inode->i_sb->s_flags & SB_ACTIVE))
>>   		goto out;
>>  =20
>> -	/*
>> -	 * so now we have a nice long stream of locked
>> -	 * and up to date pages, lets wait on them
>> -	 */
>> -	for (i =3D 0; i < i_done; i++)
>> -		wait_on_page_writeback(pages[i]);
>> -
>=20
> Doesn't this introduce a behavioral change? previously we didn't
> wait for page writeback in case of a parallel unmount, now we do.

The behavior is only changing when we wait, we still check the SB_ACTIVE.

IMHO the extra wait shouldn't cause much difference for unmount.

Thanks,
Qu

