Return-Path: <linux-btrfs+bounces-4342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460B8A81FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC1A283BDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE213C9BA;
	Wed, 17 Apr 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R+cW1C8v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T4QOjI8j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A750A6D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353063; cv=fail; b=tTmbjldZ/lH+z41cjV+qQmXNj7pcybQT35vvF/d8KFwmrF3OKU1E4mzvx2+vL6HdgNOiiL/f1xp0A2vWfCWslHecijww6UEMiLXhU817hSo3ZV63P2NJghSRe8Zv8j4M5+msHHO5oVp260uXXKWhhtN/h5e2KYYjka1ae8TF364=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353063; c=relaxed/simple;
	bh=buEHz/ugBk7eRBo6x7vphbqFJvFh8YeO/FoCXbiOQHs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aS8eV4blPPM+9G5avMPkxgHXeiQSle7ZXyoyhR4t3d8dvecT0ipzbtjzfE4yOzpnhgjqB6b6Mdy+oxUcJUGQeaSZLDlw1XPmhflBT2tdkVVbbWC2FVywkSgmjAW0ZdVAJQg7KduQ/yZWiTyt0rKPaDMO48pNxtxgiQ1euKSW+/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R+cW1C8v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=T4QOjI8j; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713353061; x=1744889061;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=buEHz/ugBk7eRBo6x7vphbqFJvFh8YeO/FoCXbiOQHs=;
  b=R+cW1C8vCt/Q0Fr4eOXQR5xPJAJrXw+xwS0/WqgWKUQeq+92a1GB9bCX
   CAu45PraPt5dul5cbT9RNK61HeeBOAXAeh+fAEkR9RXQWj0AoPfxc16lI
   Q5iX1Tp54/Ev2bdpF+sI5ux+5HpX5pyF3wX8UBtCnac7A+wOeAhzw0qsX
   WhmBECwcSmK3Lb86zf/k61BixUJm7UrYTI7XGHcjJAohmODBJ9b/XvIwP
   +1TMV8Oto4stF5VJuEMIAW7kzAoHmPB4Oieg9bZSH69cZRAHMXdDJagkm
   YmNOCVpuZse3/Hw9/yDV0415IWLatLIVIPOZksq3uG35mtcmjpKNPAfAx
   w==;
X-CSE-ConnectionGUID: 0elkoTzFSmW0Vw4ODaaulw==
X-CSE-MsgGUID: FN1RWYzKQwmQqjdJQlejcQ==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14216264"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:24:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBUGZFmdJmfa74nqFWnc9tQxzDdIxJOMEVyEZU+2Blxa1q04qmgC2Y5EVHp22gd/5o8pRhBbZYVBHJKANCnk3xkl2YKDoKRTGK8H+vFJpM3+SDFgEckyOGRJoOjJtUop+VySqTID4gq3yRUA9FSM0w6xsfJXOvpdn17TReKGaMG6ogBt3mzwiWoNIQGWYYMiz0oFG+TyU7SakVIoh96Mnk7FdENWWwZiq5pOqZWDzR3zBjkeIYSDLAtiVfVmZDDk6xi5XN1XD19iXxMBag6a5XRLNvr+My1YlUCSWoroxAI+X+PIMBDk4GQmDYqi6K2d8c1qB6j8RDG0zkxqsaFthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buEHz/ugBk7eRBo6x7vphbqFJvFh8YeO/FoCXbiOQHs=;
 b=IWBpLwJTBtvK7/BgQVNxaVu/5V8umGPJP4MkP9tDB9mfduzVab4gKs2XVori5w/2vPvbign1vZxUzzzxSbzvdxIEJznbHHPtAx/lpeo8B3lFvAQS9C4g+K2GmXB+f/KXoHchRiMNEOcyfYMLv3USlHzBABD7DdzeReetswN4Y2Vr7rx5etanR/XSbMa2jH0T1NeH693JubOXlk6qycD1+s9nUd9v0oQrvCRTJ8BsERZm8gXYDIN6GDTkiGEMdXOb4AbWmGQsYeRUWDraKw9Buj29Ad4zIm+qbMs9V7mgF6blfZehy/OsGZsy8FRv8dmtellmadCMIdStPk38TvNptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buEHz/ugBk7eRBo6x7vphbqFJvFh8YeO/FoCXbiOQHs=;
 b=T4QOjI8jELYPkdq6Gwgc7apir2OnRuZQVhU5G9yOy1CiufDM4oyaiHdzvHNEx2/qlxh9Tmjz+oggOza20XsrdKpUaTN/upalUdGa2biVt+2dfsiOvtHS04GUdXkdH0XQWoZdMWzxRAxnGWg++eIZyS3WDPJQ2FU/waYOizvM9f0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8107.namprd04.prod.outlook.com (2603:10b6:208:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 11:24:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:24:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/5] btrfs: remove i_size restriction at
 try_release_extent_mapping()
Thread-Topic: [PATCH 3/5] btrfs: remove i_size restriction at
 try_release_extent_mapping()
Thread-Index: AQHakLcn6HGk3pcncUSpNxOl8z1fZ7FsUfyA
Date: Wed, 17 Apr 2024 11:23:46 +0000
Message-ID: <244e2a22-dcd1-4a34-ac46-b184b1e2de54@wdc.com>
References: <cover.1713302470.git.fdmanana@suse.com>
 <c9c03b39687c2cc599725c508b354e40898d9844.1713302470.git.fdmanana@suse.com>
In-Reply-To:
 <c9c03b39687c2cc599725c508b354e40898d9844.1713302470.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8107:EE_
x-ms-office365-filtering-correlation-id: 1d7204b1-2ea7-4741-6d5f-08dc5ed0ebbc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NjeZpIGHJJGJYLCOQjtr6miwXRgOv0/ciVBrhN2nGXcieOGWEPmKfiekvanojrPOEDO5rVYKtWf74nG0Fej1I861oPfaCgbshljeB3gMidla3zJELc9M48RxdKLO/m6GpPPW5mNm0dtC4XNdkh291vl7YvOeWUR4t2Fldcv9621oAzvwuJzhzoJxH5LIjvnbYg9xMhVrERs0Rk1KRcfcuqxuuzCk7kevVGW1mk8OFs/EVp2sJpP9hOeTPQBlO/5Yb5qS1o9sg8F2TCUaOa9Gx9qTuBgKX9IBvoV82i2v0IFDlItp+On1aKQMwELE683G2gq6Z8HGUYqQQnkhWH4vZrHY75NiGGgCMbu4YGMtpbClFexIuKVlwM55jIslpeqYkCFcJZ4tE15uO2GdPZNV1/xMw7ZDOvuQlWxl44mw+BbuGuQWaKUoOOSPYUhbLdVanFJphkBac3Qr3pDD2paubF8z9iW+v0soSk/+WG8mM4eGjogWrX5oxRSitf0RMowe/23ht7dbg9qQPLhCxMMqNYogK99/851PeS4jOuo51dvG+0GLbFBVl31XLKuAUcCO+zdqFfr0yR99LHyUp35SpeVmt9LcIY8QXFRPuceSPSM5vQgglTPUTH9ZLB2AhPLo7q7ckSBK9tqCbJ/Y20HoNkdBlEHBuALldJEIy9H3jXoUYBq7ruQZgZbGZ3spPUJXK0F4Kme5MOcT9xXqyyjYE1qkpO7OfalwXqRO5g+uQpM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RklwVVZQdWdCY0hXK2JCb0tYQVhSTllaZ3VTWElWWGVCRWJTclhzSzdqTVpE?=
 =?utf-8?B?a0ZJakUyVlJUVVhKZ2FtcFVxcHU0NjkwK24xbGhLMEM4by83VUNTSVVBU0RV?=
 =?utf-8?B?QUkyWER2ZjRFWmJZUi80Wi95ZzZiY09ZdmdrUHVzWEorQ2t5ZEdHN0NZNDda?=
 =?utf-8?B?Vzl2YXpLZ2JlaElRN05ORTZJVjRJR2ZsdFlHVGRCQnc1OGx0N08vRFVMd3l1?=
 =?utf-8?B?L1lCbnl2c3lBZVJhOFhTNkdYeUZUbFBlK0J0dHpEWFYyZnFLRUk1dFdSZzhn?=
 =?utf-8?B?WkVRK09nQzYwMzlpeWpYRHpQVWhxMm14dWtKdGJCTFYwck95c0prb2RNQ1Vk?=
 =?utf-8?B?cEJFeTQ1QVk5c3kxTk1rdXpYYnpsUk1aSW84WkVWWU1PL1VzNFI4Z05sUjNZ?=
 =?utf-8?B?OG5qRDlUUDZlZ3gxRUF4RU5uekFyVUN5ak0zdGwzQUpsUXhzQjhpSHZQeEFh?=
 =?utf-8?B?clR2WGJ1cFJPb2NtMzg0MlZLTU9yRjU3TytnUkZEdm5IU1B5NjhKOUVaYjhm?=
 =?utf-8?B?d25EZytQRXo1Qk5iR213VWVFa05YUjlseS9vOFhSZHpTVXJoU1pKc3hDdVox?=
 =?utf-8?B?UGszeVBkT01oSnZWSWJaVzNWZzVaWlFEMmY1bnI1SkNseE5vNnhiMmlWcTdx?=
 =?utf-8?B?ZjJ6dEdTSXhWVjArc0NydGdvdXRyNkJKYXlVbGRWVjZJRTg0QktKM0JoRnZ5?=
 =?utf-8?B?ZTBKZGhwMGRVNjJpWTlLK1B3eHZxNGd1ZVJDNXdmSCtqR3gzMDg0QTIzM0RG?=
 =?utf-8?B?ZXF3OTJVN2VkNnZkdjBIS3pzMmYvZkJLa0pDaTExdU5zOGIvZnlJbnR0REo5?=
 =?utf-8?B?YXR6dlpPbmhhVkFGNHVDRnZKc1h5NHI0Q0lGMUI0SWxXOThYTDJuaEJ5RmN2?=
 =?utf-8?B?TTFSMUsvcjlUay9jWDY0WnRXOTVOT09nMHNqamUySzk4WHUwQXM4eFNjOFZY?=
 =?utf-8?B?UWVEY3hQQUMxcVdmcmZmZEZuMDcrNlhlejdmRDk4cHNKd0VlUlFMcFZkOEd6?=
 =?utf-8?B?NitXa0NlU3pjOExrVnl2UHRueTBzWnJPeE1SWng2czRPWXdmUjlBUnhaMThE?=
 =?utf-8?B?UkU0RWNLS05BVjNxcjNROGhHOFpxK3BQeDN0SjNsMUpKYlc0TFFRd0E2a3gr?=
 =?utf-8?B?N3k2dS9pRUl3Q2UyMEt3cXZGYXhvR0dtM1l6cGc2SjFDTG8yckNpOGJrekgw?=
 =?utf-8?B?OUpNclNIamdKNVVYeU9xazVhU3RYQ2ZhRG40YVhIYkRnTVdUQlI0MFcySU41?=
 =?utf-8?B?VVZmcjdYQUJINjNEVjBFRnREZWhFQnJiZ1J0VHBoVkJQWWgyMzI2UnlQdS9R?=
 =?utf-8?B?N1d4ZS9mdEVuN3grSDR0R1Uxa2RaR0FnNkpockVFNUl6aHR2djlDaXNxemhs?=
 =?utf-8?B?eUhOWENOR2ZzTmJwNHJvNlp6Skp4L2szR1pjYXd0NzNycXArdXNzVHh4MTlu?=
 =?utf-8?B?RzgrUk1NSFEyU3JmQlhjcTNFQTVHM0NWSnhXbEhxT0MrVmp5ODFPWWlheFRG?=
 =?utf-8?B?cGIxbG9JajlVeW44M0dZVGx3cU9FNGVQT0lCMDlTR1V1SU00WjBTOENDdWRQ?=
 =?utf-8?B?Y2JvMFh4RVlNN0lFVm5hZ1pTa3MyL2NYazBCcEJlUmVZUUZDcDV6TlUzVmhP?=
 =?utf-8?B?K1dFSklXREVwSCs0ZU5vV3Y3eWlnOVBYeU5BL0U3NklxN2IxWlZNc3BmRlh4?=
 =?utf-8?B?ZW9qSVlpV2xGU2NkSytaZU1GV1Nlc2RsRnYreTBFYTdsOWdGSUI4OUUzeVB4?=
 =?utf-8?B?Ylc2Z1NWVlBMZEdSWkU0RkthMU1TUkl4dk9IZ2tCb3NCU0pnT1dWQTRxcUZS?=
 =?utf-8?B?a2RZMmtUK0M2VmV6ZVpITVFZMjI2cHl6R0UzQWE2L3Q4MXhTZUh6bXY2OGlC?=
 =?utf-8?B?Q0pET09oeWwzZERqdXFMMjhSTytYMDl6VFVLelE5bm03cmRuaFFJZnZOaGta?=
 =?utf-8?B?ZnppUHVObDhtckxyOFFEeWl2aWtER2J3YncxN0duMmxtVURrOXdxdlp0T0RX?=
 =?utf-8?B?bDM1MEFmU2JYRlZtZUVKemFLWGsySWcvTHoxQ255VmNoSlg4TlJzcEV3VHFn?=
 =?utf-8?B?M2ExTjBDRmpjaXUwSTlnL0FCV0hraVdXZ0ZWU2MwUVc4eHRXWVhRZTV4NXlI?=
 =?utf-8?B?WnpjV2dYNEVVdHZxTERwNm1raTArK2NBRGd5bkJURmhZNnpRbWNFN0hkOUhp?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C9C7EAA8D96034497F8F9C390797B22@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eGrmUowt4e/R9LDK0JL8oRycKr7arw6ncg2n/b79Wfkvswlr+7zB3qNYHItqG5/j+khnRviyqvL3kWXwDloglxd4eCQWm+TyR8oMW+mbcNRwjuUueL0ySZiVwlWoWRzjj0r2OePVDj7p1fug8rPhNhvvRiGH1vGRyOOw9CHprtmXeMhCD61SFTem/p4ylg0SjyG11//QdrVe/bSZS+mG4hvw+qL2FtxVklNsMMjlHPq56Cbc3GUEfG6BqT3yNyoydA0RzL/YTar7gnj3wRpA//Tv2ELzS46kMT2i8Ph7rkVjczCBVAN2cz2Y1UqHDb6LT3ZspmhkkBuXuy4uUkPCA/9rfXlgELa2ksBH/gtY1euWfbzf0E7fnq429qfECweu3334OAjttlhyc46Gj0aC9hwSMWL6bZSmLfv8YvU8xQa07RBd3Qy93UrHHy1lgv15czD3TK5OnU6mQ1p1NAXw+0ABP6cYKW6dIrkF4SwtUclUkWkA7O5v65gPuTHvjdVoSNISxdJ8YLcf3Qt9bq05zCkH0TKfuWSA45e/u7C9U9On6+dFMdETkZ+D58NzIvrYZZqJ5mVSlW/TV5wBv7cg/7vcJVztqy5oLkyxtxNKlEqchhxvU/6UwTh9WcIZDhOd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7204b1-2ea7-4741-6d5f-08dc5ed0ebbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:23:46.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVzkCo67z5LRvtPbgJc5KBPfoXs95rZybXQ4TK5czlKVxCTgefc2cEbfg4EOotfv/ZlNuN3O5uiCklgC1qvq348QDH2dxmWzIkFEDsWElGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8107

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQoNCkkgd29uZGVyIGlmIHdlIHNob3VsZCBldmVudHVhbGx5IGJhY2twb3J0IHRoaXMgdG8g
c3RhYmxlLCBhcyBpdCBjb3VsZCANCm1pdGlnYXRlIE9PTSBzaXR1YXRpb25zIHcvbyB0aGUgZW0g
c2hyaW5rZXI/DQo=

