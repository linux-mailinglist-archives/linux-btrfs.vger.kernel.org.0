Return-Path: <linux-btrfs+bounces-3343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95987E407
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 08:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A62281352
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA74225AE;
	Mon, 18 Mar 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EQmF1ICT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kVwsRPK4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026712233E
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746500; cv=fail; b=Bz0xRZLEl/OIQipbiatLpdDzA0yryZ1wi24B6CnLzJAsqmB38SrwDPScucwS32BP5E+B7FjoWDL4+k3EQRn+sYrlIkj9nbm/qsOLqDJHKRCapa2/p2TeZJnoRwsYyUNQqIkOeCXqdNXRvsgneXLzTMFe3NE0aqCHpKEhubgtBXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746500; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kYLvvBJmauYCyPyzHHtiMtfjkyqPRpltPXMI1k3mTrLUsfkXRvOVkSEx/juqLLXKLpS0q/eMMoshRTsTp+QPWnhlNxq69/BF8JIRPAy4d9rBmsFQ5WnXUQ1/MOlqOZxBBdgCLx3qAaL0Xl1TLqfe72z+11z31LplHZn6S4yEyXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EQmF1ICT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kVwsRPK4; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710746499; x=1742282499;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=EQmF1ICTkzje5e2fbkv4qJa98/CcTH4MzAX9USzDfvIkmGZMKJRqRSGf
   iuINDiLEHIafNCahFKtaiJLX6Ig+02crfBJUDueJWL+t1V4HCFMFJEaZl
   n5g1h+Y+fHS3j+wgP7iaSUAKKW9IIlMFJJLrBt9wjyKEd8p9m5MU0DIPN
   Wd5hu7GVZGmgXi+0eePAxYxQCr9bqlXi4ZiUV9mOY1gGh5AjitUONt0Of
   QfXfgUA2h131eULqV41PIVqlKMpXZpAclBHk0yTouyvrE20x2CAUEbRRE
   SsakbzB8KCIs91Gzcl0WqKeJJIl9x9qfR6Q+f+uWyfIgdsDXdU41hB3Ba
   w==;
X-CSE-ConnectionGUID: JDEbuwc4QO+zEVcea6QWBg==
X-CSE-MsgGUID: QPIP7PdQRvWBadvQC3t63A==
X-IronPort-AV: E=Sophos;i="6.07,134,1708358400"; 
   d="scan'208";a="11346079"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2024 15:21:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHMfc8qXE7VTn+xZ2088pWuDbaA5qPFh36B53uYddwnIKzmDLwlorX+NouIystH/lMX0qWYpH/AFNAvYWJx1xn5dtG+Nfd0hfGsYoDlmZqE7tiJq89z6oM3/0fTpXCR4n0EdkH21iDelCtOU4tldQfonBgTolu78bl6v7MJKq5XSWtYdT0jPPl67K17zQb1vDFnFQL3h8armAomuLs8NWyc9G4Mqu5EV3eEOdqBJSzHK/ycnzbSEa2x7/Z+keF+X8UiGOkEjO8UTztvdlFE8K4rVtFHjpNE/QcjvfwNWrc+EgR5+9G5ETvTDFMuXOZJvnSRuYz0jQgnB5ppCsyYNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KsVHtSD6IO+Pv58qmsXrc7ZvTvJQiXkRlT7EbxzqvSFWJexVXzf90996zqAf+F2UMPzzs1+OGcVJGho0Xxzrxd5jBpe9kyOLXFjY13GDZwaDX3X3ya+XK38DmzYPiYPEsAv2lPe11pQCtEV2O1aEUVK0FTl6Y3XuZt9U1lSw7ggKU1xVjz0i+UG8dCPrJha1A0pGHpKq3y9/SMvYmmjYYEujw4azEG5bU1TvaeDr3dHiT7tdd83n2n8E012lRvZ9+vGcxjDl6KJmp3CwVsdmByKJ+8INtrQpGwKlGpL0nRiPxNslCSFMd+agBFJYLeQNlLJDGun7GZ9h3JOfy7pNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=kVwsRPK4e5GPYpzQkNy3Y/JBHeGH7CYVsi0aXQ8RfxyLxMHigDnjLSXxRV7pbahxGKC8AjLDHX2dUeYGti+24QGkGFpP9S0E1fMqf+f2sWPbaOSh9jSiDDNMWjum6T9DT1vA9MvDOhyilANeNx29GGLL6DtdbF2AAIe5f3Kq3yQ=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN7PR04MB8693.namprd04.prod.outlook.com (2603:10b6:806:2de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:21:36 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::e7db:c3b7:c5bc:827b]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::e7db:c3b7:c5bc:827b%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 07:21:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: trivial changes to btree lock functions
Thread-Topic: [PATCH 0/2] btrfs: trivial changes to btree lock functions
Thread-Index: AQHadtgmTr7Hu8liPEyRKvwsfFeek7E9HCIA
Date: Mon, 18 Mar 2024 07:21:36 +0000
Message-ID: <b387adb1-0e93-4237-876c-29efea4b9c58@wdc.com>
References: <cover.1710506834.git.fdmanana@suse.com>
In-Reply-To: <cover.1710506834.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SN7PR04MB8693:EE_
x-ms-office365-filtering-correlation-id: 12e2ae0b-4c09-4fa9-b063-08dc471c0bea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +BHtqSnIjwfqiN3jTEsxxr5oMJjQeNFvGFWp4NErPyXMNRPcjI+kp9OIGeK3/cAVJPjKMXfCEP/I08vLIgagM6isfRSLxfAMBFMs63BrtpeYRTMwReNSisVkMrn8GKHfpZKAz+BU/UDrlh/9Ei5bCw7I2c1KJgK/zwCIpIBiBdOMEcMGlZYJHXzwFSgMdEwD4s0TGVQb97zr3crSU8Qqi0qjFuaBBFicjHiEPgSDZaLWxhb/jfYjCZnd63LaeSObwIdAnJXSQhDYsj87n3/8ykFEfEmah3bvLP1VX9WyyjYtSQAqH6s/p4QApJ61RGs0D04Zx98K2Xkcu0etLVNB01YvWWw+eybn/KWb0L6vWZkOfPbD4DYf+V3GQyXWRPoRZW12GKauzzYyJsttzIr8bHxQjPt2FvCG08ojaQfCX0JmMmZrD5IWmmSAuBGhq1pGjnE6QGsM2VN3+ujEVcKPZBs59pBX22Uo2ylaaYc8b0PXaBwpmD1DeJznO/Qq/ASsEW3atVM1a6Z+wVVpnSljYw5480Pyn0qYMODINawL1It/L9rDn/wwDFRCwInRz/zjRNhbfQuQLTxd4tzxFxpc/tq/zcJRRdwmd4QUBkR/8R5QMI4Oil1zBPHwdlQvjWD9XfslnkZ+15hj3iLluTBj+1vkr3QKH3fKcVV5oCYi11l8+g1N4SrLiPimu3pv9A+ggRkjsWhKFVKIs6bifoh5t2kr9teoozfUP8HZ8ubdRDY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0Vnem4rSERoSTV1VXZhVW5rL3JqQVErZWxhMFFSNU5JNmRydmdsc3BjYmho?=
 =?utf-8?B?TEJlOTRUSFEwSXlNbzNKbXlYOFBBVkI1N3ZkNXNNSU83bWRtcVNQNDQzRXpR?=
 =?utf-8?B?U25yMXJkdENqWkJzNkdwTGdCRUtKbTR6VjJhRUw1NjM0bDNQSkg3Yit2cWVn?=
 =?utf-8?B?bGMxejZ2UUhZelVrOEVGdWhGenFmTUdibjhOZ0lFMkZLcXQvN3VzWnVhTFBU?=
 =?utf-8?B?MWJzemV5Sjd1L1FzMWVCZDduUzZQbUd6REVqOFZIMGYvT2ZkTzdXcVd3WEYz?=
 =?utf-8?B?YjRkaW5rZmhWcWlDd2VZOUdPTDY0RmRBMGpGVFEyZ0QwUENYU3NLSFVnM1kx?=
 =?utf-8?B?Wm1rQ0tEbmtRMHRJNUZHb0pEeFJjMEZTQzhJU1pnNm5FbnJmSEJ1ZktOVVZT?=
 =?utf-8?B?UHh4TU1CUllxQ3JqdU9GQ2xKNXpTMkVMRTg5UXVCM3ZDWVlqQUhqMEt6UUND?=
 =?utf-8?B?RFJqbWRiSEh2cFZPN3R2TnQ1SThUVEJ4SzlZL3VIdklCTXdnTUpZOFNTVTB2?=
 =?utf-8?B?RC9PdldzOVJ3alNlcmRCVlhva0c2SmlWL3gwYlBnSkxaUVpLaUt4S0hEajRS?=
 =?utf-8?B?NmxVZGNXSzlBd2dwem16dUY4WE9xNEZPYmJUa2U5SVFkMjNzem9FZnBDWmRj?=
 =?utf-8?B?L3dhS0UwUlVSZXVlVUEwZ2NjQmVpT2IvdFJVYlVaYytBd0FaMEsvMlFOZjFR?=
 =?utf-8?B?OE1za3l1NndSMFVvMkRkQlVkZ3ZIdXB0SE84WDZCVGx2ZjhJZmd5eE02dDZU?=
 =?utf-8?B?NC96SmE4YmlGUmZ4ZVhtZ2ROTUxPTEl3cmhvN1ZjV2pzUUpkTENoaEp1eUNG?=
 =?utf-8?B?TFN4OTVNYlRpMWlvZytJcHVkTXhINitwSWt2WGo5L3RleFo1SFhuS0c0SlRX?=
 =?utf-8?B?bHg5cUx2TS9XcHpiK0tHejJvL0FuYmswekkxcnpKellhb3BybW5kbUY3d1Jt?=
 =?utf-8?B?aWwySjFDUnRMcWZNc1JmNzJOMDFITzhaUExzbS9Ob2kvdTMrcjhxeFNEUG1R?=
 =?utf-8?B?T0R5azE3NUMwS25ZUmt1dG1ZV01SeEpEenpaSkMzc1MxUmNUK0NUSXZOYnBp?=
 =?utf-8?B?aFloemlPRUJiaHNWN1gvOUYrdDdsc2d1RXN6NGc4cnI5VkhqT3VNWXNxZlVx?=
 =?utf-8?B?SFhKY3AwWitvQUtLTU5Od0dlQWV6N0RuYVc5c3hYcGtZVkFCNWdQWmVtL1JX?=
 =?utf-8?B?REY1SHN0R1ZiZ0YrNS93WU9TbjhLb0Z0OXJqTUdTNG0xOTc3azk2UjFxek9Z?=
 =?utf-8?B?dU9kTUM3cDY4MEpaM0djanUwbWEzQ24rSVljSlc2SU9NSy8zd1Q0NTBoeElw?=
 =?utf-8?B?WnJyTW9yTE1PMzBSbE1pUXIyallkYTFwVldZZjVUQjVkbjBBUDJQQ0VTWSt5?=
 =?utf-8?B?V1JOQXVCQnpLNEVGbnBPNjI3VVlVaWo5SWhnWTN6Mm5iRE9oS3FyN0svdmpK?=
 =?utf-8?B?aW1nWWxtbStLVG9DY1BKWnd6WHRVbm5pY2JVczlKc3JvMHFybWdUQ25mVHlw?=
 =?utf-8?B?RFFQLzFTVjJSTHpyT3dzcUlra001clBKQ1pHK3RJQkJSN1h3dUFzUDFEbWFz?=
 =?utf-8?B?cEdVOWkzTmlzZFpJb0dIVFozMGtWSUZFUysxMjdybVliTnE2RGNqdHh0Z0JE?=
 =?utf-8?B?LzFXeVo1STlDTVJ3YnQxZjhpaDNsRkFBOEwzZkZxa2tsSVdUa0hLK2hQOUUw?=
 =?utf-8?B?U0VaMFRYQjhQTlF2cjhWNnJMTUZKLytwSUhkNVJlam4yUEJDUkd2TWNmRC9W?=
 =?utf-8?B?SmFCRGFJM2xOODgyQW5pS29ua2Q1YmFnK0pKelZIR0ZHYTVKaUdXamZBdmRz?=
 =?utf-8?B?VkdSSWZnNHBuTmUzUm9sa2gvZ2xHeTFFY3YzR0xRd2JhQWNIVGk0dGVab25X?=
 =?utf-8?B?UzVrKy9mdjVsdUg0Mjg0NW9WaU9peDZCSDc0WlZlOC9YWEVTNVFWMkJ4QjBt?=
 =?utf-8?B?QWxuZHpQVFp3OW5TNS9uSS9OOFJPamJjVTdKVHlJQzhIdjlPM2JCME5tMWlm?=
 =?utf-8?B?MmRGSTA3QU1yb3ZwRWY5T2dNRitFd0NWNDY5QXVuenRVUDJCMTF3RkpPVlkx?=
 =?utf-8?B?Q2YvTTUvVmpNVW9PaDkrWDUxK25uclJ1NGtFOWptamk5MUNSaVNWb3c1dkZF?=
 =?utf-8?B?RXdiaDcwbGZsUWl5VERKUGdQb2VBR1BnTHEvNEwyV3RKQXVTVisyODY0Q2Mz?=
 =?utf-8?B?QUk0SXBsZGtTZHFEOUdHRHdkL0s1R3Zwb1V0V2ovaWhsY25TeFBQMFZvcGd6?=
 =?utf-8?B?QlZMMGhMM2NiUzhPdFY2ZlhUTU5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71ADD0B664D21545A6075D59EC6156DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ldmLJvUHZzxaTGIoNg4UE14V9+icUL0TDM0moPOuy96WsNrrG52wa4fCObAdLSFmT9OlCnEj+zz/41MuXDUjjW3DkkzQgIn/jFsKinlTsq6s+nm2ZLHNsXSpeoCWHKE2ODdDilqGYS8VwIWmUFzcl/oTFqy7JwWGZhqynVnMVnWhDDiAVyeQzNq/hEBe2jsHHIYonYebDF9e4zE7FT5eIUp8nC1qinhHPdQ3gPREqUSsyPtjPSkstt+lT0GN+AYAt6ARlYu+Qr8LqVlP1SKefQgJUUB2Cio8bE+E6M91p0x19y+yFcd8f7TOeT9OXdhtfsZu4jNsx00AwHc38pYFurSapOvSYZImoCsMZwoTRYJIRHYNFlFnN5sDQT2rraal/Hd3dM+woQUnOiJVNA/IBw5TN8GIxbQnZEfeF1N72yKlvdbn+nFs/iseqQnI8H2J+g/XMG1+y0H5G4HOCS9zvlHUaISW4J/D16P5F8TrNDtgBnTpsgQmRvL18jt9DgPrAiLFTBmusLKHdGdUgbKnEfIvK8KiXoL0zt5l09Op6PdnaOj/IO0az8pt9G4pqpoc2la2BRMr0gW7d7OMq3ROoey0j7t0Ctib9zyvBBuZ7S7DIEtzhliQCDFG2qIwx1r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e2ae0b-4c09-4fa9-b063-08dc471c0bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 07:21:36.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePutsqVsLVrm5PBf8thDMMXWM5RR+z6xmlelF+wpZJShvUCYZPQZ0Zflf+mRC4NO1ucV5cmrBwSbZGE4FLR2PZixvYE/XzXxHvn2YAWTH8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8693

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

