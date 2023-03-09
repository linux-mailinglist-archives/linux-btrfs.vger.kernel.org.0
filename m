Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832FC6B2958
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCIQCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 11:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCIQBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 11:01:55 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD294F3670
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678377714; x=1709913714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=L8JorlTEJ+C81fcGT9FKucE/tUMrzjVZoaj0YltftoFosYTr3R4S+VkG
   Azj/c5vRtmH8yYYQpdIgU9YfHC8RrgWdPHS7igX3e2M+p63bHhoWvdrIg
   PUIS4RGn8D5UM3xkDI8dlfLIkoHgLgp8fcmDv0SOeiYWg7mknU35Xng3q
   hdWFU2drv6c8aSbzB2dBDr5x4xk65BImbZsgvGRZsb7VKlpZdThdb+0uS
   KFnrXn4GpNJrId8lvUvai8DiFa7BWxE+ipTdtaWmWNxlUzW1Wxud9KL9/
   HHxKn12PHVduO+Np4N/0UWe1U4djOPfbBBUtqajOkz89xCv5rDOLTmUeT
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="230191567"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2023 00:01:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjGpN0qfdCbcdcvUo2RlYwVX5YznUkbSFfokyRw0WPgR03sdD6RYU86yVO9tN7x8i9Nt01OOauCk93ZxfC0dKUoB+moBWKko+JIaNCXnNnm4wWKBraVsvApTVyp6NAr1qII4qtH/9KVJJjeXCpJpbuwTZMshD5QWlEQs+ZKJC5SqnqGod89jfHj4RA6avThMb3yQcfXMwF5WXoPEYZq1rLgNPrDfi6Fmu4K7nh1NvpPDoD8Bq9jsKndTrzi4zq5Znv7si02+q6lYn24Fmunf2OEe8CEzBaOhO1CAyAA5XIC6NUQmFzsb1kyvEAEQNmLgvnrLkoBC0N9FRbX568Xd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gw9hCUgE7yxFaqq5CsgHMTE0EkEOmJAJFYRaRKUrz+ZUfcZ0jVRQImbNHpvensNtZ1iQTCApcR3gomij89PooyXurPu+ibAfCxI9ttTrh+O4OHHKuiBZNyVAXPpYEtIq4rgLN6Qb6hwp6/yVNGuqBm65YEa3ICNbm/G4xA3UHeFh5bz0RmqX/AlIq6IlnazxtddH28C1yLmlIxwGNsVpZMDmUs9ZBQxJYGhlCy2clcZOmAPmBJRqdIjv3qbyd4QMC/3V5BmfoeyomzMh1KZp3PrgVehFEu6qfU1TD7WkwDCfRqrT3djhDNeYYyxp6lKLeuwLS23aa4LYz2ChCKteXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ec8/GKp5s8hnnDTTt+oPw/NVVTcYdVK5ZD3/T3eYq6Ts8GrlWLyLM7MnLoGwAYilt+aef+6CWjMQ3mkMSqoQCihagutOirFi+SHjqiUXl3Lccjw8apJ1SnET1RC1wGHpJElS8WDuY2PwDFRU4Aa07n9o6S4HMSG4R0bT8yDVEAg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0691.namprd04.prod.outlook.com (2603:10b6:404:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 16:01:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 16:01:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 15/20] btrfs: remove the io_pages field in struct
 extent_buffer
Thread-Topic: [PATCH 15/20] btrfs: remove the io_pages field in struct
 extent_buffer
Thread-Index: AQHZUmat1YAg7sQ6uUySrk8rtsyipa7ynBMA
Date:   Thu, 9 Mar 2023 16:01:43 +0000
Message-ID: <a7da57d2-681e-f28b-e3ea-14a30d1999be@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-16-hch@lst.de>
In-Reply-To: <20230309090526.332550-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0691:EE_
x-ms-office365-filtering-correlation-id: 8d6a784a-0278-4a65-91aa-08db20b793d9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RsicBSoFJaH2O6faIGAv9X8bb2WmIDlqWM5etEq/NALq4EB5oVbYSAxrupf2w7+aZchrNbayvsvbNPpYdV4YIVWCD1gP/SqlCvHcahjwj6HupgsCEhtVAKdy/r/LpGXZMCb8dCYOD/rrt7XW/UrJqijRKyBLCGDffiX0qr8ytKhgDSqB+dhOwespAnP1ZXE8AfQbjyqG/N4b8rUk+DyBAlkyzf+6QUGgeNjlaCOZH56BSux+0iIqAXWkIfxWuzITlq3RvhKmU5IDzvM226KgywcoeSJJNJikWfanbHhrpdRROu15Kohhjgn92fQGLteV9GtegW1vJ6GchOAd/T18Nz3pfK+Yq12jUUKDDYLjVOaYO5sZD/Ea1SvqdYVFbA1zsRbo6V6lKkltt7JUDnO7OBAnmHADQnW98YQ31AsTYJuKO+Fl/asopn7MDEWBzTPDt2+8J4KOowQRA3ARNrjx4P4mS8yn0UbTMXKnG+QCGbXnEgv6WMRLxTgYkxbZzMTzNGAH3vc+ZQ9cZ4x3/cR5rfts9TMU883FZznDuxt4d+9QTap9ZmSjdztYlSh3TQTrTLFZbuotHKmfnC7Wesm2id5TW2A5FZi1dRL4fii22uRV3adxD9f1Lz7YgaPYyEwQuV1ypHnj9rkJEms3yS3zT5l9aKH7Li0t9OjLHK1y5S/Sy2cw1h1IsxYSyOOnLhI4Px3awP0NVinEzyLDJaP+QojdLOnFMByXtcKA/FTZN+956jMbVBdlMJSbL96VoSP7lmuIEeuVgAlAVwEZ/vBQIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(19618925003)(38070700005)(31686004)(2906002)(5660300002)(66476007)(36756003)(8936002)(66556008)(64756008)(41300700001)(31696002)(66946007)(8676002)(4326008)(76116006)(558084003)(110136005)(66446008)(91956017)(316002)(86362001)(478600001)(71200400001)(6486002)(122000001)(38100700002)(82960400001)(6512007)(6506007)(186003)(4270600006)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkFYZ2Y3czVvRXdpSlpBWFBSc0lQMGNWL0Fra2M0bjBlbUl0enB6T0wra1Zq?=
 =?utf-8?B?S0ZNeEYzUlJEOGFqQjlESVJoR01JbUpkbGxPNzFYaTFnMENSK21PWS8yR2tO?=
 =?utf-8?B?RjkyNXRVMzFMY2oxSmN0cXJjbHJrL0NwVHVFV1pSS0FaYkRUdUFwL3FoY0xU?=
 =?utf-8?B?NWdIZWlKY1psTE9HbisyazI3Umh0cSsvS0VXaTVoaUZGL2FkekFsQXdtQVhv?=
 =?utf-8?B?ZmRmczBEVWR3d3hpanA0MmJSUFlLTmJsUTgrd01qaytBQjVNV0pmQUJoRXFZ?=
 =?utf-8?B?emh0Z3hqVmlKamVFbHRaM2orazRvZ3NCNHdPT2RsZnd6bHhOSDBmNnRtd2Rl?=
 =?utf-8?B?a0FNMFZleUk3Rm9ZQkJsRUtlUVRuTVJoM0l0V0NwQXNjQzlucUFndlpZbzQ4?=
 =?utf-8?B?ZUhkMHZkUnB1UkMrWFdxOVdGcXprR1dLV0VNdEoxY3RlcXlQSC92dVFBVkhB?=
 =?utf-8?B?bUFmS3NUQ3AxKzUwYlRLcFV4cncwOTEwUmZ3emdWcWYvbUZ0c3Z4VUxlbGRV?=
 =?utf-8?B?RXVBQWwvbDlRNFhwNVdKRUt0VFRLTGRjVDJpeDUzVXFCZ0I4bGtWb3VnYW4y?=
 =?utf-8?B?UlhLQ0NzQm9xcEVRRC9RbFJWVWhJSGZYTm5HSWJqVnZNMy8xc1VtTzRCSDB5?=
 =?utf-8?B?TjRBZFVNZGpmbGJETDJKWmsycGw4K3pBeWpQWFAxbzdPSzg5OTZFQ0NWaG1p?=
 =?utf-8?B?Z0E3bVk2UmtsbGU5MzBqd2dmRVhXb3hMZyt2UWF1YVNDQlN4ZldhQ2NWc1gr?=
 =?utf-8?B?WkxkM0l4SEsxUitIUjd2cy9KendzRHUvYUdVeGQxTWNGNkFFTm9wUGdlb3Jx?=
 =?utf-8?B?ZElOWFkrRW44ejRsWXhKT09DNVZxeXRrOTVGK1dCRDNjdHZDT3Y3Yng4VjZX?=
 =?utf-8?B?djg5Um1pM0FQdzlnbk1RTzRWRzh1cnQvNkRGUzlUcU9PV2Z1SjJNdFlLaDlI?=
 =?utf-8?B?VHF3Rkgwa0xXYXhQdXYyMUM2ZXhSanBsNGRsV3FiRnBVVWkvSXlWbVpMb1Zj?=
 =?utf-8?B?c0ptaVkweHhHanRVRXNvS1B5NUtNMElLRnd4V1hSMmhoekVyWFFkR0VOd1cz?=
 =?utf-8?B?UlVpOEpZcVlaNG5SR0R2cTdmNDJKWHltS2FyNG5ndTBmcFJQdytxNkFuT2Jp?=
 =?utf-8?B?VThJd0hCVWk1RUFGQTcxUmhZTVNhb2ltU2FiMFlBUzUxSVh5QWd0eUZGcnRC?=
 =?utf-8?B?b3FER0VwVDc1WWRIeHluN0Q4SmhOUFNRbHhtQWdiaUxHRWFWb1VqNEtmcWVk?=
 =?utf-8?B?c21zR3RrNU1hQnJLZ3ZZa3FUZmxXRDlkY1NyQzJzRm9odUthenZEN2JuSU44?=
 =?utf-8?B?VUUzMTMrL1pYL1ZncFliTVNEVFd4RGVibUVrSTY2cUk1KzdjUk9aT2FQMzdt?=
 =?utf-8?B?V2RpTzljaGVRMjNwaFpuVERsMWUzakRGUWhVcmllZVZvL2ZqVjF1OG43YlJB?=
 =?utf-8?B?UEVvQ2hCc09kNkp1RjV1QlhUZldKQkpkVXZQWDA3ekYxVFVNc2ZqQ1hRUFJn?=
 =?utf-8?B?cUZtMHdzUGZ3ZEtvOXllUk0yVkc2NkNZZzdPdnNXZU1UNzU3MmFuUzJFaFZQ?=
 =?utf-8?B?aFhOYURVUjZocHVtcTBZWGNXSjF0cWh6azh2bDliQ0tNT0dhbkYwVWQ3VGcw?=
 =?utf-8?B?clpZSnU3ZVAwSlRmc050SnoyN2xPVVBreUQwbkM2TGRkTnU1L0dEOFAvd3lh?=
 =?utf-8?B?MEdpVEl6QWx2VVAvMmJ0cWQ5NmFsUHZBNWdBMU9IejNweU1Zb21UclZFWTZs?=
 =?utf-8?B?SHFCa3ZWOHRvVUUxd2tNclg5REY5Z1RYdUhtL3JaOWNTNEhjcXREbk5aK3RZ?=
 =?utf-8?B?RW5CN3hubWhQOWJPOE8yckRua3JRYUIxODgzZytDNmtPcmIrcFhIU1BsK0gz?=
 =?utf-8?B?dmJxMHVVTjR3aVEyYnJ2Y2JyTzlBZmdmd2JyQlJaTTgyRGk4UVRFaXY3Zjcy?=
 =?utf-8?B?RHQxNG5CeVRGdUd1NThlZlBSZmVObVkrQnFJaW9uVGRzZXlZR0NQNnJRQUd4?=
 =?utf-8?B?Z3VhdEZWeVpraGltb2kySnBGLzhUUVBmUjg3d21iSk95Um42NkxkYW9leTlF?=
 =?utf-8?B?ZzJZWHh1U2RhTmR5cEJud3FFUGtya0FlU1FEMi9YNTJEMUZpcVpLb2ZsWjcv?=
 =?utf-8?B?NTgxTXdlamJGMmNPaFBIV3phNjh1WFNyTWUzT3FJSXdocGZvek94czA1TUdS?=
 =?utf-8?B?Z2wraEZPNFpKWDdsbjRORUEzVHk5YUJabUN4OG1DUHVFL3lLU0JHc1Bvc0N5?=
 =?utf-8?Q?TjP66kXvoNeu53d74eupZkoiZqnzII8StC5YHnJw0g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E305B43980EFD448A4FC584683CED9E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KRemynXMsxLvJxcSpYKZz5u+YzCzTDaiwcA9gbcgmYOj+hj79JP+0q93qfiwkupN/8YsvlN1aq0/+kkvuTm73ErmXl9x6ezg0Ni9Lp+K5O1XuigU8ATzYNIxon7bLOejzSYC6Xw5GLNGwUkj6hM6IAvEo4zQRbiiILscjt71fP7REn6a3cj20ILn5dsdu8fHJsrAdYn5dZ8xbGEEAHEs4h+YvfmTfMgNeIf3Auon3LagA+ikkUnpIeyssRLHTfwVSX0NqvdUihNC9nQNVvV4Pp7kyfzJYc84FuI051U7Je93uyw0GORqtvFLJAEHdf+rs+J8y8m7DDyvXO1qo0tdmwoe9Ud7XHXk08EyZKRMrV6nbLPy+qmBj+AEaSvflUdhZTbRfYFq0A2ckcv6qp+S6N3jdD3tLCXgHBxIx/TxNWakCL0P6lQ/0mkA5I0BS/5yu/RJEu5V0O5stlSnH3+2vA42nHKBr4wc3H25GmI87lBXJJ+VgmhHyuLV8u/07vK21CdfTYraN0OtVKSzh1mbaGvVtySqdmNArp844NtZMZJUG867/LNPUzVOJOMZfKlwz1N25HGwA0BvAUmG8ml85B1k2rSG1qlJh1JUj+QX6ijLleeWXqdT8Lx8myjWtHU/xozu2Zg5QmHgFn2hwTr79VdlqUZez9eDttZ9kYiJXdckCtKervEpOMDJ9fGcfgvlN9xOwdl/+vAfRH2IPMHTJ5Ug9X3LXk4WJHcLLBL9O3RHlsrR89qwAyStm10gA982T9TGOboIDVLZ6Mv6rghgtiNDsAGp80GteIrY+CYVbp30KxkmyKWJZzWCFqNYhhQ6S2TOtRUsoDzLYtHAkaPCDuLutJwaOj+OHwDH3qVrkQ8Oo7/afJ0EUZOfsxJw9nLR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a784a-0278-4a65-91aa-08db20b793d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 16:01:43.4201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROKd/mlCE2Z1WBPNIalwMVxQr1lfb/5mbDaS6LNwgLs3U8mF10PymqFsl1K8s5eTVkhQ/cz+u1lEnmC+d3n14bKAJedJBv6lI0A1UIqrRZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0691
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
