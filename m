Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A441925FD21
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 17:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgIGP3q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 11:29:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27145 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbgIGPO0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 11:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599491665; x=1631027665;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0byNUGZXG+0yECxBevj13Pml9UJgAv3Ul1/3ppnJVuE=;
  b=jCBNmz/bd7OSaaRoVyffnLczkhgpmlZyPP2FUeon5hLMGgkT1mjKkvnN
   34UyVNfUJ+l/8ncT8QOmJRRPGwddYfDT31Mf5/RgKVHe6mdP3VOKFDJGh
   ifJjBH1mcBY88v0ClEBGTReG4/eRQqLAQAd2iTB+6QcZJ6+dLziRkZJ9l
   tEkMjPIwLo5iIu9QbfjsDtI+9Iowq8g2BobdlWTAc8K8hwxT2N9lZCOaE
   12Rf/r71pnCH7CyCFTAr+ONdK/zj5pqdPCXdNvBef0YsxbuGHcBhPDTK4
   Uc/751lEmMrWtVUoVtOwBXiHfsMaxSMkJaSF7nyglSUJo2GKKvt9tA6c0
   w==;
IronPort-SDR: Pc5yRIjoKbU7Xgv0VxKHQmiuroldPfbocT/j1ITWC7esPbg4+uXozhp5b1UXP85d/lrm4oe7hl
 P01zSCS+BcvfBiPOvMT16aRp/LCOmY1FTTqnukcCTgJHIV5ppJHW7eJ6E9BuhQ4CBJw4TH9k6G
 gLZgGPiYiwUudeCtmgpNJvVMgyC1NVY112JsPD+T36NHEzD+xuq5Jp9xindNotBaHRjm+T9qc4
 XgLKe6Jy8NgL5yrz8WpQdnfg1tdR+orz+Y5wgqgUldw4Tl4/830e5r0eSyGL8h2/YuMRni9b5V
 g1w=
X-IronPort-AV: E=Sophos;i="5.76,402,1592841600"; 
   d="scan'208";a="256320345"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 23:09:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJDzACKCPUIj4pgvewuDv2obIkJ05Fwl6umD5ekvW5mZTT+v42kc1dxJhFu9mChtndedp1JLHRwkQflbMO8dArWkLlmZDtBHTL/WaNhBzHlvHHFWkpd+Evo+HU21MGqmn2G9Zg8pCvNPV1uv9RrFBvwi3tWOPvVgneKPLxLInThRgvpbXPNOK8HIaY8Z+BEHo0Tk4qu/dRYIX2JP91+pY8Z7VEOo1THCj4OPljUq+iabdFOshD3+1ZsRKAF4JSUzQDFxWCI3W2jYmq1vs9kJXujDeLMWDsWyd41j2xXUGu2B9P1ECw80tPjziJL1RtHYRC2Q+AxlFXQ3wgnp6IejOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igpu1kpkpr+hhocOKRQRMjQPACPW7TcbQmp9IUS2RnU=;
 b=gr5I54ypYogvtmyAWZytwSJOB3EFPd8tu/ptDUuBqIePfxxvEGCOy7Hp8rBi390qMJBM1thJ9jKlsv5cgzf40a1BSJ1T2qDzs4DfPHtd9uSwEq0AnF9I3ze+9Fur9qLsX9pyLOsaL8uo29wZPxo3Q1EgQn9TXRc092tTYAtwM2YSnmnoWFRfjI7aZn62407qFwOCz11reEBqr2wtzBnz0XotQO7YqWk3w6BSK/8e7Zw5ldzn1pJckZW8hQzzCUu83q0ItPWbAs9LqgwlhFu1K/5p+T4Reb7KjojNONK1aV9acjYoasCY/PZ1xhN8yvwRMlXsJjWYXEVtzFxojMw7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igpu1kpkpr+hhocOKRQRMjQPACPW7TcbQmp9IUS2RnU=;
 b=CGQz/HjW7K3yecDpVljROv2WZV3trkQo8nIRoAy4EWt6JrbjPdGDnF24QqMtJ71rLk2q48fYMGUREGrxCDwOFgChYQvPqhocq+29bCf2qeg8WbnUfH3kJ7gtWRimnUCQmoGk2oP607CIfH4XV7qVEqYOyT8k7xtf1IGswc8e57Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4237.namprd04.prod.outlook.com
 (2603:10b6:805:30::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Mon, 7 Sep
 2020 15:09:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 15:09:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Thread-Topic: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Thread-Index: AQHWguIIkDqfUfIXSUOxSTuVxfYe9g==
Date:   Mon, 7 Sep 2020 15:09:20 +0000
Message-ID: <SN4PR0401MB35981763EBBC62E6CFEE7B759B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
 <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
 <SN4PR0401MB35988315D6DF0068151AE2359B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598B2EC32C25D601E59BF879B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <a0f3b051-b9e6-e881-cdb1-0c75224f6760@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73a4511b-f2c3-450b-592e-08d8533fff51
x-ms-traffictypediagnostic: SN6PR04MB4237:
x-microsoft-antispam-prvs: <SN6PR04MB42371BB7AB925912DC5947F59B280@SN6PR04MB4237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aU8kPLmLZzGCZhhvDwAzeIVlbc2XyE2N+00XS5SRVtPO6le9N7PZTojiYYwcW20pjruzxiDefhXO2Tt4q2z1m7JncwUfc5BNqdh+wK94hE+QJZzHSO1BngW7CCuHvfGwB1QVrkv44ZA+VnIR9HpeyCW2Q5doBrmLM9y3vIYxJp+m31GqIvgYQI+c+EVi86mzYI0P1oUg6ySQJYAI8RrIrx1LESffYiUjk1OGpy+IDb+n4VMcq91zl8hQ0zKRbbly++IRMbArKF/4fAcIOp37V1Mnmfb4uPqAYLEmfm/pxnAjLTPlBfBxx+Gs4amuhPQ6TxJLzMt1Q7MqvaVLlKBgPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(66946007)(6506007)(86362001)(8936002)(33656002)(110136005)(478600001)(52536014)(4744005)(71200400001)(55016002)(8676002)(54906003)(9686003)(5660300002)(2906002)(4326008)(53546011)(26005)(66476007)(66446008)(316002)(91956017)(7696005)(66556008)(76116006)(64756008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 93uruaCZQwDtekYnGAgllIMt+8j4hNOsgUIdReW0SXlRH0DscJwK6O5DrLJpQurJSDX8Lm/X98I63PG1AoOuBM+AOY5KKjNAaWbiqobU2V/fRx96zCcKZT1oaKS06GuLGJI/02ym0jQ7rn0cBRdtFdtZKfMML+vUEbspSbezByh/MwLwBt/+Os1LUzhDzBhrdPiUqK3pzzu2OOSE8UMAuO/Ekmsfp7U494Us6qaoR0F7PXXnUAQxxywodcnnwLoWY/GlhJRsltlj/InbBdrMa9ib+mNYtgoR05oGRlWPcr2xT9N+6fN/rVcBizQkxpsq21Oe6EYskkOx2fhvmlQwK0B9mkFPr0b7QlPQ9o1y/e+X0hbVS3Z656/8pQH8V9qAiEofj+yNa1syx7mOWb2rKd+9Bf4X2HJ5907owXujY4iNuGTmnEpEW8bovFrdFfF4LVAlu7FpOEQmOqx/E4THdOcUNY9J5BVq3wpBiIJOoByojTxwqfrjijdg+fceEXcw3GzY9S3xnskeYERVwJiccasRUbjz+1pYjPpnA1AT1ge/BvlPhr4mI0mPgAJ4kAsZcLp9ExDi8ikypc9UTYp9FGr2m3euObz7gnC0PyvDYDXcTelqwH9CtlBtvkqBoCtEKMTqOfvNlPpUr0Cz3UjtTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a4511b-f2c3-450b-592e-08d8533fff51
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 15:09:20.3232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m913asbMvhiZGanQo5JHN14T2cyW5FDt1YBi3bv4oN8XP783gvWFb26zxZ0rclrO8DyZgRffdlPqmLA5JAxpkgVvypAoQUw24EFnjHf1lK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4237
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/09/2020 14:00, Anand Jain wrote:=0A=
> David and I decided to avoid cleanups in the patch 1/16, and are=0A=
> pushed into the patch 3-7/16, mainly to make the bug fix patch easy=0A=
> to backport.=0A=
=0A=
Yep I know, but one prep patch in front shoukld be ok even, when you =0A=
need to backport something to stable. I think 4/16 can go in front of=0A=
the series and be backported as well. Sorry that I didn't scan the whole=0A=
series before replying to the 1st patch.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
