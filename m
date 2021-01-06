Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8972EBB38
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 09:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbhAFIop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 03:44:45 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:44234 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbhAFIoo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 03:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609922616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BataNLm/lBTkYSHyH8DydnYsfv4QL0Bm5B24VS76++Q=;
        b=EjBziVPZRdcuMtJXe5u38qrVuuhPsrYcOf9tmhRZy3MxP0CvGWmBpAROykvk4Mu/JGXtxc
        lIu+pN1mN2SNiL8mh7rbTuXpiQMQdWE3/dLum32OyYFcMGaN27SsTOPejAo1F1ttCTIllJ
        Qiq5mqoT3ZkPe4ufNElhMTbA/2wjzRc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-tayPM19bMD-zGc9U5Ro7Cg-1; Wed, 06 Jan 2021 09:43:35 +0100
X-MC-Unique: tayPM19bMD-zGc9U5Ro7Cg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOeXglu8/W/MERhdrF9BcOW6LhBf6ZaIniX4SzWuK5g7YXWZtwfNfm/cfwQHkuutpFlGLPizdwVlnuqRlH/PSHtTEb5XYd6GycsjsG4Mofd1mQ37TvA0uYBFPWkl9ZPf4I1MHOHUuwcMfpG44LQkXVX2A35g7PzlFFEMr1wYIQaqzVwuxihKw6fPUv+8S2pqBbczIvlPdUYnC8g7pDptrTamxJhBdiX0RDFPlVuA2fs66+5tzYEM0dGX75aKbLFVtSidb7YvBWrfRyCm4aJOh33IsRnm/jlw+Tw4/6NgFCKC1PAJh6ST9KL/2T7SrRKlQVLqTBdH0wo09u116o4D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2eWhyALwnN68mkNZKuEEiDrsIZp6e1wcU1PtLgoAh4=;
 b=EYhc+dC1HoYQqUu/SBYHqucWlDa/Kc1Pj8jwGXZnFdQ1MTRdgjjfjhUt3WMa0oxUtHdctexaoFxQP25BMU+S0pi9zXLUV/KTTKd519pCpUdrfD+EHKl6rYVXp8gtGtMRXL7I+HkuG5DLFgAJBi4Jm5guqsGO5SMS6QwIUdKJ36P3SSNurFHjwHSp7ckWqtfUKF+bAYAhlAzyFTt40au4FHIdCuY5/KdT6b747ST6g/bT7x18YkCRyXJn1KB91GTTHMtQZgqPExkL7Ht82+Q/b1x+HgeZ1yemKABaKm9dJlD8+1Hw2R8oBq0HE5HQVUOZdkgVu8VGesDdQpn6V3cFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7855.eurprd04.prod.outlook.com (2603:10a6:102:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 08:43:33 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 08:43:33 +0000
Subject: Re: [PATCH v3 16/22] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210106010201.37864-1-wqu@suse.com>
 <20210106010201.37864-17-wqu@suse.com>
 <2c06bcbb-2aba-838f-e185-d2ce139fd170@suse.com>
Message-ID: <8b1e1a60-3ad1-54b0-b6c2-59c9eafc9440@suse.com>
Date:   Wed, 6 Jan 2021 16:43:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <2c06bcbb-2aba-838f-e185-d2ce139fd170@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::30) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0089.namprd11.prod.outlook.com (2603:10b6:a03:f4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 08:43:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b68d7b2-5cfa-4fc6-a3e8-08d8b21f26ee
X-MS-TrafficTypeDiagnostic: PA4PR04MB7855:
X-Microsoft-Antispam-PRVS: <PA4PR04MB7855814500AAD837E7DB2ED0D6D00@PA4PR04MB7855.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PK7JBMHPFOg91+mQqtAlqiSkgVt5cJ/zYMvCcKQo8ZQw4zqNKtAH50x9DRHEKlFKse4iJjtIRCUZmqYRFrjJZfDbVxfy5sLjfsnfJvM4kcB9BNVwThexYvbgjVXkY0KKw2NUCvGwm7LZH+gVh+uD7x72SkghDPNHVDHuGdZkLEz1foOeM+FFSFLqMEF8y1dLm2TlM7jzOSerOCKqeGXPpaoGbjR+V8IR4jUlMIRmd1opQcLmtQoa+tjByMsiF+mNLiZQ3BV+tlCO+UYPCFH1DOSyK20LAR5nazJcwMrCeUJKGamG9o2OhzZRG9K3wfEhebKTI/Al/DRvSl3FAJc4jocTHlbtYZ93KYfhUxBcR+lLdJx+rMnO9ZnuiLn9HuWF1ToFpGm6gFQ6gXlqqmFSoWh2erfKcy0SUBPFMiaIi1y6fl8lEpCr428tY2PpcS0vb1QFJzmh5q7OZbzHXZb9yypLFsFhjbNEogyn6gfmX+E/51OY7lJj9i4QShIAKPmz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(376002)(136003)(396003)(346002)(16576012)(31686004)(66946007)(478600001)(8676002)(316002)(66556008)(66476007)(6486002)(5660300002)(83380400001)(8936002)(2906002)(36756003)(6666004)(186003)(31696002)(6916009)(16526019)(86362001)(52116002)(6706004)(2616005)(956004)(26005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U50Rc8KRYaYfRwOWtQ0giI4EPfp1L3Yj1bwxH2b+6uvghJe1p26HVA5USN5L?=
 =?us-ascii?Q?d9dAH6L7Qr/R9oBTtU9vcTQPgx2BtmInbA+RamjoweTo/SE0ot+QnJmHz/+U?=
 =?us-ascii?Q?GVP8KTC9ANYoN5DKCg2ttrG4kgT8tZqf+Nw/q+ORTPWfZRqK/jFR6cuiXFE1?=
 =?us-ascii?Q?Ep0jyAmrD8x8i8l78SwdZo6N9MsHZ4S3pO1yGUX67tYLz2YnakZpWsvaBPpT?=
 =?us-ascii?Q?NEdEbPjHpf0XeLXR3Cmev7eRKoiIGup+VxJKYodv3u6oeeJSjNHUhQD6Ld+1?=
 =?us-ascii?Q?b3S2XRc35KfEr79igmAcePQQHlNXa+2ONw1IHQyQTrvOPC8Oa2Q4F5hk4J0T?=
 =?us-ascii?Q?t8rblVNltkScSnzHa8cUO292zbyS1ZviCKYagW9RMYNR3S597CyGqFm86Mq2?=
 =?us-ascii?Q?5sh6W407zxuRY3nU2sGKY02S539GuybSWxQQea7e6m+5SBrdY/F1AZnKL4U0?=
 =?us-ascii?Q?7FLN/gWYXgnsFS7W4ReWpjN/iJTSFFc6EQWeHrG//hmVMqtrQQFHRQsjmZSz?=
 =?us-ascii?Q?jZ73irstC98B/pBT6EYYZW9vsAutRXNCAotJTiyY3sD8X48A7qjFa2h9WCjq?=
 =?us-ascii?Q?1J7Zk9jb02fdqDCOhyvVlKPaG1rP8+jmXpYNWCA4Zo0KXt81jnDL5mk2ESGs?=
 =?us-ascii?Q?u6jMIYgBOnAFYnXsQzFz8sREon99JyHBJFdJ4yaGFaG2sPJBR2gI+RjLmg6f?=
 =?us-ascii?Q?7Mzuex9J+MAzG+PCuqYrTv0ym/ojb1dZ533RffoclK2HDhWu2JZU3SvFc/jt?=
 =?us-ascii?Q?e+6Z9TD+hUWJ3LRFyc5dbCuMy0JwinMVBiSGK7vbvyRThmTxlPPO0mKE5IVa?=
 =?us-ascii?Q?slE2+zhqH9s0yb/TsQjzjyXLntpRqr+25pTNlbcc0dtfWlMjbYaU86dPzlvO?=
 =?us-ascii?Q?w7CAdGvOT2cB70wuFA/5G9aXlNmH8USXtxm4Ub1ikfkrkl0D+XW6ZQTQ2A2p?=
 =?us-ascii?Q?sD7xMfWVHyFhLbStBtYYUY8VLDiiRbVL7fkozDVdk8JxLTrvokxE4HTwComY?=
 =?us-ascii?Q?8b4D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 08:43:33.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b68d7b2-5cfa-4fc6-a3e8-08d8b21f26ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrUNFVBk/pqqqk//nJH4iVqOiasEcckis6cKZlGshNTbluDDasa4z5o2wubYV/zH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7855
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/6 =E4=B8=8B=E5=8D=884:24, Qu Wenruo wrote:
>=20
>=20
> On 2021/1/6 =E4=B8=8A=E5=8D=889:01, Qu Wenruo wrote:
>> Unlike the original try_release_extent_buffer,
>> try_release_subpage_extent_buffer() will iterate through
>> btrfs_subpage::tree_block_bitmap, and try to release each extent buffer.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 76 +++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 76 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 194cb8b63216..792264f5c3c2 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -6258,10 +6258,86 @@ void memmove_extent_buffer(const struct=20
>> extent_buffer *dst,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> +static int try_release_subpage_extent_buffer(struct page *page)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D btrfs_sb(page->map=
ping->host->i_sb);
>> +=C2=A0=C2=A0=C2=A0 u64 page_start =3D page_offset(page);
>> +=C2=A0=C2=A0=C2=A0 int bitmap_size =3D BTRFS_SUBPAGE_BITMAP_SIZE;
>> +=C2=A0=C2=A0=C2=A0 int bit_start =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (bit_start < bitmap_size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_subpage *subpag=
e;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 tmp =3D 1 << bit_start;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Make sure the page s=
till has private, as previous iteration
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can detach page priv=
ate.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&page->mapping->pr=
ivate_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!PagePrivate(page)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin=
_unlock(&page->mapping->private_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subpage =3D (struct btrfs_su=
bpage *)page->private;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&subpage->=
lock, flags);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&page->mapping->=
private_lock);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(tmp & subpage->tree_bl=
ock_bitmap))=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin=
_unlock_irqrestore(&subpage->lock, flags);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit_=
start++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start =3D bit_start * fs_inf=
o->sectorsize + page_start;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit_start +=3D fs_info->node=
size >> fs_info->sectorsize_bits;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here we can't call f=
ind_extent_buffer() which will increase
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * eb->refs.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb =3D radix_tree_lookup(&fs=
_info->buffer_radix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 start >> fs_info->sectorsize_bits);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(eb);
>=20
> Another ASSERT() hit here. Surprised that I have never hit such case=20
> before.
>=20
> Since in releasse_extent_buffer(), radix tree is removed first, then=20
> subpage tree_block_bitmap update, we could have cases where subpage=20
> tree_block_bitmap is set but no eb in radix tree.
>=20
> In that case, we can safely go next bit and re-check.
>=20
> The function return value is only bounded to if the page has private bit=
=20
> or not, so here we can safely continue.
>=20
> Nik is right on this, we need better eb refs handling refactor, I'll=20
> investigate more time to make the eb refs handling better.

The root problem here is, we have too many things to be synchronized for=20
extent buffer.

We have eb::refs, eb::bflags (IN_TREE), buffer_radix, and the new=20
subpage::tree_block_bitmap, they all need to be in sync with each other.

I'm wondering if we could find a good and clear enough way to handle=20
extent buffers.

IMHO, we need to sacrifice some metadata performance (which is already=20
poor enough), or there is really no better way to solve the mess...

Thanks,
Qu

>=20
> Thanks,
> Qu
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&eb->refs_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_read(&eb->refs) !=
=3D 1 || extent_buffer_under_io(eb) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !tes=
t_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin=
_unlock(&eb->refs_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_=
read_unlock();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&subp=
age->lock, flags);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here we don't care t=
he return value, we will always check
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the page private at =
the end.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * And release_extent_b=
uffer() will release the refs_lock.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_extent_buffer(eb);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* Finally to check if we have cleared page private =
*/
>> +=C2=A0=C2=A0=C2=A0 spin_lock(&page->mapping->private_lock);
>> +=C2=A0=C2=A0=C2=A0 if (!PagePrivate(page))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1;
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&page->mapping->private_lock);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +}
>> +
>> =C2=A0 int try_release_extent_buffer(struct page *page)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb;
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_sb(page->mapping->host->i_sb)->sectorsize =
< PAGE_SIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return try_release_subpage_e=
xtent_buffer(page);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We need to make sure nobody is at=
taching this page to an eb=20
>> right
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * now.
>>
>=20

