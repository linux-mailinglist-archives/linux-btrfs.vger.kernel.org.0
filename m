Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C42375DAA
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 May 2021 01:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhEFXrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 19:47:39 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:52012 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233048AbhEFXri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 19:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620344798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7cr9HSfktWLzZr+Vc1A+8N9vs2EQoCKEdmlfcroAPs=;
        b=XU2bDlqoRmGupn98VCGjzXFJR2h94kRjlssZ4aSmgeYIHM9UIsXAVx8y2jG0lGldH3xmHN
        voMxO9JA+iSHMB673OWEUP4/nU7JEFXcHNa9rsTr4hEVkUZ/rhqCcA1X82XGNSNaLlaM4I
        QUZg8nJjyA1478e614x3U8dTRlezoGQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-JqJ27uncNe2lcETzyUpUfQ-1; Fri, 07 May 2021 01:46:37 +0200
X-MC-Unique: JqJ27uncNe2lcETzyUpUfQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNSeg5uie4KpJGWWIS9x4EtSgZvQZZXkTR+PUkCBuMl9Gs4+kotr+YfcyghkuFFvQxVNUZMb+CkeR/F6twx0h53gobhe8MD9xJkYKU5Dszea9kPjKg6WzPXQR2VADOAvRmAhWtexHkmxvJIbhuxTIVj8GF1LhYnvtAe2VHcKyavWjecqEqxlDfRmnU5mdLpCdAVFWJm79Es0WG/UOLK+0UdGN2w9p+sM6fYfGMdzU3Gm62NFwUFO0HtLgPHDNA1EzRmgcZgBFPVeKmgnhDX5vZ74lmcIowsZhER0RlprnoldcgzzfqLsJjpNaofL6aK+wizi1av/MhX98zBgMrNhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7QufgfgixvTIa+b0fe0JsgWarkxXHCcrgekmkK31PU=;
 b=Rd4C3YbEAJ1GNbfoyysqYzlhUlNkN+QDTRA45zsaaSZIt63geHE0DkCczR7KABj6ZmOXTtC469SlV1Zj73/ix3i+cz3juTKNPR5x7KTNSP1AgpwkKKdG50B55ZrjV47HEPN4hiI7w2LAIJQPTXfTcjln8KeVljbWfBpTVWRK1zsOijT0GaIDuBpvLhwWe4+6UWVYGyi7naIeVjoEHSEnGYbBrG/a/vpX4L75rpKaonBjB/x4aX98n/olG1LJEX5HCxeftjguyGsBggiP/+a5NLaK6G5asCiQW8xi6iSaQNt9WcrTSwcCVPgtL0DbRTtO50ti3iVNt5ZE2E0yEALkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6072.eurprd04.prod.outlook.com (2603:10a6:20b:bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 23:46:35 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 23:46:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
CC:     Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
Date:   Fri, 7 May 2021 07:46:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210427230349.369603-42-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [45.77.180.217]
X-ClientProxiedBy: TY2PR0101CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::18) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TY2PR0101CA0032.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 23:46:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d271344-8946-46e4-7ef5-08d910e92efa
X-MS-TrafficTypeDiagnostic: AM6PR04MB6072:
X-Microsoft-Antispam-PRVS: <AM6PR04MB6072ED6EBF6C8DB2F488684BD6589@AM6PR04MB6072.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJ/U2stkMYMJcaRaqcSztW7U2ZUNwyyE8XixdhhXy0s4D3VgjGbtyWEKNt5EAicQUAulSAUXoE8US2s8GGN2a3JPMlRHdaNFnQhJp5Z/c7r3Z8BEtqsyUNquN3iPK7X4QfeM+HOHo4lcVYsgCQ7iDxe2mce9AR1mbWZd+8INs7fBAL3j1TZ9pK+oi4nuIYGk3EfgTc75Jeyh5Rcl7665FrStKXItSEoVA9AHxWTRTvwipkmNzePyUdF5NquxJfD6Oqawi5Rpehi4xNz4Nn1VCQsAodrVpvowoU+28BMdgbJthvFUkTtOd1nqR4Cs9QtnVoyeEda3lRvC2krX6gsAZXDWtOBrwAVJNfHgCB0cy8ULP1PpGLxsZ2iwtZzA1Wej/9CIHueawhrnhI6ayN+kdK+5cusxic7mIXI+VL2NWcnwn40TYUo1tV5eXenBKO+p273clTHYBy4jOlzupPYZWQIIKVYTNSQyUibUf5/5XkKsJRHxf31qUB/WKrFoPxQe9K1jhhAz7ngAep5VZulJug3ztTOQfJmqF71Iq/6v59ogJuLJAqCeTOiMcwQEEoZYGWrPx1ya7uoxU5Nz9TPOUm/6gCpPXG/GLyHMyyg7UorJD/zBXfDRgTOH4ZgO7eehkHPGEjO3kKOTqiz6SWJCLAbj0sN5M3Bav4XwGUAE8i4KB+4RMoSqiKPvnDIf8WdWozGvMBa9tZWCSIy9TAJi3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(366004)(346002)(136003)(376002)(31686004)(31696002)(6916009)(6706004)(36756003)(83380400001)(6666004)(4326008)(8676002)(26005)(55236004)(66946007)(186003)(8936002)(316002)(38100700002)(38350700002)(5660300002)(956004)(16576012)(2616005)(66476007)(6486002)(66556008)(2906002)(16526019)(86362001)(478600001)(52116002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zQ/95Z65Mx90vAtcvNM5eFhQkY7WAfjK6/LV0b+8SeAt7oW+lZJoKC3RH2yr?=
 =?us-ascii?Q?fHhD5H6l7YeCodKUsuw/r996Xts7ctXIXmHitSx49UCLP6nVz2ar7kw/Fc/D?=
 =?us-ascii?Q?zqG4uqm/+LTrs5UWN52wfvgDdhCwQ+znYzJN4Fp1Oxzt9zcbfqPOJ0Of2CmW?=
 =?us-ascii?Q?Z7r5Gi4pwNlRZGvkbfhjtk3C3L+JS07rTPaFB+2FcMtRTh04zC5k8D9YEd5K?=
 =?us-ascii?Q?eRpm6I6mx+6xt22Sf+bETUQAS2zwEMetoPSWRw/lSnDpR9P82oEE/5FbxD1b?=
 =?us-ascii?Q?Z0J2eLSxuxNAjR1DJWe12xSIkCj73FEN9boWnCieUd77W6U+HgzQ1ip4+LB1?=
 =?us-ascii?Q?yrDcJrA7SiaVdZz8LyRPTCXnR0Usif2XOIoXL3v0etPK5XQN0y+KSc/FZUem?=
 =?us-ascii?Q?d6sOkRUw1rC+pz7SWKnxTz6H5UhO1TylhTuj3PL2/fSfnDvYg2wU0w/ntDkG?=
 =?us-ascii?Q?kYJjqWaZpZwLB5ivwTZHAmZBPHZkY9zLZ65NZSG712KyBjlH6EPusINbAypr?=
 =?us-ascii?Q?RnOchi4uzgwFXeWRRpzsjEzuVLEDlkFXObIxT5+OJfE33dQAmkBOdStrrNTa?=
 =?us-ascii?Q?EWyklX8bK3Vvotbh+kKr+Pewb+Ncp23dhq6yLnIwq/Z0AcuWR4LtgsEOeqTQ?=
 =?us-ascii?Q?56mGqKJKpcQ1aC23O7eczzBeyiC3ZoSYtk0zZ1+7yOkwTi+YbMP13yPESV5m?=
 =?us-ascii?Q?GYhJhokW0xI00jwx2dgkeah+QsUcvUyFH5ZujicbpGu0F1+vxwYTjRL+q0uH?=
 =?us-ascii?Q?644W+eT2h5pAgkEx7Fb6Wq9rjLLVDwzUli4ldH4gDE31/nL3MwnOE9lsw9Ce?=
 =?us-ascii?Q?/Chr+M3X2QA2B7OQGZoc2b4OZp8xWVB41km74mhQAqsACWcTX+tO69WuuXWQ?=
 =?us-ascii?Q?i1SxvQ6Tz5wY9fsNQk2W3m8tl7yMSm0jFlL+SwEBU7JXwm5VzOdu7rMs46Nk?=
 =?us-ascii?Q?vPFx24HG/gRTkSr6azOI8sZIAjNUr7Sb/sOAxOWhz0mK7BKjn4K/ybr8qxIn?=
 =?us-ascii?Q?ekxbW+OdbCT2A8x8a+IN8bQnvxFYCyhtaDcLjz5s9iO42luqXWAUs8JvE3Jd?=
 =?us-ascii?Q?osggOJr3nxe6E+EvqF6PWI/myGHsxBSXglUNwZMzE8c8clXmDmHGWjrJl22T?=
 =?us-ascii?Q?Nf+UzdcrmrtILS8o1LIYfkEo1JO6cqT8byKArfTKPAwzr1q+/eaUWN1+uahX?=
 =?us-ascii?Q?kfpYcVlpHZZIksr/ZyCYH5kWdGt+DjK4l09H6Nt9LsogVxSdwsyHd/2Kv2GM?=
 =?us-ascii?Q?argFeqQLCVlm7sRG1RCcCIpTNI066V1X5qZxqeu9QGVtK3SwNIXTp10zs0jX?=
 =?us-ascii?Q?n+Bxjvvxbn1DC9mSg/VC+Bvz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d271344-8946-46e4-7ef5-08d910e92efa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 23:46:35.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HK9As9CTa2ug1mAHPrvKl7qw030ZrhIQnRm79SHMvKIKuPnHzcTtmJvWHaIYEaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6072
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/28 =E4=B8=8A=E5=8D=887:03, Qu Wenruo wrote:
> [BUG]
> There is a possible use-after-free bug when running generic/095.
>=20
>   BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b725b
>   Faulting instruction address: 0xc000000000283654
>   c000000000283078 do_raw_spin_unlock+0x88/0x230
>   c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
>   c000000000a918dc btrfs_subpage_clear_writeback+0xac/0xe0
>   c0000000009e0458 end_bio_extent_writepage+0x158/0x270
>   c000000000b6fd14 bio_endio+0x254/0x270
>   c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
>   c000000000b6fd14 bio_endio+0x254/0x270
>   c000000000b781fc blk_update_request+0x46c/0x670
>   c000000000b8b394 blk_mq_end_request+0x34/0x1d0
>   c000000000d82d1c lo_complete_rq+0x11c/0x140
>   c000000000b880a4 blk_complete_reqs+0x84/0xb0
>   c0000000012b2ca4 __do_softirq+0x334/0x680
>   c0000000001dd878 irq_exit+0x148/0x1d0
>   c000000000016f4c do_IRQ+0x20c/0x240
>   c000000000009240 hardware_interrupt_common_virt+0x1b0/0x1c0
>=20
> [CAUSE]
> There is very small race window like the following in generic/095.
>=20
> 	Thread 1		|		Thread 2
> --------------------------------+------------------------------------
>    end_bio_extent_writepage()	| btrfs_releasepage()
>    |- spin_lock_irqsave()	| |
>    |- end_page_writeback()	| |
>    |				| |- if (PageWriteback() ||...)
>    |				| |- clear_page_extent_mapped()
>    |				|    |- kfree(subpage);
>    |- spin_unlock_irqrestore().
>=20
> The race can also happen between writeback and btrfs_invalidatepage(),
> although that would be much harder as btrfs_invalidatepage() has much
> more work to do before the clear_page_extent_mapped() call.
>=20
> [FIX]
> For btrfs_subpage_clear_writeback(), we don't really need to put
> end_page_writepage() call into the spinlock critical section.
>=20
> By just checking the bitmap in the critical section and call
> end_page_writeback() outside of the critical section, we can avoid such
> use-after-free bug.
>=20
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/subpage.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 696485ab68a2..c5abf9745c10 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c

Hi Ritesh,

Unfortunately I have to bother you again for testing the latest subpage=20
branch.

This particular fix seems to be incomplete, as I have hit several=20
BUG_ON()s related to end_page_writeback() called on page without=20
writeback flag.

> @@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const struct btr=
fs_fs_info *fs_info,
>   {
>   	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->privat=
e;
>   	u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +	bool finished =3D false;
>   	unsigned long flags;
>  =20
>   	spin_lock_irqsave(&subpage->lock, flags);
>   	subpage->writeback_bitmap &=3D ~tmp;
>   	if (subpage->writeback_bitmap =3D=3D 0)
> -		end_page_writeback(page);
> +		finished =3D true;
>   	spin_unlock_irqrestore(&subpage->lock, flags);
> +	if (finished)
> +		end_page_writeback(page);

The race can happen like this:

               T1                  |              T2
----------------------------------+----------------------------------
__extent_writepage()              |
|<< The 1st sector of the page >> |
|- writepage_delalloc()           |
|  Now the subpage range has      |
|  Writeback flag                 |
|- __extent_writepage_io()        |
|  |- submit_extent_page()        | << endio of the 1st sector >>
|                                 | end_bio_extent_writepage()
|<< The 2nd sector of the page >> | |- spin_lock_irqsave()
|- writepage_delalloc()           | |- finished =3D true
|  |- spin_lock()                 | |- spin_unlock_irqstore()
|  |- set_page_writeback();       | |
|  |- spin_unlock()               | |- end_page_writeback()
|                                 | << Now page has no writeback >>
|- __extent_writepagE_io()        |
    |- submit_extent_page()        | << endio of the 2nd sector >>
                                   | end_bio_extent_writepage()
                                   | |- finished =3D true;
                                   | |- end_page_writeback()
                                    !!! BUG_ON() triggered !!!

The reproducibility is pretty low, so far I have only hit 3 times such=20
BUG_ON().
No special test case number for it, all 3 BUG_ON() happens for different=20
test cases.

Thus newer fix will still keep the end_page_writeback() inside the=20
spinlock, but btrfs_releasepage() and btrfs_invalidatepage() will "wait"=20
for the spinlock to be released before detaching the subpage structure.

Currently the fix runs fine, but extra test will always help.

Thanks,
Qu
>   }
>  =20
>   void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
>=20

