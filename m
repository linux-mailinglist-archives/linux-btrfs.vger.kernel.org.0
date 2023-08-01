Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390A976B59C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjHANQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjHANQr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 09:16:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B31AA
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690895806; x=1722431806;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9yW+h6wCxKG7VlKYvVScGtg6bOWaH8XEYj7t//7JnyE=;
  b=Wv7bBEK0wTOzGIkVdmfESCjzaD0kOyItb13FvZWQAQM9UsHK37aFuHyl
   /VgLKZ0fZCuCwcZz3GEQwG/FAoefuNgI0zG2gTKVIOKeAcNiEpQ7qcUXm
   XOgMlS0U0DxznaSIUBoDVICxT9owtAA5TGV84oTeDrKjVlnNYXF3tuV/m
   oSI00Besyh5cygevNR1VfXjBCiGv7S827J8W8WpDb6MN0m+eN3tl0F1Ly
   xsXj19es0gQEO0LMY4k+/r2QuwbLZYFIhVnBGYoaETqNeYMEkGHVWG1qb
   9ubQoYUpO1ztACemGNvR6Pf681MFaJQ1gqG+dzqNm2ZGKpZ+eG2fnSBbS
   w==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="344889546"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 21:16:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtg7SnePlczGcuE39LnAyNPIqqeixiN0yMbycfVpxbmG9UlwouctfIepSNuubdpx7Z28qIaSdFgG8X1NqYzGe2z/k64VWkpNwu6jMzRT9SFOrFsiCFlvimhdwM2BLG2hK4kDkOTGVBOg6j6WgEfqSkSMo+4zA0kkv06P5IIVmtXNjsKGKnvR7P1JO/hRBiNNYKkI7p3slc1tbsB4/zDWUWDOMe7dJHga10RhFfm7hQRWG4x9/wqmuRfuc/zJN+/SE9L3Qcgy5uMDncZj+9wOY3DhRLGcRf4Mo4PI2a9qYYy/FMbgMZpLgRWJmn1jGWx+JMPuXbVL0a+Ii4c1EKrmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yW+h6wCxKG7VlKYvVScGtg6bOWaH8XEYj7t//7JnyE=;
 b=MRu6nqGsR+16nUBp/nFd2FZK9FmaCKwI+KqOZ6CXbjy9pw1fawxB56/us89Dt/zVjh23aoAqXf79LuaiaYV2pM0qOZ2XIXQEQWp4/L9qFRCbIfSl5CDdvzVAAQqbtd9JZerRf4kK1P1rQzRPdbtDQ8mHf5HtGExh3aroJ8SpV6J88flncq4D4cyJlYCFnEudfaMxmq+fPsB2HGEJwPPOsk4Zh58Rx7kwhNw7nslln6Ukwt+dstvjnIiDd64ZEAQaUWjV+KW3+lF5bbaaZQ3i7MY7jW+a454d1gM4ZGWBfqdczVLP09xwfWouX+HP5auHxPtV/JBSNyzRBR0xOw5i8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yW+h6wCxKG7VlKYvVScGtg6bOWaH8XEYj7t//7JnyE=;
 b=FqphYVKdsN12UjNf5hvSxFLVg07NZ8BqInj3h/KPl9TDo2DJ0BxYwx8OjoXxkaHamQX/W3UPYCloqpRADOC54dZXP1iIl9KSmqMEr25jjhtJvDu875I6Vl5oLTTgf6kNDPnZBcUPz746O3CDpC3KYTgysbht1Iyk2PVw+XSLtmQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8373.namprd04.prod.outlook.com (2603:10b6:a03:3d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 13:16:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:16:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/7] btrfs: add a helper to read the superblock
 metadata_uuid
Thread-Topic: [PATCH 1/7] btrfs: add a helper to read the superblock
 metadata_uuid
Thread-Index: AQHZw6Cs1Qce1Ur2r02HanQEUPRi3q/VbZCA
Date:   Tue, 1 Aug 2023 13:16:42 +0000
Message-ID: <2fe397bb-2d0c-7881-46a3-6dbf094bc85b@wdc.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
 <1cd0b6f911758c85fd135c24d88c3b0b9f0f85a4.1690792823.git.anand.jain@oracle.com>
In-Reply-To: <1cd0b6f911758c85fd135c24d88c3b0b9f0f85a4.1690792823.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8373:EE_
x-ms-office365-filtering-correlation-id: 9c7ba9e0-9c3e-4d0e-bc84-08db92918c75
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mX5udS+ZxSINArMQDNE2S9EYmoVL/xNIIhFNJmmvQ5tm6RiUUJynU7m7QMzCaaDe3FPYNUsKWlGNsJjkX/1zExtJi9/Czw9dSdu/T7QVZQSM0I8mo0hv0He9JAF681ODpwbrLdHv2U6WQe3cKBE9jwM1s4PWG9Naj47SYomJdBVvjLx7Y0cp26XnxdJMWQHKHo1Nz3dUkKD0QCNNk5PE+CNp68eKUVt7kBdeQbb2encnAHHDqTWysaaZvr+0DXRs9LrQ+eBHT09bv0DAKNUB+Og7KUZtVZw9Q/atvNUkXkYMvHJB5YwG8K5ZyTtn4VVzriDWFuIrDBPQcQSEyz+PJCQHrTjgGm6kKeTKZFzC8NIMkySU4TbdCc7an8X9EWPmz6X0SuhmyRl46nr5XIlDn9DjIWjYmbSRRvS0BdODXBPgg8r9vDhRbpANk1Tp7sCaa0emFcvujKa9uCcR7MSr8BwFAF9Kfg5DqT3auEjU1Jk4Y0KRICnZKJGD+3wIjek+tKs8eK5u7i3/ysyDedJ/5nxCFRugWnHDL6JWjwilfxC/gBgxDJEF8HMcqgN8B0lk7MViI7onHuVR/7KbuOdEdo+uwZZp4yMbbMCr1YjG36ntDPizTSqCW9mj9wLRtpyYj+OiqbtHEoW87IFHqvxzhmHiadKtuFtqEUmDUG3Jo44JHRgVLf+4BG0ZkDVRy2b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(31686004)(6506007)(186003)(53546011)(2906002)(4744005)(26005)(38070700005)(38100700002)(122000001)(82960400001)(36756003)(41300700001)(316002)(5660300002)(76116006)(66946007)(64756008)(66556008)(66446008)(66476007)(2616005)(6512007)(110136005)(8676002)(86362001)(478600001)(83380400001)(31696002)(6486002)(71200400001)(91956017)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXY4WUI2SVpsZ3hLbUkvTHZCd0h5cXNPaUJEZmJ0TDhqNUVYSFc2UzQ2K2tl?=
 =?utf-8?B?SmVGNE1TcFA1UWYzTWVjK3FhUFpITkxCWGdiVjdUdlA4SlJld0tPYmNXMjJ6?=
 =?utf-8?B?M1NQZ2NuRFMrKzVYYXBwanNFSDBMOXpraldtcjQ4MkloRXloWGxidnAyVzBC?=
 =?utf-8?B?emZzbTBUOTAraXFMaHZNK3MyYW5zSmdGWEUxVGR2TXBUOGxqcCtTTXBQUWtG?=
 =?utf-8?B?dldZR0RiTGY3TlRnRmdxd2ZQTTRQeHdyUk12M2owNCtSa1dsa3NLQzJ1SUF6?=
 =?utf-8?B?a1ZUZEhTTkIzdmlabkQ2QzlUVkpUVDRVZkc3dXU1dXhjMkRtWXJpbjhEWlB2?=
 =?utf-8?B?cHpsWWRralVTd1FBcmZxaTlXUk5YM1c3dlFJNmxkKzBRNHlKZWk1SkZDMW5O?=
 =?utf-8?B?ZUtXQjBESk05aHBEaFpoLzRHL2tYNEFrWjM0dFl0QU5kRXZhUnU5djd2aWVt?=
 =?utf-8?B?VVYvUWhJaks1Y1YzRXIvS25VK0tsVDZ2RTczdzZzNXd1TVZoQlhMT0J6TnFU?=
 =?utf-8?B?bFF1WmVMYmJKMy9PaXMyUmZxaEk0Um8zbnByVFR1cVlkQno1SEVDaGlzc1Rt?=
 =?utf-8?B?Z2VwQm01bUNuSlNWaVJrazRoemQ2TXdzQTcvSDFHYzdub284ZW9NYWk1QVBy?=
 =?utf-8?B?YkNKaVIxYVVGUkJaVmlRUHFHL244dENSU2h2V2VieWNLczQvc2U1ZEVmRVRV?=
 =?utf-8?B?RjF4MWJRMHQ4SjU3QWRkVFhMcXVTL3drak82eDlQTjR1NlI2WVNNeUVKKzFX?=
 =?utf-8?B?ckpBbHVvOEhyR3Z6bXBOOGpFRGttMTFWb1FTTjhlemo2cE1KSXg1VFRNU0p0?=
 =?utf-8?B?dG9HOXA2L1NpclRNeXFhZ3RBMFZ3aXlNVXNnZTk2cFZkVzhMZ2JmV1VTcDVt?=
 =?utf-8?B?MDdaQ1NlVGhKSWZEM3hBR2xoVFB0aFdaalhBOVBXMFNlSi9tYzc5U1Q3T29y?=
 =?utf-8?B?SVptVkhjREQvUG5FcGhsanNXWUNnT1RYWG4wOUFFbGJLOEZ5dFAwSlE3VE9C?=
 =?utf-8?B?QWlRZnRqcDZpbHIxb0tKT1NQb1BMdWlsa2VRVEl4NmhXZnVHZFY2SDFZdDVS?=
 =?utf-8?B?SVpKc3BsaFkwYnlidEJLdDYyajU0MjBmSHNyS2xpMmVMT0h3UzFLTVpuU1kw?=
 =?utf-8?B?WitFUnBSSHRjRTg1YXB4TGhQRGhNNDkydTRFdUdoQW1IRVpxVEt3Nm9PYks5?=
 =?utf-8?B?dWFPdkhmRkVMMlR0RjZSeklyaGxxUHFBaG1FdThiWlloWHVrQ3kxUXpieVZi?=
 =?utf-8?B?Y2s5T0ZoSythOXZ4QU43Umo0dDhlT1B1ZWUydHVDbllRNGJ3T2MraHJjbXJj?=
 =?utf-8?B?UjNNN1Z3VU02Ly9nbWZQb2czaUU3dlZEKzNVNTdDQlFwenF6VEREbHhWeVV2?=
 =?utf-8?B?eVZTdkgvNVR4dlpTTUtpbUJoUDc1Nk9QcjRrc3BQR0pBaEZBRHVHcUhPalR4?=
 =?utf-8?B?TUhlZ1NPbjNOMVZBdVFKSnhWaDZMeFRiL2FJdGdBNUpscWhCQ2VSNmNyaVAv?=
 =?utf-8?B?OEs0bFZUUEpTSitpckphcmNGMExJVTd2T1JJSjZrVDc1LzNOVkhqenhtU0Jx?=
 =?utf-8?B?RTFodGxoa2tzU1drVklIM3RPRnpnc0QxVnJDdnJML0JtczQvNVJJNDhTWURt?=
 =?utf-8?B?ckxRWW1MSDhzSE9SUGI1QTJlVkYyYmMwanB3R01nN3d1RXJYM3hyd2gvKzBx?=
 =?utf-8?B?amFPRVV6SS9sT1E0ZVYyb0ZCNVR2NjdPS2h6dnJPVFBBYmlscVphN25kdXJL?=
 =?utf-8?B?WVV4d1gwayswTDdrZ1p1c1JLQ2cvVWdVQkdieWl1b1VrQ2RrTHZJVDltaDAz?=
 =?utf-8?B?KzNDdFM4Z1U5ZmNMamc5NHZLUUcrRG12cTV5QnpJOXZIZVJBYVpTZ21uR3FP?=
 =?utf-8?B?VDBROWEvL2M4SFNMRmtDYlE3aHpJOXhvWk5MQTZndEtydjJrWUdKbWY3bVFx?=
 =?utf-8?B?Uk9lODV0R3RFbmRYR1RyWWVnbUJiM2xPd2pITXROYSs2MmJUdVVPYUpQNVQ4?=
 =?utf-8?B?QzNoMDZPMGhFUndIUTlMblhpUmJxOEtxdEtWelQyWlA1aE9aWG9KZGdZYXhs?=
 =?utf-8?B?bnVlbmIrTlQ3ZUlJMFRaV3dVQnIyVFZGaXpYaE4yQzRPUzl0MWt1UDZua2pz?=
 =?utf-8?B?SUMyN05jTDFja3BoYU1jSXRhMFVwd3M0d21KbmVocFVXM3pia25QclFBMUox?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C165EAFE333FB4B96E365ED071C641B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uybAs5rWzMm9WhmZBOLp1K2Y0Oo9zpzR5G5FPp+ltZNmR2c4MSpiktOfSY5OS9BDoWxnDkcoTqx890gXM9BuQ0faLG3UQGAUtvA1EZFacCsgdGw8r4HCcW62/nxMtg2yVxBtmYUzv7B44Txe9NBkd8+oEwI4/CIs0rAxoRGHkFz3DXGdvhTpNYOc6Vjt7slv58AwvqkxnSC7jBdhnga9KKuKInNqiLkTW3ZuzwJTd8UkZY2ATB1r5+tQ6+skQVDoo8SrIb2U7SzxHiU9uyg5XX8CIPdJ/3rbAk3QEzDXMsDJ4tQBiHu/TrETrviX4ooWVan+YL9RIy5FCd3OGNVAdlDqBuZnSrspBB67xHpYQUDGF2Gb1gL3/qio6dUVOT8yleSrtWe/Alg0z5lCPXO0/JDYMAtO+ksBHs+4RQC2f97pwQVWSmnaft5zjWee18qU0RNFXXtvIS2pZEraHHOEGciBO89/sqD9cWCLTEs+rgimfCEdZi31fER/4FVttEghuEXszCDJ3WWMKNiVDAQp1+f+FbCG2zcNkh1W6sUfX3QOh+bXgt/+jBWNEsYuIm+BMsmgfCa33dwOgPvD6c5HPEpdzdSZHss2etjDyfILcOsu9PTcn4QyC9kzJ27cQU8LxT6wDN78tGkJISb359y9D/JJDPQKolaeHctAru7uugxoKiaBgwICI8iBPAl0344X6MKKKU3Q0bi/8AARUfpDGlnFob9A+34dRLbprTBnMDjgbhaWlyuw2vZbXhXTUIYGAuc0VfWEP/Nj0xtxjg/rMTlX0UlsiJ8pZJ5m2YaMVL3RJCANbXeUN3hsgIKMkTp5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7ba9e0-9c3e-4d0e-bc84-08db92918c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 13:16:42.7139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mh/v7oHC8lDtu8qMLZiLuw8oWUAK1JEbf0GEUcKOPWAmJKrza9uZZr8O+eGJEGsNj2ZoxepqKV7Jkp2EWYBwB1Bn5HcfFkxHMcQgMQGt8l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8373
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMzEuMDcuMjMgMTM6MTgsIEFuYW5kIEphaW4gd3JvdGU6DQo+ICt1OCAqYnRyZnNfc2JfZnNp
ZF9wdHIoc3RydWN0IGJ0cmZzX3N1cGVyX2Jsb2NrICpzYikNCj4gK3sNCj4gKwlib29sIGhhc19t
ZXRhZGF0YV91dWlkID0gKGJ0cmZzX3N1cGVyX2luY29tcGF0X2ZsYWdzKHNiKSAmDQo+ICsJCQkJ
ICBCVFJGU19GRUFUVVJFX0lOQ09NUEFUX01FVEFEQVRBX1VVSUQpOw0KPiArDQo+ICsJcmV0dXJu
IGhhc19tZXRhZGF0YV91dWlkID8gc2ItPm1ldGFkYXRhX3V1aWQgOiBzYi0+ZnNpZDsNCj4gK30N
Cg0KTm90IGEgaHVnZSBmYW4gb2YgdGhlIG92ZXJseSBsb25nIHZhcmlhYmxlIG5hbWUgYW5kIGZp
cnN0IGxpbmUsIGJ1dCB0aGUgDQpjb25jZXB0IGxvb2tzIGdvb2Q6DQpSZXZpZXdlZC1ieTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
