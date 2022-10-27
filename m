Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10B60F480
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiJ0KKW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiJ0KKQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:10:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125B1CFD5
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865414; x=1698401414;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ocJQdnXntXhMY9013hLXw2MGB92pJZf9zheqtGNHp/ZUYQoxayQx+iw8
   /zp7jWiEA3jXnjocp41ekjEW5VXMm35oVpb28ncMgG0s1nNXlvoYid3SK
   6njXR4JLoFwFLczdf/BjKHmYV6dPbYFnqkztkrRaSNQgF3gJF99t3h4+m
   dCVFrCR/mqilRThmF9/vt7gZZ0E5oQ2LDI44NqtYz5ypP/99pkLzypf4o
   EhWRfJWIyKs9SxRmfD4mTqlnrUXldw+XlfkDiICE4XbGiUeNLG7aN2Qhr
   5IwU96zBBuKMzAk4YP+OUzygr7RYMfC2dzH2GCJ2UARWPbFp5nPaIL0th
   A==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="213161557"
Received: from mail-bn8nam04lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:10:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCCdonY10ZC/KKa6br1UsfuzjVw9mUiMWQLJxCZi6BiDET3qyWJdTE/yrDAquMOrCx6/r4S/hFHkbZ43wukUkbT41os2DXh6uKR8y0z9P94/mnmi+cYfSBaEAev71w5a59xE0sl3akpMhFcrts4l5u9r46kKNDTg0BXypBrv4joX66WhKbB0FjgZMhcdYBeV3Z3VKDJxjgTblLtG/472kGztCSGFjkHgOaseVsHD3kgPV8ywY7o1oBDTfDQsSIhqjNOJb3o0hZCVFnqpYXSi6H9De287dyTxxrScz/WuWGeOCMi5NbTpCNUEEzIQhZI7BN34rlPbHllbN49V4BYDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=btgLIdXL1U8aKnDRU23Nz9H1ylZ3TwjSHfIstnKOdmtPzWvN4ywDs2OH2GZg9xW11SmBFsKMSImsdYERhxC7Tk2OHp4LarUArnxepmRD/yvgXKDMIGX5N7EI1ChoZrTi4zPTsiPuMPsymhUzF0g4dDfP3E5eL+6+9sXkyPoRU006sx6zr3GNoy/3n67A6tidlUlBPLjVF6PdMWhYIq99TILXTnyXiBcHlrNWDe6NC3lqDElB7q9Vpd5VvgtTVRkAQ2Kg4JNEWBB4v688lnEaRn2kT5JeiHgaDn7lJ8KBrwaA5A48oUmxz1QpSx760d1ZW5Idnrd1Pe4aXNGHVdrZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Z7QrAxdWxrejGatqWfqADTwKDJyQsyZYZ6XP3D0L1zTp+B+YF1eyCesjPf4CQ+4AHPvecjTfI7nzC9L8NBzgUopaF4JA+SoH8lsHyMyNRIK+SsXRNJvk7LNZn5frH4cafWBODjfBAgi/RttIGT1x4cZjL4BfNUztb+e+QAyjUf0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5758.namprd04.prod.outlook.com (2603:10b6:208:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:10:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:10:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 17/26] btrfs: move the snapshot drop related prototypes to
 extent-tree.h
Thread-Topic: [PATCH 17/26] btrfs: move the snapshot drop related prototypes
 to extent-tree.h
Thread-Index: AQHY6W7am3u6fPx2IUiA8FcCM6Zgra4iBbwA
Date:   Thu, 27 Oct 2022 10:10:12 +0000
Message-ID: <21e38dad-0866-8dab-a0bb-a64a0631a254@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <2235e6eb3854dc111d0e0211c4a4d012741d6691.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <2235e6eb3854dc111d0e0211c4a4d012741d6691.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5758:EE_
x-ms-office365-filtering-correlation-id: 6510bd49-d8b1-460d-36f3-08dab8036fb6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JprpR6JRYdvOQUlR9Kv9sBBynZrUcQwgYJ0+l9T/zu53hkw3Bl5D8cnfKOzo5vIXRNQtxgcLbsYz2ZCRNi4qjwavADNXc9YnHUK9BcIDkPRGIx+XyZk10g0NLX5pAJ1HdX7w7Mg+DMQ9yDKFs3D834GJkjIQJz7Yr5Xm5BRpkCcZM1S5iX9CL9I6e0WhQBOlSE69yrJTejfzG19SFEpzDNgevFdrwoevvt9ga3KCMA7bjh4P2CysGf3TJGTv8cKOcoL95I3K0zihVk8nwW7b9Kp1Tga79KCRZhEkUueli5WJX8rSbugCDdOG2Ngmk+rBQaFJZb5KkSc1B7s/NVvs8x6rNH3Dj7bVci72XUga0Ol9gLw5v/F7XuJ81O0qpgYxpyJ03glpeEWySsB8g0AwtQMbh+PJn0hcDxcSYK99H+zfNCECdpW8VLH28AkU4gOJMkRHs0zvlxmtbIMA7HGa2HTRTqyoZVIWfaDbkZJQAwtUMU9oKILgG8YqCYjIa+IDKn98i3HDRc6eBiij9j3d4+Bn1/eH3zhNfvrGZbmX22YDiEnG0jC1uAwSYaG3vdcs4XNQmEVg6WdKvPFECUFtLSKdRCq7weZz73pWCcVLa2MhrgXKIYZb+MYxDx8C7i5Py71weTFYZ+6F6umxokeW0LwcaZ+sqe5sARHEEDa0809pOp89pFjIxbjrnTRzv8026SUUNWn3lccXIH0Ru9n7Ovu3mmSmaQR8ncr+UoPpKi8XzXWWQCK+Ov9Yf2zXrPbA6rjtkiv2Mdz8KNbPNC+x3f2Fjka0TJlWoMZoRZh+VD+5mjl5PTPguPwJ1fKKuVnODoZ4K8WHX51+mJAX71TN5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(41300700001)(122000001)(64756008)(8676002)(38100700002)(71200400001)(558084003)(110136005)(8936002)(66946007)(66556008)(2616005)(66476007)(91956017)(82960400001)(26005)(4270600006)(186003)(31696002)(5660300002)(6506007)(6512007)(478600001)(6486002)(316002)(38070700005)(86362001)(66446008)(36756003)(19618925003)(31686004)(76116006)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0tMaHJLbGdOcWJwY1cxa2JCRjcyTHZySEF0dFVFZFFZWjRoMThOUlFSYzg0?=
 =?utf-8?B?aW9lR0ZSeUhmc0FkYVNXYmFBK0lpVXdJSXBvZHpsSkN6QnRLNU0xaVFUWXEv?=
 =?utf-8?B?Rjg4bEkyZnU1eHVkYzFFcFZDM01zb2lIaGNlU2hvZDBUT0x6b2s3cG0zQlk0?=
 =?utf-8?B?QnU0a21WR0FmeXlocDlkT29RUTBEci9KUUg4aldaWnVJOVN3aEJzQytPZy9H?=
 =?utf-8?B?ODdRcFVQYmcvSnptdERSb2FHeDFCbnhoSFhabXlXb0tLdFpWZ2NabUtCSFdD?=
 =?utf-8?B?SUpjRnVsTzBTK1ZPMmFKUjBXckdCd1ZBZ0p3NFVjTW9uQmdlN1UyWU5NZHVV?=
 =?utf-8?B?SEhRa28wU3ltWXFOcjljcWd1NGN2RG80eHNycDFoeVVTZkpTdGozeU9zVkUx?=
 =?utf-8?B?clZRZ2xQSmx2WVl1RHRKcHlrMTVTSUlqaDJVNTFyMmJRQy9mYW42UU43eGJE?=
 =?utf-8?B?N2dWa2p1bk82TE1MSWZiWmtYNmhEelJhZkFlYkNjZWRpTEMzdnY4UTRnVkov?=
 =?utf-8?B?TEFDSkNIcVNBV091Z2RqMUFCKzR6Y05ld3dBUlo5KzgybHJHYUNXVmljeXhD?=
 =?utf-8?B?emlPRlpLMkNWTWxIUlVxUDI4RU5uMm5FSTFmZDQ1aGs4dWNQWDZRTlA4c3Ja?=
 =?utf-8?B?UEJLU1dkK3U0bThoQmUrekE4VVdmRWJ0dm1KR0lzS2x3QXRRd2lQWXVMWkNn?=
 =?utf-8?B?eWduaU8vdHZDTkpiM3ZzMWdhSUtmbitXMTlJVlBiSXFUZzMrS05VV3B1RGhz?=
 =?utf-8?B?cGppMWc3ekROVmU0dXJqYkJmWTJ3Qkw4aGFuSzgybFdOV2JuNHkrNTNUMHRL?=
 =?utf-8?B?dStTODVKb21UVUZreGtMTzU0OWNFYlViQnNJWVhpMFMvR25IRHNET21STG9o?=
 =?utf-8?B?YW9XTDdBaytzWUNNZFNwdE53cEtod2VrM2Q2T2FUZXl6d1ZpMEtsK2RZaUxB?=
 =?utf-8?B?elNmRDFsUFZjWXhhT1RqdnZjMitQeGpPaWVKN0tKSGh3NzRoWUdtNUh2bEhx?=
 =?utf-8?B?NFlWaWh0b3RnZ3M5dGZJL3N0RGpxdXVwQmFKVFlJUWVOTDNJbWIyOHp2YzBF?=
 =?utf-8?B?aU1OYThBUkxaMFdXdVNwOXNMeGl3YnNXL05vZ0RhendUSzVqMDIwMkp5ejZL?=
 =?utf-8?B?NG5BUW1KeGFpditYWWNqSlRRZHlpbjc2VFgwd2s3aHpvNmRTcDhrOG14V2hn?=
 =?utf-8?B?blN0ekpwVmF1eUt1R1BGZ2pycnl2RXlxeGM5OTFEL09IMDREOTRGazNnOGY2?=
 =?utf-8?B?Zy8yMDNGUldrRFcvalJrdHJTMnBwR29WZEJWUGR0U3RZc3hYSUNYV01QS2NQ?=
 =?utf-8?B?YlMvWDNMd0s1dDcrQTVGblJ1WS8rWWxhNTlzbVZWTzZyK1pUTDlMNnllSVUr?=
 =?utf-8?B?V2hSdkhVTnRUM3NYTlBFRTYwVEswWm4zSGcxckNubmlzMmJ5UkRtWkhXakt1?=
 =?utf-8?B?YXhwU2xra2dZb3B0QUlCNUZUcHAydXhIUEwyVVlLQ0hyVkdBUzAwR3N1VGNQ?=
 =?utf-8?B?bVpRMzAzTkhab2V5RjRhR3dVcE1vT0E3MWRVTFFLOEM0cTY5NmsvOWxrdVpG?=
 =?utf-8?B?RFc2N25IemdzQjAxbWQrdy8wOXNBOTdYamNTdzVGUEhPc2VJTmVoeVRiZXZM?=
 =?utf-8?B?dFd2aG5jQkNCL1BCbklyVVJyTjgxUktCR1QrSHpYZ0dPMXdzY3kxcVNkYWRJ?=
 =?utf-8?B?dFZjS0R5MmtMKzlJazk3Vy8vTTlYSWNmZ04zbmRvdFFKbmtsOGxNWU9FZUNl?=
 =?utf-8?B?UVoyeEJTby85aGE5Q2kvYk9ON29oQ29oeno4eWZjSWVraDBrb3ZneS9kKzJr?=
 =?utf-8?B?NkVYcWdxQzJua1RyT2NWN3hOZVFyU1RTdmZCU25MUVpQMCtjcHcwVmgvNWl3?=
 =?utf-8?B?ZzIyQXViRjlCL2Z2akVJeVZRMC9uaU50MS9hZ2ZxRnVJUTZ5WUNqT0Z1dzlk?=
 =?utf-8?B?d0JKMU1jYmlDbHNaR1hBSDRqUHFic2MycUFYdFY3UGdCTXpyNUVCNWZnSXhM?=
 =?utf-8?B?NldTMUsxU2tzL3R3M2JYZjJHZ2k4VTB2eFlnS3F3ampjZzZQWnlkYUlnYWlm?=
 =?utf-8?B?dHNIZUkxTnJicHhqVGVGd2hBM0FaY3ArZzF0dXJIcHRyTTExWS9CaDBXWEV6?=
 =?utf-8?B?dUV2bDIxYXY0T2ovR3pONk9vc09MRUR6REJWWHRVU0xObmszY1NjQktPaml0?=
 =?utf-8?Q?yeYWbDRL26TxkrE3LdCyuxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <078D5186A2B93B459377BAE3675F06D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6510bd49-d8b1-460d-36f3-08dab8036fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:10:12.4659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcn4+ZY6X/wQLIDTotJJ0Pvb88+lxitv2KK/RJ5m4Ys1UBi2eASB3tMIT8EVJosaek8/exGGzjKdQa7EHgWQv9CDJY81iu2+fe776QjWGsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5758
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
