Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2BB3B82D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhF3N3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:29:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:56966 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234718AbhF3N3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1625059591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9JVmTU/i5KK83oOJcAZYXeHE+B7S0m/tWdUy16PDEs=;
        b=kXSQS52GWvBZt2lpKeBz+eE0gZdLGLewS2fLH0C2mgIRhwacWvi+uj0tAdgoQwrsuh4ZWC
        ai9OapoY/dC7HOA3//ylfhb654FmSWWabhiSJub3qYxwJV/xooih+24EnllVrKQSJcvC1a
        zO3feinXuLKWlLZuMgM5C1oyWOyq6Gw=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-xElhvyV5OgaE8cnT3DUC2A-1; Wed, 30 Jun 2021 15:26:30 +0200
X-MC-Unique: xElhvyV5OgaE8cnT3DUC2A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVK8G7N1TaG8gJ2ByAzuuUQ7hu/OgzHoNoHl1RFyyyr/9NQMT4B6EsKIrXwzgzoZpXBlw7qO8BxADEc5vnp5JWsLbnGQHBHyl13BvQ4k23aDBr7uFInJghD7MgITP6morf/dsino9jz6EKtYVJ7LUgTPIqXMqAZ8qhiYksYRvw5kOX0V9+JuuEWiFbJ8VCkvKoXc3UawVWq1jb0bM0LrSephUxq++kV7hXwGaBr2tzdbgK0Dbeqohnkc/V4Du/AwZEch9o9vufRi70UxydJXWHlkBYmw+CtYh2HXYfL6go/kUjAeYT7OVQy87AWsnBzr9FbgHGaUpEQoaS7pfwUSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKJLFpxr6PhkCsvTHvU7gMfKy/+/R251yJsuO7Ifpwk=;
 b=GtQhpYLI1qEEirSqI8pSfLW4Ujt5+V4kR7kEHXYLH2/vCmYyt7mtRnyFQmOxognprU2lZl4k9/aQXx0I1zPVwCI2q8UmIcCtj16oa07NVyWLSb6y7sley856+ivkcFws+45tc3BpoTwQ6b/e/Z2ZBcwCCiGRLwyW9y9FL8hWobO4Yvt5PZehF/ky98Gklg2EK4Zm6Y0HS/RWPS4vym4i0BIjqiEeESoX1LH82w4RZYreef4vjBJSanesfOxeoR5V8xB39UEFPfPzqpYgiLMy0GtwtklGEPbFNoXp5AZFeWLjiHsDI2Hg19se/p0pHJ1G1+XNKhAz6hHxmq7n5r9Xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5287.eurprd04.prod.outlook.com (2603:10a6:20b:7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 13:26:29 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 13:26:29 +0000
Subject: Re: [PATCH 3/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210628101637.349718-4-wqu@suse.com> <20210630131640.GM2610@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <43550620-f6b6-aec9-9315-ca50cfbbac9b@suse.com>
Date:   Wed, 30 Jun 2021 21:26:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630131640.GM2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Wed, 30 Jun 2021 13:26:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4527146c-f5aa-44bf-ec10-08d93bcaaaf8
X-MS-TrafficTypeDiagnostic: AM6PR04MB5287:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5287C2619342AE7B87A08618D6019@AM6PR04MB5287.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjuzsFrrvocav5sEGcfVEb/oOVKXc4vckkeld60WUcvS+HwkkVn+q7Di0ryuC/DMBUhE4lAMQXngYH8+riD0914G/2TuioyPIaZa907v/44RmVf4IUEGqVP/NuZbFBRqnBBWX/ra2/hVLCaLmEGkLTUO6pnhOklbu6TDs8oMJ2n+/fg0nFwwlVA/CE5pqK0WI9VoDLuNx+LTnjFPvDuZMdvW21HyCkEZMq8V/5I0wgqrEa+K2PcpworYV8IvMdHL5GN8cKirBJiM/WBmL314yapZ4mWMMyjPhFP4k+2ZFv/pjav3S4h54H6CjvnRdX7Cyl0a2HXXb9SpCTvS1VCDDxP5BBRDX7M9vff1ETIfnKOwBGmw/CPN4w8Lh/MUTfgjzCZZ64+xWku66MtKrkWlDw5Vm23+l1Hkja+ZWSnHJKyGXLc3vlTE5RQsM1586X9nmyRw62N2OmIatJIOM/gm/tEvXi2NUL7h/XjuL3UYCpZiluoGhg3QwGrOk77841LosClRLlXJqws7dgPLTBW8fZ0IhExA1zUBCOLpcby8+VqCeZZMDiJAmONohNmSZ1WYTp1Y632BNKoRsHdEWABbZlBPo60tQVcBphOWGeniF8x5AyjqWVHOjoND58dnWobZTCaOJd0Ml74tHEwEhNNqi9IOYRC02iLT513WUtO6B8bEc0DdtJ0Oj5YCWnVp05YLus0fRc6dt0LIe+ckajZ2dLkjK4k2ugfDU5VAVY1/kkkavXYMXennIvT3llghgr6a9hb/HGrOwiLnSV393vVL7C3QCgS0hh1uaMXWYTetPsUrqCsFZqdCJJgJPV7Eo0fm7d+Pcdco9zjPLA7UACzoP7wtZsdDF35/a8o2rDgUsTMy3jn/t8beE/fViXog4t93
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(366004)(136003)(346002)(6486002)(38100700002)(6706004)(66476007)(6666004)(186003)(66946007)(16526019)(66556008)(83380400001)(2616005)(8676002)(2906002)(31686004)(31696002)(86362001)(478600001)(966005)(5660300002)(956004)(8936002)(36756003)(26005)(316002)(16576012)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZ3VCvkKOqaW+2bLtKJoeiockK2+LxxI8ilNDwxioZBhEfDKXhF2Qf/1cLjz?=
 =?us-ascii?Q?lhPhaJ9J3J++qAQH33/yhu1ZlOWt0uLxnMLZJOgWLzJBsHd3kbJaR+XJS4lX?=
 =?us-ascii?Q?EfG3VsBoUXCUVEybNeP5MI7lDRUOLKDn3j+PvA3WXS9iZTM7t/jnudFlHkz9?=
 =?us-ascii?Q?8rIUz0JgilPDNjmB+MTuaP/3XGsxzCMX2ypQCobBLmmHfdVcG66mqnmPEnk1?=
 =?us-ascii?Q?xJUwy3gq3fVJU5z+z703DlcjAEkZHyvzCg+CK2vTeDp7Den+uaYwtUQRXT/8?=
 =?us-ascii?Q?zm8OZ08wZb3VWB1n7744S+v7itzeusENb862zAieNAIhcj0KWdL/2ZxJQgeN?=
 =?us-ascii?Q?/QRqdQX1zDwxnduVZ2XTKV0arK+mWwztQJYSYjycP/EoFiLHIID++gzIpFo7?=
 =?us-ascii?Q?er8ZGetERb+ByYeDU2TQLPowcNbxlZagUQV2P39aukJrg0Un4LTsli5Uo/T0?=
 =?us-ascii?Q?QA8rxvg/OEhGBwloMvrI1qhFXRA6qmdmdN21/7gUUwDlsDsTOFOqKIct15j+?=
 =?us-ascii?Q?IOgMW3D4g/dBjCnCoEej8sO/sKYwxep+ZmJi/Odl3sk/8spRobO/3/UAPiko?=
 =?us-ascii?Q?m/RMFJRCLX0vye2yNvZ7YYEMvCxIhNM3Nw61cFy8Ow35h/63Mb5aLKAnwZ0K?=
 =?us-ascii?Q?IjD92JVb4WbnLe60jL9i61N2SxqcSPLU2Fneb28SB75zgjJ8treLGkqnRPxM?=
 =?us-ascii?Q?5e2rFQFZSyQ5uCbY/bgY+teTQELDSv97lY4k5BacLBFjyW/dfsPJAaI5S5Ux?=
 =?us-ascii?Q?O7NKFq2XYgujc02O8559PDRjsIun/Eqzdxu6Y1A4O+yQvZpKIlgX4mrb/5wI?=
 =?us-ascii?Q?3uOWjuwIbpXvV4Y2AaIdTyxG3AYdI0emqHD+tyCbtnXtsSokih+VpHhX8jun?=
 =?us-ascii?Q?B2naYXKmimS7OyNLW3MlC6uIKrA6hYEGiAz++HRw0A9gWEQNE8Tk+vN0zXZN?=
 =?us-ascii?Q?W7ZYtqblz6rAVw/I+rbHMQq8QZqnGwqgoqZfe6+ugIXiomyEhDykWruyA05Q?=
 =?us-ascii?Q?XT9/V2P8bRI63xhEsG0wsbO7xsk0AizcuXD9fwTR9/LhJQsFt1mt84dOjygo?=
 =?us-ascii?Q?D9RchTK6QhtWFI8ZPPaGN7fJMrp12Urwjs5uCIDFcuPdQiaOQZC/a9MJCjGs?=
 =?us-ascii?Q?So57LZWANV8AHEHC3AyEClRNbBNSnYR1eFbcWFNeTn5XpBKR4ezkDxxWUbRy?=
 =?us-ascii?Q?OZ3Lvoh67NCki6QOrbnjVB1PjwNf3NIePTYVD8VUahK7pyGUhW1eOhZ8WYpo?=
 =?us-ascii?Q?I3ZneIy3EJPdQ8LGSq/t6rCTIdjNxrzZVH0zoMC5+qrjp+E46Ea0UmTWEI7n?=
 =?us-ascii?Q?/kypF+fOEZpC8hyA18LVNwbd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4527146c-f5aa-44bf-ec10-08d93bcaaaf8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 13:26:29.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3bG00xyeiYwpTo8YgVD2ezz88s6qd9XQB7qRcfIKJz0aaDLI0h9TLQCxRGKua1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5287
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/30 =E4=B8=8B=E5=8D=889:16, David Sterba wrote:
> On Mon, Jun 28, 2021 at 06:16:37PM +0800, Qu Wenruo wrote:
>> There is a report from the mail list that some subvolumes don't have any
>> ROOT_REF/BACKREF and has 0 ref.
>> But without an ORPHAN item.
>=20
> Do you have link to the mail report?

Here it is:
https://lore.kernel.org/linux-btrfs/CAJ9tZB-G7KZkxGfrADbmHruuEfwyhV1bihUvRZ=
rJ_ypt_iUVKg@mail.gmail.com/T/#t

>=20
>> Such ghost subvolumes can't be deleted by any ioctl but only rely on
>> btrfs-progs to add ORPHAN item.
>=20
> Is there a way to list such subvolumes from progs?

No, root with 0 ref will not show up in "btrfs subv list".

In fact unless we pass @check_ref =3D false, btrfs_get_fs_root() won't=20
return such ghost root at all.

>>
>> Normally kernel only needs to gracefully abort/reject such corrupted
>> structure, but in this case we have all the needed infrastructures and
>> interface to allow BTRFS_IOC_SNAP_DESTROY_V2 to delete it.
>>
>> So add the ability to delete such ghost subvolumes to
>> BTRFS_IOC_SNAP_DESTROY_V2.
>=20
> So this is only extending the functionality and we don't need to handle
> backward compatibility.
>=20
Exactly.

In fact, I hope we never need to bother such case in the future...

Thanks,
Qu

