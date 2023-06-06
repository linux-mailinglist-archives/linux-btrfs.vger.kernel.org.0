Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36FD7240EC
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 13:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjFFLcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 07:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjFFLcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 07:32:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C09F4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686051160; x=1717587160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=PUYjTQ+EjqkPDCTZlu7mzdfiGNVS4sBVRurLwzRpEZV0jHVSh7W+BIkk
   L/GI/z0yojfAnNir/KLRp6J1txzMj9S6rj3IP0RflU7PjO6HF0ifti7th
   WtJAKwhdvKKxkYPdCFmoBNP4M5trFMXuA5K8jI+4VQoVRDgk5UKjNjSYC
   wzWvPkmGQLiRZBqskz5djRUfZamvZWFg+zFnz8EQkgyYlXui6YFVMILlv
   6KtFPTtS/RglxduiFNMIl2gSTHytwFKwkMLcggOFUJb1ruAR7iommxldN
   KA+uinsPOl5MBvVWQdWmeqX03D+K4NX5UBOn91hPJGtsOk30jCqkacaCU
   g==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681142400"; 
   d="scan'208";a="232659815"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 19:32:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoN3fd6dPwR51/xvHpr9f+Jz8+vCjZLJDgJlk/bLi4eb51xW5FixIUl4cpKXwtw8TR0BY3kcFIc/Lm1z7KJD61tfL1nnhZs7y6obStkjr3vhrYPNJavua9l62yotafSaKaRwQBQoczMINn0Yj4ArPO5E0BFLP5q5V3cXeOYQPW1DBym4V8UAHeVtr7oq5PAOlZwFRcrSu7/suDfQx1FwNToaR+k9K4RFjdtlfKmii6g4NZTlvK6IEjuDj25Dk6zyT5Jlq6g6xWGePouvFlmHEe+UYGDfNDbpDb8egowPBkNzIJHbEBVR1X7PxjPKVoNxWujYS7TtJ3ZPHsyujKgR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=O40YQ94m+0wmSnoZ8H94UotbfDJdNwSAJ/i2A9PQa/h3ugZUXdZMXKvzp8UZAuYUKmQ5lVu4pR8FNP9Y/h20gggJjZWmxd5QPM6A78/dwNZaOgEi8IAUZWkBqxWQRz6+DEfiOxnJ0RA4H/5X7+sfejbE+Ol+mYqchNdBj2lRVRMn7iUgDiMxX+4yNL4pFBnEEEMiIVBL2bq5qSXpizZAT/+QxxQWKHNp3sDvIFXHetRW133FXI5+Bd4C91jDwWK7ju7vxPmvnW6u+KU18O1L+Q3a44BV1RF8hP8EpbShdLx4GysxNYtP/EdQnV+Ql1eqzIuHeQ6YMC6Z4wh8FTiDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tT9pnyfpGbi1AgXzEweRUAw0UfVdT+8O9UIDiS3dGeDU7QqWmYEyhsSOfmcRSgbLYfC0EA62rkF4/AfqrEJWrUEmu5YwDYCOrmRjC9NCvGtneOzQAHrBgvhM3TcXtfYk5xprNW3GLO9hVqVOQN7G5aZeSW+f8zmKjSUzxwVEWC4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB8598.namprd04.prod.outlook.com (2603:10b6:8:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:32:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:32:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <naota@elisp.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 1/4] btrfs: delete unused BGs while reclaiming BGs
Thread-Topic: [PATCH 1/4] btrfs: delete unused BGs while reclaiming BGs
Thread-Index: AQHZmDjxtUVW3J35Nk6r6PjoqUf4BK99pL0A
Date:   Tue, 6 Jun 2023 11:32:36 +0000
Message-ID: <1eb5cc11-eb8b-7f34-4c8f-529c63b35ca9@wdc.com>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
In-Reply-To: <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB8598:EE_
x-ms-office365-filtering-correlation-id: 96d9ea7d-3ebf-4bbd-7ebf-08db6681ba99
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJAsv2yRIBvsAy7kU7Q32/CwNW5C1Nq6L69a7lE0IEbjr4rhyirBsO7RLFTNgvdtvNvF3qHbpZmATUsGmYb1EC3xkOG3YupakisxfEEC6HfMWCCATLRzgNQZ5yFvSVgPOAz33PTuMIG30+F5jkK/QkZolo/xWxfxjxQ2xT6ah8PRyuyDBpwW9gYHPA8FN5A5ypUeiLU69u2Ai0b5mPIbRhuTQJ8E0FTdqPDl6q/udiu48M7lr26RfX5IREiGcZviEL0pbu3nOfzYpVSHfrUs37SG6li+NKCdp7GLk6e2yADDD39DP+S+GboGzjmJ7ZJLLm3DxLR4wAjlZxWD3pZbVyFYMtHAUAGOhD5PL2AxR3E8O7OTcEOCPNR5oeLj8wn+oE6HrycUNmg0faloHlDXSB3IcKzqpLTTylXpDOdKuT4fvCIx348Cr7YdyACn5UHww8MawjrjBMlsnq44j7W3GnhmmUJ1QEP1x3P/q1kg2PoEnzZLdQG087vhMDGE7MGD/Vzveoo/PSjAbpfngKbm/konIyxdXlcfr2Zk8S3NJkyashvS7m3hvwxEDe+4kWoB/5thXee/uAYB39i03MNkCAuMy76oiVwMxZHFBU7RbS6tDwaiYsVd3PjWIiKXrjpXQysScztCmYwXISIbvjkO9WhhbEEHRraa9y0hHSoGok7E9sRGCwC+4oSvjDz4X4kr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(478600001)(2906002)(6486002)(71200400001)(36756003)(19618925003)(558084003)(2616005)(38070700005)(6506007)(4270600006)(86362001)(26005)(31696002)(186003)(122000001)(82960400001)(38100700002)(6512007)(110136005)(316002)(5660300002)(31686004)(8676002)(8936002)(66946007)(91956017)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHYvUDhnSk12OXkvcFdzL3o4WFF4M0d4OGdrbklncnRhMzcreGVVOEdKcmtV?=
 =?utf-8?B?aTVvR29EU01VdU5JREh3dXJ2V1RBN0swOXhvZ2ZMN2JZOC9JdU9RT0lGRGVt?=
 =?utf-8?B?Y3NpT3I4VUJFR0JoczFkcVQxMVdKR3RHdHhGT3BINVYrK0dCV2hBM1RlTGQr?=
 =?utf-8?B?UDlNNzRmSWNRdHBlL1RvWWtickY0UzdIUlRSWUNOeU91eXZFZ1paMUdnci95?=
 =?utf-8?B?aFNTOEViWitTWTlCU0ljRFlicXdpNGFjaUN6eG9yemxmcTA5TFo4QVBkR1R0?=
 =?utf-8?B?WnozcGlmKzNXYWpJa0pSV3pGN0hYWkJ5eG1XbUJqcWpOVWVFYXhQeGVBK3ZC?=
 =?utf-8?B?RjFPelRFZEJxQU1NMG1WU2cvOVM1THJUK1lEUEUwMDhtVGVHbjBkbFZaNmFp?=
 =?utf-8?B?Nk95aGM0Q0piTllRK2xNZDRFU3RQSGtpTmpkMUtuaWVlYlkwSzdWbk0zM2JV?=
 =?utf-8?B?bDVnMFBBQ3VTdDJRMGk5TEg0SnlXdkhJNGZmczdCOWttb1pNWk9MbFU1bWha?=
 =?utf-8?B?Y2tic1VQUTV2OHlJNC9RZUx0YVh3QXhGS2VHM3B4WHkrM1JZWHRyNnhISXpk?=
 =?utf-8?B?azhaL29mVk9XYUN4MWFSbW85SExPU0NPaXhYU3BrR3hidkdzSWZ3bkRTWTZK?=
 =?utf-8?B?bHNselhXMlRYRTBOZG4vMXZwWDNBWnFtRi9qalRPaDAvUVd6OXBFS1o2Nklz?=
 =?utf-8?B?TkFvSm1YZTl4YUR0b3pnQ0szUUpMQkxQQXQ0VWIrSUU3TWhSYndlZHEzdU1l?=
 =?utf-8?B?bDE5WnZLVlFkaSttdEpubXBibGhiMjhmSmFyc09xRFJxSHUzeThIRGVlUnRa?=
 =?utf-8?B?cC9QbFFaQjVGR01WY2lqMndDcU05N2xoTWtNWXJZbzBweVNVVmZtQmhycXVx?=
 =?utf-8?B?U2s3Smw3WnNiOGZsdzgyR1h3Vmpyajh6Mm4yNVlkem0waG02bExPdXhOSEt4?=
 =?utf-8?B?aHIxQVV2V0tTdXRnQTVOWkliUzZVVTgwQlJqSGhWRnNYeTdZVktqeU93RXFZ?=
 =?utf-8?B?Q2RXcU1aOUo5ZkxkYXVaYm9Ydkk0V2E4SkdnQXRYcjJJVEkrbWhWdGpxTGhK?=
 =?utf-8?B?S0d2a0VzdmFuUGJQME94Rit1eXRmYWJWNzVOVUp2bjVFNVowT3RBSTNDT0s2?=
 =?utf-8?B?USsrSjdzSHdoNDNVMEJwVTcyKzQwRFU3VUFUelZBNURyNnl0UlFWbmlOa2NJ?=
 =?utf-8?B?bkdIY2wzTFlhTG0vendzK3BTY2dWeUZwTGpSa1ZPaUlmZzQyOFJNRUpDbGZE?=
 =?utf-8?B?OEk4UnpuZ0ZrUjFrSzBEQmxSMmpIRElLT2U1WjQzUjdwSWVybXV0NEdMdE5D?=
 =?utf-8?B?ZDU4aHcwNHZtWHBqZk9uc3hUNHcxVWs3aHhBZkp0YnBlUXhuM2ZLclBLSERn?=
 =?utf-8?B?ZVhkeHBrTEtTa01kd05RWlhwQS95VDg2S1FBSHFNTUtoL25WRTlpZnZTZHlR?=
 =?utf-8?B?T0YvK0xmM1FYbUc3YTFBS1hpdTZkZnlRMy93eVhMaVhnWXdjZ2RnT1BjTHlh?=
 =?utf-8?B?LzdaWTVnQTAydXlOY0RVSDg5ck5lWXloTUJhK1lUSmhQWE94RGdibHJwMmtW?=
 =?utf-8?B?emtHOXJrcU9sSUVUTThYN2MxbUlZVEprOGJWYjFkUWt2blVtZGMxV3Fpcm1h?=
 =?utf-8?B?M01wL0lTdXp3RjU0Y3RLK0JVZDhlZVUzK0NoeXgzTzJVQmF2Nk1acDNOR1hV?=
 =?utf-8?B?UXQrY1FuYVV6UndBNlkxN1djUkdpOHRmNXJjVDM5YUhnQk51aThyL1kwM1Iv?=
 =?utf-8?B?UENsWHZoSWpqUXNOZnUycDBTODNxdWhuSXhpY1V6VGtmNnRVeTFxNmc1aGQ2?=
 =?utf-8?B?aVVYQ09wOFFHUTFDVWtLQURwNDNmOGR5TXkyL2FqZGxqNjFjMndJaGpLVllT?=
 =?utf-8?B?VzF6bFlJb0JYOG5UYXBZR1Q3eGx5ZVF3UlYwdkt0cDlpVWlzL2JYMHlxUGlP?=
 =?utf-8?B?THVTWEhnWnFVbGtxQVpEMWNNU1AvRytESkNQcFZ2RmFtSEdtZU1yOEVOalpa?=
 =?utf-8?B?VGJoMGliT2tPbU5TWEFLVXFsMDBqbWtETnJjeENGZGMySlB1Ulc3cUphNkhj?=
 =?utf-8?B?T09aMXBqcm41b3VZOTNnRS9xdzBOcklMc3oybFlCRU1kcm4ycTEzMWJCU21n?=
 =?utf-8?B?QnZVVlNjNlJPQVRtQlV0TnhNUml5Y2hEU3JLQ2NJWUFidHIvUUNEYTZVbDdB?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <924FDF86F1F0A949A58BC3EE1A1D4558@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Rk4HPt6Zx0ikSL0gKXubnRxMJvGrANKl+bo3bxD8TDRVs5t2aU18wfe56yYUkWCPeTvker9lrQRZRi1Vipy+DkYr93IysmEg7MJdGVnPxA9BO3YaY9kbwSqpIYx+8NXpqqpTU6+MpgLYbe1pQgEHKExwFlCIALNynupDOv8u5NahO2PJjHtdRVqK6YU4AjufN6fus1diNaJZE8kqb8tkAD5H8zIvvnx4I8ejB27vqTwa3uxKsx6Sn3cFYOMCnN48cL+U4F6dvG106wUmNtuqAP5ZroyMdnLlRWGJ/3fwB9sZL6RQaUMwSaOOT+0jyG0XsP5OajgeNOpqtITEpjsg/g/eGC9O0aRYB17sP3HF5fiuNDlOrfoEUlmSN8NDUF6hgCWsHiILJhqCdJS0JKzYtxMqHoP3CeSgP0iA2fvQ//vSQgBd2zy8GssFjRf0T50aXXQiY4ySiK+5dIJtWlAZaqtuRq0BuvizPWfZChNKILNgTEzsL1np4aUuOg9FyfD3n2vkhb/EK+2Fj41kLlsMG8QSPB//FzQ361OM0WrnE/VrgUngG72vD8ezylsvUV0dNjg1MgrqLKPKXtvEY8P+02Kb8qcTgkc+7PQ1rd94pR11kiHVatASLaGdME6iYinvlHmr3prQPA+AZ+o5KhU+vk2FDEV1tmYcelUZrvca0ijdewVRoUHOPLnJKiRApOceVVoLat1FH3HI6aFrcG4SU2JlXQQk4AnKx7F3yJw3ZNoCYmzIoGm5r1mZfJ4sZSkOfomB7hh+u78xOHssl9RK4blP2HH5HPOIQbpmdtm/ztxPXstYTjkQkCGAASyt09x
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d9ea7d-3ebf-4bbd-7ebf-08db6681ba99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:32:37.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAXgA6oV29z045I+IWw/z2kVxc0PSLIKYYw1F+dVLaHoaRaHdtsHiD0a048ljfTBuHKYAiyqhmeFAweGaNBUlfmG1VGmbZT4LRTgf/Zul1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8598
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
