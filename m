Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F852529B74
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbiEQHwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiEQHv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:51:59 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700461A82D
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652773918; x=1684309918;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KAKS4iprIRH3a+ra/0Z24MKtvSfZSFpU0vX7Thflt5M=;
  b=KI2fgANcESQuW58Wb0FrKIlhWLbkakkXevq3uB+t9ZhmyclNAYjuw4sV
   PSemSsUMbUMeVxKGJmemn6aYWpmnv3NJSaviUShLawo6x08YYfv1Kb7yG
   HypOi+UR8pJQj8GGYMpcFztjZhCxxQfc9pPvhlRGtExJulU+JbGiMAC/W
   JAKnJZc1EvQtu4c4LQ86sJFLMzaKp5Alc5RD33QmFC9HeJ6ZPQJaf5l4+
   zT3m/eoL0mLabOhX5MMcVddAR3GW7WoDAWbReVv5lbCPUX3gzLsskNKmP
   OPDHZq8TvNksAAuOMQ+VqPqu6bAhoDz8iEX8Ja/qLiMv3vv86CsogOgGo
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="200535723"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 15:51:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/bGFC2KD6jytEjT2ntHZpUJd/Fb2Abg7Z9vGOqd1EDoBwPCQ7aEavLJu64RtB4npvHUSxDO1AmSXKtSNO7yAavbo0ayrbKZeIXNX+EZOGICxTDPiqF5ukc/P+xNECh5o+1BuqC+CL5BKlHRzII3K19GyTnp/9EIZn3UInXAda07JgdC8dw/Be++I1ZZlJIG0BAmPuYCkKj+j9aw0dy9ARWerP92m042ryff3WMfbD35++DanqABwjHlxh0K5EXD/o6oOWgnUiyU7If9F+YbLJwekxvYhtz5spJgZwoCYFPURy4B2OOm46Xpf6aNllKOHz9AB2PeK1kYV9yekLCM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAKS4iprIRH3a+ra/0Z24MKtvSfZSFpU0vX7Thflt5M=;
 b=hhmTVar8mVvSNdCWxpQqLzYR0gKgkcNc8oM+HgCXiqsa3goMVZC9FcfPcXxWaUbjBqpSq3pmTu+jgAQulG6tS5I35TxubB+16sccfKs9Uc3UML7VzujYp5/XepNLOnoLQ+t1ABAe+3bqr9xQbpVxxus2Ig++4ZnoXUMyWSiAHNujeApSJvXHYUPlQQOqI++ly2cAqZbTbehwK4j914xywOAJNxitF9G20dArpkj+mLaCaGe6L7GJNIn81BI24cT9blmtaJA5gcREUgKWejYK+3Y4d+fNYGc+gTDDJQI6QDXMz4WHj+pcNgB2ZK3jM0hExTCCQmY8gO+TmWMVtWO4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAKS4iprIRH3a+ra/0Z24MKtvSfZSFpU0vX7Thflt5M=;
 b=DwkLhKmluf5b8jPlCur+98M11WX77C3pB9cy2FSkO1SZb+AOfUYZSsiA+qpqbgS7aYMr2Haprhy36ilVRVlrAFni6PJpMremV6XhjHKkAoyTEQqeg5Uuw9bG66wcAnXSQp5vpntYumGR+AjfyP0GeHLmN06cCqhkll9ZPo9Wy1k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7133.namprd04.prod.outlook.com (2603:10b6:208:1f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Tue, 17 May
 2022 07:51:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:51:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 2/8] btrfs: move btrfs_io_context to volumes.h
Thread-Topic: [RFC ONLY 2/8] btrfs: move btrfs_io_context to volumes.h
Thread-Index: AQHYaTGympxAuoaYBU6nqqm7/wKLZg==
Date:   Tue, 17 May 2022 07:51:54 +0000
Message-ID: <PH0PR04MB7416045672918E66690ADE8D9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <6bd71ff55e48686fc917736e686143ca7d5d2c64.1652711187.git.johannes.thumshirn@wdc.com>
 <51ac74ff-ada4-a3ee-5638-2fad8fc14f03@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f55022a-ab05-429e-a9a4-08da37da1caf
x-ms-traffictypediagnostic: MN2PR04MB7133:EE_
x-microsoft-antispam-prvs: <MN2PR04MB7133604C1253A2C3129AAB819BCE9@MN2PR04MB7133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: novlCWLZxG3nBs78/tqN255uzEJ8gQtXK46/dOtLL+FUMVU8xZvbLnuWjehF+Ekvyki6aD+iv7f+x4PmnTZFeB3zS/KCzg0E66ab09kQe53/G367d6uicwL0p8cfu1MWoRkoSvdedbUJTPT4GDe9YCODuRt7mKvo+dSp0HCOK/dV6dkaYSF7BjfBj7k8GHNkkcwoDCMzhhrfAxlX16ZokFJwtjHyJBCsRv+s32MY4DOYEhdoDhUFBde7Euo3K2GHtiSjQ5ZgF5+FstE4GTESO484cNAK8GVD8xb1R6pv3U+Tf/rLO59yDocMESRcm47dOtlyntxnyldsBHMMMPaojmASehhQMDWHTWIP69GqOrM0xIIzgf6rca7JKNgajeN88dTS4PGvwOcVKLKUB+ptiSQ3Xuq2P4irBnpwZC4yXkf3w99pRs2gmnrnYDF+wErW0VAJ5r5FGpl7xM6qjXkkkREXDbvTRmsNYYm8kDSTIxvH+vw7giIjJ5GNCJaDrOe701j8d7c1LsVfPInLBkLdcgUs+uLs73O7+3ej8wHneazjpNtqnqGF/WthJNxoygYsgOVicO4ypMBclqbISDh12k8q6zXMBnHCDexo7mV/EcSp1gikmfMFYfbFGG1Ic8+vKLDqNlb1HCzcEjD8JmsHDwM7yJE+vz/DnA/Rf1P41QGOVQpBpR9iE9Q11Syqnn8Ckv74Z7NALkY2qUzsrrKrrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(6506007)(186003)(53546011)(82960400001)(52536014)(508600001)(110136005)(9686003)(55016003)(2906002)(38070700005)(38100700002)(316002)(91956017)(64756008)(76116006)(66946007)(66476007)(66446008)(8676002)(66556008)(122000001)(7696005)(33656002)(8936002)(5660300002)(86362001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?29eiWrg73TgsTXofCQPKrlHmhX4/IGeAKPfuPPj3S1dHkrfY5vuFDUOOCIe2?=
 =?us-ascii?Q?WL+YZxuHP/C1N82fVIFyOLYYthL4bfEAxkbXo2JQoNkTj9ZxBGzHKQGowzOD?=
 =?us-ascii?Q?K72F4wu5JY8FAzwYJfltwoXCz65sOCDwzFo+1qZl04lZKsYL6/f5oeoQvpjK?=
 =?us-ascii?Q?uQn4Q7Txl/I62yS0ywl08tHxRlhcR/Bv4vu1p8RdxVMIt/pub1Fmm9v0DD7Z?=
 =?us-ascii?Q?EApWRtgID2KoK95QnSuvh5oWB2sqMkWlViDccA4PgM7kNJfkQdys4NqZO+mQ?=
 =?us-ascii?Q?5TISh81qSm5+BsRIaj8v6bbrKQn5gBEz81g/+V2FRBb2iHK57GMeHjezaywB?=
 =?us-ascii?Q?zdcYvNErxh3/Inw8N5jwv/z3UcN1mdGYzMuACMNS10H9RajJ2CS1oPBOJ1oH?=
 =?us-ascii?Q?JVeMHCxvx/ez2VRzzkHVfuUEXcWFsv5tq+BkbaPrnkPovW+UrhLl6oO4yobV?=
 =?us-ascii?Q?RpYPxA0CRKQ+lzzURr8n6RYvoqncgesMBrsDFclfOayGm+jt/y7Huk5XJn5D?=
 =?us-ascii?Q?x4hMER6ZiOO6taC1BzigFtN7DUGrpr2HFFQdW3X3nGhZpI8WEakCvdpOwREO?=
 =?us-ascii?Q?qqwI+Nj/3Tdkp+ntMH1YzmB0OQB8fUfJDZTI7H+x13U1imq3gPHg7ywVkc0V?=
 =?us-ascii?Q?wV2BQKT1aJWpuaCHeFxcQR3OVYshS29Ku7y5cecRSXToqeSz5VmQg1HVNdiY?=
 =?us-ascii?Q?D4mA1k3QbjOW9O3zS/kSNHb2Z07tcG5BBfKVniZqyZ1lPsU1H2zBaCj5mGyx?=
 =?us-ascii?Q?UTi/TKlbRMVSkk6x9/g5HsFsKEQeGROSqS/gsMK7Pter5xuOKLAJcTeTRKsS?=
 =?us-ascii?Q?e2/Gcaap9+rWHLZxcFAJGiu2Og+mg0BHfNOhYE+EO58kClYYNX5FZnYxEvxZ?=
 =?us-ascii?Q?dv9Ea0C/vfyVGZs3vdxWOXvDynJYYiRwJ/8v5GWkJEFAb7Khl6NhrZAQemrS?=
 =?us-ascii?Q?N1JZ6OnIbJBKbE7wOXYZj+B1kqqrL0cRa2e3unRZ3yIEIBTJSvqu7QHFfSt1?=
 =?us-ascii?Q?Q+TsFj3MUDMcVo0f60kgfQDWpKQK6R8mIqglfOmRp5Lg8Ef/s2lXID/Rq2sq?=
 =?us-ascii?Q?Z+8S/Q4/WysXmd+3Gti9fuYpD+ejmkQ4RAEkpfBu06N1icssRmgYIahM4Frj?=
 =?us-ascii?Q?eeriC6vex8sJWmcddL4ZOSe2mIsquRV3HRda07U4IBlgHCiADQu5pxEvF8yo?=
 =?us-ascii?Q?FffjcHd8Eha6ZGhxGxKuLkoXdFdSnXUNsYamY/XilDKbSegw2tn5FwZif03Y?=
 =?us-ascii?Q?k0WfKN4A9kq94VAE/zV8fW/A+sHg0t2rdyqbbAPwyHCA4T3fIPA1Q9sG72Mf?=
 =?us-ascii?Q?wetv5kbXs0Ro3sRWG7C9BijCWeZGx7GuBRl5nC6oKZQ/5EG34Nktxrq7QiRG?=
 =?us-ascii?Q?lTbYWitK/1QzH0KRNH2WVD+Zh+ikXhox3pn9EcbqUt+CC3iJfQjBbU16Sk2g?=
 =?us-ascii?Q?ZXL23/pduG6YGBtXcWCtf0jy5PZ5t4GmiJ6LKibJN9AqjeO2nRh/HpJP+acM?=
 =?us-ascii?Q?ucUf7cZXPulwE6LeL94EZZlASplanMgcdBupPbr0nRVntlTJs69vNLCPEfPZ?=
 =?us-ascii?Q?WVgbPQNxGaS1Xn1watPkPZlw97T+EqDw8+uMTOAGOGlJRCmzBVYP8ue4Nytg?=
 =?us-ascii?Q?nHjsq/50xBFgaPQTOJkloFk/7WiItdU8zT67A+9Y2/OSKiDJjg9mXsaLSq9i?=
 =?us-ascii?Q?4NiyxtFvwcZRZtHIOPooUopwVDUG8hhPHWElw5FhO6t0N5Xk0qEW2aZSt/zt?=
 =?us-ascii?Q?W5VGTHUOxbY09/FNLA2jBn2znfrKDENd/VsUVhOGXINxhuxl9t01r2AST6In?=
x-ms-exchange-antispam-messagedata-1: +nui6E4VymvWalmyPcr9kxM3daV213NbjlfPnmWOEB8l3O9UyuvdPwlz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f55022a-ab05-429e-a9a4-08da37da1caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 07:51:54.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJKRxl3bcgh3Plu9hSjG96K0iegIPC+Cx5TbyT1/YnwLR2bdw9kABSfFTCk26vu4qeMTcyPNc/f3gqmeW5sWdJhYtqa9BxH+3C+PMhwwWj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7133
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 09:42, Qu Wenruo wrote:=0A=
> =0A=
> On 2022/5/16 22:31, Johannes Thumshirn wrote:=0A=
>> In preparation for upcoming changes, move 'struct btrfs_io_context' to=
=0A=
>> volumes.h, so we can use it outside of volumes.c=0A=
> In fact I don't think the naming itself (from myself) is that good.=0A=
> =0A=
> It maybe a good idea to also do a rename here.=0A=
> =0A=
> I have some bad alternatives, but doesn't seem better than the current=0A=
> generic naming either:=0A=
> =0A=
> - btrfs_io_mapping=0A=
> - btrfs_mapping_context=0A=
> =0A=
> Thus I guess the current name is chosen mostly due to lack of better ones=
.=0A=
=0A=
Yep but I'm not any better in naming *cough* btrfs_dp_stripe *cough*. Maybe=
=0A=
someone else has an idea.=0A=
