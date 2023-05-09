Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F36FBBE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjEIAOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIAOu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:14:50 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4FE1BC5
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683591290; x=1715127290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=bXBKAqwdzkB9mRcRy14JPi3G3KgjgFWG8tBCo7no4sCmxzYQvYU7NnaN
   bZattIfCsbbr0sWSuVYLHqrE1T22R83UDIcZ+A7o6YtrB+u7mhRygQKCw
   yvXiUyPAEKn+pnZ+Z8LlJK+U2L0GlxR9/NmGKMdRiD4C6AEn86umlEEh0
   gMrFu5QPhSc8i6s6l0wfEQ1SISSDrYvkFjGDu4z0FzXaP4xHjzp4QErnf
   25EstVorExjQRs2TFozfgmhMfg16I2rpgTeXLh3fSFqZp4O22JpXDO11i
   7ihVM4RqEh1WRv1JSgmD6g41xs7pAasLuEOFCggwrR+tE9IJSKkWVLJMH
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="235158943"
Received: from mail-mw2nam04lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:14:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlZOCFm2i8OoGKVxqeVwJUMQPaiY5eFjtabj1nI6LqZwOO62MmGk/7f2NIros1BBnV8txy8rKoi41psSuonJ1tpeoBL5gZpDvzXoam+P5pcW5zLWPe/FnKwT4PenV/XBT+T+ANc9LzrPtrpjH/XjHcWR8rt4gkiHASMkkjzPvMol8nu2nBQBIdi6MOhM0Z9mUQf+6Tyt9uh5mq1Udj8ViCCA5BF2xmv/jSgtazT3cOAlAmG5TQCf/PHBL5mIXfbZRB+kWAz416gA8BXIXyKPIxxQMbo2Pqe+tKgEnPTzFfCtYPEYjBz7iqAKW4h2C9aYFJelkc4Kpg95UjUcPe3G5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Z2GHwKdGOny4VvAjK4fmDXtrWBYIPXJupEaf9PzhW8NNazFhOZFpRcEWx0FnsCf05LZdDHQ6ADuNETqw0MuSa1FA41proMLVtnISSGR7Gn7slEkOwQ3rWQypE5svNglgcBzIQyWAXWEiVEVJxiba6XHG3SHn4uuuWwmPy/SZ6mhsVr5IRXGwU+wFhFoAQO+JOnqCIzE9xPB//8/HfjtWHhbr9QTKHwQLcW//rwdxbw0HgQ/7AbZaOeGkGqUk7oNV05mkmXnF2HEeTsL6J7VKNJhkgsok82l5l0GZMCS74FqfitjsSBGteQYGiZRZ7UUYAbTC3tHlpf5X8/bsaJ4BNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nufP/5Ez6x3sCooM1+kq6DnWTYUd2XAz28Sdk8qf+6LOlYYAESpcPi2sxrzREVQZ3nhftK5XbNHGVMCkel7XEhAQsnt/khH5HGSeK7TWV727W6OAn6Iv/0LXKJM+jDuJhE4o6y2Oysh4rVu/wOOdoty6P/8tmBmGCEtgj6h93Ak=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8093.namprd04.prod.outlook.com (2603:10b6:408:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:14:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:14:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 13/21] btrfs: use bbio->ordered in btrfs_csum_one_bio
Thread-Topic: [PATCH 13/21] btrfs: use bbio->ordered in btrfs_csum_one_bio
Thread-Index: AQHZgcdy4MvwVNEHM0eL4ZFpDgXBoq9REvYA
Date:   Tue, 9 May 2023 00:14:46 +0000
Message-ID: <2d6503f0-88e1-ce7a-ca88-78d8c0643f78@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-14-hch@lst.de>
In-Reply-To: <20230508160843.133013-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8093:EE_
x-ms-office365-filtering-correlation-id: 957324e8-d6db-415a-ef56-08db502265c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CymJcLsxyvQSZo8Nvruy4Eb2eYIlNPOSYQl6Xik/hqTfXoBIPIzhzyPmogIsr8pRizh8Xy3ypwwJjksWyMNJkbWXdvh5FmR+mb1E7IyVugxPALiW7vJ0QrT02t4Uwvwr41tmdS3VZeAea2i0XnKcg1oEet1jIgIuAL8N1ZjC/HnyZvQ/lvYhuDc6s9aR9Nl5WL+IL1S4cJrDF/yUIVEVw9Z4rAueIYnMEKq2JT4M7j7OzBrm+xuyDvGK7eBdCo+EqaPtidkM4IhHdl/CX8JyC+Pte7NXnYkjWi7grOQoVJq6NTfzW29uvH5IwBSJz3U0y1RG/3BBjtG+J3OnrMlhwLlWBkrOlV8zueq5wsyy6EMrkeh3Wp0pzBdwpfAyP/+YYJGdGr4czu9mrhEdUJUMHDlYLXLPpHJY/xQ0U1fWOMsNkEAVkqKtX0aeZncM3YRGViD2jX2c/CPg0t+ukp50df2Ba8keVBkLC2WLjmWMG+UWtqZmxwInI7axjAIIejV8SfE7VW+fQUL4Wdxj2qevBQvPYmlb/IPCwxn4iIlhRg8WldPVNgsc3/PMV62/8Jpo01c/5SFcy4neelpnGDsuI9AT/lli6qJhc6fxuDtB55iFNoc0XEGzDIk7mJu1gCiyrCmPJm4yl4HFC73bHmOS97vsLFWcyBGygKt+YICf+1JCSa46/ZclBk0zbWGPqmvx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(66556008)(66476007)(64756008)(478600001)(76116006)(4326008)(110136005)(6486002)(66946007)(316002)(66446008)(86362001)(558084003)(36756003)(31696002)(26005)(6512007)(6506007)(2616005)(8936002)(41300700001)(2906002)(5660300002)(8676002)(19618925003)(82960400001)(38070700005)(186003)(4270600006)(38100700002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFpYTFFweGFPUTlXU2VIT0VLRzF1MU01T3NzTTlxMXRXcE1FQVRuQ1pFT0lE?=
 =?utf-8?B?QlhGYkJVR2kwaFBrS0ZyR1VlYmdqOVE1eEpYTEtVYjZuS1ZCWmNBNjZQcVRK?=
 =?utf-8?B?aWxiWkNTVWtuM3Fnc0NiQ1p3THpQbTM0K2JzMUNDdXUrYTV6U1pzN0VVNlVx?=
 =?utf-8?B?bmJpM2lwSmg2OWtKZjVKQytQV0JjY2J4WXpEN3N3dGxNOW9vRnJJV2I5eFlW?=
 =?utf-8?B?RDF6QUVaUGh6NVZvaEp0R0lQWURGb1JLbG5BamVrSFNCWUVwYzYzVXlncXRH?=
 =?utf-8?B?QnNMTlJXdzVFV3FaVXo5aEYzTlRwZnFOSEVwQkJDUkxwNGg2MlZFN2o0TDIv?=
 =?utf-8?B?Vkw1RjEyRnVtVGZPcTd5UWZnZ2QvZzZJSHlYR3FTazdXU1hWbGNxZnozemdF?=
 =?utf-8?B?c2NaVlkyRVZxTFpXL2RzdkJXa2NoUzMwTFRRV0E1Q3pJOGxEaFdPN0pPbW9i?=
 =?utf-8?B?OUlzOFpqbzYrVXVaeERxQ2w2M2NZR1V0bjdUZStJRG55bDZweXFucXk2MVlF?=
 =?utf-8?B?T0QzSFFTci9mTW1LTUlSQ3pSb2dVL3ZQcWlNS2oxUXdpUTV1dTkyNGo2NGZv?=
 =?utf-8?B?RExtd2RUZ2xpRmVodk1NcGlZdVZrcUo4b3dXU0t4Ym5TdXI1em15Zm44MW1U?=
 =?utf-8?B?aXQyYWdPSUVwcHFiUWRaWk94RDBTa1JlQnlldGZOay9OM3lQUjNUTVVBNDcr?=
 =?utf-8?B?SjI0YkFYYmIxNXdicE91UG93TDlNU0RselJTTy9vYTRGUU5XWGVNa1hCSVRx?=
 =?utf-8?B?elR6UkduQjJtdFZWYi95UGkxaDlRMmkzZDA5RHN0Nk5scXRwcS9vaUk3QTc4?=
 =?utf-8?B?NHhBZGhmQk1IdG9vbzE3ajZTY3hmcFFERnFVSXFRenUwRXd1dmJpVVB3cVVk?=
 =?utf-8?B?YXc2WVpSWVdjVVQrZ3h5T3UwNWthc09uVGlOTDA4V1ZQaHpFNUpaSjJKMEln?=
 =?utf-8?B?WTh2YjFJMVdma2M5dXM3WFBzTzY4VnpHWG1aZ0IrNmwzdXBhN3ZjTlZRckRh?=
 =?utf-8?B?NURQMzA4dWtmQnVORkNsVW1NdU80eUpFdEtIMUxGM1RteUR6a25lR1B6cFZu?=
 =?utf-8?B?Q1A4UmZrQ1VxRUtDV2w3NjVpZGtteFZrZlphZHpUbWNtSTJxU1hKdlBKa2FU?=
 =?utf-8?B?d2k3R2tRdWRNcCsxWWlqSlQ2a0ZMMGwvbmt5cE9hUysyTlE5Z0Y0SitiZzI2?=
 =?utf-8?B?Vk13WVBxbVo2NEc2RTk3VGIxQ0Y4cGROZTV3OWkvVG04TERoNGZnbTdhTldO?=
 =?utf-8?B?cXRGV0dTaWNmTkNiQko1bTdQVitmS3BtbHhWc21RL2xSeWNLL3RyZ0crMEdi?=
 =?utf-8?B?OGtyb21aeGttdUw5UktCZzZhcGFkQW1QR2FVYSt0clJhSXpwNXg3ZGphaVlU?=
 =?utf-8?B?cDhLSnByeldnS0loN3VMUjBZRkJFVlhHZHlVTjVicEh1VHVQa1g4Q1gxcWlN?=
 =?utf-8?B?Q1Y0aTEwWTlNdUhQenFaSWpES1ZQclQwMGlsVHo0RER4SklSNnVaeHNXUzdE?=
 =?utf-8?B?YVZXWnpQaVM3NE5Md3pUaVhtWlAwNkNxb3NNRmppaXl0TnFXYUhQZFB5eFpI?=
 =?utf-8?B?ZGtvb0E3RzNqWWtuWk5GOW5ySUpYMEZoQzVrd005dkNDajI1NkxUUDh5SDZM?=
 =?utf-8?B?TkthUWlkOStpcHBLd1BHQjVPSjc0WjhidFluU0dTckluSHJUd1hlcjFhVWZK?=
 =?utf-8?B?eUZoMmpLOWR5Vlo0WmJFNDUvWS9QV0IxMXJtZUFhSmFDNXgwSXZmYm1xTXZ4?=
 =?utf-8?B?VEwzc0xoQzdzcENzQnRsc1ZRRGNHWFlDOS9icFNCL0VYcXhxbllpM1U0dUZY?=
 =?utf-8?B?UWFjUVdhaWp0OERtZm1EUXZsQWFQRjk0TXVnUmRsZlRUbWpFZEFIMjlGZWpr?=
 =?utf-8?B?UEJsaDFtcFg1R1k0bkNFRDJlZTJpU2wxVk91TERWMVFNNFI0UmptN1BsWGFF?=
 =?utf-8?B?cUo4M2dzYVp0bUYvNXNYaEowTFlxaHB2amttVEJRNG1lcnhXQjVVdjMxTjN6?=
 =?utf-8?B?eVkvNUVMWWxZVkxtQ1A4ajdxQmIvQ1A0TG9HVmtBaWI1T3ptOHEzNGZRWW9D?=
 =?utf-8?B?QjQzVWlaS3hnVVQzUWszSE1tZWZ1OEZ0eE5JQlNUMTM5cWhSZDFtbDlISmU4?=
 =?utf-8?B?STBYVllLaU5TU0RJbjZHaHh4TnlxOVBEWU9zM2xXZFB3bWprY0ZkSEhlZys2?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97FB09E196FD8E4EA330EB5B8A1B605B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CkLWNpPxEMqYFnicyY5xyN5rf6VF5NiNY8+yLHiPKeKoHvf89BmrGdD5iJ1LxO8knV+mKqT5ZXhbqUqfKRSLdvLtzsHy1fvKkukWZSpAww6MglDfoQAH03sk4G7VkzGnHme/MRQOePpmAFTz7hiLw81IRW5sMlvcPm2kuxds3KN4CQr8y//R2zPrvPVL2ouA0mqfAoWBO2NYpl4+aYh1TVAuKwX1BrLlmFZ1r9Zgz3woBcsm2B/ZSsPzT4bEpCbqrN+KbLw9Wj+3pLhtnhml1rFnJ+muAd7j1Ty76B4kiXbxHgQzkPWepuZL4yqj26nKimawJFKIhOJDPjA7dof40LNlH0jA5Onh1VYxhYFlGm9V11BCr8exVgPHOIZldn+2if18jOh6HeSw8L7E66RnHGCRwPifDBaa85F/4BNMXAO9pLPn+DpgDM5kq59AvHplZHSLSkI1MiO9LFlTHGywqG12kJcYcaUo8OB28/x6c+0G0I+o2kBstoSWqdSYoHCA7p9udaA+qBVFXognPrV6ysIM7O8eKLOe0JY8Eo1AkMXPrcjfcna0bHmODYdCqQY28Ajqmz70+ye/P164ddbCSKBb+nWsb7buM1o96GAQATJagaHoM1rsPQ3laIW3pj+Ewvqrs0UPRyfir8NTi6bTD89O1FYTsry5+X6MAZawjWXEsi5MLU5w/ibcvj234H3foaNfWr5NS+jfR00M+nXK+4OJaKXO16FoZFJfWvt56EWvalA2dB7bKOSXPHNkKmZOtahsPlgYM/auwnTuYg8ndjfHr3gXtKs85gRcuAWELEvd+/aYKat1hPKAggQHBbeML/c70gjvBQ4icCA/Ptu63s+wOUmnOv9aEEp3T6w38nsJkbxwU/a+7EnN3t/KiZ8j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957324e8-d6db-415a-ef56-08db502265c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:14:46.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/dWB6aUFS6hOEC7zj3yj/gRXLyV54sJf+gw/e3lkzPEfmIKk4IAK6eOdLW5voy8TBfRwNlT0a+0Zd+wBhgl43W8teqzQ9g85aqfXs33nrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8093
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
