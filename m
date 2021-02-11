Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63014318C1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhBKNcf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 08:32:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14850 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhBKNaK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 08:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613050206; x=1644586206;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qo5irmZ0a1ukPyiNiuvF+C4SZTlnKzweG1rRSI12sOq3jpVfy+csqMUr
   hemEJaahG3loNRMTDzvUMGgJfyuSqsE9x6Zoe0e0UPINzwZ/uMj5C9QxA
   hW2FVJ0RLuBRCdG+EnRz2clXgcZsz4rQlp2yTeWQQEHyis03t4/KMn8yd
   wgqcmj7qGpBS5xV5cFil8kG9FW3opwKh/0DYaMmS/3tZSItoYgplv00Wb
   j0PQAYJAaDhrSbxAdI7fkatsMuiJx8GyonxM+b2x6MuxiEtxKorLktVpQ
   ket24WBbxSqP7lv4jAp8rWIyDd218imSMHwB2bI6ZV9NR/xazJGJ4mHvP
   A==;
IronPort-SDR: ak622B/DQd9B0YulF44fDR3kFPJQMfoRMqY1Owo0Njeq2ekj1wnSMFxeiRzyWy+zde26mcY+YX
 DFoPk2wh7/1ytI2mLuTXtOOoX2PV5J50FhC1I0D4RmGpmB/tXogG0zsVLk3dDi28omfc9jhvPp
 nehI79HpRrL32hblzb4H8sXlsrIcegozeNWqGRgocsTqaJRVO6ED+xBAIZlEekEMXsOOx+Agvv
 AhevmHJ0hgW7p3eS/drlDAbqpf/8j4NDXUBxwxKRAhl9KXvHfE08WenY8GWhCRb6GEPlQsbNQe
 izs=
X-IronPort-AV: E=Sophos;i="5.81,170,1610380800"; 
   d="scan'208";a="159744741"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 21:28:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wca1Wa30BQUBEQiR7JuUm/RRVUsRAKeWDfjwig5JB7aAkU3WCV7cWOrbKn273lE5lltOYMpvjSLQDmWV86q+vRAQMXkT7JcCsf3luu4A7o7G3CIHVFeTtwqhypenhAthMKrkv7FqLuCRsAJGrHEXBlKqBMthYBD99X/xuX5ApV+LKd+tdO+uR2OZzFFcI8dGssloL4sHj+fM7zkFMfj6+fWTO1D1cjEKHLR7Q0eIhDJB1/PD4bqQ7pq3eOoLMpkWZo/wk5jy2+ZAb7M1MoVVmhbGeJx6HzCAG5t0MUUlK6N0zIe3plth+5+Q5chHSgkUywtZmMwPGqQJdLl6lYJzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dwBZGt3m+ydMhAn6DR2Wxu2SKqsEsyQBLQX/leInqZX1V5QRURlxTzYZQubvq/CDSalp1qUghQUB5kdrtNbQGSMpMVuVEJuX4Q10x1wte+dP8Xx3aYCFlvauDDKH6Wad2WjiahNIFRUDvfWX40ndcTiOJvWs5cMYW3WN9YS5q1fLKh+69Ah1oqtg63hWYaNIsgKXk3HAYseBzTR0ZCQpQMb0/YkStVm1VFTX+aScq+CTWHTJGrXuLo2rICWEhmXrodT2LxlLNd4/hsqRCXz5uUAHkHJEtucBzN63QYy+HuIAgqCObpeLSLELnWbV24gQ2CsFKo99OmbCD6pU7Jcr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DkUfRgo35iqrRCf9nVYhXLtHlgKU/oHtGwgFJr7bmm0Ia5KVA2EbrsdDt8TbBnspias5mH/XYhRJPX35DfRFkHH2ajvqQq0Tr91hzsMOqe7E2su9lgP9YP/OGVOEqIUXVzJoTPamMXbtDUada1dGPw9LODZwzhHPQBE6XCaOZrE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4606.namprd04.prod.outlook.com
 (2603:10b6:805:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 11 Feb
 2021 13:28:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3846.029; Thu, 11 Feb 2021
 13:28:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH 4/5] btrfs: scrub_checksum_tree_block() drop its function
 declaration
Thread-Topic: [PATCH 4/5] btrfs: scrub_checksum_tree_block() drop its function
 declaration
Thread-Index: AQHXADaoKX9+KUmeokSuTaNS3vYrrQ==
Date:   Thu, 11 Feb 2021 13:28:50 +0000
Message-ID: <SN4PR0401MB3598113420D276C83037B7729B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
 <b19539f16f4292749e201032459f5b2686709f0a.1613019838.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f13dab00-0a68-4b1f-879f-08d8ce90f870
x-ms-traffictypediagnostic: SN6PR04MB4606:
x-microsoft-antispam-prvs: <SN6PR04MB4606F6306913BB0E8292AB239B8C9@SN6PR04MB4606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQDms0n5xbKsr0zIqbQLer2Qyiynn+MN73L31PGIkE+P02nmDo0E7BQY+M/auA1NadRjLIkpOWykfmUav0FcAQhZaMcPVMmU+3fLaI1mZ2xIjtyUtMOBcXuo9B1OX4vjNcxQt81vhh0xOMXJXq2uuR0GlVAWTTFmiHDOL4ixqTtiZULyUbjYCti7pX+UT5LjK2Mu3YGlfIescWEbH84vbm1A++ttsRHKcH4rcixVDBeDuZSEufbpuBdViJsoKXMpCDav7bq5qfUQOnMsZ82ZwlC38d2IoSUnFJoZpZvTfv3LYkcTPEatGwLQIIMzdKNuT9p8EnnDL+KyV8hTfbc6qaC7Rdv2ft56MQyyVdiSIVQS/ikuvDyKB5UMbim6N2ssYwTvQ0iUmXlj798yYkQShUyjcs0t5bUJ+9HE68q4C6cC0HuzX4QBWsniCI1zqrga9usMoOXpHoH/sq/QocJcQgGhx4cLN+04lwRfxwQCptf2J/P5MRXJYZCgq7t3ONhDFJuiJuo0MM8TndaO1QIFhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(86362001)(5660300002)(33656002)(66946007)(8676002)(64756008)(8936002)(186003)(71200400001)(76116006)(478600001)(66446008)(52536014)(4270600006)(91956017)(4326008)(66556008)(7696005)(55016002)(9686003)(6506007)(66476007)(110136005)(558084003)(26005)(316002)(19618925003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SLgagJRs/K+miIsTpPMPkKnharELJUcPIPEYjWkncRVg0epLzablEYgfDpkB?=
 =?us-ascii?Q?tpTlWriKHwYcB03vtZY1LKPteQICRHoV9gX/Qeias/Y5P3vYl3geGArJHvro?=
 =?us-ascii?Q?P4R7fHZhjWgbIpWV+CXSrrQ1zr/FEJUNkKS/wx5Pl2ZK5JR+XqIic87Fhz9q?=
 =?us-ascii?Q?cezNdzr5YBxgMvm/p2NrY8AhnLrxdwcrVDj/hP7ouh3g5T/zfE6KMPcYMvOM?=
 =?us-ascii?Q?qL2i3iRW5sN9QzXduHDOwgR8Z3pC42bVgJWDFvsu69iV66KahLrA+XAJYQ+j?=
 =?us-ascii?Q?Q3jyEGiIudkSzZ/H3raa39mpLpNHUmrcNc+xtgc97vpl7YYUpPuFnGTLWjdA?=
 =?us-ascii?Q?1p4PlRox4HdN3duadoJetVkxCFbQcVdKd4G5Ps4crCODO1En5wGDnSyZZmr9?=
 =?us-ascii?Q?rBgcPPl7NGrEgR0xsEVRVBvvHExUOFWQJXFQFFxtcmBo94pf6RtrcBroXO6w?=
 =?us-ascii?Q?9X76Bijqq8+urNKUtlDs/mK9I9NUjh2VQvjPSFWiFlYoV5IOmaNYvy1+CmEI?=
 =?us-ascii?Q?7WZ+EUvRiH89R9us1TI7gSjWZ1bEKdVmfKDbTlx+YzHnV8BAABMJg+Q6GvwI?=
 =?us-ascii?Q?DFy2tLe/Zuos78H+DRUW/DXbvrnkvLeHvRTKX7HT/U2YKfcXWChuXQobCvX+?=
 =?us-ascii?Q?cV3DAad4uo6t5CxEPjsKcurdKLdw5KBCaTsZmfjUJO5QA9FwtXl9gbvIO3Bh?=
 =?us-ascii?Q?JtInFUKHNG6tncyc6kbjSHL1n7mXr7aGVgQrU+8nDJyDDIhGAAxZxbqkkHvi?=
 =?us-ascii?Q?KxZyHtTp9sNowHDr/fV2yPw7O9zMe8NeEgjTTIirdxPH9Gri2iaaNb/S0RKE?=
 =?us-ascii?Q?qxsv9tl9HR1+Bzbbksj52TyTtkaae7yqLBzFp433PPz7iXG1DFhzEBF009Xb?=
 =?us-ascii?Q?cCTPNXof4SVV1drmiAQwQVtmzYmOdBDC3jmOSdFaYcG12Z3MLnaPw+vIc5GW?=
 =?us-ascii?Q?ERHDbkI4Kqpgq/mWhi0NKrsbFZUKEsLEYUY5WLkVTaxOmdwgTjMVWKnkYiYc?=
 =?us-ascii?Q?6UneZZY5pQzl8zIzja8lBzs/r9zTLQa8vdjONsfQ7mlzV8zMiTAFMi+fmAAR?=
 =?us-ascii?Q?345YQAM4j8oZupfv40ccclBhTtobAkYY5dI3JrBdPD+GGw/DiaWX8y+lWk8r?=
 =?us-ascii?Q?x0U7MQH2JO8GlMkxKYDfrBAmm2BXK2St6sMjEmeSSCmLPoESRk9QCsk8rRGc?=
 =?us-ascii?Q?8gn298TqEUhPMu/5v3D/3gnHCGchZbdUMG3HR2WrbYdkHRH0xbAZsynQd6sA?=
 =?us-ascii?Q?16V078159LJ5PgbriBA/COuqL//FelZLkqnnf+WrExVou9+YL4mOMxoTDvJ2?=
 =?us-ascii?Q?Y1Ou5sSYmuzPOmVGI/5a3PAKIgy+IO0BP+3HGW10f/YY1Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13dab00-0a68-4b1f-879f-08d8ce90f870
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 13:28:50.9952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtPitk0rqVNwHGBwKG9mb4qAnDRxhYJmGFAqUaqTsiWaYY4iUHa83f86N5FCVdS7XwNAcBVt/6ewsKoWLkrEZw+/snWqRGTHyT//+B+d0bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4606
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
