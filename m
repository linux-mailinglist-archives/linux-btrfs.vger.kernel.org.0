Return-Path: <linux-btrfs+bounces-1603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7928365B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 15:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C431F22709
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D4E3D556;
	Mon, 22 Jan 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JlRb62JF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XHf7Cz91"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD83D0A8;
	Mon, 22 Jan 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934589; cv=fail; b=IE/afWS3pwHsIleYjyA5lm1LlqadPnFlteQoqp032uh5yAw3laf4bFNz16G/HB1vQr0jC0Y4QLmxB/mfW7j9WiD5cA9glpRVXiTxiAPe6rXMz1q3So70PoSXK92bKENWXDS61TI0pqA1a1R1cW2piyHVtG/vpfAU8eJzxPnRBDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934589; c=relaxed/simple;
	bh=l99bH+ZIrarxbK/LxsXdG7zqeMvokNBpbwVCD7n2fnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tSVb1OLiGBuTUJey3M7q5jaqEdq0oouQ03fUE3RmEKveW/OeGAYGYN1TNgSp2JfW5emL3wMii8yQ959uLcY/yWS3qQWFLHSQBa7rVIKuN84Js/6s9eqrG45BvvoBOPIKSnr2+7vAZUJqcoU3LaLADz57J4mqyfaXQvrI4KSueWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JlRb62JF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XHf7Cz91; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705934587; x=1737470587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l99bH+ZIrarxbK/LxsXdG7zqeMvokNBpbwVCD7n2fnw=;
  b=JlRb62JFcW4jcYntF0vBUD8KCQRVObpf5a9/wTlhStRYD5hNXfUN2IR8
   +AUIZU9RUwo4EPLmIjGXVir385+xQaY8vLtyt9ErTMgUDaQzSVuTARgnp
   8ds9qR8jYqvmsfU+PKHqULf6X8L8gkUGcO7EgH2ii6XIZX6CuR3vkWySI
   0ZL/aQo2IaPrxB7fKkXZWLPhsNbm/alDi9OUDroBxQVviTlD8uiYczLia
   jJnaR1h12gCU4fal2a++RCxv6OA9quoMayX78xiRmJXfgb3edlxvu33nJ
   +vprn1f4AByW3V6IRpHyH6XyI7bUjSgcgtwNe5asG8e7pF54am822zCza
   Q==;
X-CSE-ConnectionGUID: GvbVvvpNSWubhTJg/VXi+A==
X-CSE-MsgGUID: Bp1sBa9lQvyaKKjHpq2cRQ==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7168576"
Received: from mail-westusazlp17010000.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.0])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 22:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqn0fUph/63EDMncw3/10RvQxWMf3Un7MFgnf8zXMw00nt/6NfGhSaJR4JPX0WzlcFrbIq3zfGd5CfzXkXtxhM2xXtJnZc583oA4WpF+QFOdCqoRwh4Y+PLochhx4i23oWtDoNdy1tN4Yesb7dfcEE1M2AtJD5fzr9bPJga19Ljj62X7t5fY/G3v91VHRaCa3rapxX46utGbg1O84sMB/USB6z4jnZibhbowpr52WARYh36ZggH/5+XzS9/Uu6dvqgs3zD4QzxzRX4ZKEfn9ipjiuButQkiUwg0EiaObvTFvI4IKgFesfIhTPGUS8p1DHXpc7dD7suW0GC42kycGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l99bH+ZIrarxbK/LxsXdG7zqeMvokNBpbwVCD7n2fnw=;
 b=HKV/Qb64X5Jxcnwa7Og0v+y9tIi6eBmH8PrRWW5bIU22KBFVAoriv1F2N09dfiCMhPUnzXR899B3ZWc/IKGB4I1YHgcTuA+gOgVTUEI4NMwe0N0sbZ7O6r4lOo/qIQHWs09SYUIhtq5cs028u6rP158FvmFbrss+/rtWaQr9ZFaXF9Rgvl+v9DSpwYX/vDAU0EXqc1T6vniRg/RuHN57FRvd0JLHDY7xmLexLyC5cE2EVJefmokMy3DRCfX3pC4yWyy+8NkD1yMUTywuTK9b+cOAewfHAXr5zVq44s7vtjLxtCmt32QWqtqYFNZh/5j1zELodHRe/JoCtyRmzrlttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l99bH+ZIrarxbK/LxsXdG7zqeMvokNBpbwVCD7n2fnw=;
 b=XHf7Cz91x5m9vX50RwrN36H98msYmrM6OiG9vy4ucEHm7EGdTGJoRGE4VHQ4Wz5Hxhw5p7dq86L0GsPYehQekywx7ZlAllocMRRWqVOcS5rADG7BsFQTBkko+Ae7BzS76fqqc8fXdzK+37CmYaG46pwJhMtNXecbTA2fwRnJFKA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7262.namprd04.prod.outlook.com (2603:10b6:a03:292::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 14:43:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 14:43:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Topic: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Index: AQHaTUFNPGjai0bjgEWDnZSYXVsZWg==
Date: Mon, 22 Jan 2024 14:43:03 +0000
Message-ID: <2fa9112d-a72a-440f-a32a-199b5350b59d@wdc.com>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
 <x6bi4u2u65q37tde3s357lzhce4wglpobfgp7qgzhun4iadg3m@2pewiu6xuts4>
 <f5d54836-5edf-4cd0-88c8-f2d474368ea9@wdc.com>
 <k7fiky6xm4hshkr5q2xukfjndcseiesfanlpc4oozztvuyclbw@ftrhgjeicsfs>
In-Reply-To: <k7fiky6xm4hshkr5q2xukfjndcseiesfanlpc4oozztvuyclbw@ftrhgjeicsfs>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7262:EE_
x-ms-office365-filtering-correlation-id: 0c5c8e16-0ea4-4b81-ca52-08dc1b587046
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VQQblP1wVezbJawbQuvb58IYnVvhjvwTSqsySQUZ6Fo7rxFIxBeJaTJ0vqeEOLRj6TbG7EuTTxmAgjXscj/aY5jdkONxNAuAxWBNiz7ARDMPfVjoT9akHYE6gDpSf3uzrNrXHKx3f411LwTnV/kX8PWXMk9T2RxsayUhJni9VSIck7tBuPR3zGYz99c301U3+uZ5qRSmwMg/7TiTXRsgjfHKUwlruxx22ntUAedt1XHsZstcDTeBDahlnw9Q7IkFhRGiKtP3XPexvaw2jBK//Dqfr2Qk+EOAH5+MaSdsNZlhxHlJ/f/T0FRHzM87PkMkcNlBH1qA61jjotPhTeLke8sGp8ZscXumVbLfmkgmPn+FSoAlGmO1dzx2AB/OARkhr0mZN/5qq4QJK0IuyCwK9LBOL+bzVIXuIV9LeR3tY1DlMpvYzKCSfuFK/rHPTLTqGr7DZGJ/kXIwoze5kt6Z4EXEiKp/nmqIXEVw9+tecGE6Hqy4GeRkaXAHhy74Bl86o1wohbqRsBcyy3mf562VAurty2F0jdnZdFsB+497k9yx+jrWBLK1zENDZMh/nMgQiesNYVGb5L74zpclBUUAB1k/vm0+VAJS99ICOnHDdyuOheQPTSCFkZwxJ9iBPz4Zd3IgJKVaZc+mdPjNxANly7q+8uTJHZd+ZenYcV0kror8iMPyhz+PT1eux51htBap
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(2616005)(38100700002)(26005)(71200400001)(122000001)(8936002)(53546011)(4326008)(6862004)(8676002)(5660300002)(41300700001)(2906002)(478600001)(6506007)(6486002)(6512007)(6636002)(76116006)(54906003)(66446008)(316002)(66556008)(37006003)(64756008)(66476007)(66946007)(91956017)(36756003)(86362001)(82960400001)(38070700009)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3FNeU95RmdUVG5MWlFCTnVFYU96L045NXdkSUdMZDhqK3Q4QlU0MXBvcEhS?=
 =?utf-8?B?cFJJeHRJYSt4K3dKMDQwdUt0SkdudnEzUlYyNW1rckxGS0oxekNVaDE2VHlM?=
 =?utf-8?B?T0dudEs5MSs2cHVYZWNmVnFnNWc3Ym13V2oxOFc3bEFIUGkzVVJHYXBwVGd6?=
 =?utf-8?B?bGF1enVFdE9Lc0dlR0h6aEZHUVlXcXIweEFLVk1GSDJEWEFwcTRjOXNtNHVR?=
 =?utf-8?B?cmtTcWdhSXJjejhTcm9OVmRkczc2dUNEeWd3eEl3eVh6d1VIaTRlY204cXZ4?=
 =?utf-8?B?RXFvdWpPcE96WnJ5MmdUQlNGaW1UT3RHMW5SVkFSWFBFaDJ1Z3lqR2p3L3BK?=
 =?utf-8?B?VWFXSlBHY3RhT09CaFNUT2VwLzJGZEl6Z3hOYlVqZzVQL25YcGtSWHlUeVZP?=
 =?utf-8?B?Y0tDY3l6NzlSaUhlOHFMR2VVOUFyQ1IrUmJka052NDR1WXBRSXBRVms2M3BJ?=
 =?utf-8?B?enZjSnZJWWRSdTJ6VEtFMWF0alo2aUd6bGxncDEvU0MxR0taam5JUzNzc1g4?=
 =?utf-8?B?anFNS3d4ZHF1djgwWW91bHJrZWRIRmNEdDNqRmpINS9WUFhiU2ozQUJNajg2?=
 =?utf-8?B?UWJENC8vbFd6NWkwUDVaM3NTNytPeXBVNmh5cEducUpFV1dhZXVGdmFQaTdY?=
 =?utf-8?B?bk1qWG92bm9iSG9RY1RqUkdqaktaL1RWT1g1TkdCQ0REWXJiQmRLY0s4bjNy?=
 =?utf-8?B?RmVFR2hwMmJSUVdwTTB4dmx2Z3BWcElUZU5aRi9BaTVNRnR6RkVSWFd5OFhE?=
 =?utf-8?B?M3ZpaldkRzRsSUFqdzBsMlkzSk9hUEl6L3NsNGUrdE1hYXZrVm1TRlRvbWtl?=
 =?utf-8?B?OENrY0hScmFUV0EwVWlSd1NHbHhJL09ablp2ZE1ITFY2dkMxNVlSUk5XK1Bv?=
 =?utf-8?B?VGsyQUlEaFpVSU9yOUQ1TC9hbURoZDJkVHNRb0ljT0tYZFNmdk1kU2UwZndY?=
 =?utf-8?B?aU44UXdNUzBlN1hNcWc4NUYzOEdzTnZYdHlPMm1RaEN0RGNkdkZDVlNJNXFS?=
 =?utf-8?B?YUF2QXA4empCNVU4eWx5Rkc5OWZLVExhczZkOHpvcjZQNzZtM1Q4T25OeU9O?=
 =?utf-8?B?eENtNlRRQm55RXZCVmxHRUZxdms4ZmRXVWtFbFNZWmtPNWFWaURUOHEwY3dw?=
 =?utf-8?B?UjRSSmY1ZWxhbTRjU1ZNcWkvWUU3OGlFNVpKRG9oNkFpSW9lTnlscFIwaTYr?=
 =?utf-8?B?Z0hLaWcyZnRuRFBtb1FWNVpvbUNicVdSaUdGcTJ5SUZHVDhMdFEycUZBMGZO?=
 =?utf-8?B?ZDhOVEpUbnNuSGQzTDVheTEvTW5yVUNCZlBKNjM3Q00zS3V2ZWJoRXRNV0hI?=
 =?utf-8?B?NFJGWk1wUjRJa0hzb3RWczhhdGdhQ29TaU5IL1FjQXZwYzFtVGg3WFgydG8y?=
 =?utf-8?B?VDVqRklMZDlnQW5MNHVzMnBPaytrNGVRd3pKeGFRSkNSRVp2aEVMMlMyVGtZ?=
 =?utf-8?B?VXVtYXEvSHZ6S21XMUdwaDdwSXhaSmlxN3N1cVl6RTdkYzNYa082Nm1pNGhG?=
 =?utf-8?B?ZForZUxhdGwvQjdJR093bUNNc2gyN3JxV21hNXB1VC9jbTlPcEhrckF6RitS?=
 =?utf-8?B?a2dQUzBnYjBGNDkwVlJ3bGE2N011ZnFYRUxqSmwxUk85bG1iVWJPeVFaU1Vq?=
 =?utf-8?B?cEhvcEl4UU9mbit3cjB4Q2toTEZveEpmU0FkYUQ4b2xNb3JpcVNLcCt6RUtR?=
 =?utf-8?B?Nit3OC9hcUk5cFU0OEZBNGUzNStsWk1XOVdReDk5eHBOUXQ4L2U1Q1V2Vm1V?=
 =?utf-8?B?OEhDZHRTbHpMK3dVSC80UjlwRXBXaTdvZ0l0MHRxTW1yNkhJYXVxQzVvQ0s1?=
 =?utf-8?B?MC93Sm9RNDB1c0o4bjRyM3NmU2RmYjhTZ3l0NWI1OVZ6OEQ3Vy9pcFZZVWEv?=
 =?utf-8?B?RFJWZDM2djJUcGVGUW0yUWgraXlxbUVQSVAydHRCVXNpK0ltYStnWVZLZG1Z?=
 =?utf-8?B?eVB1NkR4UWxFWWZmN2ZsaEtBRWU4dGRyOHVLV0x2cy94SU0yVnE1aDJTKytX?=
 =?utf-8?B?dlBYVzJIMnUzWDI5VWhXSGgyTlVqSkI0YzhyN004U0w4aEJuay9KQWtSMWJz?=
 =?utf-8?B?eG5qZHBhRkpjR0xuU2Q3ejBDR1A3TUJkOWZUYzBXb053dWtwWmtoRWRsMkpq?=
 =?utf-8?B?T1E5Z051RnpBYlIzcHBnZ0xEQTZTcktjVXphT05ESXZTVzBsdnpoZWVxazVt?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C3C319BF3E434DB931C94236AF172D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	slCyKsNAYmIFR9440HYJ52lzBYMXKiAPXgSHW0xChOaUMJADzaKF4PK3jgdJyn3qJuDB2J92u4GguigG/feMoDzqN9NXDoaa0nxEDpb/V2FudS/UH6JxQ397rT8EAuvWk65MJ3EvZE2HrPXOvmdlX+ixNOXblZ2QQiKecV371V4SUuz0BpZZ/kVW1yehUUgUiOj1ro7ilmQx01OZYplI2/CFQwKqT1wUbYjPzEZr8CZSlzqPMuzha5hEsIMUVTTNVHYGH4Z2mT0V2tnc5yx/M+2/D0dGoqg2CNqjPTvLrCaImpyJIbQxXF5CneB43nQ8BG7JS86gh7Q1ikyQPUx45zd+zK66GjLHrH2FzAOIvqaUrZ5peiraDm45enNsDDSTZFJBsoSLn5L7HrgvZvC+k7gdVjuPU0DYHRZrnJAyR9MvuviMxPuzrRWfaIAi2bybokzDxUQiSsAeYUOjsLvmQ56lSn2wfSk6wUSgDLQdsWwxl/1SzUC7edwicO/3yZBG1XOlK5FeTrFkXMwftMVADqpWj3AOhRpNNHfA07kcpt+ig/jy7Guzji/zY8ZnK4pKI1U+qcddzTH7QcsZbGrO/x/AnheoWR0dKnAiHc/gTf0S8enxIj/ry7zrjY/w8/a4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5c8e16-0ea4-4b81-ca52-08dc1b587046
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 14:43:03.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5lMUyJFsQ31sAdJg6B2v8FkZ3gFBkYOAHIgH7GNdAhXutw6Wn1uXJDmSz36etFgbxg6MYKQt/dU+Bj508Tc4FxyTKAem64wgoM4V2o43JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7262

T24gMjIuMDEuMjQgMTU6MzksIE5hb2hpcm8gQW90YSB3cm90ZToNCj4+Pg0KPj4+IEFsc28sIGxv
b2tpbmcgaW50byBidHJmc196b25lZF9zaG91bGRfcmVjbGFpbSgpLCBpdCBzdW1zIGRldmljZS0+
Ynl0ZXNfdXNlZA0KPj4+IGZvciBlYWNoIGZzX2RldmljZXMtPmRldmljZXMuIEFuZCwgZGV2aWNl
LT5ieXRlc191c2VkIGlzIHNldCBhdA0KPj4+IGNyZWF0ZV9jaHVuaygpIG9yIGF0IGJ0cmZzX3Jl
bW92ZV9jaHVuaygpLiBJc24ndCBpdCBmZWFzaWJsZSB0byBkbyB0aGUNCj4+PiBjYWxjdWxhdGlv
biBvbmx5IHRoZXJlPw0KPj4NCj4+IE9oIHNoKnQhIFJpZ2h0IHdlIHNob3VsZCBjaGVjayBieXRl
c191c2VkIGZyb20gYWxsIHNwYWNlX2luZm9zIGluDQo+PiBidHJmc196b25lZF9zaG91bGRfcmVj
bGFpbSgpIGFuZCBjb21wYXJlIHRoYXQgdG8gdGhlIGRpc2sgdG90YWwgYnl0ZXMuDQo+IA0KPiBZ
b3UgbWVhbiBkZXZpY2UtPmJ5dGVzX3VzZWQ/IHNwYWNlX2luZm8tPmJ5dGVzX3VzZWQgZG9lcyBu
b3QgY291bnQgZnJlZQ0KPiBzcGFjZSBhbmQgem9uZV91bnVzYWJsZSBpbiBCR3MsIHNvIHVzaW5n
IHRoYXQgY2hhbmdlcyB0aGUgYmVoYXZpb3IuIEV2ZW4sDQo+IGl0IHdvbid0IGtpY2sgdGhlIHRo
cmVhZCBpZiB0aGVyZSBhcmUgbWFueSB6b25lX3VudXNhYmxlIGJ1dCBzbWFsbCB1c2VkDQo+IHNw
YWNlLg0KPiANCg0KSSBkaWQgbWVhbiBidHJmc19zcGFjZV9pbmZvX3VzZWQoKToNCg0KZGlmZiAt
LWdpdCBhL2ZzL2J0cmZzL3pvbmVkLmMgYi9mcy9idHJmcy96b25lZC5jDQppbmRleCBiN2U3YjVh
NWE2ZmEuLmQ1MjQyYzk2Yzk3YyAxMDA2NDQNCi0tLSBhL2ZzL2J0cmZzL3pvbmVkLmMNCisrKyBi
L2ZzL2J0cmZzL3pvbmVkLmMNCkBAIC0yNDE0LDYgKzI0MTQsNyBAQCBib29sIGJ0cmZzX3pvbmVk
X3Nob3VsZF9yZWNsYWltKHN0cnVjdCANCmJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pDQogIHsNCiAg
ICAgICAgIHN0cnVjdCBidHJmc19mc19kZXZpY2VzICpmc19kZXZpY2VzID0gZnNfaW5mby0+ZnNf
ZGV2aWNlczsNCiAgICAgICAgIHN0cnVjdCBidHJmc19kZXZpY2UgKmRldmljZTsNCisgICAgICAg
c3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm87DQogICAgICAgICB1NjQgdXNlZCA9
IDA7DQogICAgICAgICB1NjQgdG90YWwgPSAwOw0KICAgICAgICAgdTY0IGZhY3RvcjsNCkBAIC0y
NDI5LDEwICsyNDMwLDE1IEBAIGJvb2wgYnRyZnNfem9uZWRfc2hvdWxkX3JlY2xhaW0oc3RydWN0
IA0KYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCiAgICAgICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsNCg0KICAgICAgICAgICAgICAgICB0b3RhbCArPSBkZXZpY2UtPmRpc2tfdG90YWxfYnl0
ZXM7DQotICAgICAgICAgICAgICAgdXNlZCArPSBkZXZpY2UtPmJ5dGVzX3VzZWQ7DQogICAgICAg
ICB9DQogICAgICAgICByY3VfcmVhZF91bmxvY2soKTsNCg0KKyAgICAgICBsaXN0X2Zvcl9lYWNo
X2VudHJ5KHNwYWNlX2luZm8sICZmc19pbmZvLT5zcGFjZV9pbmZvLCBsaXN0KSB7DQorICAgICAg
ICAgICAgICAgc3Bpbl9sb2NrKCZzcGFjZV9pbmZvLT5sb2NrKTsNCisgICAgICAgICAgICAgICB1
c2VkICs9IGJ0cmZzX3NwYWNlX2luZm9fdXNlZChzcGFjZV9pbmZvLCB0cnVlKTsNCisgICAgICAg
ICAgICAgICBzcGluX3VubG9jaygmc3BhY2VfaW5mby0+bG9jayk7DQorICAgICAgIH0NCisNCiAg
ICAgICAgIGZhY3RvciA9IGRpdjY0X3U2NCh1c2VkICogMTAwLCB0b3RhbCk7DQogICAgICAgICBy
ZXR1cm4gZmFjdG9yID49IGZzX2luZm8tPmJnX3JlY2xhaW1fdGhyZXNob2xkOw0KICB9DQoNCg==

