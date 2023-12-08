Return-Path: <linux-btrfs+bounces-757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A902E809F1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 10:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9162818CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C362125A5;
	Fri,  8 Dec 2023 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hO/6qx1T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jGlW2YvT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D311724;
	Fri,  8 Dec 2023 01:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702027178; x=1733563178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nO6objwVUihBRTazH9MvYfi2hLxm35SUOnVHa4TNTA0=;
  b=hO/6qx1TFv7GlGcj2ZYOvRtYiQMfOgMPcZG3eg/7z3/6O/PkId/HmJc5
   pHCbXbqyeS921DgiSGf9x5iCnbu5kHIbikcfqiPJOIo+/ZziFN1Wr4lgT
   /wSV38f8IF4R4HzWdUM0QxcQtXTMTVGD/fEeqArbu7VQPwi8HxpqIHWSZ
   Mb5x5OBYWu7dpkOXhKEMhQ1FmWDccZZnTQdC/4FDx1GfpeJ3knnGVPeAN
   opv3i+skrOkcJSX7hSdVWlbVsRbTKKkojQ0pWPeFoRMvSNIQ1fTgc20dt
   QFDyhq9qnP2+BSPkzpgioAljtqRZXpNQ3CpEfQNJsYVGeZX/6axHoh3YE
   w==;
X-CSE-ConnectionGUID: rVf7f9qCTtKYiow9V1mpRg==
X-CSE-MsgGUID: DEcr/O+VR1uF0G/YFJgWxg==
X-IronPort-AV: E=Sophos;i="6.04,260,1695657600"; 
   d="scan'208";a="4363761"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2023 17:19:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNcpxxbRPHZTgr5xEvhM5giqgfo5w8r2vvlfBlFvAddLK6eR20M0gjvFW+CLyYtZcBnhSJKFOcWvqUPoMPi9ikwPpzHwm4Y3LjCfFta18KsQYzezo+Z2dMEZNjIHwKUu/m/bgb+/E3rV+5v6TGAGzKFkfr9uWTcKOEVl+Ed3V3upCRzw/4k2+K42O5jDm/6ry7cJGl1By5+WZZC3fRFYXUL/jFBq03zOU4hsTbnu4+vElwYzYk1HyAtHF+PVausVPULcGOlfC6S3Ji/qBXw7o0cEVg5LE0rFpwqwkQlA4Gm5vEc6M/hnjiolBYNBrMgOl+vZgx0h+xTbeblCOBQvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO6objwVUihBRTazH9MvYfi2hLxm35SUOnVHa4TNTA0=;
 b=HBQdvnG2aieefjkEXBG4K+qpKjqB+C837Kdjlm0DXMeMfiWle9goJk6CfdoCQ3jkIOmkg2buxVlo5Hw4Y1yIGRt/YU4aUDKmrmuBLNXLEyHK7Y8z+NP/VblHh6R/IoIb3iE9ZhhpUicytwnxbuNd9cQJmneK8rPQlTOr51TZ/axiVlxRHnYKEa7yGlmYeufMqRqsfM3EVAlK9ESuOHKOzJaCKw4yngtY6xwsCuhNLA4OkeiVYtVGEk8guxnhCF8kGHPxlLBDZauDqDNYg+EYNB414Rvzz7a2TDFlUIlPTtBzO0jUmnWoGbTaC0F97KbgXN/cXi9TAtB0keDVvzisVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO6objwVUihBRTazH9MvYfi2hLxm35SUOnVHa4TNTA0=;
 b=jGlW2YvTFosWmWjqOGa1QLncU/6xV95PnBEWkHqcfMrpbKrmL6a/UsAiBsznvhH1ybRE8Tn2V8jfhEZchydJMUVKt4DSoCxjDiZzDb3juaz4xfEupPWSbGWyPTkWQ18YR3JB0PSA4QRs9oO1Evm+H0uHFqfgaUAuZKTYheyLFJg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 09:19:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:19:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@suse.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Topic: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Index: AQHaKOxF3S6DLq0c+02PlL9c17xrX7Cduy8AgADcKgCAAIYfAA==
Date: Fri, 8 Dec 2023 09:19:34 +0000
Message-ID: <ea5e3a98-b5ec-46c8-bf0d-e8fbd88cf4eb@wdc.com>
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
 <CAL3q7H7pMjbc1-xZ1xDSMRBM2C-FiTi=sx=mQNBqH4MbXQ_WLA@mail.gmail.com>
 <0e13042e-1322-4baf-8ffd-4cd9415acac0@oracle.com>
In-Reply-To: <0e13042e-1322-4baf-8ffd-4cd9415acac0@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_
x-ms-office365-filtering-correlation-id: 7d073ec2-108e-471f-1788-08dbf7cecb55
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f1FIFU0VzKlS4wdV5O19heajqtycZJhhdNvLjE/mMlLR9V1DKDVWaVzCCnbikfb++gdIBqEDFCs/n1iH1nEK7NFuPTwu5SOktzlWrRPYXvOE1L1ahjgEyLWQYG1T4XgG1/9YgV3eYB1MFT6qtObVdkCabNldy1Z14y6RGAFmsQs4DXQY1213OsxXDrwF6zTRs7M9G3pGPuDUCJKcpzi5N0BZeCKZTzUJIM1yB1CALS0kstQ77f4GSsZnM6kR76h73goWeTKBMFIvmlR/UqW8hCAoyiCb46aUQ2QwDBFln6uw6MtVzMd/PhDb5KhK/KoxQYo68wy7a01ImmngA4+8mt7r9T7J+GgAQnlXIl8W1eU9sm+IpFVYPJ2yidE/msM1B8JAINSWcwoptkLveb8T5dpGZCkkeoLU0GSsnpFfBWwmcW9CeWdewvSIW5vmimKDRaOLFJe9HidO5qN5TozQvUnxmy4N7KpmT3ge104X+wEfsjEmR/c0b0bsWKbxHC5s2yfU5G558CBOmrLfQEGqiYqvbkY9bPv5TMMyyvtlbHA8iG3nfjk6HsXXwpElTy4XMvIDNfiUcibpePsZWuHuJH7eDsGd0PVb5LYWXHyL80bx0o9+tSLfWaxDPrtw4kr6yDSkoab6dIL/syTk6F3d92uY+5hCslbw0xEqzabEXSjS2c5yMJeCHyDRDS14ks1xl+b+NAmovsn4b1EP20pBIA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(53546011)(2616005)(83380400001)(41300700001)(6506007)(4326008)(8676002)(8936002)(2906002)(5660300002)(316002)(478600001)(966005)(71200400001)(66476007)(76116006)(91956017)(66446008)(110136005)(54906003)(64756008)(66556008)(66946007)(6486002)(82960400001)(122000001)(38100700002)(38070700009)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzIvR0EzZlFQRW9reXNqK3pMWWxiOG5PNHcwUVc2Yzk4ajVGU2JmbDdqbzI2?=
 =?utf-8?B?L0tUT2ZyeWRGTTNPdU5DbnBod3NORWNGSTZFUjBPeFd2U2d3NXc0ZzdyVU94?=
 =?utf-8?B?L3JsbElXK1UrRVREQW1BVmY5VDhxU3hPWkFuMXZFSUIvbm8wSFdDOGF3bndM?=
 =?utf-8?B?aDhrdWk3U3JmaVVkcmJnQWtocVorTVV0TjFNQ24yUVZ0YjNPa3R1WDRucnln?=
 =?utf-8?B?cWJxTGIxbURDa1AyZVNrd0F1bm80eGFsTXlrZjJxS0RjQld0aVVXZjBqYWhC?=
 =?utf-8?B?Wk1wTWRSKzhRRHhlVWlmWHM4K3FhQXM5RlZxeHgvMHRYRWZxclNmUnZnQTJy?=
 =?utf-8?B?VHk1b2R5aWVCMG93UkFEa3FJZDlicGxWRm1jeHBrVk1DSjZJT1d2S0h3NFFY?=
 =?utf-8?B?WTZES1N1bzRMYk9yTE5tVXdTczJOTTJoRC90WFhJNFNFeFdUSkdNaXEvajdq?=
 =?utf-8?B?aC9IWHlVY1hOb3VHZUFpajhyTGNzeWF5eis3N0tZMnJlc1FWTVl6WFVyU01s?=
 =?utf-8?B?YW54YU9nM0tHbFBjQ0hIZlVhRThkUkhlS3U3RUR5TWRITnVCMDFyV0VPUWdH?=
 =?utf-8?B?am52R2JYYllKYjhNTGg1djBjcWUzMmlLenpkZHd6bTVQbE9NaS9ERkx5NkZu?=
 =?utf-8?B?VnlIWUlMZngxOVBXQ3NlSERlSHBIcDg5VGF0OHg4ZXdSRUNOV3RBWTB0Zk5L?=
 =?utf-8?B?WHhHYk1hdmFiSnlQdCtzRmdtUVNTL05jTVg0OXc0V3RLemQvaXM0YWY4Yk1N?=
 =?utf-8?B?bXZacGF4L01XWldjb05GcDFhVzR3VjhhZWxpcGZ4MjhJdnN0eU1kNHFWa3Nk?=
 =?utf-8?B?bldLU1Q5WlJ5dUdySFVFdnhFLzRRZGhFakFhNHBRcGRKeVg4NHIrTmZETXRt?=
 =?utf-8?B?VHh2RUlsc3dRSDRoK0tRUmlNM0ZxRlMxNURnMUZ1T1huU0F5QThFWGZuYmQ5?=
 =?utf-8?B?OHlSTDB2NkJOQms5eGp5UkE4SE9iVHhNdE9Ma29EcVFpWjc3M1I0QWUwbW0x?=
 =?utf-8?B?R3REY3lTYUlSN3k0b1J2OUE3M2hJNWI2U1dBcERmbmx5V1NjbCtLS0pZbTBm?=
 =?utf-8?B?dldnSkxtcS9tWUY4SjNLSXBHeDh2OXE1REd1S1lwY1lOUit5Qmc5UU1jSWRL?=
 =?utf-8?B?eTVqdVVzb0dPVk1FcWY2WkNOb2dmSkJXTmc0dHdvdTZvNERFMzRLdWtOYmVX?=
 =?utf-8?B?TjZNMnJka1p5Y0E2WHBOK1prUnZuS2ZwQzdIWFRyNlJ6Z0tVaStSVkxmUnIz?=
 =?utf-8?B?UjZWTjhKQ3lRdjdudDhkbGs4SituZm5qbnZ0S2lCNlV1cnpnV2tzZ1pjZjlt?=
 =?utf-8?B?ZVlnTUxDSHlRYTNsLzQyQ1IxTUltcFBDYjBHNzF5WGlEMHNOU0cvZXlYNm9G?=
 =?utf-8?B?VTBhU1RFcnpKMFMxRUtOSTB3bm1SVVMzVnVDd1M4c1BlaUxJalpMM0pTQ3da?=
 =?utf-8?B?emJRYlA1YVBVZlMzUVptcUV4bUpVM3R6ei9nWHhrTzVJeGZtNGJKMGVlV1JP?=
 =?utf-8?B?ZkMrWGljV1N5ZzAvYjRHTDZLNWY5Y2d1dzIvbGNicXFLSytyRVFlT3h0WG5k?=
 =?utf-8?B?b3lRQVRCdGtnK09qNHdwbVEyc0UycWgzWjZNNy9oWE1tc0hlaHZxdkRndndH?=
 =?utf-8?B?SWx1b3VyRDlOV0xGM3dqbkNwa0FDWElFYkFOKzZWbC9OT01DRXdka1hZZlB2?=
 =?utf-8?B?T0hYNmJvZTQrQmplOHdHZitQTU80elpIK25PT2RCLzROdWtaNEFOMzRpc04y?=
 =?utf-8?B?eHNyQ3QvVW5OczNWRTNFSWM5THUyTzZ5N3lNSkZzSzBVbVk0MmlHa2ZkYkRq?=
 =?utf-8?B?MGoxVGhqSDc0ajdxKy9ydVlzd2lDcVNaUTlIN0FHdmo1bkVxY2x5T0IxZDVB?=
 =?utf-8?B?MXpmcG9YbWFiZXpTWjZETmRxalJMTWF3TGp3OFA2eEczcjhmU2ZzMm5ZK291?=
 =?utf-8?B?eUpWakFOTmpjRHhCQ2t2bHVCWG5BMHBabk9qUS8yL2lDMlh2cTg4VjgySXU3?=
 =?utf-8?B?TGR1YTJyZmp2TVlUQmErNFI1RjFLVXlqS1B0ZnlYdTdlKzVaWkZKL3drcDJV?=
 =?utf-8?B?Q0hoUFBjaEF3NTVoQmNYMlQ2Z1lNR0drVUdZR3drdG4xVHV3cGpURzhKV0xY?=
 =?utf-8?B?QTFzM1pMY2dXdktpNCs5QUllTTYzN2tidzJURlFJTW85THpucmRyNVNsTDZC?=
 =?utf-8?B?OGFGVm9odE9BQjhXa0pLQVNRbGYzOGhLSUJub1dBTW5GQnlPZGRDS1hnZmJI?=
 =?utf-8?B?WlVBOENHWk1qN2MrUHNyb2RzcGh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6338FE4E4F42654E933D2D2395897313@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tma+2MLQEwSWfHlo7a6AO7SyI78aF8cjagtl0iI7dR4RGrT+T1H8WhMRSLBWk1Ug/B4BE0bPZxkb+5H/H8Ervpd+2vk0chEEI6AMIATTi5PlZsQu6PWLnNLvCLRddI4sm3LEL7DjE6kcXDUmATOYGiS2CJuEwbYcKy2DmgZ/tQGj4BQpxZdHotzVvPT4GVEvhLlwi/dWnH9pRlEVc60h1WwUVCsYkiC7Pu0ttYcAA5sZ4XXIclrWENJFRCweUO2f0GDBY6ZMsDaMynOdKxJrokZUEoidNr5jB50vKYZ7SBWreBczlLmj+yrmX3xfA2n7Krr64AgVnZcpYlDiJF4vcbL/he0vhrwPhIKH4PMmubwvFy5vX8RA2s3p7+XhQfzGibE49x5vLA8Ce5q1X0zyemHLc+fO9xtvuzVepAln1F0Fv6ywlSPh78dNZMl9FsK8MymRWUsC+hc6OqSeH+Hq97hH9uVfoTYRfgxEMOpyXoDkjpZ3P1l5pscoFrgExgNqlHxhVdOr6zvBYNkIrZ+5j2aZV7d+TH8OksSzaIXX5Wqu7uvefxltbm8GGGAz63oGC5nUD3kl1T+5k6McKlPgHiSG2rKH0UXGxR4DIsNS3/1kkgoyqLpZHBF6jCCIFilEaIJlqMzwt65IrqYcWg/3LgnD2JB9Lny9liJpRzvW53QiH7vqx8ID9tUhA0iVasLLFTT8oFxTHXT1kCPV1G90NE07KFeJNvFoioh3Po0gXPkiR1PII/rlYkcyINpKzTWCYIC2tClDsDCzbKT8nc8guaJ2nWBeGUFmAgAHubZs6PbVci8aLNCQCMXcnS/Q/n8oCjSL2yDafcizVZXY2/yKcBGm7YqYfKFV8hLrfOqSeGI9oOzTUOF9TZ0zE7GjSqGRb8mWurTWQiBo9FjfRN0qgA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d073ec2-108e-471f-1788-08dbf7cecb55
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 09:19:34.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hh3uoGoigzWwu4F7DGnL4LCHls7a/oGHQAII0qJbOrU+Tqq1x2M8NVcb/+Z61a3NiSG10JLK/ccVk5R7iKygmbkaNfsmuUm1YyAzP5FGkzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7416

T24gMDguMTIuMjMgMDI6MTksIEFuYW5kIEphaW4gd3JvdGU6DQo+IA0KPiANCj4gT24gMTIvNy8y
MyAxNzo0MSwgRmlsaXBlIE1hbmFuYSB3cm90ZToNCj4+IE9uIFRodSwgRGVjIDcsIDIwMjMgYXQg
OTowM+KAr0FNIEpvaGFubmVzIFRodW1zaGlybg0KPj4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPiB3cm90ZToNCj4+Pg0KPj4+IEFkZCB0ZXN0cyBmb3IgYnRyZnMnIHJhaWQtc3RyaXBlLXRy
ZWUgZmVhdHVyZS4gQWxsIG9mIHRoZXNlIHRlc3Qgd29yayBieQ0KPj4+IHdyaXRpbmcgYSBzcGVj
aWZpYyBwYXR0ZXJuIHRvIGEgbmV3bHkgY3JlYXRlZCBmaWxlc3lzdGVtIGFuZCBhZnRlcndhcmRz
DQo+Pj4gdXNpbmcgYGJ0cmZzIGluc3BlY3QtaW50ZXJuYWwgLXQgcmFpZC1zdHJpcGUgJFNDUkFU
Q0hfREVWX1BPT0xgIHRvIHZlcmlmeQ0KPj4+IHRoZSBwbGFjZW1lbnQgYW5kIHRoZSBsYXlvdXQg
b2YgdGhlIG1ldGFkYXRhLg0KPj4+DQo+Pj4gVGhlIG1kNXN1bSBvZiBlYWNoIGZpbGUgd2lsbCBi
ZSBjb21wYXJlZCBhcyB3ZWxsIGFmdGVyIGEgcmUtbW91bnQgb2YgdGhlDQo+Pj4gZmlsZXN5c3Rl
bS4NCj4+Pg0KPj4+IC0tLQ0KPj4+IENoYW5nZXMgaW4gdjU6DQo+Pj4gLSBhZGQgX3JlcXVpcmVf
YnRyZnNfZnJlZV9zcGFjZV90cmVlIGhlbHBlciBhbmQgdXNlIGluIHRlc3RzDQo+Pj4gLSBMaW5r
IHRvIHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMxMjA2LWJ0cmZzLXJhaWQtdjQt
MC01NzgyODRkZDNhNzBAd2RjLmNvbQ0KPj4+DQo+Pj4gQ2hhbmdlcyBpbiB2NDoNCj4+PiAtIGFk
ZCBfcmVxdWlyZV9idHJmc19ub19jb21wcmVzcyB0byBhbGwgdGVzdHMNCj4+PiAtIGFkZCBfcmVx
dWlyZV9idHJmc19ub19ub2RhdGFjb3cgaGVscGVyIGFuZCBhZGQgdG8gYnRyZnMvMzA4DQo+Pj4g
LSBhZGQgX3JlcXVpcmVfYnRyZnNfZmVhdHVyZSAiZnJlZV9zcGFjZV90cmVlIiB0byBhbGwgdGVz
dHMNCj4+PiAtIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzEyMDUt
YnRyZnMtcmFpZC12My0wLTBlODU3YTU0MzlhMkB3ZGMuY29tDQo+Pj4NCj4+PiBDaGFuZ2VzIGlu
IHYzOg0KPj4+IC0gYWRkZWQgJ3JhaWQtc3RyaXBlLXRyZWUnIHRvIG1rZnMgb3B0aW9ucywgYXMg
b25seSB6b25lZCByYWlkIGdldHMgaXQNCj4+PiAgICAgYXV0b21hdGljYWxseQ0KPj4+IC0gUmVu
YW1lIHRlc3QgY2FzZXMgYXMgYnRyZnMvMzAyIGFuZCBidHJmcy8zMDMgYWxyZWFkeSBleGlzdCB1
cHN0cmVhbQ0KPj4+IC0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIz
MTIwNS1idHJmcy1yYWlkLXYyLTAtMjVmODBlZWEzNDViQHdkYy5jb20NCj4+Pg0KPj4+IENoYW5n
ZXMgaW4gdjI6DQo+Pj4gLSBSZS1vcmRlcmVkIHNlcmllcyBzbyB0aGUgbmV3bHkgaW50cm9kdWNl
ZCBncm91cCBpcyBhZGRlZCBiZWZvcmUgdGhlDQo+Pj4gICAgIHRlc3RzDQo+Pj4gLSBDaGFuZ2Vz
IEZpbGlwZSByZXF1ZXN0ZWQgdG8gdGhlIHRlc3RzLg0KPj4+IC0gTGluayB0byB2MTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMTIwNC1idHJmcy1yYWlkLXYxLTAtYjI1NGViMWJjZmY4
QHdkYy5jb20NCj4+Pg0KPj4+IC0tLQ0KPj4+IEpvaGFubmVzIFRodW1zaGlybiAoOSk6DQo+Pj4g
ICAgICAgICBmc3Rlc3RzOiBkb2M6IGFkZCBuZXcgcmFpZC1zdHJpcGUtdHJlZSBncm91cA0KPj4+
ICAgICAgICAgY29tbW9uOiBhZGQgZmlsdGVyIGZvciBidHJmcyByYWlkLXN0cmlwZSBkdW1wDQo+
Pj4gICAgICAgICBjb21tb246IGFkZCBfcmVxdWlyZV9idHJmc19ub19ub2RhdGFjb3cgaGVscGVy
DQo+Pj4gICAgICAgICBjb21tb246IGFkZCBfcmVxdWlyZV9idHJmc19mcmVlX3NwYWNlX3RyZWUN
Cj4+PiAgICAgICAgIGJ0cmZzOiBhZGQgZnN0ZXN0IGZvciBzdHJpcGUtdHJlZSBtZXRhZGF0YSB3
aXRoIDRrIHdyaXRlDQo+Pj4gICAgICAgICBidHJmczogYWRkIGZzdGVzdCBmb3IgOGsgd3JpdGUg
c3Bhbm5pbmcgdHdvIHN0cmlwZXMgb24gcmFpZC1zdHJpcGUtdHJlZQ0KPj4+ICAgICAgICAgYnRy
ZnM6IGFkZCBmc3Rlc3QgZm9yIHdyaXRpbmcgdG8gYSBmaWxlIGF0IGFuIG9mZnNldCB3aXRoIFJT
VA0KPj4+ICAgICAgICAgYnRyZnM6IGFkZCBmc3Rlc3RzIHRvIHdyaXRlIDEyOGsgdG8gYSBSU1Qg
ZmlsZXN5c3RlbQ0KPj4+ICAgICAgICAgYnRyZnM6IGFkZCBmc3Rlc3QgZm9yIG92ZXJ3cml0aW5n
IGEgZmlsZSBwYXJ0aWFsbHkgd2l0aCBSU1QNCj4+Pg0KPj4+ICAgIGNvbW1vbi9idHJmcyAgICAg
ICAgfCAgMTcgKysrKysrKysrDQo+Pj4gICAgY29tbW9uL2ZpbHRlci5idHJmcyB8ICAxNCArKysr
KysrDQo+Pj4gICAgZG9jL2dyb3VwLW5hbWVzLnR4dCB8ICAgMSArDQo+Pj4gICAgdGVzdHMvYnRy
ZnMvMzA0ICAgICB8ICA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICB0ZXN0
cy9idHJmcy8zMDQub3V0IHwgIDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAg
ICB0ZXN0cy9idHJmcy8zMDUgICAgIHwgIDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4+ICAgIHRlc3RzL2J0cmZzLzMwNS5vdXQgfCAgODIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIHRlc3RzL2J0cmZzLzMwNiAgICAgfCAgNTkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICB0ZXN0cy9idHJmcy8zMDYub3V0IHwg
IDc1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICB0ZXN0cy9i
dHJmcy8zMDcgICAgIHwgIDU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIHRl
c3RzL2J0cmZzLzMwNy5vdXQgfCAgNjUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+PiAgICB0ZXN0cy9idHJmcy8zMDggICAgIHwgIDYwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+Pj4gICAgdGVzdHMvYnRyZnMvMzA4Lm91dCB8IDEwNiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gICAgMTMgZmlsZXMgY2hh
bmdlZCwgNzEwIGluc2VydGlvbnMoKykNCj4+PiAtLS0NCj4+PiBiYXNlLWNvbW1pdDogYmFjYThh
MmI1Y2I2ZTc5OGNlM2EwN2U3OWEwODEwMzEzNzBjNmNiOA0KPj4NCj4+IEJ0dyB0aGlzIGJhc2Ug
Y29tbWl0IGRvZXMgbm90IGV4aXN0IGluIHRoZSBvZmZpY2lhbCBmc3Rlc3RzIHJlcG8uDQo+PiBU
aGF0IGNvbW1pdCBpcyBmcm9tIHRoZSBzdGFnaW5nIGJyYW5jaCBhdCBodHRwczovL2dpdGh1Yi5j
b20va2RhdmUveGZzdGVzdHMNCj4+DQo+PiBBICJnaXQgYW0iIHdpbGwgZmFpbCBiZWNhdXNlIHRo
ZSBvZmZpY2lhbCBmc3Rlc3RzIHJlcG8gZG9lc24ndCBoYXZlDQo+PiBfcmVxdWlyZV9idHJmc19u
b19ibG9ja19ncm91cF90cmVlKCkgYXQgY29tbW9uL2J0cmZzLA0KPj4gc28gaXQgbmVlZHMgdG8g
YmUgbWFudWFsbHkgYWRqdXN0ZWQgd2hlbiBhcHBseWluZyB0aGUgM3JkIHBhdGNoLg0KPj4NCj4+
IEkgdHJpZWQgdGhlIHRlc3RzIGFuZCB0aGV5IGxvb2sgZ29vZCwgc286DQo+Pg0KPj4gUmV2aWV3
ZWQtYnk6IEZpbGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPj4NCj4+IE9uZSBxdWVz
dGlvbiBJIG1pc3NlZCBiZWZvcmUuIFRlc3QgMzA0IGZvciBleGFtcGxlIGRvZXMgYSA0SyB3cml0
ZSBhbmQNCj4+IGV4cGVjdHMgaW4gdGhlIGdvbGRlbiBvdXRwdXQgdG8gZ2V0IGEgNEsgcmFpZCBz
dHJpcGUgaXRlbS4NCj4+IFdoYXQgaGFwcGVucyBvbiBhIG1hY2hpbmUgd2l0aCA2NEsgcGFnZSBz
aXplPyBUaGVyZSB0aGUgZGVmYXVsdCBzZWN0b3INCj4+IHNpemUgaXMgNjRLLCB3aWxsIHRoZSB3
cml0ZSByZXN1bHQgaW4gYSA2NEsgcmFpZCBzdHJpcGUgaXRlbSBvciB3aWxsDQo+PiBpdCBiZSA0
Sz8gSW4gdGhlIGZvcm1lciBjYXNlLCBpdCB3aWxsIG1ha2UgdGhlIHRlc3QgZmFpbC4NCj4+DQo+
IA0KPiBUZXN0aW5nIG9uIGEgNjRLIHBhZ2VzaXplLiBXaWxsIHJ1biBpdC4gQXBvbG9naWVzIGZv
ciBpbnRlcm1pdHRlbnQNCj4gcmVzcG9uc2VzOyBPT08gdW50aWwgRGVjZW1iZXIgMjEuDQoNClRo
YW5rcyBBbmFuZCENCg0KSSBkb24ndCBoYXZlIGEgNjRrIHBhZ2Ugc2l6ZSBzeXN0ZW0gdG8gdGVz
dCwgYnV0IEkgX3RoaW5rXyBGaWxpcGUgaXMgDQpyaWdodCwgdGhhdCB3aWxsIGZhaWwuIEkgdGhp
bmsgd2Ugc2hvdWxkIHNraXAgdGhlc2UgdGVzdHMgb24gbm9uIDRrIHNlY3RvcnMuDQoNCg==

