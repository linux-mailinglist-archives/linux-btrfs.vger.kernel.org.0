Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAA69C7DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjBTJp0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 04:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjBTJpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 04:45:24 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F9BC153
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 01:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676886323; x=1708422323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Z8sD/Xgv7IMYWiUlMJK/yKXROyCEgbXPq53TYzqiuOuwzAZ/+CKizY1/
   YU+fVlUkgJoLRjRtovSYutGMAocj1pU7H0NuhdJVNeyNbJxgWrrQj5jqb
   BDV3ivNb81h1Iakm3wEUTSQPv4ctwPHFKCt95X72PC67r/jw/6hcIStcX
   j4RIARCrB+hwD8CYELroI4ohbm19/roLWnDrPGF/hmgBFPwvajAjdV3J9
   E7OzBKKNA/+t7fclAmqPq3lav1DKz0NjX5C+kWiUqDuVRUhxOG9rMl5Ym
   uKKcO9WM3qk8AISCVmEFjfwQL0oDULntQfQ0nVlakUl1wa1c+hODebzRn
   w==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="328024151"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 17:45:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8Yp8veBVgMNRONlD8KNokjq5qL425V+6sVQRb1+tFAFbtjM2gYVgMp75a06k0+vfJ5rC8aK+i4Swx6tzs4nNdfZ5xSSL/qoBuGujg0nEimbd2fGASnckNYQYW7wSAUAqob2rMOj0urMu6MGae+Kx2P0Y18z8HB8z4JjPuA8lOvZTiWVdg5yw0Qiz9Oe1be0B1BIaxJ9KJgX378Vj1qT3uxZXZifjYcF47d8yNYug46tWwFkAzkK9GgjZw7/LIPv7QAifpMmxkAecehbmy2nt5io2hU5yVh0WgncwP5rtNzqdMdi78oXnHdggRMNv/8fwYX56Z0E+eQGTi6+5W9jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oXNJ2o/D1KidOjSbfl0PIsCo/X9AO9Y0AU8MNoM5yrDO5J6STgJITxDoxVrRMooTf2wyqToiFfg8iVRTmMDDV/m9U1FHVcpcQjB0uiCytmRV8GccwOo4QpWFbj0f8yGW8jfbk2TuuBEU06D9BEfy8gmhKENTBOz+Vy5I/B0+HtC65OmYPJF+6edEtbvtAwe2OwyXtACvJNTT0mJ8QbGpEdEMiwzqP42CZppiWhDMDIPEJalxEMxBefMj8UXWzUmURDdPOL/gHtL8mJ4Mf7973qw8ze6Q5qcb9nVizz7ZVct/ap9zdyymTFXaOJWlp/AiMGLbJlY65SMhXxxX8hAa6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EZ46l+v3HHIL+wC+1M6Sw5HQ1HNFCDbcoFrIihSCivN8V8ogdefuIqhBam0uVami8DmzmUZ41buGORu6uP9qKDNgh8VIERqNkHwfdhIM6pzApxbQzu0JClD+KbnmKiD9+X3GA5gKHQNFvGHeRuPdqs3ZNG7mJoKiOtQ/qncJ3g0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7281.namprd04.prod.outlook.com (2603:10b6:303:7d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 09:45:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 09:45:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/12] btrfs: remove a bogus submit_one_bio call in
 read_extent_buffer_subpage
Thread-Topic: [PATCH 02/12] btrfs: remove a bogus submit_one_bio call in
 read_extent_buffer_subpage
Thread-Index: AQHZQiSeafVcprGQh02nGPEccqiJB67Xm8qA
Date:   Mon, 20 Feb 2023 09:45:17 +0000
Message-ID: <211bee37-c055-4623-b85e-e34f3d6c0462@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-3-hch@lst.de>
In-Reply-To: <20230216163437.2370948-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7281:EE_
x-ms-office365-filtering-correlation-id: f1f14c61-aaf7-4e15-324c-08db13272ca9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sA8lxqBRIjKW2A4ojATFJmVTf9OoNeQmU8wUOrGOMKbmpmmdhJTetl9Q9hqmyDEGyalw1T2BmKNQKlBN2TWhaP6RoX1l0+PUIjKnTe9jxrlcwmvbvKcV1PENiCnp3gW0yz9JaRufKV3k3CjsWac2BMb4gIBg6In6V5icQQAKkikr2WXeOPisz1rw5vVAMbRPf7lJK2YBTzRTiOT90PfL/bNN9N1NigYhmgjzoBtNoDSlqnQnvB6UU5QaSeoU0CY4XQSciuZfAmLAOk7UGO2zsfdCrSVvLuXudEimVzaSd99DQ+ygJ7SWSaevAlWYWi4u3321BbFyUkoOiys2UQUYYmMzUVrSybi9BtTiKQuX+LNMI20TBGiYjaL8dV4u76Qpk/0dzXYyYrEszvLFMRSyXyMUG2nP+LBPGbrkRwEqfEj6aSjYBlB7UjOxJLbZrmmSq5qnJjvDYMYBVSCKNQxhTvJcIXMz+q8/tvVB3t9RM4t2QJFZH+VSGVfdu6MxS8SsHTnnotEx9nbw942iZ9N4MzRDVb9m82r2i/e04rzqFRBj8SqDDFAxtMk2YMGjhul0zvPinfZiUqj2t4nF/rVqNCsTRDU8A31LOqCy/BcRha6XVZ3zN5O9yBsZ8GuK3tezhS3zukYyo1k24VJ4l2BT2hGLgMyC89MIshurfIWgyWPeMc0o6daw3oqT6/D12t2g3chnRiQOcWCHqF2b59G8PIJQjHTiy4d1l7NVB18zQw56XSIZT2gLDPsYG1c/dVZmFxrstw99jJYY8YaNxZL9yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(186003)(4270600006)(31686004)(6486002)(6512007)(316002)(71200400001)(6506007)(478600001)(91956017)(110136005)(38100700002)(76116006)(64756008)(8676002)(66446008)(4326008)(2906002)(122000001)(41300700001)(66556008)(66476007)(66946007)(19618925003)(8936002)(82960400001)(2616005)(5660300002)(38070700005)(36756003)(31696002)(86362001)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC91RC94TTFyeHhWK1N6L0VyWXJsQUNaTUFxZE54c0ptYVVrNFN4aURIV2g0?=
 =?utf-8?B?eXJFU1VHK2dJeDI0WmtXbnpDRGRHREp1UU5BeG1HUDErRHNtUnFwRGlaekxC?=
 =?utf-8?B?enlEQ3NlUmdoZVZZMDM1SkNmMktqb0ZTSnorejJMODU3THZRWEFtQjFMbWNN?=
 =?utf-8?B?VFlpVlZGd2RGSC9Id1VsOWVRLzVEVHhOOFdLcy81clc4OWNSakNPK1FQMVph?=
 =?utf-8?B?cjVIN0FQcEpocG1WWmZaa3djNWJoNlNUZGtRbDc5dW1jeTAya2xVdHFuQWoy?=
 =?utf-8?B?V0dnWUQ2NG9DOURxUzVmUG9QaFJWd2tWVDNNMUk5L0hyWDljNUZwUkk5WVZ2?=
 =?utf-8?B?OUhuaUpFcnNsUHF2MHdPZ1RyRFNsbEFFQjlYaWJHMWJUVHBqS0hlYnJsY0h5?=
 =?utf-8?B?cXdZMUNnT0g5UXk5WDg5Rm5TM3poSDVHVVBxWWpVQmltN2xBMklZUXI2MUd2?=
 =?utf-8?B?VStGdmdSYmdadmFZbDFJWUxxWmpqUVE2c3BOUGNjdEt5VjZJNVdyNTNxVUdt?=
 =?utf-8?B?WDdpNDFjWjE3THZMK1pkLzYvbnUwcHhRRmVNZGNHQThjTjdPRzM5cEVjQnB2?=
 =?utf-8?B?R0ttVHpKUmVoYXlmNXZvVGtSNWRRMnQxdHc2SW5XbWE1QlU1dk5zOFdzVXhS?=
 =?utf-8?B?MWp1VE5Ud09BV1A0QjIva1NtbSthYTM3cytiUkdxUjFzY0hOeFhDM0o3b2kv?=
 =?utf-8?B?YnVxenQwUVdQYy9Qd3VNQnhNRHdsMVJqRktORjRJZGRqNnp2NzZjVFpudjE5?=
 =?utf-8?B?Z3VEVE01WmpUeUFwcDJSNi9kYzg4blIxUHF0TE12ZWNFbnFZWFJWT0xEUnRD?=
 =?utf-8?B?NkVXNzFzZTVPSWNldXBEVlZDdHlHcFhvUjRJb1grT2FRNjk5M2lqZUdTekF6?=
 =?utf-8?B?dHl6cmNmMG1hZExKbWEvOVZKbGhldFhrQkl1Ui8vQlo1R1ZBOHVGbE1TQ21y?=
 =?utf-8?B?RE1HRldoRXJGdFNxSWh0SytuWTdCMUJpWm9EdUZWMzRzU3ZxM0g4Y29CVmli?=
 =?utf-8?B?cVVFTlptZ0Zmd2YyM0JlS1FPcmh6OW1jS1Q1UFhyNzFHcUlLb0VBR2Jhclpj?=
 =?utf-8?B?TU12aWNuY1E3aDNhNUxFa2d0ejFsaStkb1pqcHk5YUxWd1JaYk1ZdXVpd3Vh?=
 =?utf-8?B?ejgvME5PaGlMNEs2WTRYSnU3cXVxWUpUUkJuMmczUWd4cEZ2NmFnd25sZkp3?=
 =?utf-8?B?Yzc4bVNEY0Rwc2FkL05oSDZBOEpuSWxVL0lwdlhOMUhvRUpNSzU5akIrRFBZ?=
 =?utf-8?B?emx6UzJDL25BdEN4bTg1N0grTmNmTDVSQ2hlVW1XQ0E3SGVqN0tPdTJyWWhL?=
 =?utf-8?B?Q1Qwd2t0MzJwcjZrZlVUNjB0VGRINkQ3ZGM2ZUtTS2t0OCs5UlVjVUI5V2wy?=
 =?utf-8?B?N2lKbzZVeUVaZWpqOG5oTTFOYkpreVZBSW9wYVh4VTdRTG5MMUFRbUpJV3Vh?=
 =?utf-8?B?enFqQVVRWW9lU0ZPV2t3cjk3Tjh1Z0ZVRS9USHNnamZ6UERxaVBrSnJJZEUy?=
 =?utf-8?B?Y0hEZDlhUTZCelpKcFVraDRRWk1QQkdxcXB5UjNvaGhqSXJiak91ck5OaGV5?=
 =?utf-8?B?ZnRycExvRTVyaXBzUWpKUHYvZFFUR3BDeExCekhHWGF1dTYyeUZpR2RUZzFl?=
 =?utf-8?B?S0xRNXQ1US96TzNBb3g2TEZKd3cvZ3drTFZabituUkFpeUtoTTk1OEYwWDBW?=
 =?utf-8?B?bWljQ2tSUkpISWxUOFRsTndFM1B4MjBRcGxyRGNpeHJHNmE2ZFlTNThVNkVj?=
 =?utf-8?B?QkJ6cmFaVk9zWjMrWjJUdXptSktBY21qU2dnTkJDU2ZyQkMzN0NYVWZpSXNx?=
 =?utf-8?B?SEduMmcvaXg0bnNoMmd0WTRIdXlYdHZ5UXBKM3Znd3h5TkNrZzJ5RHRjbXFj?=
 =?utf-8?B?OWdnWjhXOXY4VVVPbUpGTHVPSGFoSUhXbXdzclZPQmZ2dGtKT3FVQnN5QlBw?=
 =?utf-8?B?TWx4ZzBZZmlTVE9vWW4vRlJuUENkUzhWTk9XbWhhNkY4ZDd1dVBjbFpYUW5F?=
 =?utf-8?B?TGdTWHVJQkxsbkRlazErZGgrd0ZGUll0ZklVcEhhb2swekVoUXMySVpieFpO?=
 =?utf-8?B?QTN0dEUrU0g4aWxveWFkcVpEWTRnYWZGeDBNUlMrTVBPRVZwWGcvTkczaTFF?=
 =?utf-8?B?MmlLeXdZVlU1VUxrWXZlbVZ6V2h3WGExaDhMYytZQXN1anpYOE1rMWdhTlVo?=
 =?utf-8?B?b3N5VUVtTXlGYnpRcGI0WEh5ZG12Y3h2ODFOMm5hWGlRRHRNZTNCVjZCVS9T?=
 =?utf-8?Q?qaoVl55z/hX3PWsU2EMUhRcB6g1MmscVGsZYAzvDlg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36C9BB7321527642A9C8E883A857E235@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xUd8zacUbTBzNOHCPMAA/ySw1MpbZgXK442sTuCfcU+TUAyDLdGYSpSIQm3EkN0bPBIv5C3S8O++0axkwQRniaS3vkEqgDWAY5DG6VYWkKEaLntHUsuhoPvqBvMCzCSsy0tqPH7WXO7q8c5ksYtH7TkXdl9EIxM9KF3IUhM5w64nsa4h9bIcH5x6VwSqs8k0oWi5tqNX2Ki0vEcw4vpowq3cqVyy9Zq3BEp1B89GUWV42evyF3fNFnCMOLhEGFXNDkiqv+0bVZL+iCG6Aw3p+AIT+DpALEoIrKwKQWwnCB2i6RWEWqQK5RJiMeNyLnTaAZpNhmB9eGwwx8dKlz4MpKjjXRj6LWjc8yHifIz/+D6KOEsg6IVopOPzWw2pQ5XmSoDR5faGHa6p4Awv4a39C/N92JeWQY8ZYxlpDSYbNfsfmzBGT7BQgvxCrGlOdgtonGRUA42kGLCv0eU5y1RIW5lBATvhao2j7MlRBXJC8wW5HXsdZYayF3UAQF+gOVLm8f+IrfoVGjdCDFLpkF9+kadqUHAJWKRrHJ1B+DxxRqrSzelqxbC4kCUdV3Cb8AYkOyQ2jAN3Mv+fZMNvHEVXf99P8x7VPfrgMOrYrEiaBnrdDsJ7UJh8MGqY+QDCpV2SadCpZpky25TyQ9LSFgg0vv/GRbq1+1k1AUZj+yzb1B1e/sdtFG3m6LRvjs+gaB43vRfjkA0A8px73us52izsIMJPraRWaEnCR+wuin6TILL2i8JgWirnYce4voZswh3CzA0jaWDu8tM/jOnvj1IS8mqD2PxWZwe3xEVUYCO9OOGJ+cegQ9JiUuhwC99KR+MSwOV5rGB2/C3qgNS0azuBcD9OPQsZe6+GckGoAvwo6iVmkPFXDMJ5LMPsa9ivu0ss
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f14c61-aaf7-4e15-324c-08db13272ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 09:45:17.6682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPzmGTF8lOv2VcxFmzrjliEIXi0LrTGJB8l1dMsxWg3rj/ywA+V22EcEijDBm+kggrWxrJ0/+6I62kAd8bFXP2qO1CulyqWcQA0Q9nPEvUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7281
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
