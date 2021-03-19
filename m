Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8C34173C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhCSIUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 04:20:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15730 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhCSITy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 04:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616141994; x=1647677994;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=JMBOgyElhgnqlZHt06KHa2XyNtuwyVcS2IBnsHxEf9Cdd74MJckwBQU0
   kzhQzxRXoZPPoklSqI4xZHagCBsUuQBfB4VCo6Ys3LWiSI4Fd2ys8WmWv
   0rIXF3QrOQGW1BGtE3IMpNkCZ+dlWnQjnRfOsI23lqokpRGOYaWdwXAxa
   IBWCwFJJeUBbtMPRhHaJUibRewyA5ec6Mtvu/cYcFEaLoYHBSfFcfu3YT
   jXGC0zhk2m5pPIMgzxqju69lSaej107vfdyUckl2InicDAH7qzAZ5QcOy
   fxByPw0uyYT9Oi2Z83veM/8acMnILsGQw4Tf85K7aClLh2wNCiD/SaJhX
   A==;
IronPort-SDR: 0ml0FKVV6rgnUF1HN+F302w8i4tE7zAQzHJJ+MTy1VtjD4KbmR8uAkBzEJgyjdjswi5nbu08dS
 cwTWjyhWPkF0Mgc/sgOCjhkHV4yYCX7F8rbf2NfbYfroPXDbl8ZgOFDJglFSDOW7JpQUEPs8uE
 xnCwqK2AyusGu82Bdp/shn00Y65yD4Jytg1ussVuRhqyuQQYZK1uktSCmy93DABTS8nrjnnknA
 GMq0xol7WmJIWqm0Nt7e7xitaMkarOMfbQDvYywBNm6keFaPSiIRPmYt8NHJMlvgKNKAZNxQdR
 j58=
X-IronPort-AV: E=Sophos;i="5.81,261,1610380800"; 
   d="scan'208";a="162504505"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2021 16:19:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byuVEAzCnCVw3F724upKaEtxiWED9shuKe8uH/3az+TE5nUETX+OWX8Kh+R09ZIivA7wM4HXKIIWGk4YY5/ypcnrqn+T/D/zmxyfP/HQCH2GzFx0OUKlSNG0IVjx68/9QGYxL7chhxzhW+Us1kol6pL7UZlahltXhLtdMRpyXidMB7I5ra2kEcV6SyQzYtwwAPJp9NFcvV0zortdjMGmQfa9ErccsHKlzBMOfeA2bJJAf30GXVh9eYmqD44ZOmrtoFZ5EeDmVIImvauFVANP3Pqs3846qfVtoS5oukmIok2bxIPW5lUAXSvAcBFEipRq+NDqSAWJoo6VlZYNQK70oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AwNX9iCzuu4fbWEdS/ILQLX9KF/ifbnnOf6hLzXIgbB95BagBy2Fykc73Bo9wMRMpQECq5f9odhg0+pFWSODQqpMU/7EKvc6A3ovOp/L82ZKnNgopbW9dzP02pe0S/Zn05Virw8EHFvzOzFPD1kq/XX7/BgaZsscSLFejfII6Aptdg4JGPHE5nWso4cmK/olsK/yLIyM4NGum+X4uk86AlHzZ+h17QEXjkTg0RHUAHzDS8CYcWK1rgtyg9Yj9UTyiYowlbXFPcwRblsB15aoPlVS4TbbcNnhiwi1JmHDv/cgHN9aZ5OnBAMvFxglBDCfP8R8ExA75GB8mP4QrSZhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eHO1kfkoBXc2OUSoTOmBpDk749Wf2GqqcHnJrAunBzXsXxrt89B78UduvRgT9IHNk/tIw1TFbfgpXYKI/+YVVsiKEshKLFJdDj87D53440KozxB4z+/pAGEP7WPk49R3+yZomTSnhQauwgB93E8vGyryKPtp74MLgYX5qEIz434=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7205.namprd04.prod.outlook.com (2603:10b6:510:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 08:19:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 08:19:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Topic: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Index: AQHXGV/Q9cRb+mZCUkOVzV9kTIcRjg==
Date:   Fri, 19 Mar 2021 08:19:49 +0000
Message-ID: <PH0PR04MB7416AE81C869555B9A3DDDEE9B689@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1615773143.git.naohiro.aota@wdc.com>
 <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:e193:b3c8:606b:24d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a38ecba3-eec8-46b9-75b3-08d8eaafc3a7
x-ms-traffictypediagnostic: PH0PR04MB7205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7205858C0802EA9349A74C2B9B689@PH0PR04MB7205.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lscLkOFQQ2vlhf05C/+QPGpvKfdq1lofEP+5mZ3cBfVjTBb3RYhKX5PG2flv0+ogBUIHrmw23e+DD9uGneMbZid/P1M0H1RS372qcb4w+efAJKM1Vd3hDib7c4kpYOqTnOhevbRDy54pE1jZNMimOCMgN++ZijRSEmiOMmrLmkJSV+5vXhE6UeQ4XG2CkWIOLz5pL5YgWBvwx0T6IPI7lRv5KeGXxuy5IZzt3vC/he7G7KtSchuT+Ip60IJgaEcUSzd5/0u6glC5qfZQjOBVKyuo44WtQL9EFovzhqokpdxEsA3+2VBpmYLxDF8y5AlIxoTwNQMGW37ZMz/QQAt7d04jKP/EktEeFM5tsTXS0DBM9oZ+8nRIO8ijz39fL7Ws8KG2KCnZfTUMuKI1u0r5zfRygGEn/hOagBOZVCaay20gcwje7q3B4q6ZAt8OHjcW480Ptc0fDGWG2MbHLrjAQC/QcsHjA/RIjR4IAkjKi9JXOhAbntBpVl+D5Smi+7GaSSXBZKvc2Wq0OeN1LCJZ8B0GAfera5zJFSlyf3kr/Lwm7dM+UxvSGGXFc22SZT91ktyKRJi1+YipdpvuLJTrCOw2yidv/I86mOy6KTN56kn2laWQJftpu5PHXM3DwWPfW/pAyrsUyUYs0pnR/t6Cx/e2l39MPdtU6mSjMBhmmrY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(4270600006)(8936002)(558084003)(186003)(8676002)(9686003)(91956017)(66556008)(64756008)(7696005)(66476007)(6506007)(52536014)(110136005)(316002)(478600001)(66446008)(66946007)(5660300002)(76116006)(38100700001)(33656002)(71200400001)(55016002)(2906002)(19618925003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?481xvsVMT9f7dVp/OULYVEOU6CTJyLQh47BuXIMUVvxsMaAHAmtgdAOSNHu2?=
 =?us-ascii?Q?FX3/2Dxht5EWcM1HWbOJlcpKLRQWdjZvex7XsP+z5OIcJg/FqoY/ZYMcsqVA?=
 =?us-ascii?Q?BNrP+eK0U4y4LXoiQ9/eauNGVxwRTfVJaF4ssVpWTffPV0CuIF+FfWcMtLNo?=
 =?us-ascii?Q?aN9k0BovXojR1E7IAsZgTE48MqBGsP4Wsd53iot+VdUNVpQmSXHqejqkacZk?=
 =?us-ascii?Q?ggSAlZb4TVP52PHayZsomIcwuI/NRKWdR/mMMS522ugDQhDhF1t9QAskC8Na?=
 =?us-ascii?Q?UC8poLyfeBsbJ/Nu7cb93PCUZIP8IDp3kUlkVWYG810ZIvpbdzrhuL9JMAGP?=
 =?us-ascii?Q?wUR9sPhel3piukLPxeru4dzx/cgqhqEOoAQhuDT1fafoeQGbGlZarJyKHmaW?=
 =?us-ascii?Q?mFYAkCJpN6c/akUSfQIa8C2WDPt9O2iej/2q/AYRKmo0gwM59nmfu2qnVzTc?=
 =?us-ascii?Q?ymriaOXzkdLPOek4gv0Uq8r1N5xm8Sh20+BKl3r0x0MmsLuu/AQO2WcNpt9K?=
 =?us-ascii?Q?SI9r7fl3TdVNewsIjUKfELOGUD9ik9JTBAom+Bax/KTy6Lyh5+UgGgUbq/Bv?=
 =?us-ascii?Q?9MWll2Or699WGLcXwyw2HkomrevCdKS1Vnw48EbkyDhGB9Ddke7z4xShG6bD?=
 =?us-ascii?Q?obeANsrIh40wPqx5Qnasgz+9+radd9EBsIZam4OljRYkD5++OwxMJcJICNAN?=
 =?us-ascii?Q?CzXMa8uR8podBMDY5fZR3kgU6gs1E2l3ZfLrBj+nfnWdYJ9AHKBEsC9AtLBP?=
 =?us-ascii?Q?aAD/cVtpEaL5N/iiGebcTBHbubcJOUzM/VUU4BfVcvHMf22Mv6OrZ5mow0PJ?=
 =?us-ascii?Q?zVoznlBLgBva7UBu/8v12ay2ILK3h2y0c/2M/i9BdzCmHuphDYiyFo4Pop/2?=
 =?us-ascii?Q?5R6qc7tGGEodfgVlas3YhxWeDJn8/t2OFHG3ZcDkc5vvmh58jIczDc/DGBD6?=
 =?us-ascii?Q?DdMkVj1v43wLUI78B8HqpadAHSrLPcFog8a0FR4ZQByEZ9Jcn3thIPSJGtGj?=
 =?us-ascii?Q?t6yR7/k7hLGN0HJN3xr5wy4z7wHinmKC3z7ozAKziQOemgBLahpIOXd4Edzt?=
 =?us-ascii?Q?gbzQMl8hkNHVdAeOZoeJkcN3u71LjkK/dLZx52yCnrBX+6rOdSsIjfWjVriQ?=
 =?us-ascii?Q?kYEvU4p2GKMgBZPg0cM+4CaZaN3DBM+KPgRwmQXdFwTcSAhntZaxBKR7Y3iM?=
 =?us-ascii?Q?IqM7CmN1tIDTcvXtbai5NTeMSPGPopLk3MLO1NOk9mgHqiWAvr8fLeNodRIg?=
 =?us-ascii?Q?vH7FusFVF+Yw/stNVfDVsgElxKao5kQmyG/wEhtoO10GYUkqj+f3LzQc7uEA?=
 =?us-ascii?Q?HKrYuJzUTrxMlwLd3a19MnOHL927WvUe+coEDNuPoCG7BiURlMO/013wmg5w?=
 =?us-ascii?Q?IREycAPUZXfBjgcrVU6PWW/UCTEDW0pJR5pMiEvBrT28vEQLBA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38ecba3-eec8-46b9-75b3-08d8eaafc3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 08:19:49.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2laHqthZzIj3GyrNACbIHje2k8NdCqa4dwpuS9n/LUYecFJe9l7V8LtSSspSOCKqUGU1naQs1DDpLPr6SPZZRSh9MtsYLWD6WG1059j9y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7205
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
