Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BC6B715B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 09:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCMIpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 04:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCMIpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:06 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91226C0B
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678697105; x=1710233105;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HLybOQnT5BpTfZCARWTOjVvCRrLEMORYyYddUgwTzjFZOnMa0yhqdT28
   OzLgWAyw6ZcZ00t3j2lpsC7erbGZVu6HI/oMgCLOz+j90dEjHV/faECzk
   74pFri5XuhXXzlCsUNpnfy2riCzQQXR2fQkkckqHhD0jCOOJrUiynogp7
   5z8YCCpmbrrlHw54URC5LznSnf8Xpo0HmGdSQkGLwAyw2IlS7m+z4mcb3
   W4L/KNbhyoxLJorFutW8qhqYHJmbA8h2KuHOF5DqXcbuTfgsUefxeavxz
   I7MfG7pOIbSywcCH+PJRxlffoOBmH3VPOPcR7IX3/M1vb+l+9qZWpnG4r
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673884800"; 
   d="scan'208";a="225272319"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 16:45:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j64Q9eglX+7t6Pw2099sAxcSBS4F1SSBc0KuIC0FFUt/eDcpG2rVd0bBgo/2VXM/6Y+/XPaZjAk8iPB7IfXFRQ5kB9Ooz5FYXOi2MdYkGkbP53PnexoRLNYGiG8by6TBqZJCTeQoCxTLJ5lIy6W4+4wPLqRV1BQzdPsNiAQJieyhCnpQ2kmwwU3ACJpplrC6kJsIrKpHu4GEkYIfUvFJmyDQRNTFT3zORkpZjttT8746vgUnSWyefySoQjsIscm321/fkmopy5gcvUSwBM7fq9q36fdIFCf/lNS5jgBsoJODYOldp7VnGid16VWdrHw7pH/RqD081F6aGNK6ahAF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BcxrrwvMgT4qZiSkbf1ljMJpSCyaYH457wwxxbjnoV1Y+wxCashddSH2+MoQCOjuJxAIEX1b6qhFiRLPbW1UhCirXX+XB7pwpbZyJ0GtwrDk5ncY9XmFbL/5P+ohvX8TDlEcbwe/breotbnPGL6HDIJHlMUO+ID1k6/UxgfqEP43WGyTo535FBbn5KsBS5qr/wYsPAkBlXNr9e0cgqn5alddRtqDnruxKKHDOasZfAMVLTrjFv44hv66VgPUF+uW1m/EDH4/q5ViP102sb2E2zHSyUretjhVtdY4kZYGrg93RLYfLs2MG1NFjDeE8KSIhYe5OhE3rkyE0arUhnLD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Xl5ilyUd3FTU2W8jwDePKxeIovLhnLr99rMw0oJPQ0Bdi5XGq6IOczyAld1z5cHAzyxOEwso48pma6ofuRWZJvrUfqCWPQT25z30spUkp1P6pJsiOdiAwT6Z7iWre/QkWN/div1zvKerdeA/k8jYtehpxRQ0HRbQUdKYc7aw/58=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3521.namprd04.prod.outlook.com (2603:10b6:910:8d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix btrfs_can_activate_zone() to support
 DUP profile
Thread-Topic: [PATCH] btrfs: zoned: fix btrfs_can_activate_zone() to support
 DUP profile
Thread-Index: AQHZVX2kjuy3lG1DRECE3RgLNrlZN674ZTgA
Date:   Mon, 13 Mar 2023 08:45:02 +0000
Message-ID: <40fa1cda-c7ab-9541-1270-106d3343f243@wdc.com>
References: <b0e431dcee052cd66decba8a4484d28055d5d843.1678692557.git.naohiro.aota@wdc.com>
In-Reply-To: <b0e431dcee052cd66decba8a4484d28055d5d843.1678692557.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR0401MB3521:EE_
x-ms-office365-filtering-correlation-id: 9e303748-5523-4f09-4f08-08db239f3c99
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNu6sxMT4Ize1lJt2YRG/cfTALkhv5RrYLvzLbsUXRPAZhv2Puj/ETa9BCCEs9ahpYGf5MqvuVmhZywX2T07ckmtjFW5I4cmvoLXHX4xqlZRLCt8cwHq3BcvjMTxAxutwdEN1ykcUT9csg9KTR446TmzbZFqXSCvMJnTdv5adyXwcHI0CmS3aGh1NyN4LwSzrelf7MRWFmRFs6822dvYZBcK20ox2AeuLxd4RP8pqHWk3TcMtaZfiIfWTjyVcl8dYi1vfrf5nvD9yv63UzAOp4tNEVBJ56vIL1P5gNkrOwYYLwAreEddiYbcORYXgvD3UMCNxA9L8QTLrffbvRw9B9uxHkNSREIAsKQgBwzp+nmE4bNC1hB165uey7Jodf2nfDloU5dfx2+K00Vqybn5b61/1/ZHmB4WdbsRcHtz4sJDVzNsNOi/TLFyNPrR4MC/MNxpLHNWdkLleO5WtT3x+9LFWRurxUb1SGQq1mT02+cJcmU3L/rCdL8s0IDJKeyI7i8vDdHZzY2e7EMlZtCsN/H1vczBc7RcTfiXic8n/MWLf6ugZCr04PWL+1xiTs1Iwqu/6Uen4bToif8G2sJs91JNFouAGVyw8xfMx/r6FnjPGPDfnBN2VTuXCwLIfcW2uGijktvTdGGLD6KY2TXYruOR/aJI1rSopcHO9nsN/qJfvwXOuUzhGtYlt0rTDtGVbXxiKins92nQMqNW2phv+XGpLzAPhoEyjl/C9nomGgBduqS9ufYq+Jt4k1l5L0kP676Mry/OaG1RbRHboITPhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(2906002)(82960400001)(122000001)(31686004)(19618925003)(5660300002)(36756003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(41300700001)(558084003)(8936002)(38070700005)(91956017)(316002)(38100700002)(86362001)(31696002)(110136005)(478600001)(2616005)(4270600006)(186003)(6512007)(6506007)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2J4anJjd016VU1ieDUyaWp5RGFINU1neTVWMG9SRmthbWZvMHdjMk5hdUx6?=
 =?utf-8?B?R0dXU0VaQ3c4Sy8xK3hkUHY0YkRyaWFEaFBPK2dQaXJ5RHlzWWlhVEVZUUxr?=
 =?utf-8?B?NkxUTDU0L3E2UUp6SjFGdW9UYnFaZklMaEtNVzZSM1VyZm4zVWdkeHRETmxO?=
 =?utf-8?B?RnByM3QyajNSUE1aZjlPRVJRT3M3Vklxc3FBTnQ4RUpGTTIxYjZlc0VTK25q?=
 =?utf-8?B?WU1mTjFNYVpLQ05mNnRqVldLT082RjRSS2J0NUgrSW0vNHFWbTRzcXdRZ2RO?=
 =?utf-8?B?UUQ4SVZ3WlFMM3NBRVMzb2RNTHNlaFBDandSMSt6bkhQMnkxZHVLR0tLWjZr?=
 =?utf-8?B?S0hmQ3R1NEgxTWVETkthMFNIZlBrYi9lSXNUVVZLanYzSTJyMGp2QXh3WU9B?=
 =?utf-8?B?TUIvaE02amIrejM4aHJDV0EzKzVvT2VJcWRtdlU3b3Vzd1VteVJKNm5rRXFj?=
 =?utf-8?B?YjI4bmpyQk51TUFGS29rWm5vazV6amZWNFVVTEJEdFA5VGpFS2V4VXBVUkZo?=
 =?utf-8?B?Wlo2NXlSWXZwcG5RaDVnWWpmOE1QSEpWVWM3ZG9aeDI4TjVqdkVFc1d2RjZE?=
 =?utf-8?B?NmJhaGdhU21XK1hTYk9RRW96ZDdZL1QyTDZyZDJoaXN2ZHgrRlhmT1hSSkQv?=
 =?utf-8?B?NkFxeXZhZHpxZVJKM3dWL0pJNGVIaGF5OU5rSit5QndsdEJ4VVp1Uko5YmFh?=
 =?utf-8?B?RExzWW9yZENXdEsvYzRFdGh1dzJ2akxXUGtmdVJsQWJtakxydFdxY0NzZm1G?=
 =?utf-8?B?c0E4eDJYOVdIaUxXL1I0VEJFV1Y3V3Awcjg3dzJIWk41YkRCdXRkU3Z5M29s?=
 =?utf-8?B?S2N2Yy9RY1RPeTJUeTZ4Y2ZSSFliL0ZoWDV6cHdEVjdESmNOUHp5Rk5ONnFw?=
 =?utf-8?B?KzM4Zkh6ZXZEVlgyNjZWSWRNa0ZvQ1lUM0R1ZkQxYm1HVDhFVjJqZVlrejFr?=
 =?utf-8?B?MVRSc083MXN6S3hESnBkbS9DK3F2WkNoeHdJd29aYVl2U0Ntajg0bEFnT05K?=
 =?utf-8?B?eTRsdTdidTRrQkNNSnVsd21HK3BwVnJjSzVkbStEazBta2JLNm1wRWcrdnMx?=
 =?utf-8?B?Umc2TDlQc0ExSllEMkd4b3l0T3NOSXgwK1ptU0RscTVMeGYxWE8waWg3aUh5?=
 =?utf-8?B?aHhBZ3JDd0Q0U1puOGdvalRFejh2YWRocTB3YmFoZTRrYzRDWUhZOVd5OGs2?=
 =?utf-8?B?VEMzMm9WNkJsVWJaREUzdGVZR0pRV1VWRFBnMTltNWV2MTFCU1BGbDFyMWNH?=
 =?utf-8?B?SnFLWjJMZjhzbjMzS2FTamM1eVNNQ2QxT3Jsb2IvY0p1YVFJRUwzUWErT0Jy?=
 =?utf-8?B?dlFUYlc2RWx0OGl5eUFrU2ViME9NaUVhT0tCeTJhM3FrcEJpQjRFTVRZNzJS?=
 =?utf-8?B?clJHUGhTNHNUc0c3eUJDUkUvTUF5ai9uM3o2and3ejJINTJCYVc4UVhxNUg2?=
 =?utf-8?B?ZW5wQ2hKY2JjUVhKSjhZeFZCOHdpSFBSSlBJQSs5UnljSjZKVjJGMUtJd3Zm?=
 =?utf-8?B?U0NGcGdURUQ0b3JhVlFxZW9wSm9CSFJ6a1lGR240OUlYRzZuSFpiYnFWQ3Bn?=
 =?utf-8?B?dkE3ZG1KT3pzbzI0d1hRcXRaUnAxTi9xK0VEOVRzNDBETTRXd2hIdXdQdnJq?=
 =?utf-8?B?c2k5OC9IL2xlWHJXMjdsT1NDZmdENG5mdHFuUG92NGhzdDVQWWR5c2FUUERa?=
 =?utf-8?B?bmhhOWI5cXRsK0RUcHAvUkFRVjg1NXdJb282d21oOXphY2tXZXNtK3l1U0lm?=
 =?utf-8?B?R1N4MHVSckJLdk45R3I2U25QSmZ2bEFFcER1a1YzSkNwYmZXY0xQYmVNdmVH?=
 =?utf-8?B?emFFMmgxSlNGaTJVR3A0ZlpkM3dSVVE2VTlPTERCMFFUQVh1UzJ1b0cvanNV?=
 =?utf-8?B?M1hnUi9rRmVmaXljN0p4cCt2a2F1Zi9uWjk4cUZoTExRZGlXZWJybjJkM1Vn?=
 =?utf-8?B?cThxeGo3dkIvM2RNMzkrcmxHUGtyMndHTmZYZTl1ZUtnOFBwNFM4Yi8wckpO?=
 =?utf-8?B?aTNaS1gvZGdYVkpjVDlJaFRPUEtuVXVxZFd1dDdXM0pCTHdmd0NSbDgzZWgv?=
 =?utf-8?B?SWx3eGRuRVZvaE4vbDJVd1JrdFcxRnNSaFNzampUUVVOZDREYjlrajkxMG01?=
 =?utf-8?B?K3NiblVTMXRFQUFOeEFJOXk2TG41NE5sck9vNzNISUxDeEhma2FYd1NqOTVo?=
 =?utf-8?B?cnpmMEI4VVRLb2c3b1pyQjFFcXZMcjlrSWh2K1dadFNYdjdEVkpaTDhhQzRr?=
 =?utf-8?Q?YOzInBMOyCMOLu9Tzf/NfqYra/C7P0zTcVT9EB8UwE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9305A232C7DE4948B2D0E8073E2B3F7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KF35QndRwqprVoL1HfDO8xOS1jv/Qsrq6eIbSTAnXMDwLK/tgk168G+WNthsDV5aFIC6/wiYuYb+tPEMmudKemcMNc+MW/3bFynEO4L4jG6vFd/AhVHqiXW7Vepu+jF8zuPABU9uXJ1DmTFjkvRHbuydC4ywwWxc7ceuYO+lRKbFgsjuaxczVjcmfgcqdH/gT8l3M2liw+KxBlX8y+PPxTvOOAx60Ssw6TLsfwTz3Xcgwthj0oxVIZEzkqVdSlWR5gkTQHJcVzD9bC0FwLnyajfC3BsiDq4W92AiG+4k95hVzb7ltnwpWoYCgeil2AvWcSsFTpjR0MxIlhYq38lvzT6TlVFXcj6z8N65Q/lfa7/2OdaYRTBNnApYHdh2K9XWQGRag1pUbcLN/vYVpQePoDZeuSZk2lNW9HoYil5+W32tBZKHRzj71/s0WLeK2mM4evRY+WxZwBJnOB9L7NNlmYHNe4k6+nnMd5KlTYNFpVHYuHkl7MiR1ifbag+tBbxrs4QCZ5vGdNm/AQp2tsfuI0NEWh8kwfW5uTkDcP4JlASs55n0M03fmH7bm+pQhPJYJ/bkJT2rLdeavpFqUd6w3WE8UJALVH05H5QYZv4kHRUsu9SNxl8rme0Pn/x2DjbM4enoatRN9HCp3/UelMaIW+O4oos/Uz6KzVFiu6N000/5W/CqRUDENSjWujxefDmvlBKUA+DJdmzVDfe53RkigrRZF62wz9PDd5C+dNCGphTkH3U/mZVWjVjOw8IHrlcDylW312p+AtuFj+3K/bNBIA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e303748-5523-4f09-4f08-08db239f3c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 08:45:02.5884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ujqz78k4xIYAdBGH3jJ7Cneu0FZV7wstmxn1xQG86ryyFiLE8P71dm4RTifEgQ9brOVoJQvA4lMbyCs0sByHSVDVO0p0VQbWbjyUzzv+0kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3521
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
