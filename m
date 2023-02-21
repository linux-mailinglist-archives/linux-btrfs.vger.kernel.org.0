Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CC769E203
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjBUOJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUOJX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:09:23 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513DC4EC0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676988562; x=1708524562;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=D3tE8a87FH9fDnONVOWfxGrE5rKAUTZUM/RjRp2f47E=;
  b=hp9kbA9vpZRY15tixwLEiTzaiSyz7eVty7p91ZqaTI0GPhjCQ9cT7sD4
   MTmrxVOkp9oKHQa8xVUGoVvCDIBdHCT42Dnrf/oJBJwvwrfXFLQjOsGAY
   z+A2Y6LkEBUvaBKM3FNOeWX3a6aljUl0Nx/M4VjnZOwQ5IBZoczOjGDm7
   mrlxx7xtwKZYXwqLxLYLg5ocYqM01M4P3HkOqlv6214r1D+q+SJZJvlLu
   RbC2kxTwEr8V8QqjIUaHdkFvlO5clPVeN33euxjqpBSbXstu7N5x6q5MI
   WWsC6SDhWjwsDFEOI7kPBbtjQDsbo0BmUITNcg0MGA3cRN7hFZt20SRxH
   A==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="328117190"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2023 22:09:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix17+U5J2Vf2WChbW4B1KCnTrts7E5ncKm+su7KJrsfRRkSoGcHCnyHP85YbmPGlPfsYjkIbJNxB/ie3QpELXlO+vODx4TfLte8ZmogFNtMk+6b9F9FttE/lbmPqeKH5RJBLk0fbtOPITXTg3QBGz3pK2OkMfP1XxbIfVBepM84UdGCrG2yjozwVAkTPEnyFLwhREmtXSX0Z7gnx5RaR9TOaJ0zuzJSaeR34FeE6GHkZ9MXug6LBVUq4MDvNlWmbpF1f4/LCTLDfN7IXjapmWCh+37StVEs3yndkU9kA+ucn10BWUz8m+wfHFJaepZDgTZ1yHvffzj/BHKnAmcvOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3tE8a87FH9fDnONVOWfxGrE5rKAUTZUM/RjRp2f47E=;
 b=Copws+U+JDJQwlTuhPBev9AjgHJA6PphzcPO8tWLZ37LgvP33ikb296IOl+ezdw0EZreJxvbiEjGy6ghEgqTMoFa1HT+R5DSn9Huf883cxXBsZA99LooyXrkK3rpLuv7vcC7VG9Plmeh92NOoraEXDryTgxTALwfDiRQooZyS6/EeejBpxZeFB2HSTDKYNk9ZRhcJ/NJYoW1J9idnqTR+VJhONxNO8cjz5GI0lMgf5NYkn1bFaJ6eRy77hXMGDRKEkFiFbHsJuc4JavImzzgeujVg2YiUKeUd4jJDtSQLevKnXJA2TbjMzo5vNb073f/tVU4mpfJSwZgM46SWlG3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3tE8a87FH9fDnONVOWfxGrE5rKAUTZUM/RjRp2f47E=;
 b=wlm/g4tnd2iNGOolIN3rR8gzWlATA+2RIyMTMJoopJhhEcZps314c8g7dC8c0mzKGVft08aytb1bTiWACP9/TTaoNh0VLballVxzuo4m7Fvr+CZKP13sA+XmMGY2UYvVQZGAu6N2OkSobaOtP6ArihoFqZ/Rl0dZf/EvLQzt25g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3522.namprd04.prod.outlook.com (2603:10b6:910:8e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Tue, 21 Feb
 2023 14:09:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 14:09:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflow calc_bio_boundaries
Thread-Topic: [PATCH] btrfs: reflow calc_bio_boundaries
Thread-Index: AQHZRfgBNxHFIz3UPEmFC4mXxpniHK7ZbNgAgAADXwA=
Date:   Tue, 21 Feb 2023 14:09:14 +0000
Message-ID: <91a459fc-ce07-8f89-8121-b7d18906a3e9@wdc.com>
References: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
 <b92f9adf-111e-0640-849a-8d85b2a171c8@oracle.com>
In-Reply-To: <b92f9adf-111e-0640-849a-8d85b2a171c8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR0401MB3522:EE_
x-ms-office365-filtering-correlation-id: de424860-c6cc-42b7-62c8-08db141536ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHVitMKH0HPtUEgNJmkthGT29v/D8qsND/163kZTQGbkalq57kDrtnq1uR6kccBX9SARnyt3cdZoe9gPWID+p/3QCjjUB1YCw5Nk0nz5ASmI43Jzu4idSnJRLVBXbxim5pIVfkOsR6zKH19/uWrhdvYtS46Zt6L/7+XgTYWx6P8Xw/aMOf/UbJjPq5UkTZ87hBrvlXca8MH/UuDlUDe2tWdtQJFcSY46uDg8FYTrmZi4KYVWrkhS6yVdH1gdQXWH8I+fuRq9VgRJh1X5DwsVYmeDFDbgx9Ye/QmUSNKATLPyALiUzOOic4sB4brx+3wMxrxX+PkAH1/saUTc8DRVn3qhsYQmr8A9NxS+2LV8hhHPoEQ2MZPyInF3TsdMcF5sEWMHazHzstOcLVngJ1XqxCMSCPKmIx0epo+O83S/qTaCrw0ZX7eTePa/gSw5henjtAzq5t61hgV32Bsl61YhQkQEE8T0Mb93Hmww5ZRUFFbY2k5FM1mGgRZNGOPhDAqQl1GHaOA5Dcpa5U80fYtF8mxzAcc9SL9ImldnGIagkZAd4UONfXzqkHyqAPgZ73EXSxx3h9HDbxvOSnbZmb4DLBjpVc6IJ6zuI5vBJKKLD79s3U9YSrOzHvmBGVsUq7qIf9v8hUHQQRyR6SomsS9/A1zU2g+HMlLb1+GDXrt+NfTe2/t9iDkWOUsrm9H8s1Fhp+VwMz2Yyzzayx9b71kqc1eXxM1pbRxI5EkY1Cb9dYl0b9euDJ59Btz6GvXE5mtR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199018)(2616005)(82960400001)(38100700002)(41300700001)(122000001)(26005)(186003)(86362001)(31696002)(31686004)(110136005)(5660300002)(316002)(478600001)(76116006)(53546011)(38070700005)(966005)(6512007)(6506007)(36756003)(6486002)(64756008)(66946007)(66556008)(66446008)(8676002)(8936002)(71200400001)(66476007)(2906002)(91956017)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z00vQm9DUFlaQ0pjaDZBZitnK0RQWXZ6Y3JKbnQ1eTZCWWwwV2MyQ2pxNFdI?=
 =?utf-8?B?L3FQeWJaZ3d6bFVvNXpBY2hHQ2dSZWJIa0dJUVJVS2JxY1N0ZWxsbXE1b3Uy?=
 =?utf-8?B?NEZqcDRGL2cwcDc0RUhzTFJrbFY3Q1BKazZlYlhEczBuQlNlRWxyNkU0RDhP?=
 =?utf-8?B?V3loUE1kM1BaSzVCbXU5M1NKTjhmUkZOUkNMSkxMWXZHNzBIYTFHRGdoZndw?=
 =?utf-8?B?bjhFbjBLYmlVMUhUd0ZyQVRrek5mNllMY0Y0OHFGd2k0UldKTTJlcVBmMmxW?=
 =?utf-8?B?UkJWM0RKOUxGVVBOQXdyZTlsUGg0a0x4Rng4VjJOY3BLSlpZQnErTkpPeTFo?=
 =?utf-8?B?azNVRk5QMjU2ZDg3WlZwT3kxcnd3Uk5QRzA4anNZR0dNOXdlYWZYL0phclJj?=
 =?utf-8?B?QXRiQ2pGd2h5RWtMNWp4MlRqSC80ZWx2UitvU2hsME1BcFJBMUZyM3Y2WlVP?=
 =?utf-8?B?T0ZLanNKdnVsbHQ1RTZmbEtQTGRBQmdDT2JnUjhxOFkyT0V2YkFjUnI2d1Z3?=
 =?utf-8?B?Mm8vQjU0V1o1clJOc1h1R0IvY1N1RGNKazh3Wm9Rd1lUT3NxRS95cWhUeStL?=
 =?utf-8?B?RCtOOXpJaTRRUWo3a1JTTGl0WWRoQkR2VHl6enFrRjJ5dFpKTmRia1hzd1dh?=
 =?utf-8?B?RVJFc0h4elB2Y0VTbTZ4T2RFcVZhaTVQZ3N2UnZOWkZDWkJibVNzSzh4bWtm?=
 =?utf-8?B?OEFSWDc1YndKbU54SGhIY0NXSmFpNGVpMjc2aDJqOTgyTlI3aFYwalFjSWZR?=
 =?utf-8?B?enhEYnJnMlIwWG10K2NZZ2hlNC9TbC9MWU14WU9Ca1c0RUoweTZQTEQwb3Qw?=
 =?utf-8?B?bjd1eWVpdVN2OXBRMFMxdlBYTmk5b3I1QldKTUZuZFBYanl2cC9mblY3TUx1?=
 =?utf-8?B?SGlsQUJ0SGFCZnZBVjMxaXp3ZCt6RHpEOVlEVDlLM00yTUhQbEQvQjhRTCtm?=
 =?utf-8?B?WWUwaCtmOUMra2tJN3dJVkVyM2EwMUkrUXE2YmhGNUhWR0tKQjhoV0tnT2Fm?=
 =?utf-8?B?OGFWbXc0c2xGcHhkbWhURWRuOStsSlMzOVBVT1E5Y1JvT3Y4T3ZNd2pRTWFB?=
 =?utf-8?B?SEltVlQ0YXI4Mm1zWkI2Y3RTcWtOczFCRnlBUndsckk2NElwZjM0TzBwcmFw?=
 =?utf-8?B?Q25mdFRvQXlMci95OGtra0JXNm1kYkllcDhkaVVmOWhTZEp4K0x2UDJPK0dI?=
 =?utf-8?B?SDg5WjBKT0JCWHJZVGtDSzFBWmV2aHg3am9vODhJdkFDVGl2OXJ4eEZqOGw2?=
 =?utf-8?B?L0J4N0FqQmZvUnZXYXpoSGhlSWtacjJtYmp4STI3bXdKODRDYy9JZkFlcXlt?=
 =?utf-8?B?OXNKVWYxTWpxY0VvdUM0S1F6OHNhVWFPNjdZdDk1SXA2MXRGNmVmejlkZVdG?=
 =?utf-8?B?SktYNjA3cGd6ZkFRUERXVExwTC9aVlcyV0phYjIrMGZCcEwwZDg4bXRuL1hR?=
 =?utf-8?B?YkhjMFhsdWVKUC8xQzF1SzN3SXRqVjJveUFEV0p3UVFRMlJ5RmgzcXpvbWN3?=
 =?utf-8?B?Vm12L1hGWlJqaTBhRHRER2tPamxEVXdTQWpob2sybEpoWFN1dktYWUNjZllt?=
 =?utf-8?B?cmlHU1ZVTVVFdDBMVXlkbnROdGRNVG1wSTZ5bll1bzZuVzQ2UE9ndFNpT1Nn?=
 =?utf-8?B?ZHc5RHArMzFpS3pPUlhrZGVySEtjWVVMV2dLMURhaHMybmpEVVUxK0JFUlNu?=
 =?utf-8?B?b295V1Z2cDZZU2ovUStNak5kWlh0N2IzVFNsdDJVcUxhN0dTNUdYS3ExbVhy?=
 =?utf-8?B?Q2RKQm9TKzFWL3lzaFZ0ZHF2d0ZjWUdPMlYrYUFQbm5aRHcrOGFxdi90T2xZ?=
 =?utf-8?B?VEhxQlNvckZHY2JRQTVUVFVWbHJFT1VHTWtXNUhXeVExNGR2S01VTHpPVFFU?=
 =?utf-8?B?dmw5WlNUQzFCZEdwUE9va2dycXQ0MThoWjVsQ2pUSVVkTzFhcWNxRGxjRFhL?=
 =?utf-8?B?djdKMS9BQ2F1RWpsRjRLcGFvVUt2WkZrWXduRlJvdUxNU0U4N0NrWVBVblFt?=
 =?utf-8?B?Zm5tV2piUmt2cVhOOG1kWi9NbUJNWFlnb1pabUhQc0NqaFpDdEZMZHhpTk9M?=
 =?utf-8?B?QW1iOGY2SUNXcGI1dGNpK0ZMS0FQT1lGcFYyTklDNDNPbHZ2YmpxYXhqZk1n?=
 =?utf-8?B?VHdwV0FqS2MxblFxSk02U1B5ZGJNY1JOUmdkWURWb1JXelZwWlR2NTE5dCtI?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C0AD4595DE43D4582BC97EC956014DB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w7k8sqgW+Qg0aAAHZ+jkGuVIspO+NZalcblWphKR48Wn7N0gLG3Kw7jrCKslIWwg1elXu55WvZV8GyodeRyUhVWDyktJReaJmtiyeF+0KUyJ9fpbBIU0Dxveqe5rgI+P3QAao3P+JxGnufmqgFQllfdd0dsMQ/TKe2gb7NgWS614hqxlGmVT8Pa5fwuq2rntXD7sMuzbiMgAAQqp/YlYNa6IWg3ccqYUqpQKpSsMAyMHNiUKuMH3ZJKsXZLDcdpNA3jy/dmBJ+NSSIPqcy0G+6xTbyLyO9skoU+CwYu4wu0kSu1eqlmK7GpW+TbmqkX6UGXQd/P6zBGi8y+P2bH5yWgYnpgJzpDkEfeW9UpFtnkoGqsXupWCINOW2d3d8u91FbjhKIw6XiKsFus1hmazjX7FqyzUsN2Qc3yPr3aIXua4kdsmp7mIHem9y4zmY1XeBYG+Vqk39ITcQviTTPxchm5Cf559WZlg8ib+y9wcyy4LVA9e2+PydRo1rcTkhudVfnJp95covg9BgM0LUgFtKhn7ltTRmHI/BnFP5dvV1mNpnz/FORL1J90B08I9ulFTu7aOFMmTFv4vPFnqOpaKLoA6gI/l6IghtmnZRQ6CJusVb2IHltrhAhlsGVzypaaAkqbK1AsY4FBFgee7lGzIyu7enuTvsVkgG06lDcYowFPNBug16HRtyKzaR/KiyzqokSP66YSqDrJDY4lmLqxF7RAUUvSs+p9NFFwnbmMwKwPG8EUI15K9HPln3+pnPuDWzWha6DQ+dvzyT300fkWlyiK9vk/Okc/qwEBFF/CRp9aVlg/juI8CXF9r2rEo91R6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de424860-c6cc-42b7-62c8-08db141536ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 14:09:14.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bpa8PZfksbuZXrM34oCgBYUGKlKh0qRiKfDo2Fd5o4lhsbu+cohvmTXFz5x3PS1HMFsHpmxwsaWmmk8mbYzhX9QaeZ+azBPau9+LqjvDdEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3522
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjEuMDIuMjMgMTQ6NTcsIEFuYW5kIEphaW4gd3JvdGU6DQoNCj4+IC0JaWYgKGJpb19jdHJs
LT5jb21wcmVzc190eXBlID09IEJUUkZTX0NPTVBSRVNTX05PTkUgJiYNCj4+IC0JICAgIGJ0cmZz
X3VzZV96b25lX2FwcGVuZChidHJmc19iaW8oYmlvX2N0cmwtPmJpbykpKSB7DQo+PiAtCQlvcmRl
cmVkID0gYnRyZnNfbG9va3VwX29yZGVyZWRfZXh0ZW50KGlub2RlLCBmaWxlX29mZnNldCk7DQo+
PiAtCQlpZiAob3JkZXJlZCkgew0KPj4gLQkJCWJpb19jdHJsLT5sZW5fdG9fb2VfYm91bmRhcnkg
PSBtaW5fdCh1MzIsIFUzMl9NQVgsDQo+IA0KPj4gKwliaW9fY3RybC0+bGVuX3RvX29lX2JvdW5k
YXJ5ID0gVTMyX01BWDsNCj4gDQo+IFNob3VsZCBiaW9fY3RybC0+bGVuX3RvX29lX2JvdW5kYXJ5
IGJlIHNldCBoZXJlPw0KPiBJdCBhcHBlYXJzIHRvIGJlIHVudXNlZCB1bnRpbCBpdHMgdmFsdWUg
aXMgb3ZlcndyaXR0ZW4gYQ0KPiBmZXcgbGluZXMgbGF0ZXIuDQo+IA0KPj4gKw0KPj4gKwlpZiAo
YmlvX2N0cmwtPmNvbXByZXNzX3R5cGUgIT0gQlRSRlNfQ09NUFJFU1NfTk9ORSkNCj4+ICsJCXJl
dHVybjsNCj4+ICsNCj4+ICsJaWYgKCFidHJmc191c2Vfem9uZV9hcHBlbmQoYnRyZnNfYmlvKGJp
b19jdHJsLT5iaW8pKSkNCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJb3JkZXJlZCA9IGJ0cmZz
X2xvb2t1cF9vcmRlcmVkX2V4dGVudChpbm9kZSwgZmlsZV9vZmZzZXQpOw0KPj4gKwlpZiAoIW9y
ZGVyZWQpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+IA0KPj4gKwliaW9fY3RybC0+bGVuX3RvX29l
X2JvdW5kYXJ5ID0gbWluX3QodTMyLCBVMzJfTUFYLA0KPj4gICAJCQkJCW9yZGVyZWQtPmZpbGVf
b2Zmc2V0ICsNCj4+ICAgCQkJCQlvcmRlcmVkLT5kaXNrX251bV9ieXRlcyAtIGZpbGVfb2Zmc2V0
KTsNCj4gDQo+IA0KPiBIZXJlLg0KPiANCg0KSWYgeW91IGhhdmUgYSBsb29rIGF0IHRoZSBvcmln
aW5hbCBjb2RlLCB0aGUgc2V0dGluZyB3YXMgYXQgdGhlIGVuZA0Kb2YgdGhlIGZ1bmN0aW9uIFsx
XS4NCg0KU28geWVzIGl0IHdpbGwgZ2V0IG92ZXJ3cml0dGVuIGluIGNhc2Ugd2UgaGF2ZSBhIFpv
bmUgQXBwZW5kIGJpbyBidXQNCkkgdGhpbmsgdGhlIGltcGFjdCBvZiB0aGF0IGlzIG5lZ2xlY3Rh
YmxlIGNvbXBhcmVkIHRvIHRoZSBiZXR0ZXIgcmVhZGFiaWxpdHkgDQpvZiB0aGUgcmUtZmxvd2Vk
IHZlcnNpb24uDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20va2RhdmUvYnRyZnMtZGV2ZWwvYmxv
Yi9taXNjLW5leHQvZnMvYnRyZnMvZXh0ZW50X2lvLmMjTDk3MQ0KDQo=
