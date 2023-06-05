Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B9722331
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjFEKQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFEKQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 06:16:20 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E64FEE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685960178; x=1717496178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rQvy2o83PSPkcvgpQmWiQZq0p4bx/3mjq6Vpcpu9EIRGOPmBLJb026Ar
   wsXDUFjtyedoyiV/iuxCSHsvOr06GafrnYJUaTxJ5Pnf38yakEbZLjPEM
   jDm+uSUTpeCHbZ1I4+mFxlYGm+5iNeZo2QDmkxYWEgg2hvzlhAHOfFtw9
   /b/J8iMnt5lcUzwt+9Iu7NzfNs1qf5sBAhnCmHr09sUVO+/gsA8SEkc4o
   AGcDFAdqa1maH2YeHJ9zsNrYIKnOadJxqcX4HRy0fnE4mzo6VQx70ZkFX
   xV++VrwtLxRIY6aSmco14dwYB1eMiP1+SMCzJwuf+3dCu+FR7xLch/4ah
   g==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="230642503"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 18:16:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXZx4kZAqFQde1GyDyvx3X4TC+2v4MkhQE6h3V+33BbxqAk5FEcQ/ksF++UE4ishNxNIsKn4Zva/kmNIXhXXX0SIIuK2eLH65k1gZjvkZ4igSjetAZ2bLpr2Bt56w7JS9jg05TuOcQIDQkvysu+tQPu0ipAsLjZxVaB5k/TbtVhaOwn/vTr/mHTo2g/4jtyQdJpVKojtT03s5iyV0t4zZ/B9YRfFgGxkIA+fLXjDcB1Xcyz7ymt4ZblJL9QMTme+YRNEog1RtvQzfoR+H58TWhLayo1SqQOqv65qBR5cevwYsOpRlN04H90niiQ3tsLdaJql+pVJq26dnnEpfWEkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=N9K/qq8W4q4+h3qV0aU6pXent2hcvq5ieyqrNk+Ij9vMZ2tNG11qqr137xG7UaH5+hP1nh8sb0djPfcam0Z4JuXLxlMqgJRhscNl9ceNoTxoz4ucOQxsfeAGa6brqR8xeOhlg/4VCmhDcxElFiLWQZaxIv3kASzjTCgZe924lfWpGEYr6Eo30zzDJt+xknY7OmQ9V84qauxY33fh+pa386ZsNer07E2IRjv3kSdtTk+lrxFcZZaTyWPx9seJDF3qXeLPkpiZUU3NPQwPEZjk0dchRTzk/Kkcoe0hQxuiST2ZMLIR/0DRpmCzYaCvbSHhdJZSZqSlh2NyjFi69k4pQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZzCrqL1e02ntsQ9QAG5Ac90oR/ItPIGULmkc+HelnqpQsBHJD3yPN/5BAqgkC477UN+w5XEYtZVuQwweNkc7dB9ngaUvRE7Df4ZJ1n3TfnZIHGBFt2z0wAS+3/tIBqR5uFX45gUK1LK9gSsHTQmHU+BeqPrQLTvPdjl+pMn6gwc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7700.namprd04.prod.outlook.com (2603:10b6:303:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 10:16:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:16:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: split out a helper to handle dup BGs from
 btrfs_load_block_group_zone_info
Thread-Topic: [PATCH 4/4] btrfs: split out a helper to handle dup BGs from
 btrfs_load_block_group_zone_info
Thread-Index: AQHZl4ruq8aYuPI5IU+GV2d/TalrQq97/m+A
Date:   Mon, 5 Jun 2023 10:16:15 +0000
Message-ID: <9d096a7a-c444-f0fe-7ee0-ab90bb468ae4@wdc.com>
References: <20230605085108.580976-1-hch@lst.de>
 <20230605085108.580976-5-hch@lst.de>
In-Reply-To: <20230605085108.580976-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7700:EE_
x-ms-office365-filtering-correlation-id: 391df36f-ad33-4986-36ac-08db65ade577
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cW1m2VF4OYMA9aTuSE4pYwZFMACTJ7exPOnE2vcY8/K+DbXKi0aFw+TmpEh43kbK+hWfxXKwFqoWVo4+mQYCsdkyFbIG/2Z33wC7KD1pleV1sZZziMEKNNoL8xslJjrKjTt9UVXuavP3uyMtKBfm/SsoJMZmBN2idhu2H0zbqP0RhfciR5cO11ko8LkSFa1iCR2PQ3Lpi9avQN5lFw+U+m6hn5Vtt2o3RikM2vxbvDCPb83sQVb9U1RL+DH4XuZy6Z4bLJhZ8d8sZnEjzzkgmHCudKQyreJBsgaYZsVGzoADUqybXs0Av3N8KP2SASeMvDJnK7EfglDeRD1EZ9d+DvZAhzPCqaFHWNXwEVdPwMcTiYySeNaaIDFiZCr/GYG3Py05csvdB2UmxHbzISiQp2gEenWu//H6RVw5qzOqQ1tG5h0KqVXfq2GM0HUL7Kc44F/3Wh3bXo/uoaeG4L/BKjiSaYHU7NJJCmskys86t0zXuCyvB2lWkUfpUZdGPPEtY3Xh85MnthsJaeCJowyfbXCNQyPZJ5FrSdZsZ28f+annSXKEXRccrkq8X3Dg5197FttLP754E6+Soh1PhVrMpkaYgW62iI5dlo7wg0THoDDeQsontmcYz5soHAlBrx2terWkD22VRqJxPstlxnH43O1eFXb1YkAwGIc9GLhVZEyVEdwwqnrwBWNmU539Zmw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(478600001)(2906002)(36756003)(19618925003)(6486002)(71200400001)(558084003)(2616005)(38070700005)(186003)(6512007)(6506007)(4270600006)(31696002)(86362001)(122000001)(82960400001)(38100700002)(316002)(31686004)(8676002)(8936002)(66946007)(91956017)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(5660300002)(110136005)(54906003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1QZGs1RmtyTDJlZjk1MHMzNEtaYlR5ZlVUdUp3VUNBdmp6OVN1aFVCL051?=
 =?utf-8?B?NE5xUkU1YzNWbE9XZHF4SmRPN2VQNVZNUVZ5d1JxT05lS1NiWXJLb0V6eGcx?=
 =?utf-8?B?Vmlaeis4ekZON1NEMzkyQitVblc4N2tjeGRRaXBWSFR1bFM3WktKbmROaDF1?=
 =?utf-8?B?S1k0NXFudE9Mc0hLRXJqRG4vV0crRzFSUnplTXNoei9MdGdrZjNHaXJ2a0lq?=
 =?utf-8?B?MTgya1dXaU1IajNoMlMraXZtWWREOUh5cTNmVWxLOWZmTnM4Z2syMHRiMWp5?=
 =?utf-8?B?MEZLR3o5NlhJRDJVMnNORG1pZFpPeGlCeVJjeWRIMzRnR2lXSHNYZjJoRTg2?=
 =?utf-8?B?c0xoL1IzZXlMbCsxK0p5NG1YdmtOWmxGbHc2eUREYVNhS0xWdzhOM0laSlJh?=
 =?utf-8?B?bkszVTdpNjFwWlVqQk55N1YyTzdmTGpYTHk1ZDdhZ3ZGM3g1MlVKRmR0YUVv?=
 =?utf-8?B?USs0OEZLWEdRNVRnVGFsUE9rQURyKzZ4dWFneTNBTjRzOWdOT2hoM3o2UU0z?=
 =?utf-8?B?d201RUkxMlU3dlB2WFg5TWk4TFVlSWM2NFd5RWltbkZobkZuRDF3UnpaNWl0?=
 =?utf-8?B?bGdBczB6T3hWeVlPQ21CaUt6WXdSTlFZcmozTGdFeDQrVFhhM05CMmtwZXpu?=
 =?utf-8?B?S01wclNnbGVNelBXYXVPTVBLUlJxVjh3bko5ZHF0REV0bE9SR0ZCTmpoZ1FG?=
 =?utf-8?B?UWpjTThiVEgxWnUvTWtEOE5GbUZvS1hRamlTa25kRXZVcHNmYVRFY1l6cDdS?=
 =?utf-8?B?SlpRZEUzc0xXVUlTR1h6eitFdEFTeW9uSWlVV2ZZaGVUY2p3RlZuRUFVOFd0?=
 =?utf-8?B?OHZtRm4wYW9Tc1Bha0lPbmNSbHVKQi91WEdRM2Z3RWE0REF2UUdmL3BHYWJZ?=
 =?utf-8?B?T3JFUlBkN2ViZGZkOTBSMUhMM280UkhxajVBSmJOdXhvb1Jlek91TFdpVUxL?=
 =?utf-8?B?aGZyVWIyM0k3SUdsRzZ5VzA0cElHSXp6VWI3TEsvTU9XcGNoaWRBUXo3R2xS?=
 =?utf-8?B?UzR4L0JwY0NjTnRjYmJscWRZMzVyTmNjZ1NJekFTSGpCWVl2SzA1Vyt2Nm91?=
 =?utf-8?B?KzNLYk0wVTFwbUZKbFBDM0lncncxd2EwUHRpa2NxeHJjTytzQkNOeExtdExr?=
 =?utf-8?B?Y3FhQUg5R1VZVUIwYWFuRzJrbHNYeWNHMjBFcnRTTlIzQlZIV2NjTDNnZFpE?=
 =?utf-8?B?S0FzMjdnM0JtOXBHMTRyYktBUTJiK1AwN0p5cEtnZVhqWlI0eFREdXNxemNp?=
 =?utf-8?B?aUVtREdoWlpvd3NpcnIrN0tCbGZFenpEMm0ydUZkYUVieUtBZ0ZZdGwyT3hi?=
 =?utf-8?B?a3pxaXhSZHZvREV3bk5OQm5NMUlLN2JqUGhIOGJ2MmZqTFk0MUxuZFJ2bG5v?=
 =?utf-8?B?QkZQSGlGYWZFcG9pbEpIdzdYUTZ3MUU0K3RscXRDR1JmWDllc2t0WThiNVN1?=
 =?utf-8?B?aXZjUkM0Nk9JRnhiRE4vSCtOZDBNR1M1MUIvY3h4WTNId1p6R1JMaFJxWElJ?=
 =?utf-8?B?U2hyNlhQNk9Rb3RGdDU2SUxkcmdyaG5CZVlmMEFPdEsvSEZVcXY4QTlyYXZR?=
 =?utf-8?B?VjZQOEIvRmVMY3RMYVRkTmFaMUpSYXo0OUFQSnhwSENhbzBBSHJsdXhQODFl?=
 =?utf-8?B?eW1PVTAzV3crVFlDNnhWd0oza3lIQXpzNE1SbDl6d3A5eE5FMmtPRXRXOVNo?=
 =?utf-8?B?Z2ZoYWFueG1wZ3E1SitNNXdkamJHM3VDQkYzSGcvNWtMY1NORTVSbDV0a2VW?=
 =?utf-8?B?bnkvTVJ1RlZBTmRoNmNtSEhSSmxQUE5UcHpCQUxHTkhhTHp6M1k4bnBScmFr?=
 =?utf-8?B?OU5OUWdXZG1Gc2MwUTNQR04xVlZqVkpLZTdIdXBGbWg3OFN5R1BtdTZIMStu?=
 =?utf-8?B?RStHcit6Q2Q0S2lrcnQ2UmNQVDdSV2Zmckpzem4xWGlYNjh1U0QwUzQ3VUNN?=
 =?utf-8?B?SjVDTytHTWhGb1ZmaTA2cGJvVFhPbTk4Q0dSNVl0N0ZZZnNmQmQ1VnhYSVFI?=
 =?utf-8?B?OE41c1FJVXN3emZQdkE0UTBQVGt3UzdzVVIvUFExazc0QVpsdlorRHFqa2xi?=
 =?utf-8?B?aUNCMERmL2VlaStxdCt0LzVDaFpPYzRJdkJTTTBjMm9qYnIweFRVbXByNmY3?=
 =?utf-8?B?TVd0eERFajNVR3lveHdHc2tHdjJBdDNuc0RuS2ZJRGRuditUY1U4bFcvOG5Q?=
 =?utf-8?B?eVRES0FucEtIMG00eXFLbHVTcEtCVzVTajhEK1FhUGZsb1JvZ3o5OFRYU20r?=
 =?utf-8?Q?l0zISBgYXDxbpnWPj8rgSDsWGSbKiWFoz4TmTV32Wg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <362741F5B1F74249866CA6C5AFF5B3EF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 755xCElB7XgDSKIIFjG/IQu0H6mvFMGN/4uT9WO+3zu/HeMkyd2Fhs96rFEjGCSdpBIi8xVQqEN+AsaLxvi3in6oQmslk6IBTZDsEMaWjqyPzu6vc9rFO3cAOUe7U6N2jXrQTV21VPc2Q6dG1Ebr1baN5UVONYvcrG0htiQBOPLci1mH6I8vLEO7NF9qORBx7O65zlq0bL734YdtWixEXr7UUVE61hswq99Hr1TUjDIEJ3gXfIU0rIwEOyRxwJtXP0Osn5Slh9Yi70zyPlWuCqDhxjc3qvdcoO/CJM15zWRoJKriY5itzh5AdxcQL8Lv7dwoPvHe/f9Pb81YYsHAnb8MmP1+CIWsRrUONMw2+cYwS2jGP5UNQtMXJF5xeRatLHEDNzDsgYoZqdkBTh4O5zueCJv+YI9IBAHqnsIou+ou3szlp4yi+5k23lzqRrZmj9kackCxnKdrcQvglTL48GPXPvxNTTcAoTT71hM8fhrF4LBDMzIQ1Xaq/Kdei39vnCp+WSpGX+y2urv5jeagQS9ocsBfNcJ43iMvkSl/FD/AW9Eo+SYoTHI00paxDIkcxnY1EEXtHhkp6D/MwrZA6lvL9aNbiOyP33tl7LzOOZhL8UK7VPFHZGTHmgJawMgOvHay5ZkUZ8R8uZjfW020sw50vuBRPnC95Sr0PCBWpQllW4M1f8VYHIbbfTS7dDNPNTZzzyfoB06z+kM5EBtTMkPkAHNvSsH6H/Zq3idlxtYsKS477n7QfwNjkT/Ja6aDo6TygBhzjkow0Xa6rSpH3uGPAFHTZB3pYQHD1ZPCHrb9nYk3BC2U0kkqnZ6JB0VBwYzKwU5u95dtn6kuYHS6H0LuX7hTLpDA8Ma1wqNE+aaSyAEOvNgA+sXJ+G5aHWxD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391df36f-ad33-4986-36ac-08db65ade577
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 10:16:15.6213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yNtiP2sb5wswn3tyjYv344eJv/NxPVgxMfuoqU7FdxXyE6ZjstNeCckErZnr8CE90IuqFOM0rqEi1ehUonO+Ax6K7AHHvFJvMJgc/mR7bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7700
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
