Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EED2EBB11
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 09:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbhAFI0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 03:26:20 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:33963 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbhAFI0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 03:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609921510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FasCyl39DamcQGjb3M4r4CWlhEX1cigq1QKjHkJnKdk=;
        b=OT+if/idIED27D5mPykZ35bZo9kbqCAWtGjD3P/TM7hoybapQ3gob7XGJRGEBMgd1Lr4R0
        mzzU8RrK8H6/ulaJv4y7crT1sKZf3e12klX0bhqOhAx/fXfN8EZrKQww7Zw8etvxRnD0FO
        JrJXiP8q5U7mF4iJKg0BOy9fk8jZtJM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-PGfXRTowOBeuQnlbd6iaCw-1; Wed, 06 Jan 2021 09:25:09 +0100
X-MC-Unique: PGfXRTowOBeuQnlbd6iaCw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5rNK44XS1MnnFTP6Pw5roFUSXdIvz/w3j0twZD0IHBD0SNiB1BmDn3UmcZhSky0G/U7/ufjFf6COmMu7ysgvZvVy5zhn0jvQ6k3JFeDI//T1msF5iKXV3g8c7CXa6fh0ImiknhOtNxPhT8R+cOLBm0JfbIuWpMjjjBpEmh89CB9/5GK0gyn+B11Por6K1sw72lKmreD+dF8C+RaSwPPD+eKvUAUTj6ovzluXMTzkv3a0oikFNutK7hHXksz4IUlLK+ENTV3/cGC4cy1iCj1+ndSZylY5wJQhubh9I/srCnL87pvqZtHjFuxBN7/PURCWzrGKvgZ+4XiGDp5sDqxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpEksv5WfBrpR4s1tQiBDD8MXTaV4JRo7xFZd6EmWSk=;
 b=YpiY1HurvERBVer4b3brFS0CiI94yBBOjlH0Ot9T0BBdVlE5qniB1JVldP0LNsYvokC06RzS1H0bo6E2SDR9ipu7/XCfQDDCrROmnYG33OivSbCoUHwVawM3QpzcRTnOvwIo38FvpWA1gc8COsoMsZLMj3B+LSTnAgM81hMmv3lWVXtaMpi7M4DUZnF5HNVHnNXQ3z3QKmhbCbnP95xK8lJxLLJTDZlhqc38Lni1gREQVMEWflCogc6ENR0Vd8YlfHtHa/uaA2exDOuQtUEZEfGZA2/uMdPoRhdkJKGuYkHaLZARH8dc9IQlUQ6jHBMQPMK7gZxsSxN2CANPSEAa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7824.eurprd04.prod.outlook.com (2603:10a6:102:cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 08:25:08 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 08:25:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210106010201.37864-1-wqu@suse.com>
 <20210106010201.37864-17-wqu@suse.com>
Subject: Re: [PATCH v3 16/22] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
Message-ID: <2c06bcbb-2aba-838f-e185-d2ce139fd170@suse.com>
Date:   Wed, 6 Jan 2021 16:24:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210106010201.37864-17-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: PH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:510:5::28) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by PH0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:510:5::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 08:25:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea09462-0f8b-48b4-5a10-08d8b21c93c2
X-MS-TrafficTypeDiagnostic: PA4PR04MB7824:
X-Microsoft-Antispam-PRVS: <PA4PR04MB782432D042668277926D2678D6D00@PA4PR04MB7824.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYlji2BCXYH11A1+mjxwLSTV2M44uORuHQwhYdnJ0EqhXJDBefpWOX2MlouET3MpjgiF1BYxHjkyhgmTIletKZSynU0w0bPuo57mK6ZT534Ywbpxgd4vUSsu7R1dQ/+qZ6xDy+WH+3rZNlDK5mIg/VIikO/k8j2RA2rF2l/5jLLS3YSjDUWzH4Svf61/RTP0Qfel0whitNxO4r72QIjAI2ADMdg2U2wszKmYHjQISkUmw7EcYUDUQgGeRUEWUuhdnJecvqkqGPWNsS7S97Vtcl6niwe6UAal5IR+JlOHN4OAZ0edfhXY7ZKuKG0NFrYa44a+hmcp5G/eq7h5Rdnvklw/siscV9bKCh4rBgNbzyyWuxgdIaFwlyJRNpsTTYhAYBe6xMNhv7Q6qGHothD/Ilajy3JeiUMVW76SQ5q4YX5Dv8Gk7VaJy8QR935nMZtR98Kq5LBRoQXFqg6xyP8TA/4ZvXJA5j0mgQzS4NRuhqibY6PqOKMYgoASSi/QVOQ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(346002)(136003)(376002)(66556008)(66476007)(6666004)(478600001)(26005)(6916009)(52116002)(186003)(8676002)(6706004)(16526019)(86362001)(2616005)(31696002)(66946007)(956004)(16576012)(36756003)(316002)(2906002)(5660300002)(83380400001)(31686004)(6486002)(8936002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g+8MDelTkNX+IPpHUlprwkkzIRao+2ZJJODmSx4UkIA7z1DxN4tbsbU+SugI?=
 =?us-ascii?Q?XAv7qCc1fdHrucNeH2bAWZXGdJecJuTSutT4rmReFjy2cq4TvwDBPZA12O1N?=
 =?us-ascii?Q?qu4eI5mbSO3w2fwywNpWV4GpejJ+7yr1vl0rXITfxJC8PwemPAoMlejTNfxK?=
 =?us-ascii?Q?qfp2b1A+lmqbAnSVnt5SJYt7/fDHFvcsn8jG1ZUQh8/sjr4CWuKNZlyKHAP4?=
 =?us-ascii?Q?JJQ1dDUY20RFxr1xrtJlTdaT2x0O6/euTMnEEbPwXBcPWrAGxTQQt/YOBkug?=
 =?us-ascii?Q?/D7e9ghkDRlR2xMpu45kibHl1PiqJ1ajiaz7lf656JDEI4z32b0tmyt33KzA?=
 =?us-ascii?Q?+SfLmaDRLjvEfHadStkLFPpiCl9A2UnmbtWsQ1rnXJQ5k+ubhsk1n2YLGghs?=
 =?us-ascii?Q?Byv9lXwbw1VHFc8KUqPCy1n4C4+pGmLsc5e7Ynm9SC63tpPftXrb2xrByNVb?=
 =?us-ascii?Q?GSG1dgTzbIIm8/gGk+TmXG+gliK73PGhEHcARSvO1R/ngFbGCOya/SG5Vgg/?=
 =?us-ascii?Q?YvH9QOfMkpE6kUi1LT7TWb0DB0uoKN9Beg+hwEtamTAiHpu3e9vQ9XpcZ/Wi?=
 =?us-ascii?Q?qkiLU9U8+6jITWyTi8BbCVT4y08r4IlV+f4acDw32cefsFegnuEuc9RLomiR?=
 =?us-ascii?Q?TO6rTwDENZFaAUuKV1eHhNfVMpOPXPFrgDZy3prc+zQUIt8/0EIS1rsSdvhH?=
 =?us-ascii?Q?+PzRDEAZaga2V7nCp7Y2sos7WjVfwMpypCP1nR9eEfTWdFrRWXLE06ixKQFn?=
 =?us-ascii?Q?UzC0JciSAhFXHnyEagYwY1ouzgt0W5L66yM59r2AKBZnh2ZSnXm2Az3YR6nX?=
 =?us-ascii?Q?+JBL2sLn77FBjqBRRINVl9vY7guTDg03xPaKPZ+4f/kYd+hxcI8WM0GE0283?=
 =?us-ascii?Q?7J+Eh4JPSHnpayExK3P1V2kzRfdI4EpbhM3pqznwW1FXDj64O7tuPwlFYOLZ?=
 =?us-ascii?Q?I2LV6jxJ+lWl+W2GPgI5le2/yLOSa6PL72lL4i+2X3BxM+m+cEPOCa7WikIS?=
 =?us-ascii?Q?eUa5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 08:25:08.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea09462-0f8b-48b4-5a10-08d8b21c93c2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSOgV8IllZZmbrr8LHGL3OJdeTcvc87Ltt/5rjhsizevZ7L+4MNNdA/s8XJ1iDj5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7824
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/6 =E4=B8=8A=E5=8D=889:01, Qu Wenruo wrote:
> Unlike the original try_release_extent_buffer,
> try_release_subpage_extent_buffer() will iterate through
> btrfs_subpage::tree_block_bitmap, and try to release each extent buffer.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 194cb8b63216..792264f5c3c2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6258,10 +6258,86 @@ void memmove_extent_buffer(const struct extent_bu=
ffer *dst,
>   	}
>   }
>  =20
> +static int try_release_subpage_extent_buffer(struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	u64 page_start =3D page_offset(page);
> +	int bitmap_size =3D BTRFS_SUBPAGE_BITMAP_SIZE;
> +	int bit_start =3D 0;
> +	int ret;
> +
> +	while (bit_start < bitmap_size) {
> +		struct btrfs_subpage *subpage;
> +		struct extent_buffer *eb;
> +		unsigned long flags;
> +		u16 tmp =3D 1 << bit_start;
> +		u64 start;
> +
> +		/*
> +		 * Make sure the page still has private, as previous iteration
> +		 * can detach page private.
> +		 */
> +		spin_lock(&page->mapping->private_lock);
> +		if (!PagePrivate(page)) {
> +			spin_unlock(&page->mapping->private_lock);
> +			break;
> +		}
> +
> +		subpage =3D (struct btrfs_subpage *)page->private;
> +
> +		spin_lock_irqsave(&subpage->lock, flags);
> +		spin_unlock(&page->mapping->private_lock);
> +
> +		if (!(tmp & subpage->tree_block_bitmap))  {
> +			spin_unlock_irqrestore(&subpage->lock, flags);
> +			bit_start++;
> +			continue;
> +		}
> +
> +		start =3D bit_start * fs_info->sectorsize + page_start;
> +		bit_start +=3D fs_info->nodesize >> fs_info->sectorsize_bits;
> +		/*
> +		 * Here we can't call find_extent_buffer() which will increase
> +		 * eb->refs.
> +		 */
> +		rcu_read_lock();
> +		eb =3D radix_tree_lookup(&fs_info->buffer_radix,
> +				start >> fs_info->sectorsize_bits);
> +		ASSERT(eb);

Another ASSERT() hit here. Surprised that I have never hit such case before=
.

Since in releasse_extent_buffer(), radix tree is removed first, then=20
subpage tree_block_bitmap update, we could have cases where subpage=20
tree_block_bitmap is set but no eb in radix tree.

In that case, we can safely go next bit and re-check.

The function return value is only bounded to if the page has private bit=20
or not, so here we can safely continue.

Nik is right on this, we need better eb refs handling refactor, I'll=20
investigate more time to make the eb refs handling better.

Thanks,
Qu
> +		spin_lock(&eb->refs_lock);
> +		if (atomic_read(&eb->refs) !=3D 1 || extent_buffer_under_io(eb) ||
> +		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
> +			spin_unlock(&eb->refs_lock);
> +			rcu_read_unlock();
> +			continue;
> +		}
> +		rcu_read_unlock();
> +		spin_unlock_irqrestore(&subpage->lock, flags);
> +		/*
> +		 * Here we don't care the return value, we will always check
> +		 * the page private at the end.
> +		 * And release_extent_buffer() will release the refs_lock.
> +		 */
> +		release_extent_buffer(eb);
> +	}
> +	/* Finally to check if we have cleared page private */
> +	spin_lock(&page->mapping->private_lock);
> +	if (!PagePrivate(page))
> +		ret =3D 1;
> +	else
> +		ret =3D 0;
> +	spin_unlock(&page->mapping->private_lock);
> +	return ret;
> +
> +}
> +
>   int try_release_extent_buffer(struct page *page)
>   {
>   	struct extent_buffer *eb;
>  =20
> +	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +		return try_release_subpage_extent_buffer(page);
> +
>   	/*
>   	 * We need to make sure nobody is attaching this page to an eb right
>   	 * now.
>=20

