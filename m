Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04506FBBA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 01:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjEHXzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 19:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjEHXze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 19:55:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6C34ED3
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 16:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683590130; x=1715126130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gp1x/St2MDUGyF0y+E+C4XgEMEGqq5xw++2vIIYevcQ=;
  b=Wv94dP/n+mYmEVcjnfz53VBmc8fnOQuwYL+ltKL2nWtqodskNIV0ThXH
   MQe6rznAbn6U1MH0G19esVmISzQ1PhjFy9+Qg6NfxIrnowffvbjvhascV
   QvFyQpICcJhub3cPfVCaVoDNpmfr2GWdMJMUqLSPIwmBY2GhWy5+JNphg
   6/hYYBHto3pNiuRmHU3t6vRTl0MJ4qRcF1nTisdbgWz03E36bTMT7vwNf
   ngtFjmRmUqsed6EK6Tm7pT8Qab2YVn55X9QpUpy9J/qQJ3Y1nNYXjdg0T
   SLdlQuyazir2iVdHJvbcI0OJQUo1NM/LsolVVllkQEhQfueA/2OtV1Ip/
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="230213302"
Received: from mail-sn1nam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 07:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY/FMi+jKtX0lcTjpa6K4+sixU9gyqDjSYwhyJyVLS9Ad7DwPcC+SMihTXdQOf3B+ja7jsHL4EU+UOJmMd1n6XXO6jFyGstgDmGp9olIASNiJT4qK4XFLtlHjfO+WEWgaXR78JJRfDekqmDHp26POzxpqaV3bRfggn/zoyn+ha0hB4WbLBLLUczriLQQ5lYDXhSdcoNGbY8Ho1vrUAzKHkQ6Mzl5NBIhXfoIKH2t3u2XlcdQS16gpVO0RhbnnsQ/RfZc0+2HmnUjRfYr/fl7Zo1NVE8n/XD1nbCHq8AhP2rvGNuALEzneTalzodTDOnCHVQu3asVqfI2Xdnm/Yi85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp1x/St2MDUGyF0y+E+C4XgEMEGqq5xw++2vIIYevcQ=;
 b=R20B3GLeuiq6eV/XSRmMSWBVeiCVLnt0Lfnklg027sNJQBluzUa9ZspB0rZhlaKlq92ce98FLhvxswyVtzCHwBvV6V3Oq4502OH+t3pVroIRi09+dY+tSwtNo/k2Q3HzdVncrmOJsZGKEeA70u5DIFR3QUWBE2WhT9kCt/+JWHwDXAIyPfHQbacoLOSU4VEmcn5rh+yKBrn1eRAk/4UvWlXDR2VOYagcbZQZuDhlV9K0QShGbhQdX5A9y2NpKRhvGX6y46gxCtHNlx4ufsKgJZWxElVapecrEQQazBZl3qIO6i6pGZJZDqlwUbANhshLPGwqatzGik3prX3TQATo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp1x/St2MDUGyF0y+E+C4XgEMEGqq5xw++2vIIYevcQ=;
 b=su2sg99c0CEY6PRCmo94WUX3xR0yAN7VMKp5dDu+fh9ZYBEXhphooX/fcwvUQr6iAsmozzkdaJHB8aKGPuZBa+KHvqQi8goxmrKpHI7YzmGYfqhUsy+C9OVVTPXK+4qnhEUL8bZlhe83xkvwvLBdjanESRvPyBmxZwo0XFKdOkg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7058.namprd04.prod.outlook.com (2603:10b6:a03:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Mon, 8 May
 2023 23:55:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 23:55:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/21] btrfs: remove btrfs_add_ordered_extent
Thread-Topic: [PATCH 09/21] btrfs: remove btrfs_add_ordered_extent
Thread-Index: AQHZgcdyqXnVlkNgaUyRq1XlPNQCM69RDY8A
Date:   Mon, 8 May 2023 23:55:26 +0000
Message-ID: <542a2e16-1668-edf4-91a7-cc356874de11@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-10-hch@lst.de>
In-Reply-To: <20230508160843.133013-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7058:EE_
x-ms-office365-filtering-correlation-id: 420137e0-e7a6-4321-f69a-08db501fb24f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFEMDg5ONoz17OzmG0KnFTQ2Lul8Fp1EnQLNjJEjm4VEFUGy1dYRwbTfrbgn8ExcFCXltPnNLittefgH/jyrq/mqBZfqCZ2L2MQlvebsbWyDbF5NCxYgUl26d3NPaZABKgVwf3GjuvFJYk93/Zq9+MeCGL77xF2/cx2o5Pl1XXrAsXpDclU6vksdgXrA8OLJ3aAdm6iWdhUsNxKdtoyjOMxfYXTBBtNPHzvYJEl0U7Ij3KidJxufi18BMiM/wS4+mC3+X82P6DfN2+1jWwxF8QcZvgUIvQgTa8oogsFiMvEEIpHSkMZPNGEkB12N3Ox1V1IJIM6wuM/EnA10iMVAQxidCahov51DCw7MwjElqu7V831J58+xvbVFmSeRBxHEPIXiURZwyn7FkSfn7JqtdACzVOXOsiyFKAeeQLQHYyk1IDj6B+29jgXnKzS0OfPSZJl8Z6Wyumc1tWh82V+pE/vmnaWX82aqkQ+zq89OXnjsX7cJBm7eyf9wcDKKFekqQnxVuMCL+C8cV/PFnucGkYdoEJhdTWcIBRabAm4a2DiBdYxphJyqMKH+SLSN8B4qaQk4QXDz5frFj5spBuMQijdv8jBklgS2TCGqJqzwoMEtYInDLvo1MpHCV4fqmEhnaOt6X6Usep1J1LRkqNUmaa7DOkyPiLbC+lP5hTq7UtkC/FTuWqC44cjaoHHkArJ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(8936002)(8676002)(478600001)(6486002)(110136005)(41300700001)(71200400001)(316002)(5660300002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(31686004)(76116006)(86362001)(2906002)(186003)(31696002)(558084003)(26005)(6506007)(6512007)(38070700005)(38100700002)(4270600006)(82960400001)(36756003)(19618925003)(122000001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEhzM3lxczBTaVlPbUY1STdabS8zL1ZBTXc3dEtPanRHUWpJcTdvU0hOejRv?=
 =?utf-8?B?ZVpreXQ5WTgvRURnaXFnWk1ieC91WFJ2Y0FKQnBESmtzd3FYTEd4LzZUK2FV?=
 =?utf-8?B?dTdVR1gvVGphejRrK1o0c3NXOEY2Q3VqODFRNnJDTkRZb3RMTkRQZWZnZ0c5?=
 =?utf-8?B?d0xGY2ZGRXZHNTBFZ0xWbFVocTVFbmI1UTNPRjVDTlVVUlpFNGh3ZUp4aGtR?=
 =?utf-8?B?SUpWYldPTGlQUlNjS2VnUDhYc2djT3hCcVUvTmtMSUkzb1YzUFRQeFV3QWYv?=
 =?utf-8?B?SDh0Y0tDb1NPMTJrbEJVZzBrcitQTEhWVExNMld0Z0gwZ1UwV3lWUVAyaWdM?=
 =?utf-8?B?cFJZN05kcXJhV2VjaldNQ2JDSkZUc1dqWUcySUFvaGF6cW9DVjdZQy9SdGw5?=
 =?utf-8?B?VVo0TUlsV21mN3lhOW4wL1pkNXB4TktOMk5KOGJ6MnFoL1hLS3VnZC80M2F1?=
 =?utf-8?B?QzJvZlFZRXZSSHRMZlBydnY3bmNnd055TW1BQkkrTDE0YVZOYy8waEx4Zk9j?=
 =?utf-8?B?SVk4WmxjRUhwSit6R2doU2VweTgwK2oxZ0NCZzRVOE1yNTh6b2dFOEhGSU1q?=
 =?utf-8?B?K3ZBcTBrWmxXNUxSdjdJYUlnNmd1ZldnNzloTm5qSHcvdXUwUW1zNjlRWWtX?=
 =?utf-8?B?eW9YMnh1a0l3MTE0NWs4TjYzZU9iZno4WmdZc1MvN2NNbGs2dCthcE8vUEg2?=
 =?utf-8?B?RUVBUFVpcnQ5T3ExakdobERhV0tlUHFlOS9JV1dLZ3U1dGQvZUFFdHJ5Vm02?=
 =?utf-8?B?THUzam1OWXVuQ1cyMXdMNW9yQUpWblFaeEo5ZnhFTWVHQWplNm9nYkZtWVJh?=
 =?utf-8?B?Rm5wRE5hS1dzZ25tcWhhMkJ5dng5Q1ByOFNLMWpOVEFWYkF4dUFma3ZkRk04?=
 =?utf-8?B?WHZ5dW8zWHZqaWJEOHA0SGRHSG1TMmxiY3ZIbnhmcGtEZSsvYVh3Y1dkSWxh?=
 =?utf-8?B?VDhDUVhoU3pIQ3Y2WDh0SXpaRExaZDM3SUxCNUhjbUgrRkRLRmxzQlNCTXVr?=
 =?utf-8?B?RDJXNHNPMUloa0JUSEdReVNxQ3NaQXdWc3hQbGxRODlOcjVpTzNRYU1vSVV0?=
 =?utf-8?B?T291QVZmZmJtU0N0VEZHL1JITG1HMTV6N1RQN1JtVUpOaEZCRisrVCt4Zm1P?=
 =?utf-8?B?MldVNDlCVklEcCtGeWNIRFB4YSs5SlNuYkVNV25IcWZUTFFyTXllRTB5eXdC?=
 =?utf-8?B?cVhORHQ4bFlDaENjQzVPejJBckRPNlR6SStiQW54WlhuL1BISTZJR0FKZExv?=
 =?utf-8?B?VmZsVVVUZDY0WmpaWGxsUjJ1L3RLSm5LOTBjWGtIblVyUUVncFpzNnBXT01P?=
 =?utf-8?B?UzhlQXM4bFdNTmJDNFRmYURodDhwY2ZlcVdwNkRLSUtCN3pKSjhUQ3UyMjhN?=
 =?utf-8?B?ZHBYS1R4RkZlYndxV095MHV4ZGNiZ1ZrNVhCenNNQjVLWlpoOEhlRk1LVFZy?=
 =?utf-8?B?MHl6ZkJlQXRodzd4NHJsaS9PU3VuQzM3a2NZamx5dXVYTkk3bVZlNVBrV2I5?=
 =?utf-8?B?UTN2c3lBdEJOdDZzVVlFamRDVDJsVGMydGdubS9hM203UlE0V0ZGTExoeGhl?=
 =?utf-8?B?K1p1bTk2ZHU1SFNjMjJwKy9uVWk3OGNhRXRuOUdBbnhGWFJnK045SFdyNThk?=
 =?utf-8?B?dmQ3a0E3Q3h6ZUhxZ2lPQUdjdExuSjZjRkJqbWN4ODRrTFFXZUViUENWcThk?=
 =?utf-8?B?dmZIa2Y1b0FKQ0VaazZRdHUxb2xvMnA4NEdUNlhsSVdJSUdIWlJTdjNGNjRv?=
 =?utf-8?B?a1pCZmtCakl1NnFPY3VQZzhUeXNVZ2FFa2tXbU1SdC82aDFYUU4rS0daYjl6?=
 =?utf-8?B?dzYvQWRoRW1UcVNuWjRTMk9QWUEyWmU3ZUdiWVNEcmlWZlp4VXFhcktJc2JB?=
 =?utf-8?B?NERlZmd4RWpjV3l6MXMzMDRsZ2RoUXI1SHhaRjJ6aFdYT3FVVlJrOFhFNFIz?=
 =?utf-8?B?bG1GMm1PdGszdmpzR2RtZkVvMWJ3QTdBbHhkc0NpaWlSU1ViSTJ1ZVF6aTBr?=
 =?utf-8?B?OFJjMWFpYkdSY2tNNGczRkZaR0tWLzhwOG5ic09nN05kQkphelVmdVlzNmZB?=
 =?utf-8?B?dWZwVXAyVEY1dmZGSWhKWVVWS2cwNG11WWVTVWRlT1BxZ09uc0VmVHY2MEhp?=
 =?utf-8?B?VzZhdWw3c3dGMXloVFk2TG9rL3lmNlVMdzMxRE8veTJ0TU82QnlVTGhMdzcy?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58CC13129372D142BD5C44BEA454E8BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kzjUlWIkrcO+8kAa6DToqEsP/Jotj6kb3dD06hO7jT629/lw/DZXwQESGFFmYRn/Q5JNjHc8yYUViMnSfLz0BuL85QYkmCKhwFvM4BXzhacNz6mPn36McfNxMWRYvJITRyyoSGi9D7OXoxkEwiIgSTrClgw5O2KySdPUPSbtriMUFynmJZMgzfBY+gk4+4IOMxN8lELD0z2HoY2fIBT9JNkNB1FxHgsZJv6M+FHUoVttvpqXiTzVLVxNOkgHmtl8xt83CoM60MYCa4JZjXQBrsmQhhf9LcGEILUgIk5PvZWbD1saUdM3DSKV2IdnyZIuzJP/URTl5Kfx0tdEBhD37kOTY/TerEJCbyt7Qdfmsr83ij1NmscBrfYRL+nMlYdL+Sy2zmzagK+k2JiyD8FA6GWepL1Ay+wRZ2xo0bthDoaMqAAnEQzoHko5kFTHnhrpaU5hQf6KdM35E7PI0Mg8QmXz5kKH4r3HrANItHGg/pumAvtbKZLVYD7GFsAGGdrRe4UH9TWY+Od8ZSH/mBTTvbE2uhq7M/UA9Y3upnTc+U9+YZgDwdbBIoJCae5ABy662ZBKVjeWVSOhvzg03/N874RJ72bVv1asUmL4gl2KBMB79/8WBusCIeS64/kyZEV7/anJ5XRs5Y5qOCQFhBQOBXertpOL+ROrL633rVaH8SQyij1KtsDG+w8nLaCDZsyK9YhRfMhJnJgTHbCbsXngEnMRnMsGAaAPwGgOLZaTOPeyaakP2dnnl17B8QZgxnYJAjVoW/Ljwm9/rxDRFT/38JQVkbeYLJodK1HBoEw9UkckRsZBwGxDyJEvZpgUdzlFcbgNgkmXwaZ+mgU0rJYH+0wRyQ3vlEurw8ntujekAKdUqst8hfmu0saKFjcTBceU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420137e0-e7a6-4321-f69a-08db501fb24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 23:55:26.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXRPeqqUJVQX3+NmItSbojTyp85/D7Igj3gStuADaEKDucVj0Fy2kqpMmDv2sk/QjQpRwNFDGrjwGYyzRUTu08Iwzk8/Y5H9q7mgEv7V2LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7058
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

R29vZCByaWRkYW5jZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVz
LnRodW1zaGlybkB3ZGMuY29tPg0K
