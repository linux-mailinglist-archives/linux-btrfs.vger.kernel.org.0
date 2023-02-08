Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C79368EBCB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBHJjv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 04:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjBHJju (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 04:39:50 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502C10F3
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 01:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675849189; x=1707385189;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=K7yiYJz67tP+ovLqcheY/gANFCfD6HWAC+WFGm51GvLn7jGgs65kiOeu
   WqB3oWyeQYCBUMX4/D4X53y68f7T5ffOSLqzV+hjQA7m4XqdcPph1w0po
   x2KWTqNWwFk571UB40EwlOhCq5imoTpY34XtjLZTxAZsbIk9lrqSiriBh
   fWKiu4GdsMDlFhymBZgMVZGESAsYLKfEQ4yNzNZ3CHtKHeVKLBoUbZ+BS
   IRpWTKxYr4zGJLLheu7l2gd1vUWuxdxf3554YwHWs3eUTtDuX1pH0iVko
   N6fJHVqYCaziYiUt4oT/pyJhyM2uGVCu8vuBW5r7s/FSdThypYfaum04R
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="227767536"
Received: from mail-dm6nam04lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 17:39:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWK6wuV6hoqNLdqk35ZUwJBpKJBg3e5s+I7p0jzMR3QannCy14V1fN638UOcMRwWfVIZfCrtF7/Shw6OIGWmBid4DXJf5Iz9C6++oZTTn3eaThdQy/NLA9PSq2b0yeBwsGU7U4aIsGr0wzsKoi6U/bUSChAhUNFagKtPM9WmrbgaLmn69yW6c4JeXmxo8zHqDFhttCWlSAgYAMVHsGSVt/z3A1KOnNa/0f9F6e9o6IADgLtdNcoUSfD6Q0hNzWqQYNaL4yn0Sfs8FV4QYDe+aH6r8RWJ/hi4iV1Oscs2uZlqW/jC2WzKYPqaoRhHhPoO4nIHasnzHcJnzzARwAR/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RWA66bZB9SFQdKFpDVfQLz/Lv/ZstxNLn9vWzSdAtnAF1PQNdzTFIlwPIfS/lj1wVfk/vYysiZnin0akZ4aRipkSBDzyxuKjMtMUjNMuzHSUCwtYhGgmyjzpK7wnjHI2iD+dmcQtruAMga3nmBxOj8pze/VHs/VpkPvMDjgEm049tWZkub23VmerlaZh3+JnFTsrGCdvvr2HZM76fu2VpIbybczwb7mIek4i3+tkyScw+1QsYlnmFI9AT/YE4VBRmHP4sp+19m26L8lxPIyAqCOOHkbDmgKOpEVUakkF5muxVZRHNqfEKFRJy1ZM0TThRJNnFm8kF5ZTVNWpaI/xQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=p/lCxivk3/Kra/Y5SPu7B8WF/t8X26EJPq07Wuy8ziVns8M35YJT6BfJVg4hTKW2pRPHxJXOfMlQBqTlsjD+bb0dENrY0IZ28/CB9dk1g2JrvaGuy8A8WeyGwupofqiMfJcEcWi4B3Dy4Kx+lxfJagktXWsONDLfpUSOyTbRL/w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5885.namprd04.prod.outlook.com (2603:10b6:208:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:39:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 09:39:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/7] btrfs: use btrfs_handle_fs_error in btrfs_fill_super
Thread-Topic: [PATCH 1/7] btrfs: use btrfs_handle_fs_error in btrfs_fill_super
Thread-Index: AQHZOxV10YVRsLGJZUSTFAkSMROmCa7EzGKA
Date:   Wed, 8 Feb 2023 09:39:46 +0000
Message-ID: <44988763-38cf-5a57-5fbd-563324ba2eef@wdc.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
 <74dfb92d8d80f082f64ddb0e3b3e073f0ae24e9d.1675787102.git.josef@toxicpanda.com>
In-Reply-To: <74dfb92d8d80f082f64ddb0e3b3e073f0ae24e9d.1675787102.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5885:EE_
x-ms-office365-filtering-correlation-id: 7b26037f-4eed-4ac4-66db-08db09b86a0e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02R6uV0Dbj2Nzp0Eueme9+mYypVyVrqmb2vjsMdI2FXL7AeqgqlZ9n/FRB9OR6TVTCJHGMiDJ654otxxSgHgBK1oacBA4GXgQelPThHA/i7v5JiUaft5st1Fm/a1i7JKdPrXOAasPqs7nQfxPQndRuwIMwIv2wMYdhncj02c3VgvYezbkkvXjtjg+gqhmKl/r6jAbo/BQl+MYS4YJ+P6Sv5zScE8QaaRKBsAKpIBHDMjfljz8faqDErJMXwoIFZjHCnKEuTCjekRTjZUaXmzn7RIeUzpvLWZWj49s2MInBbSy6IsJoS4CZM3gukOgdcRtjaGvDBRU469fW7q1fQIGPiny81D65fsgHAoroZsVpy+MRaWbjRl1/Q2VM/buDKTKKn4vq8poKENEEdDoLjP+wg6jEvLK8GaYHqwMOyk0aDT/Fo+E1P+WQ3l/etaxpAJHNBpMeevdz4KVCi/pmzx/7APS828V37rcriipaVG3yZgUYBKEqQTXi/ERi6uD/7JU7gLs7+OC+CB7mSNQpy9LKLgC+OsGIuTr0ciXNo5PWcybw0L5yf93PiMpktBZxSqqAIhNEDi9GK5f1gmp9+7jAVHpzaEnBV4ee0Hfv9q+0ynO+ws1HS6OChzjr+ckx2/SKVuN+Z/0/XMurCYXgtEHlwFFpdIjmGBsDdxtdQwijuCGl7+BZMb0vdk/SVvyc1MX7Gu7r5wEVvTxIRG4Ay3ZZzWGcRbchgx238VRIR0RgbjzQKqPqEPf+Mdl1LBFoO0yabCoqp02sGwMt6nP4TP6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199018)(19618925003)(41300700001)(36756003)(2906002)(71200400001)(122000001)(38100700002)(38070700005)(6486002)(478600001)(2616005)(26005)(6506007)(8676002)(186003)(66946007)(4270600006)(66556008)(66476007)(66446008)(6512007)(64756008)(316002)(76116006)(91956017)(558084003)(86362001)(31696002)(110136005)(82960400001)(5660300002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBBMmg3bktJVFdUek1yd1ZMSXNRYmR4emRaRWpaQ3VWMHQ1dy8zYUtYTDh1?=
 =?utf-8?B?WmkvUGVaRnk4V2RvSG9WM3BxV0VBUTlYbGMyclN2NjZ1SWoySUhJM3RPK084?=
 =?utf-8?B?SjZwdG5OckIvVTkvd1VrOGpWR2RhRGV5Z3ZWeDFNZkFxQ1ZyOHdPL2psWjJZ?=
 =?utf-8?B?ZGV4eFdQaEx2anNYVXZ0aWxzMndLUVB3USsrbWxSTTRsS2YydWhQUGlxbHNs?=
 =?utf-8?B?dEZjZ0ZsSmMwTHNIcDlkM3hrM2JDSUlpNnNkeVorVVRyVUVBenE5MkVSUmJp?=
 =?utf-8?B?MlN0Qi9JUnZIYVlKdGVkRFJmVmIvRlRWZW9MZTVyMTF4LzFIcGQ5ZWh3Tm9E?=
 =?utf-8?B?ZUVMWWcyTjFCN05pZDg5QUhLQWlEZktxREE0VER4RzM1V2dJeUZscDZ2cUEy?=
 =?utf-8?B?U2c5RzBzdHZudlhBaU9mT1RWQ1cvV1lPTW5hMi9xczlWZW5lSnpYR3V5ZjI4?=
 =?utf-8?B?NC85TU4xSmZLNUhhZWRTRVNSb2lMbkl2eE1nMWVoZzErMW1ZTUpBM0lQUTN4?=
 =?utf-8?B?c3E3QlU5cVhrWE0wclo2WUJDZnpVZTdWODZ1VTMrOE12VmVCUUhiYldrbEVH?=
 =?utf-8?B?eHhJaUZYbndiS3JPdlZSdUZNZ1NRYVdELyttTjgrekdsQjRrR1BtL3UySXpX?=
 =?utf-8?B?VXc3TFcweHA5RlN1SGV5QTZDNFNaNGFTTDkrSlg1MU9ST052aXZxVUxvT3E4?=
 =?utf-8?B?aFNjV0J2cTFxUDU0dU02RC84TmMvVFh4VGdCSXZDcHA0NVdIcHMxcEJpcmdI?=
 =?utf-8?B?N2NLalZrNHFpOGx0ZDJOYjUxdzI2aGhDT1pwUUdPY29aM3krTEVwRHAwcU9k?=
 =?utf-8?B?d2U5T1NSR2I1VGU4d3VBQjBOMnk2NzZNUW5jLys3cmZXWVhYeHVBSHZhaGlX?=
 =?utf-8?B?QTdNYUxNeEUvWW9iOFdOc01sTi9jWFZCVlFveDIzT2pZQ1pVZXl4eVU4dHFZ?=
 =?utf-8?B?dFpvYnN4MnljZDdXSzB0YmFPV2NqOVpnVVEvMFF5Wk04eGhJekpwQXlqUFl4?=
 =?utf-8?B?MWJ3S05CeEdGTi9qTHJiSmd3a243eERMN1dleXJyMFhxaTZZQ2tVK3FUczlw?=
 =?utf-8?B?cVc1RzgybHhQaDZNQ2VvZS9aR3YzV2xjdDRmSzMwUVEra2NtNDM0UFhUMVp4?=
 =?utf-8?B?TFJnMHB6MUNwWFlZRDVTZWkyeXNmM0JRdXVTYmhrUmdKYnI3WG1WNUFvc3VT?=
 =?utf-8?B?Tkx3ZHp0VnVMM3JLR0xZY2RpOUdIbFN4cWdleXhIYlQzRjRlS0x2dVl0UnBG?=
 =?utf-8?B?bC9Pa2lOQ2xXUE5Sc24yREk3bmIrM1BPL28wQU5IWm01K2dHT1gvZ1F4Qmly?=
 =?utf-8?B?NStHTWRsdkdHTzRDR0JjQmRsV0hxdnBRZ2ZTL1czOUtsTHBCb0VDYXJZNmhj?=
 =?utf-8?B?aVErZXM3SVIyQ2xHR0drOUZTd2pPNmZnY3BENmtPbmU2eEJidXhiam9nZWRV?=
 =?utf-8?B?bm9KTThNSDhNWEZxektmQW16akMwWmh6dDdNd1BlZmFrSWtCRStNWFFSQ00r?=
 =?utf-8?B?dVVLV29JSUIraWFGdVFYQ3BpN3krQjdtQ3J5eWF0L1Y3NzUzd0xXWEpHMFAy?=
 =?utf-8?B?MDlKYzJpVXBNd2hUb25nQWFFbS9kdWRFUDN0RlFYQTRKZ1NxMGhyaWtUNXJo?=
 =?utf-8?B?VkFINGg3Mlg2NVMzY3JiNG9yQmlrSDRFa1pscHZHWnhXS2pYQkVwUHZzMkx5?=
 =?utf-8?B?NkRHVko5Ny9lT3IyelNLcEY5aVZBK2p2WDdndzdwak5IanJZVkJsaW5QbEJ0?=
 =?utf-8?B?dlUybk05c0ZraDRQdWNGZzRwaDVOUWJqb2pxT09IN1MxMWkzUkd2SU9QYldM?=
 =?utf-8?B?cC9LdDgweHY0Nk5BS21GNDh2RVpiQjU5WkFGUmpCOXp6ZlBQV3pyNXpwandK?=
 =?utf-8?B?QjNIT2huWW1Nd2pTNU5JVzBVdW5VekhacTJNc1dzNWFLZzQyWDlDOEszRjhH?=
 =?utf-8?B?c01LZ1BZVHkxSFpJV2FOREhyTm8yVjFZWTV4cjVzVlhyTEZ3ejZCNEppU24z?=
 =?utf-8?B?YS9VR0h3RGRLWDFxTEp0MGY0YjBUWjRDUVRBSUxGdWFXVjJlQ1UrVVdsdU1O?=
 =?utf-8?B?aWxTU28wVCt6bndiWUZyNDFwRzh0aTRlRWlvZkNNUEdjblhBb3o2OGcvUUhq?=
 =?utf-8?B?ZENtbFh3d05oT0gwc1c3ZTBMNXIxNjVjbDM2RUtHbkJlRkRKVkpVdGZPL0dm?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC9A426F97C9704699EE15703632C687@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e6vFa8VOSS77z0U5cz8PX86KfEnzvCPaSgMhiJO5YKZNVuVBgPjcPfU7hyXnq26iigbSZoFlj1+or8KS+oa0sNqLaQPnU6fm3lFd8ptn9p3ebWu1M1AoT0icnwtFEzzLpic0GiFJhwaNmfUCyaF75ABC5g/rsnhJyJwYD3eRj/DkxQyRUMUH5ZhSbdnLlckNJ0A2q6ISHckgmQNonXbhiTBuHQPfqFkP7adxC9cjEGfl7idaMoeDe4AkUvACvtqcfV9SYN17SIy1Jn18L9IEOoMWw+BHg7AU/kYW5RLWgPkBL/qbWwrmgdnax/zEPJwpI7SpzwERhvwqVgeDyTMnv2ims8uluPk7xp8YIBO2c871UzsheQBGah84K7EHExcJKwLqVdLh46m6kmeO6moOddRtqVJrqJPYFUZf3w2IvuvICRcCoNsRlkgFXyH6ly/jY+aqxJjSJYZjmBTmR+nd+1DOqcIvGH3g8J0d0tygVrouU8FroA+D2/1WU77s6nASahUJ1mtmznMTFfbPrxDicnhK3nIp9BqZQ7Pw5ZGtqPjHMuW7JTPKPpLlTZBcZx+oukXRbuRvZBYbG1qxjfw44wCmPRpCHsMlDjqvkYVQmFfgaAH91rgEP/zerZN4+HSuawwZBL3AooNRT3ohSX2QB8ehT52wFeXDmS/uWqiIBnsxU4wu6PtqDUZ9f+D6L9jH9KjEgnI8et6wa9vC9zlbZ/HI6A1PunWsypuPkQh4+DP9XbjymRt9vCQ0Hp6oub54OEuX164bJm7ggYVSWiq9/Qss4eC+3dMxhdZx2oVHA5sIYUmMTqinkbSagnLlsh9GLnxENyeViJ7bRrkki0HBSQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b26037f-4eed-4ac4-66db-08db09b86a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 09:39:46.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yi3tK5HRIbBKeCmn2oF+ZRgJiu+P8DW0x+SO0RxQUJFESd9Vfawdp1E1mrBjHzRYfAcinHd5JWJI3fHccnb7dbonNat4pm/tTsglCsQpUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5885
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
