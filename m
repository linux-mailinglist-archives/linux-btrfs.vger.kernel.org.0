Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940DF6FCA7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjEIPsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjEIPsF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 11:48:05 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73153594
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683647285; x=1715183285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=S5Dxw0gloKrE1uPUefrmUf//vqiTXbjMlk1MkCTLLsu5Veti/aJcDvFR
   5qNIr2olfOV0wbaTA2ODzO57laNzAeS0w9G0Hcyafsp1mHwsQ8IQuQl6P
   qeUVFP3xb+CbKoGnwM99/j2/tgENbRvmM5T27DLR6oF12CqVYs5TS6LnM
   TwWg4liGHhH7edXDoNmB1Va1k3VHmC403WhOIZVffZnu7TRFy2tgikoA1
   cd1aZWXp0vvgOQIVpj3RI22yB5snyN58DQiyOJFloLX6NReSGxgP8oW/T
   5AWF06myPgILZuvuUoBuxWOo2rwwTdB1wZqHXW7TirqPPoswOQmU5zfz6
   A==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="235220385"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 23:48:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvKPJnl/Ti7+WlcVWf49D/kKMmoFD/EnNi4nWZ3jm3HdPUjsV2Lc+UJQ6Uk3XkCk/jwms1QKz/B7i2oJHvfBab2bw6lS9VaflwIXvqIA9+tF3W3fpgtv69IQJZoWiNOYULuYX+h4BD/U/FvLZQ7WLtIxUEXFVjRSYsGWS82X1JdEcIs6q9pOE5VjIKYr1C5+WeoV4/W3RVisqNF9kI1ZK2D6qffVhg63GbSiHsLmgU9PlKzmd6MK1gDB36ZN1TvhHbUErA7brVpIBRqCBnnL1hibR1D0dwzgm/tGYT0vj1dWQEluMf6QhGKYg5F28gFOWhRjAzck89TwcndID602lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=AZkzpKXAZ8zjChOM1suWK/cgDqByDnUKf+kUHbqWmDTyqI1KcNl53kzXColPDzbBHi8YUSfXe0yO3kz7JTqIVfjOZgGyJIKR7xp15WxB+kXbU8xsV5XI5AIuEZEfOSWwMCirlY3srvMswZ1Kv7FZuD9m9p1Z1E/3485s2gf2sDzeNkW54nUZX02yfLVeHnlvmHHZ9QQBC8k9ncOZK1H+ZPe9p4kySKr3Bnz6uGGpjLHG15uwLAre73ivxwZzbcMsC19B14t6UXkqmMbC3+PhSQfIz0ea3SI7FTjnZwphBDMbwafKOKiGiyMWCo55oCaghieImBCCwQF5P6APk1UE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=IWKiberdLtXPm4V7+nEt6OI4xTJ3v0ccvVkwWYyUpKymGQTj1scQ04QljE74Ur5JcMvyAvsAnnZcpqt38wzCW8VO6Af0q3r7nKAnK7dSPT4VChoG5UqkaY5mjylvRpfTCpEhzdoJAQfPZwweMcKrH3xrg4S8aq0bKjDxAQy2BeA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6792.namprd04.prod.outlook.com (2603:10b6:610:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 15:48:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 15:48:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 18/21] btrfs: use btrfs_finish_ordered_extent to complete
 compressed writes
Thread-Topic: [PATCH 18/21] btrfs: use btrfs_finish_ordered_extent to complete
 compressed writes
Thread-Index: AQHZgceHyDIe8ZtvqkyzEl0SHv8x3K9SF7OA
Date:   Tue, 9 May 2023 15:48:00 +0000
Message-ID: <1fa6a66e-f835-ec08-462c-acd59eb24c35@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-19-hch@lst.de>
In-Reply-To: <20230508160843.133013-19-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6792:EE_
x-ms-office365-filtering-correlation-id: 995158c7-8598-4240-d0a9-08db50a4c457
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryoDkm/EjScVAIB66VDJ5ByaQJPvwWFq2DO8sC22Vmy1fg+BwMfk8dZgVrpxKKhUbmZg/pJKqGSgqR8uxdUTzQPG3e5o+FcotAiJkwVunC0bXdjWVkWS0kp5ranAqCzksuKRP15Y26mAl3lbuykSCBN9na/Midx+xSNEndm18bk49uI5an+IspVhapjE8+ZPu7ciCmynHeubW23z7GOSIrwyiZJG6XRKpbSqRf3lOvLGBPS6aghnuQxKhiXwZLOf+Vpz4Gl8oXnf31XDPsSXqiXpE/5aRy0PY0zm8MPKYSuZ3tOtchOy0mkO888bLnRaBaJxO2ZCq9tacLCLdFCQzdPNDlffOuH6XNQoX/2oUeHoJV+dyn2tNph3etUz+BudJMTE5JL1qsRczo4Oqh88sAruOMQUnqaK5jbDN7qHlxYHGB20m8W8O8VhBQRKJ6id+QLJ64wNPUlsJagKAuxohw/BMtrOw6ohAHSsAd67oeEoWUCGe55TC3BcAYUzHvYuMh4PEBTe0QkUjDlsYPRd4YSHFrMZY51+J0SWPjqkGvMJV3ay3fxinP9P83mKWhNXzOO9nEMhA86WSKBjS+LwQxg2U6qCuMqC7eGp8q3KEseGswtZ5VAFZfe5ZEk/NjphJYvTQqylaAZM3EfvPj7bBovk07CO5rYXRvotJGVpnYGvfjcHGQCNzihPxrw6mWnQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(2616005)(186003)(4270600006)(2906002)(19618925003)(36756003)(38100700002)(558084003)(38070700005)(31696002)(86362001)(82960400001)(122000001)(6486002)(8936002)(8676002)(316002)(71200400001)(41300700001)(5660300002)(31686004)(110136005)(478600001)(66946007)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWE2QWNiQk11dzlmWEpxR09Da0tWdmNPMWc4VEZEbUxCMlgwVlRxNTNpMVY1?=
 =?utf-8?B?NmlwSy84Wk4vOW12eTNVK3pXVGVFZ3FrcjNPbEpwUytRc1pjcVh0cUZ4eFNO?=
 =?utf-8?B?d2RmOWZ4Tm1lOWw0UXNuNytQNW1XVGEzVFRhYnNIRUIxVjNYM3YyaXFjb1Zi?=
 =?utf-8?B?ODZBNEpVd1dGblh0NkpmNVg4VGU0ZnNPUThUK1dmQ0RRQ2FPU2Nxb2Y0Nmdx?=
 =?utf-8?B?bXdaU2Q4VU9CVEdCRjhTZ3VRbnEycTcxa1VBTGVOSlRjWHd0VXZyTGRoNEhl?=
 =?utf-8?B?ODU4QnRadVJ0Q25SVVB0bVNPRWJMc2hWQ2VwcVN5TG80VDJBV3drYkJ6M3dN?=
 =?utf-8?B?T0Z3UDVVWEpLZmY5QksxajVNNHJMVm5pYzBxRUhwaEk3Y1krNVVYR3ArL0tF?=
 =?utf-8?B?d25kMzdHd1BSdzNRT05rT0tJcGxsQ2puNVpzYUp0ZkJPSndJei9MVE00UHpV?=
 =?utf-8?B?L2JVbWVqYlFCak43d0ZiRG91cHlvMkZ3VHh2eUsyUU5rZlZRTW1aSkV3NkFj?=
 =?utf-8?B?aDhyQ2ZLUEpaeUdQdlJFL2tGY0h4WDhHa1JCU09CTmFicTZLWEVONmpybVFX?=
 =?utf-8?B?MTdjbVh0SE9MZVVraUt0SWxRYStjemdyOVRHZ3VuOWl4QWlFRVFUOC81R2la?=
 =?utf-8?B?QkI5ZHQ2R0EzbzN4WWE2TDd2VFBPOE1iYnF3dXg1bFdlMzQraEZrbStIbFFl?=
 =?utf-8?B?Sm9aRnJYTDMvYk45RGxWZWNrNlVqclBTelBPNTJMUTlvdlVPRGFCbmRjOUFY?=
 =?utf-8?B?ZVl2KzdvL0pUTjlBdDJZV1hZdlM0ZUIvVXhpa2RiT3dsN0FSS1Z5T09WZC9a?=
 =?utf-8?B?Q24wY1EvTHIvK1lsd25zVjhBdlZTdnlMUWRsc3VLNnphRFRETDRUbnBadG1j?=
 =?utf-8?B?OTI2TFVqbzBoUEZvdWc2S3NnUXFmN1diVWVCMHJYcHRhWWZpZExOQnJNMU9o?=
 =?utf-8?B?K3VvcEJoMU11YXN5OUUvTk1ZVVd4VDhmSEVJZGRLSDRNV1dSRGZubSsvNm1p?=
 =?utf-8?B?MzNuc3kwejB2K0piaitzODNFZ3MvUTN5ODVZWWo1Y3c2cm5rTUdtaGZwbHZG?=
 =?utf-8?B?ckJ4bU9STCs0ZjYrVmxnY0ptdHlIYjVRdWxoZTBJR3RQYXdKci9YajVuanZY?=
 =?utf-8?B?dTQ1MUZUZG1xVDlXaWtLRkU3SlVmd0cyazV2UWs4VnQ1OXBzUkRmYWNIdHBy?=
 =?utf-8?B?VDBwbEYrbUduU010SGhwT2J0MDhseHMrdlBJT2kzODF4Yms3WGJNY0tnNUpw?=
 =?utf-8?B?aFFlRXlpUHZSbjRYOHdHREhCUXFtUlY0Wnh1WXB3RDZhRVZFNWpxSW1aTDU1?=
 =?utf-8?B?STZhSnhkRVdSR29PUTlBZnBYeHIyd2dtREtQdWxmekc1eGN2dDd2L3FLRWxZ?=
 =?utf-8?B?Nnl3RTc3dGJBck96dndUWlM1a2F2OGVER1ZiS29kbW1UeEhWcU5pNWJkTll5?=
 =?utf-8?B?M3lHMHVqOUNjMTZkRkJiT3BzRnk4aUdzQmpqU0ZHM2JQRmtwZC9JN0k5OXFw?=
 =?utf-8?B?OUVUU2kyS1A3VWxTYjkxeTdJMCtpRitNeG4vV0Q5bEVjUWIrN0s0aFp3RVRV?=
 =?utf-8?B?bDFHTzlScnVaT3haREx1YVhDeWtkRFRXM1c0YjF3ZXBLdGpHZlFNa3JuT05m?=
 =?utf-8?B?YkU3RzhtbW03UWFKT1BJenRzMVZrNVQxZjV6cEFaUUVjK2lodnBTN2tNT0Jo?=
 =?utf-8?B?WFoxM3hNbERveXVoTGJxMUNSZ2JKYVNucUpnZnRuQ3A1K0c5ZjBDbWs3MzF5?=
 =?utf-8?B?cjRKdTljblJXOUlZTUExc3hsdnNucUVuUGd6ZmZZZzd2aWFWdC85RUNSZm5O?=
 =?utf-8?B?NENUV3NaeWxlQ2JQbENZOFNKcUpVQU8xOStKelRvU29ldk0vYWVsTkJ3eFc2?=
 =?utf-8?B?SVVXTlg0WTdQbHYxcmpXQ0l6bkNjWWZxOEF2ZUFlSzNRVUFleWorSWNhMnpM?=
 =?utf-8?B?dHlVNThXTDNSS3ppUHo3ZVpuQmVmSmd6ejRGYVBHck1VSWljSjBPWUpReUlE?=
 =?utf-8?B?Q0M1MUxvdGM3d24vYXprbEtrMkR3WWxyUGRwTlQzZmI3NVJIVk5kYnhXMUVE?=
 =?utf-8?B?UWJ5dG5aQ3RUdW00WHhnZ3BCK0FBOERRSmYzL3BkaE02dytnMWZOUEZjbzJH?=
 =?utf-8?B?bm5PYjM2YU9Tb1FRN3k3akx2N0hKWDNtd0UzRXNpUHZUUDlqWWVmMUUrNjhy?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53648CD4C427AD4EA3C570D8BFD2DEEE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D+sdBJLg7F1Ly2THl51jqIEDuSp6rPlhAvpAZGlLarEPg0L7xTtTNy3Kbsyomn2vOvmA4CW+rzGtRGqqI+Qdr+yqkmkhxG8JD6gdSSlF+GAFGJwbRNyF1E+sSVU2eG9Jf9c8CKTvQ7gXq2cnXSubFGNgkqAwsTPoIQ4lHBFTYgzWuKrY1+t7I1y+ADJunM0inISWT0vWotNAxr+Q553WALvLhinJmOEQOkjqIkmUZkds+LTMmYmqTf5S9knZIDzPgSByDUf/vCp1zUgjbIWuz42i/B7VM+f+hIUQe0HM8Bl+OvhW6TvH5N6lTZdxdWQzhXXjgtym68ZJcgmQThMoUY6nPFS8Xwt46JBcVy0kMfM4gEekqZaoc+3JLx4a35FAKVkFxwRXk7SBkfoARDmbHJnmdKxbpXDWq69VUPbYtVko6il7lt0bBfhPSgkOAr5UY3VJ5DflnmTpyghijbCk8BejnNDfnmIvGoAmVxXapHT5rOqP0tmBxbsQ9FXVsYYvhzM0EjJcwL+NBdzNKQ9hPAi9oLDUJwhO/dHPZLcN6i7+Tdri9uqExfJxHi/FKxIlZ2juLJ1mLEApDqCBIrz5dcBvaZluEhGPDC+wqWv+bHg/dZbXIu2Whx9Y0Ll55JlzloCeU55diMm8UnkZtGq7NbMgTEGcgoTmdRNwFlz3yCjGBBp/2hlPgyaBnfiKSxIBaQaKY4TfNeZFav4gKCRNMIFFUCqO3T4cytyLSc1XFmKT4fHjmVRpRG27HS7xyzuUPI3DianqNu5VJSbCOl/fxzTJo2UKRqPMY5mfIMVs63Qi8oLk1LPdxuS3VUfC13dCeOXJIOriSiTTARKis/iHw7yQqc13s4306TSxM3kcaWUIzD3cWBKpDVw61tKYR/eL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995158c7-8598-4240-d0a9-08db50a4c457
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 15:48:00.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3iDL1HCr2pogC5vtmyEM8UL9kzZqa9IAh79pMfWMt3lj2M10ikXy2pKh/nSGsj8rBCpFyumhl9WL+6w7j71wBM+LpNk5lmawHyFpQTan04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6792
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
