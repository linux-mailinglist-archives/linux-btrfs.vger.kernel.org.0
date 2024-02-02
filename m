Return-Path: <linux-btrfs+bounces-2060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA21846F0B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135D5B290B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3281B13DB9F;
	Fri,  2 Feb 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kE1Mg5Gd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JpAOUeLn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F48004D
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873659; cv=fail; b=fFEetIuXwZpR1KGMT3AetOG8dafcAWjCKHp+ePMMyvPWbsQBxZuZRE4JHA0dnXp/L/h7P3s49HxwzqMssEpOVPMUrG3PcNWzfPuXQRPsh6OtszaSIoq7cyASalmWG3gDYXnHLUUJDnKaKez24YCt2fLiaZjZJePNqpw2ypa+TjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873659; c=relaxed/simple;
	bh=fX3hrXXuWcMULiw236AIzy96Z9ip9Eoi5OYFA2AqqQg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UidHrcYO9rN+g6SS1524E0uZqtBHjLaoQImcSJKyHjw2RbbeNBQRx+QB0kkD1lz7hOW0f73yn0+yd0QjbEQotWffuE7CiXdKjLBgkSFZEi/qrgCsVovM+rcDijGemqG9R2oG/1HGWiuzGY22out1WjYYwIywJ1TuEzxzCwx+CbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kE1Mg5Gd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JpAOUeLn; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706873656; x=1738409656;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=fX3hrXXuWcMULiw236AIzy96Z9ip9Eoi5OYFA2AqqQg=;
  b=kE1Mg5GdIkF6n1gpIJJjURf2wvzufX+Wokj+sbrEYpYrFw1jbPCZE3QW
   DJp9e5xiRhyglQ+vfp63RpoO/MMbY6G8iD7iiQhETePqcTqV8ApehT9P9
   WrNGKmc1Owrw7QGFVgGIPgiBERXoK6Rf71HjgzUEFNZUn6zct9lIwlmSa
   3Hws8HZqZf/7HmAXMsS00G8yYva9wbs2L6QOgPoeDgjXwqNh/XgP3TDzh
   H6aCGHq7UFIjaNJCYuvQkVF1gBtIRGmZnKwOtf7To2g/2CeOk9cVcdIgW
   ZPdQ0JX0v3AVk7Mbw4pxNl+GpqPE0NtUqfT4heuIXzTqi29RXNQtxsg4q
   g==;
X-CSE-ConnectionGUID: UmSKL7UCTtK3amXdSy0MUg==
X-CSE-MsgGUID: kBGxFw/URdaFvLZJhadcCA==
X-IronPort-AV: E=Sophos;i="6.05,238,1701100800"; 
   d="scan'208";a="8407573"
Received: from mail-westusazlp17011010.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.10])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2024 19:34:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZkj/Nwq6WZhTtGH93Ge6HwrxbhqfJeuTUFKxP5REv6PaF6+Q7JK6OGWsvDNgDg0tEbp4+A3LpVnZx3+YH84AD3rIGAgKGrHgjti/iNtvpgeY4QPrBfqsPZlxZoybKGq03tVbSQAP6zfxuA63c6iFmdu+yHw0tbzMgCDGthyVIrJWCz0SDybt6RU7oeGL4yi9N22bSBrYM3/TxaP+Q+5vK+O7cJ0D0x+AdZLR+jsbBSRN9gMsksZip4dW6NXVcRK47x9eTkJhoD0dkVWaAWWFzBo5Outp7vJctmHJaGl8qNDa5MBt8CN7MCe15yAV901aS+sdJgdP5991w65mXu8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX3hrXXuWcMULiw236AIzy96Z9ip9Eoi5OYFA2AqqQg=;
 b=lxtH/psx3/maC7mynK9NHhRU0LBrsd8648it7klRsx8dV2m9HibrjSAphX7MQgi0w9KochIeXwFZU5NX6yBxfoIkQ31ZM6ryFVbUuJwrzQ1UDWEBS5SlN/3ko5HFHBhiClowICl31Mgl8bAoVaU0qW+r+CgWvhHBtFhLR+LoYSmc/fuhpOcbI7naTZRUvRJuuKPahu0/UcBn+7ZPbQsu72EUrVbkdJdLbaMFNgrGvU0N8O248iSDIxrECQJEY09Lzlqy/JPh4CK1Sb3sNiQZWssjY5+MnQY6OvPPCqLW5VHTeWLlLtJbCKsCItHSoZxba8/jIfUVSOE0vYbVS0y8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX3hrXXuWcMULiw236AIzy96Z9ip9Eoi5OYFA2AqqQg=;
 b=JpAOUeLnHK3hehEA8UjN2gR2Qzsm+eKmNmOFWfT6iTzoTsSGahw7EoVE8XqEpVORAK2tRyG9OSY3LPkGhDf8FegjiYZnB5Y6aDHUx+m//6a4Thl4KHzajJmls5l/aYP3znD4uKNyC6BhqiN0O20UkYLN9rXbQi0fGiPKA9iEtJw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 11:34:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:34:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Thread-Topic: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Thread-Index: AQHaVTmg407G8UXRYk2sdBaMMp3LBLD27QCA
Date: Fri, 2 Feb 2024 11:34:06 +0000
Message-ID: <9eab4581-ee07-4e03-a0df-635ae4f30716@wdc.com>
References: <cover.1706810422.git.dsterba@suse.com>
 <e25d9d750e5a753c5341d11356649f89f00a260d.1706810422.git.dsterba@suse.com>
In-Reply-To:
 <e25d9d750e5a753c5341d11356649f89f00a260d.1706810422.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6900:EE_
x-ms-office365-filtering-correlation-id: 0eefb4c8-4f93-4fcf-92a9-08dc23e2dd3f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 64HXNkcbSeeLssgni/xk2wc0+EQQ4Nlki1Bl+s68rz5Gea8Ntr/AusvG/4E8YR3CUoIhsVxgb8ViOd9RWLTtANRqKx623HI0io8lFhO2Xlof0VWI+mAS3O2sBsGEaGgk+5OQyfB+/dA0BjR6d8e/WHlj4RfLBKzmEM9RJ37C1vOFkOxgElpNnkKriXH0pv2H1IJk0vvD76tVCMmySa0AnWi7p6IaGOzif3iiM88G4MkRtdDC43lvDIABv0WoqtH+s6fxG/QmJRSUTpEODkevVuo+WnOqHNPPBpUGvUHxdWgcglOeeclW2sxSSurerjjwS2iJDlRfZoXk7YfHt0BhUxnXLn15zDcSoVdxk58p4ASeRUqZuQL3zkpHRadhtA3aQ2JsTTEr47jmFGzQeDz6pgAhauKBADafYQEGMRf8fPKWGfEON+iePKgFw5PXk+8vqQP+Vcmx4VhsFqXBSCyL5nPyQa2KhCUCgEMfRrwXYdvjEBiNfT+/l5P72CRkUkXOUaFHtRvucpjJ2xe2pP9hiWnFgSAZQNN3Zol3P8kDihoU0BZqFdOI8tDNmhGAixALz96OvVqSGs3llgi/xcP8SdT0ESm49rG5Kc7yQaCY8OKQUPY9ZJ0DigBboDD0YFaMUfw0jBaKsK4JntmU9/S7o96nctLG7ucx5mWU+BZ20aowEbvcbSyzUt3gMACD0wWI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(6512007)(122000001)(2616005)(478600001)(8936002)(66476007)(6486002)(8676002)(71200400001)(91956017)(2906002)(4744005)(5660300002)(6506007)(66446008)(53546011)(64756008)(316002)(110136005)(76116006)(66946007)(66556008)(38070700009)(36756003)(82960400001)(86362001)(31696002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0RrWVJ3WUQ5S1o4d3QyZnNWV240blpXWWFjYnJ2S0lWS3dBdmlSVENMNjYz?=
 =?utf-8?B?UFVuWE1hVE1oOWMrZG16cXhCSVovY2dDNHllb2xRYXZWMmd0YUorVTVmdllV?=
 =?utf-8?B?UGF3ak9keUVzbnluSE4vVEYrOGMwRFhQcVZrbExnOXZvcWdmRmR0ZXBkRFhh?=
 =?utf-8?B?Y2Q5WldidGpkRDltMDNrNmRqaW5UOTJBeStOcDZjK0llWTVGYXZnUkx6OXY4?=
 =?utf-8?B?N0FMWDNtd0RsMktRRDB3NXpBMGo4OTRtN05HNlpyT3J0VjhkOS96K2ppcGlq?=
 =?utf-8?B?a2s0TmJ1VExIQXVCSUhEY3R3dUtwc1ZVdGVWOHdPN2UxRE5wNkZTSGVUcTk1?=
 =?utf-8?B?QlRvRmdNdTFEQm1WN283TTFaK29EOGNrdnplYk53a0hNZGZjN3JQRHVBQm9q?=
 =?utf-8?B?Lyt1YS9XbDVCcmVFZWZXa0EzR0h5UXMyZWpiS2Q0ZCtXUTlFa0pDUTc0ZXFT?=
 =?utf-8?B?aFNQUDdiQ0NRVURzU05vSlkvQzMrYVZ3YTFGb3MvWjZWUk8zL3gwZW1hVXMx?=
 =?utf-8?B?R1ovY0xNOUxEZkk0WWx3bG00NGFrUjBxZzgxNzdRc0RNNnRDbU1Sb2ROVVY3?=
 =?utf-8?B?amVwTi9FT1hGMlVUNkJzelIvdmw1aUx2ajAzTE9tOTZYWFNTQjhjaGpLaWto?=
 =?utf-8?B?aG1FTHRZWUwvb1pYbC8zWlV2Nm1VVGwzZzZ5aDM4Um1BdElwQlJLMEZycVBs?=
 =?utf-8?B?RFg2UGdGZmo2WFN6MTVoQVhFL0cvaXNsaitFQm10cHpXQXU0eVpmeGNMamFn?=
 =?utf-8?B?WmxVMUE5L05IZVhhMVJPWlB1K2NFdm92T1hiTzVLdjZCbjFnYm1WbUdGV2E3?=
 =?utf-8?B?RG55ZnYzdjUwRW9ONGlSTTJPRHp3amhUK0UxRENUUWM5NVZCSzFRbWlIdjBG?=
 =?utf-8?B?UFVOVy9pd2ZMYXRHQnRPSzA0N2RlM1lFaW9OZzNvbFdQdTd0am9waXNSbk83?=
 =?utf-8?B?WEJTUDdSaGhJUm5kdXZJVGluZ29uVC9pclF5NVB6UDRnWXFaU2FEWFlvRHh5?=
 =?utf-8?B?OXA0WnRYTlNMTVpuVTQ4VVhMdkpiUjVVVnlXN0VlN0NSME1XeGp1Mzd6Mk40?=
 =?utf-8?B?bXVkUTJTZ0U2dlpjaXN6SHFCcjd4TWdhK0VONXZsSDNqUXNhak10SzlHMDEw?=
 =?utf-8?B?c3lzbnhlWE1kblduQ1p3dGlhdjRGM2d4Z3ljczErTE5Xd1pDd3VnYnJjWDJl?=
 =?utf-8?B?Qk83SHE5bzY2dDlqTGJES25pd0RObmNEdmVHNERyZkRTQTQ0MjFQNFlMcUlG?=
 =?utf-8?B?MUhxaWRCTTZkUW93N0R4Q0Q5Vnlmb1BBNjVNWlc3MytZLzUyeXJ0QUZHb2xy?=
 =?utf-8?B?Tm1ROHczaDBRcWJRYVd5NUZiR2hmYkJwcjg1OUJXeFRGTnNxbGlKbUxIVjlX?=
 =?utf-8?B?ZTNlRzBEdUpSbDhRNUl4ZWZCVndoOWlIRU9haklsemNSMWw3aVFJZzRwMnhv?=
 =?utf-8?B?aktVcC9yRlNFbzNHcmlINDkyNnZRbzQ2YnBxTW5vakppNC95RFJWM2tuTDht?=
 =?utf-8?B?NHM5Y1plN2hKK0twSm10emVleVJoenBVNXBVOUp2Q3VITzh5MkpXWno5RUg1?=
 =?utf-8?B?RTZ0c0lMU25iNU5OekNrNEtwZUUxdHlSUmlObUI0NWhlckw4RXZiTWN0ZFEz?=
 =?utf-8?B?dUxYTDVQYksxQTl4c3hPdmhtUXpzdnEwWEZiWUlqdFNCSlY2c1pSTmp1YmVC?=
 =?utf-8?B?WTVlRm00eCtmK05hTHBxK2FuT1Q4V3hzMUY4dUVZQ0xzMFY5c1E4V2ZkQUFt?=
 =?utf-8?B?RkxLb2NXSDdVK0JlUmE4cmZURWt2V29EWGZFMHl3dGhKVExtS3JsM2hrRlVn?=
 =?utf-8?B?bFdtN0hKZGpGNEVJT29Oam1NTXhrSjlaTkp5US8xL29NUzdsbG5HdGtSLzY0?=
 =?utf-8?B?dGcyaVJ4SDdtTzkxZldoU1VwU1pOc3pyMExyQ0hyY0Y4T0FPYUlPd05MUFFE?=
 =?utf-8?B?MitHSnVCaGEya2ZyNjU4bUxkaGxGdFRrUmJNTHpSa1VleGF0Z1lXRkpuaWNh?=
 =?utf-8?B?eEZuS1g2RXhtS2xkOVFOYWRubUNoQ0UxbW5OaWVSYnczQkxEVTdpNWN4SjF0?=
 =?utf-8?B?MkZxVlh3V0RpN0huSUFNUHNQK1hFMzJTZHpmcndVSUppNWJFVHNzMndJU3Zq?=
 =?utf-8?B?OEpzb2xOcnhEK3RxK1o5TjlLMnkrSXRDMXpaT090b0t1MWRxRSs4alNLaThD?=
 =?utf-8?B?NENIQVI5MTh1WWk2elg4a2trdU1XREZ5WE94YlFIbHBpWmZZYlJXRHI0cFhn?=
 =?utf-8?B?Z0xNdTJ0cGFvMlVjcm04R0xkRUF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB357E5F07AC6F48B82E20B66A0D7343@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qE9U8JsFXwBnW6NdcfnX4H5fwsjA+cGuhMOfJRvRW+S2oxQX9nR6l8QfhSlt+9MlywkPZS/okCEUTlnTf8QR8N2ymz8aw57nW8RmAXFtG4oRclo7vA6Gw8chCb7/FUQHfDDQrqqnC5huVzjlDrlart0YlH++VZG91IASt1HcmGt+pPh6WXcjpDcMvtxAM9pfc/4yWKDp4cduFP+bwIcH6Z/EQfIe16/uBNJYZLElHpOj3QNtoj0yhSaBkiUSXQjbAXWJbJtEtCARD4paT6807tRlPODuQlq45OPAwdThlz+0xgPih6uMqv+d8lTsJjvlhw2NNVhcMviu5wAWkaCSEj/mpT4hbI9m1DrSRo0wq/pY/K8tf1dV9L2OW4nQP/zOX7iLWqSnSgn8tMzEKnlUEbE9VnSWNrwXNl+CKgTedRzNRzSTpA/TQ1I4AHVwyPs5Hzmn2NxcIU1ObSz4VyuQ1UAl0sGU6j17p+F+sy4mL/pA4G+FFNyHs/CI8Uz+RTQrE5zYxFyYu8nptcLjg6VVjD5kh2iaGegJzbfoHzJIO/wqdSx6cyIxIL5c2UySu3WQ58A3FoLxloMA4CyV/DMjrT1buGiadyOHDRqIRXoF/7W8mrwjR76QkJ/WowSPRfzO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eefb4c8-4f93-4fcf-92a9-08dc23e2dd3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 11:34:06.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tn4iPcHQWUlNnATClYGIYvjfQEF/d2Yby3Ks4JGD0x5IkdMxd530CcABd4fQCiiKL1fO1JVz6g0sbfjha2qVb2qbvmElDaJxC/c5sho44I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6900

T24gMDEuMDIuMjQgMTk6MDgsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL2ZzLmggYi9mcy9idHJmcy9mcy5oDQo+IGluZGV4IGNlMWJmZDk5MzhiMS4uYThiM2E4
ODI4MTYyIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9mcy5oDQo+ICsrKyBiL2ZzL2J0cmZzL2Zz
LmgNCj4gQEAgLTgzNiw2ICs4MzYsOSBAQCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyB7DQo+ICAgI2Rl
ZmluZSBwYWdlX3RvX2ZzX2luZm8oX3BhZ2UpCSAocGFnZV90b19pbm9kZShfcGFnZSktPnJvb3Qt
PmZzX2luZm8pDQo+ICAgI2RlZmluZSBmb2xpb190b19mc19pbmZvKF9mb2xpbykgKGZvbGlvX3Rv
X2lub2RlKF9mb2xpbyktPnJvb3QtPmZzX2luZm8pDQo+ICAgDQo+ICsjZGVmaW5lIGlub2RlX3Rv
X2ZzX2luZm8oX2lub2RlKSAoQlRSRlNfSShfR2VuZXJpYygoX2lub2RlKSwJCQlcDQo+ICsJCQkJ
CSAgIHN0cnVjdCBpbm9kZSAqOiAoX2lub2RlKSkpLT5yb290LT5mc19pbmZvKQ0KDQpEaWRuJ3Qg
dGhhdCB0cmlwIG92ZXIgYSBOVUxMLXBvaW50ZXIgaW4gdGhlIGxhc3QgaXRlcmF0aW9uPw0K

