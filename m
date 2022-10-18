Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B3602C4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJRNCD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJRNCC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:02:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E4C4D8F
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098121; x=1697634121;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Egv6aBniDEns/5sWqUj6qBo6pijmi+mGPye/XyLGJszHNizJ3UEBHyDr
   SCyO2Iph+D6/OJUlOGdN0g2eC0yIf5vTINmnOyXORzVjsssz0hA76bQ9N
   JPq56uOcEwLhEg80vNARlsJyfoOeRgWkYptOq3EJbp386ATkBnEBe9iyT
   Qk1kzlA8M1p3CKdbU7bxI0m32AVcDGOmtksvrTN+sCnDAgfEwbTx9+A7R
   zl5EOJrkgocLMMzJkct1T6CRotLmIhnNwKQAuFr3SFFyemO8dQFdqM35f
   ayxqE5IJy7stfuun4q+Vv/Rtt3+UiA1/1u2JxZj7P+VzrdTdEoB82G05g
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="326227442"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:02:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWfcOBDhPAslTeLqv7KgY5KIDgL4Vwoie2XcS+2vOMgKyfsCopaP0TN9e4Pvk89CodCdEPMvoR1FvkZ6e6yOYs7sp1F/7fjkpAsoGzNGyxq2AbtA8EHZ7bkO2Bq7MKXJSkoMkLd13FpzoswuG/LS2+tZqcYvSYKFyCe5JxBk5KmyXQwOhoVswXqf7Zse3OL9EVcqJ5dNb3tkbn/EzOW8Sz6PO8Wbzlg1CK2CmaJkg3n7fKT86R33ry9Im3gwkODo+eTT066gdjz/zBfj5tQbNt5gWyrFNoZKa/G0B1s0FtccyS0x9k9rkRbp8LOjCbEHld8zf4FGPsqvctBRNNLdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=X0x4QDrTEO3lLnqrUkBlaQ2R3InRMNQ5FRY4KU+pG3kXxjsa1Ss2fyJt3H7l4sOx2PHbIQTxgHUS16JfybHRm1RavTT3HeLlXD2lkzBb1YtOPxDEoSA3fz8AA3QIVJ/inB4BYqtYYpdQ2L6QCaBZfKf0V0mif98q9oND9Lz4kkwKmfqd+0JjyhnFsVBJ7YU+pnfBXMTYmi2OCn3zhRqPOgU5oBiAmr6EtVnLo/8+I+G5tZtW6+3/B6iWz1FDFaIz6RcuixElcYA5FPgTibZK30iFAQHBlaZK+za/5KN9+XIXM0+pJZu5F71BwnV21RDyzQ4KDEnco0YnBP/nEMBX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wyPAid/KQwNB8txuvxBA9FsseEJdSJwsOATGPFXG888+NiqVpXbMB8R5q3jq2dvm1KWzcpGTzR4PLIDTbKAD8rJ4kw1fxlGTsLH9uC4g2OHQ325E93DwDhH7GrsZhAbmxfwcM4464FpaKRVth4HgVvbo2PQfedcXIrU0PmACpFA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3602.namprd04.prod.outlook.com (2603:10b6:910:91::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 13:01:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:01:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 08/16] btrfs: move mount option definitions to fs.h
Thread-Topic: [PATCH v2 08/16] btrfs: move mount option definitions to fs.h
Thread-Index: AQHY4lwK4lZHPvFShEy07F1P2gR+bK4UHuKA
Date:   Tue, 18 Oct 2022 13:01:58 +0000
Message-ID: <9c2e36a0-9106-bbfa-6dbe-b25c649451ff@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <b3b1cb4907069a20cd03044b108c106afb030918.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <b3b1cb4907069a20cd03044b108c106afb030918.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR0401MB3602:EE_
x-ms-office365-filtering-correlation-id: 3dd3a9cb-bf0e-4a44-4519-08dab108f0ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: czV4eTeKqZfJ/HT8QeX5lIgGWmyX3LIzfTC12f/tTO/iR4vabgoA5RwYYZl0n+9kC/3bV9Z+jFkOTCQIV3CcZUpBTKAURZhYu8oFVor2JFAcRZ7CtpbcRfnWrBx1L5bEybNwlGeYBtRugBFHssBQDck8JSn88vKxEfpUAQ5uRLRO2fMiiegxaqLHzC74MNwAtmGdMgI4lpfUYeruHBNV8KE4s1Qad6dr21nW/2+g1Y7/DZcOFcKS373zwfkKUaiS7/vXEjabbz/WH4S0ELNj8NkDuEHwbnPtMicBIqGEcNBKHHxTVwS3EruEKiE00TBlc5j4LrOLV/24GdCFiM/CGTnpR+GhyjFs9dltmd1/M6s79ZLmjw9gyLIhBBYCUQsAOMzj6D0f4nhhgGt/VKulJ1RYIpcuxnzG37epgayROu6QgC9CJm/85Je6/nKJa+2KnWmIa0kaZ6cNKrQND6bxqMDjFFFx/cu4sRbEWQ3AV3u/nLriZ6sTlKbSkcQp3M0CQsY4V0fTsRPjCWskj6YITO+g4zX2kMF70xhM2Vv6uGRms6sKKUipS9SJFNsHpl7XK3eAJSQNTBRSigqj6v7cvOKKBpY1U+bENpgLek16rvZ8DRsi4ywsjJ2pP/FHjhcyLz5kQQ5M9M8fdpu4CTg9qvXAKpRftdG8Led4pKX99+NN3mYVCtWKjcQpSsssxb9vqjUooPAZt9BwQR7a3jXGLk40spT40W/wpMFTNwgYADrGoNATsqD5r4kizuBC7/IXpkC1G/PBPAMH72UxHq49giV+Ak4m+nhvkQ2kqtkjeWVqjw7Y2+EIwo2Q5RLYqv3uDYkl1cXVyuFoUEqVAFal1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(31696002)(4270600006)(5660300002)(41300700001)(558084003)(2616005)(86362001)(8936002)(6506007)(82960400001)(26005)(38070700005)(6512007)(122000001)(38100700002)(19618925003)(36756003)(186003)(2906002)(110136005)(316002)(478600001)(31686004)(66476007)(66556008)(66446008)(6486002)(71200400001)(64756008)(76116006)(91956017)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEFRUG9KZjdJRnhrN1RDd0FNNG9xU1hJaXJUVDIvdkhEZHNXcndIZStvMjIy?=
 =?utf-8?B?blZ1QUhTTkxqRlV3SGVXZ3BVZXZ5eEhDbTByM21BaVlWT2Z3SEdRenlDc25q?=
 =?utf-8?B?SkVQb2VTSTZsSTZlTW9USVZpRWl0dCtvWHZ3QkxYL1NPK3FDM2xOVm93Z2NG?=
 =?utf-8?B?bzRibnkxeXFDS25uMVlHNVBhVmdIb1l5T0VXeTFYcW9MSloxTXpaay9OVU9R?=
 =?utf-8?B?OXMxY0N5VzF5b3N3M0hOVU5FSzlsalB2RzNod0R4M1gxSUI1emdZRklCR0Jk?=
 =?utf-8?B?cTZ3VW5laUE3b1ZDY2tMdkhiUW5Ddnh3dWJaMlZDTVcvWVlkTERnd3RxM2pF?=
 =?utf-8?B?bTk2cERhWm8yY0VYZjl1djRSejcxUUpsQ0NWYWVvbHRTR2pPaTNNZHhuc29X?=
 =?utf-8?B?RUh2QmdKeDdGQ0hMT3ZySE80MkJnWTIyaEJLc3RMcUNRdzZUZzlHWWl5MFh2?=
 =?utf-8?B?TnRIUU5PRnNoL1djTmViS1loVk1GNE5ZMEd2MkFZakRiQ1AyNVFDS1EyL0w4?=
 =?utf-8?B?WUE5Mm12TlY0VzlldVgrQ0E1MXRGQnY3bDNFOGg1TytheUJaaGZYd1RGb0NI?=
 =?utf-8?B?bjdFWEkvUHVaaEVNWWZjWWFSb201S0dwbWp5Z2ZJb1NucyswalAzdGJQT1Zu?=
 =?utf-8?B?dEtJMTdHNWNZU0w1K2ppTXZUTE9EOUlTNHdTc0I2bUdDV0JyV3NucXltd0Vy?=
 =?utf-8?B?SDNGYnZueWJweXExQ3k3alp3WGUwakN5cGtIODBzTkJha1pxb0lZaUtVeHAr?=
 =?utf-8?B?d09xRUQvQmhKZCtQdVovYStaOUdXd0k5NkJuS1ArRERJOTlQMG9jU2tIR0J4?=
 =?utf-8?B?aXBLYjYveG1QekIxNEo5cGZzVWU3dEJZRXBOR2hWY0NYR0F2UlZ5STR3cFZl?=
 =?utf-8?B?YWFyazdKVWw0dG1lMmhYckMyRzB0V0pxSStkNW5Wd0hzSU1qdzRFcjNGbVJE?=
 =?utf-8?B?TTkxSmlOb2ZSbzk1NDB6U3pDL0U1YzhHVkpiVnhTWm4wTE92VzA3TVFOTW5k?=
 =?utf-8?B?Tk04VVBTT0JzL0xMSkh0eitudTQxdFVGZ2V2UUdSdFpyazRxdlA2eFJsOTlW?=
 =?utf-8?B?RTM5ZUV4MWRvbVhFUm11UGk4OGljQzE4WmN4TDhFZ1owdDc2eVAyWHM2dXVi?=
 =?utf-8?B?Z01uNkpUQzdPTS9OZW5ubjFyZW1FU1pDNDNjemJsRVVaVGlkS3U4THV2R3pq?=
 =?utf-8?B?K1JuNjR3dGRQVzNpMDh3OVNBVVY3OHpnMk14d1ZGUk5rVnNETDdPUlR2L2pj?=
 =?utf-8?B?aWlja0hEOHB2eFg2SEhhQkxhOUlXbFd5YUZqWGRLOU53K2ZuT0tOTi9IQ05I?=
 =?utf-8?B?VnNOMzNQVjhxMS8wYXNnZUhONDN4ZkRCZlFjZUhnUTBtTGp1U1paeUNieG1u?=
 =?utf-8?B?RXNJQUVRKysvNTh3b1lzc2lISWd5bnhUUmU1R29SWFdydWdKeFFTWkFtMllq?=
 =?utf-8?B?L0pCaVd1SXB4K3BzZCtoMkM4RlI2SFlYQ3E3U3hleW1oUkVMZjZFWU1pNzRQ?=
 =?utf-8?B?RTdNaGlJdG9PSEoxOVZPMjduSGpvblBlYmFOeHdCbzB6YS9mMkxpM3R3U3Fx?=
 =?utf-8?B?VU9VM0ZEVUVEOEFFOHV0RG10S1BGbnBCbC9TNXdML0o4aXVNUFVzeFNFSjlv?=
 =?utf-8?B?N3dqc3M0OFJQZmU4a2tkaW5GM0pzSVpWSnVtdmhLZnZZREJPeVZaSVpoMThC?=
 =?utf-8?B?OVBGRWZ4cWcwTXZVbDZYMWhUOG0zN29tZjlBQ1BUazIyUHR6TEhmUDFiUU83?=
 =?utf-8?B?cGNzNmRib05xWjduTDRYOVlhdHBNbURIckFFOE9weHYzOHpBWEtBMkhUY2FX?=
 =?utf-8?B?SzkzOVhJeVBlY1ZQV0o0NzhwUmE1b2k0a1Ewb2JYYlJwUG9paGFmelByUnRE?=
 =?utf-8?B?YS9VUitVZ0VRNGVRNGx1c2tXbkRTYjkwcFBzUzVZY0N6RnlqbUMrbmRKSkN6?=
 =?utf-8?B?NTE2MDNYUUZRZTVXazhibWFWODFUdE54eStCMEZpaVdZSmpkWHpGNlgrb0xI?=
 =?utf-8?B?TXlUSVFza0MzMG40bk9GZTF3YjVwTllvY1kyaDZSZWw5OEdKaTM2cUhyTyt0?=
 =?utf-8?B?MXZwOTlsUWN4c2cvU3F5Ykp1Ukc5K1Z0YXg1MU51dFhMY3hqRGZGMmc2SWJC?=
 =?utf-8?B?MTV3WHEvWk9TSnlWM2lVWU5yNlZ5K3BMWVNzMzFvKyt0TlZhcXFFRThEb3pS?=
 =?utf-8?Q?cBWEFTxUi42jJvq4rEgcsNo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8493F6FF30724D47AEB22FB5B8B9FBA7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd3a9cb-bf0e-4a44-4519-08dab108f0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:01:58.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/+G6EKMtnlMq4DoQa9TPNDRT/TihjElvjCsR2ZwkY6GDXCoNpdLOdHx9ounpjk8c02MkeIpP/8/RaVXYM4UoVSIQtX1wzIqfd+fKckKYGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3602
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
