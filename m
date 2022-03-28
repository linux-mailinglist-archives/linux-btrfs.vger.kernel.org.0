Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F44E9731
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 14:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiC1NAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiC1NAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:00:13 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046021CB34
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648472311; x=1680008311;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tnAh/5kwTKi3+nNPM4wJG3SISEWzlVfjvif57yVY4qA=;
  b=jntZoV+ux6SIjanH4qBAlTuw5Cr37wwde83rMVTVsrJTlrJ1sEADcaj3
   z1mAMBMGDtrQNG0Kl7WuJYrSBRWpw5Z7WS7Nn/ZJi3siZcoJp3M/I7SuD
   5C519BkhRK+vEkdEL0nYyuDGfjnWS4dIxu2BhAfFN7ezkrhuTbgSLRk72
   hnxO2K5C6DVq1sY9JZpibEPg0imbo3uUsL17itD9PK7axDYV35mPhK/Pv
   TlgOneOXGSfmD00dfTg06mSqcaYkTrrDlXrUaQyv0tiNPyo49F7shMbaC
   BIuOPb3QwiC+KQJJotIlzIk3zxgOQT5X2qv6WJ/iR++Y0wBf2hacz+g1O
   g==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="196447527"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 20:58:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzDYmVwrwRgY4KfC9fD4JZSqBjdKOCL/8lM4mNE+ye2HnebBbgsGhGBMZCp3iATH9duYkYZ2Ry9Cg3M/5NHpgRqF895gDRAksxpLrPuYuhsy1+uvpqxYdgd3i2J6Ij1h/aWkCZHpeDEIWg0T/t5BCwyX3O40kPjAj1aHjy399vKqniRWhCymRReNbUnpk9pD0UUST4cw1NKxCNIZFztxvpb9FUuOyI2ZX5PiBVtAaCsz62VRy6c2CCeQCyzjcyb7lY6fRQjJsfDkk7cAqlFUmUqd3wDjafBQ7+ilF/54qkY2gOjubDOYm9ZRPRxnbCspNE1WEW8ibuR6G1wafa22Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnAh/5kwTKi3+nNPM4wJG3SISEWzlVfjvif57yVY4qA=;
 b=Vxz0lfl7ap/6A8oIA1XGUQT9T1q3EvRH5bfepekvYslzXBF9FyNT00iwx2E+eJOvaY2bXhm6WWRksaJIJMvUuDAZxEKm2M8NvcYx4ad8zW9LYgMcX/SP2euwykKCdqpOTIBNg6lQfcu7SyL53ah5VeHslZry2YtXaO9rg8FY976bVOgJA2qSYtHpB5q4kkl8mCMkSnyg7/uoWkX61AWzPQf7E6S5JBEGj0DFleYgUo1V6gjpghWwRrEWB2rw1fv8nHZ59oGUtZY6qWvmoKl6t30DlKVVrkVp8F+qaBXa7yRup5oWPuMYKob9js/KMX3zkSqil9U2v9mdqE5Kw0np4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnAh/5kwTKi3+nNPM4wJG3SISEWzlVfjvif57yVY4qA=;
 b=q5mQgfGLBAlqaEE0Cj++xB85FdyEojaCFBI58+VB/wDkB48YX2JY0FBH10noQSbs+aWqbE41dUx29MX1UjcTiCY+wtWIDhzXPPmhhKo7FNGJEtoIVwyMO8ErpEQc6MIZabvSDvvVvmm05HTQwCoAbziMpy1amx6x5m3OR8+4Nro=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB5165.namprd04.prod.outlook.com (2603:10b6:805:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 12:58:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 12:58:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Thread-Topic: [PATCH] btrfs: fix outstanding extents calculation
Thread-Index: AQHYQp/pD+O+D6y0/Ee6vtk2aMtoZQ==
Date:   Mon, 28 Mar 2022 12:58:29 +0000
Message-ID: <PH0PR04MB74160F3F0D815331B6B498B99B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d862571-d670-4836-aed9-08da10baa806
x-ms-traffictypediagnostic: SN6PR04MB5165:EE_
x-microsoft-antispam-prvs: <SN6PR04MB51654C41CF6E527A708B6ECB9B1D9@SN6PR04MB5165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0d8qdA5jyTsm9VWA/R1vAIx5k/l7WTIik/xGb9tf4aZ+nLmvep62675IKzwzCKLGXjH7rNrKrLgeCVyIchkuEvp4xNO+udMUFbqmx6GLuIj00OTm03H/PHdczw5ZUaZaoeOuxWsHoFsUKE7YSU0H5cgHqheu2rd6bTDelaXfP3pjoaBB12HcUyXBCw5N2wtBb2ZSOy7wLHMHJ5jh9TaRAmU44rPMug5F56YWgMb8eDp0nlpk57zMbHHGfn7HmMhyPsf/kLNR7L0Y19NCABispQpTh98sYf6uoohFY415aPFQDE9DkP+HOm+RauqNjDFjn+LwBtH4eZPTvm+pO0Cuws2dw6Rr9BTcJPbHkYtQ8DtAztcdzbnS/dXyxNuao5Fk36o4lD9WqHDzgTQhNK901yxxvFjugtOkwytssHTTrCfCivX/pNZPpfHmbpD+/wr/559pgEN8TKr2eX1J4BpWE67BzIR/e3LHKnYOR1lzaOOwDxiLTEJfrnKzA/lhqbOYTKgFsweZLl2uy+zFEIi93R4UHiqIMImC7XO8+w7Sbqq2T31oNize5rnWOI2bbxVgJSCSkwaSXRdAjoK7PgrT/3yQhmaJiQFll65m0318N6iqHYVg3rPUxtFrpJSDPGY/ZltyLKexvAUXW50tzOFegJXYwxMOaYfX71fuhBVDX8JbKQFJk8KyqKxnz/WeITLD+3xRaI78QI3LcDmQ86zulg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(558084003)(7696005)(8936002)(52536014)(6506007)(2906002)(9686003)(4270600006)(5660300002)(55016003)(38070700005)(91956017)(110136005)(38100700002)(33656002)(76116006)(122000001)(82960400001)(316002)(66556008)(8676002)(64756008)(66476007)(66446008)(508600001)(71200400001)(86362001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zvp/24bddHdHQgPmb7rnMZMUPN2ec2PTL/GKnKiXW/NzKB5+QkzA336W0uW8?=
 =?us-ascii?Q?Z7I2DcqdGDv1UsxMhSuUD9jsvRhZgnnr2wm7aAncoCQVYxCJL4QzuFJvwWN7?=
 =?us-ascii?Q?XFayeSHlZIf7+gEfL8hQkyFWAPK6jD5iKXXeRgSkxF8PeN1uh0qw0xrdM7pW?=
 =?us-ascii?Q?MglLoa+OQywxNA0c7TnlbZQd2onjogjFA5ThQjTNPhLsdFgCQxi8gASnhSoj?=
 =?us-ascii?Q?Al6GGBLuiR/7+hZrC9c/JdVJVYrs3uSMrVMW6yq0W5vInlIjCArYAF5moM0o?=
 =?us-ascii?Q?OWSwPiXlA3Ok5wYwb/7WMFksLVbcAUOSNDYaAsCzom1LMiPn9+h1U2bKLkP6?=
 =?us-ascii?Q?hCNB2RlB66Oir+i2Fps2IHu7/267+HCS+PXX9MxktNPR+6RVdlsSxBmbeR6y?=
 =?us-ascii?Q?+FrN/1TWJLg0eBpmVOHBP8f4gMmEaFU2JQWyBz3PqEx9/dZEjtajY3OLrQVx?=
 =?us-ascii?Q?Sc7n8+PMTho4OGSOtTH2wZIEl3IG8pMguA73iHElRoDTGeZ35NWMLmJwvQnZ?=
 =?us-ascii?Q?0KpiYTxkelo+NQ6NARkqBqr+/onzPMh1wc2r9KzMWN4Pw/m5+qRktU6zD7hS?=
 =?us-ascii?Q?XRLQ6tuuDvhgeDEZVR2n9p6gGPz1JPPJ+ZeuT5ccPaOQxPPgDzyE/sCGKTyw?=
 =?us-ascii?Q?h7cL0xcdqn0KykiXYLafU4xIwhX+wMEnD3sEVm7px27kPy22/kmnVkaC0RIS?=
 =?us-ascii?Q?sb8K2UnI5nSc6CJNshfk4kPIx2dzs53s3eg9NmTq8NysJPLq1XwNGDpQRVKj?=
 =?us-ascii?Q?boUzL1+0GUGnBWysknQhacrY7kklYiay5cDt5g7mxTMNOyrQMwY9w7kYuqy0?=
 =?us-ascii?Q?E8fkUCYMD1wprckLzsbV1qkJfo8mWg+X5KVeTnz++gOreRSbuvvPdGFyTzcO?=
 =?us-ascii?Q?+6V15F98rzrQBhQmagtU15onseuor2plea0JLlf9Dq1Q3nWidN5qtNac8Pzn?=
 =?us-ascii?Q?TaLm+Vf5mgm5kUA2CiUvcQrta4gKurlUfduoxKVii3L/Mah+rIt07pBL1SMc?=
 =?us-ascii?Q?sofuU2x+NHeNt2sQC74kAhYK17E7V9ZqKWC54lIK17byYHVgI3dnn0522TDU?=
 =?us-ascii?Q?yhntSTdZNSIbIl7MWSesIi+jEJjTkQ6u1TBnUjo4Tur1T8BOG051SpHgDcOj?=
 =?us-ascii?Q?EmoQYkbaRiYSjzqE/oYjwrnx5NEqfAvv6Ug0yc/H8JIalA7PNtSJqHejg+p9?=
 =?us-ascii?Q?kKUwJ4C8IyosSisO/8n/nl8HKm8wSi4N4i6J0a7h0TAWqgczzJzIwb3QRPl3?=
 =?us-ascii?Q?gCzLz990r/VoViJePkjdyxLUF2zDPFe79KtYPMj0qjDDe7+42MKxyPx3747x?=
 =?us-ascii?Q?iMlnHzQ2kauvi1GyFsH+Yfd3+wQBOqyLhVGPzc/CSdJGAuoygpMTiwR1oj3w?=
 =?us-ascii?Q?gYdEjBgrQqsiBG3zCStUoh/wAKzzhuzLJBrUHDPJz6LdiyCpVerxupdQdVl+?=
 =?us-ascii?Q?q3pp1Zyoih8l2I7n6HN5rssl0CJcQ0CHUVnSnvV62RSHsP36Xi33B0ue7X8v?=
 =?us-ascii?Q?ofAobjjR8tEosvjpVQefPXGTmFXQUhnautdCItdnJOCeHGkaBFDPbsKo8Uby?=
 =?us-ascii?Q?U5tel7elcjnQybIpDxXy6Ci/oq5pLtIdHKbtbvS1akHKr0YEhyfFrgMI4ZaO?=
 =?us-ascii?Q?yPHeWM8ep1HZSE65QJQXk4VcQqJqD1Pw2jMWdN/WPMhi4epiCsEHloByAU6g?=
 =?us-ascii?Q?Pi/hajr4RTBEAydZGD93PQMoVduHSEw6xLX5lvJ118wzF6vIOBOkFH3iJ11t?=
 =?us-ascii?Q?l2r0Samlq05l9nTjUWlpq10lA5b0iar5KN38hSaOEqm0xAv4slZfuYn0vfIt?=
x-ms-exchange-antispam-messagedata-1: hbCJJXl2ebcTOYoeSpJaRsyNU+erDAnRgMm2D1CwbR+rMamIVzF9KU12
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d862571-d670-4836-aed9-08da10baa806
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 12:58:29.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQf0mxx13Af8DWcPI9tk2NqenaDjymnUvPco89r41JpegxYiFDAmlV3KrHYl+SdtwgB+tC5bptCoPTn7F0EBw6ssROdXrY0agpD7rXLYk8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5165
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
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
