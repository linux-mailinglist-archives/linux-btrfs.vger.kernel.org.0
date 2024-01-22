Return-Path: <linux-btrfs+bounces-1599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C37836351
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 13:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAB41C228B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21193D0AA;
	Mon, 22 Jan 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FEKq6XAr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="POORpwP0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F83CF7D;
	Mon, 22 Jan 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926905; cv=fail; b=QeDvqEHroMOyKc6IB9CZHO74+hkzd9TgTlMKO8YzuW57OjO7DlQGyMSC7YgmnagNzHOXkJeq8jq6o7Fkg8SxRHuFeZ039DOshfx0Men2CusEL6CjkpSmns86Lfti8rC93VW4bkdQiNpIZI+j9/ZeGSf5l0GpWlqIeV4c4OplDiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926905; c=relaxed/simple;
	bh=G2oQOoF2cjMGVf07EQz6Eshw9lCucYXtfod3TqaDfRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U512jh6eH6+B+MPqnvc3F9oF5pxOnSWYiVNeCj2V7j2nnFgFcS14Po6FzQxGmUb0+nImLfRTB44WLxTy1/1oq4//p4pExU3XYnyABCXRQ54M9oVoJd6E4Nf1wjYPGO6+KwktqNLkqavMl6UUEV9YB60OnbpoaIUZu2I1lyoKZ7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FEKq6XAr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=POORpwP0; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705926903; x=1737462903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G2oQOoF2cjMGVf07EQz6Eshw9lCucYXtfod3TqaDfRc=;
  b=FEKq6XArk95m2alr5/DEgnGh6TPFBDZtzVmvRgTks8Ir+YiHjmaejCMU
   HhP5GnW8Y8n0qPzpssUvz05LGyy1BjldD5TA+xoBjgaLsQznDmQDaJVHZ
   jbVXHi9j8jB2VWFAhoNndzM6tEUVTPlPp0XxCAzlWg58CBa+16rmb9vbQ
   AiivHDHfP2bqHQVLA1b+YZmx1AQXQGYBhxG+U5MtBiY16H2BQI7nYg1Gu
   GRowf+5BX96GiYuQJiX8vlSoOx1BLAkeh3hW2yQUF7s/y6Y/2f3D3Rl2V
   hYbWKqtI8NJtlp5YNmhK64PdWmr+03uNMMQBzrJWu4Mff6oKMcBxtOYxU
   A==;
X-CSE-ConnectionGUID: 7sFc4+LXQqyBIYa6ZkGQMg==
X-CSE-MsgGUID: UukS9265SsCHkREJFWZ7Gw==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7432809"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 20:35:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBw4Tgae53TOY113aRPRRdNy+Qq3NFnEMJgx2u2VrdAusReVSJQwwVcY5YU1XWFZYAMULSRTLy49+WLnxLYLsA5FWTIXf9BrwN5hAYc3UyEBwwvJZLCENl0aCrwnepdmjQgrVtLXX5hxJXzqteCpK7wAbYeowFjLvrKWlqRWGKwktkbUyw0BZcuKCkNX16MKSBjP6KKIHpAWZcAGM4qudmzjyDEz8PlbWtIRtyrwRhH4idbXMHVtd+LeZktqZMm5KBgVQKgSlzdoOCVFlwO9AwtBQWWMtogXP2BC6aAXSBOmGdu6fHw36itN8wOENu7bTDlxpI5f30p4S89zxivcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2oQOoF2cjMGVf07EQz6Eshw9lCucYXtfod3TqaDfRc=;
 b=bAuevbb55/wo/+at/n+tOLFKTfcdYyGZVfVGUs7vscO2DPaIT0XsIAu8H4mmE8soAH6S3HFPDSqov+bD1FhTbPz2GiY/X9msZHXGCRM21mhGjAbHRERGYeS+x11cItZZIj7E/umx635zz05NmET8D0bMrJJRTOHhjtKFyDfnq9DnRnNz74kPvNxb7zhreh9sVxxg4GUp7Hi6bo8PhbjONEnGou2PnxlekDKk/oIJVkWM29kuwJa/6jfaG5d9dRMz+bZyVR9G3utBrI1DeGBNd+9RgCggUou+HwGreM5t/RJNa3RPvDN22Y0Bhb5HfjI25p+/j0WHlEzxTk3GCELi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2oQOoF2cjMGVf07EQz6Eshw9lCucYXtfod3TqaDfRc=;
 b=POORpwP0ksYFyA6FFZCLZWQtF9hRk3tnLJQZOwGsFvz7u5+eEcREQQH6FhSLeKBiydscx3xcfQP5aPooD9Ngdf/tEcDymq9L9gGTmT+p+RzArbHzf15woWnClxO4ebcvzDAGQLcxl1EEVOBsxVdYcYNOeKa91yFrFEcbpxP1Uxs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB9037.namprd04.prod.outlook.com (2603:10b6:610:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Mon, 22 Jan
 2024 12:34:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 12:34:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Disseldorp <ddiss@suse.de>
CC: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs/zoned: test premature ENOSPC because of reclaim
 being too slow
Thread-Topic: [PATCH] btrfs/zoned: test premature ENOSPC because of reclaim
 being too slow
Thread-Index: AQHaTSGWy3Cz7VS2A06C2bQhfxWLY7DlwfMAgAACmwA=
Date: Mon, 22 Jan 2024 12:34:58 +0000
Message-ID: <28bf1ad8-6272-4468-8ff2-6d748eaa3e2d@wdc.com>
References: <20240122105554.1077035-1-johannes.thumshirn@wdc.com>
 <20240122232538.2a2bbca1@echidna>
In-Reply-To: <20240122232538.2a2bbca1@echidna>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB9037:EE_
x-ms-office365-filtering-correlation-id: 3f943afe-6ab6-410f-6951-08dc1b468bbc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UPmYc7D8IHgpY36uqKtS5PC577vUncxwDJ1Ex46Bedd9Do7g8gAubEf3BCps0k0QrB15WfPtiagvWTUtipTRRQtbnSW7IySSuXXaLvrysxunMhU+kZQpi7Ri8IuaruNeUD2Y6uWI1C/6/dMblZKhXgtztgUkkmgLFbkvpfqJvaXVpZWGrA/0D1vmGJMJdRZT2fqRwculZvbuIe+ZHUlh8C264KPO9yIbTrlugzpV6S1Z3cS4DVoaBPu5DxCLhOxDhn4SEIyP9bMRHY9b5xnxonBYOaLHHTZPJ3GsMN/NV1S8cT+f01wMXZ2VY4mMZLV0pJLGpmW2INjyPlpTbDRCK0HnGJCnaCmWzpVJuWk5J+WVEk+0yfWkDvmGu+oLxpZUMIWF9Ldl/qmuyLnaSONLqbCC0F5puQc9rsDxMVTCpz4RPx83tmURXbmfzDDa/aFZWpKBOy/0mPCO2uSThLbuPi8OYec7BW4u/KzQDRn03tzsD/fDtm4p1nP3dKV8ExQKi9OdWMiBbwrLEAHL+ZaZa4Jo8/JbYyi8oizJHg4UBw8M4zj5vkdk20XjuJqUHJ7X65Z8lE+GobWl5wmzpLAp0jWV6uwuZM0SgCZCb1NksNMC+nfTIwkecYj8KIyxwDBBz1N86W+qm15CHP217xwWRK0ePnPsjBLqARldberOP9oTBPoBJnVxL8QbEUQAYKMT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(6512007)(26005)(2616005)(38100700002)(4326008)(122000001)(53546011)(66476007)(8676002)(5660300002)(8936002)(6916009)(66446008)(2906002)(478600001)(71200400001)(6506007)(6486002)(54906003)(64756008)(66556008)(76116006)(316002)(66946007)(91956017)(86362001)(41300700001)(82960400001)(36756003)(31696002)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXlJZldUUTA0d3BEeUNSQlpTa092MnAyYXloZjRHODJOWVZ5M1VCNkFlUXM0?=
 =?utf-8?B?K1dhSk9tcGhudmFXMWNxaHc4dTJTMlVGNmI0Rk1UWERFZHEwREZva21aVWhk?=
 =?utf-8?B?U1dVM0p5eUx6ZTY1VUphdjZSdW1SbFlJSW4xY1p3c2JrTVhjeW5RQm1ZdVAz?=
 =?utf-8?B?d08wSCtqSkU4WjZmSmVGc0lIOVkzakRDK3JPdkozclRGSXdpenBJRWYwNWdM?=
 =?utf-8?B?VnNBWG9raXRJQlR1SFRvMGg4TGZZeGdpcmE1NEpORDkrUnRBWGtNN25QR05R?=
 =?utf-8?B?NnRVenNCQlQ4aWorL3p3bWtJUlRJbzZGNDRIQ0JwSXVyMzVYN1M0d2FrdnNu?=
 =?utf-8?B?TDVqY1FkWTh6M0dqUDRvUUtQWjU2T0s2dnRwWGszaHFlbWJmWEtXT0xlZVBE?=
 =?utf-8?B?eExpMDVQaVdGbUJSQzVhSlpKdEJLUXV6bzhuazVpRWNXc1o0Ym5BTGtGZE5J?=
 =?utf-8?B?ekp5dlp3VmEyYkQ0aTZ3OFJXZDRKVGJSU2VUME03cDZuVWMwQmUrWFl2ai9F?=
 =?utf-8?B?OFdiRmRpQVlXaSt4L2R5WWlJOUVWbTNucndjRlh0RWlJeW5jeDN2M1NwM3N0?=
 =?utf-8?B?OTYzNTZmcXphN2ZxbDhqUmZRaVlwaWQ1OVFyZ3ZJVnR2cGRPV3Q5S3hCNXIw?=
 =?utf-8?B?SzdoMlJjb1RjSHI1VEtrTmlUYkFQUmxxZ1ZNUmVNMWF5TWZ5TFJSZHpSKzJ1?=
 =?utf-8?B?bHZ3aTMrcjUvMEUzWU9HNkVVR2tLSW1pb0tWMzVhRER6S04rT01XM1Z6MmY0?=
 =?utf-8?B?UmRLRXA3dDczVWEraHpodVlGdGZITmRWM2JHZ041cXkzVUFFeXZValhzYkxi?=
 =?utf-8?B?bDZlUy9HemxlS0g1M0JveW81bUI1TFR1c1pkOUVVZzFGK3pzbjdHaGN4RFhi?=
 =?utf-8?B?aEM2MnB3c0dSZTR0dEM3ZGtBMmJVZk10MmoyUXpDN05PTU02aUs4dzNIUnAr?=
 =?utf-8?B?U2l3QXZ0VEdzWFhyUUpDTWVqNG5iVXVudkhpVUZya2lnS3RrcG9jTjNQMnJn?=
 =?utf-8?B?K3A2bngxdG94TENhalFId0N0eXBYN09hRjRFeUd0RXgwOHRJVmJEbHFBSVBr?=
 =?utf-8?B?aGY4bFZnbjZFejZRSHNWM3pQY3lrNXBvUkpxZHFtcmE1Si9RYXMrNGgwdVly?=
 =?utf-8?B?REh0VmNyZkZMOWVqcG5rS3BDTERTY3JxbUJlbmg4ZGZ5RVowSXJoS1VmM1Yx?=
 =?utf-8?B?bjAxVUVtN0ZIM0xYSWM3SGxHbkVIdDNBd21mczFyZGd0YUtuOFFydTVYR0VL?=
 =?utf-8?B?c015d043Vk90L3Q2czhVWTkxZWxaYi9EU0IwUkI5M1ZjWTI1REFtN1E0Y2pu?=
 =?utf-8?B?NkM0MXlVSG9zWnVBRU9EK0RvaDhZM25HcFpzMXlqNTJoZUMxK3RMUTdBUWdW?=
 =?utf-8?B?cS91a2MzZWpkYmVtMzNoSjE4NXRvQ3JPNjhSL3NETlNLZFRWWG4wV25XeG1v?=
 =?utf-8?B?OFFVeG5PRmdSWHlmaXE4VmdPNmdPR1FOdWx3eHA0OFpXeWtxSldxc3IrZlNq?=
 =?utf-8?B?aHFRUGN2ejhjak1yKzArU0lZdnljTlU4TjFpbzU4NDNoQXhlUEp2U3lLYVpm?=
 =?utf-8?B?WnFxOG1yZVVnYUg0NytZNm02Yk1ETmFLQUJiQitjaUVKeFFObXFwbmVGQzdW?=
 =?utf-8?B?SUhmUWdpc0JqaXdQSk42eXJaTWh6dWVYazQwZ0k3TzBMcGZ0dEZkbHprWHZN?=
 =?utf-8?B?bGYvYi9vQkwrZlp4Z3YrR2dOdDZVaCtzbktzTEMzM3dXRUNHSWxva0gwcHBF?=
 =?utf-8?B?aWZESGJyUVA4NjcwLzVSOFBqTytjUnEyTXhiVE1tNlBBR3BQRGk5VzAwVW5E?=
 =?utf-8?B?eFZIeHRPcENPemhiejNkc25xbDRRUUhmTUhNNjQyRkNTMjVkOWZNSlhrZHlL?=
 =?utf-8?B?NmhDV3dlbVladVlYNG9sODJXTXk2bklDZk9jUGJINkxQc1FtVUFkdG9VekZq?=
 =?utf-8?B?My9Ec3NSaFZHU3pXUjJrb203WUdxSGVzNER6Z3N5NmtRUlh6cEQzUlpFNVhn?=
 =?utf-8?B?TkdSQVlZMFc3QTRVU09PYmpEU2RGTU9vTmtHYzNHVllCdFFQQ3JncFJlaUg5?=
 =?utf-8?B?Z1FUdFA2TUdycmszenlBUUsvQ1JFTURHL1g1ZkUyaFhPaExQR1BPYnE2UVJm?=
 =?utf-8?B?c3dLYkhjcjduZHdsdnpzQ0lRSkJDUTl0MUdVSWE2YWRUQ0NOTjhTeThUR3I1?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F2B0A86DA7BA74182241E86BD5DE5DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RRPzh39ZSYiLJEmbfAFuSkIojbBwgzw9/9CyucWKhg+WMom08ZCFba14a6Ddkd9gGduYxIR4UEDCywttvYmItI+uPpR/VhAcdil1RX9IbEg877Uxrf9Xs9n3cLrSNrntlfwgJvcClzkjFUnooYqMSA5fYHcUmUWdtLOe8TR5auO5fMd1R1COR9ZD6sAMbINCleNPAVZnDfBQjvb/35ws0ClByZict9kYKL1shKi0Mqpz5gyF6zELYZ/rz/7/ZrngX4MYQRbdixIPPpjgiJ1MR8qAvzgoLasC/Ej6OOktfpQcaUbYUwL1oIUBy+FqKYFB6FsQpAuiXrfE4CSf3ix3FODFg2g/rWE30WoUuw9+Oe+DO9iiT8WCOqPxuFjp5lVbZ4OBB+IWnijUi53/gNoB8cl8670Ny9rZz5B8wFcvcPbVWEKQBJEl5u5EhWZ5K8F1rVh64aLRp/b6yrgFByHz807wdaE7aVaPqs5A1sUMtKDwBSBvVYKnvYkUqKRPX/eTfz+SmC6sdY1IATRhoKQF/jbtpD9WNVggRuYmeka5EEgh6+YT0D9KW9uAg9M9troQ/jO5sGcL5mpJSYQe7pA2eXqEOvnjtVQd3FtObSufeXbahKuHq1klpSiN8IJ/ac9B
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f943afe-6ab6-410f-6951-08dc1b468bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 12:34:58.5776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FBKoFQnbRHOatLSrWXbmOBew6mc2glyfc+9gjQoRzlEd16r2xz6h4g7buGK35MwRTjbqSvwvULEtvO+T1Aqa0HLRaEcQNn6ylzLoSI4McA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB9037

T24gMjIuMDEuMjQgMTM6MjYsIERhdmlkIERpc3NlbGRvcnAgd3JvdGU6DQo+PiArIyBUaGlzIGlz
c3VlIGlzIGZpeGVkIGJ5IHRoZSBmb2xsb3dpbmcga2VybmVsIHBhdGNoOg0KPj4gKyMgICAgYnRy
ZnM6IHpvbmVkOiB3YWtlIHVwIGNsZWFuZXIgc29vbmVyIGlmIG5lZWRlZA0KPiANCj4gVG8tYmUt
cXVldWVkIGZpeGVzIGFyZSBvZnRlbiBmbGFnZ2VkIGluIHRoZSB0ZXN0IHZpYToNCj4gX2ZpeGVk
X2J5X2tlcm5lbF9jb21taXQgWFhYWFhYWFhYWFhYIFwNCj4gCSJidHJmczogem9uZWQ6IHdha2Ug
dXAgY2xlYW5lciBzb29uZXIgaWYgbmVlZGVkIg0KDQpPSyB3aWxsIHVwZGF0ZS4NCg0KPiANCj4+
ICsNCj4+ICsuIC4vY29tbW9uL3ByZWFtYmxlDQo+PiArX2JlZ2luX2ZzdGVzdCBhdXRvIGVub3Nw
YyBydyB6b25lDQo+PiArDQo+PiArIyByZWFsIFFBIHRlc3Qgc3RhcnRzIGhlcmUNCj4+ICsNCj4+
ICtfc3VwcG9ydGVkX2ZzIGJ0cmZzDQo+IA0KPiBJIGRvbid0IHNlZSBhbnl0aGluZyBidHJmcyBz
cGVjaWZpYyBoZXJlLCBhc2lkZSBmcm9tIHRoZSBhY3R1YWwgYnVnDQo+IGJlaW5nIHRyaWdnZXJl
ZC4NCj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBtb3ZlIHRoaXMgdG8gZ2VuZXJpYywgb3Igd291
bGQgdGhhdCBiZSBhIHdhc3RlIG9mDQo+IGN5Y2xlcyBmb3Igbm9uLXpvbmUgZW52cz8NCg0KT2Yg
Y2F1c2UgaXQgY291bGQsIEknbSBub3Qgc3VyZSBob3cgYmVuZWZpY2lhbCB0aGlzIGlzIHRvIG90
aGVyIEZTZXMgDQp0aG91Z2guIFRCSCBJJ20gbm90IGF3YXJlIG9mIGFueSBnZW5lcmljIHRlc3Qg
dGhhdCBzcGVjaWZpY2FsbHkgdGFyZ2V0cyANCmlzc3VlcyByZWxhdGVkIHRvIHpvbmVkIGRldmlj
ZXMsIHdoaWNoIGRvZXNuJ3QgbWVhbiB0aGF0IGl0IHNob3VsZG4ndC4NCg0KSSdtIHRvdGFsbHkg
ZmluZSBlaXRoZXIgd2F5Lg0KDQo+PiArX3JlcXVpcmVfc2NyYXRjaA0KPj4gK19yZXF1aXJlX3pv
bmVkX2RldmljZSAiJFNDUkFUQ0hfREVWIg0KPj4gKw0KPj4gK2RldnNpemU9JChjYXQgL3N5cy9i
bG9jay8kKF9zaG9ydF9kZXYgJFNDUkFUQ0hfREVWKS9zaXplKQ0KPj4gK2RldnNpemU9JChleHBy
ICRkZXZzaXplIFwqIDUxMikNCj4+ICtmaWxlc2l6ZT0kKGV4cHIgJGRldnNpemUgXCogNjAgLyAx
MDApDQo+PiArDQo+PiArZmlvX2NvbmZpZz0kdG1wLmZpbw0KPj4gKw0KPj4gKyMgT3ZlcnJpZGUg
dGhlIGRlZmF1bHQgY2xlYW51cCBmdW5jdGlvbi4NCj4+ICtfY2xlYW51cCgpDQo+PiArew0KPj4g
KwlybSAtZiAkdG1wLioNCj4+ICt9DQo+IA0KPiBuaXQ6IGxvb2tzIGxpa2UgdGhlcmUncyBubyBu
ZWVkIHRvIG92ZXJyaWRlIHRoZSBkZWZhdWx0IGNsZWFudXAuDQoNCk9vcHMuDQoNCg==

