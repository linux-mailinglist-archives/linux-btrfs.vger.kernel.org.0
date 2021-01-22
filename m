Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E5300497
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 14:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbhAVNx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 08:53:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23003 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbhAVNxQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 08:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611323596; x=1642859596;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rQuhWOvdLvDQ5ZRXvzX1jBUEguUnysNR1pNn6dW5cWsC59W2dHbQwKzn
   gnIrqB8BWlPJ62VbghiSj6frIsUTfZDnq8SJU0J7Zima/mUqiUvT2reo3
   mKe7aKRnaME0RPOQKDoQnJTjbCRD2lzYB4H5Y1dDcMI0/IJP1KAKDGZq9
   uyO+bWkJNmCUm7nZY7N8V6TAyvCrdMecGfIRkohOYjvF2+N8iK1YXull+
   R1zKyW0FImf6fsYNlW0XBuOPhYstRMjpQm7L+O9B8/uy6g0AXXiY+gI7E
   Ycdv0s0wlBuPMem1w69mdIY9iIrEO35Zv0ub+/tt+HODIAwC25yua02ig
   g==;
IronPort-SDR: lgQPm1sFmFDc39npjdEbBPp9NYIlJ8ciUhf4j0z8HFIfn5vL08dxfspiUYEHJ7tqZJ+dhBla40
 qsRXsrOob1hY2a4R9TSzj0RM1bhBac8vZyPlEHISis2YIrn8n2nJn5y0M8GoJhFrnfGgphFKcw
 SdnI9HMWsbRt2iX/Y6eK3lY8hFEF60isp8JzAMQ3kpXbZinYoaTb6Z6QSmM3OFUKmE+Z2zINnH
 nz+i/0ZStQBbHU2hYmfgHlqUw5EjaPnnYwXQ3qZek/3cyJzsb73BBinbJ4hB1+wB4fVrDIBvfU
 lIQ=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; 
   d="scan'208";a="158085180"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 21:52:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvQbkW31VEeAXYfR9tU4YzimPIWPx21KhIAUOnEmX69iHK0wyMDVcDVNLJOMfXxKeOEfNNwY+QfFBdsze98Q/MmDi06TPqcuDU0Sz4xGv/M1zfjJ+toVXrTBeO342OT17TQbUYulJjBQmW+vghiNpO5/cj7d9abx39Q5jyilGZTDcKWEEuKSBQ91WBaB0PMHq7svM6620FWL+0QVaJ/UPTlO8U1P1nioi9ZvC2cPtBB7agSsR2MK+ksCTCS1QZLghbU9RSM5tvuD3aLxo/8I0K7yirjt/KutCaT9miKsTl7tkOid27h+f05pBA+zJvhUEIzeiMudpRlNYBl0VV5FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UVNbgiOqM8m5vM0i0u9ww3T95O3i9BxxOUL/VGri4WRZ2LlWbFvS92XdjCpXDMCueKrlX/IVqSeI95k68aJzYHCRsYXxBTVv3rAUqLYO5mt63UvVH/CkGO282gEvwCT+MTXSbC9/krPQBo0dBez9uTkzN5gRxWNJbcO1OCbqFW9lKQu2IPwnIXQaOfOg34iPeGnGq4z8ASUAjgXa2KhbTMED3x0RqwAuHAUWy2lJMldwGqUYn5D6oMJGtos09A4Pp6MCm+iz+ih5WaGzDqrPJqL2MTiJusqDNsXx548o6QIDUBKmsG9XVzRL6YjbNz3k25Qw/Uq6lz3XwxeitAD2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Se9PAsyuh4hDx/0u5tx+nLaojb8UfTNTknPi2ipV1WIVlisfMPhnJChGs0vz5AriDh5vPlk895ycG5NBUZgmIhzTav0u/UcfQDAllF+mMVeOXMbH+6Dv7YeaE7FzFclq642bUKb9XLDFUn/4k08NJtZr/BcJkbp0jyny/V0y9Wk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4861.namprd04.prod.outlook.com
 (2603:10b6:805:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 13:52:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 13:52:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 04/14] btrfs: Fix parameter description in
 delayed-ref.c functions
Thread-Topic: [PATCH v3 04/14] btrfs: Fix parameter description in
 delayed-ref.c functions
Thread-Index: AQHW8KfD7Gh3/72rNUSXUh/Ie8DCUg==
Date:   Fri, 22 Jan 2021 13:52:05 +0000
Message-ID: <SN4PR0401MB3598437AE7C5617F606ADE989BA00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210122095805.620458-1-nborisov@suse.com>
 <20210122095805.620458-5-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:4cc:4501:d881:6dc:68d2:9b00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be15c8a8-0f2e-434a-9edd-08d8bedce760
x-ms-traffictypediagnostic: SN6PR04MB4861:
x-microsoft-antispam-prvs: <SN6PR04MB48611433C6B683FDF5F1B4779BA00@SN6PR04MB4861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbFQBp+bwtcmbzHCrTQNlWHeBulsUB7CUEcwBp5teGVGzR3JfQTEIPu2QRNRvXN+7Od3nZSXKBEIDTN0AttkVjmUnMQhZmvCbm2j1f650qvFEu8Pp+o3YcvnoU4bi6SiIqSvF+QaH4zEMhmM4vsIqEjgMzaKUoO5XQUOu9U+AD8dOwYd7iUwY8Uc3tM7HNHLGV8wXtJaMbwehGGT81ohEnbzRL4YBI52w8Ulsz98AMaqea0gci3Dc59aewxbFDINhdaVcR/f+GvQllajzw1oz9/yyymyapYtdH5pRcbf00RZeLkEpIvf/7Z8kwuEKnKM0iDOGDE/vM+1iCR9+KiNmYOjmA2wyZBzcBLQxsvRhTsz9aBi2SqaWQCOeavrHb/e9Qhkxs93FyTMlF1aUE6SGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(86362001)(4270600006)(5660300002)(55016002)(19618925003)(8936002)(478600001)(9686003)(33656002)(6506007)(76116006)(91956017)(2906002)(66946007)(110136005)(66476007)(558084003)(71200400001)(316002)(66556008)(66446008)(186003)(8676002)(52536014)(7696005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hEmF5n/+rjKZBE1wZaVGgFG0gQenB7PYH3ZU71JHEMqzKGDF5JoG21O/uOp3?=
 =?us-ascii?Q?iahrl5ATSvr2ea0W0K0/8BNdqrhjYFckAJLQ0liOGIUVY6O6K5w/up/xE+Dq?=
 =?us-ascii?Q?/ZVCwTEQOo5PXuoNuSUfslClr6Qmy2BH3MBcqLkL5vvcue/ryelnp9lpS7Wa?=
 =?us-ascii?Q?o75snDgsQqOx0ZjU4DDxOZRzKUsDaUIeQ0okCIprmr+ReP9qWQuB3opckIP2?=
 =?us-ascii?Q?Daeb/RDoplFduhbs+6myy3vvRZOIGhcAqhQeGMBwlp84keOJ4th2unbvTcch?=
 =?us-ascii?Q?T4pLm9/NmKpm/ne4FdTrbn/ekUa4uRwzDbXFyrSYr+PqwaEKd3uy6Ze+if5Z?=
 =?us-ascii?Q?rZaw7GKs/4PP/exjeHtl1wtPzlYt8fBFgl8ZeAA3UKcqsXYWohZ7hIA6odnv?=
 =?us-ascii?Q?U2IcBmuMRXrX+0fjFqBxyIs/y66GhJKa7cMzAH0kjiBVUYRUxZpZ2ClcJZVk?=
 =?us-ascii?Q?7PgXX4AyZHcKITtut++jQAUwwyAgtnw6e79WOf/PBgFYIcvnSb3y93zxlE4r?=
 =?us-ascii?Q?FXkGjIAwE0u2/V0RfvR21ut+MTMbVcr9oGcFkz9AJ1mAzGWZwiHVxnDQPIP0?=
 =?us-ascii?Q?ahCn22+PVabkSHbhO+otn5pddw8KblbgO+/NWyzQbvDV6n+jKar6clx9RgNm?=
 =?us-ascii?Q?0cQyghB1+CsJ0ypIeHnmhXFM7j9FK3EM3oXaW8jbbJjtGL0LnWaVvoUne5jp?=
 =?us-ascii?Q?Y1ZH3RG+J0IOdXGVeSrQItHKHDZP7qGSLwaEl2yyWTephFm+iqVCX7sh6gHq?=
 =?us-ascii?Q?LcEdh+vUX+afabLLL/T9JfC5yJrFnxm8H6+DSJ5+RSMVuBbyP7YAoWSXTKbO?=
 =?us-ascii?Q?9z9SwVLWeh9Dnu4EJGwsl2an52Tn1O0NEwBFVNJVDzxx5Rd5gLM51khnqEyA?=
 =?us-ascii?Q?sQF0i2nd+M0yhoGEOUdosmPLExoljuV4iSIqchXbfZNMSVpU2I9cEYXAeo6K?=
 =?us-ascii?Q?9xu7h/gmWYAe0wALI85C3cSQL0lSItAAQvyaZE28d/82hA9JChuo4LUpLpKo?=
 =?us-ascii?Q?DBaHBIw0KOcQAc17caI8xQGSgUKHpK7iI2oph7xYJPhr81IELi1qG/+Kx1M6?=
 =?us-ascii?Q?joiUkFb2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be15c8a8-0f2e-434a-9edd-08d8bedce760
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 13:52:05.5417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vB40xSKJ4cLnEQDwHFcHLLHiWFSIJFsvvcOfFrxOSfjs40vfhq77gh395BrRqP5h2UBRJ28c0Z9ZEv20KGzABDIuIWs7cWM0FVc9R7mkGEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4861
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
