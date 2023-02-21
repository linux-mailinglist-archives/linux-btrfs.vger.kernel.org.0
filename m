Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE369E479
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjBUQZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 11:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjBUQZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 11:25:54 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ABD241F5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676996751; x=1708532751;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=e7WYAu2Rl7Hx73UuFWVtc2BARzOuOwjcZQOHlLwga4E=;
  b=IsKAurJgMoLcUFHO4LhB3Ozg7ilSEXsjlHwL6i8dZkiy/Th6XNI2Jajd
   Mzx/fj2YfnZx//JnXLUYRHuyxq2Seuja525dCYSu0hLhW5ezOS7HBn72o
   +V8NnjJ26lsEtDCSXPErUPbX0+vq/6LkzOmKAKazBJc6MUnhYLkxiwrY9
   0/AAJQbLekxnNH9Aj+lxLJKPpR7VqUHN13szBWBrZnp0u/RNnYBmQ2qlZ
   gxbhuUd49zPa/zyrKXpUSrVMZf0FtE7JwfvKGG4jF9AQVCKj2GDvjUtfG
   TkVUg14N5C9mkFzDQl8UKxt0+mndqhvmdNPvShL5hAWDHaQf2j11FvahR
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="223831975"
Received: from mail-bn8nam04lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 00:25:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEF3ZDIaUMBI0ux+5d2wMMFhBygbyoIHKRlQeHCp9C8rEsoVBa5wi2+Wvf6QUqMqOBZ4/DzXcopLdzulAknr0YM+rDptUzYb9tSNMHjPDSF+CN6DUO/qmF3AJyKhQRt43Kx2YO9SI0WjyYVfV8wcWuEF9HRihY5L4FamvDuY5MPQjUPMbnViOwwNQPr8b7wsARHEGdr1U5FPQJcEg2dtF/Bl6eMCwIGW1DO9afL9+2Km97xnUNmPKgdk0Q6YKZK7Hj/+8Qw9b3+p/ozjrQZeT2/n6qV0xvKdMexMDamEpgskaRykvxnL7SAv0j3GmNdTVV+5+PDPnQ0dLo+sKgDTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7WYAu2Rl7Hx73UuFWVtc2BARzOuOwjcZQOHlLwga4E=;
 b=hkb8UiiDVTisOqZZnxQRuURpNfyClddON8LP7FXGmXXNLDYEPsNqXB7SwFoAz23wBBdFNUMChNamkIeeaZhC2yoVe0JQ//DXndMxTMH4DQK+N8iJOfMDH2ADo6vwP8dx5cW4+E5pibgOOiRo6GZACeD1ZBJZpKrEFhQ50XYCkCLEM0YbRKL7eUHblKNd9jHkBWLCqwqXzzwe+J9kG3Pi7uHeq6wiEXdJPlcIHGxQgPuW0rVm6LhdA8ZpLR+LS5+Pw0CJae8Fwtg3bf5KJQa7HgIlMCVzT7BuwrkZR3UKOXo9SxNQKQ1MG86ooAyc6bktnpvH1LIi33TkgO7/mx2f8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7WYAu2Rl7Hx73UuFWVtc2BARzOuOwjcZQOHlLwga4E=;
 b=xEM7XCrL4lo4sj5dQNr+SAhKRyneRbAif/CH1dcu5OhzFHVP/plXn3LTZzFuoE8tKwft4u9AniA0meKissKcATKoKww0zg9YAqv2ApWozzB5hOheXJz2FvBUE+gHEHixIqsGZP1cyuSsrYGl99RRmi/6DSSszuQaIFWzLJQENXE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5879.namprd04.prod.outlook.com (2603:10b6:a03:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 16:25:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 16:25:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Forza <forza@tnonline.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Automatic block group reclaim not working as expected?
Thread-Topic: Automatic block group reclaim not working as expected?
Thread-Index: AQHZPG2akAEfAE1cFkyLx/ChHDx+hq7Ga+4AgABNQwCAACr1gIABF4gAgABQOYCABcrbAIAAcqwAgAsgAwA=
Date:   Tue, 21 Feb 2023 16:25:46 +0000
Message-ID: <3a6e20d9-2fc0-840a-18fd-e604f65d6d7e@wdc.com>
References: <e99483.c11a58d.1863591ca52@tnonline.net>
 <b508239a-dd7a-98d9-d286-7e4add096e13@wdc.com>
 <2563c87.c11a58e.18636bcdf0b@tnonline.net>
 <31bf44b.fe8fe284.1863749a10f@tnonline.net>
 <f6e2f95e-0892-f82b-43fa-34ef32f19320@wdc.com>
 <b19674f0-0743-4e34-df85-ba6c458af01c@tnonline.net>
 <73b49250-8aaf-bbb7-92c6-73e0ad3d707b@tnonline.net>
 <60d348db-822b-c337-4c4d-edb06094302b@wdc.com>
In-Reply-To: <60d348db-822b-c337-4c4d-edb06094302b@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB5879:EE_
x-ms-office365-filtering-correlation-id: d538a8e5-3b80-40aa-6e4b-08db1428499a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYn/P/nQ3we2hqtSVOzWXbc9eVCm7cUlWDseUbDlfJ9qn69bB9rdnwE0sKi/3kwkbRfRcOlh9kGbFFSCcg/4ohdwKUjWZzN9ayBQHhzNHGMbIAKUYKM9IUDurmuL077cRDp2h9TN/aPDRsceeJa5K084Om7CCOYPbjWjv/NZi/r9gCo45f9ATMPT3bTO6bR9mYBQN9u4BmpCnGjl3FinfW1Vxry7D2qL/rbmXxTwaR8cTtYiH04X5QTIeesjZPSa2iyumknEwOfFHGoy2k0Yn4FRKowC8nH09VbJB0cxhv4jHqc/ZgJl5N4KKYfQCF6ImVqpXYiFspXtPQSwOjrE0lHT5+CcIOrJj/vlqCsxLWxe5j/a7BHPXTV05wQgPhejTfbVXlfuuwY+gicFBpCM5sHPvcrAz5/UK30YjoD1gW6wUiDz9kys4W66FhgzAJmAedp957JrBHuD5BE3kNFuC1U/Ijt7NTXsIupI/ZTXrLcHsGoP9TaM9b3En+wGyfdfkVvbAWePqsDiPryaS3GHLKQPnnJ4bgBPh3ehkmRTINstGPWOmd9hrVub4n4pr1LfM03CuDF/lYU6PIt4laOA3rF3eNx4qMfEsTo3/X3hsm/f3iG03PzcypElQxz/Y21ig+oiiTuwJM19ZrEg44e7slkbT3B3ByBdYn+6Dkald5lO7fjpy8oGDqWzVoXuEVDoBVfiFK7PTYYjKrYbHIEcxYdz09lKJHu0tWL1U8nbOVnjab8tvejp6zdf/CrGxVzfBMg9fgdV/zzvw+fV8nyZzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(31686004)(2906002)(8936002)(5660300002)(41300700001)(76116006)(186003)(66556008)(83380400001)(8676002)(91956017)(66446008)(64756008)(110136005)(6512007)(66476007)(26005)(6486002)(478600001)(6506007)(71200400001)(53546011)(66946007)(2616005)(82960400001)(31696002)(38100700002)(86362001)(316002)(36756003)(122000001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajZ5akNRazQ2YldTRnVmSno5cWRvVGJiQXdPSHoyMW84YzNGTUFxSFgwdGN0?=
 =?utf-8?B?S2JlWGdOZ1lhYmNWNW9DMmt2YW9RMmtJYVZ3NGsvWHJ2eElOOWxzN3JtNkpT?=
 =?utf-8?B?bnlGdEswUGh6SkxDd3RTTCt1dWRaVXJwampHVCtlL0IyZ2VSaHpLT2NLMFNw?=
 =?utf-8?B?RTkzQUxnekxzb3ZMV0xlamE1M2JleXhjTlRSMTY0bTg3K3J0OHZhTWxuSG9U?=
 =?utf-8?B?dktUY1BuOFZKTlFBS2tJcHBqVlBBYklaUVVNNGQzeDJmSGJnMmtxMzFmb1hv?=
 =?utf-8?B?RXdkSUM4c1gvbkplRmFzcEgrT0RaNXArR3p5VnpDd1dtY0FyRlM4Q1ZjelY3?=
 =?utf-8?B?YndjMDZOSmFQRW9IQVlxRUxhZkhHd2hyZ3gvYkFpMEMvcG5OMTdTSFgvNEc5?=
 =?utf-8?B?TEtIditRN3RRamJUdjlFNjZXd2ErK3pTSEswRFRUeGZwYU8vRUpLSkZ0a0pP?=
 =?utf-8?B?d2ZZYTg4NFJXcGhPOC9TYnN4YjJ0U1NZRE5HK2F4YU5ZUmdQdmNTUktMM3NC?=
 =?utf-8?B?Zk9TVGZnbEpPRTNQWTZsSHdtSDlVUFNIRlNlT0hoMEhDTjV6M1R5T1NYT1Ft?=
 =?utf-8?B?NnV4RDY0andnclU1aVEvWHlQV2I2RTRBS2tzZmxQZFF1VEUwNkJ2Zks0K0NE?=
 =?utf-8?B?K0Mxci8zT1h2RExOeVh6R1c1dWg3KzFiVStidnhJd1R4b2VGYktIVWwvVkJv?=
 =?utf-8?B?YlZ6eXY3SnFmUDNsM3pqczBhTzZ3R3Y5Z3hlcHY3cXBPdkRSVElZSDFwTldS?=
 =?utf-8?B?cENkZHg4WWF4WE1QYzBWem1uZnA4Y2YrSS8zb2pvS2RXWTF5a1U1cnFWblNL?=
 =?utf-8?B?Ukx0MEx1cXdCd0VkRWdMYlNCV2ZnQUVTWmFLWHlzbUdxL1FTMGRBYkNHbW9P?=
 =?utf-8?B?aTB3bXMwWkl1WENVeXJtNVVZTE1mR1p1VUxScEl0SVAwK0RkSHc0di9yc0xt?=
 =?utf-8?B?a2M0S29aSXhFZXduZ0p6VEovQTBucjVZb0V2NVlSc29obHVCNCtBL3R1b0JI?=
 =?utf-8?B?OG9SZFZuUS9UTGoveEZqcTVNa1VJUjdicDdHSllFU282NVRxV0l4M3NSZi9i?=
 =?utf-8?B?RnRiSUs1d1hQWFhjTTFzSENlWUExYVZzazEzMXVtd2U3anIxcFQxNXcwcGRY?=
 =?utf-8?B?TlNCU2dMSEZjR2tBR1BiS3p4RXRxSXRxN014eG91K3dpTHY4QUc4SzhEK0Zj?=
 =?utf-8?B?alNFT3ZoaFo4M0sxZ0pJZklDNC9vWDMxYUdGaTJuUk5NZFlKNmhsQ01FYy9h?=
 =?utf-8?B?NTlLUmRPUmQxb292YUVyZHNJQ0F4dkZLSEVhZ2Y0UDBFdFdwVHlDSmhjc3Nn?=
 =?utf-8?B?a0VxS3EzTlNZbmljcXJhUDhKRmg0ZDRUV3RMQVpGaTZoOTFWQnJKdi9QTW9s?=
 =?utf-8?B?c0ozdXBZL2NtQVlSeVJTTFpyZ3d6NHRoZG1WMWpYRVg1TXVyZFdBUmlsTVNn?=
 =?utf-8?B?WEo0QjRuRnZxQnpSQlZkWW1IOEdrVEtIbm5qcE0xdzM3T3lBWEE5eHRlMDZD?=
 =?utf-8?B?SCsvczVQUTNrR3hQalRtczV3dGE1R1R0YURFU2lTZy9XeVdOK3d0NjIzK1Y2?=
 =?utf-8?B?T3NIUFgxWTVIdnladjRSdmJSanF1Y1Uvd3ZqY2VtWUhnUlArWEIzUjV4K01O?=
 =?utf-8?B?d1ZOYWFBZHg1QlRub1ZHelBxTHdLcTdCanBIUnREKzFxOTZRblBmYWZwWHJK?=
 =?utf-8?B?MWJRTFY5NmhkMEdGc2I4KzRTdmV6eVB1WDFaRjA5UWd6Y2tOMC9zdWZCdE1p?=
 =?utf-8?B?dGlxSEpKWUtiZlpyaDFtMkdLR3NpL3BVN1BHZTNYRXBSSjZMZlo1NzM1NkxL?=
 =?utf-8?B?b3V3aVU0bXJuMGFWZ0RHR24wMW8weWxBekptODJpSmZ3Zit3Z044UEROQUxS?=
 =?utf-8?B?aHNEWDVGeEFQdjRLYmkyNUt6dEZPY0pHc3p6VkxleVhqajlaMnRUQjRoem5N?=
 =?utf-8?B?VWU5SUtkK0hZT2VlZFpOcTZEb21pL09ncmhYS0VCbXBWOHg1UlVTYXhuTGZB?=
 =?utf-8?B?c2ExeWJnSjFJK21oUzNOd2R4NzZ1RTJCM2M5TzdlUE5BbnMybUdTbElkbk1m?=
 =?utf-8?B?V28vNGluTUdtNmFzbzMxRzlkWTRJazFlQURiNHoyK2E0Ny8zdVVqTmd6UlVh?=
 =?utf-8?B?ZzkrTWxTd0xTcWJiazYvb1IrSG0zYU1CbitUMGMwREE4d2hrNVhrQkxXcVI2?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <084F87E5A4C2DE4CA12CF87A8130C5D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9OiB8IeV6nAMCerSuY16suc8Bxn/hiy6yjnn8gZIbVgo0OdlRZWnFE7NmD6jdtxRK0SD3h+G4ZNQ67b9j4kwq0fOxbV2JqfwlZ1r3c4LTjFt1+9dBCJIUTWRgD4CXelPxah6oDG2X0E+gmNnna9o/kjxWSZ8QHeczskyWfGi5VYjTw9R9OP4kUjMyWMesm7fcKMmdvDwIf2g2GK+HFlHuXS9Fork6IwUs0SL05P+OOhErCEsk7PCxtidnezy4Wiz8IuD6jTGZ4rrQLdj3iXKYtuSaa9tpzl9JGWCRZAc0JXmcB6nW70EStYsfTfFtluDm/L+quoRpJ5CjeKT+oRVRrfw8FcXYcw6SXb4tyYk938riVSZWgLaWNwyq7iyPiDAQeU5ej0UQ0MdF1grGJNNqlJ3Kz/UsokER5YKmzpYwSR89bhsSqjKPyVq1tfgt/2Nr0w9nuTPMdlCfVbAiI0a7ohTl8EhB+UL4oJdfbKrb/XHnDZ06U26SWxbdZmJruWjGuGiH0uPvw5BiUGE/TctFnX2EsjYwsNDiVXjjmsMDoUIEATBtfGRFZ00AJ6wtMRHtZt2f7I2cnPSWqpXqsp6u0PCzi7eYygxx4OzN2Yq8Qz10zUAngFaOPH/6AA62qqMXfJdBga+5M2raiQV3Y1k6YggD0iYM74Q1y4v6AOl9BmVRtWFMUnkpEpCno1IuPjxuCIZ7cl7dj2Jemz2KNEUwHvpUav8D41zm0S/jGeqmvvhzGhmS7Pl6WPnpv+4NuKX6d0C2HdoMWUVcBGFxDz9daEVX/guCLufZj04LWBc9gI/ciqWqNM/5kuCgDj+4+dr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d538a8e5-3b80-40aa-6e4b-08db1428499a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 16:25:46.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEWZ1Vag0RCEP74cEjzZC8+SoLylEgSgWOOUABP0H79oePM/9Qy29VuqojmdZro/RN8z+gwZVVJnn9MbDYTCkrxW2E9jpnpfjUnYzZAbFSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5879
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDIuMjMgMTU6MzIsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMTQuMDIu
MjMgMDg6NDIsIEZvcnphIHdyb3RlOg0KPiBbc25pcF0NCj4gDQo+PiBJaGF2ZSBzZXQgYmdfcmVj
bGFpbV90aHJlc2hvbGQgdG8gNzUgYW5kIG1hbmFnZWQgdG8gY2F0Y2ggb25lICA6KQ0KPj4NCj4+
DQo+PiBkbWVzZzoNCj4+IC0tLS0tLS0tLS0NCj4+IFs0NTQxMi45MDAxNzddIEJUUkZTIGluZm8g
KGRldmljZSBzZGkxKTogcmVjbGFpbWluZyBjaHVuayA1MDE2OTgyODI3ODI3MiANCj4+IHdpdGgg
MjkzJSB1c2VkIDAlIHVudXNhYmxlDQo+PiBbNDU0MTIuOTAwMjE0XSBCVFJGUyBpbmZvIChkZXZp
Y2Ugc2RpMSk6IHJlbG9jYXRpbmcgYmxvY2sgZ3JvdXAgDQo+PiA1MDE2OTgyODI3ODI3MiBmbGFn
cyBkYXRhfHJhaWQxMA0KPiANCj4gW3NuaXBdDQo+IA0KPj4gdHJhY2luZzoNCj4+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4+DQo+PiAjIHRyYWNlcjogbm9wDQo+PiAjDQo+PiAjIGVudHJpZXMt
aW4tYnVmZmVyL2VudHJpZXMtd3JpdHRlbjogMTIvMTIgICAjUDo2DQo+PiAjDQo+PiAjICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfLS0tLS09PiBpcnFzLW9mZi9CSC1kaXNhYmxlZA0K
Pj4gIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvIF8tLS0tPT4gbmVlZC1yZXNjaGVk
DQo+PiAjICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAvIF8tLS09PiBoYXJkaXJxL3Nv
ZnRpcnENCj4+ICMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8fCAvIF8tLT0+IHByZWVt
cHQtZGVwdGgNCj4+ICMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8fHwgLyBfLT0+IG1p
Z3JhdGUtZGlzYWJsZQ0KPj4gIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8fHwgLyAg
ICAgZGVsYXkNCj4+ICMgICAgICAgICAgIFRBU0stUElEICAgICBDUFUjICB8fHx8fCAgVElNRVNU
QU1QICBGVU5DVElPTg0KPj4gIyAgICAgICAgICAgICAgfCB8ICAgICAgICAgfCAgIHx8fHx8ICAg
ICB8ICAgICAgICAgfA0KPj4gICAgIGt3b3JrZXIvdTEyOjYtMzE3NDAgICBbMDAzXSAuLi4uLiA0
NTQxMi45ODE2MzQ6IA0KPj4gYnRyZnNfcmVjbGFpbV9ibG9ja19ncm91cDogNzc0NWUyZjctNWM2
Ny00YjE4LTg0NGItOGU5MzM5OWY3YjBiOiBiZyANCj4+IGJ5dGVucj01MDE2OTgyODI3ODI3MiBs
ZW49NTM2ODcwOTEyMCB1c2VkPTMxNDkxNjg2NDAgZmxhZ3M9NjUoREFUQXxSQUlEMTApDQo+IA0K
PiBKdXN0IGxvb2tpbmcgYXQgdGhpcyBvbmUgdXNlZC9sZW4qMTAwIHNob3VsZCBiZSB+NTgsIG5v
dCAyOTMuDQo+IA0KPiBXaWxkIGd1ZXNzIGNhbiB5b3UgdHJ5IHRoaXMgcGF0Y2ggKGNvbXBpbGUg
dGVzdGVkIG9ubHkpOg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyBiL2Zz
L2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4gaW5kZXggNWIxMDQwMWQ4MDNiLi5hMTc3MTI0MjlmYzMg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4gKysrIGIvZnMvYnRyZnMv
YmxvY2stZ3JvdXAuYw0KPiBAQCAtMTgzNiw3ICsxODM2LDcgQEAgdm9pZCBidHJmc19yZWNsYWlt
X2Jnc193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gIA0KPiAgICAgICAgICAgICAg
ICAgYnRyZnNfaW5mbyhmc19pbmZvLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAicmVjbGFp
bWluZyBjaHVuayAlbGx1IHdpdGggJWxsdSUlIHVzZWQgJWxsdSUlIHVudXNhYmxlIiwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiZy0+c3RhcnQsIGRpdl91NjQoYmctPnVzZWQg
KiAxMDAsIGJnLT5sZW5ndGgpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJn
LT5zdGFydCwgZGl2NjRfdTY0KGJnLT51c2VkICogMTAwLCBiZy0+bGVuZ3RoKSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkaXY2NF91NjQoem9uZV91bnVzYWJsZSAqIDEwMCwg
YmctPmxlbmd0aCkpOw0KPiAgICAgICAgICAgICAgICAgdHJhY2VfYnRyZnNfcmVjbGFpbV9ibG9j
a19ncm91cChiZyk7DQo+ICAgICAgICAgICAgICAgICByZXQgPSBidHJmc19yZWxvY2F0ZV9jaHVu
ayhmc19pbmZvLCBiZy0+c3RhcnQpOw0KPiANCj4gDQoNCnBpbmc/DQo=
