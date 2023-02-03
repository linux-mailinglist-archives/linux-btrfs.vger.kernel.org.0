Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF068982C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 12:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBCL6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Feb 2023 06:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjBCL6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Feb 2023 06:58:04 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148239DCB3
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 03:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675425476; x=1706961476;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=t3+oOzD03dHDfd4e1uasOPcT2tGu1J8WK+d3zPZoWv0=;
  b=DbUFQgwUOya4di91UVdMPoyMVlV/DA6bD87Ehqx6aCjm1Pni83R2bP3h
   /PHHl8ThawgkZ4R4r/5rhJlVD9mB2/7qFrVtYkelDcun5+maEIVpmG8Fe
   tkNWsfUIg2r3PTHinW8OJcrN05YmM5ALvWkrLsm8kefnx4ixcLtd+x7dw
   FRqy01/cDQP06fIjmOMaNbhkG+r1kHD4KM9CaegrfMi+NUF1SdO9BU+4+
   cZ05YfD/KM+BnUXi21Svd97t0F3xkn086D3Lcjcjgx1I19CKFjYUt8b0G
   o1NASKrHWVhxWMOgQeXaQtkQ5CpJ8WXczQM5K1HHO3/YBZLkrofpOOngg
   g==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669046400"; 
   d="scan'208";a="222496055"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2023 19:57:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KouxmCtsM+1ux63oeazcsmxI9lVTVHxUp1XrQmB2UjSEF/jUyEq/t2+SiduB2UIXJ51lAdfX/68nIS29vO0Wp2ACKz0z4tX/XWBNyJqVhdjPUBsq3iYS2wFPz4/MqCz2x+2nrPEwdAhMYOorqLHNvqWma4ZQgDk/fZjVFPITYNuzen58BQnHedHTykh8t0KjCHpaJtcdYvKgEx3zThq97oCgwQMR1nNMCjp4utY1Xc4RVDYVFmifGpxt0gUvBApjykarfAhUxbjXzmj0DWa2T17eaD2mN5HlBge90eQyuTE9XLEi7GycwCrR5Dng3iJwx0j1dffeBZG4mMy0QWAClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3+oOzD03dHDfd4e1uasOPcT2tGu1J8WK+d3zPZoWv0=;
 b=bvIaX7iQpptL55jUTE0Mp6fXne9/4Q46yAP9qnTm0fKAxWZdwieLq+uVg2W9rUQU9NGHzZvfeX7wnz9xmSvady7zN99Mq7t6a+29KjTdnYs2JY8FrbXM+u52zw9eqv8nzBVsNoH+ulprfjAHeQKdmPkGjdo0y5/ZjE18kRsRZjTmFUetGtgcMQDMIhUdCEzC0GQBVoGqd+IAiUnjEyCZNzH1p00fPMadUdKeoA0v8pN5VgxXBecxYQZ7I8BlXams+REGsmCbcqlKjyie00S6oq3jrOtIm/nCBPo3mgOJs5PHoYBSyPn3zXen0gRoD/w21ngdTg8uAsz06++eiruVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3+oOzD03dHDfd4e1uasOPcT2tGu1J8WK+d3zPZoWv0=;
 b=Oo14nLbQONNJeEb4BFdP5+xGatXSn6+57qo/d+qgATpk5/o7FY2d3hNrGdBnhhJkv/w4AOynTivu8A8nH3u89mxSfQWTCPpP3thXbi4rrIF4+JGAXtVVK6kyVbWx+xYhvoYb9g3LcJ7nejBzznMLe7UJWT4myLAujfzyCESUwYg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7904.namprd04.prod.outlook.com (2603:10b6:a03:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 11:57:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6064.029; Fri, 3 Feb 2023
 11:57:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "liuwf@tutanota.com" <liuwf@tutanota.com>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] btrfs:Try to reduce the operating frequency of
 free space cache trees when allocating unclustered
Thread-Topic: [RFC PATCH 1/1] btrfs:Try to reduce the operating frequency of
 free space cache trees when allocating unclustered
Thread-Index: AQHZN2q2jdmhYay9B0WSToeS+tYMN669HqkA
Date:   Fri, 3 Feb 2023 11:57:54 +0000
Message-ID: <f129581c-c05c-d261-81f3-ae634da00d15@wdc.com>
References: <NNJm6i---3-9@tutanota.com>
In-Reply-To: <NNJm6i---3-9@tutanota.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7904:EE_
x-ms-office365-filtering-correlation-id: 501e75af-6b60-498d-54da-08db05dde286
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGeI0iub09eKc+cE6FWf8iNT4wRSXSR2CN1ajz3oO299pOhPGwWfoEBTe65SYzdXj/ObRAPRPCTTLC6lSyVHEJJ7117DhYIDqe9F0D6s6ESqZM1mAiCSYfbD8LvAOTMJdOI+DGmQK+poGgbhsdpWADSy3XI3yC89TuYWJjZrAob9qamUZPNPiEhgdx5HYcQNv+5pJ0huOkf0cz7rm+kDpal8Qb3NqEaHS8DrplzjJCFJhxO83HwcJG7tCJ0hg+qV06X6264dL0dmpg60tOtpGV5BN/bBq1o1uc0ePChd9WvWKc2A8ubNpuROhP53PCxW0sdlhRUjvthIG++ISPEHjFwhAOMMwBWLQoMVpfToUHh5m7Z62EvlpIO5oJ0d65KWPDPBszUbf06IMw836k1Isyt2cqciuw//z6Vv45PJNop04BDTbpOpQwe9k3p4j2bRXpPl0qTg7wz4sWUKFKC879xKRMyVu3fPpxZEdu49R/F1JIxbofEn5ZkXuinWJJjwnjFG36Tqkb61fCJIFJfrWcVDcddFagmkI5HK3ZaQFanZrEoXycoaM0GNQ0hQtDMnK1etLAFUaAHVG8k71EZXaA8FoVxtPJ47pdUFl3cYCIBO49y6kMn6d8S8MKRcI95QC+NTF1KNnGNHKlhNhTcTtV8TabtIkohrpPJCxnQAYkaY1pnzCbJ0oNn8zmeaHMuJXMsADw3ZuwJdPSgqLNLjb2h+aPiKZobPhYiNliWUrujtyYbMzxRgpZ1arauIBkFV7UpgvD6wlPldThpItHHnqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199018)(2616005)(38070700005)(19618925003)(38100700002)(122000001)(26005)(6512007)(36756003)(4270600006)(6486002)(186003)(31686004)(478600001)(86362001)(6506007)(82960400001)(31696002)(71200400001)(8676002)(110136005)(316002)(64756008)(66946007)(66476007)(66556008)(91956017)(66446008)(76116006)(41300700001)(8936002)(5660300002)(558084003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERYZGNXVGxpNmhMcjVycXpvNm9jNTN6SjhHWFhsNW8zYUxrRURkL1RPVm11?=
 =?utf-8?B?eWdXZE9JZUpETnVoSWcvOEF2VDdtN2RjOTdUa3ZYcWFMWmJyaTQ0eEZyQ3hE?=
 =?utf-8?B?YVlpVnpuSjIySk5CeDRKNmx5SUc0ZkxJWThwc21HbGNrZlpITkFvaVlPNVRD?=
 =?utf-8?B?cExOeFhWQ2hFankrNzNjVllvSGtiNzgyb09CdkUzSFpmaXJTTkZCZ1Y3WUM1?=
 =?utf-8?B?d3dZQlJsdjNRUS82TWpRRlN2NXRFOFlZVTRjaHVtM0FoVURLdlR5Snc5aFI2?=
 =?utf-8?B?cjRUVXQ2cWZRV2R5OUZFLzBlSnlkdHV3VVE3aFJueDlhT2xLWXVma0pkd1Ji?=
 =?utf-8?B?TDJuQUZoMG4waUNqT1IrNm0vd25CUnBzZGc1M1hVbmdzL1pZbGVpMWNwcFln?=
 =?utf-8?B?WHpqK1NPVEVmakU1NEJRRmhXTXBuRnluOUlGUjUrQUdCdWU4d3Axb2tpTUhN?=
 =?utf-8?B?dE9aam5JeC9sdnlRWGNIcGpsR2FYL2lXLzdidkpSVEFheWxMOUY4T00wbG0z?=
 =?utf-8?B?Y2E4a0NtTWJIZG4wVFo4d2c2Umx6cTlGY2s1MkgyS3RLK3d6bDRQVURqQmJ1?=
 =?utf-8?B?V0Q2MVNZc1VPb1lLT3haaEtDN3hCRFNyY21lcjFNVkF0MUNkZWF3YzVMdTRO?=
 =?utf-8?B?YmZvY200MWNxdkxTT2FzUkZQeHJvTkdyWE5tT2tDOVJJUEtDZzZSa2Rza0VJ?=
 =?utf-8?B?bGxGUlNxUUk3QjNPY1BabDF3KzQyMEVNQVNTN3ZtbGxLMFhjUzZNeGFDeUpB?=
 =?utf-8?B?ZDlnWUwyTnFZd1BxQnFUSlRrRUUwYkVIMWg5ZlFRWWREaE9LaHpDZDFoYk8r?=
 =?utf-8?B?V2FrbFQwMzdwUUhJRVFTb2FTaElDSTRWK0QrSmF1d3FrSjZuZC9WMkFMRFJl?=
 =?utf-8?B?V3MrWnlJTU1VM1k2S2hpT3l1SnNITFZmazZjQ2VuWXVFeGhWZVJiciswZUgr?=
 =?utf-8?B?YStMRy83anhYK3ovUGg2SFBNc0U3VFRXWUtvbnZrNlA2NlpGaXdiRXIzeDh3?=
 =?utf-8?B?TEVKeWVqZk5raEFnZnpIYktDb3ZyVDVJTzRLMkc5ZFUzZU9BWjB2Wnd0S0JD?=
 =?utf-8?B?aUoyeDVOdlFnZzhvVUtkNDdXaWJ0c0Z3TnkzdkdWK01tdE5sWWVXeTN4RzVZ?=
 =?utf-8?B?TnF5dkd2dmI3RW9EMWMyMUNlamsxck9ldzR1bFhaT1BhS2dtaGZic1dFTEFy?=
 =?utf-8?B?YVJNN3NtUzN4TjNpVlQ0aVdpQXAxZjI2SjNoNFdtUXR0VjJvT0NrS0w1V3BB?=
 =?utf-8?B?M2tRTk55djh3bzF5TTZrcTVpeGw4QVJuNjlCT1hjMkNFeDRlNzhRN3BabVVN?=
 =?utf-8?B?Szg0VWxBYlpoZUtIRDdSU1EwemRWR3FHNDFBUFhQSWhUeWR4WUw3WUNlNDFx?=
 =?utf-8?B?NkV2cm5PRlY1U2E3Y2szdWxMU2hheWUwQzRtb01HSjZ0bVNLTXVUeXlBbER6?=
 =?utf-8?B?Q3ZvRlpsNHV5SzB6K2EvMWxkV0l6ZXdQSTUrMENJUUc2YzRhUmQwbzVBWDI3?=
 =?utf-8?B?eTBleE5Bb3JoUExCQlU3cnllakFYUU5la20rbmxBdWs3QUIwWUVhdERUdVgz?=
 =?utf-8?B?Sk5uQXNPbEpscytGYWVjd29zMUI3LzVHYTc2ZGNwQTNXSUdKekgzU2UwcnVW?=
 =?utf-8?B?T2dxTEZqdWY4TFYrdkJ0WjMzVEtWdC96QmFpQ1hSbHZPY3V6d1pCazB2Ym5X?=
 =?utf-8?B?WGpVL2ltdFI1czdjM2p1ZkVCMmZnMU1pS2QzeS9vQnhwSEtiMzRNWVJaMkNl?=
 =?utf-8?B?cVZ3eFBSNy9XOWpDUDR5TGhJdk1YMC84ZFhXNlAyVzJSWk5tNWhlWnZleFQ1?=
 =?utf-8?B?UUxCY1ZBb2JhMmwyK2x5MDNkT2NYMGNVYWVKZHJ3cW9oNWl2NjRwaDBKVzh2?=
 =?utf-8?B?TUEvU2diTlF0clFMNXRBOG0xaUZsdURNVnNrNUtUOTYxczZIQVk2Rko2NnBP?=
 =?utf-8?B?WDNoajY3T1BEa2xmUytBSDErRGUyV29leEpqM2xSTWQ0ODFwTjAwSlNoR29o?=
 =?utf-8?B?TExFU1QwUHhFU0l5bm1WWHVOd3ZHMHVQeEJsbWZQUS84d1c3R0MxYmVZK3ZR?=
 =?utf-8?B?MElsRkxndDlNckE4RkJIais3cHhxTE1pWXJLcmRoLzRaUVRwOEZJOXBxK1lq?=
 =?utf-8?B?TVJxZlVzeDdkMGxjSU82ZXJtOE50L0IzMmJWd1RncnlJdG1zTmRTR0lueXJl?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D22B9D354DD20A40A259FD603F3DF56F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kBjbNecrkuhXVcQILEo1SaCzXuwBq7IyLOFg45Lq7TXEcVcP6xiJcnpgiA/4nFOYSNLj0FX9MFC/8N2BWg/esEtsSTVuuXAvk0MNvvJ2IBvTQ2xazrT8EF5sVbkU64XnBwPmhZCv+5kxgR9x4lKiPQlWh9N+8yoqneA8TQ6ZAzpQ+TSR/3OQk4T8/fqveJ2QclNzdEjy5tuisZadnET+43Irq76HzGpV8gfiPsuq6hBQd/FXCMe9yzSN+5ZC5aTk0f35btLkMtUGe2L7JgKxFfU1hYx1/SrD0hjlUXpcHNG9kVMoJpV0+VfFmA8BmKb936dKa30vfmDmwWniBLOJwQRyOkJFHdFDqEEBCF/VwPfnG9KeF6q8+LCD5aMM1ydOennPpVUu2WodeuYkg/0JIlgQhZnARKMZk/kuwQQ3OeAhlSZluwE6WBbehisHH2UfoCCvb0TrqOSwIZdloYACV+eiizrO0BdLHCk5YUQnryJDz7i/nc2jgQ+h4EbIPsECufRimQhvE1vu8zpehSv5oYCK6Uw4E3gTdHQnyK+5hdPH03ElDWTHZszqMDqX6ecKxhM2qQbIjPNppOV3u72WrGZDTEvkW0jFHOE04wtV29j7SFeCQw2KP8tlV+fMAxe3uR1lGQS6ELpooyfoDpezjT8RC0Sr4C2/STwm3ZThXeICnOQTD9+1307guymXzpAosJSXiQgU62etwvbV9tLTK2e0iDgLvSRZ2b7xjR5JBdQJPzVavZ3sHegwE9zgzEKc32sQBdWJzIj3FkM5OR6lwMVgwDiaVi5FkRNz8Uzo9ibuOqLQNkALozqqnhWn+5yP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501e75af-6b60-498d-54da-08db05dde286
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 11:57:54.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /y1hxCj8y9wgDUtzpVn0AP/HSFAm3XLYC+ldd6p+svE8PtGgIXrtbNIwQD4J/WU0x9uCHSA4ok3kGl8O1dvJaybtkCyzkdXwwbwD3e20x0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7904
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SSdtIHNvcnJ5IGJ1dCB0aGlzIHBhdGNoIGlzIHRvdGFsbHkgd2hpdGVzcGFjZSBkYW1hZ2VkLg0K
