Return-Path: <linux-btrfs+bounces-11692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CDA3F3EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 13:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D6E7AE3EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765D20AF62;
	Fri, 21 Feb 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T89lGMkm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EVZ/eirE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318751F2382
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139598; cv=fail; b=de2CpZIMAj4gYp3KnGG9/aF1pX30Wp58N1qOap80qzeMTOBhdUgFMla9iID2li1a4z5+m7VcecEbv0XjiW229gBfA6xtM9JlE3q7OSlCIwqF5+Emi40KcwWWLxHWFyFvaQq2tkRddCCt8bDZb46bia8Rs8bXY7cgeMcFbRTkvaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139598; c=relaxed/simple;
	bh=2jpHDqn9gTyc2fm6pf47dA/CxbXv+LkzXnY0ryTTI9I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scjToTlZ5Sca/YtQa0b3SwlAtKp8Vyo0PXoW0g/SDGKOTQrbp4B2ruGKSrVtFus+MS7lrEkjPaKzTP1CfLpmsWNAxkv1cN1HcKtm58im01QvRaZ4mWS24ThxCZtVAw+W9G65WXiaYs1bf+AuI7KwJvS8eLB2FYPW5moan6E6qO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T89lGMkm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EVZ/eirE; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740139596; x=1771675596;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=2jpHDqn9gTyc2fm6pf47dA/CxbXv+LkzXnY0ryTTI9I=;
  b=T89lGMkmJtDkqTKUkDwa9Uu0Of7LKSr6pxD/6+1bYxBxgnmLrGt4YJFX
   6jtrfNvhhFdfC+lUTfgVW39j3HiyP7SDn6GbFj/CfQ3OtLZltSZIu9wv5
   HJnZzh/oL/3SUcmLiejrdHkvq1HZ4fsHpxD5C6C4gN2c/XMcnuFCTJ/YV
   WV9kiHuMlHmsKxp6p6sXq5WAEl47lvyptNjgeY8ZfV0yii5/nAQvyqMa5
   cWlH+t6DJPmiNyEpyPxdguXZI9H0xrpAdOrZ+x3W6F3ZrKeCnJR9KjXGR
   1D/Acdlg/Vc0ikQm39uvbcc4dCw+7r0A+Z1ZjgySkxhXY5MR4CEaVq9VT
   g==;
X-CSE-ConnectionGUID: 6ppld0KPTjGtruz4VujbZA==
X-CSE-MsgGUID: 8qvWw8I4RdqTyzIQWys6Mw==
X-IronPort-AV: E=Sophos;i="6.13,304,1732550400"; 
   d="scan'208";a="40365916"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2025 20:06:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH14S3FVcVl168WKERKNm7sS47eRWSC6V5ATyH/4JdKFwSqn4bS85A1AbyYPN+Jev5a1codFXV+6bU5Hf+wJhW5eoR7VsfqMLg1pFhXLHfn7VR2T+dhpacNs3tpM2JFHGmDRkfRnaVLJ1sesqxxPudCGz7+0OrU1PsqmpSPPAXOt+dcmrBzEuma9dGgq4lWNgsU2HZ8HXSkSqG5FtUqRaoZ93a6uF5TdLQXnDavYCkxygaJzbRq0q9kFA7WwnjS2SmQTpoUgNYYEuVtGOvdIJc2LCVyeX8Qv1xDjQiaiIeCZsBkQwE3+y9eCFLrt8rcwBUsMt3ngUF11DfiuCu4L4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jpHDqn9gTyc2fm6pf47dA/CxbXv+LkzXnY0ryTTI9I=;
 b=MDYcih96tMQYHP1Eh6DYE+mOOGRBoJ3XdX/Kd0/tnmP14jD7SU8SJ3kPZ61YfnodYYzC5mBbT6WIEQDfAWpfPVe4HMey6Kp3DtfATpT/i82WFaF3BdqoEKHpfX8OQ4hUo04uH7wQS7TZbH4NFnlR1JW1uEEDNuaM5TwL6LdxzxXFC7qBjsE6P9FUmKD5AQT6Gm9j66s7cb+WFTfYVJgozFF3dRtV660ibv9m6V8xBmeMdC419GALd9OOn62yJDtCZB32dowbMOqIuVX+TgbgqHJAHL2zSfKBiqzKJfqkCqRDP7cewPouXjlab2+aczWsHR7uB9+ezqb1wkV1lCcxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jpHDqn9gTyc2fm6pf47dA/CxbXv+LkzXnY0ryTTI9I=;
 b=EVZ/eirEsoOV9E8fIGp05A/3M2WKnjSoiAp0hbNKUc5cuPizk/0nSc/arGkbcQxWx+CcLmXhhFE1+x3DfCqf1ve9472t/VqWk4PvrjfmNEQaMPV6m4eQQjNucKcbsbWw+XFJQxT35IYs8fDIu5hic4i4S2ggAHUt1qhSYf6zs/k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6373.namprd04.prod.outlook.com (2603:10b6:a03:1e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 12:06:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 12:06:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] btrfs: prepare subpage.c for larger folios support
Thread-Topic: [PATCH 1/5] btrfs: prepare subpage.c for larger folios support
Thread-Index: AQHbg3lMXqqcV9Q1M0mJhE2JjVckk7NRqyGA
Date: Fri, 21 Feb 2025 12:06:30 +0000
Message-ID: <152ee58c-0ebe-4e58-a0a1-94e8c9c51d6d@wdc.com>
References: <cover.1740043233.git.wqu@suse.com>
 <1399d0f444eb0dfcc391c430193ccd8649ff2c90.1740043233.git.wqu@suse.com>
In-Reply-To:
 <1399d0f444eb0dfcc391c430193ccd8649ff2c90.1740043233.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6373:EE_
x-ms-office365-filtering-correlation-id: 7fc69b4b-9565-4216-3294-08dd52702d0f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDU2b1BsOUlTcG0zc0hnSWY1T2xWMVNZQ3hQN3VLcVBOcHNhaHRhSzVwVGgz?=
 =?utf-8?B?b01kVGU3aGtVbEs0N0t0eHRnQnRCbFFLTHhMeDh4dDM2OGZ3Tmx6ZDZ2WjNL?=
 =?utf-8?B?WkZHeDlOdVNjZUgvdUZLdGNCdHgvbkNtM0ZadWxLbHNzRDZNb0JKZi9VUnJX?=
 =?utf-8?B?bXRXY3JYVWdsMmt0eDVMMStRcENXc3RXcDZLc1A3M1VCcG41YnNGS2xtYmJW?=
 =?utf-8?B?bFFtUytOU1Q0dkt3S21va0h4aVdudlpYOEl4bHNOQStGSTZJNm9jTlVjejlB?=
 =?utf-8?B?b2lrWG9Idjk5dkR1RU43aEN6cTJ4VzNRUVo3MlRTODdMNVRYK3crKytmVHRy?=
 =?utf-8?B?YURZZVNsMkY4d1BjQnpTbG9ORmhTSTBBb2l6Q0tQRCtRb2RuNWorQjJGL2Fu?=
 =?utf-8?B?aFpMUGpPckNEdzJXOXYrS003djZ4RlFDaVQwVElkY2IweFNoSUk2ZjVOanl2?=
 =?utf-8?B?QnJ0b0FRbDNMUGY1aEZ3SCtNT25BVDloNDdBY3ZtaGRVYUxOR2FuL2JXUUlk?=
 =?utf-8?B?bnRUUXh1U3lhNklTUUJOYUZIWHVFV2FDc213SVVJd1BoS0wzRHdjWlNlYWov?=
 =?utf-8?B?NmhRTk5lMnpiamsxQzMxUjFJY0xvd3BDZkRMenBnaUV3MjI5Q25VY2xBZnVy?=
 =?utf-8?B?YnVVQWZDYTRvVlVpaXE0bkNoQ2RFWExENjNpSjVvMytXZFd6eEZ2bEpONmtu?=
 =?utf-8?B?c0R0dTdSaTdzTXFXTkdld2tKTndaUmp4REdjUnN4dnVSTi9ST1AyTTQxQitG?=
 =?utf-8?B?a0J0ZmVYZHhEYmtKOGJnZ1ZGN01nekdOd2FFYjV5dHhYbGN0cG1RQmRyNEVu?=
 =?utf-8?B?UFZiVDZhWkVKVXVoeEF1SHBQY2dWVENFcENQTnFRWXNXbU1DSDV4b3dkNlp4?=
 =?utf-8?B?ZmJLS0p3YStTOUg1cGlLMDI3aTNHcWZvWXE0RmpXbSt4ZWhucWxqbUFMOTE1?=
 =?utf-8?B?TUU0QWZpL1pPbjdNdDVqZWFMaVhFSXlvS2hvb1lJcCt3dlU0SkRWa2pHR1ZF?=
 =?utf-8?B?Wm5iNkNzNElnSHpXZ3k4ZTFDd1dCN1VGbW1yOHI1T2hYNzQ3TElsM3RxeFBO?=
 =?utf-8?B?L2pTeXRqcFdzaEhiajN3UHN2Z1RtTUM0SW5RMmRURm9Mc081dXpPczB2QlVu?=
 =?utf-8?B?Y0pqS0JONjQ2OGt0MGQ1cjR6bU1nd1pib3F2Tzk4ZUowaEtVVDNtRks0SDVi?=
 =?utf-8?B?dWpsRWxyYXFNRHJWNVhtT29iYlJISEx6SnpCN0N4eERka3ZNOGlqY2hyT3FE?=
 =?utf-8?B?anlJR0lxVWs0V1ZDMGtiS0lsSFB1QlVUT0dXTmdZdFRkSWJ3SGx3TE8rdVNv?=
 =?utf-8?B?anNoZHF1YnlheXorSjFkd2xORXVMQjIxakFtVjh6TGV4QWwyc24xQ053M1ly?=
 =?utf-8?B?MGh0SE9aZTEycFdHeEZmMWJ0bWJSRnpYcGNNZ0ZxOGFucERCVjRFOUhtQnlD?=
 =?utf-8?B?a0FrZXNyRHViOWJHR0F1VVhiUFhRQzZQS0svWEg5bmxCVWlCNjJDSFpaT0pa?=
 =?utf-8?B?Y1pFQ2hleGduQ2UwNXdMbkpKYmw5UHFvZHl3bE15QmlSZ3JVVFhPSy9KRzdt?=
 =?utf-8?B?UTEveHRoTWdzMnRwd2Z4T1EvcnlhRW44MDlUc1hKaTdDcCsvZ2tkSHA0ekZO?=
 =?utf-8?B?aEYwR01pVi9WNDNHaGg5amM4RU95NGNHdWJpSFR3SUl3MFhpdFpnK3hMNEtN?=
 =?utf-8?B?RVJtWThzbHQyWDErUWZ5ajRJRWRJcmNDUVc0d1o2dDRoZG5FVEZKYU5vaXRo?=
 =?utf-8?B?OG15ckxqRzAzb2d3VGN0Tlk1WG5FY2k3QkxPaVBzT1FHbm1hYkJ1b3Bjemx0?=
 =?utf-8?B?RG1GSkx0ODRHNW9DZlRNY1U1TkpxbWw0K2xWbE16RlpROXoxdnIwdnVpUVcv?=
 =?utf-8?B?bDA2S0ZzVjlXMHQzRjNrMnl0YVdjMHRzTEhNMjZQUmJSM3pjNzhpWGhOWHVs?=
 =?utf-8?Q?2T1eM9QzJG9aWP7luwKipKnFewLMAVRg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnNuUTVHa0IvMDVWUzQ5VnlMNytBY2hqOVQ2a1diVkc5RTZYTXJteXVxVDdl?=
 =?utf-8?B?b3A0OXFBb0tObGYvcWl0aTJIbjJKTTVqL2NGQ1VBOUJPMC95dUExTHFqbHB1?=
 =?utf-8?B?SHJkdENJVTNnVzRQYllZZkZUSXhGVW1FYW5YZWZRck51L0hWUDNoTlc1V3Zq?=
 =?utf-8?B?SEQ2YXRxMzI0U0loRGIrOSszR0hOSlFFOXU1bnpLK3N4N240TktCS2o5TjZW?=
 =?utf-8?B?RGNVNXZYWVFzOFhSR2FBeHdmQUdQMzhsNnJOVTQxLzMvcHpxbUlxUnhDUkhj?=
 =?utf-8?B?eXVYSUs5Z1dXSEtkZHdZdEY1YThuUVc4QXZuOHFFVG5UaFQ3ekpnZ0U4NHhw?=
 =?utf-8?B?OXhzTWNKUWR1eVFqdEFFVnBBZ21JdHJxQ3pCc05QRGRzTFVxeURod2FoVis5?=
 =?utf-8?B?NzJiSnN5b1IraHRTS3VzMHF2UXhhQnpqcjliTlJ3eWpqTk5LMU5GZUhsSlNQ?=
 =?utf-8?B?ajNRV1RwbnNmUXQ4SXhTWkUrRjcvZWlsQW1qcXpNb2ptQ0pZVVFVV05PdHVG?=
 =?utf-8?B?VDZQcjVOeWNweWpFU2RZRkZqd3BoZ214U29wblFaOG9IdDFydCtHNllNTHRZ?=
 =?utf-8?B?ckk3bU5PUUNOUDdydFJFamF0emZBaVZQSUY4elFYNk1kaHQrU3p3S1lkaEpB?=
 =?utf-8?B?bElHbUw1VmllVU4yd3g4NkVKNFJzVy9PKytsT1N4Z1cvcTYxS1RsdkNQbkQy?=
 =?utf-8?B?R3NYZGVHblpGMW9rVFBMRG1rY1Vzd2hRS1h3L2ZmbXNXeklpZTFEeDhkN2lP?=
 =?utf-8?B?ZUFhcis2YVA0aHZRQ2ZmNll1YWY3Z0FlaGtHUHV4cm9RazFMMXJlR2d5amJO?=
 =?utf-8?B?RHdOczdWZVRCMDl1K3FwQThLV0NwdTgzVjRxRlg3MGtYTGhrQlMvV0tBc1pu?=
 =?utf-8?B?Mm9IVDh1a3dKTDU4WTV0VWFNVGhXeHdwMGdTMHdTMlFEZjhyNm52Qld5OUJO?=
 =?utf-8?B?UFMwcDZZVXgrYi9qdFM3RE9oQmM4TUJiSXBuUTZOQUlBRjUrWnprc0xXTGtx?=
 =?utf-8?B?ei9OVndkbE5kYy9NUGQzczR5YlZBSmpHRHZBbzJhSzZ2bVpJZU9qejdlbU1P?=
 =?utf-8?B?OTF2RDRhM0p1OU9ja1AwaC8rNWV6a051a1BZUzhKZ3lZamhRVkJ0c0xiNXpl?=
 =?utf-8?B?OUpoQ1RkL1Z3RUdPczgzM3dqNjZvdnVHdzJYWW9ydG9JZ3gzR1VIRm1qTWlL?=
 =?utf-8?B?QTFXZDNSQUsyUHZzcVE3UTBHMitFL1VnYll5bTROeGNkSDBVaGozdnlIenla?=
 =?utf-8?B?Q0lTS0hPMUplQXl1dzJ2OEd5RmhUMUo3dXFUNTBFdlNoU2J6VmF3ZTRpL1dN?=
 =?utf-8?B?cWdoazVuSjlydXhyS0ZwcHQwbTNVWUZLNk1FdkFocjJVMFA4WllsQXR4UU1I?=
 =?utf-8?B?UW5NWHpwNXZ1eGVHUytMYlY4ZTNwdmI5TkV6NHcxay9XeHY0cFJMZWFpenUw?=
 =?utf-8?B?VjJYNkliRk4wVEVyOHRvdENXNFhFNWo2Q2JtSURWV0lNLzd2Z1lvcC8vMjZk?=
 =?utf-8?B?eGVzOGxKa2hZRGx5Nmh0U3RVaS9MdXdPMCt4Yjl1SFlXU09RSUZUTGZWVE5a?=
 =?utf-8?B?TCs0UG5GUUErSjJPVVhkMHhFUVplRVplaUFpMk5oUVUrZUhYRUFWTkpuNmlD?=
 =?utf-8?B?ZDJhOTBOc1M4T05JeXorQTYyZDl1SmNWL3lsVjdVTkNhaWk4RUpXbVA4d3RH?=
 =?utf-8?B?N2RpRlYxY0dUMUFGc1F1YUthVm1NVkJTM0FxOEdveVQ3Znp4Y0puR2wyQUwr?=
 =?utf-8?B?dHozYlllNFZCOFo0UG51blJESTJZK3BrZ3hLMlN6aWptT2h2MFBPcVhzR2Zo?=
 =?utf-8?B?N0RQQ09NYkVwbTRUZjRwSVQ2SkNrQkQ4S0lpTUw4ak9ibGc1dy9yWS9LdFFS?=
 =?utf-8?B?SlZaVXhwVzJHZUs2d3N3VVZLTTZyNkErS3V3Q1lRM0xBSGVRTHZJL2JMYjVr?=
 =?utf-8?B?aU94M1FVQUdOMmo4SG5Lcm5sK3UxaXN0Q1RXMDJ6aUNxWnhpbFllRzZPNzZs?=
 =?utf-8?B?cHVORVlRQVB1b3NtZE93ajloSUdsdlBGYTVYbWtpZDk2QXp0N1pKQlM5a0RD?=
 =?utf-8?B?S3ZPQldIejNmSVBrWDA4Mi9uaE9JMlRoYWFCU05odUtTRXFyWUJBREtINC9J?=
 =?utf-8?B?THVHWlFhUGxzbmw3MnFYQUJZTTBzbUkvSjlqT0RDTUlMdHBaTS9LL2V4ZENT?=
 =?utf-8?B?NDYvTjdTcFp3MmczTXQ0RGluSHBUZHRVYnhTQW1MWEp4dlJBTXB3TGN2dHJV?=
 =?utf-8?B?K2hYRnpjOUJXTHh4R2FPd1lIUDF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <932696CFB3C68A4CABA46BC32CCD8B0B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mCjciGkp14FVVnYSG41um+mnIjjJR0i+Iwbngge1y63P5HDqX/qLMELXLpSUIkOE78AOX0bKmzHXyU4HwBTWbdQ6QesSbvuGUhrpK8NdYy2ZWtsG5Koy+jt1rWi604Ueh9qPTYwcJnKDlpzOKHG1vtpN3eBHlbtl7N0prvXMWetFh3zfn/sdrAGM1L7ryZK+eCsWDZm+0IrMHfOJkhgGsZ52v/+RkL70GyFPmDTaNtGQsPFuMUk0RXF83PhIEFVraLkybKVUa9y+HJYnE8LSrk2/0ywovCtrjJ7ZUzxG2hq7ZvsHidcWkpAZlWqCAVy1+GyA8qgq4PYdOW8bU7rGiWI6+FwZ4a38ZwmbH8NqjwMrXnL+Yjhist9lZvvBecNlkoghR0RfTPfH4YpiBXyg4haBZKukH+GppsayGO/rZqh0jTxiqhZsTEyAKCn5qW+GdXeRyMPHOUiuV9Itd3d8LLP/sdJFVmAiplncUOz6RFDzIl4wjKwcIhdBWAgFY1oihmdPSFd71IWw2U20iFoshitrPRGCxe0YzTwdwxzDjuqplzyXnbCLjaGOS6db/VYBOMumqqywpDDAdLV6nTCgH9ZPR7E9B9HDSp+7nJgARPBhOZSfV6vob337r23Jiivw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc69b4b-9565-4216-3294-08dd52702d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 12:06:30.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIMTLeYm2Ng4n3mAJvALbGU5veuZ3sg/J2i8hEuqkleDndvniIWYJjH3PzqYv7reZWIS6n6nx6RWN/hSekyySW2xdq3FmMOOiC66myT6/yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6373

T24gMjAuMDIuMjUgMTA6MjQsIFF1IFdlbnJ1byB3cm90ZToNCj4gRm9yIHRoZSBmdXR1cmUgb2Yg
bGFyZ2VyIGZvbGlvIHN1cHBvcnQsIGV2ZW4gaWYgYmxvY2sgc2l6ZSA9PSBwYWdlIHNpemUsDQo+
IHdlIG1heSBzdGlsbCBoaXQgYSBsYXJnZXIgZm9saW8gYW5kIG5lZWQgdG8gYXR0YWNoIGEgc3Vi
cGFnZSBzdHJ1Y3R1cmUgdG8NCj4gdGhhdCBsYXJnZXIgZm9saW8uDQo+IA0KPiBJbiB0aGF0IGNh
c2Ugd2UgY2FuIG5vIGxvbmdlciBhc3N1bWUgd2UgbmVlZCB0byBnbyBzdWJwYWdlIHJvdXRpbmUg
b25seQ0KPiB3aGVuIGJsb2NrIHNpemUgPCBwYWdlIHNpemUsIGJ1dCB0YWtlIGZvbGlvIHNpemUg
aW50byB0aGUgY29uc2lkZXJhdGlvbi4NCj4gDQo+IFByZXBhcmUgZm9yIHN1Y2ggZnV0dXJlIGJ5
Og0KPiANCj4gLSBVc2UgZm9saW9fc2l6ZSgpIGluc3RlYWQgb2YgUEFHRV9TSVpFDQo+IC0gTWFr
ZSBidHJmc19hbGxvY19zdWJwYWdlKCkgdG8gaGFuZGxlIGRpZmZlcmVudCBmb2xpbyBzaXplcw0K
PiAtIE1ha2UgYnRyZnNfaXNfc3VicGFnZSgpIHRvIGRvIHRoZSBjaGVjayBiYXNlZCBvbiB0aGUg
Zm9saW8NCg0KSSBwZXJzb25hbGx5IHdvdWxkIHNwbGl0IHRoaXMgcGF0Y2ggaW4gMyBkb2luZyB0
aGUgYWJvdmUuIE9yIGF0IGxlYXN0IA0Kc3BsaXQgb3V0IHRoZSBicnRmc19pc19zdWJwYWdlKCkg
cGFydCBpbiBhbm90aGVyIHBhdGNoLg0KDQo=

