Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25E69C81E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 10:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBTJ7O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 04:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjBTJ7M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 04:59:12 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00FCEC40
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 01:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676887151; x=1708423151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZK4vwwljq4Ys20ZZYWq48uinG6Zk9EbFHBrz8nN6Dpws+smp/W6iWZl1
   qO30zzHj2zhFYRhttxQS9dGCfXmQlxf0trHKezWgw5SSJL5lohYeTVmzA
   /s6iZu81DAbZdryvL8Dy7WWOr941IQp030MAB9Xbl1359yu3He9ML89OU
   q1aBf208cLffrBlvi5Z+KM3U4vOQdWyLiMxIu8Vy+UnTw0h5RLKlO7TTe
   8/vKICYRvI1CmeUtoILWmP7nHreF0dfr43Tvd1h2BgogA4jg46p1MaFNX
   7Fk3pgHc5CmdVa2Nu1HjEDmDRCdjjpeJ+rBWvigOPgBbnvz0Yb72IQC4Y
   w==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="222013686"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 17:59:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNtAsXKaD0H1dxU8HH9lQRguykX4YrNMQnC1X0fyz+t+hu4Vapz/aFIlRtWJE2/XEjIMHiC4wugfmF7YMXPRsl449DIVA1RTBk62gZQ9L/c40+fPCd/uWPieizK7KpW8ehZtGQC5msQafVLRxkH1MC+yfz56hIqm0GzDAWEOcs567GtFjjLM6VnICMz3LjlGM4NA7z4Zy62pb7qQXhjNV2oRb/MFIG0mTZarcT7H0TPBPjCEkcHW/s2WXlVR7535ZQM2UsiFVjonp2Om32iD3RZ1bYD+FDQpQVEnntCXnLHLVkL2MLGRjzIjnI/qis5FZbwiO19arYfv99SkRCtdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=H4tdUXJEgA7SOhlb6qktZie6DsbQSf64g6zkdhsq0rV/1D4QHU9yivXdg3QXQxziSlmmDaFUFvF4kuzApz6BFkEc2UGugcMPlvTGtpKDqOQprZv/FXdzRSVMitQlt+mXMlQPXx1/QVTs+tFVYorBhNeG4z77Rq3Tq4XcxZSsVh93SR7gy+1NVeV5nC5vycTWIv0bfMYPM9g3wOlZWtTbhclTqwqQJ4hQY80OHxzl8a8VJ4HqoMegXxvNPs/1BPGdGZLo/PIZLxNgsxEE3HlQ5DjCwfpmBRmltjnHW6GslTh0d6COYoLjRnz6HurgZ9OF7xfk8K3otYrAlcp6OWIaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NgokLjWv4Ot84gKuORZK3qZEkm7Rv5ODxABI3VRSWFhPvLUZoCBBUV2d7j3vu2PrY97s8+AXfBod3HHfjUMeQLXpFnHVLk4AF35O/9goXw/uaZ9FJINqyfpu0YQQ+o6rp70AhhaoFLWSUWUsaS4n5NgMsmZes1D0m3SxcTn3Bio=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4275.namprd04.prod.outlook.com (2603:10b6:406:fd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 09:59:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 09:59:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/12] btrfs: add a wbc pointer to struct btrfs_bio_ctrl
Thread-Topic: [PATCH 05/12] btrfs: add a wbc pointer to struct btrfs_bio_ctrl
Thread-Index: AQHZQiSsM5sT0ThpWk29u+3FNONCxK7Xn6YA
Date:   Mon, 20 Feb 2023 09:59:07 +0000
Message-ID: <60ecac1f-5643-ff3e-dbb8-42fdb8d86469@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-6-hch@lst.de>
In-Reply-To: <20230216163437.2370948-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4275:EE_
x-ms-office365-filtering-correlation-id: 4a9c86bd-e3d8-4c44-a537-08db13291b36
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GJQ0FpYnnd9W5tcC/pyTI3XUbLwrc1Ii829UczC/6xBFEZnMMXnKY6GQq55+Kov08B1cWvhdrbpLgZWFBHfEgjK3O46cHVWg6XmSKTHz0jj6p5EPeXxgEhe8OMzO8DNpMa9HJTmPme7KkzCP4ZiolF4oBWCdAXLQ8ZLeeDqdi2XceKeRaNVHPvQxFj7WQUlK5UhSwvMHH17EpzmCyyrJPGh+ECQJauIEKloJHS9WAkaN5EdxxtHbVhHM4D9odnLEqIt1sfZxoiZrZuXSqMH1PPFaRew6Z8g5hjQwFJWg19eq7jOSv7hxqp+vPHJMN897voqFJK4op83ryxClgLshW98v3ja3H0IdzwCErHZS8SlubHuxVMCq8LjUUCVHw215DURCUR943XIfJ8b3zfWZhfKFPy1gv3EF8iwFEbFhfn9CT9oahZNka6QkKf77La0PLt0ZiSZyWpydK+/ZvhH8eJO3pItl+v1R/JknFZ3i1fLpQoJJWEWT8TQfm1TE4EFDmtRyP2mh9MPtxYCqOvZutkALSRQH+lmddjrreOYuM820PJMIv7bRIWp0zytRPl9RjjqXHVBf52nSM9ASsEfnkUYjUR2zsSN7YY/H/rD89RLACoK1VsBlGVMIzTlON3OetRAixp3LfNsQfAdoRJZJQO4F1P5J5Er0IrUHgtD0yfZ7TA5OYWOImovgIxpU4usomBxuXE5DC2Ck1bLDvJIrxXkbviNGVG3kgdDrBkdsrxYH2XwFdMCNBSb2X78XCqXqhH1OeMbJ7q4PwN8b4dbdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199018)(6486002)(122000001)(31696002)(31686004)(86362001)(316002)(71200400001)(110136005)(8676002)(76116006)(66446008)(91956017)(66556008)(66476007)(66946007)(64756008)(6506007)(6512007)(4326008)(186003)(478600001)(82960400001)(41300700001)(38070700005)(8936002)(4270600006)(5660300002)(38100700002)(19618925003)(2616005)(2906002)(558084003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3VOTFBkOXdjWHpianYwMnRBQW1CTnR5dW16cjd3RmNwMm9pQmFYWitPR25R?=
 =?utf-8?B?UFlJKzM4aVVPTXdDV1piYkdDNEl3TEJZQ2htR1h6c1JYN3J1MittYWk4VUhl?=
 =?utf-8?B?YjZoZHFNc0FXbU40c2xGNGpudWJkYTJvWmdGNW4rS1UyVE1PWE5QdTZhOHFo?=
 =?utf-8?B?NklZRWpjenlWUWVFczRXS05ZNzMzWGthK2tUVVJlbTlJWHU3bFg3Q1pHWWd5?=
 =?utf-8?B?aUhGZ1BndTQ5a0xrME53NlgzeXRRenY3M0ZYNFdaZFRNdHNhVzhVUlU4MkpC?=
 =?utf-8?B?b01vVndqenhacDBGK2dSRkFacUM3b28wQW5EelBPMGhvR0p5dVovM3RqR2V6?=
 =?utf-8?B?N0xWV25yUkYvK09yRnZBYlBnTDUrQjFQNlJxempLejErYXMwTE5FV3J1MFkx?=
 =?utf-8?B?TzFNUGllR0tGc2JLaUR3RTFuVVVlL3VsV2QzWTd0L3FtKytMUU0weFh2R0Rh?=
 =?utf-8?B?U0NtdmRvRUQ4NDFSSnRZRUpKOE5XOUE0Rjlma3V6SzdxUHJqdTVub1hkYkMw?=
 =?utf-8?B?U3l2bjZZK0FqTmZuczMyRmo3UUxuOUFGODRwdE5WRzlYdnB6bW9DNVZ5YUZI?=
 =?utf-8?B?SjZ4NG1QNTBQcEJ6dkE1NFBxOWZYdnJuZkY5Y2xQb1RWNmQxTVgwZlB4S2pO?=
 =?utf-8?B?aW8waFdjd1dIR2srcmtBQnRYZ0h3WXBiMURySWx2VzhXM1ZpekgvSXVib0N4?=
 =?utf-8?B?SXRvcThYLzhhK0tlU1p3aFprK1NHUFZtdUgraVkzN05mbzhrcis4Uy9ON01M?=
 =?utf-8?B?TVpOOHJadzA4SnVhK3JHZUhyc1hZRTVVaUZzNjJIdStnalVKOUYwY04rOEtQ?=
 =?utf-8?B?eVlxeGVhaGRTKzhmQWw3MWUxbjcyQWluMmFEdm5VOUlBNHBlZTZ6RnZNTXds?=
 =?utf-8?B?MXIvSXE0OW42SjlEbGwybmpxVVpBdTZNVkI1NEo4d29abUVJbGVtMjFyRFYx?=
 =?utf-8?B?dDZ5YURubjJoQ2JHY3dwRHNUaVBkU1FhaFdqUDMxamdOam5sTzJGdmRocDJF?=
 =?utf-8?B?eFRHV0dNNWJkdUN4L21zY1ZiUzNZSWNhVmM2Sm1uemVlbkVWRys4UC9XMEc2?=
 =?utf-8?B?Tm9YMVc1QThINmtwNHVKdXdhNjRlWXN1YW95eGZsZmNMRzk3T2lpR2JBWkd0?=
 =?utf-8?B?M3U5aXZzWFVPNFNvUTY4dmtwSVhhK0xrOWVpWjJudG5KT3N4Sk1oUjEwZ3hz?=
 =?utf-8?B?VUV5UUttN042eURONHZ6RHo1d1VoOG9CejREbHZiZG9aVTYxVFZpSm95SzZp?=
 =?utf-8?B?OThoMGFJZXQxeWY1M2xrRU9Ka1lQeElGb2QzVGRvUVpOM3pGNjgxYzIzY0h0?=
 =?utf-8?B?Y2UxL0Y1NVBGVUh1K1dURGxDdEUyMXFVZ2NMcm0wQmxNa3BBTHcrK2F2dEVS?=
 =?utf-8?B?cjNDM3MvQVRwSVU1WEdHc0NndEJBNk0yZlJmYm9MZHFGT240S01Mb2lhclVy?=
 =?utf-8?B?dEhnNHdrcEpDT2l2S0dmM0tGejIxeXJaWlJEWVduK053QTVvN1VDdXk4WklS?=
 =?utf-8?B?REpENGxzMHI0eWI5N0tqdk5PTDQySFdhT0ViSXQ4ZnpSWGRXU1AvdWpkQkJP?=
 =?utf-8?B?dGpyWmduNTdxaVhqUm5TUUlVVXdYdWxzc1V3bjdOUFJkN3lEbGhRK1EwRTds?=
 =?utf-8?B?UnJ0U1p6YSt5bElKQi9IeUhMRjRBaHpDOFBKcHc0cHJRNkNaSVo1Vm8rUEtV?=
 =?utf-8?B?UzZjaUh2STU4QWxqdDRMbDJHYmFUWStqdzBuY2lqQVJuOG1QKzZvUWY4QnpK?=
 =?utf-8?B?WTl5QmwxaUF2RjNqQThBejNET3NEcE5ocFZMcUVCdnhlTTh3MnBIT3V6SXNx?=
 =?utf-8?B?MDNWVnFSRjBKMkJ3eVlZaVo5TzYzeG5VdmI1NFBhaFR2VVZ5a0pzUnJxNlJO?=
 =?utf-8?B?bXN0MlV6ZmJRbWtpVmtDaG0wcnZXcHlFbkJJUkVERS9Jbms2OEVsYlFyVUFB?=
 =?utf-8?B?cG83VlhnSmNJSytNNzArbXBONndLN3RyZVRkR1NxNUtxSVhXZFdIT01RMHpI?=
 =?utf-8?B?V2JOK0tzTVV3NDdrbmVtbGRJZEZ5d1kvVjI5Z00raWxlS3ppa1kxOUNDMmk2?=
 =?utf-8?B?YmhlNFVUdUVIaExSSVQrdzV2SWFBUEJrNlM0ZG1QZ1hua2ZaV2xDaWcrYnls?=
 =?utf-8?B?YmlWNWZTaDlUUlpmQlpGYy9lRmJ3L3Fqa0cwWVphREVVcFcyeEorUFBQZC9M?=
 =?utf-8?B?NG92K212NTBoaHhhNHkyZzlQNDQ2L280K0IzaXJBdmdrMlhLWlp1M0xoaDhX?=
 =?utf-8?Q?gNN1OgNg83uyFWsZVrolCbHdN7KCxfYJ16TbKH7qz0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D93E0FA9A6F7B4EBDF32C3534FB340B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o0bn2XTWuJACf71JjnNEGxaLsDd+z+RYpMkwvaBpA3d/d74+bDtcn1YVDQcP0A3J4jGbOLjmIDSRYuh1yVuRVIBexgzIQPbn67FtIUcVqScHpsd38hhJr7Axa4OM4QfOu6hyiGHH/0bOR0ZpsUaRlPj5I1dlAZVxT7+nrVfNGCURC6vW6HKnezOQTwjUsl7b/kLieF30wrEINOhpJ8lAS0klD6suaLJAoZqTwsAwKT7JfASm8B3gbgeGSB6mJ7HuAoN+O9UC2uqa8C2jfyJaJ6jqASdaQ+07CdJoJCE4Owl7GKP+EXQjmUzxKCvyXYA//XQr5kjvSdybTL4FwiN6jlliHr/f9Zhg+WA58qnrvmYIPpUedysNG2Mc/oNeyRG+JjW5XJWc2qXjfOZHlKpB5v+B0ajoqaLmBzqJUuy1MfGc8+0kENZLppROjXrHFwcIeB3+GStmdp3FvMDVSVLI3Eleyd7aSMazawPlSOEoWttgFhlnKEkLhuF1wbDKZp0mYAKzivrLpwPW1MJh217VXfWZVZCcKH1gl2pzBcaQ1RxdZTTf95y/ijUOF/r8/fUYUHwxj7Ewf31EC8GQ2ZUHTM/DaSehuNRFYc1GhhSl8/zdtmUvqG5BOgVwU5Pz/Eip7p9JDNtmO+JLCZba2tZPU1vhY59cyamUpKzkuBc5Z354s31uYFXJkdp7TOze3/kpdr0JMNTBHpTCmkPQEU4BrZNhLhLAt/hbOP+nYtxQtouXmJznMW6aoNGUyTfo3ebfziFq1tOAcav3VmwSGKa8IwwXbAMjPVjBcCayrt62VwfaBd6T2nKe4GKBNucE2Rm+K+//Pk+paMtpNUQ3xnqQc/TJHSbmjG5F9gBxV5dJSNpILTAfFy4m2usk40iI8Z0e
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9c86bd-e3d8-4c44-a537-08db13291b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 09:59:07.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vr6qabJ68PAvVlM30hBTd4XmCAQ9tFVEPw8Y4ZIHSA3WnTKhNnLkark32kfg+/A112TGdZH8TQdSpPJld7A5tWIDI1K0Cx/+e5tf6U+grOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4275
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
