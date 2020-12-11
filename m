Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB722D755E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbgLKMNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 07:13:24 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:50518 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389918AbgLKMNP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 07:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607688722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4v18wslaY3WpSrGUC622/Zb0g5XotR7ny20C3BkJERE=;
        b=DtAbumRxpBo8VpQYUVBXT+Y8ynksO2Skzove+ZKLV+oXdmmMYm0Ao+hHmSk9VbWZ2Tdjlq
        MG/1yr0fZzw2SwY2vmGSwC/LxHwwTvGwtejyRxj1iv9UsY5Cho+HPcPzWmrp8t0AKyYodr
        d56gwY+bIMkzzRfNA8lljnRqOBcClVk=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-SGLcMq9ZPN6jqd24X2pzBA-1; Fri, 11 Dec 2020 13:11:59 +0100
X-MC-Unique: SGLcMq9ZPN6jqd24X2pzBA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOGpsHBU4fUmoMArXXNuVyGiyg4+krydPjO2R4kaLsuIrq8bAg0CPIfAkrKgnrAa7gMWA2flhP1uTedGt0sDxiWepTcTYVH1J+DP/kIfartPXcgmZba5bwaEIDLyUhQqUb0aNSuAP6wwPGIhZ0Ch8JHEcFLgUe6cyHMguwPt0668m+uiGhV0S3NwePZ49RyGu00eRGT8qHHvA/GOgthKMb5fmEVGy9hrrZGeQ4uwT6TqCSIy3kDFF7GewHKWRjSwzZy4xGiNM35zoTOp24RUGQXImc1r4rzymgo1nKrovY3BL4k0IBEyTFfTvt0X27cc7zWKIfIwhfBrIj29Boobig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf5uK2Ow2zuVK7NN1kBylGpLEa+s2if9gcjv9kVJ0Zw=;
 b=hw/afSXvc5v8UPjLDJpEQghTzidv2JoPuMuayWNH9QAaF7COapGWacBph/b9vFAlfhHN5Swd01BjinPuc9JLkqCST3UjaTOOG31w8QUb41AvqBoAoMpDNq0mtT51MflYoy4jpqH41sD7xeRUafPbWfUy84ZDPM1NlRmGzn99+8aPeqKO40+q/N73ReYYoMq75LjtZ7nKqgOe3pMiOGElh+/IA8ZhvVOQ3h6A0924l9vjvsI40zXTWya3BuVE8oKpAcx+yMEUPx/D9rtGosChpZXfcPOMxwOWHEDON7sM6G45jI4Df7aLOs/S63iaBDr6paEIe1za1wmZ6vA+FvH2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7760.eurprd04.prod.outlook.com (2603:10a6:102:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 11 Dec
 2020 12:11:57 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::7d12:a0d8:a763:82c9]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::7d12:a0d8:a763:82c9%7]) with mapi id 15.20.3654.013; Fri, 11 Dec 2020
 12:11:57 +0000
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-13-wqu@suse.com>
 <d6684ad3-875e-53f1-cf1d-a4490c35c4f9@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 12/18] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
Message-ID: <a2732cae-4dea-744e-2eda-8b8e5f2b6710@suse.com>
Date:   Fri, 11 Dec 2020 20:11:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <d6684ad3-875e-53f1-cf1d-a4490c35c4f9@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:332::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Fri, 11 Dec 2020 12:11:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ccc2d1-f444-4559-a738-08d89dcdf51a
X-MS-TrafficTypeDiagnostic: PA4PR04MB7760:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR04MB77606D02F8D2008EF6189029D6CA0@PA4PR04MB7760.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNNcPmiJIWF7wSdQmrG5DtfChRpsmIv/dvJHsapXBC/qKfXuOi9guWV0Ke7UpJKWjUfRD76bvmwp9TZp2f9GD069yMkYA/X7b/38Y7Ct4c69XmEk2g2iwww3siRlXb/gDcistdUbbYbM9E5ovW16a6HjLaDbaQfCuc8tezp2FpN9aJyx1Q96nJAxRE7uW6bzJ/XLlBoDZ04cCrENxith1UwjGMl8R3v4kNS5Y2c7z1yYynymwsu3vPOhGcm3R5QqqkPCVhFGny6uKvTj3zarK2F9o+7H4jKan+lzQfIAYIlD9ci1r2Z8CI42Hgt5RGmrLEKVleNOZoMqRzNBK5UAAVlEcWzDE9bHpAf4atAYiDWfS2zBFvWEBh0c7ScTXrchOo30VDrB/xCaKJ3jAK0JFiC7wwXTtZU6XZJsCDuNjQBOLdrfOh56co+TT6S5AOqJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(478600001)(6486002)(31686004)(83380400001)(26005)(6666004)(31696002)(186003)(16526019)(6706004)(52116002)(8676002)(66946007)(8936002)(5660300002)(2616005)(66556008)(16576012)(86362001)(316002)(956004)(36756003)(66476007)(2906002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RhETz41k5xjTFMcYA/0CGXYOAlt1pAHOs/n87th2vmvKVEBdjzkQiDB2Lh0Y?=
 =?us-ascii?Q?WD5vEHyhmYjcYFBcD8GMUe+lCEyctOc6hyKmN/U9YjwA1UCT9hE4T8D8Id9i?=
 =?us-ascii?Q?MVsVCx1XWtAEk5SJp2TMPlX/zV96YLC5J1qoin9XeAN+pcv97Id5h3Bg9aIv?=
 =?us-ascii?Q?c4Cwe1hyUXc+Unj5Ee7foJYIycm46++e7+N254JyvGSnFyAcKKJ83eZ8Dwcr?=
 =?us-ascii?Q?Ua74Z8lT3x+NcNz44koTqO6cQWSLLim8H5KZjzCCtbruuRTuL89lJWACwmTn?=
 =?us-ascii?Q?67BwO7qRdGB/xygracE36cy+5ggTEH8m3HAoPQTou+tIdAodMuR6OQcWLLuA?=
 =?us-ascii?Q?lz/ZAxHJGbL/QrAZKAysWYIALIEtbt8cYQPnPqVLx4ftoL2lFZWiq0810CTf?=
 =?us-ascii?Q?oH+9Jx3LZahBkT3Ov3bx49AHFVExp6xc5ifWnVUa5IlPpeOtFTSXGJ27zSjp?=
 =?us-ascii?Q?TEFeY9hhVS2BB3F8J7sqbopIWPuzHOdwXGNfcVsGboOiWOinCljoprOe/hs+?=
 =?us-ascii?Q?0F+fA+EVcSP5S4MORwBioxUK3zyh6OlCiHfzGyjvFPhUgYmPt+qMFcz/TYt4?=
 =?us-ascii?Q?WYScX+SAdu6BQMNBPXGdJUFvhWwuLD2vYbTZU4FQxXjzq1+XL3aUNL7Fzvf3?=
 =?us-ascii?Q?GStnYlRjiNeuffKwJUkPQGYaRNKxe4I/pqAiz+SJQf98KdosMcvQKRlYJYl9?=
 =?us-ascii?Q?on6HJiRBjzSbMGGdhz16cTo9Duv9oHQnn6oJoJM3gkpRdqcdDw6vCyZHd+ZF?=
 =?us-ascii?Q?2thIo92v7gMF6NfoBfe0IGsdn58yq0p+i6AJjYrlZEhDV8D60ocf6Hf6lT1X?=
 =?us-ascii?Q?2rjusO4uqTvyVeZeBhUHJf/IFaEzFnxNvBp1Fz2hlPQMG0hoEULNwg6qmUov?=
 =?us-ascii?Q?Cz/C/wxXQWw6bODf0sFNAOPuhns1qIEVTWlr3Bl25aLaMMalecdqAIDDcStf?=
 =?us-ascii?Q?jRgjQFeOZM/RwcTTvg41mTiskR8dnZFW+FZNdeCbUQOI3jANTb16IA5m+gOt?=
 =?us-ascii?Q?0Lz9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 12:11:57.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ccc2d1-f444-4559-a738-08d89dcdf51a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfNXEmMar+w4FAsH0bcRdJWk+4HqjylhZbPi0nyzM5TjR4GEEh4L96txfhmnsrzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7760
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/11 =E4=B8=8B=E5=8D=888:00, Nikolay Borisov wrote:
>=20
>=20
> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>> Unlike the original try_release_extent_buffer,
>> try_release_subpage_extent_buffer() will iterate through
>> btrfs_subpage::tree_block_bitmap, and try to release each extent buffer.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 141e414b1ab9..4d55803302e9 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -6258,10 +6258,83 @@ void memmove_extent_buffer(const struct extent_b=
uffer *dst,
>>  	}
>>  }
>> =20
>> +static int try_release_subpage_extent_buffer(struct page *page)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
>> +	u64 page_start =3D page_offset(page);
>> +	int bitmap_size =3D BTRFS_SUBPAGE_BITMAP_SIZE;
>=20
> Remove this variable and directly use BTRFS_SUBPAGE_BITMAP_SIZE as a
> terminating condition
>=20
>> +	int bit_start =3D 0;
>> +	int ret;
>> +
>> +	while (bit_start < bitmap_size) {
>=20
> You really want to iterate for a fixed number of items so switch that to
> a for loop.

The problem here is, it's not always fixed.

If it finds one bit set, it will skip (nodesize >> sectorsize_bits) bits.

But if not found, it will skip to just next bit.

Thus I'm not sure if for loop is really a good choice here for
differential step.

>=20
>> +		struct btrfs_subpage *subpage;
>> +		struct extent_buffer *eb;
>> +		unsigned long flags;
>> +		u16 tmp =3D 1 << bit_start;
>> +		u64 start;
>> +
>> +		/*
>> +		 * Make sure the page still has private, as previous run can
>> +		 * detach the private
>> +		 */
>=20
> But if previous run has run it would have disposed of this eb and you
> won't find this page at all, no ?

For the "previous run" I mean, previous iteration in the same loop.

E.g. the page has 4 bits set, just one eb (16K nodesize).

For the first run, it release the only eb of the page, and cleared page
private.
For the second run, since private is cleared, we need to break out.

>=20
>> +		spin_lock(&page->mapping->private_lock);
>> +		if (!PagePrivate(page)) {
>> +			spin_unlock(&page->mapping->private_lock);
>> +			break;
>> +		}
>> +		subpage =3D (struct btrfs_subpage *)page->private;
>> +		spin_unlock(&page->mapping->private_lock);
>> +
>> +		spin_lock_irqsave(&subpage->lock, flags);
>> +		if (!(tmp & subpage->tree_block_bitmap))  {
>> +			spin_unlock_irqrestore(&subpage->lock, flags);
>> +			bit_start++;
>> +			continue;
>> +		}
>> +		spin_unlock_irqrestore(&subpage->lock, flags);
>> +
>> +		start =3D bit_start * fs_info->sectorsize + page_start;
>> +		bit_start +=3D fs_info->nodesize >> fs_info->sectorsize_bits;
>=20
> By doing this you are really saying "skip all blocks pertaining to this
> eb". In order for this to be correct it would imply that bit_start
> should _always_ be 0,4,8,12 - am I correct?=20

Nope. As long as no eb crosses page boundary, it won't cause problem.
So in theory we support case like eb spans sector 1~5.

> But what happens if
> if (!(tmp & subpage->tree_block_bitmap))  has executed and bit_start is
> now 1, then you'd make start =3D page_start + 4k , skip next 4(16k) block=
s
> but that would be wrong, no ?

For (!(tmp & subpage->tree_block_bitmap)) branch, isn't bit_start just
increased by one?
Exactly like what I said, we will check next sector, until we hit the
first bit set.

And only when we hit a bit, we increase the bit_start by nodesize /
sectorsize.

>=20
> Essentially the page would look like:
>=20
> |0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
>=20
> So you want to release the EB's that spawn 0-3, 4-7, 8-11, 12-15, but
> what if bit_start becomes 1 and you add 4 to that, this offsets all
> further calculation by 1 i.e you are going into the next eb.

Nope, 4 is only added we we hit a bit set.
If we hit a bit zero, we jump to next bit, not following nodesize >>
sectorsize.

That's exactly the reason I'm not using for() loop here, due to the
difference in step size.

Thanks,
Qu
>=20
>=20
>> +		/*
>> +		 * Here we can't call find_extent_buffer() which will increase
>> +		 * eb->refs.
>> +		 */
>> +		rcu_read_lock();
>> +		eb =3D radix_tree_lookup(&fs_info->buffer_radix,
>> +				start >> fs_info->sectorsize_bits);
>> +		rcu_read_unlock();
>> +		ASSERT(eb);
>> +		spin_lock(&eb->refs_lock);
>> +		if (atomic_read(&eb->refs) !=3D 1 || extent_buffer_under_io(eb) ||
>> +		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
>> +			spin_unlock(&eb->refs_lock);
>> +			continue;
>> +		}
>> +		/*
>> +		 * Here we don't care the return value, we will always check
>> +		 * the page private at the end.
>> +		 * And release_extent_buffer() will release the refs_lock.
>> +		 */
>> +		release_extent_buffer(eb);
>> +	}
>> +	/* Finally to check if we have cleared page private */
>> +	spin_lock(&page->mapping->private_lock);
>> +	if (!PagePrivate(page))
>> +		ret =3D 1;
>> +	else
>> +		ret =3D 0;
>> +	spin_unlock(&page->mapping->private_lock);
>> +	return ret;
>> +
>> +}
>> +
>>  int try_release_extent_buffer(struct page *page)
>>  {
>>  	struct extent_buffer *eb;
>> =20
>> +	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
>> +		return try_release_subpage_extent_buffer(page);
>> +
>>  	/*
>>  	 * We need to make sure nobody is attaching this page to an eb right
>>  	 * now.
>>
>=20

