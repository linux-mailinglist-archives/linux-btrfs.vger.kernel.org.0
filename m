Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AFF396A88
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 03:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhFABJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 21:09:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:29236 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhFABJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 21:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622509678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gphve89yUfXh2sYR6RQgjDiGy2KisQYDGGLj46+bl0s=;
        b=cZgu9iUGUmV5GVBOCRxM8lYqvCQLQb7blD8leLd9Stf48r2EfXUFswftQBAE03nbc8lste
        b2s+2ZwTCFgrjvtlSb5fBImkFAdT4nEqz8nSGenO9eyKv5U85s+V8o+itshznp5/XbMmpD
        tbmSTC7f8Tc6AIT/dS3U01fZCZJN+U0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-JdNYV8d0NrmDO7hbusZnrg-1; Tue, 01 Jun 2021 03:07:56 +0200
X-MC-Unique: JdNYV8d0NrmDO7hbusZnrg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMi02+5jRQMFKc1Z5pKM5KgakesMGZ7ieTKzjcppX1+FGfRWMTBz3ZLPFPkyhWWmgISDmFendgHmXr6s36mRDsFcZB6dNAkYUCV4xo4C9Pk67Ee6l//hVx0enuHdYxAmajNvSZMpqtUEgtmXieIE+0Jt4N5jm1OyBHQvfrSv2QCET6Q9OCJLu4oAiYT0Nz4GlM8VcGk77fo1O1CKlc/BWKDKqKDca6u+vB1DkU8CJwKDE6ZF/iBzx3HE3amungsvKABred1bRfGxR9flJceBR74oO9B0Xs1sCmPrllW9miKdmBVZeOUNTkyTwrrnERkh+thgCrF4rdEDt2T74DUDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kByBkaf65Ho2H2fy/k0Bwtn+cPnmjYfvEScwplO0I6Q=;
 b=THhRp85VpLShoDz4/ys/goILZe2lQFSx5WdGmJEcSLyZw0WwI2+BcIdg3Sn2x8PVwGUpo/Gr3fB5zRPFLH1zgk+my+1LtDuOJpvwm7gJQlOcexfKlXE+7e2hVPDcmYbPXv/wi4PmRQtKDDm8hc62u3qerbuHaGLF8FRfzlJm/Ua5yBR6Kz1HTFXBuwLV352xrSsj59GMx3Qz0B60q1+MhECQwZ21LoYEogFbWSliBwD0hLQ1+auqEy+wssHwzzsNURwzTV//5eOdnKhjlE3Be7dW/PRtpMvS/pUFYKRPDFOVD0IB83LTS3h1l36X8DDffZPM0PjZL0IwmotIWC4tAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7656.eurprd04.prod.outlook.com (2603:10a6:20b:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 01:07:55 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 01:07:55 +0000
Subject: Re: [PATCH v4 29/30] btrfs: fix a subpage relocation data corruption
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
CC:     Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531085106.259490-30-wqu@suse.com>
 <ae84347a-12f5-3513-6a46-5c34dfdc4062@suse.com>
Message-ID: <d8f635f9-7d85-5c18-6436-ec3d3773ee9a@suse.com>
Date:   Tue, 1 Jun 2021 09:07:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <ae84347a-12f5-3513-6a46-5c34dfdc4062@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0168.namprd05.prod.outlook.com (2603:10b6:a03:339::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend Transport; Tue, 1 Jun 2021 01:07:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c9edec-8465-4417-112e-08d92499af82
X-MS-TrafficTypeDiagnostic: AS8PR04MB7656:
X-Microsoft-Antispam-PRVS: <AS8PR04MB7656CFF558C79F29BC38D575D63E9@AS8PR04MB7656.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWHo8vRWxbi/EhkepthpONE65k5SAzO0bIWo/UAYlLVV5MwnWzINHzoVP21C+00vQhwrfuFam0bq6cMsVlyqph0EgN77z4n+0+yqJf1gFYfiVZlmplkP1Edf501He7siIFSKsT1UJzV+ge0Xznwbnx6dc+hGzlfvuLbJsw36wnC9Lt4/2oOwQ57t/lu/MzwqThWkM0rKVdD1utmJlx/9588uUVVRb0Z2f/sdxFjrC4yj8igLt9JGqGgbkfrqVB/NHkoQaOYzBg5/ur7IqwdiYMk5z/G8EgzOGN6E6YH7ZquDvFlpsvsPimZWW6xi5ZifezCvgVa4YjfwN8TMeOJQUBk6ECZGeeAWs2XIvt2sT7VfIzfKm92bWCNvEFaBOMH+ZLdQHJAxF5IWXcubXP7XyyuSrSFxQy2/AvvC27Q7Ekv0e2ODbL/lMFUrLRbh/VBmbBZj2rXVFLj3aeF4uLvx+nhy58z8LHmuLmaExD979nTL5vAiRRdJjUu66D1vb4YEpHq8VGeZgkURFD0dR0YBsF24CTc4V/8o9A6vLZBrBsbNvg+493SrKzGMXoBc/wXA+ykoIFczZk9ZOGG9SHJnklKrq5fIENCkGf/G2xG1d82noyURsGJmOh10fcR/WRuNDobx2Iwaqg2lDa99j4lsMix3q0+JLAuVqmBKir3b5VSB+1Z8vaJ7aOItOqwReAk2SJW0BWJUlBrizKYv2Kb2oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(6486002)(26005)(316002)(31686004)(2616005)(4326008)(5660300002)(36756003)(31696002)(956004)(16526019)(66556008)(186003)(16576012)(6666004)(6916009)(38100700002)(86362001)(478600001)(6706004)(8676002)(8936002)(66946007)(2906002)(66476007)(83380400001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rsosk2XZd0UTbkEJnLLuiHCD4NHNAJ8bBf3B2CK/eBVLAKwGWy+sgIuT68OC?=
 =?us-ascii?Q?lU13WjyMRxWb9SyvSCKRHfXI/u2r4BZ+X10MK00jG5tpKaIFne1F6lvz5LUH?=
 =?us-ascii?Q?jm43pOGCj1WnvGL41UYQOfnYsCucPvk+V1RRchlQ7/gyGe2QgZBLGbwk7Kr3?=
 =?us-ascii?Q?IBYLqvUROxZXTQi+pmo5N0A2s/CDy0rFkySSNxtIo60S4rY403v5x/lE4ZLG?=
 =?us-ascii?Q?481safMDApuIlN3sjePJQN8hWCr95QGqLcCDd5t3GJAtEFPpjEt52MUENi2u?=
 =?us-ascii?Q?hXEUFE04CGmjxo8NqpYs+0WMe8LfD59OLgOFC6ubhc+5AjOMphSsWVrxHJjh?=
 =?us-ascii?Q?aZWTqbyxUHT6nui91oImoSGa0c5ts9Gv06Py2O29wzVRKSh291cEpUr8QStN?=
 =?us-ascii?Q?LzHs9NORIu/2GrYQRfd3VQDqRiea2Ue3JMa5SLsoyZuQIJRKUeqlhgGrmu/C?=
 =?us-ascii?Q?Otv127qLw0JxDdpgvIzlQiRnjilBOCvDGi52axHDh1zu3LRs3NkVy8q583tj?=
 =?us-ascii?Q?t2NOuTE1iBBOa9YoYVqN3iMLOneQpU058qEKTdNFswpCnvmk17S6Qf9SUsVn?=
 =?us-ascii?Q?mWtwhCSIjN7bqCCqrC13k+YjpqvGBpw7dqUNnqRIEOQleM10REmmxxXaiEcq?=
 =?us-ascii?Q?OgUTrPgXwzhe9dwdoKO7V4qbsIZrJ1DvjGOnjlCisTWQAFgMCjCzoPaALrJV?=
 =?us-ascii?Q?ouTRJvt2O88pbUcDjZnJWT6NQoQ6hEunjZkKZ5jZrqnqwVeAghCV+4obO4N9?=
 =?us-ascii?Q?7pY2X32k6GaM0r3pOo0L66GOok4Qu5R86jmuQXQ86Mhdk2e6bhy3IgAYxSMn?=
 =?us-ascii?Q?Oy1BGGdooEPc74KuHyNKUw/GhvF2xsemj5mF2opgDotS2zwtDoxiXlHCgoCo?=
 =?us-ascii?Q?TIVj4wT2Gh7dvDlAdGbh0B2cufqJyiekyTb+p9SR18hTS9RsEGCiaZFZw6UP?=
 =?us-ascii?Q?BbZxBMhHZJ7kG2rlqa0a5VN9KFfYuPi1EXHgkBl0R1ERvTKqZtzu7RR1iKtJ?=
 =?us-ascii?Q?tOoug11ggjHjOCDhruTDuD0b0CM79cS4RHOS1U4bHRFQxgLvkuMggjJSAonn?=
 =?us-ascii?Q?bcfA5W6Oh/KqMM0jc4Qdyu7fZsk5E6FPjxtuuIApFsCjuxBUtBhwhfJS0gxn?=
 =?us-ascii?Q?5UjGrCtNcIhkToVKm+FOGdvZJzNNnrUBVHo1RhBQgnLskaIeYPlqGw3PrFue?=
 =?us-ascii?Q?tsLLbj+pBAK0MW0JW9rvsZBoO56mbejYjswHLlWYKUgkKxYI/89Z+mih7Xde?=
 =?us-ascii?Q?FGmIvbDGgtsGv2SLJKpec7xkNNzW+yL1/UNZ9v1BGemYOLPMhagGvQHzFDNK?=
 =?us-ascii?Q?jTgKg+rZbj1sv39bn+1/tSA+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c9edec-8465-4417-112e-08d92499af82
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 01:07:54.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8dNfiiF+P+uDclQYIRwKwZvz4ZoHy5gO4NVC8VG6f3T4abgUeMjG2q+A8uwLaas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7656
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8B=E5=8D=886:26, Qu Wenruo wrote:
>=20
>=20
> On 2021/5/31 =E4=B8=8B=E5=8D=884:51, Qu Wenruo wrote:
>> [BUG]
>> When using the following script, btrfs will report data corruption after
>> one data balance with subpage support:
>>
>> =C2=A0=C2=A0 mkfs.btrfs -f -s 4k $dev
>> =C2=A0=C2=A0 mount $dev -o nospace_cache $mnt
>> =C2=A0=C2=A0 $fsstress -w -n 8 -s 1620948986 -d $mnt/ -v > /tmp/fsstress
>> =C2=A0=C2=A0 sync
>> =C2=A0=C2=A0 btrfs balance start -d $mnt
>> =C2=A0=C2=A0 btrfs scrub start -B $mnt
>>
>> Similar problem can be easily observed in btrfs/028 test case, there
>> will be tons of balance failure with -EIO.
>>
>> [CAUSE]
>> Above fsstress will result the following data extents layout in extent
>> tree:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 10 key (13631488 E=
XTENT_ITEM 98304) itemoff 15889=20
>> itemsize 82
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 refs 2 gen 7 flags DATA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 extent data backref root FS_TREE objectid 259 offs=
et=20
>> 1339392 count 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 extent data backref root FS_TREE objectid 259 offs=
et=20
>> 647168 count 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 11 key (13631488 B=
LOCK_GROUP_ITEM 8388608) itemoff 15865=20
>> itemsize 24
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 block group used 102400 chunk_objectid 256 flags D=
ATA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 12 key (13733888 E=
XTENT_ITEM 4096) itemoff 15812=20
>> itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 refs 1 gen 7 flags DATA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 extent data backref root FS_TREE objectid 259 offs=
et=20
>> 729088 count 1
>>
>> Then when creating the data reloc inode, the data reloc inode will look
>> like this:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0 64K=C2=
=A0=C2=A0=C2=A0 96K 100K=C2=A0=C2=A0=C2=A0 104K
>> =C2=A0=C2=A0=C2=A0=C2=A0|<------ Extent A ----->|=C2=A0=C2=A0 |<- Ext B =
->|
>>
>> Then when we first try to relocate extent A, we setup the data reloc
>> inode with iszie 96K, then read both page [0, 64K) and page [64K, 128K).
>>
>> For page 64K, since the isize is just 96K, we fill range [96K, 128K)
>> with 0 and set it uptodate.
>>
>> Then when we come to extent B, we update isize to 104K, then try to read
>> page [64K, 128K).
>> Then we find the page is already uptodate, so we skip the read.
>> But range [96K, 128K) is filled with 0, not the real data.
>>
>> Then we writeback the data reloc inode to disk, with 0 filling range
>> [96K, 128K), corrupting the content of extent B.
>>
>> The behavior is caused by the fact that we still do full page read for
>> subpage case.
>>
>> The bug won't really happen for regular sectorsize, as one page only
>> contains one sector.
>>
>> [FIX]
>> This patch will fix the problem by invalidating range [isize, PAGE_END]
>> in prealloc_file_extent_cluster().
>=20
> The fix is enough to fix the data corruption, but it leaves a very rare=20
> deadlock.
>=20
> Above invalidating is in fact not safe, since we're not doing a proper=20
> btrfs_invalidatepage().
>=20
> The biggest problem here is, we can leave the page half dirty, and half=20
> out-of-date.
>=20
> Then later btrfs_readpage() can trigger a deadlock like this:
> btrfs_readpage()
> |=C2=A0 We already have the page locked.
> |
> |- btrfs_lock_and_flush_ordered_range()
>  =C2=A0=C2=A0 |- btrfs_start_ordered_extent()
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- extent_write_cache_pages()
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- pagevec_lookup_range=
_tag()
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- lock_page()
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We tr=
y to lock a page which is already locked by ourselves.
>=20
> This can only happen for subpage case, and normally it should never=20
> happen for regular subpage opeartions.
> As we either read the full the page, then update part of the page to=20
> dirty, dirty the full page without reading it.
>=20
> This shortcut in relocation code breaks the assumption, and could lead=20
> to above deadlock.
>=20
> Although I still don't like to call btrfs_invalidatepage(), here we can=20
> workaround the half-dirty-half-out-of-date problem by just writing the=20
> page back to disk.
>=20
> This will clear the page dirty bits, and allow later clear_uptodate()=20
> call to be safe.
>=20
> I'll update the patchset in github repo first, and hope to merge it with=
=20
> other feedback into next update.
>=20
> Currently the test looks very promising, as the Power8 VM has survived=20
> over 100 loops without crashing.

The extra diff will look like this before invalidating extent and page=20
status.

+               /*
+                * Btrfs subpage can't handle page with DIRTY but without
+                * UPTODATE bit as it can lead to the following deadlock:
+                * btrfs_readpage()
+                * | Page already *locked*
+                * |- btrfs_lock_and_flush_ordered_range()
+                *    |- btrfs_start_ordered_extent()
+                *       |- extent_write_cache_pages()
+                *          |- lock_page()
+                *             We try to lock the page we already hold.
+                *
+                * Here we just writeback the whole data reloc inode, so=20
that
+                * we will be ensured to have no dirty range in the=20
page, and
+                * are safe to clear the uptodate bits.
+                *
+                * This shouldn't cause too much overhead, as we need to=20
write
+                * the data back anyway.
+                */
+               ret =3D filemap_write_and_wait(mapping);
+               if (ret < 0)
+                       return ret;
+

One special reason for using filemap_write_and_wait() for the whole data=20
reloc inode is, we can't just write back one page, as for data reloc=20
inode we have to writeback the whole cluster boundary, to meet the=20
extent size.

So far it survives the full night tests, and the overhead should be minimal=
.
As we have to writeback the whole data reloc inode anyway.
And we are here because either previous cluster is not continuous with=20
current one, or we have reached the cluster size limit.

Either way, writing back the whole inode would bring no extra overhead.

Thanks,
Qu


>=20
> Thanks,
> Qu
>=20
>>
>> So that if above example happens, when we preallocate the file extent
>> for extent B, we will clear the uptodate bits for range [96K, 128K),
>> allowing later relocate_one_page() to re-read the needed range.
>>
>> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/relocation.c | 38 ++++++++++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 38 insertions(+)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index cd50559c6d17..b50ee800993d 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2782,10 +2782,48 @@ static noinline_for_stack int=20
>> prealloc_file_extent_cluster(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 num_bytes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 u64 isize =3D i_size_read(&inode->vfs_inode);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 prealloc_start =3D cluster->start - o=
ffset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 prealloc_end =3D cluster->end - offse=
t;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cur_offset =3D prealloc_start;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For subpage case, previous isize may not be =
aligned to PAGE_SIZE.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This means the range [isize, PAGE_END + 1) i=
s filled with 0 by
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * btrfs_do_readpage() call of previously reloc=
ated file cluster.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If the current cluster starts in above range=
, btrfs_do_readpage()
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * will skip the read, and relocate_one_page() =
will later writeback
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the padding 0 as new data, causing data corr=
uption.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Here we have to manually invalidate the rang=
e (isize, PAGE_END=20
>> + 1).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!IS_ALIGNED(isize, PAGE_SIZE)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_inf=
o =3D inode->root->fs_info;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 sectorsize =3D fs_=
info->sectorsize;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(sectorsize < PAGE_SIZ=
E);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(IS_ALIGNED(isize, sec=
torsize));
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D find_lock_page(inod=
e->vfs_inode.i_mapping,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isize >> PAGE_SHI=
FT);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If page is freed we =
don't need to do anything then, as
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we will re-read the =
whole page anyway.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (page) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 =
page_end =3D page_offset(page) + PAGE_SIZE - 1;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clea=
r_extent_bits(&inode->io_tree, isize, page_end,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_UPTODATE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_subpage_clear_uptodate(fs_info, page, isize,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 page_end + 1 - isize);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlo=
ck_page(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_=
page(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(cluster->start !=3D cluster->bound=
ary[0]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_alloc_data_chunk_ondemand(i=
node,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 prealloc_end + 1 - prealloc_start);
>>
>=20

