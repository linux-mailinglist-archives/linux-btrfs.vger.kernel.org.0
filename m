Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5604D9CA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 14:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiCONw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242530AbiCONwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 09:52:51 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4178653706
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647352295; x=1678888295;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=84Ui1oRmBj9HpUFJi/9AOZubAOQHirB/6U9piqdde6k=;
  b=ptfbosWm6bJCgUscCtOmRhAPxTyWe1mJ/FdpFsNhej/+DwQ+Zo8tMIus
   3yrkoLk3H4UtlbK/yGsNfcCrxgmQtnCsvfewFjznabczheR74ukvPGQuK
   cG2ZcrgF2Er4AAQneor9E667bWstCGFv7HDdLbR8d9h0ZhTFwlqVGkY8H
   ICnJs6tSBXZlbQtw5R5pqsVt+F5MvKl/37rwc5kc0im0jpirL2Gb3y4C5
   gJMnRzpzir3leL/LWlu2KOBWCLgde5LQyMBa27xpTvACE9xb5Upqun8p1
   nlmG4EFnLxkPoJ0zCazMvHs1PNQ2ueWq6ysmz3+WBnymzYNvO2eVhkFrY
   A==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="194329228"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 21:51:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEtfKeb05hbf+hkyEE9iYqB2Z7EPYpuTCn+d/9mZSq97D4a22enEDKiQEzFziJXqG7aMl0p+LkduEByEjnaAXjyTT3QbC/BiXK8Q3DLt0ZJZtDBGgPcrJ+/ecBUE8/IikwlL3tV7K/tHR+TwoIIoS2ZjyvlNwk0t8hrHKbE42pmhlfJADR2w3dwt2+WOB1vgs86a0jds0LvaVBUhwgMjqHWqNJyLBKEkWcNwAvd8omipIzi2CeRfhOIO0Db4sxhpcayCv8H/T+TJTExA+DVkZi1/uDf+q5gJJdSKKyIhBfH5C7GoWecXO/tGKwpbr9Nix1bEHfGmO/QfaWcN1S6Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdRZhQCDlTzFW8K+kV0WKonIBKgorP6AuMLhU7U5JTM=;
 b=OwsF1kEq/5yCU2xkmtWXXqCGsskAO5KUnMwjh9dhkFJeRBLnXJ0x51oYsMSN47BWUqQlXXjsdhxdIEMHMpEc0C466qsl3hHNl8n/FqiEiDxYQsIF4W9upxWGYHl0AY7i5e5h6+e1QiQEvmFWgEQUhZ+T71mEum4lQFZCSQfMUrjw6eXHlsQX7HQ5nG3gqmfTAo7hL7YqOKiSwSOGikgRYGn7mi1R72fm0flW1RR3vD/jnhYwX1Q34N4hSUEzds9niZzsrG1YjC2tvLvTebF4iioCVCp123SnOYyZJsohIhkPyFA0BxSUuZHfUUXcq+rI+0HIIGTz/+PqUoNCVh83BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdRZhQCDlTzFW8K+kV0WKonIBKgorP6AuMLhU7U5JTM=;
 b=jTCqeLeFVYsyH9zHJfHkj3/2lWkSJCn2G4Yy+I4uZCgMtr64xr7HNQHOWIxyH5DdYFUmv1wFCX3cSQ2jEEmr3ULjU54gkPJWUwxRNVyi129StNKrfi7TdLpPF8MS+leJzt3CXXqayPzZmXq5hK9EnxGaP9FNB0YoB7RaOWcCle4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7627.namprd04.prod.outlook.com (2603:10b6:806:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 13:51:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 13:51:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs: zoned: make auto-reclaim less aggressive
Thread-Topic: [PATCH v3] btrfs: zoned: make auto-reclaim less aggressive
Thread-Index: AQHYOFxAQiAIT4o+/k68hu4scsxCjg==
Date:   Tue, 15 Mar 2022 13:51:32 +0000
Message-ID: <PH0PR04MB741627CCED189B4D1B5B1ADD9B109@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com>
 <YjB8perl04WEeTnE@debian9.Home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2208d27e-9314-4e6b-d99b-08da068ae9de
x-ms-traffictypediagnostic: SA2PR04MB7627:EE_
x-microsoft-antispam-prvs: <SA2PR04MB76270AAFA6622C3315DE99849B109@SA2PR04MB7627.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kc/fJc5Ddd45rScPJCIWJOz/OEB271VmZpWDEconhs0flQzbP64+JQOqz/JfI9mbde9KSMVOYIpWCXWr3sa0HvWiShFYqkJUnBOJ230bVG0n+imvCsMfE59yI4O2/ohVn+U3j4bkrrvs5x2AC39TFLeko23vUysxFRrZQaJY3C9s6zOUmIIWGxrByoX21MZwjSYbv2HRDhnU5Z3XrWqpLLHBhAL9dTF1XB+rZEK/4NQqFEYmauI8ybzIWowensNyXx9YLfXg6zvBRnrTcpiA5q1NWrO6gUNTEQI3Gq/SzMiKIOv2xzaqhJCL9UIBmb94zWAJJCOCdD1Gz/unGtiIdIwjAm+RtnAzlHz9mDEGk4IzPpdNPQz6QBM3YFG6EYuZFqXQTRIEhfrWgWdvHvTRfCCTuK3UTu0y+SF8QvJsu1jcePsybw7i/H8s8pxhgqOoL5css8vQTD7Sg6EXKHDSrQIOq1FeeJ/8BUtvHJqwTwVtjlMr0H1la4EXrYbrTqalB+JI6n58+87xhgkZl8OpER14S48RAXruKxO7rPiXg+Dd2aVnexpjbr9aYZnLj96WajwPIhmMbugkr0KubR2VaztDvL0rGR2HOMYl/yZc4wTJB3EjB8JGd/6Lbqs2KoS6yI8ubjnu3n83FVcBqb4r0esxvYmHqdjMFxQem9OWBfSpvEmrnnIw/ME4B3NomVbRbDnjG9FCPGQfwec/crRckA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(122000001)(33656002)(82960400001)(6506007)(38100700002)(7696005)(53546011)(8936002)(5660300002)(52536014)(9686003)(86362001)(55016003)(186003)(83380400001)(6916009)(54906003)(316002)(66556008)(66446008)(66946007)(66476007)(76116006)(64756008)(91956017)(8676002)(38070700005)(4326008)(71200400001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?33nLR0zPDIOdTpl+9Brb8BRBDYKwx9KgWO91S6JHrVDf+7mQtMOyZJjphKm2?=
 =?us-ascii?Q?198V133fpzQIbAH8KCt5/xboFOeOrqk9jI3c1IjkWymj4jvZX+y7lQK8sED6?=
 =?us-ascii?Q?T8aAJBwkIswHxEa/RVJSUN0cdrVcTcXw9Bc378QDEXfmLGRnu0Zw2qM+kWiy?=
 =?us-ascii?Q?2hMQr00uRGD51NPGtwH+WtXTWyOJAiRUYgd1OPzYrXg6IrY2334BrZFLU1Gx?=
 =?us-ascii?Q?hEk0zpsEHfDfMEKvqPA7NAdQi1lRzosgL8DXdZfzagO1KWQcWxyqhcW2ZA1J?=
 =?us-ascii?Q?QntSD+FWJGnhRU+fbt9Fw/MZFI+llsekg3X2wvHNkvVxzbTfXuyt8a5aJ9No?=
 =?us-ascii?Q?1p3kLzpLibxRjInknywrkJe+UmBe2TZh6EBW1JivMAB14Td0J8II8gY5bx3C?=
 =?us-ascii?Q?02+4cot8t6FrFuQ/uwlx/4UMhqBWRH9UZzzXqe29IBWotV0CTYxE9btKqJgo?=
 =?us-ascii?Q?2WU8xYiJPGRm445iYDRTHE8fkenKlWGNZU3EwGWsMLTlNK8P92hg514RGHTq?=
 =?us-ascii?Q?RFvwAEy/jOVIvYa3rdh9m0+OPZYhBWrvfPp8iBG/b3nR0vJ0tL3WXYMcckdF?=
 =?us-ascii?Q?fAxdjdMAin2QVLf5H9HcGsIqFPBwKF2llCjBbd9cdMhP3L8UY+KjXaGW+cOB?=
 =?us-ascii?Q?XVvELDPeRmPdHofK7378dl0gF9zWihtXFJPr3t6iWSWs7yXULCvGK68i/HKO?=
 =?us-ascii?Q?vtV2Xooul5EzsS0kzG0Wt17qdCcG3BxWhaiJLCBOOtlBVDCrWR4VcemleBTK?=
 =?us-ascii?Q?zbjBaM8lWLhgXVuZU3xLZkX92cmjFAbCbmrWjh3H/7aHcD8TseBkEuzf7OmN?=
 =?us-ascii?Q?21Bhn94OG8IgauAxwl8etRH0GQTOt98MWHPWX8KSxQ5o/xJVDGlhbRIMPYzo?=
 =?us-ascii?Q?pS3J4Mr/gzDddHYTblxDvSPAB3+7tRDeHA/dlkAIkIm8C4CHMj/Scv+UZC67?=
 =?us-ascii?Q?DSbpc9wpsWoa7n5+seCedt41ROI5nrsafSzkOql6o/FEn2Qb3Ib6f3PuL3Us?=
 =?us-ascii?Q?ieO4G8MsM0a558IvyNklSFBEdbp0TnMORVoOAb7au4vJp0FgVMMMBwqHyWk0?=
 =?us-ascii?Q?jBhrISoZ7rovF4RFMsCd5K3VKht1e7wY6ydgsN+0mGA38d34yk0eZjKteQIq?=
 =?us-ascii?Q?H6hkBQk5D+LjrcooWbT/T+05ELXHbAcvWhzI8DkIXDhsZtK2wKXKYqyRYDUa?=
 =?us-ascii?Q?mmlSzfk7b5P5aKzCr4FeRMERUNwDPanwXKu1foVULiKq1GvySE7vv5llYF99?=
 =?us-ascii?Q?UL8ix/carmBut4Um826yowb9kPUIbMA7zHKjNH8+uE4DUhWwKpDCX9FbBQ2N?=
 =?us-ascii?Q?LViD3OqpT+2FxfLQ+osBZP5OaoT6txgiiukZY45hUEZOjcv7k4z8GXgi/zAs?=
 =?us-ascii?Q?/oInijgVvav4kW8B6BLkYM0OBLa00RbsqybHUheUMRhs4/g+iHNsJJKzcOWN?=
 =?us-ascii?Q?izE7BbsxKtLfUC9GX7SA4Y6D6fHRL3S4V6v4iaa5rGkEq5gtsX2cnToffMM/?=
 =?us-ascii?Q?q5Pci8nq4inIPUCJe4awK+na8mSXWPMYWhy7rgDQ1M9Ev/6TUvBCrHegz5z/?=
 =?us-ascii?Q?Ww+NGaRaDKYU+R5dQ3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2208d27e-9314-4e6b-d99b-08da068ae9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 13:51:32.3877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/NbyNObZuWcwPydUkarPq9pv0s2VukpGa3pB6q/SAdv/ur+8GjZd+VnZt6YX2H2mjh9ZEs9Piho6YeVb+bQQ1dwtuwQpGY8r7o4BAMeip4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7627
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2022 12:47, Filipe Manana wrote:=0A=
> On Tue, Mar 15, 2022 at 04:02:57AM -0700, Johannes Thumshirn wrote:=0A=
>> The current auto-reclaim algorithm starts reclaiming all block-group's=
=0A=
>> with a zone_unusable value above a configured threshold. This is causing=
 a=0A=
>> lot of reclaim IO even if there would be enough free zones on the device=
.=0A=
>>=0A=
>> Instead of only accounting a block-group's zone_unusable value, also tak=
e=0A=
>> the number of empty zones into account.=0A=
>>=0A=
>> Cc: Josef Bacik <josef@toxicpanda.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> ---=0A=
>> Changes since v4:=0A=
>> * Use div_u64()=0A=
>>=0A=
>> Changes since RFC:=0A=
>> * Fix logic error=0A=
>> * Skip unavailable devices=0A=
>> * Use different metric working for non-zoned devices as well=0A=
>> ---=0A=
>>  fs/btrfs/block-group.c |  3 +++=0A=
>>  fs/btrfs/zoned.c       | 30 ++++++++++++++++++++++++++++++=0A=
>>  fs/btrfs/zoned.h       |  6 ++++++=0A=
>>  3 files changed, 39 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index c22d287e020b..2e77b38c538b 100644=0A=
>> --- a/fs/btrfs/block-group.c=0A=
>> +++ b/fs/btrfs/block-group.c=0A=
>> @@ -1522,6 +1522,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)=0A=
>>  	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))=0A=
>>  		return;=0A=
>>  =0A=
>> +	if (!btrfs_zoned_should_reclaim(fs_info))=0A=
>> +		return;=0A=
>> +=0A=
>>  	sb_start_write(fs_info->sb);=0A=
>>  =0A=
>>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {=0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index 49446bb5a5d1..dc62a14594de 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -15,6 +15,7 @@=0A=
>>  #include "transaction.h"=0A=
>>  #include "dev-replace.h"=0A=
>>  #include "space-info.h"=0A=
>> +#include "misc.h"=0A=
> =0A=
> Why is this included added?=0A=
> Did you intended to use div_factor()?=0A=
> =0A=
=0A=
Indeed a earlier version of this patch (using a different metric) used =0A=
div_factor_fine(). This is a left over, I'll remove it in the next version,=
=0A=
as it's not needed anymore.=0A=
=0A=
Good catch, thanks :)=0A=
