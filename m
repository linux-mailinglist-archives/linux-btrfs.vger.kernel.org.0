Return-Path: <linux-btrfs+bounces-12791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B27A7B790
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103B13B39DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FF178CF8;
	Fri,  4 Apr 2025 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CJolE5mM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="go5NClAf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA8101F2
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743746737; cv=fail; b=JXQx+7p9Fqa0BpTfVt3OqQKv1/DQpUu0m2bAXLigRl7z/p4O1rKs+DqZlGANmMEiyiVnbzY/TShk1XFyhnMFjoJuT/cH5tMNvVYNF7CxpeMRNkzTGr9Mjogjfm/lTwASiu4zq/a7dM22rmyu53Jfx/u+6SZq1y20JMte9wj9PQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743746737; c=relaxed/simple;
	bh=J5mvC746oWqenM0IePqD795fnAcVnEFhRqV+xjqAvjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czIH79sjRnpATyNLnRivNlQ/tocujXGzy4Ept9Eh9O/eqgFrsX0GIArW2uc+sHT81P4uUL3a5xvkqq+2NVbd9tKSJ0iZwzV7cAJ4MKRQI8z6vEhWJtH8XjHmKrLeig/G48Zqg+5x51Q8koI1nhEjphflCFdlrQHxMoDriDpzBh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CJolE5mM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=go5NClAf; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743746735; x=1775282735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J5mvC746oWqenM0IePqD795fnAcVnEFhRqV+xjqAvjM=;
  b=CJolE5mMj+uY4MfpAHA/Fp36w7IS3iiyQzjnIueh5JpRyjhzYxwm3Ihc
   7kj0hqr/X8edTqcGFrm+lSi98R8+UGtcu2LXdcdncI8PBMrw0H8WCvywr
   uJrng9rX5/QomBb013ek82nc2vJ/4Tn/Ay/XMCzEt92XHTF7ovJSgl2DF
   6Qkm8FQn/0SZUooZudHFw80hNLoGkyFQCuXt5VM2zBtrHbhXOekVHEVYV
   lbcknBCvzlP1oPksZM+2as6HThH9gh8wOGvCdWo39Tb6wPMX3t+aBKkbQ
   k24CW5PsLHTnpUMlioiwNExgJasgh4PYAAe+aVgqFBKpq+BouaGX6P00u
   Q==;
X-CSE-ConnectionGUID: jWqDmy39T9mVgzGoQbHgYw==
X-CSE-MsgGUID: sDToNt+TRU+wqGFJwaZEDQ==
X-IronPort-AV: E=Sophos;i="6.15,187,1739808000"; 
   d="scan'208";a="70769910"
Received: from mail-eastus2azlp17010023.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.23])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2025 14:05:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwCuGcwXB5HDaHoFpeSkeB25hYgdLEnG0mGGB94IMGu6FPDNoro+0cI9ek3l0Wx/ha+O6UjTfK5NJc2dle9PIFl3fLF6ERm/H5xgl+nVLDR0kUdhWWIxJfGJFr1RE1zsDsMlM2c+mZ05pW3f42z1Uw/uJxjjHkRthztzcLbfPVhmecI5Hd9ybKDzZs1onKQeq0aF45mvWIWLrFxwe0Vy199viaFNYhvdJpU1Tk1Ysnl6rx3bGPIr0u47I56Lmzwe+7ywcTOFac+lLtueb4swsWWcoABRTe/n87CBMS3AiS1cpXbSuY59nLEpwQ0Zr1YRXTAVYxEitzLw6bzTFgc01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5mvC746oWqenM0IePqD795fnAcVnEFhRqV+xjqAvjM=;
 b=MFBPGbGAb407wFkohYJZq3RuS6e+Gyx/VNq7OI7E4m9cqwR64Xsia2Sd9TQEo9A3lYCmE8sGsb0Iekk+MVM5SM7RllGkHid2YJTaU0QvnzhkBpu+oLSxeD0D9GF/UT8dc4kFObxXZrPSXI2eiW0yfyjjfxoS1hHWZPYmakcoVujNru70QWjImMsV0/7KCoGROfniqvQpMOiUfk0Dlrp+WxWvlOUQy6QEH43wsywyDqTyYQalOoNG51US0NAYlId5JLC1o9JcFU4aOXUiIUaGYnBe+lZ8XyJJe7j0ZCRr+wLZhBZJTcc0LreOdbPucoss/8bDusAzWbZNDs5nihrR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5mvC746oWqenM0IePqD795fnAcVnEFhRqV+xjqAvjM=;
 b=go5NClAf3ieD6pxVEIvyLWB/lQJc0z1zIXyjG3asvzv9mR0f6AnVc9F7bRr6RMucgMCJvv21eowk1WkK2IqdsffiN8fpmWqJFRxAAQ/C83/dmoDUM06TzdQW7bcxCWY+rVSDSl0NRPgKXya7bgjrTOIy6m3Lyf+2LMFA6ATSfXo=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BN0PR04MB8159.namprd04.prod.outlook.com (2603:10b6:408:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 06:05:24 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 06:05:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, Josef Bacik
	<josef@toxicpanda.com>, Chris Mason <clm@fb.com>, David Sterba
	<dsterba@suse.com>, =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Subject: Re: [PATCH] btrfs: zoned: return EIO on RAID1 block group write
 pointer mismatch
Thread-Topic: [PATCH] btrfs: zoned: return EIO on RAID1 block group write
 pointer mismatch
Thread-Index: AQHbl03eYsxEKGkcqUSsmtEsY8MUK7OSfaKAgACi3IA=
Date: Fri, 4 Apr 2025 06:05:23 +0000
Message-ID: <1da17177-af1b-4ff1-8eee-700c6e6193ee@wdc.com>
References:
 <f6c1c74599f51626bd2b804705425f68e5544bfe.1742223756.git.jth@kernel.org>
 <20250403202229.GW32661@twin.jikos.cz>
In-Reply-To: <20250403202229.GW32661@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BN0PR04MB8159:EE_
x-ms-office365-filtering-correlation-id: 8a235fa5-dab9-4b70-17c8-08dd733eb050
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEx4a3FMUW9ZdmpjWHVnYm5oU1pZbHJIdCtYUnhhR2hFbTQxcEZENmt5bUtw?=
 =?utf-8?B?b01TYmlPQU84MUtDd2ZBTUxJQ24vaUpGSFNvL3Y1bmZMSXJJVGhubzBzb0NC?=
 =?utf-8?B?UWRlVXFaS0lQdkpqemxNS2N3Ym9rdkUyeTNxalV6ZUNBWVo4SlhaMGhCbllS?=
 =?utf-8?B?eHJLait3V2RRSWcvRFpzYUFpY0JXRktSZEQrMHh2S3VZdGJIcDlONmkxRXNm?=
 =?utf-8?B?dk5NbXZNM09MRit1VDdHdW5WWGwzQm9oN3FiOS9yY2F2ZUVENzI1MktmbEU2?=
 =?utf-8?B?NlkvZ2gyTmgwaE9VZFVsbHRpbkR4TURxK1pBaUJxVUhmcnpRMlZsNkRUV0FN?=
 =?utf-8?B?T1IxbExXN1g3RE9qNHZxdk5ENFcwdll5dXM0bVdOYkxBZm8rVDZwS3l0azZI?=
 =?utf-8?B?VUl0dDNQc0lCRXFWd0kvZDZVczRkSWptZjZEMzVOUlpnVnNkR1ZUNHcxaDV4?=
 =?utf-8?B?cHlNKzFITDQ3aGg2clhQMERncDg3MVYwRithZzZrcTU0dlBqM1A5ZXNObXN5?=
 =?utf-8?B?TFJvdDdBVGxWQTBGdnRxeHdYKzUvdU1jOXE0cTYxTWNNYUJ4K1ZJd3VRVkgz?=
 =?utf-8?B?aXN2ZTBUTnB6Z2dta3cwNktCdzA3YTVlaVBtbHEvSHlKSTk0VzFZRWNlVERw?=
 =?utf-8?B?QmMzYkkwZ0g4SWhiYzJGQmtzZE1UWlFrVTE3R1NjaWNDZG1NbzJOK1hDNmsy?=
 =?utf-8?B?ZE90Z0UxZTBITG1hRlZiRURIcmNZMmlWaUVUMUZiNFVHYTg3Z1B0UE9OdFdz?=
 =?utf-8?B?bHRUYlB2Wldvam10MlJOWWVodXJhMWVsRE9CeXlMbzhWTDlxUmtmaVZoZWJm?=
 =?utf-8?B?Zm01WktZck5Ua2h3M0VEbjUvTDZTaGU1Z3NDV2RvdkJ2QU0vYmJUZ3VKVVZX?=
 =?utf-8?B?TzN2bnh3eE5aTmVZUEt2SXpVR2x6OUNMcTFDQVExUi85cER6djE1NHZGeTM5?=
 =?utf-8?B?WERLMnRRSXdFbnM0R2pkdEd6Z1pJbW5QNVhiVXdXamJYbldvWHZ4aGtrdHRm?=
 =?utf-8?B?SFIzdjhFM1E1S3IyUzBpVmJNa0tudUFBK3h5bHQ3ZkRmMHdQMWFMM0FTZHlI?=
 =?utf-8?B?MndzcDNRdDA0S2Y2cEZ6NklEL1REcngwbWdtTEV2UXlCeE4wZXpiS3VaTHYx?=
 =?utf-8?B?QUNpcHFIWURRSDhDcVBqUHRRWUR5RURIbk43SmFXOVljSzNjYlBtS3JCK0dC?=
 =?utf-8?B?L2lxVU9TOGVPT1VKa0ExcEIzNVluMElYVHdiZk9FQzRubmJNQ2ZUZTU5cjlj?=
 =?utf-8?B?QThXVElHVGdISElvZENybmdjU3RQY2RqU0s1NEtlb2srYVdQenlIaEZaY2xT?=
 =?utf-8?B?L1VuTm96c3dhVVpIMUVZMy9pQWhZZ25tZGdhMWcwSjVLc2g3SkgyLytnMW9s?=
 =?utf-8?B?amtUU2lrNEZRUG1ucnJBMTN1UVIyM3ZFQ1ZJMW9hWGZ4ZUM2RUNpaHp5ZFds?=
 =?utf-8?B?ZDFUbHo1NjFiZlI0VmdYWFYvVForRDBhTTV2NXlraCtVQndTV3JremNmUnZ6?=
 =?utf-8?B?OUF6aVh5cVBPU09zaEFJRFpYVlgvdEVHZGtrOFFYVUdsc1BOMGJQRUhlNC8v?=
 =?utf-8?B?VGkzbmJMWGQ2L3RINllIZGZyQWhLcWJVT211RkM5REpORk5TR3NtWkREWVpZ?=
 =?utf-8?B?cmxaL2Z3WlFWaExqSTVqckxpRHNxZXFkcC95eHlWUXRmZEtpWjJjbU5uaElu?=
 =?utf-8?B?WnU3Q28yK29jZHhPQlJoQXJxSWtIOEFCSkR1akpMbGNFVDl1RE9IbVdjNkNr?=
 =?utf-8?B?akdrNUR4VzhFUGd5b0piZ1QwaTRFQ1RiSXROSm1BZGYyMUJWQm5tZVdqeFZU?=
 =?utf-8?B?bTVLYmxJejZoeXJSY3Z4bHpVMG8ydkJTcnFhKzBFRHJ0K2tVcXVIQm41alFI?=
 =?utf-8?B?dVVPbHV1KytXa2J5UTUvbk5WeHZrQU9RcTUyRk5GbnFDUm9xeDVmR3VkUWdI?=
 =?utf-8?Q?OJHyM8OxEoCheN7esnp3uNcUrRI2zt+f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjdSbVhPdkh6Z2x3TTFlaDVxUGZrZzFCUGNTSnR4OVNoVEp0U2QwK0xzQ09y?=
 =?utf-8?B?OGdDNnl6MTBoVDVGRU5aUm5TNFBYcUZnMnFEazBMQzBoYkEvV2xmMzIveElF?=
 =?utf-8?B?VndiaGZmM3V2dzg2cStyeitmYTNIU3lUZ0x1c2Y2c2loT0lyRkxHaHFuMUh3?=
 =?utf-8?B?cGg3WHMzRzJoYnFXMWFIMU85YXF3RWcyaVJDY3AyN0FEZkxFOE1qRkZlU0JW?=
 =?utf-8?B?NzhlcENmUW1TWk5keHErM3RmRytGRWJoTkM5R2VIKzBkSDhBMTNtV3hsWVlZ?=
 =?utf-8?B?OUh5MG1TUitZMFhCSnVwd0hvaDQxbnJiMjF0dG9DUGx3K1ZrYnAvNmxRYVVs?=
 =?utf-8?B?YXNRS2o3d0hpamwwcFBEVU0yeEJxclVwSy9TNGJmSjNvZnN1c3hVUU9hRXlT?=
 =?utf-8?B?UFNiSm5TVUhqdXBWNlMwTXNkQnVKZmxZVWZvcXo4aTgwSTRFMitaUDZYT0ZN?=
 =?utf-8?B?UVNIaUd1T1NCQUFtRmxObUI5VnFlYXZuVHBFKyt3azVnS0lOSm0yTVRrV3py?=
 =?utf-8?B?SUwwbkhRMjF0bEttSDRNYk50WXFzdEo1a1ozVWdSNkZYT0JrVE5DM0x6TmVK?=
 =?utf-8?B?cjNCYXVyU3I1ZkR2Q096OHUvZTU0YVhWVEVzeDZEeUZIYkxhZGJJUGxUc05W?=
 =?utf-8?B?b3lBVjdPTVVJdllVd3JvSzBMeDJpUmVpa25JaENjaHhMSmVrSVJuNlZ4V2Jk?=
 =?utf-8?B?cWQvMEJKazdNR0s5NkVRSlVsenNSaHZaUjZJaWFNbksxYXpYTlA5SGZKTE90?=
 =?utf-8?B?Wm5KY0s4Ti9zWk5pdUd6RWZvWEtVTm9Kck02MkR2bEZabzIzK0dpaHFBQytp?=
 =?utf-8?B?bEl4eVlIOE0rWXFIcW1SdVdqcGdJaDBmK2M1bDgyNXVUZlNaT1NRSm9VbURm?=
 =?utf-8?B?bGE0WVh3WllvZzUvelUrNVl0cnhhT2lTa0REZ0Jub2xqcngxRlp4WTBheEMv?=
 =?utf-8?B?UzhrUEwwQ3ZqTzRpOEVBdjJIdVBvTzIzOW9FMkRWTmQ1WTJ3eUNyMjA5SU5R?=
 =?utf-8?B?UWpiMnNVb1p2c1M1bXh0R283TzFjeTFseG84d0RyYXpka3c0ekNjdlcrM0Vn?=
 =?utf-8?B?bFR3Q2tjMTRnbnpyb1BJRnByNDM5MHdLTjNRSTdKT1V3ei80K3NxdnhJUHRR?=
 =?utf-8?B?ZVhONXV2M0pxeVVBNXZsUGJWaVFCMHBsM3JLTUN5OEl1ME9IOFY3dnVUc2t1?=
 =?utf-8?B?VzZqT2Y3ZXVSZVFrTW1vQTN5WTAwWmdsTlgrdkhtV21wTnFOaHlQZ0JJdXpQ?=
 =?utf-8?B?L1ladXo2RWdVd2N5WkY0WWFvQmpBUlhpSVE3em8zTjg5TjZDUDllWGNua0dU?=
 =?utf-8?B?TW5vN3dTM3A2Zi9zSU8yYUh4ZXZsdkQzdUltVkdMckRyS3JXZEkyRjV3Y0Iy?=
 =?utf-8?B?N01hWHNPeCs2KzhxVkdpNEIyZlo2M0dsV1o0YTdpcDhjUHJ5dGhnOUd4WG9m?=
 =?utf-8?B?VVhhUGVVVFJPcHlOcXpiS2FuWE5BdjFvRFNuRDV6Z1RkaTIzVmJHeThoZE5l?=
 =?utf-8?B?TGxFenRMREREcDVzbktBSHFiK2lZOU5sRm5qYUNlYlIrRDJUNUNLSFV0NGQ2?=
 =?utf-8?B?bldQdmpWZWxWMEFURjZhMjhoZ1NYZnRoTXY3T1BrYVNLWXVXcldVbkx0cnVN?=
 =?utf-8?B?a3BnYnJ5cm1xV0pUY1JHdVU4S3NsaUJRbUJ5UUd6UWswOUJLR25nVzJFL3R2?=
 =?utf-8?B?MjEvZ1dnYlIrOWR4b2tKOHFkeGk5NlZHU3lsZlRMT2ovOFE4MVAzRytNTVhX?=
 =?utf-8?B?Y1RHUitjM29aeTRVVUM4Z0Y1RjhVQlZQdmxsbUQvdDV5N1pUb2tFZHcvZVlV?=
 =?utf-8?B?VWx4czRWU0pVMTd5MUJFRml3amU4VjdMczU0N2lCd3d4UHVMbCtCS29ySVBw?=
 =?utf-8?B?WXB6ZGZDT2lpTWZIb1E2YmErbm5LbkVQcGlZSzh2cXJGeE9jY1luTzk2K3dP?=
 =?utf-8?B?b1dZb1BNMGFFSWI3akpNSHREOVVFb3RlMzlxMHNEQVV4MXlVUEs4ZGJxRUZQ?=
 =?utf-8?B?dmdsNE53UWNrT1JwV3R4WGZ6ZVRGdDBXOHV3b1E1aTN1MGZEZUh0c05NUDgz?=
 =?utf-8?B?eE1HNlY0OGVOcG5tU1J1ZlU4M0R6UHVWSmcyZ054NGxoeXhSV0lJeVZNNHp3?=
 =?utf-8?B?Q3M0SVJ5anB4NEJlaGpycEQycldEcHMvb2F2MGZMM0RLWGdjS3N4czhWU3dF?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA81ADA606CE4F429E2CCE495A65F0E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uZYNhk107kTwe+2rhxWBPEGBuwOjgE+Hdqo0gFITlSKXy1tRZnXbi/nW2xLdxarmjWYZTU1TTzYrj4ADUjJuLzHlhyx17vRCu8D7rBi76pdou8FDrBwxOUlCFqdjFU5V2q8GcjQsBy9mcrH2jE4E+auSsbjhZ6rfzw1OWwBvECO+JgLN8hNMtZD1jXOdtkneSeobtQPs0aKUNnVfUp5CByBBTwGqH5X6WYut2wLIFHQ8dO2v27b5LFtb4TigUdI3VEL68rL/WeSvy0ikWE92Eyur2SPAv5Q84oONuaUKf+caF+rD5/Bh/NtPjkzOYqTsVT8BkwW4+3GAmo6xAvfJzG8lqUElGR2juMP4U1RU8wfre7nHmALwmQU1H1Yx6iSpwUyBL2vFDPntHPmyfIlJUzJ3lpZTlg7oZOHVyGNjVPb+ViMVnAH232tQeF4DCnIvCQJ+uQ2Bzgcv0X9GDXHFY/+EDKT0prGEoSRPvUt0rluB3+8+Z0Y04t4X9L4iqIFO3N6yZ6H8+mOcofkp3zDqlkaVmBbwaLT1L3u6ZZNzLBuaruMBbNtYatO0gLuRPX+jcJVKIma3nkMK+JlrBOeDXDJONGehl9peI9KzMQx6IaAhKWGSb1qZXbr79R7067jw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a235fa5-dab9-4b70-17c8-08dd733eb050
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 06:05:23.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWZ6AdWCcXjSYyZQCHoSw3UJeKZbFypMoPfEuyVtNUStvQW/ehdD7+dUwu0+0n81dbGzjSDeLfdqWSE4fkjKuyCAhQIKfHK4TJ70cwyfrz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8159

T24gMDMuMDQuMjUgMjI6MjIsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+IEZpeGVzOiBiMTkzNGNk
NjA2OTUgKCJidHJmczogem9uZWQ6IGhhbmRsZSBicm9rZW4gd3JpdGUgcG9pbnRlciBvbiB6b25l
cyIpDQo+PiBMaW5rOmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLyANCj4+IENB
Ql9iNHNCaERlM3RzY3o9ZHVWeWhjOWhORStndT1COENyZ0xPMTUydU15YW5SOEJFQUBtYWlsLmdt
YWlsLmNvbS8NCj4+IFJlcG9ydGVkLWJ5OiDopb/mnKjph47nvrDln7o8eWFucWl5dTAxQGdtYWls
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybjxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4NCj4gUGxlYXNlIGFkZCBpdCB0byBmb3ItbmV4dC4NCg0KDQpPb29wcywg
c29ycnkgZm9yZ290IGFib3V0IGl0LiBEb25lLg0K

