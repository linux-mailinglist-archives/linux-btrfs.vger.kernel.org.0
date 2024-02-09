Return-Path: <linux-btrfs+bounces-2272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE884F1D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ABE2881B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ABF664B9;
	Fri,  9 Feb 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kizjh+t8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C7kmYHGG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5E1103
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469294; cv=fail; b=ltmEeTohGJfcFKFe2kDza1pSf8N/yLcKpwejJ4bLvjPSDWPQSRvGRzuuulbzeaOdsMrceOf3YA6+50/Jq2+kVsTH8avDOOC5+OkMF6kVZMDDLlYd9/IBiy4IcuDnQkxwWG+HsQp16dCLRcEMJeDKwK7ULYAnrYMcrYr3dtinFY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469294; c=relaxed/simple;
	bh=9IX35dBQ67XumPO4sjaWgSMigZivoZz+o9I0Xhzvxgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJSUXx+oaSh7u8WoTCBLDuj2UmhItdcQJrheiKnTXhHdkgoUc440ehZVdRRvf56g9DsKFxP8spS/rlm01asoArNgX58YwzDDuiNmlQp1+OkK2H/iXtwtB7Tpyj/+j+/LDFi80l+ebVWE0znXjFTHBzYO9ZZu+UfNovk7+RjQI1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kizjh+t8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=C7kmYHGG; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707469292; x=1739005292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9IX35dBQ67XumPO4sjaWgSMigZivoZz+o9I0Xhzvxgk=;
  b=kizjh+t8Qr0gjiUD8VbSTTg+PI3ZNAsrKYjZx/aIfBZtfbf7T3+qUGTt
   sYWaZ0rjdcQoux+s2Mc4VKtKmYU7c2nNyWtYv76fQsvg5Lf4ApGZ2hLjS
   +So1dNGNjXt2oYjMidfFIo6O6n+UEMST+u3zHD58fljcUEXuZ7PcK+keL
   JH0qU/AlMXCyEeGbSmmpE1NuOVNEGLXPUtR2FL68f7ZT/fWsLShAmUPZh
   0YjVl5GByYda2fi0dQs8+Jo/pV34gRM5Qu5x9wQA1rISqfaa4V6YYS/W8
   GumA1fVSNesxLVPK56ypB0onJ43S1uXqWLjxnbS+aA2zA6awOqlaBOfPX
   Q==;
X-CSE-ConnectionGUID: 5W0L+gCgSOKnemQ7ky5c/w==
X-CSE-MsgGUID: OXGW439lQlGeEY1DFw0o3Q==
X-IronPort-AV: E=Sophos;i="6.05,256,1701100800"; 
   d="scan'208";a="8798415"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2024 17:00:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLMDtQvVwMStei/D7K80NgW4yjzlf5bCqjEfWoGzY8aYDMZvhhtc7P0Mf5OaTMfVKhFyaWjZ7PPPn6IkQgiqV0M3M6SfCvNsdI9iAAVr3y2/Z65n5A+nuQOij/6a76MTbvpjG2QZiRN+msH0+w/FYmXUE7rpllc/hBerOcUiEyw2QPn9zotlJ4NyYl7rGvPY0D2DCtYUaKjKXzHKCA1wR1+Zkn6l4+D68rtLE8rhO/CzO4wXtoL0gR6REL1ED4Q61YbjRMW/KgrkMeutkNgHVbuEU8jOl8uT2vvYUyDjIpJMOBtDUtIheWWlN5C7CAgNqa51Hp9eEXsWhjgIwic0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IX35dBQ67XumPO4sjaWgSMigZivoZz+o9I0Xhzvxgk=;
 b=SDrQgWNgtOSmlNzMgFltXAotfZYz3e71KCvL2/5fZcJeZ3rC7ty98iIZeoewgWz2dKuxGLMicKCd7AWoD+3DGj/ihSYU8cBYhPpujvV6GClJQ+ntNeCQh4Eos9BsHhPjds88ACpzKW685q5eefwHScsSSzFMXuwmCi7rhj0hZQAszBMl7kRWIBV6YiiaqJ0P6NH6+rF04PgGyO0hBqRVk1NYDkHpf85mWTYIleifCQGQcIEYCwtW7n+dAMcRzNWll3r4ImU8lD2K+rpxclBI/kxebfhO/1elwRIXA6CbWvtPIBv+vs0Smrae9eywLoemTB8jYzEofRjywnwYE1z8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IX35dBQ67XumPO4sjaWgSMigZivoZz+o9I0Xhzvxgk=;
 b=C7kmYHGGGmyWWj0wK8ijJQZW3x1dKKZxYWtTPOSFRF8VbpM3HVVH5tqO3BlpeN9yGRczaN9Lu7ftIYN6TxMhBxAks0VocrwtJxGfei5jv/f5rKzKZfpqi6nlNecfsbhlfCbke5Ad0MfB2u3Cjh6eFqtDW3cSH9uk+gw7Y0mPy60=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7574.namprd04.prod.outlook.com (2603:10b6:510:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 09:00:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:00:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Topic: [btrfs] RAID1 volume on zoned device oops when sync.
Thread-Index:
 AQHaVbCKj/f1FqvKZ0SR7X1wPPWj1bD2+NkAgAFwV4CAAMh/gIAAvbwAgAFL4wCAABdUAIAAE6IAgAUG+gCAAUgDAIAADC2A
Date: Fri, 9 Feb 2024 09:00:19 +0000
Message-ID: <7c852b20-dcc9-4dcf-9c36-5c33692559e6@wdc.com>
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
 <1573ACF30347C754+463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
In-Reply-To: <1573ACF30347C754+463b9523-d8b9-48ba-806f-c7eb89c55827@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7574:EE_
x-ms-office365-filtering-correlation-id: 63ef85c7-09fe-40ef-4eba-08dc294d8ad5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wofBszWW/DsH1bNF6MOhLHtiX/GwDlyLEHyaT9MC8qwevW6bxmbkoUmds5benuxFwdxUB+1bYBXgn7Yf7fJvBcfsPbejmKM/sAcABoLN853wZYnr0zwZgwJJKUUTm9krdVpBpnUMFr6uujWMqxgb4SfrjYEBCqXzEXDoUnMO/KNfQJ6Ovlk0XUsf7doj8uGT3y+kwL2mxj3BRHw6ftL12dMnzzn6ZOoylU20iNSzhOnYCcDazzWFxfDgvppCj0e3CE3o8rVeO8Av6fv9URn8uaE55hoFIdyFBlIjI7CNKV4bEWcCFNKMiEHC4B+VdkVONNPsNhQ75mxFshluP+fulHcOXDWLWVm0BqGH6Nyinx9MTyPInfTglOz4cDy75Q/bxh4jYFFX4XkH4qDw4WVcd9jIWETG/nFkJhEBLGGC5SUVpHXAuBxk184+7RUEyULEDtagwMPmRS1xlCYQSrGzckwa33sMyOhda2tpwkEz2/lfW2kw5sa3X6ROMRG2TdEx5lDPb9IGRPO8T7RePOBzHzqz3WLomfhtzdk75i3pOn1moKBclgMbK1J4GFabelu1qq5RufhvTm0OMEnq1sqT08m8GDgsmdWKaAly/QXfAWy0jj2h162AdCp+r7oKq2ZZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(122000001)(5660300002)(2906002)(38100700002)(82960400001)(31696002)(86362001)(6512007)(2616005)(71200400001)(6506007)(53546011)(83380400001)(38070700009)(36756003)(66476007)(110136005)(66446008)(66946007)(4326008)(76116006)(64756008)(66556008)(6486002)(8936002)(316002)(8676002)(478600001)(31686004)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MldUTTVJQmNOVVNxZk9HV3MwZFU5Tm9NRHl4WXIrYWdXNFArMlpzaXBFOURn?=
 =?utf-8?B?cUVuTWdsdFpvQ1d0bSt2SmZiQUZoZHQvMjdJT1JLVk5acGc4RlhCUkpqaEFS?=
 =?utf-8?B?RXg3L1c4c1YwblJ1MERCS3ZkeU1OVDFiT3dxSHd3ZWxtWmRKTWZ1MFBTQTY0?=
 =?utf-8?B?SFI2TjArY2FsSUZNMVZabE9LM3BCbjhQZjJIRVpsUko5TnNQQ0pkbzZ2ZW5u?=
 =?utf-8?B?YlR4S2hzZWxmcFYxNTZmUEhHcHF4RjJTT1NZNE1ZQXptd21pV1JBaytYcm42?=
 =?utf-8?B?OWxBOWJOUllhd1RVMVMrN0x1V0dOSTUvbFBNMXNIK2tTQTdDci9pcFI0UG91?=
 =?utf-8?B?ZFVLdzNoeWpLNEpGdXk1Zk85YSs1cjR4UFZJUEF4ZGxMMG1xem1QZy8rOUp1?=
 =?utf-8?B?WkpOOTR3NzdhR3NRVnZRU2JUVHpxT1ZyeisxSFduK2EwWVdXYnBQRjNEakNT?=
 =?utf-8?B?dDd5L0EydmFLT1NZUHh5VS8ySmhLOWpnbUV2VVZIalk0dTFscUR5Yll0TFpi?=
 =?utf-8?B?ZDlhREp3RGZUVEhBYndUYk96K0FTanJhSXh0alNhSGV3QVNlWGZ3bUsxdUEw?=
 =?utf-8?B?b2JRRm9jNnE3OWxORTR6c1J4cG93UStJcEFpWFU2aDZuWVBKNldML0hGYWlX?=
 =?utf-8?B?RVJrU3NFSWV2aW1IeWtFMSt5bkhra2oybWFKcnVIQWFya1VJSHlWYnBremMv?=
 =?utf-8?B?Q2dOUkxrMjlUclROMkNBYW1lc3ZVa3h3Z2tEcGpkS0ZVNnVxa3ozbDljYjEy?=
 =?utf-8?B?UHlRZXQxcUU3WGplZ0I0c0dsWXpTcEcvVk9MVzQ5eW02RGhnTzhlNXpwUXV4?=
 =?utf-8?B?YW50KzVYcm8xOXMva3AzR0Ivb3ZKNHNoeDNhcE1YV2JaM1ZOVWhPeUNLTU4v?=
 =?utf-8?B?aFZLUmVwOWdRNjN4WURwY0xHUlBvQmtObXEyY3UrcGxQaksrNmNUVDlndGEz?=
 =?utf-8?B?ZkJkU2h6QU5EV05YM1plMkM3RzlVMWdqWEdjZkhlUTIzYzBkZEIrWTh1T0dl?=
 =?utf-8?B?Q3p3cEV1U25nL0xpUUZabUd5b0RzZ29VaEFCRkZsU1dQQmgycVhPanV3dGMx?=
 =?utf-8?B?eWJ4NDExMUg3TGl1OFFQVnE3TmhGNkNlN2RBMmhSZFduM2JJV1FiemZOZlVi?=
 =?utf-8?B?S01xNU1hL0xnbFlxNUV1dld0MjlqOUhTdjJlTE1ueXFiQVM5bWplODhPVGJh?=
 =?utf-8?B?TkFkY3ZnbnNVcDV0VDNOOERxNXBCb2NqWEtyYiswY01PL2FvZ1BZSituT21q?=
 =?utf-8?B?WS8rSm91MGpXZ3NSMVErcHZYbHJqQ0JTMnljSDdZLzZKYkQySzBaQ2NUZVpP?=
 =?utf-8?B?dytOam0rWjVsNGZhaXNlQmNDMFRmTUozd2pSZU5SY1h5ZGgrOGJqYVEvOGJF?=
 =?utf-8?B?bGptZENMRHVCZ1pNYStGV2NlK2xiOVh0eFQxeFkrcy9zc2JWQjBIOVZYYjl5?=
 =?utf-8?B?cTNUbTFweFRKZXI3WUMvTHNxNWNNMERqUFV6cXYzQk40MjhPaEhVa2lOVmU2?=
 =?utf-8?B?Nm1nbjRYRmZVc0JlSzQyVm5ac2wyc1pjbTdwTTYxS2wrSEFYM3JaVm94RjNl?=
 =?utf-8?B?N1RXTWxIOXQ2c1FpaUFCRUhCT09YOURvUEJmamJKYzArbnVHOFRtUEVoMTdT?=
 =?utf-8?B?eXlXUU9QdnI1WnN4UGtiWWxBRlBDZDZTVmY0eVQyL3VvZlBTdFdxYzVFZWpX?=
 =?utf-8?B?VWlCMHJuamF2bDBoVTlIb1c4MkVYTDNYeVd2djRFOE5vNGQvWlRKMCtaaEdF?=
 =?utf-8?B?ZmRkVDd2bXZqSm1OMkUrZFFuNFRnczlDNVBGUUxpU3FCYzZTeVlsODJTQlk0?=
 =?utf-8?B?UzVNNGlUMTFmQVF3YVI2bnR2Q1VZMTRrRWF6bURtVmxoYkV6K2pSMHdxOWJM?=
 =?utf-8?B?VEVud0xjZjN5M1VCTmxRQm1RcWJTS2NlZkcyY0toL0tVVVFRSVZMK2NSbFll?=
 =?utf-8?B?dXBRQXU4WDlkMzd3NWR1a082UWFXa1k1bklvU2FKMjFIY0RPb2NaVHhyTnBF?=
 =?utf-8?B?UTYraStHOXhpVDRhL1BJamNjUnBLMlJwN1FDZThNc2hZdUNwVVdBNExOVHlV?=
 =?utf-8?B?OWV4NUh5ZHlTV0V4d3pKUG94OTNqMkRUcFh2N1hCYlRBNXBhZzAzUlNyc3lG?=
 =?utf-8?B?cUJtVkdITXFiNDRSTmNIK3BZTnRoRmxWa1d2d1VwazRTMG5EZFk2OXVtVjIz?=
 =?utf-8?B?eHBiRGhIUSs1SVl5TE5EaGhCOTZyWjlONEdyelhmMloxSTRibGJDQ0p2MEdl?=
 =?utf-8?B?ZTZjaEp2UmM1SmxrSXNPZ0EzSDZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD1D0B2CEB11F8498B32D95427EA211C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f/1KTGhfGokXMNzEvm7+L3F3vuY+UgeIs8XeB0XTUzbjvfHajSc4R4vCMW35IS9mJGGyw+C3qOGUa4YW0Ss3qCGWr8Co5GT+7dIdOXdo2ICFtFEgO/JU8UjfFwJeP+yMXWAgU7NhfuttuIG+mA0lbyLOWNhwS1thX7qRUJi1VPUJzXPcp4jaCIvIf0sehwm4cSi7XlZzBTVNnRG6gV+DhzKxmd/PLNFO+eSkJl9TGXMXT93EeDXmRTVMe5PcdCDPsYjZ52Z6DlQb7y4Ug2xnBpVXCXBrVKUYdFrFzxNdjQfO8f8EkX6BhgsuYrrrQWgCA/SlO5EDMLSgJhpd5D8X9+daUMPsXv6/kyCt/M+/f0adAy6QZlMrfUWvog3T/yXo0TXDNGMIwg4npxGD1lrMwoKYIaizNi3PPp+bIT1+bD8j8LR9ZZPBp7bsHiEBt21lm5FVXZkS06yozljTQTF4UqwcmskNhpK/UQz7ZRvKZo3rmMDfvkC8aw7VOtg39c10XwIaAcQ0xS1KZU0oeDs2FWLnCvuaF1eHLvMSKKE/1UESLDh7fC70CReQgm+KX/jhqcaWmvif5laB1ouu09XVEKmntMJHU6gAH2MNKRlH4LLop40vWhqM9p1wMBjdxyMh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ef85c7-09fe-40ef-4eba-08dc294d8ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 09:00:19.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fS9h01bk81SCiQtr57C6aRpOM7AHp4qcn5EYaoyXTFMeG9YffpUGrYKdvEHxZnKlmgfO7xHwDGF/96CK1lvl3McPmErlZeKdT/nNPKfvpus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7574

T24gMDkuMDIuMjQgMDk6MTcsIOmfqeS6juaDnyB3cm90ZToNCj4gDQo+IOWcqCAyMDI0LzIvOCAy
MDo0MiwgSm9oYW5uZXMgVGh1bXNoaXJuIOWGmemBkzoNCj4+IE9uIDA1LjAyLjI0IDA4OjU2LCBR
dSBXZW5ydW8gd3JvdGU6DQo+Pj4+IMKgwqAgPiAuL251bGxiIHNldHVwDQo+Pj4+IMKgwqAgPiAu
L251bGxiIGNyZWF0ZSAtcyA0MDk2IC16IDI1Ng0KPj4+PiDCoMKgID4gLi9udWxsYiBjcmVhdGUg
LXMgNDA5NiAteiAyNTYNCj4+Pj4gwqDCoCA+IC4vbnVsbGIgbHMNCj4+Pj4gwqDCoCA+IG1rZnMu
YnRyZnMgLXMgMTZrIC9kZXYvbnVsbGIwDQo+Pj4+IMKgwqAgPiBtb3VudCAvZGV2L251bGxiMCAv
bW50L3RtcA0KPj4+PiDCoMKgID4gYnRyZnMgZGV2aWNlIGFkZCAvZGV2L251bGxiMSAvbW50L3Rt
cA0KPj4+PiDCoMKgID4gYnRyZnMgYmFsYW5jZSBzdGFydCAtZGNvbnZlcnQ9cmFpZDEgLW1jb252
ZXJ0PXJhaWQxIC9tbnQvdG1wDQo+Pj4gSnVzdCB3YW50IHRvIGJlIHN1cmUsIGZvciB5b3VyIGNh
c2UsIHlvdSdyZSBkb2luZyB0aGUgc2FtZSBta2ZzICg0Sw0KPj4+IHNlY3RvcnNpemUpIG9uIHRo
ZSBwaHlzaWNhbCBkaXNrLCB0aGVuIGFkZCBhIG5ldyBkaXNrLCBhbmQgZmluYWxseQ0KPj4+IGJh
bGFuY2VkIHRoZSBmcz8NCj4+Pg0KPj4+IElJUkMgdGhlIGJhbGFuY2UgaXRzZWxmIHNob3VsZCBu
b3Qgc3VjY2VlZCwgbm8gbWF0dGVyIGlmIGl0J3MgZW11bGF0ZWQNCj4+PiBvciByZWFsIGRpc2tz
LCBhcyBkYXRhIFJBSUQxIHJlcXVpcmVzIHpvbmVkIFJTVCBzdXBwb3J0Lg0KPj4gRm9yIG1lLCBi
YWxhbmNlIGRvZXNuJ3QgYWNjZXB0IFJBSUQgb24gem9uZWQgZGV2aWNlcywgYXMgaXQncyBzdXBw
b3NlZA0KPj4gdG8gZG86DQo+Pg0KPj4gW8KgIDIxMi43MjE4NzJdIEJUUkZTIGluZm8gKGRldmlj
ZSBudm1lMW4xKTogaG9zdC1tYW5hZ2VkIHpvbmVkIGJsb2NrDQo+PiBkZXZpY2UgL2Rldi9udm1l
Mm4xLCAxNjAgem9uZXMgb2YgMTM0MjE3NzI4IGJ5dGVzDQo+PiBbwqAgMjEyLjcyNTY5NF0gQlRS
RlMgaW5mbyAoZGV2aWNlIG52bWUxbjEpOiBkaXNrIGFkZGVkIC9kZXYvbnZtZTJuMQ0KPj4gW8Kg
IDIxMi43NDQ4MDddIEJUUkZTIHdhcm5pbmcgKGRldmljZSBudm1lMW4xKTogYmFsYW5jZTogbWV0
YWRhdGEgcHJvZmlsZQ0KPj4gZHVwIGhhcyBsb3dlciByZWR1bmRhbmN5IHRoYW4gZGF0YSBwcm9m
aWxlIHJhaWQxDQo+PiBbwqAgMjEyLjc0ODcwNl0gQlRSRlMgaW5mbyAoZGV2aWNlIG52bWUxbjEp
OiBiYWxhbmNlOiBzdGFydCANCj4+IC1kY29udmVydD1yYWlkMQ0KPj4gW8KgIDIxMi43NTAwMDZd
IEJUUkZTIGVycm9yIChkZXZpY2UgbnZtZTFuMSk6IHpvbmVkOiBkYXRhIHJhaWQxIG5lZWRzDQo+
PiByYWlkLXN0cmlwZS10cmVlDQo+PiBbwqAgMjEyLjc1MTI2N10gQlRSRlMgaW5mbyAoZGV2aWNl
IG52bWUxbjEpOiBiYWxhbmNlOiBlbmRlZCB3aXRoIA0KPj4gc3RhdHVzOiAtMjINCj4gVGhpcyBp
cyB1c2luZyBudm1lIGRyaXZlciwgbWluZSBpcyBTQVRBLiBJdCB0aGlzIHJlbGF0ZWQ/DQoNClRo
ZSBvbmx5IGRpZmZlcmVuY2UgaGVyZSAoZm9yIGJ0cmZzKSBpcywgdGhhdCBhbiBTTVIgSEREIGNh
biBoYXZlIA0KY29udmVudGlvbmFsIHpvbmVzLg0KDQpCdXQgYnRyZnNfbG9hZF9ibG9ja19ncm91
cF96b25lX2luZm8oKSBkb2VzIGNoZWNrIGZvciB0aGUgcHJvZmlsZSBpbiANCmJvdGggY2FzZXM6
DQoNCmJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9pbmZvKCkNCmAtPiBzd2l0Y2ggKG1hcC0+
dHlwZSAmIEJUUkZTX0JMT0NLX0dST1VQX1BST0ZJTEVfTUFTSykgew0KICAgICBgLT4gY2FzZSBC
VFJGU19CTE9DS19HUk9VUF9SQUlEMToNCiAgICAgICAgIGAtPiBidHJmc19sb2FkX2Jsb2NrX2dy
b3VwX3JhaWQxKCkNCiAgICAgICAgICAgICBgLT4gaWYgKChtYXAtPnR5cGUgJiBCVFJGU19CTE9D
S19HUk9VUF9EQVRBKSAmJg0KICAgICAgICAgICAgICAgICAgICAgICFmc19pbmZvLT5zdHJpcGVf
cm9vdCkgew0KICAgICAgICAgICAgICAgICAgICAgICBidHJmc19lcnIoLi4uKQ0KICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQoNCkkgZG9uJ3Qgc2VlIHRoZSBkaWZmZXJl
bmNlIHlldC4gSSdsbCByZS1ydW4gYSB0ZXN0IG9uIGFuIFNNUiBkcml2ZSwganVzdCANCnRvIGJl
IHN1cmUuDQo=

