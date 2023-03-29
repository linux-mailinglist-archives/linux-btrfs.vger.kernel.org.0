Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2506CD643
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjC2JVG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjC2JVE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 05:21:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F430C2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680081659; x=1711617659;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OdM4xAbAoI+kBZumX0s65Hj+81uX1cbRhBIfT5QGFa0=;
  b=eJ4oz2PYmYaglM1oaHwlcJZUqg7LMnQII2u/13449/xUWK+eI9im2xQ+
   NlrMotTaOAnO81W7cy7e5pno3d6h7ExuQcBMgdfC73xj41Vdt+1N4s0N/
   Igo4SnEFvjsbhz7/F1aQpvWFRZiBaZSvjpHtebnyhhOhk8em0FbuWzzRk
   tUOOZQzNOcgttjzC//UNfPWEPd/ZtRdYvbium8ml/CvSBZpggZHKJMRfU
   vFrot2vvw4WnwSy1scbqiuiwbc4C2OLkNdzpJuIpJMiHtJvFHeP8iH3qF
   0+egyXqTFAV5O87zZ3l0fld4nBd/F5RVSEE7U1PmchDLafkHzrTZt1Jn7
   g==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="225058624"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 17:20:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlS2Eh9O3VijB3jzP6B2LTLryjOL1rS9UsaudSKbmkCy8VKk4K7cnqczTYawRjJEMMtjn2ae0Dkh4bDBVBmY9K/pL1hnO88PAoU4ksRRPVMyYnDunGl8W4RqbIScuJUgX3xda4wZcfp6r4cjM4MiRdkJhFzo/NN8zLa3pMcQ+60SrKBXY7pYq5dZ+gNstZ39jX+/yRpSuLbiPD/VXf5cW1pCKvsbwmG+cpzFTXHEQO4ObOVUhJxrSzzafcUSwRSstMzRoXjj4LE2hF2jLneuXV8+pB/Y3Wdosa5Y7MJqOg3rXrgbScqvzk90txnmxLoB3bN9TLudsHcWZ1JAgTejXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdM4xAbAoI+kBZumX0s65Hj+81uX1cbRhBIfT5QGFa0=;
 b=N8qxJ854mMqJ0fnCTkEm60qDRygucJSpgUzHg5OYfewFVDCy2mtTzklauGCNtT4Bpq99WWZ3+8K3/wsLJN8484JJ9159Xm0V/h3gdP4Lc4aNGGC6YgWerwyeK+QyKWG4D28sJBkShsJYt//E/qJ0sOPG1vbW0rvdXwqr+0hiwIr+ATYkR6mEQF9SqjHLxs3hLi1pGN4awsBS8ML54py0aadymGsrpe8/ffhck5Stw3h3fTYm35IRxCwdAhPjCnA0M4ztzzROEUhocfhhTxdIVIajnleJAdw5oKFTGX0gU0VzY/Srb9iCsAr5yffHm5cd3QR9HjP2Yn8QfwdNEruvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdM4xAbAoI+kBZumX0s65Hj+81uX1cbRhBIfT5QGFa0=;
 b=EYDgQwMIRsxsXrIkR+m9GYL5zin9P6eTbShGY7MfSVd4ivpxcA8GcMjBCKvNe8HMMia/Fh0UmdwTKhSz6VhezW4o+5KyIt9xwhkf/uX4PYLC8UtRJDolUdWnS73XJZmq40yg5hxvv5ZH31nvwMxjtc8OdB/VpwC/oYRc2VvGvbY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB8326.namprd04.prod.outlook.com (2603:10b6:a03:3db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 09:20:56 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::9265:d244:59dc:1d3]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::9265:d244:59dc:1d3%9]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 09:20:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v7 01/13] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Thread-Topic: [PATCH v7 01/13] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Thread-Index: AQHZYdENh5FUtUmafUiZtyrwrHeQ168Re+WA
Date:   Wed, 29 Mar 2023 09:20:56 +0000
Message-ID: <b9b3f8e8-1838-a40d-57c3-100955563541@wdc.com>
References: <cover.1680047473.git.wqu@suse.com>
 <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1680047473.git.wqu@suse.com>
In-Reply-To: <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1680047473.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB8326:EE_
x-ms-office365-filtering-correlation-id: bc81b4fc-3482-40cb-b772-08db3036e707
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxvHUl8rWzLz0nc9nPb08WbfPriwf6ls5Vjplhv9iIMzPYbvtd4zA033rBe4A2BPlOnzMgwzGWhGdRWMjG6eg1/UAe09Eh3VLLBQtUKreZ94N4O76iS4+aNdVRzkZwWNHDLqbnjCBfFl/FlMfR4zj/+jyi2LdHhpdjIRuaPO77dzkWmsEJYtH6F1wloS+ST1+OPWNGNYg7qLsx4s4Aw0Dm41zJsWQ/nw6mjvvOQMhZdAlWCdOK3EAOgXilRe7yk+z/qz5l8sGbKbVxj0WuT4z6R3nkYND/tMddsPHkd5EQJnmjULAKC7Awqa8cqlIpbk522sJnDqXqu96PejjNMlT41SQqeOC+HwzLriaoomxE7YyMODzvMxx7W24RhnNHp4iQlJbQNFlNw0OWbwWqeKASbXdRCXUMB4cJGCk6EpRl95/8exfIzdSgjQl0T5NKI7A/AEzsNzlXHcuWh6dyh3jGj7gXfozCgGIgkuCJEp9Jbwg/uYKMqpS8D5kSnwM0QZvuXp5X5i5L7V1VDu35YT8xqHiM8DxcKe1ql/CpHJCnuu364OvPLlMYXw3VCD5hLIvZcnKnveS2amGcjeu3Rlmc74/OvIBQSkQ77WpPGo2GPQoc+LUPhEJTWQ+PO6t91NTCx3LDRCVM8JQM5ei9PSBGr2P+/Q7R0xFo4ZNJfQrdjuhT52Upz1TK0fYnPrWunA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(53546011)(6506007)(38070700005)(6512007)(86362001)(2616005)(38100700002)(31696002)(122000001)(82960400001)(4326008)(36756003)(8676002)(66446008)(5660300002)(8936002)(66946007)(558084003)(64756008)(66476007)(41300700001)(66556008)(2906002)(6486002)(26005)(186003)(71200400001)(76116006)(91956017)(110136005)(316002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRKTWhERC90dWtEZndMZXJqdEtTTUJFOW1uQnNSSmkxTFU4UUorY3dCSXRI?=
 =?utf-8?B?a2Y4VXQ1T2JWeWQxTHBNcWFyV0JBeFNyc25NekhmUTM4b2pDRDFIR2JieW9S?=
 =?utf-8?B?ZDhhcy9tVjdDa1greFZ2WWRRZ2hBbmw3TkhSQWsva0J6Ymg3anFSdGE4dzJT?=
 =?utf-8?B?TytCMysxQnlnYUROZGxGZGhFOFJ2L3IrcW01NTJZOGsvWmdSaE9SSXVuYWg3?=
 =?utf-8?B?NWxtVEJHcSs3WTlCOVloUGY1OXhOMzd1RlV1TmdxVnByZVp2bGowVGZqYWJt?=
 =?utf-8?B?bUd0Tm5iVEhJRVBrR2Z1T1Y4di9lNS8rdkFCVmtHSzc5Q2RaV2gwbTN4ZThT?=
 =?utf-8?B?RjNMZE9qRkFRa0RYNjRuRUtQZldyTU81RUo3L3ZVelBDWWRPdjZIb25Cdnps?=
 =?utf-8?B?eDFmYkhqNmw3S09zeStDSERSUGFOd1ovYkUrR0txbkFPNkc2Y2JnWUhUWjEw?=
 =?utf-8?B?d3FEYTVrbnRLVVo0LzM0SXNqTTVIVzhoeSthTlQzNjlnSzRsYWRKL2VPNmdJ?=
 =?utf-8?B?aHFINXBHNlVQbk9lNmJpcklncktnSk5aQXFiQ0ZBTWZWTlk2RngrTGRWb0J2?=
 =?utf-8?B?RWg3SG80b3JXdTJLZXhRckZjUmdEbGJQeExCRXF4bnhPMXJobXhiOHNCbDMx?=
 =?utf-8?B?R1ozNXBnMzZQQnllYUpiRUZ5aVJNcFJHNmRRWUdhc3lQUHp6OFMyaGRQaDRP?=
 =?utf-8?B?d2Zlc01PbE13RDUrV2ZvM2tTMU4yV09PU1lWSkFLczJkcnBrNTVYS3J2cmsw?=
 =?utf-8?B?akVSd2NIVTRXOFVyYldUSkdibEdDSUVwZVlVNmREUDVrMytrQUlkVVkvWWRM?=
 =?utf-8?B?Zm9MZnBsYjhRVDlnVE1ZYW9BQTJ0RHJtK0RrbmMxVzNFRERVYW8zWHo5amM0?=
 =?utf-8?B?aXVTemc5eHVFZ3BUY1ZTRXZwb2RMQXFsaFRxUEVXRTkvQ2cvVWZzcGNDVUN1?=
 =?utf-8?B?UzFXZjF0aHJ6cE9ZOHU0bXV5WEdqU3doUmZ4bXd0M1hVTVNoOWN5ZVZKL0xW?=
 =?utf-8?B?TWZUdzVMQ3Vnb01aZkFPdHVSRVhqTTdFR0ZJNExSQ3Nvb0RXTTBxeGRFdkp0?=
 =?utf-8?B?bFBlc0w5Q1grRG1qcTFnMEFHZkplbjhOZUordkgxQlNCeHd5UUphTDRXSkhi?=
 =?utf-8?B?Rm1nUTRCL2hJTjRTVFlHTUZmZzYzZFJZbHZvTm5JVklwTzVLMlp3dUR2SXl6?=
 =?utf-8?B?aHhreW03WEhOQy85NER3dDMwUlMzQ3lPTXg3VzUzbkdOczVMbEdPTEZ1aGU0?=
 =?utf-8?B?U0JIS0hxUFRuRzk1WHlIU2ZqUVVaMmU3cFJ6SkU0MlR5RzBrZTN5TUJPY3dJ?=
 =?utf-8?B?VHF5VHMzckxQL2c0L01zeGE3K29YdXphb3RUanNFTmlyNG9qVG81TjJvenRH?=
 =?utf-8?B?UUZONmQ3bExjMUpTS1NlNUwyRFdDYXkrb0pjTVpLb2pWVUphdHZWaWNLK1Ey?=
 =?utf-8?B?ZThaYStmSVVaU3FXY2UvNWNtbTF5dU9iYmwrQnNXSHc4SGF0ME5ON3dOTnha?=
 =?utf-8?B?Mk1DOW9WSGFGRStnVEt5VGJ0TTBROHZqNGZoVWgvaWpmTWcxRDJiV1dRR096?=
 =?utf-8?B?aUd3TTlxUFl5UEFRQnY1OFRkSXk2MG9GWk11R2RIbkhSRnpFS0J0MWJTSVlH?=
 =?utf-8?B?YU9wUXd4SlpGLzkxZ21YY1J1dGkwK0dyRVdJZjV0NGUvZkxPYnVFam1mTWsx?=
 =?utf-8?B?NktkQzJYbFUzS0tVMUM0TjQ3TVM4bWxXRmVKSFJKbWk1aVpYTFVINzJBekhS?=
 =?utf-8?B?OUxQSWQvbGVNdnJHZVhtcHhTRG16dWxFZ1ZvZ3NCLzVOZHY2eDRrMGdBOUlJ?=
 =?utf-8?B?RmIyTkJMSXltRE9Ld2UrS0NnaHZ1Sm5HVDZXVUt4YlVhRXlhSU5KdG1QZ2Vk?=
 =?utf-8?B?Zjk0b2l1M2JLNEw4QWlLdTVHKzNEeDZDYk9FYUFIVHVvZWY4WkpDUHNlZFJT?=
 =?utf-8?B?OG5KM3VUMUI1UXVYWXdSN3VQYlN3TEtGMlFMZlVNSkt1QWdia2k4Q2E4Rkwr?=
 =?utf-8?B?SDBiQ3dEQ0FyQllXVTBRY3pZeVo1NXB6b1dybDRXZ09sR2FyeXF0aFhHaWl0?=
 =?utf-8?B?S0I4ZHJ5cFQxdDI1OHRkNDJUcEVCSzVVVmVPVjY3OEU1RWQwb1lDWllLMlNo?=
 =?utf-8?B?Mmd1Z2gvdGpYdGZxS3MxaDEzWVhzNjBmTnRPdFJWRXBOeGFpdURhbVhSaytX?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78CE46AE03451047AFCDF9D212611939@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SEgraDob+GcD21gIKrE3RFofL8NBIgCDwwYyPelg1Q7luGKyY49KBB7mpRFUsDhYo88pMrK7jtMEoogJMi9bBo1SdJbvTJd8fCoWLXYLksj4RAAq+wgFqrn0g6cpn/cj8ciYdxkvbBKTX/eJhXQYfa4oYggdKU2E4EMrvbdWczZH5CgI3cjvCOo/MrRSyBsXA6iHL/CJ7QaPy2z5CUs1k6LtjA1/UZohnfbS0AJ5Csg9iU26FELMBzkSg8AA9T9MdrJLHBC4EjY7Fq6yk0TMXz7XwmgWTnwWuRk1Hy4gyU9hgx1+Iv22nmaT4G3dybyQKMpZ+5aO29CYcDanXr8gwzuCDFs/xQPRGNyoml0G7XTGi4JLf9t+RxXqvEZJEsLIgo2jE5uRAGlFU3sOtPjSU8wZ/m3dmPOopR/tQ7obMvAd3BwMlwWzKC80pFwAH40fxTalmVZMpljtEQBY7rhf40a+A5kVlNR4Brt/3daeVWRlj8vNt926kbc9dswIPNBlhnL3j8Ey/wBmYk4AjCD21iLH0b/H0nlq7+uMn7f5MQfKOQER2taJPv7HcQw92Jr4mKe/HZPhx3y+dQKHL6ZuGgTAXJJT0eTVQ4YiqKwExsISq5Y3GRyjon3Fkc+IjjrwhvZhzp/ETnh4x69LYuSoCC3NufI7Q4ub0PUnhhfN5QXkFmczINUrN5DLtVRsn5qqT9ahf607vRmrTd/7TuHN48iEox4yQ8jIRaBCWXTvFZGOdts7jxZ3c866WvPrSMWa5QkPzNFv9c4mgiAK7AV04a6GBBrM0yCL8BRFTLo4iP6HGW7s3CQttb4mTXyMRRp3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc81b4fc-3482-40cb-b772-08db3036e707
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 09:20:56.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knGXwMjI9qx8HeqtGAvNMnABf9ey9dz1laXcV8Y5aDPe0m81H9OLcIaKIpXnjt+i+IWf0DbTZqZtKj1unTN02HBlTMQWfOzYrTldXQEdEIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8326
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjkuMDMuMjMgMDE6NTcsIFF1IFdlbnJ1byB3cm90ZToNCj4gKw0KPiArCWJpb19pbml0KCZi
aW8sIGRldi0+YmRldiwgJmJ2ZWMsIDEsIFJFUV9PUF9SRUFEKTsNCj4gKwliaW8uYmlfaXRlci5i
aV9zZWN0b3IgPSBwaHlzaWNhbCA+PiBTRUNUT1JfU0hJRlQ7DQo+ICsJYmlvX2FkZF9wYWdlKCZi
aW8sIHBhZ2UsIEJUUkZTX1NVUEVSX0lORk9fU0laRSwgMCk7DQoNClNob3VsZG4ndCB3ZSB1c2Ug
X19iaW9fYWRkX3BhZ2UoKSBoZXJlLCBhcyBpdCBpcyBvbmx5IGFkZGluZyANCm9uZSBwYWdlIHRv
IGEgbmV3bHkgY3JhZnRlZCBiaW8/DQo=
