Return-Path: <linux-btrfs+bounces-1589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2254835C36
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 09:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E411FB25A6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE1182DC;
	Mon, 22 Jan 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DI5fP1rB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="smIe9clk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71A179BA
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910548; cv=fail; b=oa4BYUA8y9PYby5Qq+f6/cEuXpnqhNzt4mrKWrT1crhVeGwYxRLL9IOJ+bYKJjtQr9mYi5q8cyRtySjyoIMUbgOOoF9qigMk488exQTT/oxpv59S3u+N4j4K0BRN41EoOkmPcW92TFfUL3kJzoBUqNjwuzcmN2wWoNja+rhrmQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910548; c=relaxed/simple;
	bh=pE9wqN1uxeMkQ1xeV8D+Cqhz53G2urzxk0GM5AO7m18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n89ofWQlA2I/HX3Rld50k+RrytXrVsbhWhFYP9ChC6j9nOt0rNBtBZuoObXzIqMQNOWtVZUTT+isUVID+SFMm3z9UG1q4RdFcfBruRGn5/0e/7Ws+MzClmlelGyKwwXn6JREEo1S9crEyLgxF3nivtjp+2oBWffe/HOxh2FSrkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DI5fP1rB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=smIe9clk; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705910546; x=1737446546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pE9wqN1uxeMkQ1xeV8D+Cqhz53G2urzxk0GM5AO7m18=;
  b=DI5fP1rB9jOZ4W8qMKM8RV0t6bEkoTTwxMuWVXQfVBMcxBgag6y7Q61I
   5VVlRbmLuJJv/NgE7qohwPxpgr1dcd2akw9rrhTZqV2um9LFnLkxn6mBQ
   A2D+BDNJy2fm6e8tch3NmrmyEqcqvJ+WFCdqbv1IRU97saKKzXhwh8mC4
   aJl8AK3tWQjHPX+tWRWz0vlEBr+goMNdATAaZx42GDjBwtZLwziYhNkCU
   s0KvjKdytQTB0zjU8lfQQ5s6PXb5rUcGUJL9nKdYEo1bOozdOo4Mru15s
   FNwybM1+/FSh8HPe0jJxVatRvJ9EC5KhKNCY+zlXdEaqwrD4NghsBBnrB
   Q==;
X-CSE-ConnectionGUID: zGMDcVUXQm6fibZC6pqs+w==
X-CSE-MsgGUID: nJOSWvZKRwSrMb6bE54WZQ==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7492687"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 16:02:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtxaIBninT7mbBMVHjRTKZdIgu/sH3Y1Q61hMk51JdnQGRKk4ztnOdJW9JgdodPRnSnZEq2on5YdDtf4ijUegyamINdO0Rt25crqysVaPAZCJ2IwuO7b6QDqsLiDHSW2xr84C01MEnbpE4HVm6HJU/93nYDQfIcIQ4cdxSMtuEpDxbsm0V1l8ThEELw8Nan9MQBPWb78N0q+3UDwtkUPZmv74LDjUXnTsC3eOzIVCdvD3qRu9HGPtTaMF4Fhx92Tr1tWk2n5t/INb9JBhUBp3OrqSo+I5tCIshl8rCE8Qj5MIN4Da+gBvw/RVlGqGFE+RlVpeyFdoFWUZsNKip4eWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBFCCuzWNztC/xlNxACPxdZUG0pK3mEW57dC8/RO+rY=;
 b=FROcASpNXDr1GYCiNZ2FLGKMAg5uHmXmoiUyR17yM8So0orDF1E179yIi6UKyuq4O+1CglPV0Y/jOdxXn2ee6J6BuCDiQ0PJPxo0s2+vym+UOlBLvReAjVu1i0lep7SzHMI1hcQ8atD3M5OkH27RxSElXy0bGmitr8vmKjiMaEaOM29qaRzKrBRO3MBLm+hUpUWS6eGQfJyTeiO13rkwbRWNW3kN0DrGtE3/MKtkROUPozqPf345+kepbrNeDrSjVM7bjN98OEvOZnTggayvNAmsMWLSZtkVRnNV9oFbL5ugcW99zQgGXvjb08s6wZ9JT/SQApGnz1TeMHH7BabBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBFCCuzWNztC/xlNxACPxdZUG0pK3mEW57dC8/RO+rY=;
 b=smIe9clkMPmmopJfRbXXmGyxRHlJB3bLuiOUq0L9gw+EFl9KcpyYqPbHLDynKS9GvJo/Q33uQhQVYoJXQD65XXuBJlX1C1WKeY5ZuIwjDuPbbTBqOmWnCoczu4goT7yKajw/4Dkud9r/v3kRg0JbrC9ePGFfg1sQwsfQDyOWz4A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8450.namprd04.prod.outlook.com (2603:10b6:510:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 08:02:16 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:02:16 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>
Subject: Re: Re: [PATCH 2/2] btrfs: detect multi-dev stripe and disable
 automatic inline checksum
Thread-Topic: Re: [PATCH 2/2] btrfs: detect multi-dev stripe and disable
 automatic inline checksum
Thread-Index: AQHaSewVjLDSjVxwRU6Ss/4KdDc7NrDhRKqAgAQ6HYA=
Date: Mon, 22 Jan 2024 08:02:16 +0000
Message-ID: <hi2ee2dexcslljowj3wvdum6smmvzvtupo3hasbfzxs2efzf2r@szxn3xqreuzi>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <7ce85c808b96be3c8352ffa03fedbaacf0dc6d27.1705568050.git.naohiro.aota@wdc.com>
 <fb44aa48-fd5d-4b3b-ae87-2ad0d9648b44@wdc.com>
In-Reply-To: <fb44aa48-fd5d-4b3b-ae87-2ad0d9648b44@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8450:EE_
x-ms-office365-filtering-correlation-id: 36a2e9ef-28cc-4429-a28e-08dc1b207338
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TT5tKL3vLYVavN0kebshK9WkCZebWRtoA+ilIQ3L3G+BH4YO0VRduu73DdAwT7XW/OhpePHFJe5KhJMZZr+MBnWN3Fp/FdPfcqzewMCEoonB5KE/k/yIiBTrkuZ0k9e2GxAmfFoEXunzubgVUtF+7/bjvnQ2p9/n+3pqDTGdwPiyOFy45vBKnAOdz9s14Ei0eLp7WXq07Q0tdHV6xYANEx+4zpex1a6am+7mjCou4qlllAEsb/teVLCFHqgyvj4aprqzUUZKlL4aR4IPBeG8NL/bI9V4WvPAbl/6INGQjPv3lDOG4ZWlPp2sGEHPgAQA85Ns4sifO6poneSAMV+kJ1mOmJsMyozQs6GiNYc+HLGS2HArCG/ZI2JBLKUbO9QlUp3wYPsn1QpiSJGfoQ5/xwDyUQIqTp/54I9Z+wKoEVzkvi+LGQeJn9C9Zz8adbqfUuqB5IMi4iFBc53bVK7PH00lzX1ojrC8lV10DhjFiRZmYCQTBDLmdMIIK7bTDwbzC7M8eHP34U6nuEtoj7jvIgowH2+MDSKWLzM1DZZxu/B5ObpKm9nJSiM6Yt0Gvkn4GXL0nnKAACQ00LgXv4hko4pxnpjqlwtLoXewa5G+sb3HTU6iCQpq3uJXtKPeqoHO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8676002)(8936002)(6862004)(4326008)(5660300002)(82960400001)(91956017)(54906003)(76116006)(316002)(66556008)(66476007)(66446008)(64756008)(66946007)(6636002)(33716001)(86362001)(4744005)(2906002)(41300700001)(26005)(83380400001)(38100700002)(478600001)(6486002)(6512007)(9686003)(122000001)(71200400001)(53546011)(6506007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FiP2Bkj4SNLxjU2wYqrexFKWCgg90lMd9+T2wMnUtwi7ilY1usebFrwsiG01?=
 =?us-ascii?Q?+MoRADj14SnJHBiaNk+x6++HhUtvEAY2jQ/+b94Enkoydkpgoa0i94TK6rC3?=
 =?us-ascii?Q?/P3DQjueQIezWoWHZhK4LzZdQ8QuCDDDXyuTdONdpES2IS1M/vmhuBGSDf6c?=
 =?us-ascii?Q?bS+dUIkV/zqifhaMUI1mrAg2gkX24SP96lPq9ttb3dDawpZWXH1OHW10twFe?=
 =?us-ascii?Q?xvpGbiN5KuSQfOZCdbbg2JA4rkzd4tHycL/STm6FZ8saSa8td+A5pm1rvpW0?=
 =?us-ascii?Q?Mf5fys8Zu1pne/7YhLGabxJpkEjHNRStZgMjqUyUAH16cFmeBNu+usb1sREY?=
 =?us-ascii?Q?gHmLgQgDYI53wmcjXFXy8x/2bpZGH4yMUpxBrnlfqFe3NVZk0bSC4/F556hx?=
 =?us-ascii?Q?O+3JgL5X2GyegX4ZB2hnZqSSqedx8DUxB8/n208Kr+Yj4xkbllKPt8YLY5VX?=
 =?us-ascii?Q?SshQeuaMlI/OPaC0oNE18XgUhq7epELjHZSzrE23SRMe/UiC31JHEwji8f2r?=
 =?us-ascii?Q?s43LoAlah9xBpbON/kG88EZXjTw1PFCyoQwmZ+7AAfkyzA1QNfkxg12KlTE5?=
 =?us-ascii?Q?8W5ZHKx91gKizyJwDKUVvV2ge5xj+Ar6aGcqOIJQim8fRUdK1rNkRiFWznwX?=
 =?us-ascii?Q?IxFlmvJXYa+wguajy1l4BOV9zPm9QKbWnVVKnwCj8u4Wt0YQItqoplsB4lly?=
 =?us-ascii?Q?gxnuxiyly0Dr5L23jrEsb3q1+sIrOKM3IMmUjFtIlBV7FUtJ63+tt+/TGjIB?=
 =?us-ascii?Q?ndzmHNL2bA5+ZCG2DVh8t7oJNEb31L4uT6gVN09cgbEu8zBY3JzRnJf7n6WD?=
 =?us-ascii?Q?lz8+rNbprzKAuW4uwHhJcQKdlL0HXOPs6O0yPUogwbW626TAOQXlT+ESihVG?=
 =?us-ascii?Q?QI61JlIouogYGl0rdWLkgZ+llXyEDMQ5GHdS0vGeQDj5z/esx0SuzOR2bjMc?=
 =?us-ascii?Q?7SsNQgzbWbBLda49xGHtIbMWUXO8ZlAWkEJzOwvjjd3GuckSnff8XyiQNc1r?=
 =?us-ascii?Q?LQ2+OExarlNni2egfARmqUefC45HtGMCU+4w/TnIaY/m4Hp36QV/y1FgGhIz?=
 =?us-ascii?Q?06PX/fi0w2L4lBpX5eV7a+koiceed1mAAkm75VL0TzLvPgTaHzaknE2xwX1g?=
 =?us-ascii?Q?eXfJGAxaUaxfkyWw92uedmeaR4YfDhRt7EB9lfAEzQXCbmPDCKaN4ASKeDfa?=
 =?us-ascii?Q?BGAjcCqIgf1ZE4fw7LnJZbJvox8pNYO9L3w/abl6wUiqtYS2LhXnw+e5nI7J?=
 =?us-ascii?Q?6fJB/tYQ9Gh50hKsikcl9cDObf65Gy8b7nsrz4zdkKdE+RIFLVAmdFYIhHCS?=
 =?us-ascii?Q?CinljDWbo32h/1DpEp6R5JuQwHCvcti7ZyAadkN1mbCRwxqKIk/lL7n8S4o5?=
 =?us-ascii?Q?54wkpdBdF/N8fsY6/Pq08q2/w3JbP5bEtNFlXWFzyWib2AnMlCwqEW4+3U29?=
 =?us-ascii?Q?ewfFrDFIDF/PKvOpowLsBWLAewW918DvyldHmVShT/suOOu4Uki4rZAaC3Rx?=
 =?us-ascii?Q?mT8/SUfbwtfjs61+0tk5ETJqcShvCkn+TToe6F9FlMh76TgGQdOjufAWrH52?=
 =?us-ascii?Q?7UN6P1Qy4/QTMnsSghD9kA33AKhjGTtQaPgpcfR8KJS+2FpdmSdp0kl/QEqh?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F0AAE7B5298C740B8391DCAB79E4719@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FLRKdCllKbS2u5UefbrghFO95sLy0+FAr6C8/RcqtLbSCXmXNV3eSL6RexFrjA0z4VOsAuAiBD26WvmYpVu02MvEsh9O1LEjPZyPk2V3qwOA3Pe3db4t3F3/y+xLo+s0NBwx0ycGSyl4/XaX45mPMcm51mQCBx+x6daIGHSY2S4Si3Jgh38BgWNQ29bCKqaaHT8mKPV6L2WCh1gKjuwQ6rV1sDz1feYC4JaY3j6MMvKABMvD5N1b5Yv8SOLIzrh3acbZDqWHHsf3xFnmXSYXm3Yunp2ogGcSpsDrLj0AQhn9Xfvb5pQ2rW1F6Sc1dSuLBX2HMrNYIyLNyU/5xDd0nUS/CP/ulbRHKBaxqrt7e6RM/cd7RSxwwZTnYid8B1Vi1lNs+kuPfrt2AP8sdG4ocbV00psInWyEpg1zkb/cVRwsuSgR0m0S8Lf0gojOxP83W6ouUGJjn7zlEDAoqLpB+kTn9x94KxrKdP5t2wJfUNhiqCmtmno/TjiJ1Hn+/ZfwjtqabIsb87kjsarg5mobvfmumnZeUik5ZwqNGWSpP+ehNN19e/nbyEdpnfPkO4U+eVsmil5An9OB/VcBdFZBe71dfZsB+ismZRlNm2i6EZaI9yW4qIoPSABHLj9+gLDP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a2e9ef-28cc-4429-a28e-08dc1b207338
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 08:02:16.5351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiP+l5W4DkRZ8tvtWJ11M2qkPfATirNjh+TmokYvCGePSd2ED15uUu2qJ1KZMSmIPgueqqpYGUfO/UjkMhd2rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8450

On Fri, Jan 19, 2024 at 03:29:13PM +0000, Johannes Thumshirn wrote:
> On 18.01.24 09:55, Naohiro Aota wrote:
> > +static void check_striped_block_group(struct btrfs_fs_info *info, u64 =
type, int num_stripes)
> > +{
> > +	if (btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max !=
=3D 0 ||
> > +	    num_stripes <=3D BTRFS_INLINE_CSUM_MAX_DEVS)
> > +		return;
> > +
> > +	/*
> > +	 * Found a block group writing to multiple devices, disable
> > +	 * inline automatic checksum.
> > +	 */
> > +	info->fs_devices->striped_writing =3D true;
> > +}
> > +
>=20
> This function adds some overly long lines.

Oh, the checkpatch didn't gave an error. But, I'll move "num_stripes" in
the next version, well, if it's still needed.=

