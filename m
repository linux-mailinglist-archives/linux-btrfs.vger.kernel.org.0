Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9C52A587
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349552AbiEQPAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 11:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiEQPAo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 11:00:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A91BF5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652799642; x=1684335642;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bLq7S2KAfNzVhaxwKQf7oT8OuZOy3GgtV0gWgBSiTqORieW++uhZS7Uj
   CvMQakmDoahLsu5zxlHsVi+BFoNDtQpICA/Yt+IQqJYt1w1szMbhleYjn
   wYczuPOZwATDXLbh42EPzXMWYOE+5PKPGw5YkIrrwcKraqQavlkQ+iNNg
   O6bl2Wg8ei9yIWQhEZT/sbraplPp07YQrMQ5It+He6Gla49p7E5Duud5d
   baVJ0hcurFU6hKIHWFug6Jt8RJpXpucjbB7Q1k2o7QKKaGeGpAbEha+8A
   2qgtZBqAoONjXo4YYCGY9/UDN+YCiZWJ8a1AlgRXvRusuvvChU9xOqyka
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="312547754"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 23:00:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXYarTVXGxErrG+H9Qk+J/kNne/lfVs9eD9rrJW5fPsyMz/Xng5wqw8B4z+rIonYs9eRB6O/zD8ZPxBglAxYsYmPJETCbhDWGSJbN+A9Q19dL+44hruYgXSHK2bQGxQkJIgr0y1Z4mP/Ap31VbME3/m+gnXhx87Vd6kNKcblAnSAJUtoGZJnSlNYRO5l5WASevuQdWXsYUZm4zcwhOPK2p1YmkcIFyt2pjnegRiJIO7VWsCrQJN1+OPKbTma8kx2S94Cwgh4Uy6eGtOpTnYcaLel4IA60EKz1ZnhYBA3Ozyq+TWmWAZVqNaDlAON8oVGcOEhApjPrUWESEhXp4h/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ixSL4bIehH7yp+0iNqZsGmPtDf9mgPChciiI560mG+thzNI36doFlrAoQts2aU+QtNjFGF4D/3JrP3OrMuRd94ZQKYKklyvgr6u+TcD1tjmdzYy3cOJ/NNZ0Yd5uXxu097IlGVjwbgwOcLsXmD+cZOzzK5fM3zBcZqXRfDIHJL3HM0WGmbCReMAyku9iJQ0z732JORbTkxrbMfeGVVa/5l0UXpbnG46RqUdcS0YsRtAm3X/l8EEtSZXFAFNCZ+bo0kelHnX2UyNyiTc87Uz8NSuHJkHklvTBjPOcPefFPm4ALJ1oDztaZ0T0+4ZL4ru8pK5RDQUGYtdKLzpIB4wCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=k2BU+287IsD8xdd1UzpRQusj9bwsO2dYuJVRMY++3z0ekEM0lbBj5AKWJ/b3dOfbhJ/v5D6KDlN7Oyl0ZUL9A9/3KGkuqmnZY4Igoqv83RuBYgGwZhejTADkHb2Xp6oZEzDjWf12Nji8xTENokDXpcHxCbPeyOwPyiJEKUjYkfs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6207.namprd04.prod.outlook.com (2603:10b6:208:de::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:00:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:00:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/15] btrfs: quit early if the fs has no RAID56 support
 for raid56 related checks
Thread-Topic: [PATCH 02/15] btrfs: quit early if the fs has no RAID56 support
 for raid56 related checks
Thread-Index: AQHYaf2aUxRqfgGkAE+eciiiYSQQWQ==
Date:   Tue, 17 May 2022 15:00:24 +0000
Message-ID: <PH0PR04MB74164C70572C8C36D31205479BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cea4252-c65f-4284-9c07-08da3815f906
x-ms-traffictypediagnostic: MN2PR04MB6207:EE_
x-microsoft-antispam-prvs: <MN2PR04MB6207EE4B5973905BBEF4D63B9BCE9@MN2PR04MB6207.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ocVHiyOvhA0eEwxwyZp7nuq/oypqq1RE7+nZ2EHTihYgeLj+UypsHC0z7qV8a09c4E5d5f0by45noXKw0zggDhCQG0H/Xsh6rPSSqit8wvM4dO9ye5JxQjNo9f85olRfsxL6CA/qteCdf8UYu+/YevEk8UxKQl86mUgif6IvWDqfiYnsHtb8y0bQmXyPfzNef+cWMaDvFkkZfYAQ14ua4/JokImoJWCCiTfgqMomjlb0vou4r+ti8jyr/v8DOys5C1Xv02BrmSXbu6+nPTJ9lo63k/UESp7aISFgN+Ez25ZgGsf6UpEZRCPqrUe6UUg2BVFWtKZxkqGTRvQalvAffpGbpGiU1/OwtsCFeOxgEj4VpkSRZIEi4yMxiYx/XCH8l4mZlUHLjSwDwyW0scw52zDBNyxNgXKDxhB6p0mXEOr/C7MG+ue0QEW6wbT5bHp2NIbwl9/03P2FwUUONQzyWwHYBWdtLwYt8oZybq2wOWqJugo/9szlIkAe/yFJz+eyl2z8LJLQap+EQ0yf7qeXWafTZSGDQwqk+gRfFAPnOKpo61b3hMKQzGAcfit00s5SzLMtlfUwlD9IWYf1TZUDrO0TaCG1Qc9Fdi5HObzHFilDp4GH+/axeYQUZilU/zWt69Js3WcrDtmmYyd+mIIfFUp7hz0x0GRwVEb72ehpPYfkczBhoWdueZr42gJoSHbIpz5O2HcUHBVDB72qw10geA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(55016003)(508600001)(52536014)(5660300002)(19618925003)(558084003)(86362001)(186003)(7696005)(33656002)(4270600006)(9686003)(76116006)(122000001)(66446008)(66946007)(66476007)(66556008)(64756008)(4326008)(8676002)(91956017)(316002)(38070700005)(38100700002)(82960400001)(54906003)(110136005)(6506007)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?abwedj33+Q07MKCv6h6Bk++5rF/+Phh5UvwiLF8ctuySd9e8rVjkTu73OraW?=
 =?us-ascii?Q?DOtj0zLTktmVbokMxq5MNy+lZwMnWTX2aORQoXmLYXeN/fOdGwwo4LazsNVS?=
 =?us-ascii?Q?zQcjX5EYul3LQbLKV8+c6PRHHcFQjlywiZpmLJw5P6TwcRRo3dCYkaifUQ5S?=
 =?us-ascii?Q?ysl7s7GM9tcqW22G0UN5vy2MVRd64M7z86iaCQEJ//Wzdw7+Gm+GWEFtOpRv?=
 =?us-ascii?Q?jnUrDBpdObKbk7d1XfTupdSaQad82g5IDhX5yknzFbe9DlwCfgvseLLmhlrz?=
 =?us-ascii?Q?CdRS0SheECIG6O38iT+4bRjPuIiDOJ8o4e+jvFFZAiOFNPfzGoOEHQ2ChwCS?=
 =?us-ascii?Q?PCDRW2MCSHhZf7ouCoo5EZ/Rz1q0DxD3iOINoFgU4feukSEPNTy8AcOF7KxG?=
 =?us-ascii?Q?CnUBCPOZEhWV9SRlXA6FZL4vxJDuTJY4NhsYqEm6PdO5wnMIxKBbkbtntVY2?=
 =?us-ascii?Q?vOy+l+O5SZkLhZvCs8CA2itNf9PhcuBf9ubwMV8e0Zc7aSR912O8oIOn+0oc?=
 =?us-ascii?Q?2WIUyYSLi9/eTP8PQVnWVgps6GQP3ACuY+LBKjIqPVb+byZb/hM+2u6tL8eR?=
 =?us-ascii?Q?SLdEFFAllRzRzyKRxVWuzZg7Q3W5MpQYY+XJ1Se5/jZ/hXBmdJqRhwBcqb+u?=
 =?us-ascii?Q?ilSeBFlJ+ZCV5ppIdyLilHC4FQhIA+CptvMDsqOsLnw6ibDit2yD3b/Ou1V0?=
 =?us-ascii?Q?xjo1jlhilmikEFcoo29yrZrCh53jNNNSRWuk3PLk17NQsNwzc5AgLFjiuoO2?=
 =?us-ascii?Q?yVjzAvnytzxYTvAHdmXl6gQ5QuCRyZdV3P/0QuhSvfJBQs/FhpREGvUAoXv1?=
 =?us-ascii?Q?7XqiGgx0WrnAbJfyAjs4bqE7WiSOEAdBrPm6OS1Mw3Zut4ethyIRl9SD2MTA?=
 =?us-ascii?Q?TBaC3Ryg2b15effmdFmWF40CYC75hPPPdxH4UeZlzloQNpvxALzE36YPOQls?=
 =?us-ascii?Q?kpHVfTnLObkQCOON3bhzFJVRDlmwKoytRVs8kpedKjV3wK+8gCIkyhyNauQy?=
 =?us-ascii?Q?YDZcKcdeispHiIh2cC2+c3+Ngtwkq2i9jprtQ2QiTPS5W7lFm2F4cIoISSBW?=
 =?us-ascii?Q?AaVzrPg7hk1pqBj7PFxUuvnUEaZqtZnxHyscr3o7qY0RmJr1zQu5XOAFnm1c?=
 =?us-ascii?Q?EEKwBvv+zCd2W9Nfwqh8QgIPFEaDNFfEN/3jGfwB0TiqRJ+km69hFBYdZ2YS?=
 =?us-ascii?Q?gBQiFSR4nUuRwoOfYvzJ701F61e21WSGKyAM8Q9xueF7ADUADYlnap1NtTGX?=
 =?us-ascii?Q?E4sD9QajcUFG22IFvvDrDbNQpeVCiXZA9YTNXFJaJxxOzVwNOrTlgetEJ33G?=
 =?us-ascii?Q?BKD+o0tv8IFWRF17JphGfqo/Huykxg2ciQAnRLeB+OTsY2DakIMZbkF/eyA7?=
 =?us-ascii?Q?hergkAXUozn3f22IgWmMQgnCclAhJPBJ96DTXuDDdXVxu+MW036PfzZqowVH?=
 =?us-ascii?Q?6Su56IPqS/fSFXB/FZCg2J7RFRmpjzkrZNqcPLNLMuZ3D75snvsjZT7YqtL0?=
 =?us-ascii?Q?BkcPT0PkhWcvCabY/poNzATrDP0sIcN0V+Z0xEkfGWbJNP+gJeRkJsPC4iHb?=
 =?us-ascii?Q?u9hk5Ha5OAsrOTqwr8r1p1OV2CJq7DkSw/dnSR48zfQ413Pbsajqxhf/7r+N?=
 =?us-ascii?Q?vD2sYZwritLzfY2Na7NYGADeQ0kVSPn7fWhOuUcRQwHeo73y4CBRvvw4r0mA?=
 =?us-ascii?Q?2w0KqL/hpUaDJtDt40W6a08FE6GKgNS4UXJR3JXCq0VODdIfn0E7ND+S+GqE?=
 =?us-ascii?Q?3FsciRjO2VeZKG7LtSJA64M1ach26v1+8U3QAe6PhfYKmqPSCj/zp8Jkxjb/?=
x-ms-exchange-antispam-messagedata-1: vV0lXDx52alqtqxlF9s0KxWe+Ow6ivSepvBSyB/1bGpWs1nd47cDBOHd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cea4252-c65f-4284-9c07-08da3815f906
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:00:24.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3bpY75CsMYFyqPjsUdxeuezwBYBMqkTJojHxRodvM2bdv+zWi2xrZpjpC4po800CBsMpzWNOFDDq7HfWVjQqlHliIQdAFBnDkcPX7ZzW20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6207
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
