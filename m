Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA734629494
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiKOJmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 04:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiKOJl4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 04:41:56 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F921DA61
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 01:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668505294; x=1700041294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=d1R1uM3KRWxyurxRBE1hQbz4ETWO3l03AoWSrdyOAY4uDfE1OYDkR5Q6
   DuoZsJF6X4X18Smmtkj+2MXMfRw7s3sX5pp/6tOLPMSZWKKJWpSaagx/I
   aJPd/N55iCCi0lix0ghtyD/Kt1QHroeGn9CABBLZcSEfMZF+nQzZ7RePF
   sQg8jI8K/NMUaOSmg0GlSprG/704UUcFo6c37Fv4FuyeE74iWWLXQbUDI
   lZi3W6EsVuxGP2kVyUn/ek4gFlETStbKjt/5n13c88ocAmuHaB3ePPMzU
   FuCfvkl3+0SOKHRqdjQvimlwe9K59/FSpwcX+ykbXtTxB7p8zMtU/OHIX
   A==;
X-IronPort-AV: E=Sophos;i="5.96,165,1665417600"; 
   d="scan'208";a="320646492"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 17:41:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd2XuuQwNutlij6hS0u9nTn/Vmo8neZUXdYIvSzrjWwtyRbQWT8xHiv7b1V/vhft5ay5hLl6umhfgGeHyu1Zlx/ZhYVhu6dRIj/WfDCw/JyS9v2syoBVB5+p19glAh2QoCzsbRgzKHwAt5Y1zDXXXIkbgLWkt90qvLBtsIeG/mPlHPq+1YtB6v050ugWyPajQrINht87d7Zt/pseFICivR5CMQyBf2DQx30nUSxGqvwiveywDBBdJHwroYKYlXgBKevKBgTD3zdr1RSQEGQB2GzbKNTXIU2d1L529BONW8WZIJF7bDS+s/1D24t+khzPEORp/cWCTZV0wmPmwpU19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LKzxRIx35pnT+SLV7+VPzRBzeGwgcFwqQFybmyVL+zkCxqWMmdcG2XcTTws50Y8XX2ApmH+SB5YUgeovTSl96jalgZ8uTgYLTeh632lzTG9OwLZ2WaEH9W3rRBC9/DOUQpFB7F3ULKgId8yI7/s+LJQGyKQEvxhi4OFSpn6fWDRJhOL9aSXPXGzt6krpKyl+uUVQ3U5KILP6QjzV6YMEBDJfy3OQZAmAlfJKh/9ISdRRKHL+uIQ3UxCm7//YGpphUkZVO84bcuLQtS4A1yIIT9yfEnnFK51LRDKpVN2ToXd5hT62Gly+R4tVgL3lX+AzzFXFK8bf07XQehrzXMGMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cREk41Bdo1ii/6J/G9jCzoEtmglff+MV+tddDD7XWYv6OBYnKejne5d0b1weGy58xZM+xOnpGYAd+HgtZTwP6roJRCrzLsMEjwZujtYFbsp/TWgKDMj7AVvJnhvltDYjDvWCT92NiGMz0wFXHjyO4Pn/SqAFN8HjhHf8XBEsgWM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6781.namprd04.prod.outlook.com (2603:10b6:208:1e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 09:41:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%8]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 09:41:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: fix missing endianess conversion in
 sb_write_pointer
Thread-Topic: [PATCH v2] btrfs: fix missing endianess conversion in
 sb_write_pointer
Thread-Index: AQHY+NY7qpwy96/WaU2Uu1e3PwjNBa4/uzWA
Date:   Tue, 15 Nov 2022 09:41:31 +0000
Message-ID: <b977ca4f-0518-e32c-020e-771d387abaa7@wdc.com>
References: <20221115093944.1625659-1-hch@lst.de>
In-Reply-To: <20221115093944.1625659-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6781:EE_
x-ms-office365-filtering-correlation-id: 326f5177-b0d0-4415-9037-08dac6ed93c7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XAOs/E3SiUy7SvzK4SMsArF+OElXPBGLlrY9EqmN0YSezhYpS1ofAaZ+B2bUC/Ft8kK8D1Jys7CVHiFDcAztHMb3nrEK+b2xhgMDtn7IT4rRGjmOYRgxWfMX2OmLbDdwX1YtXuGHAYZWd38AgHHBzGAsyY9rPVCS6mScRdKw+oWOLMCLwFn9i8Ja/PwlpuWZu+z5pIUcgqi4osOYNaVnU5YM05tnFXTTHSlfG5WxF5u7EGB31ypk5SOpkbZ091m1r3hXaFxLEc7wakN4U68N2M5Abzht3LaaTc9EgjBg3j27dmGsh68yRtxK1gXi0g2hexf9uB+tHw4yZVfGkBM9VZtHwoEb2tlxYXNm+cQv9UEGafMgyssPUnaOow3Dd41CamrTS/8AndUBbOQLB8qrud7pDucZSZESJbXtUDP6bvrRSRx1CEMFw6HF0UPOMLKS66/ZE+wAA9KgvnoH9Q6oU8fwWe8hW0QgBCrwKQmTPDD8qnWOv3QntoV60xwqsMcrlPe/5LCJ9mYsxpd3YDaRXZ+TQulJjCq5BjHHYL7X2zN1GtsrMClSjnmEMLGc89pIauKDoAdXpv+/IDnvdtX1iaGvHdpbAyQtvqQE1/dNFRZ6eQC36CUFM1R7hOswJ8ojRwqC6Fy83ZLAK/tL2Tr9ya1G/JYog5Xb7FmElJ3sf0XtKZ+0bG8fCwA5WWcT8yXPzh0DPMWe9bTHfh9IpOdKuGO2M1wcSAc0LGmkeTf9054u6qVST1UIPxnO1hqMvWnBwRAOrknZKyf0JTep84gH06xN+GJxis63YLIQkwSQ+d6QtiH8Jl+7ejG4+dSnI7h/We3zXYr/iGRhpr6wJfT4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(19618925003)(31686004)(2906002)(76116006)(91956017)(66476007)(66556008)(66446008)(64756008)(5660300002)(8936002)(8676002)(4326008)(66946007)(41300700001)(6506007)(36756003)(478600001)(316002)(82960400001)(186003)(26005)(6512007)(4270600006)(2616005)(110136005)(6636002)(71200400001)(6486002)(558084003)(122000001)(38100700002)(38070700005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clZIVDFxbXJQVkhuVGZLSmxmZ3lHakIyeU1SbEJQaXFETEoxbUc0THRXblZX?=
 =?utf-8?B?SG8zVGhNbEZ0RGhQSVd3MEZKZVozb2xiVkdaMnpDaUpKd2NwUlREdGV4blMy?=
 =?utf-8?B?N00yNXRlU0RpVHRUQThsRlJQVDVuVzhVc2U4T3RRa0FRYlVKTzl2emd6WVlQ?=
 =?utf-8?B?blRnMkVITDF0K3FwS0xKUFdzZW1QSDRCV2xRK3NVbzNtWUJYK1hPZnNyV0Iv?=
 =?utf-8?B?aFp6QlhBdjJKRko2bEwwWGcyRDU5SUQ0a2NxZEtxdUw1ZkJ1QTA1TkpBUGFP?=
 =?utf-8?B?NHlXRHRhSCtISnQvTlFkdUUxL3hDai9Gc0ttMU9XdGczTU5jQ25iOVZNUHVI?=
 =?utf-8?B?OVVtL3REZDdKUGRJRDhNZ3o5eFZpeHJ6a3dHVGNmR1loM1ZKT25hY3gvQURK?=
 =?utf-8?B?VkNFNlh3TUFTOWtmNHhCenRaaUJTYmdBdVVYYmZEMnVQZU5CTWVYV3hxUGFH?=
 =?utf-8?B?emVwY3F6MHozdmdmaC9jRGtoQnJIbVJKTDN1UWJkbUFneWx3cTVIVUFkSXRi?=
 =?utf-8?B?K0VkbWxVQUI2Y1gwQ2Z1T3NKbmQzMHhYTnk3ZzFFa2Q2NHpHR0JkVlFnTWp5?=
 =?utf-8?B?SS9iUXJpY3VQUnpCY3g4S0lDSFkzazdpMHVTdjFucDYxcGlmZXVNLzgreEMx?=
 =?utf-8?B?dENiZHd1ajNUNDlIU2FMN2hLSU10YTR3TmR3WDBJZUx0NWJCYVBmMGE1VFhs?=
 =?utf-8?B?Z3k3SGxFQTRhS05SbTNQK0E1RXB3Y2wrN1dxalRXN1JuUUViVEd3Qk1wQWUz?=
 =?utf-8?B?YWVkTTU2bTJNZS9ObU13djdxeWtLcSt1OWJwNVh2RzlmNy9aaS9tL080UGJT?=
 =?utf-8?B?OW8rd2NQaExXTWZjVGlRRWVkQXZWSVV2TlVaNDFKWElPUGY0aW5DTWZDTk03?=
 =?utf-8?B?aTRnRlRDOTV3bnRJRXlxNFNRT1lWRllUeEJPcUpLSE9xbktpUzQ3WWpHT20v?=
 =?utf-8?B?b24zUW9EcENDMk44b1VrRjhoK2FSZGFQSVdIWDhlQmdjRkJBTjVTQ3VraXAz?=
 =?utf-8?B?dmJpV2hORnVJQ2IrMTlqVFR1ZkthNWR3ckI2d0Y1SDFWK2RqOU90aFkzaDRa?=
 =?utf-8?B?aFdqYXVWQzFSaEZpaU1DZHgzMVhvOEozZ244ckEvSjRQRmJrbWJnSG1uRm44?=
 =?utf-8?B?QkpPYjBibVFsL1dxMUVtWG9nTVVITU9yK0pYTktMc1pxa1lEN0V3d2NTRXAz?=
 =?utf-8?B?QnRibGVVc3pXYlhXTEovbzBFdWo0Vk9tN1JtV2RMRVZSSWRqdmdLMjJrVm1L?=
 =?utf-8?B?Yit4QXdQOXN6OW9lMWZUUDJUQkQ5SlhibS9UYTV1UjZzK2NSTStOZlc5cStn?=
 =?utf-8?B?K2xjRC9ZMThKbC9HN04zYzJMZE1EZXJsU0VmQUdnRmJnWkY0YzU2ZE1hQTZT?=
 =?utf-8?B?T3FRZ3VZZlBiTzFKVUwrZFhIbGNQdG5qU1JVcmxUYkxqbUpjOUxrVGlSQWNM?=
 =?utf-8?B?SUQrdU5xK2tXQ0pqSDZtYlFlTnFSQTNta0poaHNiTlJNcHRmWVpGV3UwZHlK?=
 =?utf-8?B?eVEzcEh5eUdiMnNBc2hNVXVmUm9ub1p6VnZYU1lUQ3lWWDd5c2JkSDBQUHFl?=
 =?utf-8?B?amtQaWpZWTB5d3hzQnE3bGc1NUNoZlMzK1BXUUc1MTZwS200MG0xbCtHbHJ2?=
 =?utf-8?B?TkMxdllOcUxiSm5mbThyVDg0SE1EUXNFc0NhTUw2WEtEcVVTWTIwR2YvSDA5?=
 =?utf-8?B?L1dJRXFaVTd3OUlCNkJOQ1h5MXdISkxaNjRESHBHbUkwdDA4eWFWMHQycXQv?=
 =?utf-8?B?WnBpRjAvUnh2TlJjUzREd2lva1BQdU42eStVMnJXR3R5QXFoTVVzL0tPclNH?=
 =?utf-8?B?V2l5dDJ5ZHJocXk0M3VGVlo4aldqY2gwZjhTSFF3M3BXdVhyTzU4TUZZL05x?=
 =?utf-8?B?ZkdvdHRvNzZZVTk1QnZDLzgrdnByWndMZHl0a3FzSjYzTm53TG1VZHlqaGdM?=
 =?utf-8?B?T1RxWExlaXpRdU9wK1krd0ZDVCsySGxMaHR4aXJKVU5oSG5haWJkbnVaMkhj?=
 =?utf-8?B?QjJORVg1YndWVnREbVVzTm0zMFhyQkJkWUQxK0twNGkvWTJqRElJVURFWEhq?=
 =?utf-8?B?aFgzVXJ5TDAvOXF3QlNGYWNrd1ZwanZZa3R3Q2RKdDdJMFFxb2hpN1lUY0xE?=
 =?utf-8?B?a3daNllyNUpTdTlabWZuQTJCS2lOaTk1ZndSU0ZEdW5nMzhiN1E0YVhEblhU?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D222B1A80CD2C84BB0F410D37CB614E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +7n37cN2P3ywpwyqFZXRC5lAprXq2F3QRVzrcGxJNrzY2OUuwvZRksReGAYx+rulrUjtqWN9gohIHUF0bxZaZpLh3vVn+dxrVADUd7hH0QuoOD1DY0VSAGo5rcLLypeAyVgJ8AhPU2x9kDv/Vv51l38Pe0nQN3iQMOZFsm/2Pa2TkpVGbI4ahq7Zs7EOM2Syl/ZLdkv+1Xoag6dvcGiU6SB/m680+9HMk+2ZFJ7QnMrQnJLp7rpPAHvoUc+dJabxQ8zceBICsgNICb3V6iGUR42mk4qLSzrAtbPVZJ2vkrvQqzwLu9swOTm8KwrivMcdPpFjnWzUZkWRdboZNHwwoa8CEy4Sut0msUW+bii6VcXir4enMM4x46vCaTz4ek2UzMCiNBF/tEwMFWP9j/mQTQsEZfaOQmkfMfPOWC3TyTkauGOXWl9oK0hOyNrwwC5+tOF21T9wU488owTfqZfjy29PSysJAZoqFOxWKY4gyZxQvZzB7FegLql44AFV20UUYSERSS16UmVS9yD8/fdIce5QbKBtqxtqgXdAekfhIW7prdyRfCQ9IdtstVMiVBgnrozqE6ccTApOJofh48l6EOoEic0Rhdw404OGtkaGgmFCrYo+gXtNdmSdyYNpO2FcAmgI0WvLILVEOjbvdoz0kldN3R5z/9mvmRgRcLSNJbnrLT4aOJ+OGmmjKEKp7Yk/NcenlJSodc9vLn06d9lWM/bvC8SQPYrzWCS52MaDlqSyF2KNvlvvKT8V4+9zGafxF1bbC8QYxZe3D1/BN7F25kQjd5AUnhNmfYMva1nudAO7mDcs7mwx9kwee4YMLnn9j+ncIUmEvzqhlPdt1mJmyWIRAp/1UdmXTrmr1B/vrs2SdAepTMXPVSuEz1dfdqPC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326f5177-b0d0-4415-9037-08dac6ed93c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 09:41:31.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUKXKTkoriKVpQUg1DjYRLmO7eXwrPyieiUyEpp69DUSsa+r12ZNM/U79wXkQvx921GkUmKS/Et/Sptucz2umAz90BPnGBjct6ysDYRLlx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6781
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
