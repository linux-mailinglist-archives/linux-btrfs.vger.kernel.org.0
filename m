Return-Path: <linux-btrfs+bounces-3823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141598955F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3775F1C221A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121085942;
	Tue,  2 Apr 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iJOjZyeq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KOj5wzKw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AE7F7EC;
	Tue,  2 Apr 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066345; cv=fail; b=HW/rF56apTn5ST1wyDUYznjZWSk05NfUv+cW1s6hXJx+AmrNvPl0aIkyhxlI5bXhIdh687IUbbikFVP2POMgu0pJCo4ixI99FosPidmxRTLzoNssr7Iu3ususRnIDrZhwu8HfMB/4OAe+73NGOTDDm6UN0AoFEpWtAJX7Pj2EI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066345; c=relaxed/simple;
	bh=/NvuaHc6W2tDBg0tURPBaCA1znz1350ZiURCu2lbOo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNrzGbZkxHJxAWhsO23lILRxDQokcyVGZLo+49DX2esz+g9fopUCqb7fwmIh4NaZLCBxPDE/d8cLiFikRfTFtS201bPTJMrd8KPa3CmWZ/hzhslkARSMirR3EtbRQspG6yYabXW4wCa9MSam3xEwTfxUGubLwJXoJtwA1w2CvYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iJOjZyeq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KOj5wzKw; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712066342; x=1743602342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/NvuaHc6W2tDBg0tURPBaCA1znz1350ZiURCu2lbOo4=;
  b=iJOjZyeqV2RyjERdCTIKdcgxtcz+AV26YEY8KYbNGQ019b4SeiBjzS8x
   Z85SjX9kahlOr/slID8XlPyrUbKKCE+RlGSR4sRe+brFDhfFasTCFn1Lj
   sfUkPPWOAaBXCo+d9TubxG36fttV69TxkE0GK9RqeNxbFLz24MdRbg19V
   80rk2FoP4AA9m1guHrwzNW1WyCd6QukwSJBj2mbk8dhaDiSSHzx1LsHgU
   xL9zF0rsR2rjjNOQmd/NawJcei8QHDD7kaXumr4rf0XmIafW0Jj0z/Rgu
   0F7wnEwhqWNsA/4bjdBwPZuYKu7AUXH+fuccImc3oldOBuPlJXAOV4wa5
   A==;
X-CSE-ConnectionGUID: i6J59NF1Q5G/7bOdaI5BPw==
X-CSE-MsgGUID: anvhoOtvQKeXay3K0pZvgw==
X-IronPort-AV: E=Sophos;i="6.07,175,1708358400"; 
   d="scan'208";a="13704940"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2024 21:57:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZOvc8/he89DIiWwDb/YCkLUuLo0ZbGEMVzFpwcTwKWaw7gM/sUTnUlbsguJTAf+iQa+ezweJEEGd1VOBBr7Okf1yCIoVKBM+nBCQe9LqRHnPqv6Jlu2Ev9/dfuMRI1JYB0VGKQBDhIs6cGor8Qge7dYWXvF+CkC5E5fxq7+D0bIcshgm4xbUBheVv0LSswps7dbEXswHY0g0twow2kmT3oJNTE8nWyDVUFRqHKwiRX/ekgy6NRP785FTXtkVlRBZEgS663IEui5mIk3XnUFVPmqaw+l4QLPJq5CnqcHsRT6JzGIOcmjn2jiW2cwepBdsiaPrhKEJjA5PDRGXwPwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NvuaHc6W2tDBg0tURPBaCA1znz1350ZiURCu2lbOo4=;
 b=mx6pnpErQgfzkY8oQOLCS9K2UTAn38UDW4htB6/t7K7GFe7o6ChwmmY+retQHEjxyMflrhLrGNgrJNbMGeuvjT1X7qMi8i3y3zt/k/3wo/cwUXPamURzRRs9Lwtld65bYG69tT8nbr7k+Tu2j9MPeHScpd68R9MJQOq2cO7kWLNdi2yU8m3LEkJ/i2XMqyUJX09ANFh9Oan0Qz6OcwvnKGH6eWxA7YXxKIs6fTqfGUlLFXKHPpdkJdct8E0M7nIzcs+xPWHTRW2s9vZyUw+VRS0zH314mGhBIwsWj2Cge4rl/pWBPvb6M6oF5PlI5jEM3tUaX5Q0GSXfqAD6zGcBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NvuaHc6W2tDBg0tURPBaCA1znz1350ZiURCu2lbOo4=;
 b=KOj5wzKwtnDPNJsWxoU/1CS8S5ZYWFbFybXPYt33rG5/faySiTwzMIBAaYiRlYcDLgWVXNSwkfF+RjaUuzTFMaMI0ntRCoFxNZ/spPPnY8DzxTskVeZWkRP++H2xw0ntPmJyR0u595LhC/me1eFJhxfVaRBvuIjOqsHEKsTxNyM=
Received: from BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 by PH0PR04MB7852.namprd04.prod.outlook.com (2603:10b6:510:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:50 +0000
Received: from BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9]) by BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:57:50 +0000
From: =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To: "ira.weiny@intel.com" <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Thread-Topic: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Thread-Index: AQHafpsDHkGvCDwhu0et4j9YvbUnjbFVDkiA
Date: Tue, 2 Apr 2024 13:57:50 +0000
Message-ID: <33489603-3da4-498a-ac0f-8021df2150e4@wdc.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB5431:EE_|PH0PR04MB7852:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Mc/2xTVKYOH+bqcm8ZVvovkbaUgTnr1w1wF9mlFbJvA1JEcL9NkHT9ICbi5tkeZl52DaSamp82dXzEvq8u8KQH0WxNBEU3Uk8ZFAdA1dOZz+DJYmHfgFmR9rJ+7oRHsFLWak0j9ChSv2hMU1fCkZi86LhbCDWJ+vb/vlnT6CgYZhcFq7HvpuxmBJgE0BzDtd1yJhZ6URvTdJfxVfPvUSlDnjMcjbUuz+kzCe7Kh6+wLZXQGUSnft7gBBaiu7xMLjkzquJXS4zTlVw3Lhc+36t/RZHM/RjkU0hv7rRWD3NF6xnAeZ8/Pm6EQEwMOTZEu6FUzaD/y5pd44A4J3ZuC5U4HQhP8aV5+Nsw0U7Tw0xenOSdDZsFZ2aWIvthjne3PuN9ATG86XahfAmbof9ULyNYsP0O0pBd8M+S70UPfYbCnGf1+QEbI2icFVr2Ck14KpFpBHAy4h7VpL8V+wb/YckLzopdKlP/RDXuGrvUoBVYjg86/75G2P0aD0PwwwmTVvDbJ1lvI8ojwJPiFWrYIFgPaQL5VDpkrqtHnFlqza3TvZFvoQmQNHes5Lc4m0LVnNylhllilhg2MSWJUoTM6RYI1UEV3eHxCnDoAt//ITjeoaJcYcIP8HPUJnrK7cAHeKDWAHkeCVAmp2j3PxKniVID9AihF76VCzNuOAj2OtyNg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5431.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1NUemN4ZWdZbjdqNHRYTEk0eUZ6QktzVEw0YVNWK1ZDdFR4VWdjLzFMOWZi?=
 =?utf-8?B?ZG9ZYmIwUzllTnY1SUMyUkhLVENGMm4wdysxRitoMXJsWVpCSU1LWkl2c1NK?=
 =?utf-8?B?TG0wRGdLK0JyNzRkVndScUgzblBGWHg1T1loQUp5bnhaQ0VoeXBLQ20rdDN5?=
 =?utf-8?B?R2dqQjI0Ukh6QkVpakNhbFZnU2t0ZHNZd1FvTlJYLytNakxjbjRKcEpsVkJo?=
 =?utf-8?B?RFFidGNYNW93UnJVOWNhZitSNDhnUnNEWEdlbjdOQ1IySGtoYmVlRldqdkIz?=
 =?utf-8?B?ZE0rWnMvWEJmbHZaZnZDaVRROGZYK3dMdi8xWitRbFJDL2hUWkJhK1JCdytN?=
 =?utf-8?B?YVVoN2N4dnNJSVFHMEhiUUxXTitObU4xaFZFQkNYTUQ2T3NxNldxVzdHWWcx?=
 =?utf-8?B?TW9xeCthWmhaS0Q2UnYyekFnN0tGV3J3N1ViUFRIT1pzbGdqMzRxVUNhTDlP?=
 =?utf-8?B?ejJOQ2ZUQXlmNTlpWGtpS1JudEpTcnNMN2hDNERPWmV5Z0EyVGhXbHlsRFpo?=
 =?utf-8?B?bUZuUE5YTjBwN3kxMWtjUkswQXlxM0V4S3hQS2RraFMxeEo2SGJUaTlzZlJj?=
 =?utf-8?B?aUc2YkUrdnR4WXhMdlRhNVZ5enNkYlV3bmJvMFVxMG1oTUV3NGJxZkIvK0NW?=
 =?utf-8?B?bHBmeEpXZGRZa0NHS1Q5RUJXWWRLL01aN1I3cUo5M25MMEo3bEgwKy85ZDg1?=
 =?utf-8?B?aVBZNGx2MlM1TkhSYmd6dWdpdzUwektDTmtVeU8zUncxNUxJRTlIRnlSaE1S?=
 =?utf-8?B?UjljdkgvVC9sWE5rNG5MMEdDVFAweUQzRkNqRmQ2WlN2eEw5OFQyZjNPMGNo?=
 =?utf-8?B?OWdVK1A0a0d3YlRaQW4yUTlNNVpHeGhvRzc0eHBlU0FSZkVGRnZnTlNIalpl?=
 =?utf-8?B?QzNCZ25HWERWVlJXZlRxeGFldzdLSWdEdEw1N0RGSnV1Qmw0U2RTZEdqWVVW?=
 =?utf-8?B?eUhRMFQ2dVQ4cFlmRDJZUmR1aGVhNHI3djJiaW9YNmtPdjlHUU9GRGt5YVNB?=
 =?utf-8?B?dHE4VktaUzVrUUJ5Nm9jQWh0R25sdWVrcjBHVXRwWnNaSzZzeFZQNFNocGdi?=
 =?utf-8?B?ZXo2a1gyVm1qemVKSlV4bG1rWGRjNUVOVHJXdlRhZVc4VCtBZm9LaGg2UFZv?=
 =?utf-8?B?UkoxckYvTzlBMlY5anhUNjlzSjF4YVd5dDU0NDJBdWpMd0NhTW5ndTFEU0dI?=
 =?utf-8?B?SzZsRmRMeDBvSmhQdFFEVEwwT0hkL3hRUzl6SnJwWWl1dFkxalpFK2s2U0pF?=
 =?utf-8?B?SW9Cd2dKWVh0WkNLZXlTVkIyeGpNM0h1ZWVucHo3U0w1RjBLKzYvbC9IanZZ?=
 =?utf-8?B?VkVvZjVBdUZqa25LdmJQMXdzQ0t6L0hwOVdhU2pjNlRza2xpMzcvcEJCbUJx?=
 =?utf-8?B?OW8vRUJmcVUrOTkvd1RSZWFHSHJwdmRXemI0c2d0SncvY3psQWNqY3lkT08z?=
 =?utf-8?B?cFNFVmdkM2NmRlNsY3JKbnZ0R0JJN2syVW9lTzZlU1NYYkdNU0dub0s2WTUz?=
 =?utf-8?B?cURmQUdDcGtMd090N1JjTFp4VGNEUllXRUNISWJpN3NxM2hJOXIvRFpZNUdN?=
 =?utf-8?B?MTBuZFd6N293YlR3Wld2bEh3MVcvS25WWWhGY2VxNkxkU2RJekRXb1Boc0tp?=
 =?utf-8?B?TC9rWFV5ZjNwSFFZd2ZOT09QU2lyZ3pGb3Nib2dGQ0p6bCs5ZXljZGhsRzVN?=
 =?utf-8?B?VDdsNkFYbEJPZFp0VW5xdENYeDBtMTJzamJvbjI4T1hNWEVhNmU3SUJGMzZU?=
 =?utf-8?B?VTUvdytOMEZBTVZBbnBUWXNEQ1VxWkVBUEpxT0x5TWlMUWVDajFwRmFzTHI1?=
 =?utf-8?B?WFIyOFBQbzl0czZaZmtRUis2VXhFelp5Ulo0eEpyVGErcmwycG1YTEtwTE4z?=
 =?utf-8?B?TGhrVmhiQmNXWGNSeHhuNzJJMXBycTMraFVSYTNWLzhnWjhMMHFsUkFMaDJv?=
 =?utf-8?B?Um5NUkEzU2o4RTJBcnlJWFpmVlhOSEM4azZJUzBXbkM5bThLVFphMW5vNU1W?=
 =?utf-8?B?aGQvWFM2enVPSWVFWFZ0cWh3Yk1KeGF0NmJsUTBjQytyc2lya2haL3RrYkpq?=
 =?utf-8?B?SE5kRjBQcUt6bGlPdFA3N20zcTAvV0R2U1ArUFhiMUQyRUtPakFYUkNrNC9H?=
 =?utf-8?B?bk9yYU1nY0FNYjd0bzB0RG9wZi9NWFNWRVZnZjBYcEVGV1JEdHpmSjNuRisx?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BD54804DBAF0644B44E0FD0EA733397@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7EHu07qa/yQAZS1egU2/VZwYh4DZ43dUOQwt9SCxDEXIoufC5FS03/nlRoWvct85+AfmDC3XUY+B047hDb1Uj6FEENCRni27RhBv2kwXUaHPFPJkav2LgwMp1q4xQnCzZMN+S+s6sRDHVIJni0JqYrYf4/3MAahC+fWAtyODL8MV/TvGhL3WKFysffuLnr1aqrQIK3zm4E1rclEUJminlPAiDCY4zK5+Hl9heWuADrMZuH15CPUJkGN+xHNYSPpAU+Thd/IiOTvWDDSEkPwTsX+OzjD24K4f/75ERF5fL7Bk/Bt7GMsvCYPbbepwp8+AyTFfH0HNN4DthrVyApQaGwO93V4F3FECccfi1q01+jtBd+OopUHcBGulHMNhsHyHXLFfo6AR3G5RrKo0XKNVVBmXpnpBBQdD3kI3k/EGSP/+w7Lo+MfDRllcpAlNucuPcw7vxW5KYK+VvOo8myNpFymsUqYDTEov5nj99y8hjfK/j8nXuWH6i6p8Z206Bo6mvIyfD0b3xtF+jIKKKaBASYuw3+ZuTj+EIFRveGKWSg4sfJz/p7qCK3zPDmONZis8xi0zTqa5BsS8pLswR45w0gnR2R+NJqH6g5v5ODFGz/EYBZQBK8RfOXqy7L1bDJ7m
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5431.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487d2248-c6e1-45ef-666b-08dc531ce255
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 13:57:50.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YsVOQE2FiYmBqgwiWAKz2XYBmlUARpZv7xlL4zHfykQ2n/zejkvK+wWk+456nKxbFpW8dvhLkmZq/4uQJVnE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7852

T24gMy8yNS8yNCAwMDoxOCwgaXJhLndlaW55QGludGVsLmNvbSB3cm90ZToNCj4gRnJvbTogTmF2
bmVldCBTaW5naCA8bmF2bmVldC5zaW5naEBpbnRlbC5jb20+DQo+IA0KPiBEeW5hbWljIGNhcGFj
aXR5IGRldmljZSBleHRlbnRzIG1heSBiZSBsZWZ0IGluIGFuIGFjY2VwdGVkIHN0YXRlIG9uIGEN
Cj4gZGV2aWNlIGR1ZSB0byBhbiB1bmV4cGVjdGVkIGhvc3QgY3Jhc2guICBJbiB0aGlzIGNhc2Ug
Y3JlYXRpb24gb2YgYSBuZXcNCj4gcmVnaW9uIG9uIHRvcCBvZiB0aGUgREMgcGFydGl0aW9uIChy
ZWdpb24pIGlzIGV4cGVjdGVkIHRvIGV4cG9zZSB0aG9zZQ0KPiBleHRlbnRzIGZvciBjb250aW51
ZWQgdXNlLg0KPiANCj4gT25jZSBhbGwgZW5kcG9pbnQgZGVjb2RlcnMgYXJlIHBhcnQgb2YgYSBy
ZWdpb24gYW5kIHRoZSByZWdpb24gaXMgYmVpbmcNCj4gcmVhbGl6ZWQgcmVhZCB0aGUgZGV2aWNl
IGV4dGVudCBsaXN0LiAgRm9yIGVhc2Ugb2YgcmV2aWV3LCB0aGlzIHBhdGNoDQo+IHN0b3BzIGFm
dGVyIHJlYWRpbmcgdGhlIGV4dGVudCBsaXN0IGFuZCBsZWF2ZXMgcmVhbGl6YXRpb24gb2YgdGhl
IHJlZ2lvbg0KPiBleHRlbnRzIHRvIGEgZnV0dXJlIHBhdGNoLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTmF2bmVldCBTaW5naCA8bmF2bmVldC5zaW5naEBpbnRlbC5jb20+DQo+IENvLWRldmVsb3Bl
ZC1ieTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBJ
cmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+IA0KPiAtLS0NCj4gQ2hhbmdlcyBmb3Ig
djE6DQo+IFtpd2Vpbnk6IHJlbW92ZSBleHRlbnQgbGlzdCB4YXJyYXldDQo+IFtpd2Vpbnk6IFVw
ZGF0ZSBzcGVjIHJlZmVyZW5jZXMgdG8gMy4xXQ0KPiBbaXdlaW55OiB1c2Ugc3RydWN0IHJhbmdl
IGluIGV4dGVudHNdDQo+IFtpd2Vpbnk6IHJlbW92ZSBhbGwgcmVmZXJlbmNlIHRyYWNraW5nIGFu
ZCBsZXQgcmVnaW9ucyB0cmFjayBleHRlbnRzDQo+ICAgICAgICAgICB0aHJvdWdoIHRoZSBleHRl
bnQgZGV2aWNlcy5dDQo+IFtkamJ3L0pvbmF0aGFuL0ZhbjogbW92ZSBleHRlbnQgdHJhY2tpbmcg
dG8gZW5kcG9pbnQgZGVjb2RlcnNdDQo+IC0tLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvY29yZS5o
ICAgfCAgIDkgKysrDQo+ICAgZHJpdmVycy9jeGwvY29yZS9tYm94LmMgICB8IDE5MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9jeGwv
Y29yZS9yZWdpb24uYyB8ICAyOSArKysrKysrDQo+ICAgZHJpdmVycy9jeGwvY3hsbWVtLmggICAg
ICB8ICA0OSArKysrKysrKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDI3OSBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9jb3JlLmggYi9kcml2ZXJz
L2N4bC9jb3JlL2NvcmUuaA0KPiBpbmRleCA5MWFiZWZmYmU5ODUuLjExOWIxMjM2Mjk3NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy9jeGwv
Y29yZS9jb3JlLmgNCj4gQEAgLTQsNiArNCw4IEBADQo+ICAgI2lmbmRlZiBfX0NYTF9DT1JFX0hf
Xw0KPiAgICNkZWZpbmUgX19DWExfQ09SRV9IX18NCj4gDQo+ICsjaW5jbHVkZSA8Y3hsbWVtLmg+
DQo+ICsNCj4gICBleHRlcm4gY29uc3Qgc3RydWN0IGRldmljZV90eXBlIGN4bF9udmRpbW1fYnJp
ZGdlX3R5cGU7DQo+ICAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBkZXZpY2VfdHlwZSBjeGxfbnZkaW1t
X3R5cGU7DQo+ICAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBkZXZpY2VfdHlwZSBjeGxfcG11X3R5cGU7
DQo+IEBAIC0yOCw2ICszMCw4IEBAIHZvaWQgY3hsX2RlY29kZXJfa2lsbF9yZWdpb24oc3RydWN0
IGN4bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCk7DQo+ICAgaW50IGN4bF9yZWdpb25faW5pdCh2
b2lkKTsNCj4gICB2b2lkIGN4bF9yZWdpb25fZXhpdCh2b2lkKTsNCj4gICBpbnQgY3hsX2dldF9w
b2lzb25fYnlfZW5kcG9pbnQoc3RydWN0IGN4bF9wb3J0ICpwb3J0KTsNCj4gK2ludCBjeGxfZWRf
YWRkX29uZV9leHRlbnQoc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY3hsX2RjX2V4dGVudCAqZGNfZXh0ZW50KTsN
Cj4gICAjZWxzZQ0KPiAgIHN0YXRpYyBpbmxpbmUgaW50IGN4bF9nZXRfcG9pc29uX2J5X2VuZHBv
aW50KHN0cnVjdCBjeGxfcG9ydCAqcG9ydCkNCj4gICB7DQo+IEBAIC00Myw2ICs0NywxMSBAQCBz
dGF0aWMgaW5saW5lIGludCBjeGxfcmVnaW9uX2luaXQodm9pZCkNCj4gICBzdGF0aWMgaW5saW5l
IHZvaWQgY3hsX3JlZ2lvbl9leGl0KHZvaWQpDQo+ICAgew0KPiAgIH0NCj4gK3N0YXRpYyBpbmxp
bmUgaW50IGN4bF9lZF9hZGRfb25lX2V4dGVudChzdHJ1Y3QgY3hsX2VuZHBvaW50X2RlY29kZXIg
KmN4bGVkLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGN4bF9kY19leHRlbnQgKmRjX2V4dGVudCkNCj4gK3sNCj4gKyAgICAgICByZXR1cm4gMDsNCj4g
K30NCj4gICAjZGVmaW5lIENYTF9SRUdJT05fQVRUUih4KSBOVUxMDQo+ICAgI2RlZmluZSBDWExf
UkVHSU9OX1RZUEUoeCkgTlVMTA0KPiAgICNkZWZpbmUgU0VUX0NYTF9SRUdJT05fQVRUUih4KQ0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9tYm94LmMgYi9kcml2ZXJzL2N4bC9jb3Jl
L21ib3guYw0KPiBpbmRleCA1OGIzMWZhNDdiOTMuLjllMzNhMDk3NjgyOCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9jeGwvY29yZS9tYm94LmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9tYm94
LmMNCj4gQEAgLTg3MCw2ICs4NzAsNTMgQEAgaW50IGN4bF9lbnVtZXJhdGVfY21kcyhzdHJ1Y3Qg
Y3hsX21lbWRldl9zdGF0ZSAqbWRzKQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX05TX0dQTChj
eGxfZW51bWVyYXRlX2NtZHMsIENYTCk7DQo+IA0KPiArc3RhdGljIGludCBjeGxfdmFsaWRhdGVf
ZXh0ZW50KHN0cnVjdCBjeGxfbWVtZGV2X3N0YXRlICptZHMsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgY3hsX2RjX2V4dGVudCAqZGNfZXh0ZW50KQ0KPiArew0KPiAr
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IG1kcy0+Y3hsZHMuZGV2Ow0KPiArICAgICAgIHVp
bnQ2NF90IHN0YXJ0LCBsZW47DQo+ICsNCj4gKyAgICAgICBzdGFydCA9IGxlNjRfdG9fY3B1KGRj
X2V4dGVudC0+c3RhcnRfZHBhKTsNCj4gKyAgICAgICBsZW4gPSBsZTY0X3RvX2NwdShkY19leHRl
bnQtPmxlbmd0aCk7DQo+ICsNCj4gKyAgICAgICAvKiBFeHRlbnRzIG11c3Qgbm90IGNyb3NzIHJl
Z2lvbiBib3VuZGFyeSdzICovDQo+ICsgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBtZHMtPm5y
X2RjX3JlZ2lvbjsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgY3hsX2RjX3JlZ2lv
bl9pbmZvICpkY3IgPSAmbWRzLT5kY19yZWdpb25baV07DQo+ICsNCj4gKyAgICAgICAgICAgICAg
IGlmIChkY3ItPmJhc2UgPD0gc3RhcnQgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAoc3RhcnQg
KyBsZW4pIDw9IChkY3ItPmJhc2UgKyBkY3ItPmRlY29kZV9sZW4pKSB7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAiREMgZXh0ZW50IERQQSAlI2xseCAtICUjbGx4IChE
Q1I6JWQ6JSNsbHgpXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0
LCBzdGFydCArIGxlbiAtIDEsIGksIHN0YXJ0IC0gZGNyLT5iYXNlKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0K
PiArDQo+ICsgICAgICAgZGV2X2Vycl9yYXRlbGltaXRlZChkZXYsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiREMgZXh0ZW50IERQQSAlI2xseCAtICUjbGx4IGlzIG5vdCBpbiBhbnkg
REMgcmVnaW9uXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhcnQsIHN0YXJ0
ICsgbGVuIC0gMSk7DQo+ICsgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBib29sIGN4bF9kY19leHRlbnRfaW5fZWQoc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVy
ICpjeGxlZCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY3hsX2Rj
X2V4dGVudCAqZXh0ZW50KQ0KPiArew0KPiArICAgICAgIHVpbnQ2NF90IHN0YXJ0ID0gbGU2NF90
b19jcHUoZXh0ZW50LT5zdGFydF9kcGEpOw0KPiArICAgICAgIHVpbnQ2NF90IGxlbmd0aCA9IGxl
NjRfdG9fY3B1KGV4dGVudC0+bGVuZ3RoKTsNCj4gKyAgICAgICBzdHJ1Y3QgcmFuZ2UgZXh0X3Jh
bmdlID0gKHN0cnVjdCByYW5nZSl7DQo+ICsgICAgICAgICAgICAgICAuc3RhcnQgPSBzdGFydCwN
Cj4gKyAgICAgICAgICAgICAgIC5lbmQgPSBzdGFydCArIGxlbmd0aCAtIDEsDQo+ICsgICAgICAg
fTsNCj4gKyAgICAgICBzdHJ1Y3QgcmFuZ2UgZWRfcmFuZ2UgPSAoc3RydWN0IHJhbmdlKSB7DQo+
ICsgICAgICAgICAgICAgICAuc3RhcnQgPSBjeGxlZC0+ZHBhX3Jlcy0+c3RhcnQsDQo+ICsgICAg
ICAgICAgICAgICAuZW5kID0gY3hsZWQtPmRwYV9yZXMtPmVuZCwNCj4gKyAgICAgICB9Ow0KPiAr
DQo+ICsgICAgICAgZGV2X2RiZygmY3hsZWQtPmN4bGQuZGV2LCAiQ2hlY2tpbmcgRUQgKCVwcikg
Zm9yIGV4dGVudCBEUEE6JSNsbHggTEVOOiUjbGx4XG4iLA0KPiArICAgICAgICAgICAgICAgY3hs
ZWQtPmRwYV9yZXMsIHN0YXJ0LCBsZW5ndGgpOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJhbmdl
X2NvbnRhaW5zKCZlZF9yYW5nZSwgJmV4dF9yYW5nZSk7DQo+ICt9DQo+ICsNCj4gICB2b2lkIGN4
bF9ldmVudF90cmFjZV9yZWNvcmQoY29uc3Qgc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gY3hsX2V2ZW50X2xvZ190eXBlIHR5cGUs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBjeGxfZXZlbnRfdHlwZSBldmVu
dF90eXBlLA0KPiBAQCAtOTczLDYgKzEwMjAsMTUgQEAgc3RhdGljIGludCBjeGxfY2xlYXJfZXZl
bnRfcmVjb3JkKHN0cnVjdCBjeGxfbWVtZGV2X3N0YXRlICptZHMsDQo+ICAgICAgICAgIHJldHVy
biByYzsNCj4gICB9DQo+IA0KPiArc3RhdGljIHN0cnVjdCBjeGxfbWVtZGV2X3N0YXRlICoNCj4g
K2N4bGVkX3RvX21kcyhzdHJ1Y3QgY3hsX2VuZHBvaW50X2RlY29kZXIgKmN4bGVkKQ0KPiArew0K
PiArICAgICAgIHN0cnVjdCBjeGxfbWVtZGV2ICpjeGxtZCA9IGN4bGVkX3RvX21lbWRldihjeGxl
ZCk7DQo+ICsgICAgICAgc3RydWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRzID0gY3hsbWQtPmN4bGRz
Ow0KPiArDQo+ICsgICAgICAgcmV0dXJuIGNvbnRhaW5lcl9vZihjeGxkcywgc3RydWN0IGN4bF9t
ZW1kZXZfc3RhdGUsIGN4bGRzKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyB2b2lkIGN4bF9tZW1f
Z2V0X3JlY29yZHNfbG9nKHN0cnVjdCBjeGxfbWVtZGV2X3N0YXRlICptZHMsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGN4bF9ldmVudF9sb2dfdHlwZSB0eXBl
KQ0KPiAgIHsNCj4gQEAgLTE0MDYsNiArMTQ2MiwxNDIgQEAgaW50IGN4bF9kZXZfZHluYW1pY19j
YXBhY2l0eV9pZGVudGlmeShzdHJ1Y3QgY3hsX21lbWRldl9zdGF0ZSAqbWRzKQ0KPiAgIH0NCj4g
ICBFWFBPUlRfU1lNQk9MX05TX0dQTChjeGxfZGV2X2R5bmFtaWNfY2FwYWNpdHlfaWRlbnRpZnks
IENYTCk7DQo+IA0KPiArc3RhdGljIGludCBjeGxfZGV2X2dldF9kY19leHRlbnRfY250KHN0cnVj
dCBjeGxfbWVtZGV2X3N0YXRlICptZHMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgKmV4dGVudF9nZW5fbnVtKQ0KPiArew0KPiArICAgICAgIHN0
cnVjdCBjeGxfbWJveF9nZXRfZGNfZXh0ZW50X2luIGdldF9kY19leHRlbnQ7DQo+ICsgICAgICAg
c3RydWN0IGN4bF9tYm94X2dldF9kY19leHRlbnRfb3V0IGRjX2V4dGVudHM7DQo+ICsgICAgICAg
c3RydWN0IGN4bF9tYm94X2NtZCBtYm94X2NtZDsNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgY291
bnQ7DQo+ICsgICAgICAgaW50IHJjOw0KPiArDQo+ICsgICAgICAgZ2V0X2RjX2V4dGVudCA9IChz
dHJ1Y3QgY3hsX21ib3hfZ2V0X2RjX2V4dGVudF9pbikgew0KPiArICAgICAgICAgICAgICAgLmV4
dGVudF9jbnQgPSBjcHVfdG9fbGUzMigwKSwNCj4gKyAgICAgICAgICAgICAgIC5zdGFydF9leHRl
bnRfaW5kZXggPSBjcHVfdG9fbGUzMigwKSwNCj4gKyAgICAgICB9Ow0KPiArDQo+ICsgICAgICAg
bWJveF9jbWQgPSAoc3RydWN0IGN4bF9tYm94X2NtZCkgew0KPiArICAgICAgICAgICAgICAgLm9w
Y29kZSA9IENYTF9NQk9YX09QX0dFVF9EQ19FWFRFTlRfTElTVCwNCj4gKyAgICAgICAgICAgICAg
IC5wYXlsb2FkX2luID0gJmdldF9kY19leHRlbnQsDQo+ICsgICAgICAgICAgICAgICAuc2l6ZV9p
biA9IHNpemVvZihnZXRfZGNfZXh0ZW50KSwNCj4gKyAgICAgICAgICAgICAgIC5zaXplX291dCA9
IHNpemVvZihkY19leHRlbnRzKSwNCj4gKyAgICAgICAgICAgICAgIC5wYXlsb2FkX291dCA9ICZk
Y19leHRlbnRzLA0KPiArICAgICAgICAgICAgICAgLm1pbl9vdXQgPSAxLA0KPiArICAgICAgIH07
DQo+ICsNCj4gKyAgICAgICByYyA9IGN4bF9pbnRlcm5hbF9zZW5kX2NtZChtZHMsICZtYm94X2Nt
ZCk7DQo+ICsgICAgICAgaWYgKHJjIDwgMCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByYzsN
Cj4gKw0KPiArICAgICAgIGNvdW50ID0gbGUzMl90b19jcHUoZGNfZXh0ZW50cy50b3RhbF9leHRl
bnRfY250KTsNCj4gKyAgICAgICAqZXh0ZW50X2dlbl9udW0gPSBsZTMyX3RvX2NwdShkY19leHRl
bnRzLmV4dGVudF9saXN0X251bSk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gY291bnQ7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBpbnQgY3hsX2Rldl9nZXRfZGNfZXh0ZW50cyhzdHJ1Y3QgY3hsX2Vu
ZHBvaW50X2RlY29kZXIgKmN4bGVkLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgaW50IHN0YXJ0X2dlbl9udW0sDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBpbnQgZXhwX2NudCkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3Qg
Y3hsX21lbWRldl9zdGF0ZSAqbWRzID0gY3hsZWRfdG9fbWRzKGN4bGVkKTsNCj4gKyAgICAgICB1
bnNpZ25lZCBpbnQgc3RhcnRfaW5kZXgsIHRvdGFsX3JlYWQ7DQo+ICsgICAgICAgc3RydWN0IGRl
dmljZSAqZGV2ID0gbWRzLT5jeGxkcy5kZXY7DQo+ICsgICAgICAgc3RydWN0IGN4bF9tYm94X2Nt
ZCBtYm94X2NtZDsNCj4gKw0KPiArICAgICAgIHN0cnVjdCBjeGxfbWJveF9nZXRfZGNfZXh0ZW50
X291dCAqZGNfZXh0ZW50cyBfX2ZyZWUoa2ZyZWUpID0NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBrdm1hbGxvYyhtZHMtPnBheWxvYWRfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICsg
ICAgICAgaWYgKCFkY19leHRlbnRzKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07
DQo+ICsNCj4gKyAgICAgICB0b3RhbF9yZWFkID0gMDsNCj4gKyAgICAgICBzdGFydF9pbmRleCA9
IDA7DQo+ICsgICAgICAgZG8gew0KPiArICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG5yX2V4
dCwgdG90YWxfZXh0ZW50X2NudCwgZ2VuX251bTsNCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBj
eGxfbWJveF9nZXRfZGNfZXh0ZW50X2luIGdldF9kY19leHRlbnQ7DQo+ICsgICAgICAgICAgICAg
ICBpbnQgcmM7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGdldF9kY19leHRlbnQgPSAoc3RydWN0
IGN4bF9tYm94X2dldF9kY19leHRlbnRfaW4pIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
LmV4dGVudF9jbnQgPSBjcHVfdG9fbGUzMihleHBfY250IC0gc3RhcnRfaW5kZXgpLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAuc3RhcnRfZXh0ZW50X2luZGV4ID0gY3B1X3RvX2xlMzIoc3Rh
cnRfaW5kZXgpLA0KPiArICAgICAgICAgICAgICAgfTsNCj4gKw0KPiArICAgICAgICAgICAgICAg
bWJveF9jbWQgPSAoc3RydWN0IGN4bF9tYm94X2NtZCkgew0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAub3Bjb2RlID0gQ1hMX01CT1hfT1BfR0VUX0RDX0VYVEVOVF9MSVNULA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAucGF5bG9hZF9pbiA9ICZnZXRfZGNfZXh0ZW50LA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAuc2l6ZV9pbiA9IHNpemVvZihnZXRfZGNfZXh0ZW50KSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgLnNpemVfb3V0ID0gbWRzLT5wYXlsb2FkX3NpemUsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIC5wYXlsb2FkX291dCA9IGRjX2V4dGVudHMsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIC5taW5fb3V0ID0gMSwNCj4gKyAgICAgICAgICAgICAgIH07DQo+
ICsNCj4gKyAgICAgICAgICAgICAgIHJjID0gY3hsX2ludGVybmFsX3NlbmRfY21kKG1kcywgJm1i
b3hfY21kKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyYyA8IDApDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiByYzsNCj4gKw0KPiArICAgICAgICAgICAgICAgbnJfZXh0ID0gbGUz
Ml90b19jcHUoZGNfZXh0ZW50cy0+cmV0X2V4dGVudF9jbnQpOw0KPiArICAgICAgICAgICAgICAg
dG90YWxfcmVhZCArPSBucl9leHQ7DQo+ICsgICAgICAgICAgICAgICB0b3RhbF9leHRlbnRfY250
ID0gbGUzMl90b19jcHUoZGNfZXh0ZW50cy0+dG90YWxfZXh0ZW50X2NudCk7DQo+ICsgICAgICAg
ICAgICAgICBnZW5fbnVtID0gbGUzMl90b19jcHUoZGNfZXh0ZW50cy0+ZXh0ZW50X2xpc3RfbnVt
KTsNCj4gKw0KPiArICAgICAgICAgICAgICAgZGV2X2RiZyhkZXYsICJHZXQgZXh0ZW50IGxpc3Qg
Y291bnQ6JWQgZ2VuZXJhdGlvbiBOdW06JWRcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHRvdGFsX2V4dGVudF9jbnQsIGdlbl9udW0pOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAo
Z2VuX251bSAhPSBzdGFydF9nZW5fbnVtIHx8IGV4cF9jbnQgIT0gdG90YWxfZXh0ZW50X2NudCkg
ew0KPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIlBvc3NpYmxlIGluY29t
cGxldGUgZXh0ZW50IGxpc3Q7IGdlbiAldSAhPSAldSA6IGNudCAldSAhPSAldVxuIiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZW5fbnVtLCBzdGFydF9nZW5fbnVtLCBleHBf
Y250LCB0b3RhbF9leHRlbnRfY250KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FSU87DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGZvciAo
aW50IGkgPSAwOyBpIDwgbnJfZXh0IDsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGRldl9kYmcoZGV2LCAiUHJvY2Vzc2luZyBleHRlbnQgJWQvJWRcbiIsDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RhcnRfaW5kZXggKyBpLCBleHBfY250KTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmMgPSBjeGxfdmFsaWRhdGVfZXh0ZW50KG1kcywgJmRjX2V4dGVu
dHMtPmV4dGVudFtpXSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChyYykNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFjeGxfZGNfZXh0ZW50X2luX2VkKGN4bGVkLCAmZGNfZXh0ZW50cy0+ZXh0
ZW50W2ldKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmMgPSBjeGxfZWRfYWRkX29uZV9leHRlbnQoY3hsZWQs
ICZkY19leHRlbnRzLT5leHRlbnRbaV0pOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAo
cmMpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0KPiArICAg
ICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICAgICBzdGFydF9pbmRleCArPSBucl9l
eHQ7DQo+ICsgICAgICAgfSB3aGlsZSAoZXhwX2NudCA+IHRvdGFsX3JlYWQpOw0KPiArDQo+ICsg
ICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gKy8qKg0KPiArICogY3hsX3JlYWRfZGNfZXh0
ZW50cygpIC0gUmVhZCBhbnkgZXhpc3RpbmcgZXh0ZW50cw0KPiArICogQGN4bGVkOiBFbmRwb2lu
dCBkZWNvZGVyIHdoaWNoIGlzIHBhcnQgb2YgYSByZWdpb24NCj4gKyAqDQo+ICsgKiBJc3N1ZSB0
aGUgR2V0IER5bmFtaWMgQ2FwYWNpdHkgRXh0ZW50IExpc3QgY29tbWFuZCB0byB0aGUgZGV2aWNl
DQo+ICsgKiBhbmQgYWRkIGFueSBleGlzdGluZyBleHRlbnRzIGZvdW5kIHdoaWNoIGJlbG9uZyB0
byB0aGlzIGRlY29kZXIuDQo+ICsgKg0KPiArICogUmV0dXJuOiAwIGlmIGNvbW1hbmQgd2FzIGV4
ZWN1dGVkIHN1Y2Nlc3NmdWxseSwgLUVSUk5PIG9uIGVycm9yLg0KPiArICovDQo+ICtpbnQgY3hs
X3JlYWRfZGNfZXh0ZW50cyhzdHJ1Y3QgY3hsX2VuZHBvaW50X2RlY29kZXIgKmN4bGVkKQ0KPiAr
ew0KPiArICAgICAgIHN0cnVjdCBjeGxfbWVtZGV2X3N0YXRlICptZHMgPSBjeGxlZF90b19tZHMo
Y3hsZWQpOw0KPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IG1kcy0+Y3hsZHMuZGV2Ow0K
PiArICAgICAgIHVuc2lnbmVkIGludCBleHRlbnRfZ2VuX251bTsNCj4gKyAgICAgICBpbnQgcmM7
DQo+ICsNCj4gKyAgICAgICBpZiAoIWN4bF9kY2Rfc3VwcG9ydGVkKG1kcykpIHsNCj4gKyAgICAg
ICAgICAgICAgIGRldl9kYmcoZGV2LCAiRENEIHVuc3VwcG9ydGVkXG4iKTsNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJjID0gY3hsX2Rl
dl9nZXRfZGNfZXh0ZW50X2NudChtZHMsICZleHRlbnRfZ2VuX251bSk7DQo+ICsgICAgICAgZGV2
X2RiZyhtZHMtPmN4bGRzLmRldiwgIkV4dGVudCBjb3VudDogJWQgR2VuZXJhdGlvbiBOdW06ICVk
XG4iLA0KPiArICAgICAgICAgICAgICAgcmMsIGV4dGVudF9nZW5fbnVtKTsNCj4gKyAgICAgICBp
ZiAocmMgPD0gMCkgLyogMCA9PSBubyByZWNvcmRzIGZvdW5kICovDQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gcmM7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gY3hsX2Rldl9nZXRfZGNfZXh0ZW50
cyhjeGxlZCwgZXh0ZW50X2dlbl9udW0sIHJjKTsNCg0KSXMgaXQgbmVjZXNzYXJ5IHRvIHNwZW5k
IGEgZGV2aWNlIGludGVyYWN0aW9uIHRvIGdldCB0aGUgZ2VuZXJhdGlvbiANCm51bWJlcj8gQ291
bGRuJ3QgY3hsX2Rldl9nZXRfZGNfZXh0ZW50cyBvYnRhaW4gdGhhdCBhcyBwYXJ0IG9mIHRoZSBm
aXJzdCANCmNhbGwgdG8gdGhlIGRldmljZSwgYW5kIHRoZW4gdXNlIGl0IHRvIGVuc3VyZSB0aGUg
Y29uc2lzdGVuY3kgb2YgYW55IA0KcmVtYWluaW5nIGNhbGxzLCBpZiBhbnkgYXJlIG5lY2Vzc2Fy
eT8NCg0KVGhhbmtzLA0KSsO4cmdlbg0KDQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX05TX0dQTChj
eGxfcmVhZF9kY19leHRlbnRzLCBDWEwpOw0KPiArDQo+ICAgc3RhdGljIGludCBhZGRfZHBhX3Jl
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCByZXNvdXJjZSAqcGFyZW50LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlcywgcmVzb3VyY2Vfc2l6ZV90IHN0
YXJ0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXNvdXJjZV9zaXplX3Qgc2l6ZSwgY29u
c3QgY2hhciAqdHlwZSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMg
Yi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+IGluZGV4IDBkN2IwOWE0OWRjZi4uM2U1NjNh
YjI5YWZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ICsrKyBi
L2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gQEAgLTE0NTAsNiArMTQ1MCwxMyBAQCBzdGF0
aWMgaW50IGN4bF9yZWdpb25fdmFsaWRhdGVfcG9zaXRpb24oc3RydWN0IGN4bF9yZWdpb24gKmN4
bHIsDQo+ICAgICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4gDQo+ICsvKiBDYWxsZXJzIGFyZSBl
eHBlY3RlZCB0byBlbnN1cmUgY3hsZWQgaGFzIGJlZW4gYXR0YWNoZWQgdG8gYSByZWdpb24gKi8N
Cj4gK2ludCBjeGxfZWRfYWRkX29uZV9leHRlbnQoc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVy
ICpjeGxlZCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY3hsX2RjX2V4dGVu
dCAqZGNfZXh0ZW50KQ0KPiArew0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAg
c3RhdGljIGludCBjeGxfcmVnaW9uX2F0dGFjaF9wb3NpdGlvbihzdHJ1Y3QgY3hsX3JlZ2lvbiAq
Y3hsciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGN4
bF9yb290X2RlY29kZXIgKmN4bHJkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgY3hsX2VuZHBvaW50X2RlY29kZXIgKmN4bGVkLA0KPiBAQCAtMjc3Myw2
ICsyNzgwLDIyIEBAIHN0YXRpYyBpbnQgZGV2bV9jeGxfYWRkX3BtZW1fcmVnaW9uKHN0cnVjdCBj
eGxfcmVnaW9uICpjeGxyKQ0KPiAgICAgICAgICByZXR1cm4gcmM7DQo+ICAgfQ0KPiANCj4gK3N0
YXRpYyBpbnQgY3hsX3JlZ2lvbl9yZWFkX2V4dGVudHMoc3RydWN0IGN4bF9yZWdpb24gKmN4bHIp
DQo+ICt7DQo+ICsgICAgICAgc3RydWN0IGN4bF9yZWdpb25fcGFyYW1zICpwID0gJmN4bHItPnBh
cmFtczsNCj4gKyAgICAgICBpbnQgaTsNCj4gKw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBw
LT5ucl90YXJnZXRzOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGludCByYzsNCj4gKw0KPiAr
ICAgICAgICAgICAgICAgcmMgPSBjeGxfcmVhZF9kY19leHRlbnRzKHAtPnRhcmdldHNbaV0pOw0K
PiArICAgICAgICAgICAgICAgaWYgKHJjKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gcmM7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cj4gICBzdGF0aWMgdm9pZCBjeGxyX2RheF91bnJlZ2lzdGVyKHZvaWQgKl9jeGxyX2RheCkNCj4g
ICB7DQo+ICAgICAgICAgIHN0cnVjdCBjeGxfZGF4X3JlZ2lvbiAqY3hscl9kYXggPSBfY3hscl9k
YXg7DQo+IEBAIC0yODA3LDYgKzI4MzAsMTIgQEAgc3RhdGljIGludCBkZXZtX2N4bF9hZGRfZGF4
X3JlZ2lvbihzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hscikNCj4gICAgICAgICAgZGV2X2RiZygmY3hs
ci0+ZGV2LCAiJXM6IHJlZ2lzdGVyICVzXG4iLCBkZXZfbmFtZShkZXYtPnBhcmVudCksDQo+ICAg
ICAgICAgICAgICAgICAgZGV2X25hbWUoZGV2KSk7DQo+IA0KPiArICAgICAgIGlmIChjeGxyLT5t
b2RlID09IENYTF9SRUdJT05fREMpIHsNCj4gKyAgICAgICAgICAgICAgIHJjID0gY3hsX3JlZ2lv
bl9yZWFkX2V4dGVudHMoY3hscik7DQo+ICsgICAgICAgICAgICAgICBpZiAocmMpDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiArICAgICAgIH0NCj4gKw0KPiAgICAgICAg
ICByZXR1cm4gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCZjeGxyLT5kZXYsIGN4bHJfZGF4X3Vu
cmVnaXN0ZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3hs
cl9kYXgpOw0KPiAgIGVycjoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2N4bG1lbS5oIGIv
ZHJpdmVycy9jeGwvY3hsbWVtLmgNCj4gaW5kZXggMDFiZWU2ZWVkZmYzLi44ZjJkODk0NGQzMzQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2N4bG1lbS5oDQo+ICsrKyBiL2RyaXZlcnMvY3hs
L2N4bG1lbS5oDQo+IEBAIC02MDQsNiArNjA0LDU0IEBAIGVudW0gY3hsX29wY29kZSB7DQo+ICAg
ICAgICAgIFVVSURfSU5JVCgweGUxODE5ZDksIDB4MTFhOSwgMHg0MDBjLCAweDgxLCAweDFmLCAw
eGQ2LCAweDA3LCAweDE5LCAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAgMHg0MCwgMHgzZCwg
MHg4NikNCj4gDQo+ICsvKg0KPiArICogQWRkIER5bmFtaWMgQ2FwYWNpdHkgUmVzcG9uc2UNCj4g
KyAqIENYTCByZXYgMy4xIHNlY3Rpb24gOC4yLjkuOS45LjM7IFRhYmxlIDgtMTY4ICYgVGFibGUg
OC0xNjkNCj4gKyAqLw0KPiArc3RydWN0IGN4bF9tYm94X2RjX3Jlc3BvbnNlIHsNCj4gKyAgICAg
ICBfX2xlMzIgZXh0ZW50X2xpc3Rfc2l6ZTsNCj4gKyAgICAgICB1OCBmbGFnczsNCj4gKyAgICAg
ICB1OCByZXNlcnZlZFszXTsNCj4gKyAgICAgICBzdHJ1Y3QgdXBkYXRlZF9leHRlbnRfbGlzdCB7
DQo+ICsgICAgICAgICAgICAgICBfX2xlNjQgZHBhX3N0YXJ0Ow0KPiArICAgICAgICAgICAgICAg
X19sZTY0IGxlbmd0aDsNCj4gKyAgICAgICAgICAgICAgIHU4IHJlc2VydmVkWzhdOw0KPiArICAg
ICAgIH0gX19wYWNrZWQgZXh0ZW50X2xpc3RbXTsNCj4gK30gX19wYWNrZWQ7DQo+ICsNCj4gKy8q
DQo+ICsgKiBDWEwgcmV2IDMuMSBzZWN0aW9uIDguMi45LjIuMS42OyBUYWJsZSA4LTUxDQo+ICsg
Ki8NCj4gKyNkZWZpbmUgQ1hMX0RDX0VYVEVOVF9UQUdfTEVOIDB4MTANCj4gK3N0cnVjdCBjeGxf
ZGNfZXh0ZW50IHsNCj4gKyAgICAgICBfX2xlNjQgc3RhcnRfZHBhOw0KPiArICAgICAgIF9fbGU2
NCBsZW5ndGg7DQo+ICsgICAgICAgdTggdGFnW0NYTF9EQ19FWFRFTlRfVEFHX0xFTl07DQo+ICsg
ICAgICAgX19sZTE2IHNoYXJlZF9leHRuX3NlcTsNCj4gKyAgICAgICB1OCByZXNlcnZlZFs2XTsN
Cj4gK30gX19wYWNrZWQ7DQo+ICsNCj4gKy8qDQo+ICsgKiBHZXQgRHluYW1pYyBDYXBhY2l0eSBF
eHRlbnQgTGlzdDsgSW5wdXQgUGF5bG9hZA0KPiArICogQ1hMIHJldiAzLjEgc2VjdGlvbiA4LjIu
OS45LjkuMjsgVGFibGUgOC0xNjYNCj4gKyAqLw0KPiArc3RydWN0IGN4bF9tYm94X2dldF9kY19l
eHRlbnRfaW4gew0KPiArICAgICAgIF9fbGUzMiBleHRlbnRfY250Ow0KPiArICAgICAgIF9fbGUz
MiBzdGFydF9leHRlbnRfaW5kZXg7DQo+ICt9IF9fcGFja2VkOw0KPiArDQo+ICsvKg0KPiArICog
R2V0IER5bmFtaWMgQ2FwYWNpdHkgRXh0ZW50IExpc3Q7IE91dHB1dCBQYXlsb2FkDQo+ICsgKiBD
WEwgcmV2IDMuMSBzZWN0aW9uIDguMi45LjkuOS4yOyBUYWJsZSA4LTE2Nw0KPiArICovDQo+ICtz
dHJ1Y3QgY3hsX21ib3hfZ2V0X2RjX2V4dGVudF9vdXQgew0KPiArICAgICAgIF9fbGUzMiByZXRf
ZXh0ZW50X2NudDsNCj4gKyAgICAgICBfX2xlMzIgdG90YWxfZXh0ZW50X2NudDsNCj4gKyAgICAg
ICBfX2xlMzIgZXh0ZW50X2xpc3RfbnVtOw0KPiArICAgICAgIHU4IHJzdmRbNF07DQo+ICsgICAg
ICAgc3RydWN0IGN4bF9kY19leHRlbnQgZXh0ZW50W107DQo+ICt9IF9fcGFja2VkOw0KPiArDQo+
ICAgc3RydWN0IGN4bF9tYm94X2dldF9zdXBwb3J0ZWRfbG9ncyB7DQo+ICAgICAgICAgIF9fbGUx
NiBlbnRyaWVzOw0KPiAgICAgICAgICB1OCByc3ZkWzZdOw0KPiBAQCAtODc5LDYgKzkyNyw3IEBA
IGludCBjeGxfaW50ZXJuYWxfc2VuZF9jbWQoc3RydWN0IGN4bF9tZW1kZXZfc3RhdGUgKm1kcywN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGN4bF9tYm94X2NtZCAqY21kKTsN
Cj4gICBpbnQgY3hsX2Rldl9zdGF0ZV9pZGVudGlmeShzdHJ1Y3QgY3hsX21lbWRldl9zdGF0ZSAq
bWRzKTsNCj4gICBpbnQgY3hsX2Rldl9keW5hbWljX2NhcGFjaXR5X2lkZW50aWZ5KHN0cnVjdCBj
eGxfbWVtZGV2X3N0YXRlICptZHMpOw0KPiAraW50IGN4bF9yZWFkX2RjX2V4dGVudHMoc3RydWN0
IGN4bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCk7DQo+ICAgaW50IGN4bF9hd2FpdF9tZWRpYV9y
ZWFkeShzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hsZHMpOw0KPiAgIGludCBjeGxfZW51bWVyYXRl
X2NtZHMoc3RydWN0IGN4bF9tZW1kZXZfc3RhdGUgKm1kcyk7DQo+ICAgaW50IGN4bF9tZW1fY3Jl
YXRlX3JhbmdlX2luZm8oc3RydWN0IGN4bF9tZW1kZXZfc3RhdGUgKm1kcyk7DQo+IA0KPiAtLQ0K
PiAyLjQ0LjANCj4gDQo+IA0K

