Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD069E0FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 14:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjBUND6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 08:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjBUND4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 08:03:56 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019411CACB
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676984632; x=1708520632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=YcNL7YStDhAVz46RrnMg1ACaVtz2wEl7FTx8mbvX3QaVeUh8fleL0NLf
   GRQ6RKBjl8buEUHR5GKzB3X8mcmKvLj1Pc3vpandMkqfCv4QoK2wuo0PR
   Exo+z3zY3/jeMalyirWymizMx8FSuYsU9Yp/gN5T10gPQW09vVbphLie9
   9ndc/HAnDzhzDzqbw0KRptHxSqmABtQjzIbA+UFz4rFXJaCKHybpqp+xq
   HYMeEt7rPi4fq8naIWFovXkkYd/ZSDD3SfshUm9crw3DrQemcER5H7XjF
   MrO/yDB4Lwyg9ZuBHjramtaC3LzhC6m17m5UeQwOGqWda/47aygBcflmk
   w==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="223816960"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2023 21:03:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0S6tzB7zMXXisYuUkhI4S+Nk8mHItMTv9QFhcIE6Ww8Fef6yynnRqFaJSXIOE8XJBPL71hpj4xLQG1llBR9yCCis8EUt6KCgUw1/V1HkhAVZeqD99KI0EXpeqn+G4eqb40P6D6EnV1x24aotwo3ppk2yjP5Tbm0gC7WgHGc3U0iOn76lqTdEiBeD4R12fRnUjH0jUCR63+XmB2NeOOX/tJ3/KmgW69HSh/k430soc3gU2u8vamHWPlQneY9ohDWGTS1AgUm1iJn0HjFLLY7djvZeba307DoLlUeZ0uNIh3SnlnDXYNAaBqXuv8KX7jViWf3EiSiUHUiIvO9ededAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PLjFYgT6w+eDOD8cm97lmxJj1+1ECirhR8TeO6pTrtIzjZuB/ZzDD4uM7lQbaXR26+/Fzu5Uub5qYhk8FDyz2XAX0pis1uVxcjBZiYdlHg5juNeC2yy5sw9OyCx/XQKvPvg36Ul3YtUUix2VmLLu6KuRt3aByEBRMbOI/1uVfebAFPyo+JqRKNb+2fgb9tU7FZSMVNIf304qAL+N+AX8bvE/01VFReN+AxXcNJ9n0CoN5Y+yBm09bKrjLoBmX939GUh3ZCzMev7wQzsQWGXeEtF2JambgtMhmbhuWYr94S0Jyo9KiZ6LKWekuz8NjycfNTzz2BbPH1F/02rZcHPq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HfXIjSutA6EsYzQweAlAPwEOFpaEtjY1uFZXB0ojdrX8gIg43tRpiIWZTd0+hfj+NMVnC00wZOVxjETIELCg8m7jtKMd3B8syek2IyGgT1ih4URtdtM3v6edqtbm/HPL1z22WF+uAQDxjfyCEFJKzYR/2Tn27vWskwECxdsSkow=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB1090.namprd04.prod.outlook.com (2603:10b6:405:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 13:03:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 13:03:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/12] btrfs: check for contiguity in submit_extent_page
Thread-Topic: [PATCH 11/12] btrfs: check for contiguity in submit_extent_page
Thread-Index: AQHZQiStQpkviiPj90mIAx4J4wiUQq7ZZZEA
Date:   Tue, 21 Feb 2023 13:03:45 +0000
Message-ID: <08f35c0c-2a69-b358-4327-9c75b3cc4601@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-12-hch@lst.de>
In-Reply-To: <20230216163437.2370948-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB1090:EE_
x-ms-office365-filtering-correlation-id: 06a88acc-b1d1-4336-68cb-08db140c10b5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3iGuSCqD0lSmb2PJDPdWsxNQdGfCYcwAVCUEVJShwozv6qmEQW215G6s9bVQwbvqcAX1PR8pN+/vGpi4EGtQe2nZmhsGKcuQ0TUHXV0ADobaDV7o8MjCS/GfWRVIKZsWBPdWX53krLSorhRvGmtv9U2QfUI0hewr8EjBp26lcj+PACWS1IZNHMu9qaLoBqb5wQwxvTiOr+YWLkWSp9n6KHWCTlGBr2h9QMKH3hilddByYxFXSbnFpiAFxC/OjgXtPZ9WS1x9TZXeNUywZHRR59nOp+PZUb6aV3LY9Bqeq4raE4bUd9dZpe1afBa7tZwsr55Bj5qFJmMNJXNEtZzJ4+EwV/EYDfdWxQhqUauTt+PbkMe1fAMteX4KMQaYToJ0V1H33rQ6W+Gx5gBLOUTkkufQZopA5WzWvffZsh3tVMMhH9lkmfEeMmTD9kuibNRLbpFbyqXVrQGwCdRy+NEFlD5++5SCrPuRDMf/Ss/J/osga7LrcF38wySFWverqvC8ZlGguMD8NgYVgDx+YVZuolVinzu0hK15JD6zmLVmF+71pLXZjD7kItljSbTHX72PTJDBw2IX+Jfke0uRMlIfBIiSVYB/QS8DIKMYNTG3xOhme2YAPZU44K/HS7W+MqEGJ/S5QRft5bLr+G/ddUOU5A6MDsFzWkiUzKj/x4zwzr+Bt/UFM5iF8hSSzfGwd/CmMvwmwlmQqjQNrnqbnZ8btc/z6CNzRr8U4UzFYqYpzOs/y0WP34cm7CeaGx/gsvCFQfLL3Qu9QIBzST1LU8R9t6w08ufOny2iOqb/ICzXwCYWRofvABCznfO8uj/1MYTs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199018)(38070700005)(31696002)(558084003)(36756003)(86362001)(478600001)(110136005)(2906002)(76116006)(66556008)(66446008)(66946007)(66476007)(91956017)(186003)(4270600006)(316002)(26005)(19618925003)(6486002)(6506007)(6512007)(64756008)(71200400001)(31686004)(2616005)(38100700002)(82960400001)(122000001)(5660300002)(8936002)(4326008)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjdKQnF0dGp2ODlaRUJHeXduYWd2RUxkT0NDNzU2bEVBbW9qZXVNZDNlemdp?=
 =?utf-8?B?MUwzWEc5Vzk3emZnZVRvVFpGUzlEOUwxTUUwTWlsckkyOUdoSzZ3WG1kbTJv?=
 =?utf-8?B?bWhEMlZMdzdldWd1SG1zWjZLd3V1RlJQVGRpQi9SRExDc2srL0diSFpIUzkw?=
 =?utf-8?B?RzUwYnpkbWxDYVFRdXkwZWRyZU5odkdacFU3TGtYdW1reDZpN0xqSjZWU2Jm?=
 =?utf-8?B?SDB2NDhGWFVFdCtsMmF2NUQwUjJXcmtHOTk3ZVFBN0hvVktJMjZaeEZkR3l1?=
 =?utf-8?B?T2IrV3loUnJENjV5REN6Sy9pUy9UcEs5VWs4d2NvdndvSEFwNDl2Ty9ub0Ja?=
 =?utf-8?B?VkR2TEgrb3Vnck1DNDMwdTdpMkxTWDFvVnVZZzdTZkVOUHZ2aG9XQ0ltdDFD?=
 =?utf-8?B?MjZzRTQvc2dIR3lydjZRNjJZeFV4YWNjaDJrcERXS3JBZ29CRE45ck1TUU1z?=
 =?utf-8?B?dU91WnNZVXg3VE94NExobWREdjZwTkVvdkF1REJGamRDei9NeUszR1I2OTho?=
 =?utf-8?B?ZGQ4K2QyYk5DcVZTbjFoSG8xZi9BZWppaVR6ZklDK3dFRnBUR1VTcEN6bUZy?=
 =?utf-8?B?d0NYUThwTGZJUXdqdWp3V25RQStYRkViYXV0V2pya1VPS2JJdlA3L2c4WlNW?=
 =?utf-8?B?NzNWaVdsbXFFWlgzZC9kdzlzbUJ6eUl1WjdpM3BjNlJlZU5KbTgvV0tZT1BH?=
 =?utf-8?B?KzBnZHFKbHZoQlFlc2tFcUhPM0FHeFJNMlVhSjljdU5OOUw2OG1CcitidkZ5?=
 =?utf-8?B?QWI0amNHYU00VitncFNkQnFDRVBWYmlYUlVKckxIUEtEQWhzUUdrYmV0UFF4?=
 =?utf-8?B?bzREdG9Lc2Q3eHFuR2VnVUZKSW00QXRQQXhaNHU4azRHRHY5dFdmVE1SQlJR?=
 =?utf-8?B?RzVSYko3NytPU0gxZ1N3VGhUSDVFdnNyYnV1dlBFcXBXV1ZuYXB1SmcrUjEz?=
 =?utf-8?B?bzdLV3FaOXNCemRGc3BybkMwZ2ZJdGswQkpxcXBWcHZxRXkwZ0g0eDJNWXBJ?=
 =?utf-8?B?RGZYMWM5SUtHRkZZM1ljWlExemVRaWMrV0k5dnRIZ3N1N2FETzV3OWlHRDdG?=
 =?utf-8?B?WlN2VzFuSmM4UENBUmpXekUranVTQW4vSEFISC9jbnJ0a0U0NzZUUHRvTmMy?=
 =?utf-8?B?eWZ3YmFZSnRqNmtCRXYzZFUydkMydHRDOWxEa05VYm9xTkJsVXpHKyt3eWhB?=
 =?utf-8?B?elFuS1g0K3A4MXJDWXd6S3FZZlFYWGo3Uzg4UVBlem5UanhXWE5LN1lZQUxU?=
 =?utf-8?B?SXBWdVd6WVhPZ0I5OWJQdWZnM093dlBLOUZaQmR0alcrQlRrd3pJWGNRQ0t4?=
 =?utf-8?B?cmIxQVlzbjRTL2tVTTRNdGZqSkY5WFM2ekdmb3lydWlGcnp6V2JKQlJNNXpW?=
 =?utf-8?B?TUZKWGQ2M2lBU0pRT1RTNG9idFdORWtmaFVFSENpQjJyNGJqdmVXUnJ3RU9S?=
 =?utf-8?B?RHRHUkc3UzJNRTlxZUdzQU5pSExtcFZLUjVxNFY0YjloY0lQYVRSRjFKN1BW?=
 =?utf-8?B?eDNPSndGU0laVlk0bnZocEx2Uk1MMHYrM3NjYldqUDdmSFJGK2xPQzd4dlpT?=
 =?utf-8?B?cit6UmFnZFJQemRGeVVJWS9zU0dvL3hxWEFrU0E5SHBmaEhjWWhZQ2s3cDJn?=
 =?utf-8?B?NGN6L1M0OW5GejUzWVp0dnp3Y2JpUFR5THFDS0c4c0xKRmhuYUtwTEYxeCti?=
 =?utf-8?B?N0cxS1RHY3Y3SWR0b1hDRmh6S05kZ08zSjZ4c3drT3dLNm1yNGNvY3RhMGRG?=
 =?utf-8?B?TlZKNFB3L2ZYazJHWnVSVUk3czFNRVN3RlZ2bUhZWC93ZFdVbVJjbUlaU1RN?=
 =?utf-8?B?TlpscUVsK1ZiZ1VVN0ZGMFdVNXJZdGJ4OTNZcXJoODZUVFNtZW1HcURXZStB?=
 =?utf-8?B?RlFRTUhtMndoeTBrZlN2d056NzZmVjY1bmVzUTJhVGxXcURGeHNnOW56QnNH?=
 =?utf-8?B?WlRiRVBEUEYvai9RTzlubkh3QjlrTloycUVlVHdOZ2JJWjFWVk9FV2xOOVJk?=
 =?utf-8?B?bHJwV1JHUnZXaE9uRXpwek85SFE2QmZEUHVtekVXRFNUUUpzemdDc0RUQnQ1?=
 =?utf-8?B?ZHcrZFVxM1E5K1NCREY5M2s2WDR2N3ZMbERIcGVCQTA4MmZhY3NIYmdBZk5C?=
 =?utf-8?B?Q3hpMzdXbVJ1M0ZIUS81S1BKTWdMK3g5MGF3WjJ6Vnowd0lESDJ2d0xsc0VI?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E8B2E5021C72B40B9BD32892CBC0071@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 58DWInPO7maHR2YQU+y7gX0o8QXm0IqFWp/cHaQgJ6EHnvWqbaTu1CErDFghw/DbDZxBVzyUFnri3oFV/W6rNBN/FITKSrdwlzUp+OaukuM921LRpAZBJz9T62RF7CopOFV/L6t2f3uzwfmY5AOlh/ixQG7KpWmFU1Sj5QTm3KBXefuyX8sEPpiGuFcJcBww8B98Hkl8yGs4cFWdMtD3/YPVoR6b+lzWp5GJen4vOBExd0HNcf4X5xDnedejFM1/vbEieApxSHa31ZKl2tnuu6Ygv/uATUeLwsF0vVUPIlVskFx9xJLUSD/6Z27DT14epXeBIQ5His8E42HwTUgxXklbuVHhhuhI8jFL3pRIiOYAgkR23j19x2oSkvLMjiC1LJJwgEmfHwl4nUvb/CtaOn7CGdM1o0vJb6kjwR4KLncJA8XLALx9vYDB6MIGd5ZTS49lbFaQDgfzaFatebjL2PaBjWak/XGhIrXCRlGa/lUXSwdn6HrWwdWABG+t7tKIakn5a/66fz7VG9G/107KSeFalcVMDpbDskktdlyqL2QEjRfByMibfHvHuFyMAftFehaArBZiECq0F3uZXFKn2rtfSg3DGgqk30ahXbKo3Ysn8WEbvskA8WmeENcn56QrWDmQhtWH+jmYhUnG/+JZ68v9ccKs59SaBBriY9rogMS9od705x2ehbn1COr6u5Ce2g/3WxwnK9SnlhIjR40VUVKp46ZSO10m4flMsChPldAFTjyI5tOGcPUFBLsb7YmMf8DKnjG5GKw9BZg+ktaCa5ssbijLbSy1fFeHA2foBqPnNTRnbBFW9OmpXKCS3C0xbRNjlV/Et7MCoEJHNOup2U+Hs5VSJrxgyARLhDF3eSRQA+JxueXJdT7bNMmn9mvN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a88acc-b1d1-4336-68cb-08db140c10b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 13:03:45.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 865D5fQosQQxp0haSTF4PZ9JLa7IPCBBGz4PPSa4n53wMfWXhV6cOa2ciAILigcMXtaP38lv09QuvTCObodSdB3tKxBagpqRA67Pt9tcEGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1090
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
