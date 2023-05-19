Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15DC709AE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjESPJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjESPJc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 11:09:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23341A8
        for <linux-btrfs@vger.kernel.org>; Fri, 19 May 2023 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684508968; x=1716044968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FZi7tpj7pPVI7YpR8Be7b0xhE1erB9zpG7gl8NkEhUY=;
  b=mGItirxPsKhnexbLVpL3RhvGixL3jUhuhPnb+g7xK/Wc27XLck796WLl
   N6WPYu4jATl4JPqYcrxff19MxVM3OoPUlq2B8qlsa9M1xJD9CPGIaA+cH
   +VeNjI3BIAxctb1TPsxotp01RchjJduKh+ondtv53puY8KnPIBUyATs/O
   70W2KzYERiyJD3T1T1qP964Q2fdMkS5QpXf82pBRg7yjPfHMXb25i8ol+
   0lEt8zDNZ2xL6SU6qPSsFZyPm+0aCb8MeBaH6hMiP0+rUeG0foKfT1SwJ
   Jkc/2AHS9BKOOZ49T3kSwhzm19+iJRbjj13REAS2gLCogs2T4TvWVDLUD
   w==;
X-IronPort-AV: E=Sophos;i="6.00,177,1681142400"; 
   d="scan'208";a="231207770"
Received: from mail-sn1nam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2023 23:09:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdx/SVGWu+iAMJJxVHge5D71STN3t3vlxXIzHboglSvN3wxSSuf+CYj4f11LjAR6OK3XOYnk7f+VBE3WRPTEt7foZQuzhtYsM32/GrzbMzy1GT5WNVhDuip4lh1EH83QdwAsUaQp+gzUXo8Mc4aj5Ud+HpV7RolOtwXpEgb7TM4f8sO3NOqlTB/ArD79BkuNxPsrJgyKzGyJiW6KIrc0AqdGt30bKbTNgo77rwyO22Fr7MLcTu9vBKpFwLmodsSF1bV7w+mPdMp/PxDieEdXT+hwgvMTMivw/9/fvFgLm4qRod5HhtDCdP4fhFHjUgBSAfJD9pBOuu0KJiLDbQDJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZi7tpj7pPVI7YpR8Be7b0xhE1erB9zpG7gl8NkEhUY=;
 b=b5aZMC0FqSG6oK8s4SBmm9labVMjzDxY/CLqnmINFb/iWmw8O3bKKms22z+nnNWQ5q1tE16/PchkkO5iZcE8kCATbVzGQTMh7E69ndqu4t1GP0fim74mMPmwMabWCLO0CSDJAbyJ8vt7FIt2HwgbkOc2RniAuxjjxy0c2tG7zQL8WpmHmCDCtZageCgzcyjAU6kZWCMJKPM8sEFAHB8PzZCo4XtGVhMxABDAMZjgYXMrLWju3UmbHPpYBe8bkJc1cJKi7JHtpT5mBwuLA2tQKA/yaDQ6GVDkKSK8NMYqppZram4iJFY60fxzOr2VQ8AcSoH8nXavuJ5ucYu5IBNeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZi7tpj7pPVI7YpR8Be7b0xhE1erB9zpG7gl8NkEhUY=;
 b=jtFBJ2KB/STt6mwJGfMF/g5LdH5MSa0XtC3O0dL9wybMnC9+96F/cYwOrmg3SgnMZy8z/1c56l5R3jOEE8ltlCHK+l1dWebb01EcOonYLJqaxEtcQmNgXjerOfX1F6g5VsGsf7/HatRIk5DL8n4+h34c8Ub/p7Zg+SIZ1op6rQs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6744.namprd04.prod.outlook.com (2603:10b6:610:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 15:09:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6387.030; Fri, 19 May 2023
 15:09:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: call btrfs_orig_bbio_end_io when
 btrfs_end_bio_work
Thread-Topic: [PATCH] btrfs: call btrfs_orig_bbio_end_io when
 btrfs_end_bio_work
Thread-Index: AQHZhw7SmkQA7CG6k0W7x9znFfluMq9huayA
Date:   Fri, 19 May 2023 15:09:23 +0000
Message-ID: <2706bb39-a7a6-f04f-89be-427914b98d49@wdc.com>
References: <20230515091821.304310-1-hch@lst.de>
In-Reply-To: <20230515091821.304310-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6744:EE_
x-ms-office365-filtering-correlation-id: aa93e45e-168e-480d-341b-08db587b07e4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3GB8MQCAyNVyFT2xHoDm226D+CuQ0Qjl7pnXbnK30E0eqMJx3cmBKpGqP/TqqkwAUIvBB/s0AvEi/WFupnixtFxee9DoH0+Ojtw6HERzAUFqOz8TlN7BhF/wNEN+ahU7JKfA1PiDoSxgmc13tyZR8099nWWjTkvVjWyWoevdPtUJn6yl9SDe64hjoWn1KJ/G1f2LrKZ8wUVUmOttbOCMnS5m3NZz/sToSgcMP1ABNuxJd+S1KC1nZbz73FG5Lormm5lfhnLGCrjxlKGhUobwDYpw6ymyYYZ9SPgA0CHpZwlvSBcAqlNnyHWotx6IuCCcGUxYlcHJi3cqE1ReNK8xQtrHOuiUTjvl5Fp05o/AHzL9Kj6ZBN+mdgBPo9A0pcXr30oOaBU0QHDTdDH3nNO4cy+M2j/FhP7p4d9h3NdFxN4MIKxnNV13aIh+9QfFRXP3XUj17Ze7mf/+e3pmQBo8MS3vrmNHgDzfo9Eufl3DMo5bGDsiFJ5PAhxDOtPB++9DREiprxJIDNyt3KzleL+54yVMVfpDfqJ4I3OJPdX2UXY2Vzm5shMzxUbeVwVNSv5gZbBTuoNgFWPUV7pk0YGg94egOPiAiR/SiT+eqPjQNkfaYKKV4i5+FnyaFl25352dnHzIam8hqaNvX80TMbvTFMzwNNiWutFFetN9g5s+zgKtsGi5zjqjDy5U1/Xai+F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(66556008)(66476007)(64756008)(66946007)(76116006)(66446008)(4326008)(82960400001)(8936002)(8676002)(91956017)(316002)(110136005)(31686004)(478600001)(41300700001)(122000001)(71200400001)(2906002)(86362001)(31696002)(4270600006)(6512007)(6506007)(26005)(6486002)(38100700002)(36756003)(558084003)(186003)(38070700005)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzBXbjRlOTFZN2RWWTFORFRQM3NLQ2R5TzFFbmlVVTNUOWVZYzVOQlEzN2h2?=
 =?utf-8?B?L2toT3hpMStmakNtMCtlZk0yU1VNSXhYaUxRTVJwMGR6OHdlZk1yenhzVUJo?=
 =?utf-8?B?cWdQWTdEZHVmSWs1UDlkOU4zejBuQ2VzWlRhNTdlUjlIUmgvN2tiTDRIQjNj?=
 =?utf-8?B?NFovOXJpY3hKRm9WakJYRnNCb3RETWZLVEtBY1J3d0t6NVNYYVhDODJsMFpo?=
 =?utf-8?B?UjdjYUJBVXJ1bHRlbFQ4ZHRTUkMzVUpVcU9Hei9YQlplQlp4WDhsOUkxeG9Z?=
 =?utf-8?B?YTNZSGFYS3BMVUNLZXN0dWd0U0Y1VWhrZDJReTN6cDdmbUpNQkdBMVFXUVFh?=
 =?utf-8?B?MkpKSDJwQ0M3czJ6aG41TEI3cndhZy9WRW5iTkZrakt0ZGNqdjMxN2I2M1VP?=
 =?utf-8?B?b1VXZi9sMkNoYm92MHU3MS95N3dNVS93SUJ2MFV6TUxnTUJOMDFVMUdyRnVz?=
 =?utf-8?B?WEc4V05LQWlRUGp1cTZhUnBFbDdWaDJ1TURxTTZ6OHdLYW1WOGYzL0YySG44?=
 =?utf-8?B?YnVDc1pPVEQwS3dxQUpHZlBMK1RpUUlHV0VWRHkrS0dGZS9ya01tZER5Vkdy?=
 =?utf-8?B?KzJRa1NRalVpSUxhck80Q1M3RDRjYVY4YVQrTWNlRmpoblBUdWxkN1hFNHdD?=
 =?utf-8?B?bTB1Z0dQME9yRWx0Mys2emJlRnBMa2ZuenJvZ1RTOU9PN3preC9PZ1orcE1p?=
 =?utf-8?B?UW01b2RUU0R3OFI0c1cvL3p4eUJ2bUNZdjVDSVMwam9NQWQzd3pmZUg4OU5Y?=
 =?utf-8?B?RmtYaUZMZzlwVW9zOWx1d0xRN0FBUmIwNEFTdjEzV1BpUEFUUVhoVWdHaGZF?=
 =?utf-8?B?TzlscHB5M1g0M3ZtSTZkVG1QZVVqU2lTSWo5R2VOdXNyaThtUzk3SUVTaDkx?=
 =?utf-8?B?RHUzNDlPcW9icTBtK1RoZDFnM3lpVldSc3JXV2w0YVdJVWNGK3hQUVlCdTNH?=
 =?utf-8?B?Y0hqOWVTRWpxcm1teXo4dkJ2NG5KYy8rNXd2N0dBYXV5T3JHK3RDam1DelBo?=
 =?utf-8?B?MDRwQTV6SHBZMlNLbXRTUUdVWkY4a2ZQMVlEV0tyV1AxdFJFUlZ4RHlDbTVF?=
 =?utf-8?B?Y2MvQklnQWQ2OXNPblpDNUpNSXpRN0FVMjluZ0xZV0NXSEdseDFkendvc2Ev?=
 =?utf-8?B?MFFoeVhTK0lZQ2RHbmtLSVpsaTR6UVNOUmdYbnh6RElzQVc4OWMzVy9wWlo3?=
 =?utf-8?B?SlVBd2pFYXFuNlFOcmtKRS9IbGhGZUUvNkx1SnJkdVNMelp3MXZ6K2oxUVU1?=
 =?utf-8?B?SVJUa29PUS8wTExnd0NteFIwUGY0NEtzVHVha2tBclZNejh4SThGYWJ2V3la?=
 =?utf-8?B?Z3ZCVXF6YkFNakFSUngwN3hvNkFublhnZE1zRWZtbzFweklycEtibmVQKy9h?=
 =?utf-8?B?SzRRa3NON3cvTGpjVzNlcGh5TEN5V01QZ2xyNngxL1hKdEJ6bzJhSTRuKzM2?=
 =?utf-8?B?MVh5S2ZOeHVKZENFT2djZmsxdmxOZC9nbDRuNWJiM2J4dXFvK01jcDZFdmRu?=
 =?utf-8?B?TmwrUUxsbDBROXdXMWNmVXRSU2hucmFXRUpXOThtTTRjcEtWTG94UEQwWnUr?=
 =?utf-8?B?d29CNXdKdkE0VlhmSkwvWTNxNWhnU3o2cDRWYjFGc1NZL080ZGpYd1RJTnVE?=
 =?utf-8?B?YmdhUVF3U3puWlBsay9vSThOZXp3UE5YNzk0TEZwWk15MlpucHpKSUFQZ2p5?=
 =?utf-8?B?V0MxeTlGQ3ZZMG4wZ2FSMk5iaFVtMEhKYnVoT1pYZkpJQ1QyMU5RQ3JNTWtM?=
 =?utf-8?B?MkhOcnR5SGtjcEhsc1diMUNDdW5iN1VEMTZYM09EZWxZeEduK2pxWEdpcEJZ?=
 =?utf-8?B?c3ZEeWhSSU9adzFkZy9mcXhjSkdGQlI2UnFTWmE0MTBFUURkMjQ3Z0piSFMx?=
 =?utf-8?B?NDYxS0QrMmhzRzRhbjZCOHpaWEpSZ0lhb1FuMzM4OVZrNE41SnNhRnVVNzBU?=
 =?utf-8?B?VXdOaVhpY3Q5VThGVWZyMWhRc2RhaTl6V0NlZkRDQk1ka0tmVTdwWmtTZWtG?=
 =?utf-8?B?b1IzbEFwZndTSlpPTTIrRDljUUZBTFJRY0hKYUx2N002Rk1lYktsZHROaVdv?=
 =?utf-8?B?US80dEppSVRJNmx0cG9lQ21RNEdUMXpQU281czRQMDR6a0x4SnFZRXdkZkJa?=
 =?utf-8?B?alZ2VzMyUVdoR01qVzlDaEpqMUQ2RzZvS1hWUE0rcGx2S2dOYktOVlo4UFJj?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFBB0A4FAA791341A1D8F08CDCF037A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7QS03x1n8re+uVtx7XWUzndD5Ab9pP4CkIBs9iIN7IoPuR2Nsxhof5c12qdFxC56j8QzxgKqQVafNx0YYcPBpSKTqe5xisz9iP6OJJsioDCQqQBx4WccoBbk2Ddrwj84XVrbh8Tn5gHchCRhqyvafmFP93LIAEnra1y4BZ8AiR1RXGX2oeaoXUvAQaBccdCsTGCexEgactn36cGdA48zbDaPJMBO9quAhNulUzQdlYwPljNIyGbfvtDKTaVl1nMtLQ/gmVfQaRcBQaAuaxRSOt081ybe1GG+TlqYZd4vdnaj9CxTJ9U0gIuiVZQBScTpG5PNdBFCl2KujZNFCmjX8HouEjeMr2vn8qKfSXInsEqfooAkh5s4jzkCjXppHSgdKbaDfF1N+wz9eZXWVtsVv5XyD+gAf83L+9fZaVGBcwGyac+vItahwXu/Vnjyj/IMFI2vA6CkoauCjTor12M9L0LWEUn9boWkBT3idA0Uv1uDAQYEzmDcdPvb7mRbkD5to2R5ogVS1olpmx1g7GKmiMZwlP+iyjXGTVzC5n4G+qhFr6nJgv3rzNAnClXUGmQs+VK9psgANlRvpC9Afw3Q+dh3aEP7YPNavwofJdaaU63yo+ojYwon/D245DydKEvSmUvCfUVOUXawn960xcPZDE0vaVsjyLy7nuT9uXqWRD/XVh4WOVPWKVlawN5EfrTvYeYpvzOVDxELT7OB+yqyhwT4+vSj2NihohFFhwgUPsejMaFRrBwbiPE0VgBTAKVXcnwkxnlQHq5rZZjXXjKv65/rxwVVD9JDsZCS8VyWTVe8nrjXw2id/K8LvbzHuUf+sL3tK1KQMkNZzzA8guRuahAMWL/JKVy7QTatM+ewUKqJ+C5D7kcDoMhSJ1ep2fG6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa93e45e-168e-480d-341b-08db587b07e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 15:09:23.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtJY52YLjaHIPJNtKimH+/RDHbL6btPpqmbnDtG3xysjxKzcU+uHdVhI6yT5ApmPnIpjroyFzdXJtv9OJS2LrILyr8z14sxKbX8V/wReaB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6744
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQpUZXN0ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+DQo=
