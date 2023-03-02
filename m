Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDE6A7F8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 11:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCBKFi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 05:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCBKFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 05:05:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB21723
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 02:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677751493; x=1709287493;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=UYpdZAqV1a4GXFq+jJbtXYiznv/lYGzjZLlw7a2gPnMNQav5xKD1xMWX
   X0+m9WPlXsQJautT2r0A0itiaGl6PseaiBKAOfqJcCbwutyyrbl36nvez
   EtoLMi16K0BHjRe2BrUsu6UIncM8fxKq6wkSjtrLupuxZ5rgJFZC6sA6o
   7LunugxqHQ5xINcA9MF/nsjWsITBN9wNDodXsC8lnMlhMLm1ZYNaBQ1wZ
   jrvsmmKcTGC8PtG+1l4T8MJqYuK4H8o/CHbvtMwE0rIDJZjFriYOzkh39
   VCgDxABZWI2+pgKgujSTqQfqVaDuhINVpsALE771Q4ilIeOjkkLoUX1ai
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224617195"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 18:04:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocvi0AsNpJ585NTBpsX5R1JSiPKcwaveV08ZUHulswElRmv/sbPiTLKruLjq1VlWOdLSUvBw+6DIfDlMOJe0hMY05U6//VMK9ZDjUtyvG0AtRyQiO/5Wp4IgEtG1TXWHn5fnzvLEmKEPDzmM5+OtY5CJJOibBvkFzikPccYPZqc8H6gKKqLyCsnPlw3b9bCeGY4VaY92Q/4rZTbwxE6n7lcj9kNBbILK7cbRPrgznSV6K2zBeZGBakiOc0+gs0QECuE0BBsDpy9Mo1J7RHg9PVABKW4eWcKQkeVWCk45wb7y8h3BrKNA+xucl58mg1L0NSuhDQzD+aGvxXyM3DDeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=M3IU80w/apQYu9l7KPyymwESwEkM4JeFbb3Mbr5pMwWDhCybGoeTFnfTuHjKeeestarNX0quK3D+LGDtxgVVDvQVThRD+jknKEXqUxN7dTvaKnvg0lcH2OAtdNdq8ZOLoIjiJu9+KfcU5W15GPR5xbnLqLFtrwwZfEAR9R0GQUapcuJm8deTenIxrdoNJW5zFxp/tCnFlq4vNkE+hy5ktt2ptm/oO2Y5VJsgU/FWddMGyj+Ov02Any5zKvHtjb1ntNmeqeg26NuUMLU1IubfijRSc5S1CrUVnz+Vq+VModLpYCYy0IdoPJEMr1tJv5/a0jJmmVS8KVG0jPKvHChfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BWpzPqkboELzChkLYa4FFb+aJ+ed6YEbZcPF9yvNpf1PDX012gzNFI+4IcQjjHLtcww5yJdBN7ykuReNAMiMtSg3vf/kHdq+JWOOTHM2MFQhK/VtZoU6yNIhrbNcdnFuMJQmOV8SIQEtyJF69yGUiMD/bZ7NXqEdSoAd9FmD61Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7093.namprd04.prod.outlook.com (2603:10b6:610:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 10:04:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 10:04:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] btrfs: clean up space_info usage in
 btrfs_update_block_group
Thread-Topic: [PATCH 2/3] btrfs: clean up space_info usage in
 btrfs_update_block_group
Thread-Index: AQHZTO5aqIKlIK2kmkipEGhrATqaPA==
Date:   Thu, 2 Mar 2023 10:04:18 +0000
Message-ID: <021df8f3-fe6b-4e99-e18f-873d08779f97@wdc.com>
References: <cover.1677705092.git.josef@toxicpanda.com>
 <f7a7a4beb5d9f249204fbca72a04b4cd78274c18.1677705092.git.josef@toxicpanda.com>
In-Reply-To: <f7a7a4beb5d9f249204fbca72a04b4cd78274c18.1677705092.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB7093:EE_
x-ms-office365-filtering-correlation-id: 5772cede-cfaf-4213-b653-08db1b057d09
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8SISZsYZw8dFLEE5gwaom3mgplSEB+sSvQvfkyjiHdsUEPqUiTjVx35kj0s2P8ofJBErsvtgZtvljvNnp8Okah7jB7UzuldfLIirgsk3ZWyJywtc1ikwfbllu6mH8G7uIgpE/I2f7597HdMkXTQphbVxMivo088IfaAH9XDi7a9dO9bZJwOnPsfQVCQmDE/oYUUuaA4KDRzdzMLL1UYXTRRVNjtvbnwqnakkNpCtFlFAN8JXi5VIU5dk7coxs8SinfKGemzBc0a8zwXT3ASVgK6Q1CDbmxVOccvSZbmMBBoTGpBdg7xdqoUSKCuPmJSKIFKBSBvdzUf5hNZyuZR530SwFvf0BE44Ha8USTeEWJ1kQ1U+JhBmxVQ/RQqv1ng/SVsMU4XmDReFJ07ya6y5WAY5pkPV1mHn2hf2uDz/zbAG8FFwZ0b21osalet1INTY+Nygs8/LIUncYYo6DFu4hvx5viKIIfry6m/XuMitDFTqEhZM9w6VIPfkjjTBcEWMVLARGwQPM6AZd+zfPLWSGXpLWNDsYQZciiaQ0y3CNQJsUtg6j/N2oAHpZX7Vau0TSpqU1pD0PcXvXbTJlI+bx0QiafdSN1WWFsacHzoeXNHavWv887q9tPL9yK0oT/cwjxKaErzWlg7vhZg3hTMgMBfyo6Co7VJovWmQnYbyVpnzLtZpI8nSZFmwEN9y2/4FZTkA45u2e01mOAk8Xa4kmEqZJqNKDyKBvkW6nCJINj+n8Cf+5HTgcX61OV2gGsHPS8O654MzPAXlIA1FmDF0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(31686004)(36756003)(38100700002)(122000001)(5660300002)(8936002)(71200400001)(82960400001)(478600001)(31696002)(558084003)(86362001)(38070700005)(2616005)(186003)(6486002)(19618925003)(6512007)(6506007)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(76116006)(8676002)(316002)(4270600006)(41300700001)(91956017)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3IvR3lHWWEraDQ3d3dHVXVEc3JZOUllRWdHUVRQUC91Z0lFTVZ5czJuaWtz?=
 =?utf-8?B?b3ZoL2hmNERIbjlQK0JVU3Z3dzhUTk0zbGRwTUVPeFg0ejFGM1lQd1NwUEFr?=
 =?utf-8?B?aHV4QUZIN05reG1YWnc0MFZnWlBEZXVIdFFSNjZoN3JzZ0wzTERVS1hpZWJ5?=
 =?utf-8?B?VVh1RTNnUXFIRHV3Y1BTT09ISXNMUXQ1UGhwWXpTS0pmVEVibzJwd3ZWbUpJ?=
 =?utf-8?B?UWJyYjJQT0xLUDlnMnBQMExvT21KUnlTZXRBRUhlLy8wU0xBYWp3WmJLeGpO?=
 =?utf-8?B?VVY4YlR4NXRPRWtNc0VFYUc3MkRiQTBtTFk5T2RHTDNYUVUxRnhLL1BQVHJ1?=
 =?utf-8?B?Mm8zVnBOYW1SMm5oOHIrVzBodlh1b2YwbmVjTFBTczdvOXZKRG1UWURObWxz?=
 =?utf-8?B?dmxhb2R6VjV2RGFWS1FsZ3d3b1pPamtNcUJWTVNVT2E4dDdsNkxaeE9yOGJy?=
 =?utf-8?B?czdvTjFpaEd0L1drNjdPdkNneTdwTFh2blJqS2IzMWlEVTNOSXBZbVJmNVNI?=
 =?utf-8?B?cFMvNXFnR0FaQjdjUit4SXBtYWtjNlp1NERYUmcxbFBrbkREYmJ5T05aSjBw?=
 =?utf-8?B?ODQ0UDRXL0VqNnRpK2tEcTVBYjJ0NjlHWU41T2thQXVMa3k2ZFkrWXR5YkQz?=
 =?utf-8?B?c1MxcWwvbFdEVWNyaVp0MkMrcTJSYTJOVVptTTludjZPbktBOStXUE1NRTN0?=
 =?utf-8?B?eVRVVE9scnVvQXZZdk53OWxySnJ4cERNeHdNMnJYQ2RwcTZRTHpvRnhsNldv?=
 =?utf-8?B?UGVlNkZxT2xCbUpXaXBNMmI2cHlDSEI1UlIwTjNmREhFNlJmNWJHWm02RVdR?=
 =?utf-8?B?ZDFrZDRaTDdFYkRNRWg5dzZoMEJ4bXV3SCt2NGZqaE9xamxjMmg0OUxjNWsy?=
 =?utf-8?B?NVc1S0YwOFRXMmJhU2NwNVkxL3pIQklZSEpSUGdjcHRGRmdtalNsa2N0SzlT?=
 =?utf-8?B?V0ZFdVJhaW1YR2d3eHpVTkFFNTRwTHIwcXFSYXBlYnBEZzNkK2lpSnNETjhI?=
 =?utf-8?B?eWljdFpLK3VlWjE5T0ZONVZyQ2NIc012U1Bnb1lzUkx3VkxQeUQ2UXpJK25l?=
 =?utf-8?B?M2NKRk12elNqRjRCSVpWNlNXamUweGpSNFRNYXNjd0hVWTRDbGVYTmsvSitx?=
 =?utf-8?B?SlBMZmdsTG0zU3dEZG0xQUNJM3YwejIrWEg1aXAzREl6ZkJNMXFRcTZRVW1X?=
 =?utf-8?B?VWd6b2Z4VnExNWRuTkkvWWw4YjFzZnJDUVRkUlA3VGJUNFNvOUR1RFdwUk81?=
 =?utf-8?B?TDZXcjl4bDV3K21raUNmeWhCQ2s2YlBTbkl4ZFlaNno4OHRXUGFBbEVadWk5?=
 =?utf-8?B?SXZ2cnd0NlhKaTQrZitQaGZocVVNWjVBY0g4aDg3dEFjaDl1SXQwaTRxM0N2?=
 =?utf-8?B?TjJ5TUdHYWlxRWF1WEJ4d2NJenVuS2JkOGtnVXFTN29MeUt1OHlCQk1GZTRN?=
 =?utf-8?B?WHVKUXVSampRVnJ0RWtSUTNIRUU3UkZ4bVdlWmF1LzhFSko2WE1RRC9QMFFw?=
 =?utf-8?B?emZmQmNDSDBSVHpKZXphdjFQSUlqNkJXbmlWNVZmS1h0OGV4eXRWUFFwRU9R?=
 =?utf-8?B?a2swYmtZa2IxOVMvUHNIVlNPTnF3R25iUld2ZE9wVWhCaVY2L3R0SzBTWkt4?=
 =?utf-8?B?bXJFSG1JeXpETzdlRUdDN2NrZUU5UGtqMHY4ZEJ0Y0lqZkpCY3BmaTBCODFm?=
 =?utf-8?B?VngvZVNlL3lzaXFDKzZzaUpYUlBCT3V0dEhyNDlTOWZpL0dFWU1nL3kySUt1?=
 =?utf-8?B?OXNiVEFEWjRzeTNYK2JkOWdPbTlRMVY5YUpDYWJxM2h0OW1tYWxKRXZCcUQ0?=
 =?utf-8?B?MEtUOGZYVFEwV1hhUkEyMXRPN2syOFhQTjdFaWJlZDdteFBoZ0N2bzQyWVBF?=
 =?utf-8?B?ZzdMdDFmOGtaU0JDTkJrTFFncTN2MmIwWG94K1IyR214THAvVHNmQlRxbHRS?=
 =?utf-8?B?aWxOa2N3VXhUOGNPRitHenBIaWwwT05UTU1GSHd5WUVpMTIwQWFoWWQ4Vk5B?=
 =?utf-8?B?RGlRNmRsOGo4MTlxUGxPdjR5NVZrS2NKR0NNM3o2SDhqcmg3d2cvdmlobGlQ?=
 =?utf-8?B?SjJyenZWN0FQamtnODdRbml5REVHZTZhVGIxeityejVTbzhMa055SUx4ZTBH?=
 =?utf-8?B?Ni9nM3ZDNU9vZHhYOHVMcVFlNU1uTzN2SC93b08zQ0hndFZmclRsZ3pONU1s?=
 =?utf-8?B?M1Z2aVpieEpaMnJnY2NObGdQaTdUaXdFdnpTbjVZVFJucmdTeGlOOVMvRzNq?=
 =?utf-8?B?OVhmYmc3OVdtYlNkbjV0MEhWb2p3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45530F77FA65D54EB08DDD333ACF8B5A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7mveJdu4oWuZBTlEnwAm5x2vdns+ZUtcwMNEfO118rwoY+d+PSb6f3XC6w5wO7crsGg8JIOuzNGCh03qU7rYvNDk5duTG1Th/php+wY8W3VQYv1NFrrFuDFng5CXqFCP+ibJArqI8K6mRSk4rMZHFgR6/18z7atS6kWKvQf9ap31HWBjTx2XrGIPZfzs6XbyZcZTJlRI/26B5l9wma01k1AlXD1U6Efym9iGXVBXiiK+2Lm62w/qSnUgGVHCRd3EZeYc+GWpbjfS/LnmE+RZrhHMOWwpdMmpAIqrLOrd+CUUCZHmURseK5q7OyYuV8D2WtM7cLdXYzeaDxvptJsx1A+XDMtlCkzy0xu5U6S9iiubYsdqgV4sF8QUGwpQkbp1lfb3g4/MsWnz+AtzfuDeJjJJpZxSLCVnPnP9UCVrJ9FxuEOeVI9ddOTkF8/82ruGxwlpmWmkvRB0TW3d1Xv7BoAGt7RUOkMgeYu6AEsdq1NjGhohA4NyG4tzD4YcaK/m4R8VAjNlUzMd2tvvA7/Mk5eiixZ6ojsW6GS32sBiXyho0+Ri2+mdxmM+ysUmuYtLa+OC4aVm0c1Rs+INX3+khEt4vZdv33MFDXB3rr8L7KvRxwOOgL0fDwmXyQtHH3+wZ1KB1M6kGNPYJJ20xKH64h8hdtQXcoyIlebvl1N/94BAxUgQ9lUyiDcnEonsp60Q8No9CFZvcwK84RX9IucMQ16sehGPh7rLILzGb75UJVNie4BoBI/oaGIqMWhOCiq2nwMkvk8VqY3Ax0wOxNCSOushV/DJhNvoaXnI2NkpdQ3B9s61xDXTFupZWU6Sa4aprvOIcn/7U0eCTwT6jbHgNw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5772cede-cfaf-4213-b653-08db1b057d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 10:04:18.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trfJFRAcW60hkcgw+TvWfDQ1LM+X5yTJSTbU6SsIA54xCzBNi+wxj88PhoNaE7CjIe7ZBnxbHFxd1lj72sSARUJgXfFLf6ftkzIbXQ4gtKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7093
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
