Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A967B36EB65
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhD2Ngz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 09:36:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29081 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhD2Ngz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 09:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619703368; x=1651239368;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=N5heWN1kBfHNEbeSplSX9q6EazlEpZw/sIpWNFWbu/GdS0/qKji1jePH
   iItOl6CwCPfjSdnSjpfuX2kiDT9+ym3j56OF2VUnsjzgczV/w0bF7Qw0C
   6gRHFx5Bc0JT4W20SfInsbwwItc4kkXuzUZKbUHQKXl7gWpfffKQGBSo9
   r8DYy8mC/vZu7hNNu7VcprB6rXzxDj9CpFpCulhxg0s55nNOuLTmONh0/
   EwVa256j0/OW8o6BruAgUVi23chExuOrSBqWyF+ZPuJBJYW4bR5qqIOnM
   s4MD6c4OG35l69EGfFhcgGIdwoUs7uq5a6JyRdtOU9O78d3h7RXdkVf7y
   A==;
IronPort-SDR: 0DEUIQapA7MdeaBpNmrufRjY6uiEiV67nbCE3vyjXFArjM4Y1pfJH2Uve4Um4FFBDLMc6NSJfI
 eLkgBMFBW6QYvBHNquNlwGQXdJolKSq8wM6le1fvC5sFu+rHJzjViIdW5aMV9dB+JwYGTif/iV
 7xeNgHbBlGk46XhtcLKzABkuNujRl/hQj9gro0g9hrvPiEW2DleBj1aV8Z7+/X9QuheAZg9Hjl
 BV2wCpaUrKyeKbcqcefeDfCR/jqrSodsrQK36/AvD3yqHOVoaLfHgV35oQ1MZywboyERBgxKI5
 +Zc=
X-IronPort-AV: E=Sophos;i="5.82,259,1613404800"; 
   d="scan'208";a="166660613"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 21:36:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAr7EAFmOvYrPyeVYLutZWRSRaTaKlgvC+MIOMHS3MQPgLwBzRgz8IKgDUEgdhm+jNahJn8a4vAhQoD226yzBPjmfQv1MvqoAlUhV0SBKneCzplMOjwHFEo3KDUM1ITQJSF+GfQVEBMeYI9Exsd81VloC38XcGM3w/KRfZ3U0tsk6JnvgDwTbccWJspD0DiIbyNuqwadwpKrip+uzHeEIsYtFROjUGZkDpBsf2DgxeGQY1uvBvbPW+nT/XO8CmwDM+vWO4X+o5wA7R7bmWr/W6uKEB6RvNgdAdf3/qdyvc17hxW1tBDKpRrHqCdLl12baTj8uNHbGpx8NLPXQE0VUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bDOVRAvs96ktq3owjbtldchCb3XTuskYm58sjkv4KuPrCtI8HWqIAj4eBxAuYXar+leXEsjvnUzIZVKPumLN+5Sa7IPKtpoLjgm94aEaSz+w+6bRmmn6zo2cQn6MO2yvqMt9tznVjbCXt4R/TGw357RdoNBjhY2BSScLW2o1i/D9wTLzDbivBwOC5P4NaFg0Gz+QWBu07lxExXgrBjMwWGso/lZJmVcg2nVuhYoIEUlvoWlp+UA/vrViD6kktuuDOjL9jg9vUcRXyv2ur4Q+PATKags2U1JQZCC8FxrD+DihhJTEDCYvry4ioTZwhlhYOJTQSqHV5ziDXlkVgWzQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BqIH60u2lagWnfhgwzDlJV7mXamyk6cpMEaJrRCBA8dg2e0PLPk7IPtQ9DgoAiw61sduKrYO4dgkQEY9cNSYxtda5A3uOSFdhb/Jugb1qqY6QopCj83VCHdfPI3hAD0gwlMmBkKVQjUeEwscs87tN9idieNgQBsNckdum3fSj2c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7736.namprd04.prod.outlook.com (2603:10b6:510:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 13:35:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 13:35:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/7] btrfs: check worker before need_preemptive_reclaim
Thread-Topic: [PATCH 1/7] btrfs: check worker before need_preemptive_reclaim
Thread-Index: AQHXPFV3ztBamLcEAEuVfwDCPjEhTA==
Date:   Thu, 29 Apr 2021 13:35:58 +0000
Message-ID: <PH0PR04MB74164F4B010C5ACB92684F5F9B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
 <949c99db63e3f5c61dc402deee9ceae3087abae3.1619631053.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:a91f:c11b:e39c:d980]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c853f20e-a142-4321-91d9-08d90b13b8f9
x-ms-traffictypediagnostic: PH0PR04MB7736:
x-microsoft-antispam-prvs: <PH0PR04MB7736AC056D470163C54DE3669B5F9@PH0PR04MB7736.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mK6Jdws5BRnYofp7rbXCzLrbYy0Ip+dBN8SQ1mi0Z5PELEAxEFtMo2zQKMBTmIBmONdQw4wqz1TLl1z82+aWkLyVWnKiG3ngsjbZB7VeinEJODHkvCwL8eE7E9Du8DCFtmZ0a9FwIOE9tgQ1LTJKplgDsCBsqRB+mVp505s56RjsIfHO/91EM4gXxP0NNxYx/b8zc8k+qYDSfVE5nH+8yropCqorxPByEvCVJg+1ylr4lZOkoxr4JdIz1M1tk3oKpoQSHEnJu2MC8MHEOtzMSw0uG6Hd1OcNcSURUrb0HPTBkBC9enoMipf/idMc3zJa+hUrH8ppYBCM3gFKVAM2oNrVkdtfmdr3nZ1wZCs7vmJZRwBfYvwpjvkYMNmU4+hEkFzaWQkekJG3y38wv4GVzD80ax0/zgNYD/2GWbdXf5bkK8U0sX6REzDHgT6jmL/4KhU3Q4nlsBc90BuumXmbLA+1ZHqq0H6QyToihl+Hrr+Kfp+3VZM57vYT1Tijuos9VVK87XPlPr+7a3DQOlQGqwGVPtqJdadrilqUdlO2CQ8QEGOpBSUT1RgJqgwgynWfaJNwBMr9rqw02jyoerwbNBZzRpgXBpRsyIUHv0gsMY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(52536014)(558084003)(38100700002)(5660300002)(8676002)(122000001)(66556008)(4270600006)(71200400001)(7696005)(64756008)(110136005)(9686003)(6506007)(33656002)(76116006)(2906002)(91956017)(8936002)(186003)(316002)(86362001)(66446008)(478600001)(19618925003)(55016002)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P2Ut6s+MdyFYHOw16MfXJ1/pgHMkzg9HzGXkLLa4ItzheTB6P7KgiENPQlhf?=
 =?us-ascii?Q?ukdMgg3Q42p5bF9l97slklFvcmgqxaUmBQ8Le2C0eY+9oY/ibIqWIVYdTQrV?=
 =?us-ascii?Q?sR/0StbaVzZ8FxA/kkBppmT1MoUiig3UaDdLjnBBEwW1uqzhwp9YJ6wnMkpI?=
 =?us-ascii?Q?zQSbqRcmsWqc9/PXIWrTALwtXcHiiHLsZLCDcgAenZkjLM1P7ivbREFNmQRk?=
 =?us-ascii?Q?EiY7ZJV4wO7ERHE4lJXrvWYlhVlancxW7Its9agfs6MtrsBAJ+SSxZwV32ZV?=
 =?us-ascii?Q?OXnZiR/er7IP9ma+jX+YZvlL9oZNLGrNP2rRWXnbc6CD/mG5FQfq+DUynjcV?=
 =?us-ascii?Q?vW90ZOQB1zpYmZ4mdNQADy+oQGxdpXGPkkyxtbYlKwdFLVfRT1iic3FJjR7f?=
 =?us-ascii?Q?CLk5p79WzBgLPxBiEm28iDRn3hv9hz3kazlNbmUTXS9WB8MwWeZi4esWrYXb?=
 =?us-ascii?Q?5/AvygL1xZQZj89tvZrlZ/z0atwZqWqoG4dA9rnTqlSA+NLS4V3RcUGAA6LC?=
 =?us-ascii?Q?jxEmXq+7PMKs9tUdl0fb6TO54Oy0+eSxLEG3nmovU+XfaO2cUW6Tu4jVMOZz?=
 =?us-ascii?Q?12F2fhGgX+o0Vut++mj8+BB35wGMGzo5WiSJkOV0zMd+DZ1+ah9wiNC8AlDs?=
 =?us-ascii?Q?qbs9jWCEymQcNEyXy5/PcQrEzn+wPN0Ns9lm4DlbCybV+x/BfxYf+8HyVwQ4?=
 =?us-ascii?Q?Ls4xxCPROoYNAxBocIeOQw6TmErMdIRplCxQ8KFcKH5eo2tpCfXugrgZsGSi?=
 =?us-ascii?Q?Fr0GZvgXhv1Hgr3VZrMkpPEPpRXOgItCIBXhhu6ZhAF/DN6kIE7NTaG73JZ1?=
 =?us-ascii?Q?q247sReWHarZNZYHtmaYtDNkvGCHC7rKwQweo04MAvOZGiMLrTpyeRglg6cm?=
 =?us-ascii?Q?+Z9/7rpxgokF/xUirx7Cdq35xy8ubqYjGsbsDldWxOzUhrQUwaofyXqiLQYV?=
 =?us-ascii?Q?7oVxbt6v8cgR53DJgk4pamWZb8M+8JEmhv9RedqWwJz5eabGm6s1v3BVA319?=
 =?us-ascii?Q?YY8nUxZqFjXpYxGjx0l/SQ254cE0KlTOCTKb4oFcCFAnSVxu4XaFgfj+Gd0h?=
 =?us-ascii?Q?Xp+aqg5g1SLsFz1Z7cgk3Rhm+LOX76mkSs8p+xExeXwaYnIXCtF4EEU7YaTh?=
 =?us-ascii?Q?fyodhGe+2m3c7ZL2iyjy4SE3ta7HAGmLtWCriRbyksVyeGARtYqpBAj5DYQS?=
 =?us-ascii?Q?KTP9ML2JjBlJn2qpjrXQgg6MUSG/8V9iPBI1Kx3FdDY7oxJykQP/AP12z+55?=
 =?us-ascii?Q?GhwKYfMkoCmjWr6BY5PA8+g1Lueq7wB+eo1V5GCVgQTWxxQeJe9hmGWCKYad?=
 =?us-ascii?Q?7qSQOsWu5pBWMKt7TkeULdhf3ObYzGfpILNDGTWuAE4o5gD+2/Fk7tmghtDO?=
 =?us-ascii?Q?59YV++RRNeRvJVqkRSli3V+PJK3NAd6Q6uDmmKO7bzzGxMKPwg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c853f20e-a142-4321-91d9-08d90b13b8f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 13:35:58.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMc88JkrlPb102kNulvhAqjXBPvo4qc2BuFsxyINehvrSzDKe6WtQU8Xl4D3BWNNtZNdPLq7RriG1r5GWkCADhW5pzmags26zBPPXZkHwRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7736
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
