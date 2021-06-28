Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43243B68D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhF1TMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 15:12:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34578 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhF1TMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 15:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624907383; x=1656443383;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UF93mj0FqmNu5XevsdPXifETjyp4EuOWnCvEdzUnVok=;
  b=dCvpOj9urmRhkOHcdMHIw0CGjaTYiB085P61vskFYfudsSXyFbCL4+H0
   muHzidbyzOMOJBm4Qisid6hsw55xJ0ld+kRi/NeJqNk9LHmLDCFbbJAQR
   /JGwFVopD9I9gvT0cO5L/M2MnEG7F6WD/O35gDk8m6/BudQaKCmPUCy1V
   oANTaaG3OA1/KgK38IiVzKI9kxGaOVwFY2pa0biTAOs9ZeVqOKlkbeSBF
   dOSc3FVM76uRGIkyBwAwTArJGahJ1enTqpH/CYtRZKWdczbERLEQYxJhl
   pAJf6xsQRHQwN+8qBq/HXs14JkG+jb8AvnJ57H5ds01OnoplrnYEq+u2F
   A==;
IronPort-SDR: jILCBrlHDong8j6oZjpKVvWeqdJSmUElzqsO9eIdR0Ky7M/QpAkBZ8tzpje9XE9uJ69A8qN5hX
 WiA2qo2fbca0MxLGjGweY4SFiW3l8sZjz5skw/d2GFqUcEWVVx/V+f5Ij7Z0Aqx84EwKPhfH5N
 I8rE7pyi9d/whJmAyYjHSFjVoYVe/fHUOf3/pEmoHBEgFb8ML/bk2xsUarQ6IC9TqMIpGiFOg3
 YStxB7neVzfcDZbrASPJWBMJFwHST6HGEVEDPxwcFzuDUOjB1ZTlHuImrVaTdveODf2fU0+fA+
 eU8=
X-IronPort-AV: E=Sophos;i="5.83,306,1616428800"; 
   d="scan'208";a="173124563"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2021 03:09:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mViY4jxXtB7WPRJ0lqOP5UxAUV+xTbydce9lRS9be+k/yZWSbliadRxgVLqczJMcdPLanCUwJn66FoxjUlHKO5XujUJ0XZDqzTlxhEtS3GTcbaSD/psJiUXw4s3shOktQIrSe6QNzNcqkw8UfG++tGJkbYK9RbrvUEpMZvZNMxRJ2o8uRI7RvpRWwE/cN3EAyqyYfx25IMO6vvvRSJST0lL9g9cuv841e5uDp9lKEfRLDdA1VMNENrDSpI7CCPQTA77YGjs0rYkN67kkqENbob1CMBfr7MHtoybvj8UwE23FWEY/PA+bXJTLT7637oGAUBrK7XBZDH65sUEjc0aD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJvvq89W12z/lEvH71q3Qbr82vXAA3z4KfgvjKbZLwg=;
 b=NoMSJMRZfKt8EcXBO+IoBvNT5JDIkxeZzp6Z0uBxrYQIpfUbRqjTQ9EIsL5MvXbwrq1HFkrUJTVSQWeVra4S4SxNqalMe0Yt9MXugDSb2YRiumGAzssdL6bXv1DcWj5q9cmC5/AW39gImILt9Q+y2MK3q1KEbdGVnOR+7HYWX36cgu7d3kVVOr14Lq5lZ3hyw2uslq5y8BnwVTy9jnYDDSuSAvzleJdKEsj4IaWs1XwlYIG9tNLeZpj3tR9dFRb43DogKvnBZUiPcboQtRNfLdUsBrTHhNUpGEprx210++3z+/89KjmNaLijZME9z+H86hY7ed5LtLwO4dPeucZYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJvvq89W12z/lEvH71q3Qbr82vXAA3z4KfgvjKbZLwg=;
 b=dxeGc4EMoQpy2C8ZihWHLMQsTB7f2cKy7p5IlmqKj3+IoBkQuDqVKBo4chUbSoNR+7fH+7Y9Ijore8UVVsqLW94Bo9JkaH5AePNep3Ectzy5hYu+H8twHUKsTXig+LHeFj4gPlPH2mxGyJtqYUyB15u20qrXOFN6uOFxwPQrkrA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7285.namprd04.prod.outlook.com (2603:10b6:510:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 19:09:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 19:09:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Stop kmalloc'ing btrfs_path in
 btrfs_lookup_bio_sums
Thread-Topic: [PATCH] btrfs: Stop kmalloc'ing btrfs_path in
 btrfs_lookup_bio_sums
Thread-Index: AQHXbC+LiQFes90cKUCE8CVPq5/kSg==
Date:   Mon, 28 Jun 2021 19:09:40 +0000
Message-ID: <PH0PR04MB7416084D7C8760DA2A13282E9B039@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210628150609.2833435-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84dbc69f-5292-4740-660e-08d93a684814
x-ms-traffictypediagnostic: PH0PR04MB7285:
x-microsoft-antispam-prvs: <PH0PR04MB7285B2D77EE01816D42466209B039@PH0PR04MB7285.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rmOhi/9PHjw0Og2y1VDy45TRnuzwYuMG3Qg3ATIUDinErH9R6dsUXBle/Aktr1vSeKFFF8sjEndnZW6NnMF9xov4BELn2Pvjt2mjmS9mvQMXL87pzxyek00o05Ha/vFK9AYbkFeQjttekYszchldjJPsgOwvO/67Hx9Oo6+cKUQ0N0mS3jZMzaI1398P949T62wmcl7XTyILUYZxa6WRZvCwA2UaqBkB1P9q40ev58HHSCNb1xqz2dss7gudMXEVTDrsp/0DOwQ/UFR/XqLvs9ePVuPz/jaSvfmyl4oFhU9Nyidu655KlTdVZJ7btGyt1Sjj1ataZh8YYwYOTdraqtoPwSWVcS/dnEzHW3rRU4SQR7vCuaolNgIxMq6XtXqcNeo5fqRMgyxDx3V88m+1DtyfMSZiqDEB33rS6ubG+CGR4k1inWP7Ru86mggo9GTAquDKS7Fg2+zeDDe6Q5J1Bgq9EjH3YTmjudu8K1ZrMB8yrREAPvsTkLf1YbrjIjMZ8dKT1sjNyqx9p7PrXcIL6zzK+h21+F/RqsWSMd986rQwOlUTgQllSVDHjpe94NjIwQqivZpb8gNPxL07XNmzWujifmBZaz2XIaRasKu2MUhYk38NP6/TkxMVT9VZw20Mi0UKmo+TKek/ExB2PAgPyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(38100700002)(7696005)(86362001)(5660300002)(53546011)(6506007)(186003)(26005)(558084003)(122000001)(33656002)(71200400001)(110136005)(52536014)(91956017)(66946007)(316002)(55016002)(76116006)(9686003)(66476007)(8936002)(478600001)(66446008)(66556008)(64756008)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iTJQ29P2tnNH7LGi70p3muJNKLTp97kWL+3LfivpfB+cNGc8pnRzMSJC6lsO?=
 =?us-ascii?Q?f1viJFiBPZMY1bR+hSVsnQ53XyihX37p03bbConBDr3BT+nePjI2HaD5XvId?=
 =?us-ascii?Q?jPEPq1ut+5sLFc36FppuX8e+K6WuoWRwWd7CwsP2UjE4YcmcjrlAPX763iNe?=
 =?us-ascii?Q?3m6iZZ0EpoXL2zpPewhZhlm0EfLZunQHNYa7SFOUQyFs5Z/MbVaGKmo29RpD?=
 =?us-ascii?Q?o89/w25c/pyZqBNawfHjP6UWRs3QjhlXpqdnQdy5/UNvvJ9RFOAuG5eTx1w2?=
 =?us-ascii?Q?4gwG1Vstx4qBzsLkZZUzdF5/825AoyUhhnDVkQYmeRTckMVYmLzP2zFZtlq/?=
 =?us-ascii?Q?jt3fs2coP1yonc6DvOwFAKadEt/ppE9kRr/CDSPTISySV3IhsiCYyt8kCNPt?=
 =?us-ascii?Q?BUHHj+C+Y89BWtCbZPcmg7luzycLq/VTpb/rRPBsvTNvAJVdHp2SCgOgVDyw?=
 =?us-ascii?Q?QhJUIiasjVlB13YN45awMh2/XIuamNG0CPCKEyWKKT9ATd7ouMZDBeyuxvS1?=
 =?us-ascii?Q?0y8sVoGu0A2JFS1zolwkzlpESlRvNj3sGYcPU20eono3P4/5o5byUjaIsb9l?=
 =?us-ascii?Q?1cSkVukaYwhaiM/eelXFxMH4drsCbaRDtIRk6xjxHRhMWVmiOqEhsngv9/Xb?=
 =?us-ascii?Q?GQbUuqfWgWvVu6dvVUxbb82ZvCNWGmVkAjA0TfSnBGvTC27fvJ1dUmY4R6fs?=
 =?us-ascii?Q?8Q0JJSMj/WnBZlyFGajEb8yPFIDNY1O9JldsOTLolWxl4wMVYnNyX+XkCPWD?=
 =?us-ascii?Q?3NErR9zL6jjROC6M7Zki4apSbQ/lPawJ+UQaejBGRcj2v8snCaLsY473Z3GI?=
 =?us-ascii?Q?6t2TWMEUSISriKq3L186CqGWmdnoIef0ABgBbmUEhc6rvu+OhTqAS9iRhjxp?=
 =?us-ascii?Q?1aJeXYUAhSRGrd0LLtitqEUeexUXu7+mqpq8LTX0Z/YoSOikSe02uqzQH5DF?=
 =?us-ascii?Q?sKYIpD2aoPhBp+MCz8kiQiLOzDIp55UmBaJ+cfLgJj3IcHyU9HSod/AYqxWP?=
 =?us-ascii?Q?jtqIsB8PbgpltZ8ouCToDWQu8WHdeuxKfoXkj+adN+FDPcs5RDDv+yBjx9Fz?=
 =?us-ascii?Q?yhNc+DLgvvEaThJSi9N8hC5P3qvesEC4LBJnRf67xhQCEa0w2x5neLsYPQ4F?=
 =?us-ascii?Q?eKZ1w0PmmXRvQSbOZBGsG4yXaTMLNS6bAiX0JW4LWFxnF6YncJKQmIRDm9EC?=
 =?us-ascii?Q?hYprXwQTpBSvZPEb1a0kwdTHg5DWYTx05cRx639LAeD+0cYnxNsnhb+6IDUa?=
 =?us-ascii?Q?egEaIDgafvFnX2v8CX2hbEueCISn9R+m+HmRAtDjpNPkQynPwNyOp9wdSWRD?=
 =?us-ascii?Q?LftO6xOqTuw2NLOYhDnLQSBH2kmq8fCW8voW2IeY6F/q3g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dbc69f-5292-4740-660e-08d93a684814
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 19:09:40.9264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsL8m16HqKw6NnH5NVQCni//oAUKQyBmpYpOcb+d4OgpSL+GycANbam5XT9Pau3SqseAhZsDl6aHOU2imhQ318A/9rrUtLN+QmThYkznM00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7285
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2021 17:09, Nikolay Borisov wrote:=0A=
> While doing some performance characterization of a workoad reading ~80g  =
                                          workload ~^=0A=
=0A=
> All in all there's a 20 seconds (~7%) reductino in real run time as well=
=0A=
                             reduction ~^=0A=
=0A=
Code looks good to me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
