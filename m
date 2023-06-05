Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2773722330
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjFEKP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFEKP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 06:15:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F310C
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685960149; x=1717496149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=cEyBoftM7iynAduuFwKgLTUedCm47Q9UDdPRbVVCYg5VY268hM9Ojug7
   zYcMtj5zvC1iBhpm28YjWpXXsGT8dSpPP7dLIiEbapekxhnxe9AfchYkS
   +Gnf2NyrD/6OmrgdCn9q6VvV22bD2BTv1cGoemKx2R0QeGJKYkPDivBL9
   c+7y5wJCP2IpjcRwtUlUfXu+gxaBTVkAPJXx0hkOVZ+bzJWBXoiwOWWJH
   +bV1KprjpU+aWsm3OqxF3uJ02zjKgc757Hv/srp5dqJgruD4iD9iV2GBF
   8h6ZB0S3pVJN8LTzeNXyj0WnfCl/SiY2JOPwM1eutyVvoAU2GxcSCkE2m
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="230642476"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 18:15:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL79RN9pMsCEguzz6qd7maw+q5zIt7VsgtieM8xFFtauajq3OZxhjwHcWEyZUOUmlYMJxlIIbpxlAfTiJtnysPg1ppa72dmbZ3vcCGdfGF/qCm6iIxZbD42UG1bSTKPbAhCwsIFGuGXVdTb0LB6XoMe9yZ/uZRKge1UWKILYyCMxAO+yDTwJFfVx9mR9PlNNhXPY+7pHa3jLxPAY897KOmXb9lAoKLRS8lrdgKZRcpl2KlZLPUy4DMvfvVf5SDVrxc+RZa6AzqFW0QFel94essqLGFYMxfZrc4UXs56pq068ANYUpHjlTjqsXKUlZXbZj8vsLrV91wYMZ7CtJtW92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cdbOLNJZIlZwDVm+M7CwhYJ0Ldje8NYoncGxTfhMhxl3v4naZ0oN0Gay5vK0nrwq1cBkEoL0ggB21aXM5PK6+j/eZ3sUfKX8pPK4F7b/cXEx9sr3GMjlbem8+Iidn9XiiTIodkbHB8SpOAu4jmUmeUwiqjcoothMZKJSEH+BhgY5bkNA9T3N6mPairjKk69c27jTy/lqCCUz/I+uEG86+Oh6MgbbRA1e6PP8uWkNTEMIQ/HihARg39pwYfJ+aCilR1a/a61n7xWI/eOlx1plDqj2H9waCk9H4jeaomCgGASp18OwCixtHeM1FPQ2lF4VTgxUV0Tz69WOG28ca3QXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Yi6JaIxFefy82VyfDTkRQY1OxdkIOC6j8IwGIqkIj3qLk71xRlUnAwazOnrlctgTUgEk385p5zUmw/dJNiuQUsXCDzpOZ/7vwts2LIcawzX9Sm8T2a2n4gz26h4ZohhyglpPjbhivuUa3h28TRg/jzP80LDSfLQvXX9Jc1kkSCI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7700.namprd04.prod.outlook.com (2603:10b6:303:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 10:15:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:15:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: split out a helper to handle single BGs from
 btrfs_load_block_group_zone_info
Thread-Topic: [PATCH 3/4] btrfs: split out a helper to handle single BGs from
 btrfs_load_block_group_zone_info
Thread-Index: AQHZl4rsDJxYLGKqnk2sMi+d2jM9/q97/kwA
Date:   Mon, 5 Jun 2023 10:15:46 +0000
Message-ID: <47c832fd-589f-2b80-d892-d33f0ef1c4d0@wdc.com>
References: <20230605085108.580976-1-hch@lst.de>
 <20230605085108.580976-4-hch@lst.de>
In-Reply-To: <20230605085108.580976-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7700:EE_
x-ms-office365-filtering-correlation-id: c1a27a92-1cc9-492b-01bc-08db65add404
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAQRLBPpvrxyglcVdy7c3DxsLAoMF8OZF1siWH9RzgMr6SfZa8frM/gt/vec6wxOeZhVzdVJOqtXXCdSWsx1uBvHQGPIUDa5jSIxFbabTcRsFYkRswuvfe3frLyMbuzLJVi+qRQPBT9qdiGt/ucnquC+QnUb+Lwj9lZAaUmLYh4e27Hx/G2cPxLvSdnobyiDn94Toea6D7BmfafD0WVYbuLKxJw8Bu0LoW1XW01v3QXW6ZUi5a9pjeC70wjodrGzaz1Bqjz0bbe6gj7gu+YU0xuWSGG7l/6BOHQBhzqrxUhlauV6OB2/zYqc8LKGCwHC8cWapVDMYG/+dty/tR0qj7qON1xJ4f0dcxBfo36B/1l6qi/aO85eE523tqMuwjCLvJq5gB6irwCp+jdJD7D2sAk2BXe3B56QiKn4KVvz3xumAwPgpUoOVpQqmSUmnPAddSBbrgpDxm4W02g779qw+JYXbDJrKcOjohAlEUIDFmFUl7uPjsyrnsY44nAMv7EGA1qaqENKaFezIAWSMOe3m+wNkaUsiWaJbAnttjIId2pMporVgLp7SV47z1PG+2UykLTkn8MuAdijz4sk06BdZTPqxOESGgCck0Drk5VSA+6tK2ZVl+ka5tSJbmYApYg88bRyiLoZH4j7fwYJxCJ+A7FVWIqLa4dslWdPJjYr0APxEHtnx33wxGj4gZJdq/ML
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(478600001)(2906002)(36756003)(19618925003)(6486002)(71200400001)(558084003)(2616005)(38070700005)(186003)(6512007)(6506007)(4270600006)(31696002)(86362001)(122000001)(82960400001)(38100700002)(316002)(31686004)(8676002)(8936002)(66946007)(91956017)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(5660300002)(110136005)(54906003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzRkQUN2a1B4MHl2NWZlK0ordmE5NUNPMTdSVGUweHBPZGh6c3ZYT2IrY2l3?=
 =?utf-8?B?QnRvamlZemZxRGFWcWJ6OXU4VUlIV1ZlOXZxOFp1TTlNeC9HVlN4SGRPblU1?=
 =?utf-8?B?MDJTQVl0WHhzWnBEZmV5bjBFR244a1ZCNGNrak1HQVpadm5tVXJVMlpqRmV5?=
 =?utf-8?B?STFwbGFiTDZ4YW5UVk5jbGdCNW8yS296TXpzZkRpUDZLQlNEc05qVUp6UnJr?=
 =?utf-8?B?RGFRT1oyQnhwMW5FVkUxTGNqcE1QbTNpU2ZaU2ZDNXd6WVBlTEJnNmpORTJR?=
 =?utf-8?B?MUcxNkJxYXU0YWE4VVg1S1IzTGRaSTM4OFNTbVE3ODlXWkxBcmMvWk0rMThY?=
 =?utf-8?B?WXJxKzgxZGdiQmFhYm1xRnI4QWpLZHpXU0hpYWt4cWNSQW1WSENxMC9YZ1lx?=
 =?utf-8?B?SkJPVStPdk1sY3hONFgybnZaN3ZyMy9jR0VBU0pIVGczVDdrN3AwVm4wRDJQ?=
 =?utf-8?B?M2h2dU0xOFFlZnJLeUh3ZG54L3NpdzZSRllTbkV1LzZyQlRmdG5vR0RUNDZP?=
 =?utf-8?B?SjFxYnlHM3NnM0xMclFDMitKaUhYUDV3ZklIZFRHY1NVSDVRVVIyWXI3YUFa?=
 =?utf-8?B?M1NqREV4b3M1c3VZQ2xIY0gwcHpiQ2xVMVpNb2RicHYzdXZVRTNjbjdpalY4?=
 =?utf-8?B?N3FwS1pQNFd4aUFENFZGR2gxZVNGMXRWeUN1S3B6VmpmZ0Y3Mkk1b3Z6NnNE?=
 =?utf-8?B?T1hRWjNvcmJkOSs4ZFdCL2kwQjBRaUdkNWxYMHExRlNtRUVhakdEeFhuQTZF?=
 =?utf-8?B?Y3JTWHZBei9sak5kUG5vQ1J1VWp4TnlJY1BCZ0FWbGlWeGtjRUFCSmVWK1Vk?=
 =?utf-8?B?SWE1RHgrc1l1VkhwdGtjSXFnSFBLcVA5SzZTZGJWb1JNeGk0Q3cremtmU05w?=
 =?utf-8?B?NGgwMGt0dkdhV0REeWZaQldzdU53aE5ZREtwMFhqTkhMWEZyQkpkVnJlMjV3?=
 =?utf-8?B?TFZLRlNkRzM3eFFoeU1hRzQ4bEVjc2cxRHVWKzIzZkZBaTFicU9ERU9idXdJ?=
 =?utf-8?B?NWdZZitud003UU5uUTAwbVVmY3IyYk45cUpYT3ErbjJwT3YwWSt3bmQ5dUZn?=
 =?utf-8?B?dGhBNnMyeXE5eHZlS091RUJNL2JsMjRseno5RXFHL2RlbmdOZ0JBenRFM3FI?=
 =?utf-8?B?alZ1cnZiUzdMbW9qWU5qZHJXVHhYYVh4eVhCdGtFQ2s0MGtPdGxQdFpZYmVv?=
 =?utf-8?B?YmlZMjZyaUVDNndPc1gzcjJ2SXY0bnArZlNaWUVlcDA0UmYzOHFrRm9hQ1Y1?=
 =?utf-8?B?cEpOc2JSVlRpYW41MHBDRkxCREZ2emdZeVlXOXF4MGtnRjJja25SKy9idjMy?=
 =?utf-8?B?N3N6NUJFMjJRZiszemxRLzVoaENhc0ZNMWdKcUdkZjRiM1cvdzJOVVF1aVVh?=
 =?utf-8?B?elgvMzBjbG1aOFhNcGJSaDhNT1Zpb3AzSy92c21wTW4yTnVQV1Z0S0VQWWFN?=
 =?utf-8?B?YW4wVU9laDBwMnpkRHFsMXlJWS81SEVscnZYTUdYeG11LzFNTkUzQmN6K0Zi?=
 =?utf-8?B?R1FHazhGVkRuQVhOKzBYZFFIQzBBK2NqY2F0Q0pMdDVOd0FhMWw4aWYvZFpp?=
 =?utf-8?B?d3pUeVlXeDFGODdVY3VhYmVyZVNFTkMxeHdOOHpTSjBPN1h2N1U3S0NHQS9U?=
 =?utf-8?B?ckw5R0RwZkdNbjBtS295N0pxL1kweFlVZEgrVUtBd0dEbThOcS9ZYzh2ZUJU?=
 =?utf-8?B?YXU3L2Qwd2duSTRVMVc5aDdLNXczZ1J0aEVrSnRQUFNHU2xob0NRa05iOGZC?=
 =?utf-8?B?UjVoM2FzWFlyMXVWZ1cwWHU4aENsS0NuVk8vMG9rVnFkbVVmbzdYL1BDNmJK?=
 =?utf-8?B?eldmRHVzVzJkVHRmK3VHOUlrZXFEU2FxWGxDUjJwWEZmTStVS1ZhUzdTS05y?=
 =?utf-8?B?cnVDYzhkbFRMRzRZVDVvU3YwOC9IOW84Sjg3cXNTY3c4T3U4ZG9rczM2NmtM?=
 =?utf-8?B?TkVvQUM2V3ZsSWVIZTl2LzltM0cySlY4alQ5VzZ2dklSTjNRMWRNc3RqSGJW?=
 =?utf-8?B?T01VMnVJb0JhTXlPMVNZT2RBVUtocWNRNUZLMmQwZm9obXBKNmdJOCtka2hI?=
 =?utf-8?B?aFBYYkhMemhkZ0xDajBuRzcyL0tDVTNPQlRvNXVWZFcvWFhMUG45Z1ExZUFi?=
 =?utf-8?B?cTc4SUFEeDh0UVdjVU8xeEZCRlpPemw3YTRkamNOUzFibFJzaU5pY2RSZUQ5?=
 =?utf-8?B?NHdjT0VMWEZBUGpoT2ZvTGV0MWRRdTRaTnIza216dGFPZ0kyM3JnZTlFNEpT?=
 =?utf-8?B?L2NrTm1UU1NIWDFhRExUaDdKZ2lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4DEEA1487CF484FA913D5078CEE44B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3iZeTegp0DHtQJUV8P+dHyDtuwgm+SgZUpi+NhAjuX3+A+zws6NaG7teinOLke3k/vLUpUFQFlRD5f8Jp0oEIxnZMsGYM4As4lqnY4JPkiZ7h90eBtoznlMImJQYl2f/dyqko09/T405ENC6YecZAxKmrcSlXVggjqSMd8ubk0HOfvu11QU4SSdOG8LpO0Hgqy7gwqiWjY2OzGFcb/poadMyQ2FZRCsfmr1QQg4jdXt3lsDMMKXzEZQrppbqkp6R2TLjP/IdEag6lUUqIwX4xmjtBdfNaARFVUm7kIWSiv4ajz1+zcfw1FaEQ5RHfQpqJoF4ksonqN0LFLrRYHhwEMFnIf2znyQgOOf1BPprhmSQy8q/NobGI6Ro5Sjqg60Nkq84XVcXOG0CNZcC6Amg7S+rAhwNdMCzwM5nULwvEu0Dvt6WUS/DF5xZ7NdJ6Yf2raJlr2HsQxBREdQeUHMYXIIfZ0720nwAfxPgqjFj7Cckd64nD8R+XWE1Ad0NPXZdMOyyB/7dBboys2p50LU4SD07KZQZyYqrMsAC5Sv6YGo9OEoMv3PJTQkXSIMdGG6PkY5GOL7EKiu9H5qV5mzPOxNU0EicVkVa6NTOvOQqdMRxJzOqbqx+12DGKIQu19quaIP50uZXyBQmAeITmsHn1G7JpdvK1MuY1LZWw526rowgQ+ByWbrZbdCwt2ngArQx0OGAIUChYYnQxruFEIJI7qy4FRyoE+VHjbm+UWDzUnXr2jM9LXGRNUmkrKIRfjkeaHBskAQSv9yHgOjyxjZeG3cle2wH79QOGZvm4/NOATjB8hyUvcywl6zqx1fzQwrajmiFDPhGOmcRODefIFi2LUSv0+Ee25A7CYt8SLpHpMwS3TUF5pgBLgfw+I4da5v9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a27a92-1cc9-492b-01bc-08db65add404
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 10:15:46.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPRjB9pVsI1v7gSexk6Cb7ky0QK9FV6y17wJofJauEHyhhaohGTHvk2vQvnpQT9hzHg7WhIknLKhSr5Z56UVAMTuuwCC1XG8M0CiCt+m2Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7700
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
