Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DA76B5A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjHANTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjHANTb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 09:19:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F291734
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690895970; x=1722431970;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=TJvcu1Z1Mz51out5FTfVLsD8PTGJD6yLaYl5y/xrDFw=;
  b=J06Gbcd/0gx+ykGEvA2sJAvK1XEVVTUiwza4m+/9aaGjiVbHIz9jCOiO
   SbJyoOAEy1SFQuJ5Zhnt5oeJA3B0yG+U/AQkv7J7BS30L4sR3HYyb83hF
   qKsRL56A3sTDZvQYg/12uFiJRuY0ht3NHxcRoVOnKUTy50xOy0s7LLHyG
   tdpluERjwmixEn8NkwfAbFYMPnafcjmAV+un0M9yCUcodFNksaE22RCqV
   zDIfwI8C+Bg/AFZHIQBlTLjjqSXlujNOYsYCyIUGu0svS0xMKT/r7L7MY
   Qs9MpNVbYyIJPnOjFPdmvheEM5KzxJeJuQamlyJ1exf1Ajrnqs4ifcPkX
   A==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="351781795"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 21:19:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjEcO8S1whQ+6z0i6U4PO1dPXNNfrlWU6q5D96OcCcgAZJH2aeyV++M0SSOPmJbOeI4XEW49Cj9KrQL57OVI9JacJZmltUTpHsYA/fcWwbVA3007ArJ5e3PY9YkQ+TmFD39mbkTTb4l2rJQkJTOHGBFx02D1NVUeh9Rxu2tOqc+Zp0meTkU0DzuovIXz3B6Z/gKjILQ7kOf4V3P9cpNAOKWjoHbH6sblu6b/Ocrl60ZhkV1A6aTV9BqDM0qKG58ou6F9U0KUYmBwxZHCh/hlX/szZs3wsyJ3SGJ97iUw2nYCwpGi4gXIlSF/+aIrPNiXvMR2M483RDAeSEVIes0e1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJvcu1Z1Mz51out5FTfVLsD8PTGJD6yLaYl5y/xrDFw=;
 b=SjUFInm9Q6XbTKoNxZAsIh8Hu8HCdCVPc9lW8rle2sHe6q8EsJuAzxxDpRfagtksBQl8D9mNnkIk9wARPd84TOAoh6VyZgLbjlp33zhKky3dSNMZZrNRHip/hxDz8Ta/mvMxgo/Tz2VVHu4GIlfxodLNKKhMvReBzdO3igvZm64hsN2TY5N1Bk4W9hb71VWQcRUfEe03m2a8vtiKZMxWYhE6y/folgWC8MccEoJXgAWwGrPCcqL8hNTV9mXuU17QsnjvQTPCsDeZNjNGhdDr3TShMivy22LuzU81YhN05kiLuCzetr4Vnme2szPl4SJzN52qfLtDVsURWTO2mAqOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJvcu1Z1Mz51out5FTfVLsD8PTGJD6yLaYl5y/xrDFw=;
 b=LjRxhPtp6bmyMF3mKyly1iq/wXIKc54JYOhMqNGaQ9AVMIkeHt+ZKE/zlsGCCC43rz7+eCheHqpbAyy4BhF/YKxgMOfgTpUgtHmSINQA1KOE71XFswLyOGJJScNiJE0X2Geg/CVK0UO4le2AhLuNss1bTQ8fLkVttXTV1VUB3iU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7276.namprd04.prod.outlook.com (2603:10b6:806:d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 13:19:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:19:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/7] btrfs: simplify memcpy either of metadata_uuid or
 fsid
Thread-Topic: [PATCH 2/7] btrfs: simplify memcpy either of metadata_uuid or
 fsid
Thread-Index: AQHZw6CtMXBvO9ByVUKQUBOyTUx17q/VblIA
Date:   Tue, 1 Aug 2023 13:19:24 +0000
Message-ID: <70dff6b1-8fb8-9c3a-ffa1-f1a28120f6ac@wdc.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
 <371de895b777e1805002a0703dbbd4fe5a5bf3f3.1690792823.git.anand.jain@oracle.com>
In-Reply-To: <371de895b777e1805002a0703dbbd4fe5a5bf3f3.1690792823.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7276:EE_
x-ms-office365-filtering-correlation-id: 8e8ce74c-98ea-466a-76dd-08db9291ece2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfNLNl0nUh6dQCw01FMXd7kYxQNDaX1zzdAr65xoFT0nO7kuooOKjHW8MYxmudKoizwEEJDuMsXNLgWpg9hTe4fRHKRWl5eYZSRdY0wXw6pr17o4Dd2ePB0rhprCz+JUG3I+8ys8GGZI7WOpSyVfYfLyt8eoIO2sDtcNAm5EYZHBYU3QsW7kl7Bd2/+A7lgnBeNidqStJ8Ccv1pYx2dXBkyUu7KH4egWqDetJ0/WMzNYSCSEMk+CKsCVnI9LE+QwuOsWoLvR/7cVMJAxTFua9C4lAGCCRLLHx11FlljbuR7ngZY1vS2VUvBx5JoM9KCTJIhoeXwkzHZ/ZdxZ004+D/DpzIK8g+4nK5/fvSaWEzlcizlbPzL8Ai3pHxwXLZEsIEJNiIQ/yffKuXEBXqpUljKAZMDmm1s+y+YbjOU8P3MTWj+8aDUOYoWBJUn4/PsB5nWH8NLQgINcuQvIlcDC8dzoFpOKQwhhA1mjhLk985c6v4J6sl6NtPBKr+anQz6f4priAAhu0maiK6vs/S/NcxeQfFjBqE5rhBGPxqxNYrqVwuIINJHxSYQ0mSnpWWlmp6BPQq0VEjR1Ks/9wCN1xjRD/nIQgsUeu6H8UKU4XA7KQjmnbwJMvObZauTERjAEBRpFhe8X/mKEvHPAH+Xyc1La9YLKtF77FFerJdPKxt8JAuVEqM9o1RT5dr3tVyZx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(2616005)(38070700005)(36756003)(53546011)(26005)(71200400001)(31696002)(110136005)(6506007)(6486002)(6512007)(31686004)(478600001)(558084003)(86362001)(82960400001)(38100700002)(186003)(122000001)(64756008)(66476007)(91956017)(41300700001)(8676002)(8936002)(316002)(5660300002)(2906002)(76116006)(66446008)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVwVURKdW13WGs4Ukc5ZnZHTFVWOUdoaHU5alMxRWMwUjdGTHJ3MG5YVExC?=
 =?utf-8?B?TlFkNitpM2Zma0pKblBUTTI5dEhPejZXaXZIbkIyYWx5NG5CbnJDT1paWDYr?=
 =?utf-8?B?ZWIwYUgybnhTb0wvNjNUejMrUitSa0VjYnA2NUFLSmd4SzVKUEdOYTB6WTlk?=
 =?utf-8?B?OTQ4UlZaVVZBazNya0tUOXRGbEgycmx6UGtuNDFwcCtNbDltazIyK1BGRjlE?=
 =?utf-8?B?RXo2dUZtd1JWZUsrOUlRM2k1TGNJM3BQTUh4dzdPTE9CVkFHdU1yOFZTODVK?=
 =?utf-8?B?c2FxdmtzWWxKY0RNcldBUkQ0K0NvWjYzRTRjeE1ENmR1d0Nlb1BLZjNtYVQ0?=
 =?utf-8?B?ZTBsWUtGaWc5Nkp4TmFUMzQ3K0Ezb1J2bURDbEJXRnVLMXpyK1VIakhzMjlk?=
 =?utf-8?B?Z1k4WkFEU2ttSG83ZktnOU5NZlpRVTlVWEFEMnh1ck16RmE0RXZ0Nnk4MGNw?=
 =?utf-8?B?elhLaGNaTjlrM3RtaG9LYkxYMGdTYWZKRmk0RFFib3ZCLzZMSERSQXRVemor?=
 =?utf-8?B?UGRZQmQ3SkFWV2taRFE3dnRBUnpmTHA4MnJFS2JEV0ZNbFhpRE4yeVBTUEZU?=
 =?utf-8?B?amtvNHFaVWtHd1hSM1Q2VmxrclVPdURzKytoeVdzdHJZRkV6WE1DMGpVbnlC?=
 =?utf-8?B?bEZJbWZKd2VSNldVN1p4bmhJUTFXc25EbVdvNHFRYVArV1hUQWJnUUFNWFpK?=
 =?utf-8?B?NFFKcWxRUTk2ZEV2K3BJNGhoYVM0eWtGSlEvRmtUYmRQMk1KVW9vVnBvL1pO?=
 =?utf-8?B?NGRpd2w3SzdEa29HUWQ2aHp2Rmc2RTBORmRZOFM1Y1JsZ0hGbWNFMS9HdWti?=
 =?utf-8?B?R2lsSlFPNjNsWWpSb1A4dzNMdE9EU2VCeE41YzhLRk1rTVRrbU5TWUowUXdv?=
 =?utf-8?B?cGtDdXQ4aVRNUmRtVm9MaGJ4YmdqZkk5Tk1vSUYrdlI2MFA0VVNLOFB1Wm5S?=
 =?utf-8?B?Mk5WQmtRWjh6KzQ4K0VhUW9MU2FkZHJja1dhWURveWRUQnlmNU53NDlUTzVu?=
 =?utf-8?B?VkcxaUc4cWdZNUlSTXh2YlZ6b3F6V3o3QzdQMjFOZE1XQ0JUMWxEZW9kNWlw?=
 =?utf-8?B?dVVHRHZBZ3BLRUdKNHJvOVVjTld5TFcvMVk1ckFuV3V5QndHWHhCR1BobE0v?=
 =?utf-8?B?bDYyZlVndVZCcXZwa0VySnM1bFdCb0RlbW54WUV1c1NTaXFQK3FITS9CRG9M?=
 =?utf-8?B?ZE00N2x1blFtOHY1UGF2V3RpUWEvd0RaREpoMTRJOEtCWXVtN2xMSmFMdHNM?=
 =?utf-8?B?Ykh5SlhSSzF2SjBocTY0bXFxRit1U2pGdmFRRlJGWlBqZDIvaXBHOGJKK25k?=
 =?utf-8?B?bWJJRnFNOFJXWWlRV29NNzNlWGNrc0QxTFlKY2U2Q3BDb3VsUzhoRTZTRWVF?=
 =?utf-8?B?ZnA1WXZteGx6djNhK21vNU9OZzlEdjY0NnRDZXlXRW8zYUVPTFAwZFNaNCs0?=
 =?utf-8?B?UlE1Z3FIRi9sZ0ltREZPSkRDTXF0UzJiSzE1MVhnOVBmelRXSnFtZ2ZtRU1a?=
 =?utf-8?B?Q1dQbllTTTFoMFRSTWlNbjZzM2NmYVJpakJJa3FqUGFocytTY3hNSXFMVFZN?=
 =?utf-8?B?d1diTGlpTVBCbDZkWU1Wb2FWbHNDNWhIVDRGdDlkOFp5UmxnZmVuZXV4TWY2?=
 =?utf-8?B?TDJpUzRMOXpYUklmZVFqWjdGeDhNT1dQRjNHQU8yZWExT29RejlGWWJnTlBJ?=
 =?utf-8?B?S1EyT3pQTmV2QjBQMzA3cDdvMGg0MCtEblF6Wm5kY2FTYnBURmJVTHhLNEZ0?=
 =?utf-8?B?czFUM0s1UXhaYXAyVmJLM2xyMVpvenZYN2c0SUdVSkFIRnJmakg2em5laUJl?=
 =?utf-8?B?S29Fa1NyeEJlN2dCTmE5VXM4aDhoVndVbVhnL25zYVBPb0EwbGpDS3d0K0F4?=
 =?utf-8?B?SVNZSmNvQ0pYNEVBRHk1QTh4WDlwZlovOCtNby9CMlpRMzB1bjR6TXV1bnM0?=
 =?utf-8?B?MjliT1NtQmRUNDRNYVVUM2pYalhZTHczUE1KZmZyTCtGMW5tYXNvK0piR2d2?=
 =?utf-8?B?bjVYWG5SVjNKYXdhVUNzSWU1T25ETDFjY3pMZWl3WWdLMnM3ZEd4aE1XZDIy?=
 =?utf-8?B?S20zQmVkR1g5MTEyNmJoQkJSUktQc2ZuajhtMGNlL0YvR1crMm1JSDhMMEZu?=
 =?utf-8?B?bjhnK3E2bDVkNE5FK2p4WHhyYWRBeVBQSnl0SHlVZWRKVEFBeHFYdGJlM0RP?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BCF9C3541B6C94F9C48643226AC01CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gp/fYbaM55zXTuom8RT+hUx4byt/2GYOy3nuVFl85ZGODyozzaj6fmsFPAtHw8IErXkxo7ciL+WazLW7zzUShH7eAVp6PIBjnyGmb+b5IKh/zYa5BjAT5F38/ctm6c2aimgzCUZmumH8e8V0tXLghElmvBZGiCo/pXitru8rel2OMytyHYEzIosZnsJ8SxI77DNNOE1YQekyJRkg15JKBvL7gm11X91sAQ0PGkgrjEhF7EbUyOWAj91XxQ4c534AkMizAqm4DKBCajHQdy3e04DTfAChI6pzj0zUlH+r+FgpEhFJ9q1yznzoHU/v+Usy0cRRxa2s1+YWyXRpiCGhBYvqxZk44vKierIzBr5szmqmK5PKlptAYtC5ACyV5qeQFWdu8kjyqPeyYLDxKqcUqGce5kVdynhyGJlgFSoZordE1U2WcacpL6rKL/fXfCnbPGyeub0dGVMUcV5qql0Qxe+2xR59nPh7+EwKaUHKv/s6FlkZLdNSewbIQTbg/O34zvJzdGfgw6y7tZ2l5uQ/4o4r+gIVvf3Hjbq8PsdjcHLJ06IzaBxW4hhf5PybqWrJmEqTp9bbX6PTHj7SBsGxsEH9rdWNuSRVbzig0IOJgiAXDpP9JNGpgUv67E6vVaB3MoDTGWyqB/H40QPWyUOgLaYk1Oh2MG9715WMsjrNlLp7N4ZNncddYs50g6ByAyLGfRFlm8XQuMtSMjZChJqqUGbBjEyuBFfbeis/LEeLD7lVl7OSbnl8P6thbsok85rKEZHq9joPK3oS1iHGxwrfoOAmquAciSO5rf9rpAeA2tcXj+2SAjVFqVaVMf8PeEEb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8ce74c-98ea-466a-76dd-08db9291ece2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 13:19:24.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5liShS06Y9VYr+nPNXHtWatowx61ii6+01b9g0J8CPDlGDSn++Hy4sdP7Dx+XTtVvFecJNKwwGNitWXQ9OIz49NITjA/x7AXgEuaB6ibuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7276
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMzEuMDcuMjMgMTM6MTgsIEFuYW5kIEphaW4gd3JvdGU6DQo+IFRoZXJlIGlzIGEgaGVscGVy
IHdoaWNoIHByb3ZpZGVzIGVpdGhlciBtZXRhZGF0YV91dWlkIG9yIGZzaWQgYXMgcGVyIA0KPiBN
RVRBREFUQV9VVUlEIGZsYWcuIFNvIHVzZSBpdC4NCg0KTm93IHRoYXQgd2UgaGF2ZSAnYnRyZnNf
c2JfZnNpZF9wdHIoKScgdXNlIGl0IHRvIHNpbXBsaWZ5IG1ldGFkYXRhIHV1aWQgDQpjb3B5aW5n
IGluIGRldmljZV9saXN0X2FkZCgpPw0KDQpDb2RlIHdpc2UsDQpSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
