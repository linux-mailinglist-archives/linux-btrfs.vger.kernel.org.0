Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59939648065
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 10:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLIJtG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 04:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLIJsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 04:48:14 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551286B9A3;
        Fri,  9 Dec 2022 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670579170; x=1702115170;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=pWH/3guYPiBXoUQPFiTnNQ79Y9OHjt6kRqWCjrzOjJwFSOVjbk8MGDZ5
   W3gtLKR3bqM6LYkHBge2DKwHca5VgvUlItf3KMiI9GSuohs646+r0bKwl
   KwYGy8/whg6AmGXOsiEHznVwEzCzrf5FbcWGNKXVam28wHMP6pzcnQlml
   zCcvmlOakfw4KW3jJw8Dz1FzJdZ8IWowUU9DH3qB/XJkQZ4Ls5onI7i+e
   OhwVSB6Pgn9BtmyH6t7dlv/80WPmJ2018XLqN9OsI+7ViNsLnLE4O7cv0
   6OjUzXuTg8XGatI1nJK59duWWYjYojXXDV+ztcZz4/gtIbssJ/PnODTkf
   g==;
X-IronPort-AV: E=Sophos;i="5.96,230,1665417600"; 
   d="scan'208";a="216479433"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 17:46:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da05FXupO/IDtlslcPmoT+7eTLQSIQN6iYxNzwxILJczpPQgmHzVkLHMOSv38qSb3LIhmsKXPx4qpgUYL6ItAjsLbiRH2j9XoLibok6Atn2+BfporWdJnGFWJz3DNux1Bx5zISVOiJaCM1wb65awnSJ8niexFAFxX2T9YM/L3V2uPtgLaswPa2ZBk6uOHvtCW7aZSkUifN4USXFjEmXhH9mFEImmaXjftR7dl3m3rk7LqXdqVmx+n37YbI70JzLC6HlkbGZgqbLh5gyiwbPYEEcLzXI9Xn48yT0bC5bPjhxIBzfy7H2D7GF8a+29FIO3Ki0Uhc+tHxjNVjDnFbHhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=THhj50lWFulPnxyHowoZZmk1rGYquT4moj4MyiJB2YtmoBcCrsiDFdsPvAbJzFNSlBzjpqNEMPpewIvFvfq9My9jRJCRmlgJGyE8QNXsPXmj6+5eOaFOoiWuD1Nz18z1DnZ+x9cdNmkWHD16gG5aJmN9dbgxK1SgkmYOL1osLxMxhOfOT9mIz1qilaxgFESptxcZyIVWAHIeGrl5gxFA0aaHw6ZQ4zTyejOrr1ImOOMeskazOaBO9j0y9LjN/A9SEr/Q2aFKlLmEyEQPTqG37bKhkF8Qtz31rL76llFDftTaEwklnLdPR90aOsJ4hsZSUvdG0PFPd+234IrwYwWdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=iOz+6Nn6N47xTlu67gz6tX8e5NQtVT2aCDcm1M0Y+IJtdUV/6N+UnCHAV414sks0ia3luj1r/XxO9L3LU4VJSUO77TQzsRHzecPu4zZF9Lm5H5U4LRc7BLLck4XNAAVB3EIad1R3M88si2y2hITJR410xF5Iij86wDWhbse3n7Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5642.namprd04.prod.outlook.com (2603:10b6:5:16e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 09:45:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 09:45:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: btrfs/219: remove it from auto group
Thread-Topic: [PATCH] fstests: btrfs/219: remove it from auto group
Thread-Index: AQHZC5AWt97Y2jxf3kerOGN6ih5VBK5lTvCA
Date:   Fri, 9 Dec 2022 09:45:56 +0000
Message-ID: <12985c69-b166-18d4-e4b8-5737b41a23d2@wdc.com>
References: <6c08b564ea499de6d34a1bd8bb0f435d73de2770.1670563995.git.wqu@suse.com>
In-Reply-To: <6c08b564ea499de6d34a1bd8bb0f435d73de2770.1670563995.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5642:EE_
x-ms-office365-filtering-correlation-id: bff16180-58fd-403d-a32a-08dad9ca2ba3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHAjwTWFwmXM5tKgR2sfchkeaP4BSFtpwDm73B8P/aONgLK6xxx4YXvJwtUpQTJ/dIC+dZX2YrgCi8QruPJqDVh6UmfMSRRHCjP7j723VVwgjWV4PArgoO42Bvf3VA4rT8BJwAa4ZX3UrCnAfxCjA5lJOFLVvMO7kaMcmX60Skm+YiXnnMwOm4Eq8bUFKhItnwDP+RyCRi4n1jmq8Tkevz2rcYyMAE2wmB9YfOOsOCNxpjzJ1Tbh1T/uR2JrzCBCKh+H/xv6Q0BJcELwfloh4UD9zDaxAIDc5/YnW1OkoYcbjEhZHd744sWXgRmhdgM65rNqifJbynlUYBxvmAVVyk05OJqQDdq0Zq6gFZwtt/DWfliNsQXmeUcfcYHbD0fW4CbafAToekSnKwnqLK6eoGcvRjGDY1Ht7t6YqxpNeRUy9X7gxBJ38VmEYGRrWuZevELHHm100r5OD8NSps5J4OX/zFIgJ0Y/VJklU+QeAt7YM5Iq9KE387KftHegx1G0Jnp88zsEd2jeBbw+s9BZH5WxUPGA6+uPPhFHc9isrH0/u/6kEtzyDTbfbrEq0nuzOdYa2jj8gL6xzTxAwuL/9XRdf0rkKrE9B9Sxzz1cK26WMy10xBVijude+OP+/Fnv3gEH4XHAIjznHPsdRnCDsbePpnfce/vtVXmcQ6mEOSwj+Rve3LhzBTk9ulJQAwFZp32QgbofiPa6HXnBlIRUhoFN+nKnai+Y6cnUCRe8q4Zfaj9F9/G49BQBBmPzndbx12BG86TqgjDU3j38lPE1GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(316002)(2906002)(41300700001)(19618925003)(478600001)(6486002)(31696002)(558084003)(91956017)(38070700005)(2616005)(82960400001)(66476007)(64756008)(8676002)(66946007)(66556008)(76116006)(66446008)(38100700002)(36756003)(6506007)(122000001)(71200400001)(86362001)(5660300002)(6512007)(186003)(26005)(110136005)(8936002)(31686004)(4270600006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVFqT3JMTDNrdklleEFnZnRmNXBlRHVVbG1DOXRnSmNELzVkOWJweTZLazZF?=
 =?utf-8?B?djMvTjdwYTVkV0NnNm4wREtJMit0NWpINFRLMDZ3WnBQVHJaSlp1SWNsSWFT?=
 =?utf-8?B?dzluRzdDUjcrS2RnVUdSWW85N2gvbWJFNzlQRUZVV09tOWE3UlVqa3l5dnBs?=
 =?utf-8?B?aGtKQWFSWVRTWXV6ZFozWFV2N09BTUFpeDFZdFZjYUw4Y0FxUERZenFvY05a?=
 =?utf-8?B?MGFzbEFHTzBmQ3F0ZHBUUmwycjNKUENGeGE0K0txd2dkN01MVHFlZmRSSitr?=
 =?utf-8?B?OWd0YUlaK0wzT0RrYWhGTnArOFE3dmlzWTRDSkQreGJaWGwreWNjV3NybWQz?=
 =?utf-8?B?THQvNmJtT2I4NUdmS0dmOSsvV21VWUpqUDI4dVYvVnJxKzJsKzFkandQTXRP?=
 =?utf-8?B?WTVBcVcvNk5zTXJLenNhcmVQYzVWMnJnS1dHZ3NCbHB3NFpXMnBibmpnZzNz?=
 =?utf-8?B?N0cvdEcrblFERkI0c05SWEtITWJaWGFGYi96LzZER2YyaXMxWllyeEo0NDdH?=
 =?utf-8?B?dnNYaXlIVGZrbW5EYXdHU3k4dFpkWkdZQUViODNYWmdPTktvUEtKaFhHSThZ?=
 =?utf-8?B?T0FKZXNHc3VMWWgvc1R3eXU5eG8vQXpzYWIra1MzcE5Lb01sQlNmdGxBWHVo?=
 =?utf-8?B?aWIwZTVnQ25udTZkZFRPWFcvVHhHRWwzVC9KUVpwU2tGUDZROEFBMmhsNEFo?=
 =?utf-8?B?LzZqZFhvS0hQaXdkNXJvRS91Q1EyeXdPQkFvVFU1b01uVi9hbE9UK2pFT2JS?=
 =?utf-8?B?RUxkZm1ldXRHSWVmVDRlcEZ2NmdwT2pyN2w1Y1QxWXk3Ym9kUzE2Q2NuV3Ey?=
 =?utf-8?B?cHozdit5ZnNJT1QzR3FZZEEwMUNsRkgrbjJwN0VDb2VkbzN6SWN2cTJINTFL?=
 =?utf-8?B?bXpoRGhJcEFpMFhzQjdNNGFQellWNG93VkY1ZlRkQmF6TUU3bDNEQW5IMlFI?=
 =?utf-8?B?aUFrNmRrL1hJUlFRelgyb3UvRUk4TCtCMGR5Z25SUHcrQXIzUWVoYmpzLzNl?=
 =?utf-8?B?WEkzWkhrNU1nZUFjL0NUNnVLUmYyeHZnRzNkUGlpaUZKRDZaVWZSbG5GRjBw?=
 =?utf-8?B?bGNhWmc3VlJnWWJkZEV3eTFBbk1ZWTZVQnh0KzJjKzFKb3luVUhNOThCVlMw?=
 =?utf-8?B?SGxhQVRIRms3R1VPUnNtUVdyTWNEYk51Q0N3S2tJK2MycTVETCsyOU80cjk5?=
 =?utf-8?B?ZVdMTzhFWndLTDdVZ0NRdFBqVzFWZVd6L0R5aFo1M3NHNFJwaVErU1lMMzhO?=
 =?utf-8?B?SjIzdmU2bUh0SWpQdlZ6NklFS3M0YkprODVnT0xsNFI4WnlIREl4KzdvL3Vq?=
 =?utf-8?B?OVhCR0lrNmtyanR4TEY4U1U3Q1ZnN1JoWEVkN0gvMEZIY0tmcUVDOGlmckZZ?=
 =?utf-8?B?ZlhTYTNJZllkTC9BSldUSVFsaDhaU1A0eTg1UFF6TXNyQk0xOEsyYnBoZFBa?=
 =?utf-8?B?UVdjSzY1aUJlSWVISUlZUm1UUTAzRjJpNTFKNUlpSklMeGJ6RDl2SGZhZTI3?=
 =?utf-8?B?V3pDQ3Z1UjAxbFY2UWNWTnMzRjhvRFpidXgzTVdNOUdFSjRxenh5Y1Nqci9a?=
 =?utf-8?B?YUxpSTBETW1FbGp6N3NNSUY1dHlGRHJHYW1XRldDdXJ3UCswcVkvUHZuM3kr?=
 =?utf-8?B?dEpoZ0FidU44YW9Jc1VxMGxzck5XYVdTT2RuV0NpRVJ1WTluNk9kRHd0V1N0?=
 =?utf-8?B?MC9UOFh2WnRtRFd4emhYcmFTZmlHbFVYTHUwVGRLQ0EyWGkrOEp2S0k1U2J1?=
 =?utf-8?B?WmJucXpMcm81dlVkcDlqQkpzYUFEMUt5aUtwV3ZPMy9vWXBEOHNrRDZVSGEx?=
 =?utf-8?B?aFh5QTJrU0ZHbGxZYVVseW1uc0Z4YTFUNkl6TnNzSm5zT1llSzRhbEszQVJu?=
 =?utf-8?B?QmhhQmdQd2JaTGhMcnR1cmNhRlRYTXVHZWwvR2R3SXluaFk1K1R2OStkU0w5?=
 =?utf-8?B?Y2k1SUdlYlpEem96cVlwUGt1eThXNFh5SG1NbHpkNDY1QytVSk81STc0Qndq?=
 =?utf-8?B?QU53SnNqRGJKdnk0LzFtMjUvVXBvSkhCeGFKbjZid05GZ0UxOFBQdi9QM3Br?=
 =?utf-8?B?N05Ud0xoOE9jVCt0dXZDNk5uZjVuNzAzWWxGK0hLOEZxN0NtQm5xUzV0RlZD?=
 =?utf-8?B?bEtzUzI5YjNnb3B4TzR1RVhEbjhXYjJkSlRJeXdWU0c4RzFrVmRXKzhqSUNK?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC377C15EC353B4180DBE1B1E57FDF5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff16180-58fd-403d-a32a-08dad9ca2ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 09:45:56.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NwRBKtv3G9SWFkSHWZijblA5abzgh/jU+Ur8og4QhfEiiITLZ01EBuCiIyN2T5d6QDvq0o8+hlR+5jc7s6k2gvWlzGnOU4Ikoy1YNFAe3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5642
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
