Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9539D66B823
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjAPHYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjAPHYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:24:11 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F993D8
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673853848; x=1705389848;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gU3w8Y4zlAqjM0C/MJDAAHgqE1NXGBy8g3qcBhRn8gYbgcb/CV5EN6MH
   0D3u3Q1qnGkIzYTFZONpzslBzbeDsMA2OrqtpoqSI9v6FSu0hLydsjEkL
   UNhUbHPfMfCQCayLpPRi12udSOtjHJ4CWgz84RrvNeR0dUuYpZTyPBRoL
   ZhpFi+wIHC8blUqRujNifKPqFYXCFPZehbekbmjQX1ROawDhWeKbE8ZLY
   d6FWBHS+JDNQJfMrk9aCJxghn8XACoNWjfouw15UmntTx8f4ydwhUAjj8
   AhAL5iw4sl2AvropMpjXHARk7ST+8R0ltcm6j9pLqWGqPBTUaiXlf6Ffj
   g==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="220988268"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 15:24:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khDT3O2QNywOehSJKfDnr8jxFDj+la8XvbhL+O6SK0ipev3YK/yrROCur1JXvNRA0Vj5W4nHZrWjWBTp9VGTwF81jyppuqKAYo64AcWci3Jp6o35dIp8+U2EbPTvmPFcjGoN0zNzUh+k6mB/Zg/emFMt+W+5YY7xbxfdSuyc4HZkQZEvScDcQmkk1cNq7hpckaHR5KnSSxjunlkFMQ0bNklZeDJeYsKfTlq1A+xoAbkIcIfZqr9UtQCiOkpfVnOigTMSV3LPlztbtxFCgpSVE4hqJytNacJ5ONg5xtJfUd8Zfd6/svxuBob8HG3LROpFX9z6DcIj/2oNeFMnNar/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=e+0eejYm1voeNHnJlSzTkplZQkyr8LiLFMA7aoqk8EXKh63WwdM8/5aRtdXjys6+mHggIBWgfKu4K54Oq+FibpzWgUMDYMIxqv6apwAB/YRHMUrF4ow6Vmf3aR7sprnw/s+aC6LZ2y9e90Tga7/hEwPMrLPuw15rgMvMQCaLy9zf8Vb6M765rgOJ16UHuo3i71A+FLZbVOt57OwC1HE0eRzl0jxnk6gWcfk2fA3LIltyleTa6j3JudWFDCEchY7VjrU30HnWKroks/Tesf5XJ7c7Ohcjys33SHa1u1CgfG4qPLLuBtyysivHj32uIzXyY6YnA/bKdKG4WXopkz3feg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=pfEDRJoVyJHYpfQhk0j9pagNey9hrJc/3jRSMmCb6unG08jg60uUa9Pk/7j/89nvxyJgvv88pge2NuPjl14Yx/pOUZ7NcI2k98ehRvZUMCDTq29UAcsOnlK+T/R+2lDTS+C+sJgN41AADqXW7pso7/V0K/aO8lzBwvtL9QpWlR8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8007.namprd04.prod.outlook.com (2603:10b6:5:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Mon, 16 Jan
 2023 07:24:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 07:24:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: mkfs: check blkid version
Thread-Topic: [PATCH] btrfs-progs: mkfs: check blkid version
Thread-Index: AQHZKVfndnCeWxQVpUC9HSdv6R3XEK6gpFeA
Date:   Mon, 16 Jan 2023 07:24:06 +0000
Message-ID: <b3e35d2c-92c0-c69d-68c5-781252ff794a@wdc.com>
References: <20230116030853.3606361-1-naohiro.aota@wdc.com>
In-Reply-To: <20230116030853.3606361-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8007:EE_
x-ms-office365-filtering-correlation-id: d2ece0d2-6794-4836-fa1d-08daf792a6ce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAiT9ikvwRsB/T1kFVAJp/bLwva5PIgOn1QBK5PkDJzzu1U+1Ca3L/9FpIwewKpQ9jemb09OG3Ow/hD26nR2cDI9j8vX2Rc1tJB82hiO3kGCatllOsTXSFax0MOnApnRGTJDOwKRkLi0G6L+vbUJLSiag8GjJXGjcQ2e55/IplvNsaOQzhRKUySMw8YQUiVHWBa0vfOmypUvYJfIuy9XmpHeGpKgySbseCdB/eegYWVQiM8crsrZTP/ItAJUXGuRHYYzaSymlc+3xmyuXoi1Ho8d0146CttHKwHKHZluI29Btsq4e04o8km3II4Y6AizTQFs2LJ/owjVZZAedD+oKASfl9z9HHIpyN+FYuiStTRn6QCYgp5uFglFhcRPzk43ob5BK8g000cmIpxTJCRixURfaKE7rBMYE6Jq0sLy+2pSjBguM5eTQeo/kQVe3vPdZWu7PJN/RTtxemqwVSLDyxoFf2JtWTALQpXzplMBy2huESN5NYDSf57XePhl3sQ2TsvrL+9ymLS4lrHefdIWOCsdW5lTV9nr9IMUzBep3M3ahPlOKQTcOqMhy2SgOt/nJHMrelt9c5ehW4RHsSKPvwa5Pijc8nbZihWElcqVwo5qoPmjEL6DoEbv0/q7JVk04+3MRM98lxtDTzMpXg7ta6GfM3BQiyUsVk+WdNWOFY5fiDEgVj8xCDHce8pACsLe29rutq/5L7xPsve3UfPIP0GSCw1XrDZIf5+lH4X0a+sx+NxAu+aHkkptOf0qceu5o4zbhdb6MyDTTWVL8YSt1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(2906002)(19618925003)(31686004)(91956017)(64756008)(8676002)(66446008)(66946007)(66556008)(5660300002)(41300700001)(36756003)(66476007)(558084003)(110136005)(8936002)(316002)(6512007)(71200400001)(6506007)(186003)(31696002)(478600001)(4270600006)(76116006)(6486002)(122000001)(38100700002)(38070700005)(2616005)(86362001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHk4Q2xIc1cwZDFONnBUL2ZXSFNtbzU2Z0hJVnRZYjFDcjlpaG5RZ1gyVlRm?=
 =?utf-8?B?aGhtS25QTXNXL2JEM1J5VmZmaU81Q2ZqOFdubTN6bUQxMnQ2SDNpbWNmaUNE?=
 =?utf-8?B?S0ZRQnR0RDNQZG45Q1JMWFJjbjVnQkhobC9PNVU0eVdjSHFFNy90TXdMeEhr?=
 =?utf-8?B?aVBudGZTUEVBa2RmNzI1TWx0OUt0VW45cG9kYmJnUUpucitjMXZ3clpFdHB1?=
 =?utf-8?B?K3R3NmhYY0wxR0JaK2tSTXE5Ulo4SUVOa3VFWHJnTnpOUWVtTUVhdFp2NStx?=
 =?utf-8?B?Wi9IRmZQRTVKVW5icFloQ3kzSnRzbEtkZENEa0ZLeVJpQWFVVnhscEpBdTdi?=
 =?utf-8?B?eWJFV1RsY3NlTllqVFN6MCthUnFrTERnOHA3bVU5MUttcFBHcXJ4clg0ZkFL?=
 =?utf-8?B?NDRNWE5jRmxiMzN1Q1ZuVTc3ODNxWmRLTzJrWUJGdFdrY09XNFJHNWc3YXV5?=
 =?utf-8?B?am9ucFJzcEVNeDBmTW53L0pOUkhBd2ZTMlRSeGY4YXVRL2Y0cWxXRHZuVWxY?=
 =?utf-8?B?ZVNiZFc3VWNJWnpTQWtFZENQbnZ0WHVxZjVBVS80Sy9UQSttSC96WWNZUWhw?=
 =?utf-8?B?MWQrTS92UmF0WWRhZ2dyeWNTVW9Kb1lkUUgwTnRqYjhmNGgxVk9FcTBmaGdH?=
 =?utf-8?B?ZGJWYmhGR3ROWkdTQS9Laks4SW1UMkp1aE1ONlh2a2RvZDlKa3BnaU5uUDhW?=
 =?utf-8?B?Mm9DT0JxREkwY212NmFVek1KWURoZVg3N3BJWUhyNnJyOXFhdVE0T3dGaWEz?=
 =?utf-8?B?ZzJXV3QrOURKMmlmSGM0ZUlxUzhTZy9mSUdIQ01QaVBhV2gvTUhRYmEzWExN?=
 =?utf-8?B?aEFUL0x4TldUbXVrYUZjVXZqaHVTaDFXaWg4aFpDeTUxM2s4YVExbnUvTFZq?=
 =?utf-8?B?SkVGdFFrbGRmbnZ3QjlUUitzaDE0RFFRWGpRRjNaWW43bTB4Q0V6WXZXdElJ?=
 =?utf-8?B?TnJ1Z2dNSXR6OUtzTWRueGE2anAvaDBzVnJHa0hzUGlnNFYzTGlVMEVRWmxv?=
 =?utf-8?B?cHp2bW8vaXU3c1puYUtJTU5vOTh0N21WdGZxNFFZY1UvSnRNTXJMUllRMVNX?=
 =?utf-8?B?bmh5YmUrb1p3RGVVY0VseVcyWGFMa0c1eVptSTh4TTJVbzhCdE41eDJBNzc2?=
 =?utf-8?B?a1IvVFFGV08yT1F1N1l5T09kbXllZURhU1ZmdHdROXkwNVNkTGdmcVhrWlM0?=
 =?utf-8?B?elJrcFZDdlo2aGMxSHdSbmVnVUdDb1dGa2swK3l6T29BbkNQK0pnZ1hRM2Z4?=
 =?utf-8?B?RHBpaTd5SlR0aVhwRDlTaHJkczZPbFEwUnJkeW5MVUN6c0YwK211cXEzNkli?=
 =?utf-8?B?TGViVmZiK2IvUlJNMEwvY2h6MUdsc2wvc3RTck15S1JvaEVPbXJkK3dYYjVI?=
 =?utf-8?B?N2ZHcFRueUN6cU5TVU43SzlLUnQxTmYwTTlqSGQ5RmR6RW85RTF4cFJJK1lo?=
 =?utf-8?B?bEFVc0JLeEM3ZjFtdHBuc0NBamJPNnQ2eGkrN29DNjVpR0VTL05KeU41SDlG?=
 =?utf-8?B?cmUvdmNrc1BuY3dPa2cxcW1hUGFGUWdIdndzU3RucDJFZ3FKMjlmYWo4bkdM?=
 =?utf-8?B?NXM4V3gweHNXQ3JBVk1lRTh0bWhheWQ2aDJtbERjcTdlKzVmTkI3a0ZpYTBE?=
 =?utf-8?B?c0ZZbmx6TUFLNVFxMFdYS0dPL3MwNlJWZi9MVjhQY1hyZU84UHh2Sjc2dkxx?=
 =?utf-8?B?N3VidkpJekdmL1V0Q2l6di80Vk1rakhHWXlER3RqcHhnSGEzOUFOU2lDazFF?=
 =?utf-8?B?SStmOWpLQmF2L0NRSkd1dFA2T0NkYVZRWGY3MjcvUVpUNU96eURKdXVzdEIy?=
 =?utf-8?B?S3EyQWhWNlllNXRpa3JTVFY2dThSNElxZ2RnZEZxVWtzdzdaTFgrdHhIR3pN?=
 =?utf-8?B?OHhpWDc4VHhBVnVKK0ZqS1JDMktKRUlnc0JkWkd4TUhLZTNzSnNOeFdLU2Vj?=
 =?utf-8?B?Q3RaRExBT2lLdk9qM1F4VzBhVVVZUkFqWWtCQVp4cmJBdWYyYTBOejE5ZnRa?=
 =?utf-8?B?Y3JkSVdndS9yVkhDWnp5L0xhekJvREZEOFRaTFhaWC9QVGQ0NkdNUkpVMXZC?=
 =?utf-8?B?WEdCM2F6MUJqaWwwS3RGVUdXQTFZdmd5NjFOeUhOend1WUhzMmRhaGROT3Fm?=
 =?utf-8?B?Nmtkc2paWlRxK05MakprelhLdUFxVGdSY2Z1ekJNUWlWRW9BZVVxNm5rL0hJ?=
 =?utf-8?B?ZzhkOTlocFVyMlptdytwd3QyTTBpcUN3OGFWVFNwVjZrUHNZN3RseHU4bWkz?=
 =?utf-8?Q?rSvtygxfpiGwfUzUB2CfLCV5Wcyorkvi7Wxs2Wz2Cc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE9D00562B0A6408D59CB176178692C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q5Xa8TT7uMALRMVUCjxt6/OrEs49KiNV/uQvjrpqyJJbHPQMZVKmxfNavw+vz56QyxOaWU5K/BOeQ2IyUEDvnFPCfIdUQzqhjkAahVc5gMHlrlPE//doQJ3KZkAGJyy5oGkDulyuaQHdF7Alw9noNJ17/bi106mIL3LoZ4iY9+fkRm5+UaeALchnNUny0WB8ZzIbNFFfyh7f7770zYCPUbzjEi7G5xnrBtcAGolYH2akM1RPQ+o4IuSaIEwrhQgZxLie09JN607WnrfASEOHXerTKUySj7ca+GcRzstOQ+cdlDXFXrIiLCfypJiBJzp9SnrP3So2QaqgEDTCQKE+rF2pbIH10+hSCuVUn3dlqvmWOeRdc4NTsPymjQQA/U/0lY0isYm1U+Jrr3OYW8sWxDQ7TvKETNyqmEIy+0gzGbAfuDjyKbS615jOIsV2BgmPEr/uFPhujD3VX3DoNSfObOpEVYw7jjQiRWfqKwbbLgP9JM8ZiAiC3LOWDZ72uuoGZfLR+ExcGGq5qyJpEpOK50SVBkMAcxjGOdQEHoLSOJkkVdIQ8rnbNT/Bzt8qcirElUr47139j1ZvT6vUVZNlsA/H8v5LP8LPV+fQgT930oky//T5gd0+uk+eQzRTxAHms/1kW3tMpJ6y7We7c3DZupgT3CT1kPQpCQDJRV/ZEREVtgcYU9PRAp81FkdCjAGM0Ye+8y8T23DBhOYZ1LFfmH1e1Po5A+RV0vobzdlgtnddqBCur2r4W81ygmGM6K/EszWJRhMBT4iiDJpG7unfxg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ece0d2-6794-4836-fa1d-08daf792a6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:24:06.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvpJEBhavu7nB6rzIEt122CqjCl+GYam6liDThEAlhQ+UwGTQpreVDu/vO5/yNcoeNIPJDCZXDr5lxFQtwXAfGl1Mmz679rem3IEB39ojmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8007
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
