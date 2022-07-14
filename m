Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4251B5745F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiGNHqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGNHqE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:46:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425A1F2C1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657784762; x=1689320762;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rFLtURvYyuXJwGXnhsPSmVLQFmeBAIEh2X7L1hu7X+k=;
  b=cmjdLa6IGy4+/yXl3oa0oA/iKnmP/ZnttY852HfwJjBGRA1J1b7uMMVC
   hej8S4QWAYzumqJVDeo8hyFaNrltFfyvQWV6CSa33iA7d3q66RXxDqU7H
   pAfQ/lj+CaxTSnNRHLqKU5OZWK4pfqN8v5STq/5SMxj1xAn0CgTbN2o1/
   7em65eZgaGrVRStGsrL3n+SfN3iDa15aP/sMbRddNOl29UpptmNhzV8g5
   r67XtJAQwj3SbZlwA8O7YPdK0m2xWbQ2Q1dpStOqsGClFcByZXfE8PeQ1
   uG0+uaCXlOIPkwDkShbCatBcJEBE7EPSb3GHi7r4m4nZLKly5Y1NTlzn4
   A==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="317833987"
Received: from mail-sn1anam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 15:46:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avJOkWxaHbwQapgqzcla4ajrAii6CJzHxm2WwTr8n9NARivTfpqhg9FMpwQHRZLSkdyLBMxPZFu1lakhmfIXFJE+fQq2tcka4VK913afqZot/h2keQpryO8J+gNZ3D2oJJ1GXY4nbpzerXCqJVRnYSaaWKcsnThm+H6etJVJC+wJTXWKYtbdLAp43L4bwvCr5g/T+JcMfgbgGub3xnxvanrs3Dqi30YBaefAOOVtfwXtnDteF4AMl74Dnr+d3fLpmBx8U7aQv2NTr3pgMsOb9b3+D/zHYSWE58lf45aT3uEazjTPrsr7KyUoUOwsOEpAfVvIgjQKbhOUgOUWr6d0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVHTRkHw5xDe7yvOSHg+6pS9TXUhWyVMxrXFN3mP38M=;
 b=I8L3hI7Tf6h9e81srJJzd1crxdwUmXwe96Nxz8dXyg5yeUnMSmlwbN9YYLy6Nr9H5QO8g7d9znGAbRLCiDhlYFr1aDWorB7P9QEaDURAYVwYMWxQzVBCGgwvcah8ue71z6SSfiaTrUOstBG7Or5+oiKMQ99CYuVNGoSGu6+d0JDlUvoPU/sMR8YleDjduOZAGfh6EFQaMAqoobBSQIlnZqYoIfpc39U0JocxRZl98Bgx6hFKEHSRFj7nToDkGw0zYgsrLUm3KeUJ80IUVDcjII5zaOIwh4yvIl/kDE0kjSMU9RxFkHQGvGJ/f/S4YlWpFGOrGdZHt7gISzB85U2kaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVHTRkHw5xDe7yvOSHg+6pS9TXUhWyVMxrXFN3mP38M=;
 b=MG/yRsG3QVpAfTmjeTbp2RUfyfqIPy836aXbHkv4NW+W2U4AfWifxRSV7MVu+cxBBKFwj04zCYyloNkrodulRFPcQHNVaxSN9PApC7wgB6x9eHAgD72OD5yymy5j3vJDPDJhPv5ssTsI1mgq1f+7DzGkAFPf5ofV0TQKgBIeAOY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB3721.namprd04.prod.outlook.com (2603:10b6:3:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Thu, 14 Jul
 2022 07:46:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 07:46:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Thu, 14 Jul 2022 07:46:00 +0000
Message-ID: <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf5b84a-433e-409e-f5ea-08da656ce56d
x-ms-traffictypediagnostic: DM5PR04MB3721:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hnVprOD6bbeTUPrKmoTiT7ox3b/15RMYAkO5+NLViqq8104nBp2eUo1w188f5zggQ0slUs10r0cJkXfp9Y5I4V7dAcRRZi6JXwouDuY1PFZJDXNTJ41egiYMTHw0uSnA7oAPsLoOKcwq8nHHamsz3fExoCXGmVyUZQKzzUSde6CjJmQdb6aWFRN6GbPMdgHzgnIWiWoyoeLn6mya3tH+QfEolkHqDgXUp1h+D4MqBBxWkCzPtUCjnR3RsPB1YUpHvMx6vNdXRqxie7OkTHfGtPy78cpm86z6x+Z4vNIze93B87S4MoePaG+CZTiKW6nz2JpQcUl4fMwtfR0jJGwhL6FX1a3GDaMKjxxml1FMxb/R/4DHsfRsn5mYC/2je0v4s/cjlq6aT/UBCWOl//AT1B4AVZ1qzK1LMhygMgPcCeEjEbmgosknBS9ri/c5G44otfDbZdrDvukl6ANJRlqL5NgX57bVfOhREsF9nSpDYKo2HgjzEwy943eohcX5Myg1k4/kFrXVZoGdi+8B/w0coxYb0o15g2h8yyn869bhRFDMhAKWaxWCEBPwa1XoWOcaHa8WLZDNsfaVOtJfbRHTiE+NvYx3mcCksrKuRSRGrW69AF3KrQTaEaT6w5QfWjQn5t/jd/VbZdCFbflamVpbdlCJYn0jeFmxXoQQfUuAI7JoaZhaDSWoMZKgzFZE5GCgZPgJe0Aifnm7dyc3zmJA4nWubcR2X6JBmKOC4gIGPhs3pKnDYOoqukEbHPSrsmxTQMWD4CJSwHJSUydt09gJ9M+vA4i+u9h/Qh21VQ/nHn8fGIvmNGchCsTK1x/2il5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(66476007)(8676002)(66446008)(66556008)(26005)(5660300002)(38070700005)(64756008)(82960400001)(38100700002)(52536014)(91956017)(2906002)(9686003)(8936002)(316002)(76116006)(86362001)(33656002)(83380400001)(110136005)(66946007)(41300700001)(71200400001)(7696005)(55016003)(122000001)(478600001)(186003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Gh52CtscHrRBn3+YzOw3rxSAMlkHbZZZ2gAOxp42K7qWA5nxxsjeNFSHLZ4?=
 =?us-ascii?Q?/4vnSEyOxCUcJBsvaBBsOrPznZr37YT2rskaBTsubQYjinWmbLDpSgIAZq9Y?=
 =?us-ascii?Q?c3WUxzm5sI/Vm6LlI9ZDlBkWZEaaMocEcIjh1U+E26l+xUULSZHuKWUTT+av?=
 =?us-ascii?Q?6ho9E2G+q9fhUO+v9EYYzrlO4iNj1NGmwVFR7a3VPTm/DBLbgj4qNltJC0Px?=
 =?us-ascii?Q?uYWZ8qjK8kCjRbTQly/K/Z7el5izoirpRFGjnUDzCRT7S/ri0vv47BTaXLi3?=
 =?us-ascii?Q?6fb47hAQHpDUVcHJxu1pUCNEKmu1xKciyTza5pDjLsWtZ+syx3HJC+8is7Nb?=
 =?us-ascii?Q?fFfBsz/Xq6oID8DwJOR1qckIiUXBckoC5/J8xv6H8WZB+/RQyEo3mYrkY8E3?=
 =?us-ascii?Q?VJBKLu3KJkxch/SujOQiwreNmgiXjJCe12scBHgJtj28N5OYXqKh2w06Mw8U?=
 =?us-ascii?Q?bmJ7BI4149+ECKrY0Qf6swmZoePO0YbdZtJ+TPtexs872vx/B4IRn0i2sYrZ?=
 =?us-ascii?Q?8kxE7N4hlGkFXVQkrqha9dHFKpLpRKhg4AQIXW9EN/goNtjT8ugYhEQ9RGfh?=
 =?us-ascii?Q?vr6Ru6XWUKqXOyaGrcigmb82yUI2kkYHzDSLJRWYK3PpIMAdlTl4IQfGwY9P?=
 =?us-ascii?Q?/uY0aHaK8FMivM+Cey4h58Y0BQ6qag9iRYK4XPKvFxxI8JZ+iRbMbFVZ/hq+?=
 =?us-ascii?Q?FxNPDQ3wniECM6V9d6WjO0BfxA0nb6AKaivM03TSl0EXYvYrcoeIclTYYlvg?=
 =?us-ascii?Q?HmDuRXJWjdcHN5MFpcJqasRUBYvTndgxFWeW2373Tn45DvfO7c+X0B8RTWYp?=
 =?us-ascii?Q?EbihCG6eEUh0A+ijIfyRulrsm0tgllvjlLZV3rtrVG5wrFUcLRAfnEl38yys?=
 =?us-ascii?Q?QWhOectSV/tu5KANPRIhx32OvBweCXuPgNAyNMoSPEuVXFvsAP9dB9ZU3BEe?=
 =?us-ascii?Q?dyT5y9Aac/xzyfTKpI3YuhZEs1AqGIXd632QS67+GPmv2McX6b5QM9q99dDg?=
 =?us-ascii?Q?ogJNdyHFql3oNaPtozvCZQ1zk1mk1s5yAwtE6fH2Dm8Zu8WA8k6TJG4NcK4y?=
 =?us-ascii?Q?d138/z5wKSAkSfoOLPpaS2To4tBSVHkbPYGB8eKzlBbLInZ3IqsEpISchOP3?=
 =?us-ascii?Q?f5yfXcf5Ue+Fgh7iVz6PfJzvkOIZFW/N6+D+p2KFJfCbb8AOMTV/xCMcSmEM?=
 =?us-ascii?Q?s229yIREe9bbHyc5UpXIOQuu+iLRtFfReVyQcSol8DHDqjIyjZZTX/xARiDU?=
 =?us-ascii?Q?oYSEx4JoUgLfQgisaMOkgcr6DZps4FfqqjIayoMp+j9lbs7S6Imi7AOmUzbk?=
 =?us-ascii?Q?nWBDc129BRzMgSFOwWUBV8MnzgHnp9mL5OoP9BKWTrXLZ4jG/9EFyNjzLoRk?=
 =?us-ascii?Q?fBHWei0H1yJOv2F/j8wnTxnU9zQyOk/9bGp7uQOreCwVmNLKN20xA/ntYpjv?=
 =?us-ascii?Q?RQEQ3UVD0IPfz9s2IeZGqkTyTeIvsrXDZ9RVDMS4lIh4jDgs2FbYKJDX1nkv?=
 =?us-ascii?Q?KzHdS8cfN0Jyqf8dwGVJiaXdDdAESgRPnpuskv7NMplUc+J4ttzZvHvndYCy?=
 =?us-ascii?Q?8ybOMQYjKaQlCbH8g443J6ZWGsmkFkDRuEcOjp0UBuI9BNRkh5kpAbt9Hjib?=
 =?us-ascii?Q?xz9F7+fgYxyltIzqSLogYTU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf5b84a-433e-409e-f5ea-08da656ce56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:46:00.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJzh4wlS1reATgx+lY4zffC35vpHAVY1K1M/GrSKy7aiF4CzgEM/9vCAjL3UE/kkze07yLyL7M4dHJZVM8MeaTxXtK07TSl3ZDwRJhZjrmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB3721
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.07.22 09:32, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/7/14 15:08, Johannes Thumshirn wrote:=0A=
>> On 14.07.22 03:08, Qu Wenruo wrote:> [CASE 2 CURRENT WRITE ORDER, PADDIN=
G> No difference than case 1, just when we have finished sector 7, all > zo=
nes are exhausted.>> Total written bytes: 64K> Expected written bytes: 128K=
 (nr_data * 64K)> Efficiency:	1 / nr_data.>=0A=
>> I'm sorry but I have to disagree.=0A=
>> If we're writing less than 64k, everything beyond these 64k will get fil=
led up with 0=0A=
>>=0A=
>>         0                               64K=0A=
>> Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
>> Disk 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
>> Disk 3 | P | P | P | P | P | P | P | P | (Parity stripe)=0A=
>>=0A=
>> So the next write (the CoW) will then be:=0A=
>>=0A=
>>        64k                              128K=0A=
>> Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
>> Disk 2 | D2| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
>> Disk 3 | P'| P'| P'| P'| P'| P'| P'| P'| (Parity stripe)=0A=
> =0A=
> Nope, currently full stripe write should still go into disk1, not disk 2.=
=0A=
> Sorry I did use a bad example from the very beginning.=0A=
> =0A=
> In that case, what we should have is:=0A=
> =0A=
>         0                               64K=0A=
> Disk 1 | D1| D2| 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
> Disk 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
> Disk 3 | P | P | 0 | 0 | 0 | 0 | 0 | 0 | (Parity stripe)=0A=
> =0A=
> In that case, Parity should still needs two blocks.=0A=
> =0A=
> And when Disk 1 get filled up, we have no way to write into Disk 2.=0A=
> =0A=
>>=0A=
>> For zoned we can play this game zone_size/stripe_size times, which on a =
typical=0A=
>> SMR HDD would be:=0A=
>>=0A=
>> 126M/64k =3D 4096 times until you fill up a zone.=0A=
> =0A=
> No difference.=0A=
> =0A=
> You have extra zone to use, but the result is, the space efficiency will=
=0A=
> not be better than RAID1 for the worst case.=0A=
> =0A=
>>=0A=
>> I.e. if you do stupid things you get stupid results. C'est la vie.=0A=
>>=0A=
> =0A=
> You still didn't answer the space efficient problem.=0A=
> =0A=
> RAID56 really rely on overwrite on its P/Q stripes.=0A=
=0A=
Nope, btrfs raid56 does this. Another implementation could for instance=0A=
buffer each stripe in an NVRAM (like described in [1]), or like Chris =0A=
suggested in a RAID1 area on the drives, or doing variable stripe length=0A=
like ZFS' RAID-Z, and so on.=0A=
=0A=
> The total write amount is really twice the data writes, that's something=
=0A=
> you can not avoid.=0A=
>=0A=
=0A=
Again if you're doing sub-stripe size writes, you're asking stupid things a=
nd=0A=
then there's no reason to not give the user stupid answers.=0A=
=0A=
If a user is concerned about the write or space amplicfication of sub-strip=
e=0A=
writes on RAID56 he/she really needs to rethink the architecture.=0A=
=0A=
=0A=
=0A=
[1]=0A=
S. K. Mishra and P. Mohapatra, =0A=
"Performance study of RAID-5 disk arrays with data and parity cache," =0A=
Proceedings of the 1996 ICPP Workshop on Challenges for Parallel Processing=
,=0A=
1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.=0A=
