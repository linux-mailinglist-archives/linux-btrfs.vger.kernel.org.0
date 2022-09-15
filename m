Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74EC5B9C79
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIOOAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOOAV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:00:21 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067482A265
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250420; x=1694786420;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=X2gwabAIO5EEI4RrMwlSD6ZaZnvCKT5LMW20VXmwyl2E+40zaq5O8kOm
   pyutUx/xWM2j1X2z21DiFeFchNIhKiRjzMw8d3jyL8ks1XSmBbrXK1aEM
   7eiQ3xZFfQo/aIi677eAGgctalXg2NUwQw4+Sj2cN4Z7YSkbodB/rGYdn
   lQ6VEZIweGErUOJn9KGvXxjNr64d/HIwdxIWmm0quVp836Pr2DZyZWZiw
   SWQLl1eeXY4VAfrE5kn0wy7Mw8KyFiXHMaPQBpKJzXFBfwqowoNeUNycX
   5LzIWAaawVnMcnBMKSMa7yslAikbb0Sys+agsLG0NmMTG4oT51vBYYRk8
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="209838299"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:00:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg1I7YGtwLH3LZOtl5ULG01m+BYyQKHF4K2nVrPXXecRtUgXExE7EcfAu7L2fEvkr7g6K+ntpFIXJSLTsGhy61SjIwJhyn4tYZI0r0i5ltoXtI4TbHq5Xivf8pDlLN8CBtnDL+fPEXCq1+uEhvi1eyg8RBUgx3zhCtdCZKtDyfw08TjijrkwfwIb+J2aWPyemH1dPj4iES27b0D2UMjs7YCYnmSjtzk6O3n59wSLnjOIp5y/nqy8YGH7Wnlp3jgDiNhwsZti2qgtZ8s0gjW1G1cU75r8nEmCZN1ArAWexKiMby/703R7uCXJwsR5PTWFZJLEl81p/l8wt9Yzn5DISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YPrhLODSV/WrJ5hPhQi19oQpHQsTYvH6c2ryKn7NSRx/qzRViHgiU3JhK+pp4h2mKoJihJBtP4mbBvou15+kEacdkMSJwIOlekjEABBis1gCtCPcgROneuNnK8m3np9F8GchGuDmuuNwr8FaA5tdEx4SYSLcDdWaXT2ezqrhBWapJdf7t8kKv2p4IA5tJ88+G7sokKzHCxbbj/5piqCiIXpm03il+KDtoEjfwDvZ9cGyBHH1GNFYpea/LWelqslN9I9+oYbT7MDZK9X7bwEuCARQ6WsYWzA60zdABxNgXg8iFeWaH1ioNMPH29fhieVg8Hn4nPws5vtePYFGjlbvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gzI9eMPLORedxquoy1p85aYx/Zl41ZrBJgCLEui3zp0B9wrqezXGBXJLubePQ0Z+IA5HraRPxRZPWgGmx8/8HvBbrljrtiucfkyo3hgfyOI9oxEcPE+BvsZ5p4hIVVutPcdxaqWHcWc88qMa9HadbSr1tvksEWPfNzjqMJhpFmU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7952.namprd04.prod.outlook.com (2603:10b6:408:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:00:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:00:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 06/10] btrfs: move btrfs_clear_treelog_bg to extent-tree.c
Thread-Topic: [PATCH 06/10] btrfs: move btrfs_clear_treelog_bg to
 extent-tree.c
Thread-Index: AQHYyI7dNsJ2TDerWU6yWetop8o4+A==
Date:   Thu, 15 Sep 2022 14:00:15 +0000
Message-ID: <PH0PR04MB7416AB14B4DE37886D2AED089B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <4d12140ef58244d81f2888e8d9e585c268f01911.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB7952:EE_
x-ms-office365-filtering-correlation-id: 76ae95e7-5a19-4c76-a465-08da97229ddf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDvEetWdj1h+ujDyTp3XsfG8wgVBp5VHwHzuMlawMD1WuWcaoGXYcgWubn7pb+PAaRZPy4TbnpesqEEtDSteCG4THmcZujCIXbPEGBzlVjiAsviFHEF2om10CX3abPeFsV6VUr4MaKRBbDRCjUyKdDGOGT+k32JSDqS1/ThL2zO+U5Noa5HwAzdKn3BeMKqtKmut1wvWPgGffidQjaSrCoj/Uz/jD52ZEEcBw3GqNzpJwHhFZ+ew2+pbOzj508APJkeGHIzWKucra7qA+BKULHMkYpZpzyQpljSzc010Y9nB4Rd/W+N33HLZZ/nmH2aipFxFQ/I+KHyEBDMQ9LL5I4iryD2zgBpAGw9zPw+goFhfhkbVSyelve60wOTlc/NxNoK7moi1PMhBrt+ql1NOIcpwIxeB4CYPOPRJTJYqOnMtmFnKCTH4XgPsdK3P1PWSXvVx6HCgC6UnqT4BBFajXZhIn0eEba3XDiVJ+F6mm5gdEh+OP6iXETJttacQPrYGeL3cwGKqskUEjq4ivO2XPB/+0zfwWfIFduc+tDokpqhxvCQN+siANAlyCnNIh+UZeCAE2WSR74s88BzDqaJ+GyeG8Cddgrurn+ev3AhfiK9lFcPnBlepAO3HgDVcrM8RfApwyQ62KPAvVs5Xu+QXeXyZs5kyzFHW2FSwr3pnMGbek4EEEC6SyAWqslPCwO7VJubyRRoLBTvFa6YHVhAZ3qoXayIE8K/+owfEh6h2VdxoUBu0VO9WNd1k33Fll2zf/RVpK/KaKLRA1v6PS4oYYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(316002)(38100700002)(8676002)(122000001)(55016003)(5660300002)(82960400001)(38070700005)(91956017)(52536014)(33656002)(558084003)(86362001)(64756008)(66556008)(66946007)(66476007)(66446008)(76116006)(8936002)(2906002)(7696005)(19618925003)(41300700001)(4270600006)(71200400001)(186003)(478600001)(9686003)(6506007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HO/59VmqV0laO4FMeMLBEjlWrIP2CeaYEe8D4MTAqr3Ck7PO6CZXsehBMrjC?=
 =?us-ascii?Q?C5slIZPEHWUGUQ9MNsEfKbmjSu9fDt6wuUySRGloCaSn0GXJwjjo4ECOLZ47?=
 =?us-ascii?Q?tIbgvaGffLAiKGAtAQdFLG0QTDM0w++hmsJizzlte+sbH1o3Ow2RorbjLXfe?=
 =?us-ascii?Q?vnGVxzRbkNPbo5nHznXxdv8H3+m39TADU3njXTSg7NkxZ5KlJSMPlNQ/Xy5a?=
 =?us-ascii?Q?pYC5avb4cL8QP+iHHWb8AiHq7YdNFJ3j4CFGA7rOcBfgfzfhvz6JIFTBoTBB?=
 =?us-ascii?Q?78mtsQ+UMaz4VXL1PDgw/J8pSMwFKzi1C6z+PZWOS9y9HbtmZpADLwP4j9ps?=
 =?us-ascii?Q?6jqCkxUsP5bpjmZr/0DaCuGpfQsH8WdYEgE1CQzP/0P0SsFVP9MGE6RDxu+a?=
 =?us-ascii?Q?VsVvVJHLskbhBFQwKb6Y2PUT10XtxCT/3F6dpUiaNdtSKI6esG2vNVkgdNJZ?=
 =?us-ascii?Q?TttQEeFFoUHIs8sugln+8SM+bmsUFJKQRade51FZ+GIDFPrCZVoPhjoWPBov?=
 =?us-ascii?Q?MjrB/1G0dsvZRKELi8RyWkl07IlSgR0WZi8znf9ExIZdjmwKjuT9/Ipn8S53?=
 =?us-ascii?Q?NxwTsGKNGFk8ilWX9ufOAWuYHm1ZNQZWn25QlySbw9lNDdfi1ZK1KgADmf5t?=
 =?us-ascii?Q?UrQgP6IPwhMhVSDChbgEHOXJV2n6+GtmP0NazGrJ333pbIYH27FeKIlWqxiY?=
 =?us-ascii?Q?QztGgtNtx5rrtn1EgXdptwTx14jxUMQ8Pqb4W1/VygCDrW+AKyOANuJOtbA5?=
 =?us-ascii?Q?UFltp0qDAmKKGL9BR01tckT0SvKyFA3jieO8thjYNlBM9PH6eJrmTJ65pkP2?=
 =?us-ascii?Q?QykUbHV0qPxmEV0SLf4a/eUYtE/soNuQ/Z/uWTMVmSkHzH2zeT4OrkBwKhBn?=
 =?us-ascii?Q?E37B+foY1aojd/3T2vU2BeW52KgEj0uKCIB/iVnutnz2amhd96W8mWu0XsE2?=
 =?us-ascii?Q?m4N7xUh/aJnpWul1Zd1vGPY2Pr5INMEPzyAnHONK0MJIXdMeyBEl/trwuxtw?=
 =?us-ascii?Q?3s8vond118yjacfWknVsJjyPqCj8rK1izZvutXptRB4EmLpjKYA0A9h15HkH?=
 =?us-ascii?Q?1Mhm+9tgQL3pWI/BfAcg0VoeMI9LJ6ujB9h66yD7KDi4yp91bS8f4TJJl444?=
 =?us-ascii?Q?rA9kbPAra5s9x+IupauTTPE6qPwOMJRTy8Jx+9cCdtnYDo1KR4a7kd0LIYEu?=
 =?us-ascii?Q?9rmEm22Uzh8f+n6BtxZ45HGcoC91JCuBwfF3bhz7i1NsxzZ4JP4ZVFH4vSFS?=
 =?us-ascii?Q?WLINjI6Uu91HpRgJ4f5huI0Cn4Y7+23OqjpRR8ezV3HwrPO+54rvYo46hGfh?=
 =?us-ascii?Q?F+Wz36OOBqAcKP9SGp0Hi8PQGbKg3cH2IxM0TUNyZOWvDzrjJF/iEAY1cPqI?=
 =?us-ascii?Q?YMjcExi5z9Fx6ve13DLcAmJ/260HrzjrHOzhEsGNpHP36FOX8SESLUCUXHwB?=
 =?us-ascii?Q?hVoli7APMBukq31x/sQDD5ZqzVajhSEsMxTGPjTHKmLQf004AXepr7Jz85bb?=
 =?us-ascii?Q?qR5X7w1kvN7JATPxIVOd2z4sRre8E7EtaeyK+IydO+po3XxB7lE7jIDfl69e?=
 =?us-ascii?Q?RSZNWVT/J8bghirPYl0G8cEb7MDMLnQPOPjOJborwzLMzg7EfJiZkwtqoRi9?=
 =?us-ascii?Q?CXl+HlazzbF3nfZ6CjEnTvXeSjCJrGGgwlyYoVAGZStuP70K5SJAKKtDbVzy?=
 =?us-ascii?Q?FaIsBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ae95e7-5a19-4c76-a465-08da97229ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:00:15.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vw6vOuKyuCz8QMsTd8Ke1CUmpcnFlafweXaasMPkhmqSCxK1M5rVolfVhL9v2oF/PDLn4fnaaamkyrwL8i3/wEfubpPmHM92NXxR9Z6QFUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7952
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
