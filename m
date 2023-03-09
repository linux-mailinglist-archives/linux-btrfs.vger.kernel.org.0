Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9676B2267
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 12:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCILPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 06:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjCILOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 06:14:49 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B643EB896
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678360217; x=1709896217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=U2ATs6/9Sks8cPreBI8vahWSqM8v2/M9GOegsWoP4BTeOawHNynmuQeY
   +V3ZrViOI8sXNaNeuDAhMbhiyaX3NshfUtKTydUBfVBaVle0QrmRQf7XU
   nzNCJWfOg3JYbTFwoTCG7/mjnAGfda+0esuZNHe5ewcdVm1dbbkxuCPOs
   vKYMTlUJJ1IAK9FYBSAPd9SAYZgq3h4PL7wDAKGi2ltOikA35ubtfbiMc
   ZlgYOlMWj+1pmhkBGyIycV+zHjiYio6u5CqpwUqGNF8l1ipDqhr8FgA9n
   IjUZCSwrMgciAhFADFUiSyQV1iRtFnfTjE17nReZqoZPWmvms7DgNHHgf
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="224995549"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 19:10:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxsKdhAZ8FeaAqCGF/PvlTCrHY5CUqN1bMn800eMe9+HCEwWmdrUuaZoQepH1qE6JndDI1sxsAH5/1lYbRajTzmA7rOsJSE81u0pSylUlVyY+BwEEopuLX1kAODYu862Df9xU7TdnM+9ngoS03ML8ULbNKSfCmj3IafRJXiqte71wyt8ldwuDJesOMTNSgs+dv/zBMNUg7IX/tpHBtM7fWUlDz7qONFYBooG/zDK8XZJcukmhMe4yT9FqSodzSngRT6Dcx98lIP2XQ/gHAbEyjoBqiXw3qkatkWQvAO9828O4oAZNqvqIw8vi++MLBwV+nWOpJ7QYGaZwsuxmZx4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YlIwIFvBUA6QK9L8u8Yqs1MSiNvEtJuKZOmwqnUMmPhZuw99d4SER7/rWx2bEzpHUAV2PiToSHnU9IdkwwPQlSYt06uDPCnt0vwM1xqCRyqlAqCtP2Nf4fBOuVLt/o/36pVycy2vh3/Ik++BHqgBGBOledNmCelIxfnaOdKADOjRW+S0aKXCTnzPIlo/NqcKcJNO4tFtmbqKbPE5KyvWHUCfLw2lvcwtuYpkPbf9aHnNcZy7pVlhmF1YicUPTGDCkS+IN28ecIBkvugDwsgvSU6WGqgesFLQQ9P9IEDf/M8Grq+/LtcAr4Ji0HYeL+LDRAyNU54XLS9Mqhmy6BLPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=SpzYjZfyafTycW3eGFkXfUsjIYXVk8duiFMa4OKLnj35KOJ3xW/oEDKhACN0Raq8KNSwfMt+SVHh+YaUuBSMYJve72yEnsiV5ozmV3F9Jcio406hY5/HebLOPNIMFaa9iaoAVZfjbZJXRiBBeqqe2Ym7uVLMlgepegJ/+qRO9eE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0992.namprd04.prod.outlook.com (2603:10b6:301:46::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 11:10:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:10:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/20] btrfs: move setting the buffer uptodate out of
 validate_extent_buffer
Thread-Topic: [PATCH 02/20] btrfs: move setting the buffer uptodate out of
 validate_extent_buffer
Thread-Index: AQHZUmaEMN4FN3PSpk+7GSSS3k0U6q7ySqIA
Date:   Thu, 9 Mar 2023 11:10:13 +0000
Message-ID: <fc913bd4-858f-e13d-f46d-97b36611da2e@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-3-hch@lst.de>
In-Reply-To: <20230309090526.332550-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0992:EE_
x-ms-office365-filtering-correlation-id: cc3eea8b-ee36-4b3b-5e23-08db208edaeb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crRpPC8g3R3HaBkhul6v0SdNoDxjnXYnu858K4xP0uHz407kDMKDKrLEkspl1tlTaP+5APBj9Pv75ULvI2JeQojas6ojuTKkcgC3ym/1IN3BmBggM7l9MrE1b4InK3xeOWXq6jab4hrgISdJljypJcbIGd7hJU09NnHPKLudiy/kXSRc0RfGWkbSqAzO80GcYd0r1mlfKBNojKTQaxRdP1La2kI6ZMrgM6SYf26OxBESz9lMquGzuIPV436mo8zpXojaxG7eb2gTML+h21nmZ/rpG8VozslHmRg7HFco+mfMDSvNaAMqzTrgK7aah9w28CttZrXexsasn/smOGKaGKNNsJfVCuSRmk7JwXLJ42Ht4rPmEGhDas80vyjjjc+Dvvyubo4zF2pGJownYqcA8y5E08lsJQjgVHlh47rasdyaYjEGZxbqozlTjafC/LrbZOEJnBCGA+z8VmExevftm4qzQts1KqBdoAOuynij3l0P7W4KsiPApchMUNRyR+JNqbqKT1YeyuDqFGJp2mHLo3TBC5jnQdN89uwnNDQ7KkfPFfitDTjw2y+st0XnytRDpJwptLFvtZA48AgsvcS99wLijKmZLgXCaP33Q5PnFNd3WRIjkuGACm+1u6VExL4dVEnRoKgNswHw66ypCXqFEbHdumL7r6whKSY+i8Hj3O98lRiAKAQ3Am03s0mGMh70XF1+qPWeyuKv74vbOpmBu3dSEzZAGScqVROHnaH6bDNydSz21A/2PseqhP31uU7FAvSoADh6KUB6kD5MUi2wcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(64756008)(31686004)(19618925003)(8936002)(5660300002)(66446008)(41300700001)(66946007)(66476007)(66556008)(76116006)(4326008)(8676002)(2906002)(316002)(478600001)(91956017)(71200400001)(110136005)(558084003)(36756003)(6506007)(26005)(6486002)(6512007)(2616005)(86362001)(82960400001)(186003)(31696002)(122000001)(38070700005)(4270600006)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxNRGwyaGxyelNIUGZ3TGhjTzFrZjd1NG5NVVJ6QS9sbXpId0NOb1Y3aVBi?=
 =?utf-8?B?ZXBWYnEvVTR5RlpReGRNWEVZV2lvWnhyVENTVCtvVzRYaEtENm1WTVB1UzJW?=
 =?utf-8?B?bENrTnVkMWc5WC9zT2haUmlKcmMvbkt1TVhXVis4cm0rYmY5K3dnZ3lENVNv?=
 =?utf-8?B?cUNpeDBYeGRRbkwzV1h4UWN5bkRHRjBxWGpKT1NZTWNJLzNwSWlIdzFZOWE3?=
 =?utf-8?B?R2NpVXFPTU9sMWhVTEtHbDEzT3dxSVlpazdlNXZBR0ZiN05iQlR6S2FKdmN0?=
 =?utf-8?B?RUtjWmNZZThGcktpQzdheVh4cHl4SUtyVDdVZHZYbXUrVS9ZZkRxMnlpcnd2?=
 =?utf-8?B?U2liN1NIZjdocCtMUWcvb3R1Y3ZiOVlmN2ZEVTMySWNkcWRnU2hSTFZoU1Vp?=
 =?utf-8?B?UkltVnErVkduZjRITWUwaSt5VXRWdlh5enFJRDF4UlQwS3VldFVNVjFKZ0JP?=
 =?utf-8?B?NnZhMk5ZK1VxK3J0ZHFlUm1UU1VURzhVaTArVmhJZSt2NlFOMFhRTFVhTW1F?=
 =?utf-8?B?NVlHTksrNnM0R1kvcGVyVlZleWhOUXpqRHhDRGxldElURkFwVGwwcVkvUXdX?=
 =?utf-8?B?WVo1cnQ2ZEpHQS9ydnp2VGNFMjNwS2w0YkdIQWYxZTlsSTdiZWJ5NjhVMUtO?=
 =?utf-8?B?SjVvWVpZb1UvZGdtWlMyRitPUFQvUDdoa2NBdjQ4dGNtRDc2VUxnald5cFVk?=
 =?utf-8?B?aUhIL2lGYkY5WHU2bEltUGM3RmpaRzJNa3JobW54QmdMSjNXd1RMdldNMllO?=
 =?utf-8?B?YVRBRzBTS2pkTE5laHJJRjNINW9PSGgwL3ZsYjdJK1RqakF5cGNHVzgvREIv?=
 =?utf-8?B?SzFFdlU2SHFpQ3JGQnpwbHRRVmNGTTlnbFRQazEwamQ5WDNlTUViUDZSQXVJ?=
 =?utf-8?B?L2tVT1ZRQUxnU2RNYnRSd2Fmd3Q0Z0lwQldTN1MvVHhWcUxBaTBlc1lzZmNN?=
 =?utf-8?B?am9NU1ZObm5DYWczNjZLbFBKQkF1UnE4b1NZYlQ1OG1TdG4rSWV1aDY0Nm9t?=
 =?utf-8?B?aWdKQ1R0UmVnN29ncCt5UmlORlQ0ajl1cll6V3Z0VzdTcThmdXdYVHBsREI4?=
 =?utf-8?B?Z0o2OXRmdE1MNU9hak9BZkxORXA2TjNNTHJQd21jOWdwY2ZjWnJvbURITUZE?=
 =?utf-8?B?blY0bXV1enVXTjJRQzZlMTRYMHJwMGR2K093Qk0rZ08zcGlFUGpwaytGM0Yz?=
 =?utf-8?B?ZEU1THhiK05BRDd1TjFYc1I5RTdzRS8wdVJueHJNeUE3Znp6Zi9vZ0haK0Mz?=
 =?utf-8?B?Z1BFUE1lV2pHY1R2RGd0MGdmTis5Yk8rNXZYTmRCTkc4UnlCcnpObk9mNXc2?=
 =?utf-8?B?WTF2Y3ZraVFld0tPdi9SSnRzZUdBSUE1bS9KR2pPcWxPWmZXNnRZZlVrMm9r?=
 =?utf-8?B?Z0taYS9xRFZ4dFFjZDdCWUhhRUpMMW1GRCttd050U1hMaWVTUmsySFFndFRm?=
 =?utf-8?B?OTd6bGpFSDIvZ3pGL3F3dExyUDI2c2xhMkZIc1JEWXpWcVV4YmtKWG5KT0JM?=
 =?utf-8?B?eFFCY2ZCZmdURE5YbnlVUEhRcGJvbVJWOEpVMUZWNk05ejZNeWpVak1YN3hU?=
 =?utf-8?B?TEpPQ3NQN25QRk9HSVNaam1vcUpXU1NKWHlmNTVBalpsU25tMjlmdDRDc1N0?=
 =?utf-8?B?WUR2N2V3Q2lvTmY0S2ZMUUoxWHNJcDk1eDFJMlljM0hBaXp0c1hpUzFMSTRI?=
 =?utf-8?B?d052Z2FlMHgxdEJNaVFiaER1bFRNNExjMmdxYS9kckQrZmJNOGMveGJIbjQy?=
 =?utf-8?B?ZHFXM3NlbWlTNnhObGtEQVV6emFJS3BUMWd5R2VvdzRXOTk2Vk5ZZ2lHVnFs?=
 =?utf-8?B?Y1hlUzUzVFIvY3pYdXJmNitNN2hPK0dpWGxXcDdCdGZYSGtJZEVoNWpnTEYx?=
 =?utf-8?B?WUdSajIzVi9yMExTQU1udjRzaVNCNDVVWi95ZnJ3Q2h5a01PSmRJak9xNG1h?=
 =?utf-8?B?TzREWGNGN2xKVml1eC9rRVVGM1k2SjAydzNIdkpmamVEeEs3S3lPOXlLUFpa?=
 =?utf-8?B?dmNnWk52aklSakpkSStEK0FLai9IaWtFb3hoZmNnb3laaFFhWkNqdElvUnFZ?=
 =?utf-8?B?VHNhd0taNGZBZFpSaFArSk1yZStCT24ydXdjM3o0ZWxQY2FnVDFoN2ppSHdQ?=
 =?utf-8?B?dzQ5L05JSThOSnJsTEVTVkpmU3BpUk1RU2RoN0lzYU1WVzM5VUttM2JIbDhP?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C4B0569EC3962448E0AFB9598F54A2F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pJp3Ui9kbYKxqpte1N7WI2sRWC5PrYPrObyvrMJ61OmFW9sxpFosNltHaGVBpQhgo+oqxRB6ZHfVBUO8kUm1VWKBIwpA/TwQu9dUX5T20ktb97Dgj1Hn8j1EEXTeRy9CEDv3GT1Utb5tcBDdBUo58qXiNr5DTdQcsRfCHAFy0uQ7NpWqpt/PFIB8IAHKAVB/oa0RWQmCN3/YZvEwVojSY4cV35HlaL8rKwgMmVm33epKqL9b7sYQ6c3U0yY+Rg/si5q8+6enyDhViARlz643MI8uT69l6LpnXPa9qDm82KfMfSz2+Bouyy6U+zDznmsso6MfJ2yLPqnrD2fJ6PqyjJhIrUeDozQLl0ASl5EMDcbBuOAfME/LMBgRZV9GVuDdh2zvEKa2/OzccsATx5MwM6Xj6em57jEAN/r+jppcGD49bzlHQuy+HHaSVY++bcP2MVUiHhxErbyO8PfrB6/+sr9F+RmVZYgPSMJ76wHbrlKCVpxAx3oNNxezxiruAH+ILjxBsaAIr9NMfOxxp85PIHf/XnAOX7kXlmXuoM3YhKn2xS9LrQf2DJNBGtE9sbePYFvUHPg4959fzTS2rJoX+cRwjCnp1V4s2WDOo6fh4aFUQ5rC7AmwJL3olCJe7yX5DSHkcTEIGWhsmieA8eo21kQ+ij+XPau6vTOWWDbvudzBhpoB6JN6f3qT/7W5vlFqUePQ6E9THHfApiiiUiSbI4Udco2ZJF+xnf9/05BO/bNR7foqmCmY96pHuu81U/HDsi2fXChnwnLBuvd12B240bMUb7Kx1NtW0B6ZaMs92dEPgkmFMA/18NN3P54l+ctHSeYV1vsI8tFlnUt34prwjDMTDOHz8/jV2Os2P79+puWoqNTgrj/0ERWj12ifyZNB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3eea8b-ee36-4b3b-5e23-08db208edaeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 11:10:13.3048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cb9Be7vKXm59rTEPEsEdB/LGXOCFSB3+IfGUgLNCNAu5NFmWE+/HEiBDftJsZ76FbmQFoerOM0Vd/y2wvyowK9clSBrzU02mIUKYGCu9PdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0992
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
