Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988696B258D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 14:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCINfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 08:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjCINfN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 08:35:13 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A6861505
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678368912; x=1709904912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=RuOjUeI5u3va4qQ6vAX500prEw4K/7kmqicDefCKRuSlAoTVYeEVRuvU
   4c1ipwCkMsYM9ncmJQ0aElNcQ3n6gsIDCmdjCVZJABrtKhOiBRn4FDKm1
   IB6euMPa+TxMGaCFAnAbOfr0/DrcY/MIV+2wwCdAkvO5gOwsnzk4rpOqM
   p5IQx36dczi5EhgbSpmZE3bho+B/ddAYSsXdT8u4pxfxdZgwqNPmbYVJf
   Nnt8fg/Y8ST7yEpD76ngbHQfUoOpAaWRaSS6LTuQRTYp6GtQWY7nxL6Ec
   mLw7nvTqrfVtkx8zuDYbj5WVBWxQjf5vHbwdo76Umw0DysPutC22PgxmZ
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="337219490"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 21:35:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBWep24TS5et2R1STtHaVBk1ITOIv2y1aWH5wWbYy++ViqGJy8QADVp+sETdo5EBrQBkJ6DbIx3G32/ykDFumTxsJaYaZLUUZjZ92BRYLUvHRslpUM5RAp4ZxzKp/z3+lxvqj16R6qow5DVv8pmC4KBJDTFSkz6oLwgD1PKLtF6OMrHaNfqs65ia3vV2VrenHFtqyrsCa6v5PLYvMgUl9ajlRphhTGV7Q52ISZyjit70O9ju2LV0Eq1squLMLl/We2nf4ZbVNhu8ujkQWq//Iwves0Dz0B8xChhnMza1Ll0lg2nbL8iXUA3yxBybXsthFoVq2K6YM2BuciNEW41ANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=etOlo4IHuHBp9VTSc98tFfKTrceJcQEbdxGRTY/p/7Q/IwK/XaFFlDQdxHnMfA6TWyPjRPp/qkhnmGwH83Arx7sb+ElkRGqT/0bSsKjS3Fs+g0RS/YYBfIedmNDz3jcU9ycFlHJ0BZw+YgqsWkm3lX7z73ouqM7/RKVYZvuHBw7GMR9Rvu9AitjNCJNqhbwS9pXC1PchbaPfcj83VF0jDi/UcXRrE1+VoqzWCoy0Irsr8+uN3971uZAPWXv+/kHcZ34BBv5DrE/WyLft3WeOBOvobyEmVch+TQOZ1EADHzjiXQpQw+MGrgRdzPSJRvVIAoucuTPl0yV7Sk5Asp5nKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XBxSiaNm/yn1FduiXnf6tGYSdcbY0ms39wrWWbT0zrRKUaquvG0Y+ZoW4yghBeYnSP+KiPgSzEk4JA7XkUw4lQZ9WPYaQ16knurAZw7aGrEn+jebWXSchuBnxn8ZxkOtSmPdsDLHkSsNBGSUrQTWFn+5+zMAASrWVcNSNnwkO7M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB1253.namprd04.prod.outlook.com (2603:10b6:405:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 13:35:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 13:35:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/20] btrfs: submit a writeback bio per extent_buffer
Thread-Topic: [PATCH 10/20] btrfs: submit a writeback bio per extent_buffer
Thread-Index: AQHZUmaW3hr+dwuBcUKSv07wvaf68K7ycx2A
Date:   Thu, 9 Mar 2023 13:35:06 +0000
Message-ID: <3fab0732-c1a3-b578-769d-a3c73f88ee20@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-11-hch@lst.de>
In-Reply-To: <20230309090526.332550-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB1253:EE_
x-ms-office365-filtering-correlation-id: 4e8623b9-4122-4db0-3e98-08db20a31878
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KGlaTAjVRrVo8B3khxR2N4oVOSC0srx8+r048eASj0KLTXjXXeU7Y97+jMjL2blDyrl4/ua21O/gdJ3AaM2GexElJw7taMMMhzp1ehEw09RG3zXp5xDAUZFhs+YBrS7S4VRWXBpiPcJ8kJWhxBthvDpbE0VJN9gfAEMyRJBJoO7eciyv3VvR7KoBcK9Zpo3Jx1XFx4AR6+qCWGE5z8299zc9p4Llj+P4vJ4k8R58kT9bSZDt6kMt5Lgtty+ebZpuu1tdMfMNYsuVhja3ELNHLNwdpP+hjbqSXA2ld32zAQiJiMwM1DPiKNuRZpiAjHOJaQtjoQsId0HyCXIH0FywBporX4IokbX7aH7opqz8zp//j8jxSFlbBFF6o/basAbSNcUYkBqaQkAFHkm7su2yV54hWj8mw+lEbc4fpt+2XyUGzDLUhjkwI1Gx2Qn+mJ6o/xaSnPH+yJMLoaxMepBzABXHqNHDQxJrDNORR/waUm3NCrul9QduethKVLKKNobABb1Y/oa7yRaT66EDrr4kHmRaaq3yd/b32tE7R/vNom27sBvSbacaLiGnpLnzgDmUvHgx3uYkEJMBrlZI7P4BAmPcc21ft3cdWmrha/EEqHFP1ga/u2jknxZH3EIQDacxcGZSrqDxNPGSfZO8IP8Xuq7Hekv+KwkrJDqMo9R6ftBvZ6JXGgrL+GBuT90MhXGYCVwU7oQD973xjpSd/XXPJ98S9T97IAGZJDLxU/D5EQ+b0or5msYiWUTouFvwFvNWUzBotfwG7zhJI+FS1L0gKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(41300700001)(71200400001)(38100700002)(2906002)(82960400001)(316002)(122000001)(36756003)(38070700005)(86362001)(4270600006)(186003)(6512007)(4326008)(91956017)(31696002)(8936002)(76116006)(66476007)(66946007)(6506007)(31686004)(26005)(66556008)(64756008)(66446008)(8676002)(558084003)(5660300002)(6486002)(2616005)(19618925003)(478600001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXExR0lHTnp5R2JyVGg1VTBNdXpzVkxkb3Q0TTc0WGt2L2lBN2MvYytrc1ZM?=
 =?utf-8?B?aCtUUEttNk1Ob1B0c3p5RUpCOGxTZnNMZmZGcFNzQS9NbzU3amZyMnJFZjhU?=
 =?utf-8?B?VGxWdkVNVUU4bGhJRS9aTnZxKzVuV0FqdmFDSDVFU0JFZFEwbVEwb2dWN24w?=
 =?utf-8?B?ZnhwcnFxN0dnY0RxdklFcXpPUW16Skllb1hrc0ZSeWRwMk41WjhncGMrdUY0?=
 =?utf-8?B?RG5MVmZlSjhHakdRY3ZJUDJXMHZJV1hCaFM3Qi9aM1JMS1NXb0lLVlNsY0c2?=
 =?utf-8?B?MlZJSkF3Z1RYOWZ3UXJmYnJqdVBuL3JYSERFUlFULzdwT0t4T0Q4YWV2aWNj?=
 =?utf-8?B?WGZVOVVCLzd2UU5XNEhpZWFlNkg5b292Qm82L3crdWQ3OVR0MGk5c0xDQ0JJ?=
 =?utf-8?B?Sk9vZFp1UkI2ekxDVXlDTHo2a2FGcmpXVk9lcWExV0VDK3JzeTV4bXhHRkEv?=
 =?utf-8?B?RFM2WnBTQUIzN09vS2JaOERFRm40TVlVTldGSXlVQWRpSnREeHNDcWN3VzVj?=
 =?utf-8?B?S0swUC9Lb2NOL2h3MFoxcjZUV2RLdXpucTBrUzNFVDJkbkhLK0lMREMzaStr?=
 =?utf-8?B?ZmF6VGs1MTdLcHZFdWtlNnVTRnlXd01WVTRPYXRhTUE1SmI5clREcTU0QzI4?=
 =?utf-8?B?cDRpaUNFTXRwZFEzM3RWcWZDWEwwa1N2c3AzV3FIbEhabWE4dng0SURhN21K?=
 =?utf-8?B?WVlKb3ZDdHJrMVpCbGswVVNCczNGaExlUXp6a05NUkRNK09nY1hzT1lZMjlD?=
 =?utf-8?B?MmRnRDhQNnVwSnJudGR0Z05VVU0ybkc0UExXTlVrRExxZXhhekY2SG5vemY5?=
 =?utf-8?B?QTUrYU96c0FWWVVmVUVsTUVkejYzdTAwMDlBdmc4YkZrZjdvT3k4RkUyNDFp?=
 =?utf-8?B?SXRHSllxNmx0WCtYc2cvNDl1WGhGL2tTMEsvaSt4TVhMSkUyVXlWR0NXbjFx?=
 =?utf-8?B?VVYvVndYQTFGSTFySzBHWkpaeW5WN21jL3FGMTRra0VMblJ5QkdqbHp6Q2xt?=
 =?utf-8?B?S0pCQlZBb0doOWkzS2tCeXYxR041b3Jsd2NvNWNSZkljNHhJWkFGMm1kZENs?=
 =?utf-8?B?T0J1dWR4NVYvTkkzMC9RTU13Sk9mVTVVb3R1WmFwcjA4N0QvQUg3WlBrSHRJ?=
 =?utf-8?B?Q0ljRll5aDdzallxcGk3RldJN3VRNlpRQWx5V3lIYmpSWHRYajZabzliRnky?=
 =?utf-8?B?MG9Ta3RORW0wUmhldEVrTmNueHI1cnZGRkZBUm5MY0Y0bHh0cmNyVmM4eW5Y?=
 =?utf-8?B?QWxWd0t4dGQrR3A2K0wzUGZnQ1d2L1JldkdlR2V3TmROeWV5cWIzTC9sNkVS?=
 =?utf-8?B?YnZ6Q3BsWmx4dGF6NG5yUFR3dnZXdml6Q01nQXJyY3NCT21FTVhqeHBhNGRl?=
 =?utf-8?B?cmgrRDczNmFxNXNrc3VhTjM3emN2dTBUWitmazdUVUhjakhLSkZHcDBVQ1di?=
 =?utf-8?B?c0hqZEttUWVPRUgrSHd3clQxS1EzVDFseWMxeW9IS3NWS3dIb2pHSVVDTTJ0?=
 =?utf-8?B?WmQxNjRuYnhNNnJJSlRtbU91MHZtQlZOYTRQekMrU243NDh6NkRSZFRDTEJs?=
 =?utf-8?B?cWhnamRobWpzUnZGWWdnSlYvaDRFaysxVnA5N3VEa0xVQmFxbUZsRDFhUytV?=
 =?utf-8?B?U2dVUUNhdHpLVlZKVnB4NUN6SUxha3JwTXZUZjd4L01zT1RhSTBuUnJ6YWZE?=
 =?utf-8?B?cTZOUU1rdE4wZXVUZ3g0SjRlMUNZYzJQc2o2RjZLYUtBcDlMek5YdUxGK2wr?=
 =?utf-8?B?eGE5NzFHSzB3NjhnL0JhQmtOUytZTzh6Q0lrR2JhMFlISnBHRkVlcEhKUWVx?=
 =?utf-8?B?V2hnU1d3clJ3NGtma2pVak55aVJuRmdjUnNQWW91Q2l1TW9STk5wOHpsTnM0?=
 =?utf-8?B?SXBHMWN1aWl2Yk96eVlJZHBIWnBLVVhOZmRwOEUvcWNZdUMxMXY1cmx3M0w5?=
 =?utf-8?B?R1RLa2UrNGlsdU5QNC9ITWhxQmFsWUVqUXpqN2Q2T0dRNzE2L1liYkEwYkZR?=
 =?utf-8?B?MTltMmh3QW9TRm84SkxSWGhNVXExaVJIOVd4dXlyTm9yYTcxSDlTajA5SEt1?=
 =?utf-8?B?K3QzRjMwVWpHY1JZRmFNSTJGcUJhZXZGZlpqWjl4aWhZcm9xVWk1Mnc1Vjla?=
 =?utf-8?B?VlRBVElxeURId3R3cFpoQlBlUWFjVnE0Z2U1cXozeTNvem85RC8yWnpvWk1H?=
 =?utf-8?Q?kBphot/n5g3SHM1Qb8jjHc4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CA42AE87EBC99448744E2A13CD72F61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WYkZu+XbnrysnGKQwn96EX57InY9+ITRQ0+aFn2p3Tv9GCaO3wXv0QTrlsGcirSDGWmbuqghcEQyrLVA0KloaygXMei/Q93apoHG9kD6ev8+zOZbieMVk/sHRQpSqMpQn1mawrITZgxlAdutas0mSX27HFJRXRdQ5g9LHH3/THK4wvVwDdx5BXgH2bwgYPsCp6l+bslIXzhL+IASmnce86NO1+kiznMI0KaoIN2Jm6yOGGO3ThnKRSnSLH/bG2NQyNZqRhvMNAnYcj6YbeONV2OU9Wqe1LBj2F13Fz9PvmqGs/XyCtDhC34hj69TNfgqauU0WqIfcB4Q0t8zRebBFe1Y0eXBNIZvSyUv4fGNaIM8WobGOayV+C6ANJ+gHL3o5DKeioNgYrUGgvFY37rYfXyJSdkco8eSYGillQhYAkfCqxHTVVh/aPoqYXe8hwlzSviMwd8Yziu5MlDY0RaVPXRf+x8Xefj2UneYk7VNK9CbPEhaQypLA68jXx1IYkDiiWYUrvopFNGdWtmmsbeXDqBL5ftBMDSEHGssziTinYPC79wQ2K17YDd9JcQZGfjrsYdulre6HwMhZdnOB0tJo79oac0N8/iwDZvp8mGyZ/zCLDCzfqsUdc7z864G5FO+lnqjqU7SMpoKj4bnwTbpYPbtGbxFYb6whiOD9L+va9gUe+biS5iATGjRASlstooY+E+TxEkXF9ByPw+qfmH/DhnA97lHCojmvovl8nMgIT/DCVYIaqDhFihpM6Icp+nnxa3sPc/bJLK07YTp7qPp0G/GX8G+EwRU6jBXKpYBc8qdhpK8s1id2G+j+AVlwmpwslKVWzCiZHd4p1o5VFUIalS8mT1P9aFS9dEcJgbSkiIIGSm8/M7EtkYWANgHUZOi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8623b9-4122-4db0-3e98-08db20a31878
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 13:35:06.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1alCFJ+UAS78+hroB1X0Uy4ceXFwMlSe2enQgUVWKJcqN6dGF4aVSicUEBtGbpwFFANla2niKftJuvf6qshGe8pIEAl/SKevoJtEavzLVGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1253
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
