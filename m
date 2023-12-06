Return-Path: <linux-btrfs+bounces-711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09233806D70
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 12:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95F61F211E0
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C75315B5;
	Wed,  6 Dec 2023 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AekG8bSr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jtTj6g9X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E5810F6;
	Wed,  6 Dec 2023 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701860921; x=1733396921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M5lOWaCx4b7D2jr1Z1kUbQY/YFgwtTg7laUeki+exQk=;
  b=AekG8bSrcs1pOE9zUpudU7ayhHlaXdx7fXiTv3jLFoIqlrqPRd1Yy3Um
   p/8Bvg6OkOwsj4xKfl0JP0ivmzjSR1wq3OB2yA743QwlP120XhkUbb+zy
   q4XWixR6a6WYjMgpTqycNa307MY7kgJVX+BFkC5Ori+ADdmgsnnuKE5Vh
   aG17mY5AyxSyfcXhJ8XcwqlnONotCa20TJvThqdjPzZ3rbvZQbdJKBd3n
   Y/ZCYBRzFwaUJs7A0OHa92dBqANRTuRFAd/rHL7qcZ2kMLLTEHRGWDVv/
   8Hlgv1JqAwKdrN7ZpZSmyH6bWq9rVHHBrNqj9yMi9NbcsJHDsulHlTMBn
   w==;
X-CSE-ConnectionGUID: cRL1RpQiTKClYJAhwf4h0g==
X-CSE-MsgGUID: 9+n3MsE1R6qkakXTU6CB6g==
X-IronPort-AV: E=Sophos;i="6.04,255,1695657600"; 
   d="scan'208";a="4147603"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 19:08:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVrjopoJ1aPT6Zs1pUWniG88IgapbsCjRVTM51JQrMBSIWeosLmB36Jvk7iUWyxlbEPicbJU26LVUTzm3VG1zZ1pPct/COcWnZowDb/Je+zyKnJVl1OZm+zB90lfmj5zHoXwFuO9eRhL2bUp+oEgxfHbZo5vhYQMWDjxV5cOf8GY/3lBnzr46JG71vkGCxJSfOj69hqtOiMQQh09fILL3PotN6Ax66Lt+FFv0cJ8TbdGemZNorHB0ao/K80CHxFVXGhCtuIkYosaOmJqm4rFjTD4Bscjfyw9Lz2LzV7/xv4zq6BzUY4kwO3nIJraXLsPAgj6aJc98BRlSiw4yruPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5lOWaCx4b7D2jr1Z1kUbQY/YFgwtTg7laUeki+exQk=;
 b=HfeVZ4aSbZUSongyxtXCJGCIsNeT5X50X5zMBEpDXoQlXT5HPKTtPr3YM6jNR4OhDG8zR5TtXFKMtc442LAT4R+w1+CPN3/o26rjU24NZlbNzaHpzdFjwhCFh0xzyYSQ4m11tKXbDUiZuTpkpDlZmRhAC7T884a5mWhc168+PoqihaOTPeDRyrdA1FvH0Z+t1hQIpZwWzG7c6JuK1nlI3KdObUs1t5eNPbFXEFmz62upCX/5BbYYMTQcSJn5GduWnEundv9XaD7LEUaQogm5wz7VsnSN3vOEe7fL3Zi0hUwO16GauckMDpB8gBiuHVfWU4CUNwfZhr3KFdpFkv+Jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5lOWaCx4b7D2jr1Z1kUbQY/YFgwtTg7laUeki+exQk=;
 b=jtTj6g9XZLeU3eeNJfXaG96u+bAZUty15LpoeirLgI8NiXCeTxoZlFlEXcW479jehZ5gykDsUzs9Jd4jAN+cYr0yelWjvau84swBpaj5SmjNQIbmlHfmteErFNup2VMCCN7sRO7Un+1HxLc/E3TkIFnIi9o6gdIYJ3JJQ+XOlhs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6510.namprd04.prod.outlook.com (2603:10b6:5:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.37; Wed, 6 Dec
 2023 11:08:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 11:08:38 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
CC: Filipe Manana <fdmanana@suse.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Topic: [PATCH v4 0/8] fstests: add tests for btrfs' raid-stripe-tree
 feature
Thread-Index: AQHaKDLbE+BaKbd8NEiZIEJmYokgj7CcGLmA
Date: Wed, 6 Dec 2023 11:08:38 +0000
Message-ID: <46045c46-5614-4c01-9080-b6f0a7dd8d7a@wdc.com>
References: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
In-Reply-To: <20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6510:EE_
x-ms-office365-filtering-correlation-id: f395180a-1a0c-4f3a-fe64-08dbf64bb290
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Om+C3v7Pn4NkpPx51RG60ZowO/RPG4efo2aHX6TLVDVc2lBoOyVW5HpqF3mTSE+yDQvQIGxR4liHw3lmPL9MsbwC88GJua604HEkWgQsa6FwQtJwekMZ5QZMqIJJZK18/rQHSVJXpZvmuaHOCYrqV0oP2XLAtHjWtPf1Xm5htuF/dEtU/N7jhQIylX9ord1AETyViz3RJ9F0WrhDg1JIdPv2wN3kJLfzl6lgV1UjpVizh9a/sNNCZ40dJhGLG9oUqXDfdNRTvIamfciGo6aRtkhyjsW+IjWDbHuI1QGFakkJxrLyynfjeR4mnHJ3g1bLSULq8zc4fjOJpMx4u4q9ImR2t+eGwWKC6wdVgb9UAzoskVvV+v83QAZJo9qoB274Iy+DnrTk2NpwEZDpkeSQktuuyaaeiQl624sk3w3afhRfVm0VE1fRAVILkc3kREx+TquTMIJMeSZXU2z0DotY0+selHSFau4IfKXGNKiD9TJ685z3Y3/bGyHsy+CTWnSHLeFyzQsD9m/arAVjMMwaQGhWob+nEhSPdy714zei/rRapF3FMIts6gYWYp1hbRTVqu99XelCf7YWNjTkwdxe61ZUKbftxjbhYvN7TslomqKBpPyHSenmrXmThFBpV9u2rzeWTgBj5v6l/2XthyO5FFYDUBWOUL5sDZSKDiUdg4YPr8Wy+G+YqYHP6PeyMAXU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(8936002)(66946007)(478600001)(6486002)(4326008)(71200400001)(5660300002)(6506007)(316002)(91956017)(76116006)(31686004)(66476007)(66556008)(64756008)(66446008)(53546011)(54906003)(110136005)(6512007)(4744005)(2906002)(2616005)(36756003)(122000001)(82960400001)(38070700009)(41300700001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1l2VDY3aGNFRjFDZDNCbUxEc3k5d2lQUGNleHVMeldpUXpnL29NNlFQRHJE?=
 =?utf-8?B?VjFwK2Jnb05NMmNZeDUrcXhhSEdoUkl0UlF2RXNBMWpJbUIyNE5KRUVwQkp5?=
 =?utf-8?B?ZDl1TmFpa2c2QkJvV1p6d3hnbW40WUhKUGc1dVYxRGoxZ3pxSmhFTDRQZy9L?=
 =?utf-8?B?Mno5Q2VDVExINEptcVo5THp0Y3lJRU5ZdEpPZm1ySnZDa0dmTFo1TVdUQlBY?=
 =?utf-8?B?cFE1TE5tK25nbVYxSUJCdFA5N0swNnFCa2x2NnF0T3g2SGVPaGE1RTFBU1RL?=
 =?utf-8?B?OHlqVHVaNGJsbzExQ0gxeVJ3SW9zeFFQTXorbWEydXkzVXpRNW1LSFBZUXFH?=
 =?utf-8?B?YXRRbGVaUGxOKytjZ0tEbTR6Y3JlVUhIUXpvSEgzWFg3WTN1OUwrYWs4VUZh?=
 =?utf-8?B?K255dHJxMkExYUlxYUs2SzlqZ3lFVWhqbkZKUFhzOEtIcjJMRTBuSlBTNGdx?=
 =?utf-8?B?L2RlalZybWdXLzFaYW1CYndVWDJsQ2ZjWG9haisrd0ZpZHR2NTE2YlZROGp0?=
 =?utf-8?B?ck9oK3lXMi8xazhsSm43OU5rZjZSSm9RT0MzVDI2NjlSOXBZNUl4VEFFcTA1?=
 =?utf-8?B?d2Y3dkhUZVBZRHN4ajJZamxLOUhhR3ZIbU1Td2xJT3NqM1l2NnhEcXB6Vmgw?=
 =?utf-8?B?L1JGcE44dFYxQW1DMGdSRGdGbEtERlU3NzVhRUVVdmd2eS9oWEhYcmdSdisz?=
 =?utf-8?B?Vk0rNVdRZW9IVkJRdCtHNWFNcnkvbU1YRVdiUXlaSmVXZFJvM2czWjcrU3ds?=
 =?utf-8?B?elpzay91alJjK2Z0cXZ0bDl1MjZId09WdllOUlhKQmxGd1A1c011ditIY1hi?=
 =?utf-8?B?N1N1L2w5b0pVSzRaSEQ1ckp6cEU0eHdENXRaa2xsNTlycHZmLzh2ZGNNREdZ?=
 =?utf-8?B?a2M5aHBXR2k5YmZZK3NtdUdrQld3V2N6SitNUE9RY1Nocnk2M1dRTUFJTmFu?=
 =?utf-8?B?NmtZMjcwcW9PbzBTV2MvOWRxbHFhb2J0ZTkyRFdwd041TmlhL3JOSHRkQi9x?=
 =?utf-8?B?MU9nK3V6eEVvQitZQTNmMzM3WWlaVmlOUlBFdkdVbXNiOXZ0clBZb1lQY2Ir?=
 =?utf-8?B?U2MzVTBhMjkvMk81ZVZ6d0RwaEpqYWZoOEFRTkY3SkhyWmp3MHkzZlIyZXVB?=
 =?utf-8?B?UWFqUG9ydFlyQUU1Q3MvZC9Ic0locVA1N2k3MitYT2kzKzh1MXpoUDBHNnli?=
 =?utf-8?B?M2Q1YUJMd09JaWxBaFVkRkZucEtKaWs0VHN6Z3pvY3pYMU9NU3M3VC8xV2Fa?=
 =?utf-8?B?MzczZE1uWm5jcmpxMml0YXNVaW9SY0liYXNGeXRqSkRzejdCRVA1TVFIZy85?=
 =?utf-8?B?UTBIN0JGUXk0VXd1c2JCQTQ5dnE5NUxQUFZ2eTdDc3J4VzI1WXpmMEpLNnR4?=
 =?utf-8?B?VXFkVkJPQWpaZm9OUjhNL0NnODlmTHRCb1hDYXdxaWpJWlg1TVBlN3NtWCta?=
 =?utf-8?B?YndNVTd2MDg0blhBV2tkY3BHUHpRcGxzRlVkdFAzVEJYZVVMSWc2WUhYK1Qv?=
 =?utf-8?B?S0lRRlRGUzY0cGlJYjFGRWZkamdZRjlJVnB3WHprVkZPZjJKVXR4ZTN2Q2pN?=
 =?utf-8?B?c0MyT2ZOL0JYQjcyZ0E5M2RjOXM2WnhQakNtNTZSem1jRHlLR21WbGw2V2FJ?=
 =?utf-8?B?eHNDMmlidkFyWFZCQXN4a29pYi9CYkFqRXhFNFNnOTBaRDBjeGFHSVRVZm1T?=
 =?utf-8?B?SmdvcTJWNTJRSjZsWUlPTkF2Q3lzUit1QWgzMUdhVkoyY1cxNVFSVHB4NnpW?=
 =?utf-8?B?ZDdXNmhxT3BPREM2UGNVRkR5YkFGSWQ2azdDanJkamU3QitQOTBKSkFqY0Ix?=
 =?utf-8?B?TjVYQjRVOC9Ka2JaVHpIWUFuOCtPNnhETTlPT1U3OEV4YlhkVUM4ZVJvZERT?=
 =?utf-8?B?QnArYlRsTlZOWjd5MnRFdVVtVHJHZkJtMUdyOEQ2U2FiMVpySy91c3hIbFdx?=
 =?utf-8?B?M3dTNTFoY2N6dDRqb1p1ZVRucFVVR2hXNnZmREFvc1YwYy9MY1lkTHJHQTJK?=
 =?utf-8?B?eGc3T3hGV0E0Qm9DRWVRTmlkUFI1Wkp2enFic01lK1FGck1JSGRTU1RMQ3Ey?=
 =?utf-8?B?SFhUVUhQcGw5dUdEU2xXYXJ1MlkvV2kvaVFrK0ZWYkVmTGFEOWNNN2N2R3gz?=
 =?utf-8?B?SERFRVV4bEJ4RzdybXVFaktSQk83MmJ2cDc4STBndUlzNWtFOEtRU3ZCUVV1?=
 =?utf-8?B?eG0vaisvWlZqSDRUVjFmSFY0d1phd1dISVdqRWt5ZU9aRG5HdnZkL1FSc25z?=
 =?utf-8?B?UlQwUUl6bEtHMDRxT1kvc1pKRVJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D6536776918CA469A9188BFFEEA757E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dAd+ULsBZF+MvBMhbL84eMKgw1I//0vUtqDivksoMfhlnK26Zc3llrO5XLHBlEHN5AwJmt177J76m105orIsVo3iXiBjAjP0ElwfQXF2ykkz5WCGVE0kWOQ32tENS4qt/RU7coCMpzk87kh1y50MY4HHQrcdv0D2CxNGjPQr/JXlRYXrRoc9NyqjMcbHESuDVmjO1k7y118ey2E4kpMLd6HEjKbCJ0M3i3W8lwirEj6Acz0eEzmXGUfGHLmRER4biJZh1uPhxhMJ/pDmsO2og2TwRAB9zKffrtNt4F0+v4LCKfm56fbt7HZHGa3gWPHeN6v0J3NFoJ7gDDQMb+Tp0flXKELQHiH0wn02rnhEjC4/0dSEYJiqLGSOeYFb87F7GSSiCR4pJjMV87Yg6+aMtpyHOO4XiJGw7PNq1aYzRAXPHJIY3OkMAiVPLZXXZNlrR20gw/2xksImQ7a8rAYS4sgld1Wd9t9xCNwotDNpCuIRDNEu4dXqIgqp7JOxXBFMJK0lPjbc9I/kEFURWxdqLOt/mOFEv40yF9MENMmiu0GyUF37QehZ8FwOw497hTLsAsdq+Y4GyRFsKC2wNSLGy4gWFHGR5W7KU8OdwAwJYrRSDr66PdgO+Xp8UkGbL0Zpsqn6bTM0VHgmiiJkVPqcyNNPLT1m9FylTJcDytl7F91MKF0PNcEp8YTnrKSTu+wuBGPl2TM3pI2oJP+EbGYib3JstPQ++mjF4PR5OJr0+2yXRQMjn6KVMqdM5dtKRfnG+LOdQHC79pC6RWQtjt5YdImuDe/9db73YycK2QParP5CI1kJgIqpwf6CxuCWwcHJa10S0q+m7mbF8fDVWZOArWUm7mwcF71xWbCYFjeV1ZA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f395180a-1a0c-4f3a-fe64-08dbf64bb290
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 11:08:38.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +E4Y1On+htJKTuEkv8njnGWMWaUy9dQZfDtI7ySEArtsaDr5Z32V0Sr6IgXZvjG+IhUkVb7Odrxq8zRuzg8kE0Yv25/Z7ljapTsAfQToPr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6510

T24gMDYuMTIuMjMgMTE6NTYsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gQ2hhbmdlcyBp
biB2NDoNCj4gLSBhZGQgX3JlcXVpcmVfYnRyZnNfbm9fY29tcHJlc3MgdG8gYWxsIHRlc3RzDQo+
IC0gYWRkIF9yZXF1aXJlX2J0cmZzX25vX25vZGF0YWNvdyBoZWxwZXIgYW5kIGFkZCB0byBidHJm
cy8zMDgNCj4gLSBhZGQgX3JlcXVpcmVfYnRyZnNfZmVhdHVyZSAiZnJlZV9zcGFjZV90cmVlIiB0
byBhbGwgdGVzdHMNCg0KU2hpdCB0aGlzIGRvZXNuJ3Qgd29yayBhcyBpbnRlbnRlZC4gX3JlcXVp
cmVfYnRyZnNfZmVhdHVyZSBjaGVja3MgdGhlIA0KZ2xvYmFsIGJ0cmZzIHN5c2ZzLiB2NSBpbmNv
bW1pbmcsIHNvcnJ5IGZvciB0aGUgbm9pc2UgOigNCg==

