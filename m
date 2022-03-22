Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3A4E4537
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiCVRf5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiCVRfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:35:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DC377D0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647970467; x=1679506467;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lxmw0toMdUl1HiQGMz+OHmynbUFAlC2lPFpOzZgnjgM=;
  b=khATFgqxv9xsxdZWlhlWjoV0xAwR/cnLt9n/mpRfHG3D97tQTcmBEKcM
   Cu46TpgwBvVPseEtEfcQplz12zBus1LI148oTxmWUaRKWITAT9RbQ62Od
   AOHid5VjpOhYUxqxTWt+cC4AI2yOG3c9HE3MFzOnZXVnFKdlscBtjRiy5
   UhWUmjUvZJePk0WPVBldSk1zdNz3htvVD5Xq0nScq0y3iZJ8s8wbdjibs
   8l2XjjPMsNZBJ3Ch7E73h5DVFGLt6dYzGlVYKh6MfnMPNXdmo+zVXUPAB
   muHk5j95gVOaqpSC/PcSLXDe/3GoxyfUQPoLR9ucOItqXcan+twDkE55c
   w==;
X-IronPort-AV: E=Sophos;i="5.90,202,1643644800"; 
   d="scan'208";a="195986767"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 01:34:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2A1u/rqa/CF2/AV/6+QYWpREC35lO9+wmxJ0MmuTjy0scMKOJ9qpgVsqa+tmed2cHNQLKmMBFiH9UdrFstvq8tdSmswwaBhP3AhPZmRLQm00YQ+iE23XlJa7D3KYVrugyyuL/1P9VOK38gf3WSinD9EchSkQ2MnhNm9kaKGxef6ruslKWeufP7eNaYHcIVti6Rg92LF5JaP35GrW36oSg54SFR64+UJCSWw4utpPtV4HNP8B9dR+IN5Gp2URWWQUnfEFspAnngiKIQHXuMTBZDrO2J7m6M/mv5B5PB64QerakOg5QhKrS7DLLJYz2c9g1EOV/4lpV/nNCFbopYBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwZEnfSNBPbgNAQNMLBtuFfTQvl5gwW5kI+fEu1VWYQ=;
 b=SnXoAQGyHUsf/z4+IojdJ71UPViVHXgkQyICS4yEgSn/b5FCfg/BvZtaEF3NedVzxw3I3STkYyODaO+jDIm2f7p1skyIeL+lTbp5XPn1dkZCJ6KcKeD5C05+n4U0D0WIMHdYILoxznq7rF4Hgoykrqz1oBtsv/UfgsKuYgl/SurfA4AhaPnY5nuUE/9QRHwc0Xa2VinMNokzCgsGLlJi97Ic1kPmsUgsbVDdSdoSP4ubx0HpPCNM1BB7qgvMbyLQdPWAb1sw8pk6DL7qOnE3MKjY5Mc9KAV/H23lOUFmllD2yBlDBhoJPI/2RIdpeor0xGjSMo/Ff7S9YSoMLqXiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwZEnfSNBPbgNAQNMLBtuFfTQvl5gwW5kI+fEu1VWYQ=;
 b=xdZ8LUHPt86Z9KUmZHlO+VYu2647n9fImoYgup8zCrg5Puq+Q1LnUNm1g1xkaPaeTwLj+JpAL/A36ZEGPx8j2CdTmRr/4nn/t2x8mbLAExn9XriaYrRrk7KK6Jv0Oc3LKkQ0S+EN1dkqybyhWGu5xMUO0SZOrTYxfARqIJOn0x4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5835.namprd04.prod.outlook.com (2603:10b6:5:163::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 17:34:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:34:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/5] btrfs: make the bg_reclaim_threshold per-space info
Thread-Topic: [PATCH 1/5] btrfs: make the bg_reclaim_threshold per-space info
Thread-Index: AQHYPT6/GLOc8fBrcEGFPEdGXfVFXg==
Date:   Tue, 22 Mar 2022 17:34:24 +0000
Message-ID: <PH0PR04MB74160B74DE69891C707810F19B179@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <63d4d206dd2e652aa968ab0fa30dd9aab98a666b.1647878642.git.johannes.thumshirn@wdc.com>
 <YjoIPZtKly5+jBfV@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28cba861-1637-4389-7232-08da0c2a351f
x-ms-traffictypediagnostic: DM6PR04MB5835:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5835F1AFB4773E758CD9BE029B179@DM6PR04MB5835.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scXH7viUBBrby+JLVB+fp6fZ0ElRexzMJexs8u3jVoOExES5gYYZiNNpG8HF752AULX7nW7IXdSSacvElQSgMfJ6c+Qob+9FZZXQ/RI6oCQetafdnd7V9V38IJ6hs3dVSzJM+CHvjCtxnGjQS6u4OT3bqr3olk8fTIPhrzMXSyUNn7XnqRh8WYYWvQHhanHYxDncGPE2MNdkkmfC8Op/h239s2wOINOEtXaisUBJneoE9i6hBd9FZ4KgtX6lvXoEkNc2sgXSyZAgKbMQABlpsrCZiCAM9QVcAWPUFkycWzN0akkwdlbKpV3Q2WRF4Vw7HR9wkZf/QwEytRVu7EcWe78ruCmes0xJMoP+Dkt47tOKx8JebS5GDFWKFJG2otrm/TU0ptDcw9tO0E8VayGW1wVqEVk6lIVdRIorGOmxkGOQW471oTddsXeY6ZTpfEHhBuQ0I/uS4cmi6Ap2QN2KQgC7VwW1BjQx9jRRFN7Hf7/Y9Z9YMHhCbTPFzJdeGSkN67OQKMbxKNV8a1faG6TXL7enZsKSlF0RMM0MUuZVee4XNGaZrSi2pTENw8AKlmKGsAZ3ntyCGMdQ1p9VS0ZS7IiR5Jw+LUHhtsA85nmpfu6z4FhtKMMMftKDqXnMjsppr2F/U1C/SX2i5URC8M+CGZM/jUPAanzfYl1eUwC8EXVFzMWT4fIMVRKX3lkZ/BaYGv3mOUzWX4xn1rvowzqyvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(66446008)(186003)(26005)(33656002)(8676002)(64756008)(66476007)(66946007)(66556008)(9686003)(55016003)(7696005)(71200400001)(6506007)(8936002)(4744005)(38070700005)(5660300002)(2906002)(76116006)(82960400001)(4326008)(52536014)(86362001)(91956017)(316002)(6916009)(38100700002)(54906003)(122000001)(508600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CJB2x1rMIFhNGFspDccZzx1+Tw1saScpP0giipTfTKzzb4SJPYEZtR65BP8X?=
 =?us-ascii?Q?KEDb1G5EKp9AMN/C7if9MMf4GE2lz7MYeVYWtUhcqsxrvUi2w8pTtV/hNP/b?=
 =?us-ascii?Q?d89onyYdivjyYGEvA9HjI0eVsTbiNsRGWvwT5Fz1TtYrkY8oB6j8OQ+A5qEp?=
 =?us-ascii?Q?vVvKuWav4gYYJEV0qC4mSWWJYEF8bY9oaseAKbJZw6XSBesEcX2p8cZmFSOl?=
 =?us-ascii?Q?A9y0fzglL91xZxEWDQxs00jTcMA8gnSm2fuqV/O5IIf4a4NiFEiXalOXCap3?=
 =?us-ascii?Q?Yh5NX8KrXmOE6LD5ImL3Zu76H2eix+OCC90g1CBFTyCAmr1rtdBs9BNnenUN?=
 =?us-ascii?Q?5w/g+GKRutiQTu2zr8nT2tOpPi30nWGSbhYSkiL2+Jcg3C6TQt9x2AbVd33g?=
 =?us-ascii?Q?JvBxEoy8D43vuHGCa4hfo3McD23G/UXhZrSpcUsisVKWbR33XFXsRWfecJQu?=
 =?us-ascii?Q?MmhjACVLThTObI6uoC83f0xdUvdBTDpSrdE9NUvjSE9OFM/Qv9wSty78sLcm?=
 =?us-ascii?Q?sQ94+PlZEBJIGg2LDxLeMQ0qZP7D+zK1NFixi+Nn15+mBZoK/CqY+1NdTvwS?=
 =?us-ascii?Q?hKofNjWiZsATwzkW9wDS5VPyuS8argX30jw3UioWg0rs287cTGZvzx8Q28dN?=
 =?us-ascii?Q?xrD8ZgHgsCLMC8171/X57W+xXHeCZtwz0lWpjjCUxmBar0HPVlrTklLkFOFD?=
 =?us-ascii?Q?ExPK+aDsmy7at+YjwGGu5F9AHHyIK0ZqQQ90GwkqQCf1fE3tBMY+JfOYV6DE?=
 =?us-ascii?Q?c5JBaaEuo2aPtscGjX+uMXyJ0kSJXGLsHrckvyDRgmwuTJQFzkATbBYMNoKP?=
 =?us-ascii?Q?5kqZanInMiIBy68lSmuJBO8ckIe4MC87l0VGIanLSATbhEPKc6JWF6vQbavT?=
 =?us-ascii?Q?z8667O/Y9SF/bFKnN0LdzV668Ucn3VuDGB3CKONgHP0bcx1QwGhggGCzSXGI?=
 =?us-ascii?Q?6EYwQSbx2eoqhGCbTuxhiMe4iGgYovP2FHRrEnVnZaOc7PquRjF3VcR8oejF?=
 =?us-ascii?Q?WiF8/tSL3T70TLoikzc0U5zofXnbcEuiI/l1DSxflkvjNHYux9wwlW/dNVZC?=
 =?us-ascii?Q?4QTlJkPmssWqxuPpuUkIGlm4b9jrXzxKM4y7/aOH40CjPIcoHzARsGSmOIq3?=
 =?us-ascii?Q?17w2UFBBErXRzzIwu7oqBaxQdxC7ss2uMMlhWIJyGNFIKz6pVlRVEE3Aeoue?=
 =?us-ascii?Q?vFKteZ6KONqZLOqyDUj0BFSUuyme7eBu/TplWv139Cjev0JQzoZwE6qqfmOt?=
 =?us-ascii?Q?qBQ5nzUbKz4Kd08Ic4aJsiuAzPOD278vT2DPaGmh+au7l+kSqAgGTy3w10/L?=
 =?us-ascii?Q?H+qAtKg0e2N54o0BNIufYqdDcqcwutK7SSsqWVGdwFf8sGmcyOTsLtjWtv9X?=
 =?us-ascii?Q?WKxJzuSdIFiC40ATidNo9WrYKGazyws7MM+an/ktg+uLnUq7ie7vxtL/UxFg?=
 =?us-ascii?Q?2FEOE1517QmY0x5qFMFpqoRfwli4/NZr8OxbP7Gr/5CXV2dQ+vF4Z+mG6pYD?=
 =?us-ascii?Q?yrqn0dF+I6YvtNA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cba861-1637-4389-7232-08da0c2a351f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 17:34:24.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYj4zVD1GFSfPhWilqdneJmmQ/vy+L7e19vf46vqg8C7hCFT21xMrOlXN/MitJstcjFOGemR1vh+odD0xeLsizeExPoy59+arbdE0JVIbxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5835
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 18:32, Josef Bacik wrote:=0A=
>>  =0A=
>> -/*=0A=
>> - * Block groups with more than this value (percents) of unusable space =
will be=0A=
>> - * scheduled for background reclaim.=0A=
>> - */=0A=
>> -#define BTRFS_DEFAULT_RECLAIM_THRESH		75=0A=
>> +#define BTRFS_DEFAULT_RECLAIM_THRESH           75=0A=
>>=0A=
> =0A=
> Looks like you added this back by accident?=0A=
=0A=
Nope I've added this back on purpose but apparently screwed up doing so.=0A=
