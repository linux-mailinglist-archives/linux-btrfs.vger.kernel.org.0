Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33E38FA1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 07:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEYFs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 01:48:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49247 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhEYFsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 01:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621921616; x=1653457616;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qISizUtQfPIbH08n+xez33Mc8yElALd5fTvbhwwoV98=;
  b=SxZJI06HSqSVBlrPFZ0p/oDu4INItvIkSgazrhCQId2JCQfDHw0Bi4il
   kMX++88YGC96vVx3DIBMzE2df8hsXUFDKhEW1Bw75vQm//Pen+guvmUzf
   5JxRW3VLfZ8s6D4KNRWZQ7mEqr0I1zTM84lQVsL/flvqPkGFwadHMIa8Q
   PhHfrui2pgjAp6jK2LHg4o+m3oGJSBwjOJB7TOy3lZi1QDHj3C2lMgjF5
   26mtAy+FDl95GsUhIQ6jZvpOPzc01SURauPmiN/Fiq2v+F9gJdrUsSUBS
   Ilz0OwgIc39VIhZwaqf2ti9xM83vWh79+c3DlWw9kL0jv+B1RPfuCIgQX
   A==;
IronPort-SDR: V8JSV1uiGMXRgUC/T8UlmQLnE43iDqJEla0xBCt0PwTUv/7JmgUKJYZtKg6k6mh+AZNdlek+eM
 5yATIEqWnYx1KP3XXY28aIq37Gkq5HlX9H16vNug3ra9lBEXm3kRfdq9/W/d5a7E4eI9b3lw2N
 UNcZzEoCgg2KcUkGsFgbuLbeTgb+G4gB+e0GReSYUEa9OnRVgk8EHgeu/1+O9smGLwRrcEB7oK
 W2chk4ga9isOPjiJ4X3kxnBCX9Up03gZixyXaHhGKJYVI1I2KgDImGbK20jMJT3jB7YsGXSKSe
 dfA=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173997233"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 13:46:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXQdO37hm2HhPtmOJ/EnV5xcjD+fJ+bqwWAO3HnY0+Ob+S7F8iUTPJAvqxGYzMIJPEExhCGkEGGsmtBQbl1CvUNFlc18ytZrWG3NFVMYrbBuuZ8mDkl1AJYi/x8UdOyFjuNfQoxTzqC5GeQUXdK4dwI7w/p+rOwX49c9ZYYqR/t6nNtzK/ZaE8zQUjkEZjzpPm2+UEzZVJApTaa8qXv2XC0syUkpL/hCIiOQ3r6oBZVQZ7CBQYC3Ik/pIzm/2Mf90vnUjhnAcF3O6zB3rUkZyzelqXhyxI7rXp7d6sLUvGKQDgqwp6gpmzPhmNufoZV9DUdNW3rEjZ9R9imPIp6gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwgypZl2bq9DdeHdnSeSvoW0baNzjmDdHJJ0Kqle5+U=;
 b=joMstQzWG47HvFVixDqW9uriDcLxXJePdkP2vTSXTLzRxeUEm//t+1czvIl3xqoTklpMV1FirFGPTfb2v2ogHrh1C69EiXUZmCq74PODr8VKulB/y0oCMbMBATlx18aX/fZwiDrLW+KBGkGLKqSFHAJMK2ZoPZYxvmn1sPH8s1QcH0nhracIxrYkSB7RQbjznBl/+FKBo2P7SMfmTYtOeW5zjmCe72x42rlxoGGas2cXEgB/P09s+P0gIlrf61OKnAqUdSb9H+oq0jW64ER0jvCG9ZB5zBK1RR7NPGDG5D2bk8O5+hclPXGdUCyQqBwqcIXr1XtE/dEc6rBD00XWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwgypZl2bq9DdeHdnSeSvoW0baNzjmDdHJJ0Kqle5+U=;
 b=MuqfHwmWevcm/yxW0b/6pY2edpKxR+pOwUN3Cu0QtCLprIYiUg1KxodScEIjpB2wDqkGpkUWlC8va5BR1kKb61p/2cTNT441Yowk1AuEFgt71C9P/KUJu++sp4FimVlDAPVc24akH4tjpkivJOvvFUVmKA2zxgya6YZ2sO0OFAQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7688.namprd04.prod.outlook.com (2603:10b6:510:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 05:46:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 05:46:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Index: AQHXS/wyoE+7u2fw/k+3p3TOtvxw4g==
Date:   Tue, 25 May 2021 05:46:55 +0000
Message-ID: <PH0PR04MB7416685F0A77F9B37551191B9B259@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <563c1ac3-abf3-3f60-dbdf-362ebc69eb28@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b696492f-31f5-4cca-16b6-08d91f4080f9
x-ms-traffictypediagnostic: PH0PR04MB7688:
x-microsoft-antispam-prvs: <PH0PR04MB76886F1F0A8580B43F04390B9B259@PH0PR04MB7688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:43;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZ4o2qy+mfxNEvmj3fXfX1kqO0EokJ1e78PqriOw7Btofb01M2lx8cb1fyYm9nG9hE43f2/uzFvFUoeTXH8xsSM2jzfM2HLpoFwISs5QYeSj53ay1Y6na9YPSde5Sg+FZ7TrSiqYgts8rowQdGu6pUU+oA1PrAupT0Wr2epCEpHg89wtqmNSS7EidxwFvaI5qpBwplEpvI6Q61dEdGTQB4Z46YhgZO58K/tBbyVgGFiCpMyje1D7qT1F73lumjJOje5WtzDsoz1NdV5eZ46LvuGygmSnGxi+PjuMMLTxg1q6kBaeTUICzbK5IcxYSrQzGV1qCscXaLjloYv5vS9y8NuO5DMKtdkBEqd21aiQ1bsSWBpliv8kdIapqhPKCoofVdqTyr3la80DZkBOGD/DqbG47EaqzrJQRH8muG1DtAR/M2T81URAiKEgrRC7+yhLD37Y7WQBDluco+v11SIzraHCKhMVrBn8uKbfHSvOagFGfgVlXxHJKD5b9LuAyk8nb5kJdi0xhjUjeINRYh0ac6UPQOVpwrQeYrsM+J9jbHkcIOkAIFH/FlE+GvKpfzgYU68kclTbIqzH0VOwVthjtd0w6RjxVsyAyGrNID7dLg57mh0J8JKALKc6N6Hb8Z3pJEMCdirk+G/NwOzeRXI4VqiA8z1yuZAPXqXwkX8gyW+HoogNdfTuEUpW9TaJ7ZR8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(376002)(366004)(7696005)(5660300002)(66476007)(66946007)(64756008)(66556008)(71200400001)(110136005)(91956017)(9686003)(66446008)(76116006)(83380400001)(478600001)(316002)(2906002)(53546011)(86362001)(8936002)(8676002)(6506007)(33656002)(52536014)(38100700002)(26005)(55016002)(122000001)(186003)(239114006)(31884003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OoEeuMkTQ5QBbozQDbDiU1kVH63nqHGgfamxeXDT6tGMYa8tOdZuXhMU2f4m?=
 =?us-ascii?Q?ZVO7YQ8JpxsYaEqKURAs1hyYfe5yZ+M5oGrtl7VWEnZEmdhUxeq9xZqjrCbW?=
 =?us-ascii?Q?wCj1DxOPPp/H12I8COAKdSVlCJ4hcshrjKPEWugoeddFhy/9EetMcJfBd7UP?=
 =?us-ascii?Q?mHktVLNaHodLaNcCVab7SQ3Q7pj4avn8P9q2OuagQ19JRMSMksx2uXTOApFb?=
 =?us-ascii?Q?9E1KEkZeyTwtVNB9ycYW2gPBiEHZSTaVPo3EONJR/wGkBxBjc3pr+0Xoe3/X?=
 =?us-ascii?Q?LzzlGplLIeAo6befWN1ofjL+fNxrw7fRlgrSMFEnRq+xqxqDi2+S9C2hq/rk?=
 =?us-ascii?Q?sTSyFv+1vbT+SISDIQ62OGZ86ZqdKRLcXjvBT3X5Zr5KtDB2kn3uHIH6sz1e?=
 =?us-ascii?Q?/KwusaAsSmyDwY7UlCmV/CZBAJzdSvUc5NlpaVJ/eYiR5Rte804CJPHaVbqa?=
 =?us-ascii?Q?5ou/PUjMN9jApZtygmisvJZGVGDoMr+fSdE66qa9N2BjAG217EeeEEm6HHIo?=
 =?us-ascii?Q?/iC+1coAP70p5CMFN8qSh3vjqwENPklzWILLWuKJZb/ykdPlFAWYoUqG6cNE?=
 =?us-ascii?Q?EA4tGLfTJVroA88jFSRGSDcYg+WB7misbbhIJKQfcSZL7GnivpxCwyKNtgB4?=
 =?us-ascii?Q?YV86q85z4BwUGIAfNxU9V9RiGIwgfqTVZEOPyJJZnolD+/NfCHiBC23qe2Av?=
 =?us-ascii?Q?SDQqRvFrOaJ93jwzN2Ic44ybXmuApcIGMA+MqhEhdBb9DzxIuIB/yY55+/1o?=
 =?us-ascii?Q?f0Cf69/svcCL8K9BbbzeeYGQFY9/LE3lU5SzqrgY8kDYk5apLVroYlkshIF5?=
 =?us-ascii?Q?PHIA7j05pA0vJLIBcEZVkhTEjV7Ig1h4EsYfkFYRfUBrJf9rWGP1PLvKnAp6?=
 =?us-ascii?Q?OsuoseUPBwd2nqltsEcG/uBf6pgnR/JlTHO0f89/uY0Be2xbs5RxaD4HSNjD?=
 =?us-ascii?Q?sTiRA+c+dONt+786DPietd2+V8ySPD4pHBIiH4IF007WEt7INCmNQwInb8r8?=
 =?us-ascii?Q?1xZZpkUtLavMaLMjY3I59O9iG2xvvPY84oLklzSBxSO/A9TKaS6eyIk0TZUT?=
 =?us-ascii?Q?BkAfmthB0XkDkGX9nj1Ind+fjViS2wLhbJljsvSJs6XHC6VHh9VtCwHWaXkc?=
 =?us-ascii?Q?DQjKS9itjax2duSiSLWGY1bw7OC6IGlJMfZUvIUH4i5QWOJy82NNjOplfNtb?=
 =?us-ascii?Q?56Wmd0xC+bNbj+jwI0At369pk5vcnu3FN+x5H3q4o5T3W4dtHBNSTQ+tDPjH?=
 =?us-ascii?Q?lT6EmS+0Ntd5TYYERSETK5suPE3G0+7rLQUYRiPPksDhrXn/JZ3xhvM8/gh7?=
 =?us-ascii?Q?MGW+vtRphtHKSiA2F61W6DYtvLHZmylpvjb7PHdNzv+wYA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b696492f-31f5-4cca-16b6-08d91f4080f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 05:46:55.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SN3sVRYYQlJix3w0lZ3EQjlM7ku8xNEpf+9fvg22Mxch+4QXC+d3fw6+FSiAqT5OaygJ7Odv+7vmR6/kIg2BJjoQSUOAUbkxZAiEiCGCHV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7688
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/05/2021 16:13, Josef Bacik wrote:=0A=
> On 5/18/21 11:40 AM, Johannes Thumshirn wrote:=0A=
>> When multiple processes write data to the same block group on a compress=
ed=0A=
>> zoned filesystem, the underlying device could report I/O errors and data=
=0A=
>> corruption is possible.=0A=
>>=0A=
>> This happens because on a zoned file system, compressed data writes wher=
e=0A=
>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND=0A=
>> operation. But with REQ_OP_WRITE and parallel submission it cannot be=0A=
>> guaranteed that the data is always submitted aligned to the underlying=
=0A=
>> zone's write pointer.=0A=
>>=0A=
>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zone=
d=0A=
>> filesystem is non intrusive on a regular file system or when submitting =
to=0A=
>> a conventional zone on a zoned filesystem, as it is guarded by=0A=
>> btrfs_use_zone_append.=0A=
>>=0A=
>> Reported-by: David Sterba <dsterba@suse.com>=0A=
>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat flag"=
)=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> This one is causing panics with btrfs/027 with -o compress.  I bisected i=
t to =0A=
> something else earlier, but it was still happening today and I bisected a=
gain =0A=
> and this is what popped out.  I also went the extra step to revert the pa=
tch as =0A=
> I have already fucked this up once, and the problem didn't re-occur with =
this =0A=
> patch reverted.  The panic looks like this=0A=
> =0A=
This is on a regular block device or on a zoned block device? I guess it's =
a =0A=
regular, but I can't see yet why.=0A=
