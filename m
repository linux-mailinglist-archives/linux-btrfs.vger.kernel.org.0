Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B8E6C316F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCUMUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCUMT1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:19:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C748B303CC
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679401166; x=1710937166;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=czMA8nIbbs8pPkzj7SmuxhFQC7s7gKidHVFqidu5Fr2J5PovZ0gcF6bf
   6y0JwwR2TC71G/t+90JP93vA23QnVZdzZrBO3glG4wGq02pwkeVh/s6LK
   KPH5KP3fzYZmGu1rINPaxx/TebIsfDQ1Yb83nFcX3bfnFZkARcKjdcYWu
   lp9LtZPGoHjemU5/TO+zyJTHNE5SwNOKnzHMKz4Grmqq1gDsj2CNVHpic
   ZhD1hqMaWzpMLAGmi/PE/vBDX9pQU/+Xiz2zBFzvJISl23jdBYO+YwIYL
   Mpg4N/SSKdqgPfm0YqguBKrBW+4vVxOFaWdkjWig8B24MbM2/7O9Yg8nJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="231102921"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 20:19:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLWI6g1clYqixIB6uQ329iokHBoM28Pu1W5TUCn2/SVZv75DXZT0jyUKGCUXeSfRo7QRnmvN/U0P4uGJy6dxax1uCPRcdPB4fbP/jG6OpN2HwL+45vPh0cC97nR7SnG4/62T+oLPzwlHAGCMAB2vbBifTNlpFdOm7nU2XYkmQyh2PHFUDfBawL8EF7m5dy9XyGjm9y09jccBbolgZ4XMM+jx1gvd8iqZbj42Qk/3oWy1MYPAG5WjMtF0mjrmxLQ7V+/IgNPIQPgoTX7A9u2HFoNSTL7IWaw7yXWw13HD1QiJ3FGu27xbm7i/4MXKisN3KcJWVu1bV4sf59BwuJqtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MX3tHtjG+ZoSdRrN2T53AzUOcxDAhSWvUPDOzw3xg2DKAnp/bmdmlqGS6bFLdGhKHMNWcBTGgqJPsEAIt89PkrprbGwtF1UtCfVAFRVx2MffueDj5KkHS4GouOgXGm3BrEE7MEovBDapbv1NvtU3dMu8TMNeoHMNxdSzcM+FeE3GaYg2Dq0HeUa4dHXmap7jtzbsGFOj5JIoa32Yso2ba58dv6ikeUor0oZr+YoakHlUOwNB2cTHb/kX039REjEcLkzdKy2t3jukbjzITO1nZMVMmVIeqo8VtuJCgoytmgt2Tqbpo+4vIP+g4FnY/PsZsfq1UIjSd2f59esWOemkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=W9g1WADlDaOna6CxaoGYV2LGiudYThorTxMVCrT7KmzNY++NT2s1sH2cUzweVdosyEulrSWQaFI46Hxx/3sPo1FumNqk1HIhgKB8bCbq2OPQLAkT0SMccCauY343dQHppvHJbotlAZUmIQzr3IWFHQKSxuatmLE8r4vxsQ24eU4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7882.namprd04.prod.outlook.com (2603:10b6:510:ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:19:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:19:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/24] btrfs: remove check for NULL block reserve at
 btrfs_block_rsv_check()
Thread-Topic: [PATCH 03/24] btrfs: remove check for NULL block reserve at
 btrfs_block_rsv_check()
Thread-Index: AQHZW+ZYgXXpiGqh0EuoV50QigRyRq8FJvIA
Date:   Tue, 21 Mar 2023 12:19:24 +0000
Message-ID: <000b524c-9c3b-0a73-9ec9-f13a6ddd6f04@wdc.com>
References: <cover.1679326426.git.fdmanana@suse.com>
 <8a7ecbeffe854a442aacb7c5c0c97b9f44528ebe.1679326430.git.fdmanana@suse.com>
In-Reply-To: <8a7ecbeffe854a442aacb7c5c0c97b9f44528ebe.1679326430.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7882:EE_
x-ms-office365-filtering-correlation-id: e7137617-67a8-41fc-75b0-08db2a06822b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcxk4lh6SM2Z2Q0q8J2ATm5H9wEjoz78B/SbzR+NA3dHouHQfee/hWhE0Cv8A/L9EXT563OnLAzHIW/KHHmQ7OChag3LuILAK85ULxQedpzUSt3DKZCm6BOdNB22Ck4JqnZjHuUk+U/8Qiz4XPYOniSvbhcdRrQME49aOludHEtvKzxD59TrCSk6377HRmOxJDuVNbTFqFB4DNJgHuRneQm5hsyhqTGeXzFQNnwWP4CTf/Llvky4BRECFAvNx7AyOOrbBAvuNOMgZe23OMWiYVqia4J91XEnYVr57brn4D/hunHKjo4zkn0+sqVO8LDSGQrD8X9WRe5S94ckhJ47bP69eM2Gr8DOcBzAL0jxXWilu6/BXRZuRwbwjPloQLOCFB0uE+/1euJzSWGALyI1T7Zk+p8F8Q0bitkRyt7Sm0fkps6VKCVB48MFrRk0x75jbtm3rPcz+DtaDAjqV26yIBL13DYOliiMyWVFy5hoqZlVbBUA34xX0zcL8dJgQiO6ThIC8KBj9FMAf+yVEgGh5AP5Dzl4eTUP9zym1uIMrjRfZo5rPPaKlfrA8K0ClF+S0qGWcqKsfTDIYUhrO0f3yH+td7BMyfK+pe2khYijhZX8XIkuoHJmLCnY28N1UYCSjN2OV3CTHWtfQxyUOkgIRfx2F06RSvOIIrx6LVT2zMV/kSPoSfb8Lvj97yK9XlQU2G3PkTyvKGTDi1D8zSwczv6XBti0NTzlqvnmJgMwPV5poXS12b8144tMyFrhY65YLJR9T+QfgCdmnKCYGyWRBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199018)(86362001)(38100700002)(19618925003)(31696002)(71200400001)(122000001)(558084003)(8936002)(66556008)(110136005)(316002)(76116006)(36756003)(66946007)(91956017)(66446008)(8676002)(41300700001)(66476007)(64756008)(5660300002)(478600001)(2906002)(82960400001)(31686004)(186003)(2616005)(38070700005)(6512007)(6506007)(4270600006)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXdKY3dXajM1ZS9WdGlIOXlwZXMrbUEwdkJqNTJvQUZiV21oczZ1a2NWaXJk?=
 =?utf-8?B?UVBnNWNrNTdKNEhXdXhINDF6eXJVTS9UaE9FUlBnQk42cUhTcFJodzZ3WjIx?=
 =?utf-8?B?cTNYY3dzS0hYRjdrUXcwTDBhQ3ZCOSs4T1JkcDBibE4yYWIzRExhT1ZJR3lX?=
 =?utf-8?B?Yy9PVHpyNEsrbC9UV1dGS2luQmRmMUNHTXEvd2N1TkFLRDlPOXlKN3BOQXNo?=
 =?utf-8?B?N3NTSWthSW5vMXoxNDR1ejlubDE1bGRHMzN1NTJvMzUvVGMwaG9qaHU5Qmg1?=
 =?utf-8?B?dklBMGNmMmZsS1pTM3N2OUJxWW5WVVd0YVJsaFBPM3NNTjMrT3lSY09tME40?=
 =?utf-8?B?WWRGQ3BDTk5MVk9abzlvM0h5c3Zhamt6eHVWbnhJZWlhSzVqQnR3RVUyZWMv?=
 =?utf-8?B?NW9xWTh6U0tkZnBaT3loemNYKzBmU09QMVhLTytGd1gyMHIzSDlac2FLalFJ?=
 =?utf-8?B?TVBSVmIycit0MlorS01pWkR1cmpvMi9WQ0N2S0NobTJRRkNWL1lId0VnRzlm?=
 =?utf-8?B?bUhrSkxTS3JIR1pnVG9nRDJsV29mYWk0TkozWVdNSUJ2bm9JQlROSGRvTlFD?=
 =?utf-8?B?NDdXb1FjdkhxSEh2bVJ0VWdWV1ljOWVoR0Q3ZStUKzEzV0xRYVV1dStCYTBo?=
 =?utf-8?B?VEZZUzRLS2FqWHFoTGRHVnlMbFNBYzd4OVRRcG1mK0FNVzBSTkVOR0VJSmI3?=
 =?utf-8?B?WkV2VXh5ZnpjTWF2aUxaaEtLUzFOTmlSVS9JeUFXWE1sTE1jbWZNWlhBNmNV?=
 =?utf-8?B?MkIrUVlVQnhyR0JWUGsyVlVLeGNBMmhCQmxyQnVUWTJiU3krMCtkcW1DNDB2?=
 =?utf-8?B?N0UvQjVzcVNiYk9pRFlPRUZ2c01BTHRab2MwcEI0eHgySGxkeXJIVFJnWUF0?=
 =?utf-8?B?bUhRc3FoVFAyVkZTcGNKWU92c3dKTE1zbXl6Y2M0dTl4ZDhVbHJRWkIvU3BL?=
 =?utf-8?B?RERDT09Wa1krMWRIdFdpQ2ZxSjFPNktmR1dzc1p6K1IxRXhHbnJ2bXFUY2Yz?=
 =?utf-8?B?QkJId1BPdERmYWdBQWVoYkZmZzFhWE9HWnU1am1NdUVmMzAxQjBNRXJmT0Ur?=
 =?utf-8?B?OWRsODJKLzRzb1k1ZS9zcWVqYWtMZDU5b0o2a2RHK3hLQUlNSVd5ei9jMkhE?=
 =?utf-8?B?UlRnN3JKQ0ZUN0tyM2QyODYwZ05ua241RTlobW9DR0JmOS9ySEhLS1huWXRh?=
 =?utf-8?B?UTFuUjduU0Rrb1RFZTluOGtVaDMyOVBMWmdkNVFOZFZzTnAyR1F0bzBEWHVt?=
 =?utf-8?B?cnBQSmpJSmRwR0c3YW9YbzhVRzFhWHJjd3huNkxhS2p6TGZydUQxS3JlSFcz?=
 =?utf-8?B?akUrQ3B2dzF1RDBQL1diZjlpWDVaNjFUYkluM3Q3SCtLdVMvZExnOXBEbXlS?=
 =?utf-8?B?Z0ZmY2l2c1NWYk4vTDV3ZUdnT01PTUZsOUJ6S0VsYlhteHdZa1JkaEdiRTRJ?=
 =?utf-8?B?akJRc3hyYW96RndKUmlaZzhLVGVKM1UwajJ5Ynp1YmVUM080d2tGSXQzcjFt?=
 =?utf-8?B?aFhwQmEyQm1sUnFhMDYvQXIzTHNESmg5aGROZ05JS0FROEVDRkxiOThXUEpk?=
 =?utf-8?B?dktqd3Bic0l1MThVbDBia3g1VEN6ckNzY0thZnBweGdsTDVkalA4aENuTUVD?=
 =?utf-8?B?OHpKVWVqNmZUQklpVjFGTlEwUFJhSDRQakVNV2dKamRDN1hsa1NGTUpYUHNU?=
 =?utf-8?B?RzZuUjZjY2hwRE9TUCt5QllnUjc5MFRoemRkUytSdFVrZzBmdUU2T0d4b09I?=
 =?utf-8?B?ckVCbGc4cjQ2SW1ISUw2aStkOTM2NXkvY2xFTVg5WEhNRGwrSzZ2ajB0dlh5?=
 =?utf-8?B?akVLa0JyRFRIbXdyOXM4dGdhMGJxNFllZ0RPVnFSaEMrcTJQMUxqNFEwZ3Zs?=
 =?utf-8?B?MWlDNk9ZVmhYNVpPSjZTNWNwRkRGWXZRNDcxL1NrTnlkRVRrUG9vMWRRMUdN?=
 =?utf-8?B?cmpMVkhlWkdldEFPMFZxWnB3dlVPWXR2NmJYU0xVMUVOcEN6VHFrUUJ4ZXU3?=
 =?utf-8?B?eGVrU21pVWZ0aHJTNzBqVXJpUERMSnEyeGlVeDFMd0FPZlc4M2pscHNBUE1q?=
 =?utf-8?B?M0FJK3p4T2RJaVR2dXZ2TWZNZFBXL3kvV3R2a2J2ZlA4RHA5dlhoWWRHUnVu?=
 =?utf-8?B?bnJZcFRERTRScVhHVHhNWEladFpWSDVhYkxESWszMzFFZCtxSCtFSVRzUDMr?=
 =?utf-8?B?aXhFbXRNOGpCUEhkUWVxcmRTMVlBMnc5YnJ6Mms0SWkwR2svSm5QWlYyYmZu?=
 =?utf-8?B?MWEzTE9YM3dtd05TckxMTnZ0UnhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <751F0171D23F5747AA24D033A6FBBB0C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I9G7xDLa53OZ5Rln0WQDQEdFsZmubb7oVSON+p3XA8+AGzxdihC68UoQbJlwS97B5ATPkMcYmbc4YnMDANFfjmIqSI7FAw8XJjYN9l8JfwawBkYenGqImUQiVtc2Cx+oa1irzT+vTzeL1syQCfb1KAPoloHrXuyPFOReK/oir7AF9l/VcYTWjmwmXeiEVNjiY+TTlDNt1C6YXcRpSM/LL5gYM5IN+mDjNhqqIioLOvjP95puPUliEjeL7x0oXqMbX1hzONdHxTbSqdn4hPxATuqPbZllX3aACi/yJdHiqc1L6OR7xGtyx47kD1WCZnbJYT2PwjTDGEVxQtFgzK9RTEgZVdzPZJQkJEzK8ft2/2EWCkjlC5wmDw43DUYOkaK8htkIvTqXfl3saSKGnhtmPOvhxlMJSwlZGqd9ZY7IYC9RnrIq9ot3gJjisoM4xApJtsrFF11VID/keV+jipP6mCC9VjGd3lnoMxWQJ/df0DcR+SDK+hjUujLHXWuINIZwlANellt5dyXnD2vN5WBdDN7IrVfJhpLZVPGPDIp340vTzdnf6d+NPYcJU5CXc+FhL6pN4JcS7Gjk2q6mJNRaCpQCYsG76+S9hxbGmJw35z/TP3XPFKaNWNrVxjEZaedvb0ocGUEz7y2CgZnkbgVpdvau05O6HnhjpCz2C8UdofxjsxVcb6HqaRejphuNnjsu2V2Qng9QoLgEB69U5XIKXV+5ij+tTv5x7aE8lcPnv1tC1X05O83chPGY9xV1/qAiM77S74S3hLSifAJan1ccjKaeWAtqrN4Skm9LSMX3RstBPx9SwJI/28KF3KL4Un9k
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7137617-67a8-41fc-75b0-08db2a06822b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 12:19:24.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPReNvFEFcL9hMENzIn1LWREV/MtLd/HWpyIK1ISnDNcROjCYxuxmrlT5Cnzg/jTzL1cI9vs0RQKVIYQ94XPGMooqEfoTwvdHRsjlhBIghQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7882
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
