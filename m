Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DDD6A81ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCBMLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 07:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBMLG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 07:11:06 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FAA3E609
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 04:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677759062; x=1709295062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zyUPf3IH0k1sxfBg6bSgnQGiAZ0o9peliIUOiu38Cq4=;
  b=iNjgJU9Kg5sB5rZDIfdvt6dwVEoULFs7TS300XfcDJMCt31LqnMR0qLB
   JW1XbLpcNv7yI1M4kIStXAI2wzCrJY4qlym+YRkNARFaAJGdZET9cy1uH
   ZogHwpG2OvfKgD39xEDkKli8YFOp5KAoC/LGTuv65kPcIL+JeaTU7icLl
   E6aTgV4xUM8rjdlUPIpan4nXG22B95rAAuvWykvO0UkTbZJOZskhkF9R7
   qBhe6SjF/vd8U1K92gZmP6sQlR2CGMSWdXRnaEN0w3+8BBhggqnbx103j
   YDm85WzC9Wc7taX2haqyJi9T7x58rWwUl4gasYPtIDDXa/LLHmSDyQ59O
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224407681"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 20:10:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA9b51haSp4vKPBBRHR84nl1w4o0DyQ2hKE5fKcMce4aJTCUmBbyPzyWzRoKWuty43q5wx0MsmsN2OtitwyFf9QIfsFFT8tCbFvtlA6e9cK/xhPcSfN8i7bSjBxSKr+BSuXTFREzXL7M5/3Gjn55CUX8IQPsajG5C7KqVTzglMOVYy95EmY8guV45PJ2EeWYoRTiKeVXj2FyusqIBL/oo0XbbXLrmZl6h3r2TZ+7oonwr87IXRor6CyV9ye/PZHSrS8QnrgNNn+cKT2/l7ykOYIcG87MelOrBqttQ0oQlnOj5Sae/z92sFOoz0r1eoC7d5C+aF+pY6QeBHyh7WU3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyUPf3IH0k1sxfBg6bSgnQGiAZ0o9peliIUOiu38Cq4=;
 b=XCkzfGDfolQvehCOJTVgU/p2mHWdoKBF5l3wNtzNQBDnhNp3bczTSnwIA3n0MqBxHTqC6ntJi0kRMB79yxRtOynLSILrfdU7/d4kInG5vPRNYfelCbN86H4aDQ96N9nRsO0vPVpdLCq8YSUVzaUQUCsRFv224OibC+FPpZe2wUsDTYfpIBN8J0/G68FJhereoXgTjdhncasnBXo2exFG98XQLVdT5SX5MMcNmXF1eM454tPzegZ/M/D20HFe11ndrrg81fy0Pa9fwkw3bg1l9aaAfIUymy89cnkVnIrrj1F5rmkN7rmtjH0G1F1OwAFa/sfPIEPd26AUsd8u1Zy8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyUPf3IH0k1sxfBg6bSgnQGiAZ0o9peliIUOiu38Cq4=;
 b=Tl4JPlayaKsDWCI/LNFO9yBMueVR+KIoaGbF9waxYzTYaMb78s/Xu5+Qp9bXaicaLk3hb6OPzowSdSqzHprBOSz3HyXCorlay+LEQHPdyZ0LzjiC9OWI1kGgf0JjhZoWrsvqdwlP7juarhrPnfKV0BzjpJI++cj8Ohgz/+X9tXM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4334.namprd04.prod.outlook.com (2603:10b6:805:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 12:10:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 12:10:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: remove unused members from struct
 btrfs_encoded_read_private
Thread-Topic: [PATCH 01/10] btrfs: remove unused members from struct
 btrfs_encoded_read_private
Thread-Index: AQHZTEO7elAshmFvrEmDevpqeux3Cq7nZ4+A
Date:   Thu, 2 Mar 2023 12:10:58 +0000
Message-ID: <0e21596a-91ec-6ffe-d337-40c7bb216d71@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-2-hch@lst.de>
In-Reply-To: <20230301134244.1378533-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB4334:EE_
x-ms-office365-filtering-correlation-id: 42dfee6a-b5c5-41dd-7aef-08db1b172e97
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dM1uT59kk+NgdlhJ4x4M3rULvlAzeT8SeZujBLUgXGpYBoBkkqMGy9Tab39BSAp8gPxVAS9G+JwzhRHuxsX/0HKW4FdZ17Dh6EigR1DGMk55nE0oVMH7J/QHuS/W4EBB14Zo2bTqIJnvWe/id+gVeVP/hwFGL+LXPUUU45Zzr1ZVw39hSZPgsX96VdNuffiXJlApuuF6IlJLYITYZKQhO+Yr8xYI7Vc0B8IjGsbhMClJ3LRJvcJLCg908WjKbbDUufrQ5cOTFGGsVT3Yixnes2qMNQ/fCRbgIEZxDrWMlDjnocCeyEu+L3hNH0j+ldB3koVzfs9nU2f/9yoivAzlzEHQ4cISFUb7naRFFURgl/wUdQiAuNYAaOaZY2iTMMQzDhWex1gTBL12v3pVpuq6u3btLZBUahD2pFlcfQbqwytxIcBIXFMt+yYfgdAlPEurWSjd0nzvu5Psx/3mGkjm34gQkSZSUC3FT5JLLxIk292lIAL62YBfdjRHivL3aS5KhP4JKRT27fN7QZYEPy4p4wMkVAnnR3j9ELjQMuyJjITYEAYslRbh6hlhx2rHu9+MTQAsbQwXsUkrNWweRnpvCOnp2DHp1w/m3OLnDEr//th6CkQvA6yKlb8wSW5nfjzW1tKTqoD5jitE8xsZajS0OCQjL6pYA9N0n7+hhA3/yUvvfNGXRhZXBgY/SvBLMFlMLMamGR0eVpOgiDoluiAUzjQPPrj5xXFsnzcnOFm6GrcW161mAO21re5t4ePNYnVy+8Tj1wndpm5AjwgYHkqK7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(31686004)(36756003)(41300700001)(8936002)(2616005)(6512007)(8676002)(66446008)(66476007)(66556008)(66946007)(64756008)(53546011)(186003)(4326008)(76116006)(31696002)(558084003)(86362001)(2906002)(91956017)(6506007)(5660300002)(478600001)(122000001)(71200400001)(6486002)(316002)(110136005)(38100700002)(38070700005)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkNBS1lmdDdRckZEb01uSVJ6dHdtNE5HMFhlZnJ2Z3NPKzRDVTJBV2FOWnNN?=
 =?utf-8?B?c25IdUk2SndXcVBQOE1iL0RzVUJ1aFRHR0tpd0djUjVYL3U5Uk1GU096b3hn?=
 =?utf-8?B?RW5iMkk4QmZMcjVNMVc1UXRMRUttTWpacVZZaTY1aTlyY1VUWWZSOU85ejVp?=
 =?utf-8?B?Mmd5QzZZdGhSRVF4SGVFeTViSlY4a3RLL1JYTXJwNm94andkblJ1elp1Qmg3?=
 =?utf-8?B?aHFteGFFNXpXZU0wNXBTWk5FVSt4TmpJNTFXcUs1UmsrMDZtTFJsQUxRc1Bm?=
 =?utf-8?B?WjFqeFpNT3owdElscmk0WXlyS0tjRDJoSHAzRE9UWGtTQWFGSnNiS1BUQ0F3?=
 =?utf-8?B?SEVWUVZBV1FBUUNBMU1KdVg0WFBGZzBDcFdET2hiMUZtYnBwV0RwQnRYMytu?=
 =?utf-8?B?bEdBQ2pkZWZVU1FpS0xIcWc1VHJGWVVrSGxsL2xhNmFLSUYyZEZSa25kZzlL?=
 =?utf-8?B?L0ZpaENKb2FzL3RtY2NXV3AxN0RKUHM2RWZWTXNUekNCenR2Y1JKM3pKM1pl?=
 =?utf-8?B?QXJmRHhZNmtnTzVZWWhDcXhJMTR3c2pKMStEYXVlY3BIaUVRZkdoUU9jYlA5?=
 =?utf-8?B?YjdzczdkYU1QTmZmbW9WRzN4clJXWGxlZzgxdG8yU3BKYlZVVllPRTk5TnRi?=
 =?utf-8?B?bXVPMTl6VDlTVTZEWDc1bEtkU2g0Zm1FMVAxQk15RnA3WGlqWnNrNVpjaUo0?=
 =?utf-8?B?N3J3cTlSeHFmTnY2TzQwMUN0Nm5XdXNyejNqbEpVVTdiMjAzTnV1V25mdGJv?=
 =?utf-8?B?T3ZDcEQ5Q2d0VWEvemJaNWRaK09Yak11YWd4RHlRcEVuYVhJUWJvTnYyYUN3?=
 =?utf-8?B?K01aSjlNMEhMdXA5eE1QZHNEUkp2djdIZUVaNmNzcHNmMXcydWpKdWh4a05U?=
 =?utf-8?B?RThFSDBqODNRUFZLb1lkOVpaVGs2WWZ2M0pRd3E5N2J0VEVJNmFNdjRGV2Rh?=
 =?utf-8?B?TFZNeThhM0tWTXczcndCeWZMZFpXbDFlUzZ6VXh3dFVmSmpQMGp3TENEV05v?=
 =?utf-8?B?bFVtMDh4NUlaRzZPZURHU0s4UjFyUGJQOS9QUDUvNG9ncUN3blErSDVMRU1w?=
 =?utf-8?B?NjBiKzhTTCtzcWpEL2p3Z2w3TDBGTytPUk1YTURlcjJjbHRBWEpVSmZMUGlU?=
 =?utf-8?B?bVdvVjdOUWFONlRFVEd1YmJrck9Pbm1mNE5zbTQvNk92ZTY2THpFUERMVzF4?=
 =?utf-8?B?ZUVQdGhhaU9WRHNPVlZJaHpCaTdKbnFVTzJTeERIbmlJSjBtQkJXeGdGd252?=
 =?utf-8?B?bjk4bldaUVFoUjNGb3pqQUx0Nm1iQU9lYm5yQ0U5TUpvRXI3N09rbCtWVHdD?=
 =?utf-8?B?U21CMkk3bEt0TFc2UHlCcWFVWm9UeXFFaWJBTXg4RTRNQ0RPYVRiSDd4TWpY?=
 =?utf-8?B?ODRVZ2FXeEJ6VWtIQ3JLVHU1bnNVSm4wMWpOMkQwQTJwNmpKU0o3Q0NzZkp1?=
 =?utf-8?B?a2pjTVJRY2tnekM4aWorWEswREFvaUtjR0xvd2NscisxSkN4YjZKTUNLTDV3?=
 =?utf-8?B?VTlqMjV2TXNaMVRFNUI1Zlo2L3Fodk81dWpDMUhqblRlVnR6VGVpNG9tc2Ry?=
 =?utf-8?B?ZndmdkhuQ1RTZ2UxQTN6OGlCc052elFNOXdkY1FFVXh6ck5ORkp2NExKTkth?=
 =?utf-8?B?bG1EZXI1d293SG03b3E4Zk9QaTl0RzIySFpMa2ZNY0hMd29NWFI2Y2V3T0pJ?=
 =?utf-8?B?ZmZCU1lOcmkrZS8rYjNKR1VoV0dJWXVSU0JmbmlHY3k0cEVEM0VsY2w1bml4?=
 =?utf-8?B?QzFQOEtuSGROKzdJQ0oxNFdQZTZESm4rZktGMS90WGNYOCswS3liRGdxakNy?=
 =?utf-8?B?bGZIWThVQmZobjVzZTFWdEEzb0p3cE1veTcwNWN4MGRIYW91cjVJME9pVFZm?=
 =?utf-8?B?eDhqR0RMOFZPTDF6SHBCb3JlVkh3UzRuSkNjQjU2QUQwYUIzdUtMRCt5ZE5U?=
 =?utf-8?B?UTZDd2J4cWNnb21zQ0xVSHZETzdTeElITnF2TzF3aDM2VU0zd2hNUzdTMXZG?=
 =?utf-8?B?V1RTNlpFV1B0N0M5eXhBZGIxOGVHYW5xTEUvazNqNW1VY1RGSFRPbnR5K3R3?=
 =?utf-8?B?aWllR0poVFkrSThhWEhSMUZEb1JET2ZpRWhQNDZTd0xVVG5GNXIzL0lDenY3?=
 =?utf-8?B?K2ViekFZZ1BuclNGT1B1K3FQRjR2WUpTSFFmS0xWbkNndDJwTGR5clNnblY2?=
 =?utf-8?B?RVUyOVowTkFmRng4S2d5aUZyVmxxZ2RqUkpIaEVBMVJvNy9xZjhDdmdRU0lO?=
 =?utf-8?B?YmxkaEpselppWU9McEFWMWJLZWNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85EABE640896514EA9BF5DB70ABEED4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MWo1i4t8n2EE7aFliDdfCMSTX4Px1NyMPx0wNda3TCdZj0NsXC2rTfYVB8NBF6GwHE4Xfz63siNfrIG9c0VxhtmEYtRjUd8nBQQ0tgiGlnzkqpaKK8JkZHJP55AFK+C9huy5V2247j+ORcaR7Y+Wc+yUL73oDvVaOjrAdS5Rv+BY4jhVb9ZEX1Hw5OFtmrhHBAzKC+bi0bdme+ll5FF07Kby7D4TrdbKPBA2P0uAHCBNtKckx4msZFKOzpCNWaS/2ml9l0C2+vH0PTFaoPByxqqdyk87Y77kn9D7sLMdnl7G6K5T6gISk3JEXZOVgypZrRsFjSPV0QBjK9gA3I37lyoUlQV538tytGJ1tf0d0tKE8CbukViI04kwSJg29lyPANLQHYygOIGseNi+7wDohyxANeV0SJESOT8h1JNL7TkldZSP5/o3CNj9pLn+6ZlrBfNzpnUmjm6wB5cfugCPOZM5ShMuiCyGiPbJWC7VS5y0J2FQ+WBF64Mz4X8bi87WRnOOTso4VyrN020lGrQgy/Xdj/g7olYjeldh7DT/jcfw1fDriJ8y6E2e/J1eRj00Tn54YkUTXl3wsmxDTio1aV1RDpPeRNx0iZOLyGufxHH3FrqQ5t2hzUiC+ZeXaGdwPgpYPVjOTft5M751jYyZxeSR1GQq1bwzjhdV+edKLHNGC+b6lh7CpOX/7L1vQ+WDVsdxxcOtThgf4h+Ze+o2kI3GAGdh69lA8LSNUMbpM6fUp8Wg+PhmeLP6rrqIwrIHo8zuzUg2z1049dUzXRyp6ZbXlLFM1RVcUHdebwaDYTQWJzbKoI+gxysBExrhuXjNdKj0mLcNQE/H3DIBlvTCjSQtaPu5TVn+gkKYAX9BrCdERFE9bVJ++FBSqFKf9iXm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dfee6a-b5c5-41dd-7aef-08db1b172e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 12:10:58.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0w41rVKNFkOWVul/+/RdqHInWWLj/6+U0auK6mQq3cyHq8HSLCbCziPJFHUQo4VODde6Tl5dgEJOu/B5Q2BnSkmcKn6kiisWyRIxYXJzaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4334
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDEuMDMuMjMgMTQ6NDIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGUgaW5vZGUg
YW5kIGZpbGVfb2Zmc2V0IG1lbWJlcnMgaW4gdHJ1Y3QgYnRyZnNfZW5jb2RlZF9yZWFkX3ByaXZh
dGUNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgfl4NCg0KT3RoZXJ3aXNl
DQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2Rj
LmNvbT4NCg0K
