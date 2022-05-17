Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3A52A707
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350567AbiEQPif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiEQPiX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 11:38:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8704517F6
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652801851; x=1684337851;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=p4OehKHzxBwvHeXgGyDz/5MsjD6sAfBn/Y9o6T+qEqAmmmhBixPfhME8
   tYqKwIqchtY6CPzW2cah1YnV92S3B23+LvKHj/817NwXJXzGdVsiKXagd
   uGFqJ7eqX/duDj0uaJ7T4wSaz4p2QhY7R6VdVnfDynKLVLZdr86JXHMNf
   ZN+wegYnuAtdKwFWyuWSM6MpEpn8YE8f1DhJHMERVnz8fO3xJG5UTfTDw
   MFX3z5fgWUIdFzdGHwn7JNZTii1z/XJVcf69PnksatllNpEo5rdrwHJJb
   emRaQZY5pQFX2dp1rGk8La0tWaZjQ0g1TKJSxVudOdDuKWifl1bOyYGge
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="201430343"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 23:37:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFLiDeXXZQFmPt+2GZNfyyC41iJVqc+MOMutfYKopyvgxaGnc3Z4e7k8rwQnn2vY6x13Tcimdtv6UKg4qvDxG7b5lhENbkTrpf3HMVQ5t8I9uOd3CUJSnB2KC0rXwczJz7uDsbR54hSBAzv5TA3E0x3keyZ/bseZIrk4IlTUKiMeJStqtma9yTaHiYGe2XY1de8t8g8g7L/0GqDlXZpUHuxSbQbswwotIBlua1Ks83kHLjM4mt906R6nBvObM5/5R7nK1w/92iRA5Jv5WXJ8anY14d8HPypcWpPt7B4JiIDT+KvCU/NvQIgpKinLZC+CVtC4kRvvnkFl8IEeHfVkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ped6+bAENKE662QQTkrjKAz+J5YZc62rsNq+JT8A3QL25hOORBdOsjsVOvfsiEwM76tCXsHANb+8JISHUnUFljrW5ueEQ+qxzWtC7hBXUI9GjRX3nFIriNC77ftov9VVfJjmXG1cV5UnxR84PaZGRW7yLFlf7X/uiQ40YHziSqw9q25dQZJITdZjVw4F0ecdmFpqpFeF4viTRzuof2nOa2oahDB8EG8hKRZpTOX4nqCnTU6NBzbAjhCUqOW/y3pvCAXFlMG7s+HPQui7WMCK5iUNTBrAQ/YA/xGwsD/Q/8XB4DIx5gH8nOKGIYCXd6nzd4i5162d6suBGB5Cj27BTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=vvP4nW8ZXdRoSXJxgFaqOoTBuZdHAvGPs6feyTgBVwvXJsRVyvcovkkk9g92MvlAhsHKpiZkUfwCU4XJdGvHPFy37yz56F9RTDsW5PMGtavyCqQn6O3Ab5iFW6qlNIA2AKZ47BjWBHenSpZmSdRYDiXvklFML9gQMRXTxpJ9ETY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6251.namprd04.prod.outlook.com (2603:10b6:5:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 15:37:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:37:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/15] btrfs: add a btrfs_map_bio_wait helper
Thread-Topic: [PATCH 10/15] btrfs: add a btrfs_map_bio_wait helper
Thread-Index: AQHYaf2xJI+nyWP1REGqwO9t1FLjbA==
Date:   Tue, 17 May 2022 15:37:25 +0000
Message-ID: <PH0PR04MB741680974450159BEF4EDBDA9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea66db5d-b428-4448-b3c4-08da381b2495
x-ms-traffictypediagnostic: DM6PR04MB6251:EE_
x-microsoft-antispam-prvs: <DM6PR04MB625148EB63285BB255492EAC9BCE9@DM6PR04MB6251.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAXUHGpCFGAOcgda/HVzvDODIyo5GqmEEJda8U5GDR+lCtOw+dyPjbDJSjb6Wl7Loq2pwO/1EU82fOCz/f359nRMMJOj83J3T/g3n9XeTpVbsPHHjg95Xs2+JzphsYKBjyQCuVWfzn/wJ8pM6nvZbNT9XmML8l4szNyhplZOzCMgB3aTB9nG6PQd1fBfPXKC5BOnVxRZ8c6c2r7GO9sR53cT5t5O/T/z8PsndklHyzPkjREnjmMZScG6uc23HwMOBm8VTHuhUyeZk6z7jME/MHZoGZrnKgYXz1cTZSjG7waYSDgFAio6pIjT2QyEV3J8I961bRaiLlNyQsTU0eOKkqDy/mr/XagewUT8nDcxx6V4fP4r0FLuGFVenrpgECoe1ULHTD6qfgtcIdXZ917Bj/n4hza5Yi4bpGAOp4k0e5mx/ZDpGdLwjPjaycdfe8X3RLCKrJoE/9bSADH5hUtp6sQpEcbXpzLiwCxQbYJLemRJV2npYFLFhNgjrCIhN+K+ytPTYKlth860zWB19WQeV9E9KPT+bpsk7FB7InTXXPeXWN/KZLLTsTYDoIF9nf602dtsqHYc+ufEUSBHHlQmxsJzftOAG6p/71hUOWsgRyI+xrmTrVKEaUd5FPeT5WNuRZZa/5Sd0buPFRWUmKandvGw4gWwVGa3ycf8l2i8tEigIJgX4Sq1MsavgEZqgQdYwACY8ydNJex/hRNbcoxNKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(66556008)(66446008)(66476007)(76116006)(66946007)(558084003)(4326008)(52536014)(64756008)(5660300002)(8676002)(2906002)(8936002)(4270600006)(9686003)(71200400001)(186003)(6506007)(7696005)(33656002)(316002)(82960400001)(122000001)(54906003)(110136005)(86362001)(38070700005)(38100700002)(508600001)(55016003)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EGel5rlAYNWw+gNIPE1L2QhUMCINUQbnqwQNPuj9mOkMu98YO1Wvf7J2zHp9?=
 =?us-ascii?Q?+f5yUozZYXI18+jE1oU3FvI07HNP0rsb6LqyZfR6V6kY7xg5mYyEJO3WXIx5?=
 =?us-ascii?Q?O0FP761v74vv88igbU4Kl5ScVMuGPseWZeQyKKEKqktD6ve89eWQkRhCRuzz?=
 =?us-ascii?Q?xfVlGEYw27LIJjgdQExObuj4JrSlLMOH5McqJJGFZb0wcrs8EIDsN3d3YTu2?=
 =?us-ascii?Q?dMFJL6AFGW0cmlp680aTq4JqChlD12xJA/1QxxysK1ApenrVMQt3PYIhUZIo?=
 =?us-ascii?Q?c02IMcnSQUl/Myq2pZv0xwTtxs3+AD6QHLMBcI8rfc85Pe6asI0Tqn8FqqTp?=
 =?us-ascii?Q?HGTxrKhIX9at3d1gspELq4uNnF4rs2ANjhpX6H0aDsZ09K2137GezUCKuWxA?=
 =?us-ascii?Q?yZAXd+tHXgcf3xbHQProfNtGkG4yrVtw5LuITZ0zroZm7pv3ln6YgI1HJnIm?=
 =?us-ascii?Q?Pva/br9QuiaYPesKKmtYbSjSgJoPiiQOnXXZ9lrjrDj3s3muYTbB21Za4Wfk?=
 =?us-ascii?Q?WDTn7ExNdiq2d3k0C+yxc0vwCtNfBKF3E/CEDY+hAQSbQ3G0c0ykjJPe1ASz?=
 =?us-ascii?Q?2NNiAwMJWjq8DIZLW+OnYUDkkC7MZgf4jg7fuibGv0bBbGgMB/PM9k4CxQGy?=
 =?us-ascii?Q?lA/n66G0soXK0XBqaOo76lpFqNfsSE0YitevDP7Kv3z+UmVGXctR+YRHQyKu?=
 =?us-ascii?Q?pA92Hno7wMYMWpWOtTIrKniYKKc800glszz43VQDqZ2vtAVTy/phwahrY1U7?=
 =?us-ascii?Q?Jh/ciVW0XHlTv4QG6GfxI/TRotVwK8X0YMyl1b3RO3K0ZxL6pyCGd4BTwirh?=
 =?us-ascii?Q?lp3Xf35Z9z4G5ZOLSiy6OZZFK2bxHDDVv8zxdE8LxFmqH2Lz8CFlra5+IJmE?=
 =?us-ascii?Q?sc0k/IdPEC7PMJvxeh+dqG2xRxfONHa6AoCYlBo4/HEW0TfIvIIJh6PXidfu?=
 =?us-ascii?Q?5NNBQ6JH5slmjVUi/0qZF8UwrbJiSAJB5w2q4BZ+GRLOCiCZoBo0cwjyj6Ps?=
 =?us-ascii?Q?3DOmrnU/jSbU+ke0u8qWiqz/mKVFwriHVEYJKbhBe3sAuTAccRMOOgQ7nnUf?=
 =?us-ascii?Q?iEqFtGhBkqsjZ+V37ncuUMBgBymnEN69Mt50UVpeG1EKv76GSF4m4nsSqsUI?=
 =?us-ascii?Q?fJoHG0+t4S2Y0vedCXD2waS4easuCsXcJ4QsuiBkOJtGtVYQo+Dr4NywUcXL?=
 =?us-ascii?Q?PSC8LCBIdQRHnvZvFWbmNNweUT4A4fY0jiH8lGk53/Rh1HiX7Mskj4UrjSgc?=
 =?us-ascii?Q?iK9qm0jqlYvrUkt5NIpMWlU4NGOzs1oFzPKvkQ1duPRGEoF0soULlWdai7Ah?=
 =?us-ascii?Q?4uoRFnzD7+u39w7I6Z4BlItlPgxWf6idT0PaMmYQxuNeXvapFEP7HypO7TPR?=
 =?us-ascii?Q?XNk05Mv1z8N7q3chlacmLX+0PrzCuDDHRYBI42SauJ7oMJ8t2MaAOF+05Eb5?=
 =?us-ascii?Q?bivfSfnccWxBvPUm5f4CB/Ll9PuIJlx9XlFA0W+r4tQorqZoP2HkPZk/5Z+V?=
 =?us-ascii?Q?H9N5tdjqkO2rdrEm+6yaVTaAhYMUWSMbiblv39HHGKnsGirltrr9mruXgV6F?=
 =?us-ascii?Q?PgaOpolDih+ial4ijMwTXAQ0HL9OTHc+vvI8ln/DARD2IWX4RkLd5R7yViDU?=
 =?us-ascii?Q?DDj/ngLIzEGSpRvogOtEf5144BEAWFK80iWbsenRk/EY4D0xd/+Dx2oD4jaI?=
 =?us-ascii?Q?/29F4pcY0PQrG11reL6T2IvU8R2h9vbYYGc2+HkgXRlJG9NyWa9yej7H1fp9?=
 =?us-ascii?Q?7kASpFJvuYIj1GYZ+9P/UXQMAc6oslTfwp8DfovzsjaCNHOr36IpKvaAsX2H?=
x-ms-exchange-antispam-messagedata-1: 2Jng2OU1ZiwdnE9BZUgxq0gzHjDvP4b6O7WvHfEcD+K6f5saNt+eu/ZJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea66db5d-b428-4448-b3c4-08da381b2495
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:37:25.5097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hx+qGlQi5zZUZ3M9AN7YHMLtCAxoczhzswaCtFmW75KlNOgJ9wyS9srIP3RXDqkwStBK/Wutmp5hWAVtFzF4jliBEYkKjU79NdLf3t6PgdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6251
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
