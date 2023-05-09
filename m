Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95736FBBDD
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjEIAMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIAMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:12:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632F91BDF
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683591133; x=1715127133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=SYLjXtOovTOkYlpq6EHkHgB51+VIt8W3wYHHQ/1mC7hGNY/PmgHOmsfz
   0Wdy40DOrXtCpz1nepkTpnOcAWCuY02X51lWLy+mkouYKoP7JcHH0OJEv
   6NN4UVrr6KJwFsqiCtyITlp+Psv0H5wuxm+5BYtUC7xav+13pSxNLq1eL
   xEb2rGS9mCY0LYbiUoUl6gyGZcVS/uicW5eXUDdbyIeNKxZthu8TBnlEm
   7YjNU6oUk/jo5V//Opyjd1f2eol+MsZZGRzjFs0yEtHW8277f8VRTCCvs
   tuI9IFjPNOAA382Y/OxZQOJYDEL8/VUT5GCLKEBPW4+/fHJwl+UJKeJiQ
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="230214687"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:12:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKGdLzIhNVKpu9JE4j4pJchsakqyQD5K9z1dx4fIbyjKtGwLKMHKuD8w0QWzzYfzAl1QyIBQFHZdxnx3lbXS1AZ+b2DVf2okle/HQ6Vva96XMXbYV66O1QDyGvLBHilKGw30GLJ51ZF23wLhhEWouNan+UnTuFF3kvo1rkFlB5TM9qVak0RTDN7+csqfJRD7sY7eZ8IgNh725zc3C1nAmsadMKDC583TYo9ezI37KBGV0L4F8ie91z7HmqZP2lso6c343Gxn9m0b3Uu2nSxTEP1r7Lh/LSKSJeP0N+w9XvQVVpOb6g7sNONVxoXv1kTRBl7RlCvCrgrN91ANDUSaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OifGkYQt07GvSNSYYOJg7lcW63n+fMQDX20nQZeVbI1dCNFpYs4nyXi99pjcKZYXSPaBPJqh/lChjLjnwgF/BoOG4Fklg8vmm4ibkAhnDKROeAkUbxytcTgOy5SxxA1FoFnhC3yD30vDSTAWaDcJngQ/VuSd6KhwvIUzRDL7nPNMGA7HH6ztbOo/gXUQDXmStpblZMNGG/LqX/Th2jjoHLK7P34hsOPjvwHCqSWpkDAFAThocKyAnQCmAgPyPboHmIt5DCWTJ0/2XloTokFsDNse4R3H6wYjFg/yeYS3fDa87vhW1z9QVw0lw80QzY/mEZXr8CMGUZEXS33PndhKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Lkeb117DHkHeMp7lLEWmsVjh1LDgBGUinZT50Cor+sxgiGSZ+Yi9WRHp7LLJFHIZQXF2ac8BzV9UUfOI+SpAJolbmWEZpWv9sbSIpPg1W5LXlnmvvWQQYU7mbTLF/xYajLv2vSuSPYP55jNIB4HXrwt1To8TpEcaVgQ7gNxGbcQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8093.namprd04.prod.outlook.com (2603:10b6:408:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:12:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:12:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/21] btrfs: add an ordered_extent pointer to struct
 btrfs_bio
Thread-Topic: [PATCH 12/21] btrfs: add an ordered_extent pointer to struct
 btrfs_bio
Thread-Index: AQHZgcdoWY+ZrkaaXkyHh4TLU9dKBq9Qix4AgACHHYA=
Date:   Tue, 9 May 2023 00:12:10 +0000
Message-ID: <8ec121ca-0b9d-d39a-2367-69b7692e0ab3@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-13-hch@lst.de>
In-Reply-To: <20230508160843.133013-13-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: aced47cc-196c-48aa-b640-08db50220868
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWHYozH/OKbEXIJYf9SknJe6kwFEgvwBbeR2IoVpeEozXZa+C4kCFlDCBO7DUI9wL/2CctzhHuz8HYC1HiLAyEl2NjyKzrZL7RS1feF6TTe/CMY7ApA2rF1+tRs3Xz7RTKBe5fllcR5T9jZQUkPdqppFI49wuzwtttOXbo61OCDoGvJTCa3nR3+M75mV4cym5mF7MIwTOi4hUOMjpQ5JptXmk3ydkLxfKuGa0A7lf0CrfSYaWEDV0bksxW8lLLqLy7QXUUKIphavwW/1QGYiy58bivJeEk935GTDvANft21IpL3qxL0dXdPXr1TYINgSaSFqyZDb9uDlOFvtaGsQcJhmtYEE0ZOg/xC16dlU7+awKswNSqLNqJkiUJ9+iNmJ0HEO87R3aPNBqqjYX85XasxihtnDTHiILVSTPyMEw/KkWyBaEVPrbkkii3tiPyuwYAzJu7BRnj/55xyOb7jLbePLjpMV7FXSDi3pT3OfYm48a7FYRpCy7cAlC5jeMwncqmr1obFFrTh0UsI4VlUAW3b1Z8E76s0yruwA3Gaj5BlpIht2EkTSfWZj+55KRWZHvNgQybxH3yGqUZsd0ksrlV1CDytSlRgfqDOrhoGa+o4g/SAZLOESLJoxz3JvAZLuG5OXOBHxbCZR7EAfHlWbjorvNg7VduXxi/+SWVyA+6NyN1WKOM0ecQCDQVrJd1qc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(66556008)(66476007)(64756008)(478600001)(76116006)(4326008)(110136005)(6486002)(66946007)(316002)(66446008)(86362001)(558084003)(36756003)(31696002)(26005)(6512007)(6506007)(2616005)(8936002)(41300700001)(2906002)(5660300002)(8676002)(19618925003)(82960400001)(38070700005)(186003)(4270600006)(38100700002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2V6RU8vTVI0aWZKQlJPNEw0blN4SXpCZ2ZuT25hR083eE84QXQyY09SVTVh?=
 =?utf-8?B?SUYyaXVUa0VpZmt5WmplSzRHMjlXeXd3c1QvdEJDYkhJK0UwdWtvckFObTJp?=
 =?utf-8?B?OGRPakFPWXJxQ2dETW1kS2h5UlNWUjU0MUJrN294Mm5Da0hGV05vZ2VPTy9R?=
 =?utf-8?B?cG95N1ZGeUJFckZRZmd4a2h1SjlPWlVtNHlHOVNrZlJjZjNLc0I2M0p5a3Vw?=
 =?utf-8?B?UXBDQjFwSVRJSDZLeWxJUDlpcEJkRmFYTlEvVFhXS3ZhaEwyZENEUEsyMkVw?=
 =?utf-8?B?Sk1wUGw1cFFTWG9hUjlFbG1UcnBXWmhudWFubWdFUXU5dHJxTWZPOTRmZmdp?=
 =?utf-8?B?V0UzS05PR3VoUHlBSGVQODRzZU95TEtpUWhBWkNvamhlM0VESGhINHJCZWc1?=
 =?utf-8?B?cHdwUExIdmVKT1BiYlRBL01jdDU1MURUWS9JWHBoc1pBelVRblVONndIV2FS?=
 =?utf-8?B?TnU0S3duSzNDZVR6cFNHMFlUb0ttN1NlWXNiQVNMT3N6bWlvNkpzTDRVN1Ex?=
 =?utf-8?B?Mjc1a3FXK2EwS0trdWhZU25QYTlscFdEL0UxTndORlU3Z3RQckJhR2FzL3NO?=
 =?utf-8?B?V2xZeWlwWHhjbU5kZnlKRUtXcmhNa2Z6SzFYZE1oQklvcENiVThZK0Rjb1NY?=
 =?utf-8?B?YU5FbUh2TXorZTExdjEwNHduMGQvWnFkTUdkMGwra1pVV21aOHJrcWtSVzZk?=
 =?utf-8?B?VDYxSnFERWk2YVNWOWI1Y2MyVnpJcWMzS0dKeVIvVFowdnpkamdFYklodjlZ?=
 =?utf-8?B?TFhhR2tpM1JVUVBMM1ZVd1U5T2d2ZVNBYTdhaEVEdmY0ZUlHVk11R3BPdjBY?=
 =?utf-8?B?M1RQT2h4cStkRFdpNmlBRjhwWi9TKzkvQnVXTXJGa2Q1M3hsOTZpeHZ3Mi9y?=
 =?utf-8?B?ZzY4NFVycktjTnNjN0F5S0ZHWC9oZ0VPdVVNY2NJUC9kRXQxUWd2d1BqOHUr?=
 =?utf-8?B?OXFlcUFwVTRHRjJqb0pmYWthRnBETFlCT2g4cjNjREFKNWdydG1NUENrQ2w3?=
 =?utf-8?B?bnhTeVJqQnZwRHRHU0UwSSsxSHJaeGVlckFIUVl2TjE3blFrU1REMmVla3pl?=
 =?utf-8?B?OHUzc0hxUXZYekhLRmFUNUg3YTRPMk5tVjIwUVpxN3JuRVR2b1BjYXNha0hH?=
 =?utf-8?B?aFhvYWJYRWpwSm5wY3JNSXp2djZVVkh6MWJCNStnMXpQcXdZOXhKV202dGJB?=
 =?utf-8?B?bFFscHpqZmk4YWtNNDQvSzdSUFQveW1WQllBeUloWEdXZGE5MEhuOEUvYmQx?=
 =?utf-8?B?WnlpQlRYbU14MTdLSWdiakd3NzRYRURoT0Vlb3A1Qklzb3N5YW1TT1R1aE1n?=
 =?utf-8?B?VU5OeFNWMm5LZlo1dlAzMW4waEU4ODV5eThsWWJlTlgrNDludWlhNThQcTZJ?=
 =?utf-8?B?ajN0dzk3VHBPUzB2TFNxMEJjaGFhTlB6YTdqZm54NjQ2MFp4Z3pjOFZiMXFX?=
 =?utf-8?B?N3ZqUkZOSnduL2RVTzhPZUxUUlFPMjIxUm5XSXhaSkoxUFFQVGZBMCs4bVBG?=
 =?utf-8?B?NjFwcFNkRFgyZGpFLzZveVlidktGZHhqZ3c0VTBsL1ZwSWd5MUk2azhwcEZ3?=
 =?utf-8?B?QUpieUNnNmU5SG9ENTVUNTAzY0hDSWY5T0tOUjQ3eU4zd0V6bmpjTnlkN055?=
 =?utf-8?B?bjRrOWJmbWFkaWdmRUs0VWtZRVRUMEw2V1JoQ0hVU2tUSDcvdEV0ZTJXTGRa?=
 =?utf-8?B?Nk5DSDhMcGI4M0lQSEdmNjlsSGloaFF4Vy9Xb0FHdjVpZ0x5VVovN2J5aWFa?=
 =?utf-8?B?eHhzMnJ4UncxQzlscnYwTHRhU3ZOakdkRXJhQXFMMjBvVjQ3azN4bXZvSGJL?=
 =?utf-8?B?blpOaG1BUm5ETUlsQWcydkNTRmRTZVhlNXBBd2h4MnB5a0U4Yy82WUJhWkJn?=
 =?utf-8?B?MVgyZS9ZZlB4clIzSVE2UXRUZFZvTThVeGd0bUdNYVRRYlBLQzY5UmF4M1Nq?=
 =?utf-8?B?RjZmcnlpVTJySVJCRkVaSkdicUtlMWo4LzA5YzUyUzBSckVJYmY1YVNobmF3?=
 =?utf-8?B?Q29qN0hHUVZna1ZnTUZZTHNQL3lOdVBwNnlhK1I4SU56K3RFeW8yamVjWUdI?=
 =?utf-8?B?TUdURm5NTWV5SDA0THd5UE0yNzZPYlJUSk0vaXdRb1MwREcwWHV3UEQvNXdH?=
 =?utf-8?B?blFTb1R2MVVvTzU2cEhtZHZEOUo4QUszSDQrQXhQdmRTSDZBems2Q0RCOUll?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADBA15A9D7947141B83C4C4B85D0A4E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K0WYAF0pYqLyQeYFKUUNXQ/6CHklxOgUX7ef6Oh6r4SvfrD6ckDVKK1feWMD3zhAIGLlNviVXiW6+cg+DwIOC/LM515jlthRYQBhwGDQXPL3POHsbkeQ8TJ8dTuIFZ/YOqbQesiBGV1gMpHaJXhg+YWejnD7cY2EhHS33jLCZJIOYATAAp41q0KcAZEQd9UyUpp6UOZf+XKKtu5hhXiwKGXz6LOfjU8HmrzCIEvDOPcST8hCtOMESP6rTK6ogiWgxUbZksgYHCR/5eOCeeDw2bzUqcpN6LpL9zbhOw4QcvVsPDTYxFvKigxicDDoJwcPsYAz2RvxLYtrg2vvmrSVNdX3OM6yLCixFAl4yAsmlT2lg/AtgYnmw+rwdPyzcklTWhNVWo2c32gUWd5mFFzr8/5muGjf6qchr7ynBE1CjIFYFIHuj5zUPyqT288N91Au6U6F0D6w1t17+LcsLGb32OGWydTnwLFJhXUCyYBC+RTJSr13iZcqwAt6aaQGWVpL7yeC1hPI+UP3L+lqWeDWdxVfNdmz3gA0oNJAeRyicynx7iiO5sLaFQI84P6iQfoCtC3+nImtT01abSUmNB5pquIDVQzGNIgw/ml63dKYXeqU9xcIfUV1/hP77vNaQAzPxkCDb6WMH7oQd+V5on6zwCchmVQ2JqXFC8RJtNuJwowG4oUy51dVWrqNt2wH9JQl41gTv/atgFR+qRKZx6r/JhuviFgh1/5uuCJQxgssUqUsZJQca0qJh5UlY5Q0jf7ViiDRJblmd3JbF2RtRFbccuVeervih33w4Ob6G7Keh8yFdqm5rmpJb2cPJmWIq7L8xgELqvl9DB6XA4t8Ey/qbfRyIZeUfpXQTFVi0JWyyvlabI0xJ28zSndBzP+AkrlI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aced47cc-196c-48aa-b640-08db50220868
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:12:10.3132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yS/vHGuSBcuu3QP5eIbyh+/PDbCqTbIX+6zpbW5Vey1FIDZUcTlVRurXIddbM0rcdPhG0ViTHvm2lMgY3rEPPRTTmW/WDr47W5QR2+9qcUQ=
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
