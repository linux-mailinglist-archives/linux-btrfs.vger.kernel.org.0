Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A10265EE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgIKLkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 07:40:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:57928 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgIKLkC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 07:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599824388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMU6tji6P+hQ9hCVTOdDujQ5puoMeq65MdxR3M/KStc=;
        b=HI6F427fCoeWNm/Ey2yQq77mEHKQqkwk2mTN+KqqVP8tYYwToiT9dfJ6gmlFutx6aKuq4s
        Z/0Yj3KYkRN5IVgLbUbXLWgwK9ewG6rmAmIY3GiocHXCpcJIibfF55k9uJGnh/AtnX13S6
        b4xEOT/7yg/iaUVJ8efQvxgesxZK+g4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-vMMqqr29PGq6blcBO6nd8A-1;
 Fri, 11 Sep 2020 13:39:47 +0200
X-MC-Unique: vMMqqr29PGq6blcBO6nd8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7RHZ9RJJivu8RzjG7RdDuMt03OgiL1CKPcbvNruZj3cs8ZZoOqeiUWV/QwSZQoAioS11iEm3vLHLim7uFYXDAekkcJdISMY2XhDU+kMIMkn4hZ9+CTgZIvOV0xWw+Ahpev7LRr8tumOJkBp7Y4ho5aGBwmaN3PHSDiJdBJEj0V33ZroRQvbQgKUOGBtvwKsqTFlv4yY0u5htfSyVPksV6MhtnF8p8Ka15cFbO8lNNk3o/MnuOB0L1l65D2x3TV0zRMYIyVAJ1He6yXyE0BJ6EDysV4jTtjbJihAbsbOI3O2QNoRcSXNl4MNhCHd9WZByKCosgDE5NXU3VjulqjL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t89R9hMjAgixzCJ8TWqDNbk8c7V6AZYQP1IZZcHk/M=;
 b=GBajNwFYHhAtN/Xiu1sS0xfYGEDZTZkk7Mt59+isDFrQ7573+SzINvCsOUc2EItDe7v18PtmfcUVhx0AOz7J0nH3vLa3U1zcYZ3kDt0WVYVGZR64cz/V8aiSm5pRpEImk5d7rAXDEyU4KVs7cjnJorbEe1lhulFYuwGXZJ9kr0uS64vw1acv+UDmpJ5+VB01zdjTfdK6vnkl04RQjXwAgg7ZCyDE+pftu0YpoFFIqtOsezQ/rdPJzvS0r+d6vjuixbJagLXMlDO0uueDRyqDpiArX0AWEWqNtOqhY5Lhhl+028fUaxtFjTP1cWS295iJgaZSBcRUN9XoDTBoUAx0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM8PR04MB7201.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 11:39:45 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 11:39:45 +0000
Subject: Re: [PATCH 09/17] btrfs: refactor btrfs_release_extent_buffer_pages()
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-10-wqu@suse.com>
 <dad03832-6de2-5aac-3f67-6b6f2d13cabc@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <fbccbadb-096c-3de3-0c33-bc1682510c17@suse.com>
Date:   Fri, 11 Sep 2020 19:39:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <dad03832-6de2-5aac-3f67-6b6f2d13cabc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0033.namprd08.prod.outlook.com (2603:10b6:a03:100::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 11:39:43 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7119395-8aae-4b0a-a363-08d8564761a3
X-MS-TrafficTypeDiagnostic: AM8PR04MB7201:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7201D1B17EECC1B32C5058C8D6240@AM8PR04MB7201.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxLrouTZ/hi4zppjt7xta5XyFGzrGHxzS+4XdAmALiO4diiguXF3D6ln65JKKo5zfYejSz2xgwzlbKg2tMSJGjQdk4XTD+Nx4g4cC/cknQLUoBsIc410Q61PsbfvA/PEZ2KpcbcZUxhfidS9u/+d3XYnyCvQsH+sdkRioI4duWmdyeGPxoWJiMan3i+o01PO/Vtkm1zItEZCdGhIrJwzDn4EzGq1pbiWeiJYWE2kk/bbO4X8acIiBsmF3dIGNI/Siw08/pqUNgEMpSqei+gUBdQodExr9iQWXyGiylRA35m0sKzxOesiKvEgMHQ6LC1paxbsIPEQEfdPTx/qVCxp3tHm24wrbh+Iyg/KrC2Eq3774YWV4zuWZ769MoJ5qjrzKtoL27G2joc8sbtHds62AbfgPW+JZ54cAErJpGRAa7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(31696002)(31686004)(36756003)(6486002)(316002)(16576012)(5660300002)(52116002)(66946007)(6666004)(186003)(6706004)(8936002)(66476007)(26005)(478600001)(86362001)(2616005)(66556008)(8676002)(2906002)(83380400001)(16526019)(956004)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qXeS/v2B6kvGtw0qCY0Lnb6jt1wMPZ+mhs0fo2bRhRIeEOuIQSzgPNSuF7rgJi8K0nVyHgq/ekgfohAz3y0/xa//DC/j0rbKKnRENvk1PYaXpwF1FcJpF3A5ghHaLb9gqVnhTs7tgAeZr1bW2xElij+gdFZ9xWj4FGVuwirReLe/e5G+FvryeVfIQtulq4HygbQydCOq3i3dKOXB9G76DAKY3earbkFHzOigfnV4pFDnQk5pKIgpsdZBYkvDJgVRHml107ffzqL4LI4IPzlJ9BJG0zvsaYQpCUQogIvlhIIwDpf1WIY436lEFPn6jr5qcSjcxEnpRRLIp2lq+VYauAr+L2ux6tvJXRWkSRUkznMeFFhBc6GTAAlf7pgcBDVRgAelVOF0mDqQBNI6TvtdnoFGjAtRSRz10tVuW8A02tRZiWEz050nXZNa+rKTwz5QZIPNd5PrW/p9smAGGLa3kUZgHCtcp83PDH5uvJbO05iGwcPT2/QFGsCBhEen/bqbNp0/XIRf5k50Knn6hYroN8w9wX1PD2XKO/J2+VBwkiyCuG48Pbvzn77xWxQ/mUru92CWLulnemzC1NaQfKiaK5WRbxTjHhzdP4dmY9KAWa0AfksFBRX1mNxjwFZXY4j4wqevqruhTz769XsIDyoBag==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7119395-8aae-4b0a-a363-08d8564761a3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 11:39:45.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePhl8bVywuRmX+gx49PKEEOUdRTMAkqIwME6garK6uoKebg9KPcyheNvQHeoeml2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7201
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/11 =E4=B8=8B=E5=8D=887:17, Nikolay Borisov wrote:
>=20
>=20
> On 8.09.20 =D0=B3. 10:52 =D1=87., Qu Wenruo wrote:
>> We have attach_extent_buffer_page() and it get utilized in
>> btrfs_clone_extent_buffer() and alloc_extent_buffer().
>>
>> But in btrfs_release_extent_buffer_pages() we manually call
>> detach_page_private().
>>
>> This is fine for current code, but if we're going to support subpage
>> size, we will do a lot of more work other than just calling
>> detach_page_private().
>>
>> This patch will extract the main work of btrfs_clone_extent_buffer()
>=20
> Did you mean to type btrfs_release_extent_buffer_pages instead of
> clone_extent_buffer ?

Oh, that's what I mean exactly...

>=20
>> into detach_extent_buffer_page() so that later subpage size support can
>> put their own code into them.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 58 +++++++++++++++++++-------------------------
>>  1 file changed, 25 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 3c8fe40f67fa..1cb41dab7a1d 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4920,6 +4920,29 @@ int extent_buffer_under_io(const struct extent_bu=
ffer *eb)
>>  		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
>>  }
>> =20
>> +static void detach_extent_buffer_page(struct extent_buffer *eb,
>> +				      struct page *page)
>> +{
>> +	bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
>=20
> nit: Now you are performing the atomic op once per page rather than once
> per-eb.

Makes sense, I should just extract the for () loop into a function
rather than the loop body.

Thanks,
Qu

>=20
>> +
>> +	if (!page)
>> +		return;
>> +
>> +	if (mapped)
>> +		spin_lock(&page->mapping->private_lock);
>> +	if (PagePrivate(page) && page->private =3D=3D (unsigned long)eb) {
>> +		BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
>> +		BUG_ON(PageDirty(page));
>> +		BUG_ON(PageWriteback(page));
>> +		/* We need to make sure we haven't be attached to a new eb. */
>> +		detach_page_private(page);
>> +	}
>> +	if (mapped)
>> +		spin_unlock(&page->mapping->private_lock);
>> +	/* One for when we allocated the page */
>> +	put_page(page);
>> +}
>> +
>>  /*
>>   * Release all pages attached to the extent buffer.
>>   */
>> @@ -4927,43 +4950,12 @@ static void btrfs_release_extent_buffer_pages(st=
ruct extent_buffer *eb)
>>  {
>>  	int i;
>>  	int num_pages;
>> -	int mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
>> =20
>>  	BUG_ON(extent_buffer_under_io(eb));
>> =20
>>  	num_pages =3D num_extent_pages(eb);
>> -	for (i =3D 0; i < num_pages; i++) {
>> -		struct page *page =3D eb->pages[i];
>> -
>> -		if (!page)
>> -			continue;
>> -		if (mapped)
>> -			spin_lock(&page->mapping->private_lock);
>> -		/*
>> -		 * We do this since we'll remove the pages after we've
>> -		 * removed the eb from the radix tree, so we could race
>> -		 * and have this page now attached to the new eb.  So
>> -		 * only clear page_private if it's still connected to
>> -		 * this eb.
>> -		 */
>> -		if (PagePrivate(page) &&
>> -		    page->private =3D=3D (unsigned long)eb) {
>> -			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
>> -			BUG_ON(PageDirty(page));
>> -			BUG_ON(PageWriteback(page));
>> -			/*
>> -			 * We need to make sure we haven't be attached
>> -			 * to a new eb.
>> -			 */
>> -			detach_page_private(page);
>> -		}
>> -
>> -		if (mapped)
>> -			spin_unlock(&page->mapping->private_lock);
>> -
>> -		/* One for when we allocated the page */
>> -		put_page(page);
>> -	}
>> +	for (i =3D 0; i < num_pages; i++)
>> +		detach_extent_buffer_page(eb, eb->pages[i]);
>>  }
>> =20
>>  /*
>>
>=20

