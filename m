Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DBF605744
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 08:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJTGWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 02:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTGWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 02:22:07 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6A46212
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666246926; x=1697782926;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HLbDg6SX+FeT7uxzkeWbq0brV82t2AnURmujxE5eQxrrJe+CnCiZopF3
   s4i1EBTt823hWEILBlztag72cgKInQMOefvhKABxKJIGLamOWUiuh3VLV
   3uJdyTOYFgyGtXeixxP2M9znDHT8YgbUzx/ioMEPsa1XpNYAx+Gd2S808
   qYEAOHlSZDYzaJXQjNnTG+8RaeQvUwPTGrzapbKX2IIAURaQh2EP4TC5P
   VAA7Y9A5zzgqhAV1Kqg/xdR/DW0JLpHBLYBVwn5lmt5wFlYSWCuohT8cm
   eU6Kqs+S6Ce3AJmJjPRisIVfAFR3igTzQoiYLKPMhfRn1r1d4eYUdwHeE
   A==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="219456800"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 14:22:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8thjMZbx4grTVJuclnG3Qt9s/5Owmv+RFwAm2MGWAXli6hQ2nRhRoTNRMmopoui6VtRrTa7fHsuTZKXFLUrdPVGeOg9tk/oNJVGXPdQnziSAx/JeqqJkAcBwtzywZ2kJLTb1MEo1r/v9lWP7G58ujFCU3L48ZZHpMvUGvnGail2PMD+m4s+hDcZzTXe8kYrUlf7XyggDVQaLskmCk1MSEOox7bFJNo8N3unGDGXgFbKk3PaQGMB5ReOrClmico7JI6mHdqBxMqGZvm8gbg40kwBVHUaeYqj/EmFXVP4Csrcpy95e9+SlgZDQaCRemBHQm2ztwOtifTLVrzabbDRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NwQONGfXwld9NXm8vgnZRqEqdtzQMfn4M9IlYcdBjRxFF3ktaSvn0NDeTlhg9lHCdY1kzm9g+N/RRFlEffhamhd9kHUamn9uga0tzv7GoaM65JeT3R0SC15VruRUleSLGqP5ppx3ZjGfQK7JgZaaR/UqiaG5fnHYEhm15gC4MrL76QUTEU5CYBcS5vhJO76KCffXGBbAVFcC2qtt9orSgw0FRqA5wHjWoMEmRjdq+/gbbymZ5CmDvrNRqkan/yriksWJoDGn69A+mLo+x4FOEmyu7k2Rz7bCOg3BtFh9V8psBcr+Z03o+O92HZhsKTgm7EL0Od5hYCcWuStjhu6/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Az77ylwPbrzHx7UjVEE1DTAwkjjlkk1oR/EprGbrW6NslYFGhP32JmYmfyrRosDGdNjGS3L1VS00lcEEtgZjEjYtpT3AUEipkZUqQaF4BUaFSLZyfLjCAajP4E5ukxiMqLSEGiGYcexVI5fcpG7J6nqAFSyhR6AHl/9a1HtvUlE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7358.namprd04.prod.outlook.com (2603:10b6:a03:291::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 20 Oct
 2022 06:22:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 06:22:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 13/15] btrfs: move btrfs_map_token to accessors
Thread-Topic: [PATCH v3 13/15] btrfs: move btrfs_map_token to accessors
Thread-Index: AQHY48tOoKyEGM4BAUGrnyYT1gOlz64W0PEA
Date:   Thu, 20 Oct 2022 06:22:03 +0000
Message-ID: <3fa6799e-d448-72bd-4f02-3569ab2fc25a@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <1eb9a18b17e156ae04b5df664f431e212b1cb02f.1666190849.git.josef@toxicpanda.com>
In-Reply-To: <1eb9a18b17e156ae04b5df664f431e212b1cb02f.1666190849.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7358:EE_
x-ms-office365-filtering-correlation-id: 2a507319-4a31-49bb-fd87-08dab2636755
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvbaDO8pALyyVeR0/6YdeHVdY4ueLww/koKImRNaLMrllJW04/13KDVNa+GE76FS/qOX9PDhRmJeCMEacjxThJ6DFjzwVUfZ5emM/k3rcfuvTGXHWZZC1hyQo1FkqodOhCsOSnEZURm/ylvq4C3bkk56CDlt0I9FrpJMw/AxKK5ucteq0pQv0o4BpbUNVz0n5uCkqK4MxRv4zpTURzUHac5eOQ+9FWaTZiWR2qyrgQp6vjZgeU0q8GYLNz/271S6M34Kzw3whrr0LT9HFdSUMk+kWDLnTs7y+DcCzITjTOCWfsg5vwqalkveEmGeHMBiawJQRgo/yBQ33wCLDMR/7RaJa4LSAwfUz+1Xq0/uA1LkCV8s5H2jNSSSiTu+dr28IVLM9urALtY7j4rGG/wvETgnR0nbd66jcZPMYrYRL0nPVtu467Od58N4rpZq7znjUWm00Cso1SdCdNT/1wLi1CZs0Qvlt02tcAwykQr+iHt9nIUEy4rHX+PX2c6XobClZp9x52FNanNPALCNowA3TLwlMSldSoh3F3MerwxhCCXwvc5mtgBBCJ2ors4KBTLwA3d+jI6DLGXi5UV7hKwFvJ7ryzYgDhTvd0VqnkMqoIQ/iePxGq/ODRs420heSKibhKoSw4Z4ETHOS3qfoomhWRhzdeR1h4m0Tl1eJXXLH8grfMa0FbbtufHWScWQZkkPfd14jHdKo9zTK187LRaJAxemyosTslzOYDK+ud9Y674/OzFRQlCMR9dcBjH7VDcz7bdUdyqnNHIaqCLY+kPRzI0gA99nIZpDVk2K1thCND9uFeqq0MjBVo22TzPaHrKaaMmtMKUNUQfv1mkHw5shYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(31686004)(2616005)(186003)(558084003)(19618925003)(122000001)(2906002)(71200400001)(38070700005)(31696002)(86362001)(36756003)(82960400001)(38100700002)(6506007)(4270600006)(6512007)(66556008)(5660300002)(66476007)(91956017)(66446008)(64756008)(8676002)(41300700001)(6486002)(66946007)(110136005)(8936002)(316002)(478600001)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlUxcmlITWhIcTNkVjgrUDlCaUNISEx5QllYaE5XaDNlWWJDYTFWL3laWGR6?=
 =?utf-8?B?ZUhPMnBYMkIzVTJIdTEyNDBXMXYrUmpZdlVUaEtMSE1oMFZaYTRtTWtmOGZy?=
 =?utf-8?B?L3k0aXAxbFErQ3Q1a0pncy9MWnYvdGJucFRJdHVUUDhMZGtOZHR4QU8yOTBG?=
 =?utf-8?B?YnYrSFJrb0d1V1NNbmVTZERVY0xmZ1NFTE5hOFBWemIrWkl1NmVlTUQ3U1Zl?=
 =?utf-8?B?dEVhUEg4YlFUZ2hObW5STXpTMGx3UmgxUzhua0FCc2F1NThMSlJQVG5uQllh?=
 =?utf-8?B?bUJvOHN5cWlSYlRheE14eXZkcHJnMk1VZE9KeThxUHE2NDZBUU5hcG1YL1ZV?=
 =?utf-8?B?OENNWFVya09xZUFwelhTRUVyd0FkMm1jeUVmRkgrc3B1SzU4citlSUcwTUh4?=
 =?utf-8?B?TW9lTDVhR3FpZWVjR085U05FbkpLcXBXNEtmTm4wZ1FWcHhiODBWZVI3UVVk?=
 =?utf-8?B?NU1nSnE0R1NOeXBzOFp3Vmh0RHRHQU80NEFHamhNUVpVa0w3cXdsb2Y2c0oz?=
 =?utf-8?B?Skh4V3BCbEhjNFl1SDJKOFQzaHYwSGZqS2xKVExoVnJFMG5kVEZ5Y2cvQjVs?=
 =?utf-8?B?YTdMek1mTkMzMFQrb2NpbUFFN1p0TWtTYWR0WGNsK3IyYkNUVllWeTlWT0R0?=
 =?utf-8?B?N2N5dDl0ZDUvNTRsVFBOeDBjand1cHh6K0hPeTM4bUxoeVA1YXAzNGhzckd5?=
 =?utf-8?B?bVAzMDUwMXQwSElHVGEwUThNRzN0NTYxMXdFdm9RSXloZjBkRFFlR2M3ZnlH?=
 =?utf-8?B?ZHQzWVBwak1RVEZKUGVWY1NPUGkwUU5vSGRPWjFGUGRkTEF6Qjk3ZWdacTVX?=
 =?utf-8?B?eUp5WnUrRHV0Qy82alRsekNPL1RsT0dNRU4xSFdDdHY0NnY4ZGFKQzB4cXV3?=
 =?utf-8?B?eHo3Y2FqV2pXcHV3eHp5NzdOY01pcGZLa2s4WUtvV2hoWlh3aUtlcjJocjh0?=
 =?utf-8?B?eWdZSVJoc2tzZVBqUkd1ZmtUSURaVXFkTXp6cDBuV3VSeGJQSHBqSVhRWENY?=
 =?utf-8?B?U2VadEl6R0craTV6YlowVldEa1N1SHJPWmQ5RzUveDJKYno0WnVxcnhNRnVB?=
 =?utf-8?B?dnN6MlpBR2hybzdIRnhkSUdqaG5TVXEzVVhXYXI0YVBuOFhRNE85R3NSTThC?=
 =?utf-8?B?RmFqTy93MHFNdnY3bEw3a29Scjl0TmFSbzJIYjZxWWF2VFhoQ0ovTjU5VHVw?=
 =?utf-8?B?em1xVUMrbnhNYXlDVDA4VXlkNFh1Y25Gd2cxV0dCZFB1NCthZ01ESTJOVWNr?=
 =?utf-8?B?MzE4ZkM4SStwWEFIS21SN2d5SDl3QzQzUlI4RE92T3FsWjkvY2cwbEE5TmZ6?=
 =?utf-8?B?ZE1VTVU4a2VtcVJzS0lNMzUwWitXeTdsSnlLZDhPbE8rN0h6ejYrRGlueGtO?=
 =?utf-8?B?YVM0eGNwVFZUTXpTNEN2cU9tVEtGbGtaVnR0ODF1NFNQL3pEbjIweWJUSEc0?=
 =?utf-8?B?Nm9MREp6MnJTbTFydU0vOCt2MVBQektSRFh3b0VjNGtjZlM2M1RXY0FwbnRS?=
 =?utf-8?B?cUlkSVY1RC92K2g0eVBWYUxabnpSblcycXE3T1hmNzNQTWloZURWTVk0aTdE?=
 =?utf-8?B?anZrdjc2bFFtV003RUs0bkFKWm9nS1Y4eVNhQmtXTGFMRVlTL0pxdVZkL1Ix?=
 =?utf-8?B?VnRsd1RZM1dNUXBtWVJ4WWcwS3RQT2JtZzltWVAvSlBJY2dGeGNWdDZ0cVBQ?=
 =?utf-8?B?emdhSlJGR0Y3Z1hyWHJ2NFVjNWROazM5U3N1QzNwZlJyemkrSUg1RmlmOXZU?=
 =?utf-8?B?TGtUUVp1YXFhMVJraC9QYnVJTkNEU0JFbEFISHAwcWh1Nks1aXdTdEQvWlI4?=
 =?utf-8?B?VGZlaTQybHhZbHVmKzRVOGEvdi9tQTR0OGtUSWM5MkU2SElVL0EvWWwwaVMx?=
 =?utf-8?B?Qll0Y2t2TG90QVRYd3BrRjRuM2NaY1ZaY1FLVlVTSlFVSUU0OHRCM25jbnNn?=
 =?utf-8?B?VTc3ODRYMXpsSFZUMHlXR3VxM2hrZFdZczJVSjVpSEhqR3Zuc2Vua2ZQSERo?=
 =?utf-8?B?YXhvWktkWjl4cWltQkhMWmlNTFdzcXc2SEo2cXJPV1BVYmE3YmdXR0s2M1dq?=
 =?utf-8?B?NkxicU1rWFMwQ0YxMGNvczdxSXpzZytQeGFJK1BrNStENUVVRHRNcmN4S2ZG?=
 =?utf-8?B?clhEdHExZEozMXRERmUrdDVrUVh0NDk3SVBPS3BHREhiZWpHMkl2Z05ZSUNO?=
 =?utf-8?B?NlJiVlkzWWx4d01zYkFLOE81ZDVtVW1RdjF2Nk9wVnhqR3E0QndmaGkyVGtN?=
 =?utf-8?Q?LWgFT10wIeKQFz6mOvMllFRyNNZCyKnFn+ZWMK8xDw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9261494816DF445BA17138CDE15AFC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a507319-4a31-49bb-fd87-08dab2636755
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 06:22:03.1229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QcfEnwTP1TgsJNidoi0dwC0yngwQKujetDa0kr5yf4KjyT6HOAeWU2++fEh/D1oz8wd9r/iZtFqm1xpzEcrIfeD/J8rB+TnxNHxIHOhT7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7358
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
