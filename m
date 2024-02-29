Return-Path: <linux-btrfs+bounces-2924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5886C9D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 14:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B784C1C20D90
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B87E107;
	Thu, 29 Feb 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DWQe1NqH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OV2MqfVn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817386F52A
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212227; cv=fail; b=S2s+LaeywKEbGkPCLIKAVBoNRYS0+RV2BZMRvMxru0qzHzFgXv5QsnYhoJ4zDpdLCZ9Kb5SxDwdOx9FSSlAB7B5SHjs8lv8dSqQYeM4m93XXN77anALZxFmGtnshrl79Am8b+aGXOlE3BJVyQ9qJFhNrndBPzt58dWqAJWvplwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212227; c=relaxed/simple;
	bh=aNQlyABP43ACTQ9fFAT9xZp/ER51uA4F3pc3x7fdvj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pdly6gE6y7fyCnPksb6kj70pLuVoe/sBpxex1pYFvppDjl1gcmwaDFgGCtYOwpNe7w/ss3SwaB9Z8VdLRfsK6cpeRS//H5u7E2Gq5xlnS0gR+kQDGIrSIqF0Roof2XSavQatqVwQMPimJFF0ax96bRmI0tuRfbfk5m7Daq2gQkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DWQe1NqH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OV2MqfVn; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709212225; x=1740748225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aNQlyABP43ACTQ9fFAT9xZp/ER51uA4F3pc3x7fdvj0=;
  b=DWQe1NqHzo0k5DHGBI5NkyAtXRmqeTijAERqaoEkuuFSrQrTwasTifkn
   3C+1IldWPN9CQ8nljC9ZqCfrNuIn0GM2t+S7nGysRNAQRPXQ+FrCN0bXq
   XQHxDA490ID3V0fXOIZFTXpLQoDdsnZasNAbkbQQ83kb13F03jBSuItez
   ampsfB2gyjWyrZqvNV0IwYsXusejosLbdJbGM0veBFF0htsXNG+LTcsBr
   yooIaP2N9pcCWcmCDTLQp+luX042Y44svofcbxmArhAJarAp/u47RY0N6
   iH6Rt8r4aqgDFnw2P1ii8rUfv+kGnkLyuQ1fW+wITODITzpiX1ASK2adG
   w==;
X-CSE-ConnectionGUID: 5Dc9dUfCSnSVRAGQoPsBEw==
X-CSE-MsgGUID: 877oR5b1R0GjRVRFoyfZCg==
X-IronPort-AV: E=Sophos;i="6.06,194,1705334400"; 
   d="scan'208";a="10490744"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Feb 2024 21:10:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzUnlM6TnLynUPJ2hfs9gMmd/j6SJSwksKayew5PyETInhqE/Q3DFpLaJJ0UIwguiUlP/YnPWL4ncZ5ygD0VPZ3k15sysKYbqTlDiquHys2BhtC9rZHI6Mtik8gO9pqLQfECtfzRnaJimkQ8vteaAZ8C+7PVxMIctOPtOlsgHPuw+CV1iPZRvNENqZO347U9Eb77RCPN04GI72FvkIWhgOQpNgsyQSHsLWklaHhT0N99ezpwwLHDIfy3yGj1Q+5X0XjVEG3PVJ8pDltK01mZUnkxXpiaUUyDxh/YY6FMibtEc+xY/wmkhpXh7R94+inOgX9ZEksJn2gfxsVf92WI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNQlyABP43ACTQ9fFAT9xZp/ER51uA4F3pc3x7fdvj0=;
 b=mTBjLXQTfL4SUt02sLZf16i4GFCrZTbB5Do4A6heBJxI5XNFk9Ca6ajuYDB2nQILMjXroL79fRXyeVN+jRn28bKkqQNNTBTX8BJpSyolaP9S05s381B9ro4tZkghMCC0u9U8tBNZ0SDY7BGBi/b3/e1OY0J8gwuPiGVMVefgHFiOIFYxiWU11GWJpWdFyn7Sc0H8UqdlyVJoJKn2tfQVPb/HP/r7QtAge9QRTxJYLzf7FRlKieaajxuVoBUBrjsELd094PTRfqs8OjApGWfoVKdNs2QefirWDsnxGBMe9dZZYa/C/6rBUzaDMY1/MUeHk1Rp4XFbDtlS5ita/paBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNQlyABP43ACTQ9fFAT9xZp/ER51uA4F3pc3x7fdvj0=;
 b=OV2MqfVnJK/5eLn2HF00SyweG/9RYlf25UBrZ8L/aSOkeHqi3vbAUm3ZSVe6mDzGwaZToHaLbHhIYR47Y/fClleU6bXNP8NTL/qboYfkuLCYvIT59iE7bP9BMsphe+aVISISi04WPuJprjPJVCs+pKcClOd/uxxZSHERb7Kl+eA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8004.namprd04.prod.outlook.com (2603:10b6:610:f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 13:10:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 13:10:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: fix use-after-free in do_zone_finish
Thread-Topic: [PATCH] btrfs: zoned: fix use-after-free in do_zone_finish
Thread-Index: AQHaawkf7hVGRqzgV0y/b8i97oPiPrEhR76AgAADdIA=
Date: Thu, 29 Feb 2024 13:10:15 +0000
Message-ID: <bc225f09-2450-451b-b0f8-d280f2f90939@wdc.com>
References:
 <4b26736862c49050ef907e6f326ab34c0e82c6b8.1709208898.git.jth@kernel.org>
 <CAL3q7H7takPu4rcrwMv2v-F9Dt-Hh8i3N6oi2X=XFsZMkhRwfw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7takPu4rcrwMv2v-F9Dt-Hh8i3N6oi2X=XFsZMkhRwfw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8004:EE_
x-ms-office365-filtering-correlation-id: 817d05bd-127b-4a89-dbfa-08dc3927c52a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 11GYU+eKS94jcJEIk6KSoq8KXBRNy7WVWgNFFUBWHRbLLs4SS1ZQosqCnqO9vfkdnqn8SZXdqvhfyyHdSy55wdlGhcBG6SMaqdkOUSkC7VCjUOArCzAu38eHWAByYk1yoNhok3BeHx4wT4xR5D+Rxs57OkeEzKPsSAiehDdEsjdNBD2FuDNPlDr7RQ3Zk7Q21SzGMZtQyKhKzSkxwgA8RFPbIxS9L5VZ/aAsOT6jST5XA7vUznu1bZc5G7h8Nieg0VYhnSIgJEuFNii0guky8IwtrFVCLuJq2sqEPTXO627+0wanZyPVJ6f1Wh6qG6mitu1yMykQMCgoJRwcaW0kjjPBqUN3LAHVxTJUVSbXHDkhxSsRkyTw356uE++rPUJmvlOPknhdJf0OE0WhsPuG/8xxC5/DEBEeuj2Mt+5TGg41NzEPA4BQGHrkmuak+WAB57iYUcUSSmrfXtgy6tMNY3/qaAkhNa+nsUvcDR+JenZ5nUSyNeX32v8dh16mnYuSsespQ5zxYumw+fkm2xl76jQa9ZJcSrYIRfT/NNqlD6ZL0IC3vW7FU7uuT0cyIUwwYi0s1ukVjcADZp00tNQerNQFOQ39KUpyAHDjFCWue0+nqwQ0vPTU3GF3L7Es4sC7SheS+MXbl/OvFBPJS7Nc9KGvnzGAkc/WBNszB/VsKo6qGY7froqxdSer+JaDlcNDrG9GGPtQ3rdO5ieN6ceWZaUz/D6wipKdunpPtOQ20go=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjF4b3dKeU83VDBac3VLL2xFNnA2OS9vVnZUOUkreW51OGpRVWExd3RNbDdE?=
 =?utf-8?B?c0lUZjVCMlRBRWFuOG1tMlJJbGhEZmJ6eHlBVEVTdTZEWFl6M09tenB0eXlz?=
 =?utf-8?B?dEpCRVhpeVpZUUQ4aStoaXBHbDNmbUZOZllkQ3NoSklacjZEL3l6Qk1WcHF1?=
 =?utf-8?B?emgyK2kwRXBKVUlCUHhYMW1jZWYxNjhDa2Q3cTVTdUZVVVVUaFYyZDZnenVz?=
 =?utf-8?B?ZlAzaU0zcUxtc0JwSjFiWnBmWUh3U3JvRnppd0FzMXNYZlQ5L1l4RlhuOUhl?=
 =?utf-8?B?d0ZzN1hSUmNGUldmd2VkTTlaaDc2aHRHeFlqcURGVWFqRzhqLzRkbUVCeUFa?=
 =?utf-8?B?QW9JZXBGTDVUYVFMMHl6Qno3YXg2cWpmcU1pMGM0Z2JJQWNScnVSeDlHVDhI?=
 =?utf-8?B?ZFkyck9IUmEwTzJVZnFJZzBpRnBFZHFFTjZLeUFBL0dXZXdpMzk1N2lvNUhs?=
 =?utf-8?B?U2NFeDFRKzZiSy8rbjJmUDRuTnIrYmYzSUlwd0lObkVEWWZNa0RKdmFzNVFp?=
 =?utf-8?B?bVJ2Vkk3UmxhZnlmbVhvblhCd1MwVW5Gbzdhdm9KMkppd2Q1Z2NNRjZjaFB4?=
 =?utf-8?B?OWdENXlvTXVoWnpEeTQ0cmRMUHJTeUwzRGVNRU5qNUF0d1RoUk1xVG4vUTFw?=
 =?utf-8?B?WkxYOUJGVTd5VGo2V1E3SXpsS24zZlZDZjBiK1dCNjhCc21lckZpT1E5QlE5?=
 =?utf-8?B?VEUvYUxHRHIrdzQwb3NQakp6aTBtN0RrOG8xQTJKVksybGRnY3BBa2pKK051?=
 =?utf-8?B?V1YwWmdXeW1FOVErMGs1LzhzU3pCQnFMUXZYS3ZmUU5ydjJNUk1lMDhYYkNF?=
 =?utf-8?B?VjlQU3Jza1dXRHJiZ0pxWURyRDQwcktsQ0lsWjRaY1RsUDFYWk9FN1lXd2ZR?=
 =?utf-8?B?OVZLTnptKzZOKzRRNGhTb2orNlVCNGx3SkNxZk5UWnNVTkxVQ0dZNDRjSFdo?=
 =?utf-8?B?Tkc1UkFmOXdodUJIR0J1ZUNzSXVXb05FcFg5YzE2Nk1iM3BFN1p3WkF6aC8v?=
 =?utf-8?B?KzIxWXkzYzd4YkxRS2g3djVrVGkzUXJNdXhZZlcwSStKb1J5T3A4QXdWamVZ?=
 =?utf-8?B?aGs5aWZWQ3RSUDd6UnNTZjlkM2dqemtmakM2NStQY1N2UjA2cTM3Uk9SMFRh?=
 =?utf-8?B?TGtJRTJNeDZvdVpjbm1JK2xnSE11bEkrOTVUOGZiUkc2ZEo5M283dE1xaG5F?=
 =?utf-8?B?SnBoSmlmSkRhNk1EYVR6cXkwZ0QySnRHcUhzZzlYVjBiTXdQdCthRysrUnJF?=
 =?utf-8?B?dlZ5ZDNROEVKL2RYeFdZS0hBR1ZUR3BRUUkwS2VlS2RkTGhRNHF1WXhQUjVL?=
 =?utf-8?B?Mlk5aUpqRFBIYjZUYzk5OU9qVUFXZ000L3kyOENKclZpMmVlTEczdVF3NUk3?=
 =?utf-8?B?SjZMdzVPYTJVNE5ZTFBoUlpLVVYwRU1kZWl2Z3pCd3VPQXVOK2YzRkQ4aTVi?=
 =?utf-8?B?SkYyWGZvREw2eGR1Q0dhdENjN243NGQyeDB0Yjh3N2QzdS95blMza1ZaYzBM?=
 =?utf-8?B?K1VRdTVDYmVFZGUyQmVmUFB0QjZhbkg5cnU3cXpRQzk3U2xaaWptQ05JYXFG?=
 =?utf-8?B?VnJrVGFzTkZpT0RZWDRUR1BJTHZXRkMwb3pVL3hrRXpOS0NIUlorK3ZzdFNw?=
 =?utf-8?B?YXFXMmk5OERBbVpESm14RloxckpreHFqUFhSdE1PSmxoUzNwTGpCcnFlL2po?=
 =?utf-8?B?MFFqV2lpY0M1ZWFsNHc2cXB0MkUzNk1mQURzNUdZV1JHQnFkQzZyOTVkUVY1?=
 =?utf-8?B?QUNubTFObnpaV2QxclFWMSs1T3V4bXZCUU14aEhTNE9ZMENVbzNheUVScjUz?=
 =?utf-8?B?cDl3SGhYRWFWMkEyTDREeDJzdWd1c0dqa0pBL1E4bmpKV1c3RUU1SXZnTHhE?=
 =?utf-8?B?ZCtwNFBXbE1BclpRNHNtaGd0R2hSSG9oRmptVW4yQ3p1ZklyNzFMNDBrRjRU?=
 =?utf-8?B?WWVwcE82ZHJQOFBWendXTE4vN0NINEpsUTRjeWNSV094RDdTYUE2N0NIYTBm?=
 =?utf-8?B?YlB5MkZmOWhsOVhRcDVOSTR0MEF1VWlIVGJLTGEzenQ1d1ZnTU9MZy9rMFI5?=
 =?utf-8?B?NzJFZFpMQzQ0V2ZGQVdJcy9QeXhhTXFHNytZMjMzYTFhVG5PdDZGMzhjdXdC?=
 =?utf-8?B?ZGtWN0tyZXI1VTN2Y25aYkRUTUREMEpJc2J3cHk3WUlydHZvLzlYN1VpSmdJ?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <876FCD69E121F84CBED133EFBD932BCA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/jQO+AZqo3YZBwWctNKuano+q/KOLXJyRNilEYQd1xOeAhRfTQabXfXT4vY1mBh6re+YyUbNbDf9wbkHuVKsy76tVeYPMPBrF8gBGINlO+KRXn5n5KjL3Zm7KBhs3qgwjpwkVncMmuDlJVWLfQOC7hHyR97pTTAd+SX03hJhmj1X0cTPTI6pit/4BdrDcoHoGY4XILCTqli+hNZ8UxA5p0Oi/huwq0OwVJ2JG1O2Xp7phU7t5uR7E27p0nIXp4+gQec1KSPraV0IJ978jtWNAMrWNcJifat6+hi001PvG5la460jGO8Pk34HlMIyUE4w+Er2o+d+u4Q2F+mSvW4Bgku/U4TVqfUahS7kSZiRCi5eGiHvxCL6kRnUZ/FBE/PYjYWP95rMtHYPVltHqaGRbJfLcXR8aPO4WQikLO+GUfFndDpvrWLsPnACtXDn3CCG5Uk+WVF2tozD5tOKQ2XqIUiJ6Er4bP84c8B7tRxTWmNUET77UXGut2nLN08fQSoSNMDmeor+Bv9bAA2YxhbuwC6BJVA5HzfRNPui0R8bwuYtSkzGtHXDUAjU5kG3kfz+c+uzjY8ovrB83cO21Dtwqzcuij19Pp5OoeEv30TmRnAl9qEW1J2J9Pvvn5MQ9EER
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d05bd-127b-4a89-dbfa-08dc3927c52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 13:10:15.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/XR0qOTwsiWsluiydgMY+xYfo4EWGwo428VlTzyXNQG0ZtwwWWFi35uNiVb5mNvuSKEquMb2dsl0Z12281jXrKsCwm5UNiApUZ9hgtQA9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8004

T24gMjkuMDIuMjQgMTM6NTgsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFRodSwgRmViIDI5
LCAyMDI0IGF0IDEyOjM34oCvUE0gSm9oYW5uZXMgVGh1bXNoaXJuIDxqdGhAa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pg0KPj4gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NCj4+DQo+PiBTaGluaWNoaXJvIHJlcG9ydGVkIHRoZSBmb2xsb3dpbmcgdXNl
LWFmdGVyLWZyZWUgdHJpZ2dlcmVkIGJ5IHRoZSBkZXZpY2UNCj4+IHJlcGxhY2Ugb3BlcmF0aW9u
IGluIGZzdGVzdHMgYnRyZnMvMDcwLg0KPj4NCj4+ICAgQlRSRlMgaW5mbyAoZGV2aWNlIG51bGxi
MSk6IHNjcnViOiBmaW5pc2hlZCBvbiBkZXZpZCAxIHdpdGggc3RhdHVzOiAwDQo+PiAgID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KPj4gICBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIGRvX3pvbmVfZmlu
aXNoKzB4OTFhLzB4YjkwIFtidHJmc10NCj4+ICAgUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZm
ODg4MTU0M2M4MDYwIGJ5IHRhc2sgYnRyZnMtY2xlYW5lci8zNDk0MDA3DQo+Pg0KPj4gICBDUFU6
IDAgUElEOiAzNDk0MDA3IENvbW06IGJ0cmZzLWNsZWFuZXIgVGFpbnRlZDogRyAgICAgICAgVyAg
ICAgICAgICA2LjguMC1yYzUta3RzICMxDQo+PiAgIEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8g
U3VwZXIgU2VydmVyL1gxMVNQaS1URiwgQklPUyAzLjMgMDIvMjEvMjAyMA0KPj4gICBDYWxsIFRy
YWNlOg0KPj4gICAgPFRBU0s+DQo+PiAgICBkdW1wX3N0YWNrX2x2bCsweDViLzB4OTANCj4+ICAg
IHByaW50X3JlcG9ydCsweGNmLzB4NjcwDQo+PiAgICA/IF9fdmlydF9hZGRyX3ZhbGlkKzB4MjAw
LzB4M2UwDQo+PiAgICBrYXNhbl9yZXBvcnQrMHhkOC8weDExMA0KPj4gICAgPyBkb196b25lX2Zp
bmlzaCsweDkxYS8weGI5MCBbYnRyZnNdDQo+PiAgICA/IGRvX3pvbmVfZmluaXNoKzB4OTFhLzB4
YjkwIFtidHJmc10NCj4+ICAgIGRvX3pvbmVfZmluaXNoKzB4OTFhLzB4YjkwIFtidHJmc10NCj4+
ICAgIGJ0cmZzX2RlbGV0ZV91bnVzZWRfYmdzKzB4NWUxLzB4MTc1MCBbYnRyZnNdDQo+PiAgICA/
IF9fcGZ4X2J0cmZzX2RlbGV0ZV91bnVzZWRfYmdzKzB4MTAvMHgxMCBbYnRyZnNdDQo+PiAgICA/
IGJ0cmZzX3B1dF9yb290KzB4MmQvMHgyMjAgW2J0cmZzXQ0KPj4gICAgPyBidHJmc19jbGVhbl9v
bmVfZGVsZXRlZF9zbmFwc2hvdCsweDI5OS8weDQzMCBbYnRyZnNdDQo+PiAgICBjbGVhbmVyX2t0
aHJlYWQrMHgyMWUvMHgzODAgW2J0cmZzXQ0KPj4gICAgPyBfX3BmeF9jbGVhbmVyX2t0aHJlYWQr
MHgxMC8weDEwIFtidHJmc10NCj4+ICAgIGt0aHJlYWQrMHgyZTMvMHgzYzANCj4+ICAgID8gX19w
Znhfa3RocmVhZCsweDEwLzB4MTANCj4+ICAgIHJldF9mcm9tX2ZvcmsrMHgzMS8weDcwDQo+PiAg
ICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+PiAgICByZXRfZnJvbV9mb3JrX2FzbSsweDFi
LzB4MzANCj4+ICAgIDwvVEFTSz4NCj4+DQo+PiAgIEFsbG9jYXRlZCBieSB0YXNrIDM0OTM5ODM6
DQo+PiAgICBrYXNhbl9zYXZlX3N0YWNrKzB4MzMvMHg2MA0KPj4gICAga2FzYW5fc2F2ZV90cmFj
aysweDE0LzB4MzANCj4+ICAgIF9fa2FzYW5fa21hbGxvYysweGFhLzB4YjANCj4+ICAgIGJ0cmZz
X2FsbG9jX2RldmljZSsweGIzLzB4NGUwIFtidHJmc10NCj4+ICAgIGRldmljZV9saXN0X2FkZC5j
b25zdHByb3AuMCsweDk5My8weDE2MzAgW2J0cmZzXQ0KPj4gICAgYnRyZnNfc2Nhbl9vbmVfZGV2
aWNlKzB4MjE5LzB4M2QwIFtidHJmc10NCj4+ICAgIGJ0cmZzX2NvbnRyb2xfaW9jdGwrMHgyNmUv
MHgzMTAgW2J0cmZzXQ0KPj4gICAgX194NjRfc3lzX2lvY3RsKzB4MTM0LzB4MWIwDQo+PiAgICBk
b19zeXNjYWxsXzY0KzB4OTkvMHgxOTANCj4+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDZlLzB4NzYNCj4+DQo+PiAgIEZyZWVkIGJ5IHRhc2sgMzQ5NDA1NjoNCj4+ICAgIGth
c2FuX3NhdmVfc3RhY2srMHgzMy8weDYwDQo+PiAgICBrYXNhbl9zYXZlX3RyYWNrKzB4MTQvMHgz
MA0KPj4gICAga2FzYW5fc2F2ZV9mcmVlX2luZm8rMHgzZi8weDYwDQo+PiAgICBwb2lzb25fc2xh
Yl9vYmplY3QrMHgxMDIvMHgxNzANCj4+ICAgIF9fa2FzYW5fc2xhYl9mcmVlKzB4MzIvMHg3MA0K
Pj4gICAga2ZyZWUrMHgxMWIvMHgzMjANCj4+ICAgIGJ0cmZzX3JtX2Rldl9yZXBsYWNlX2ZyZWVf
c3JjZGV2KzB4Y2EvMHgyODAgW2J0cmZzXQ0KPj4gICAgYnRyZnNfZGV2X3JlcGxhY2VfZmluaXNo
aW5nKzB4ZDdlLzB4MTRmMCBbYnRyZnNdDQo+PiAgICBidHJmc19kZXZfcmVwbGFjZV9ieV9pb2N0
bCsweDEyODYvMHgyNWEwIFtidHJmc10NCj4+ICAgIGJ0cmZzX2lvY3RsKzB4YjI3LzB4NTdkMCBb
YnRyZnNdDQo+PiAgICBfX3g2NF9zeXNfaW9jdGwrMHgxMzQvMHgxYjANCj4+ICAgIGRvX3N5c2Nh
bGxfNjQrMHg5OS8weDE5MA0KPj4gICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4
NmUvMHg3Ng0KPj4NCj4+ICAgVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgb2JqZWN0
IGF0IGZmZmY4ODgxNTQzYzgwMDANCj4+ICAgIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIGtt
YWxsb2MtMWsgb2Ygc2l6ZSAxMDI0DQo+PiAgIFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQg
OTYgYnl0ZXMgaW5zaWRlIG9mDQo+PiAgICBmcmVlZCAxMDI0LWJ5dGUgcmVnaW9uIFtmZmZmODg4
MTU0M2M4MDAwLCBmZmZmODg4MTU0M2M4NDAwKQ0KPj4NCj4+ICAgVGhlIGJ1Z2d5IGFkZHJlc3Mg
YmVsb25ncyB0byB0aGUgcGh5c2ljYWwgcGFnZToNCj4+ICAgcGFnZTowMDAwMDAwMGZlMmMxMjg1
IHJlZmNvdW50OjEgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgw
IHBmbjoweDE1NDNjOA0KPj4gICBoZWFkOjAwMDAwMDAwZmUyYzEyODUgb3JkZXI6MyBlbnRpcmVf
bWFwY291bnQ6MCBucl9wYWdlc19tYXBwZWQ6MCBwaW5jb3VudDowDQo+PiAgIGZsYWdzOiAweDE3
ZmZmZmMwMDAwODQwKHNsYWJ8aGVhZHxub2RlPTB8em9uZT0yfGxhc3RjcHVwaWQ9MHgxZmZmZmYp
DQo+PiAgIHBhZ2VfdHlwZTogMHhmZmZmZmZmZigpDQo+PiAgIHJhdzogMDAxN2ZmZmZjMDAwMDg0
MCBmZmZmODg4MTAwMDQyZGMwIGZmZmZlYTAwMTllOGYyMDAgZGVhZDAwMDAwMDAwMDAwMg0KPj4g
ICByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDEwMDAxMCAwMDAwMDAwMWZmZmZmZmZm
IDAwMDAwMDAwMDAwMDAwMDANCj4+ICAgcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJhZCBh
Y2Nlc3MgZGV0ZWN0ZWQNCj4+DQo+PiAgIE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFk
ZHJlc3M6DQo+PiAgICBmZmZmODg4MTU0M2M3ZjAwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPj4gICAgZmZmZjg4ODE1NDNjN2Y4MDogMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4+ICAgPmZmZmY4ODgxNTQz
YzgwMDA6IGZhIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeDQo+PiAgICBmZmZmODg4MTU0M2M4MDgwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBm
YiBmYiBmYiBmYiBmYiBmYiBmYg0KPj4gICAgZmZmZjg4ODE1NDNjODEwMDogZmIgZmIgZmIgZmIg
ZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmINCj4+DQo+PiBUaGlzIFVBRiBoYXBw
ZW5zIGJlY2F1c2Ugd2UncmUgYWNjZXNzaW5nIHN0YWxlIHpvbmUgaW5mb3JtYXRpb24gb2YgYQ0K
Pj4gYWxyZWFkeSByZW1vdmVkIGJ0cmZzX2RldmljZSBpbiBkb196b25lX2ZpbmlzaCgpLg0KPj4N
Cj4+IFRoZSBzZXF1ZW5jZSBvZiBldmVudHMgaXMgYXMgZm9sbG93czoNCj4+DQo+PiBidHJmc19k
ZXZfcmVwbGFjZV9zdGFydA0KPj4gICAgYnRyZnNfc2NydWJfZGV2DQo+PiAgICAgYnRyZnNfZGV2
X3JlcGxhY2VfZmluaXNoaW5nDQo+PiAgICAgIGJ0cmZzX2Rldl9yZXBsYWNlX3VwZGF0ZV9kZXZp
Y2VfaW5fbWFwcGluZ190cmVlIDwtLSBkZXZpY2VzIHJlcGxhY2VkDQo+PiAgICAgIGJ0cmZzX3Jt
X2Rldl9yZXBsYWNlX2ZyZWVfc3JjZGV2DQo+PiAgICAgICBidHJmc19mcmVlX2RldmljZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDwtLSBkZXZpY2UgZnJlZWQNCj4+DQo+PiBjbGVhbmVy
X2t0aHJlYWQNCj4+ICAgYnRyZnNfZGVsZXRlX3VudXNlZF9iZ3MNCj4+ICAgIGJ0cmZzX3pvbmVf
ZmluaXNoDQo+PiAgICAgZG9fem9uZV9maW5pc2ggICAgICAgICAgICAgIDwtLSByZWZlcnMgdGhl
IGZyZWVkIGRldmljZQ0KPj4NCj4+IFRoZSByZWFzb24gZm9yIHRoaXMgaXMgdGhhdCB3ZSdyZSB1
c2luZyBhIGNhY2hlZCBwb2ludGVyIHRvIHRoZSBjaHVua19tYXANCj4+IGZyb20gdGhlIGJsb2Nr
IGdyb3VwLCBidXQgb24gZGV2aWNlIHJlcGxhY2UgdGhpcyBjYWNoZWQgcG9pbnRlciBjYW4NCj4+
IGNvbnRhaW4gc3RhbGUgZGV2aWNlIGVudHJpZXMuDQo+Pg0KPj4gU28gZ3JhYiBhIGZyZXNoIHJl
ZmVyZW5jZSB0byB0aGUgY2h1bmsgbWFwIGFuZCBkb24ndCByZWx5IG9uIHRoZSBjYWNoZWQNCj4+
IHZlcnNpb24uDQo+Pg0KPj4gTWFueSB0aGFua3MgdG8gU2hpbmljaGlybyBmb3IgYW5hbHl6aW5n
IHRoZSBidWcuDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IFNoaW5pY2hpcm8gS2F3YXNha2kgPHNoaW5p
Y2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1z
aGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMv
em9uZWQuYyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBiL2ZzL2J0
cmZzL3pvbmVkLmMNCj4+IGluZGV4IDMzMTdiZWJmY2E5NS4uYzI3ZDIyMTQxMzZlIDEwMDY0NA0K
Pj4gLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0KPj4gKysrIGIvZnMvYnRyZnMvem9uZWQuYw0KPj4g
QEAgLTIyMzcsNyArMjIzNyw4IEBAIHN0YXRpYyBpbnQgZG9fem9uZV9maW5pc2goc3RydWN0IGJ0
cmZzX2Jsb2NrX2dyb3VwICpibG9ja19ncm91cCwgYm9vbCBmdWxseV93cml0DQo+PiAgICAgICAg
ICBidHJmc19jbGVhcl9kYXRhX3JlbG9jX2JnKGJsb2NrX2dyb3VwKTsNCj4+ICAgICAgICAgIHNw
aW5fdW5sb2NrKCZibG9ja19ncm91cC0+bG9jayk7DQo+Pg0KPj4gLSAgICAgICBtYXAgPSBibG9j
a19ncm91cC0+cGh5c2ljYWxfbWFwOw0KPj4gKyAgICAgICBtYXAgPSBidHJmc19maW5kX2NodW5r
X21hcChmc19pbmZvLCBibG9ja19ncm91cC0+c3RhcnQsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJsb2NrX2dyb3VwLT5sZW5ndGgpOw0KPiANCj4gVGhpcyBmaXRzIG5p
Y2VseSB3aXRoaW4gYSBzaW5nbGUgbGluZSwgd2h5IHRoZSBzcGxpdD8NCg0KQ291bGQgYmUgYmVj
YXVzZSBJIGRpZCB1c2UgYnRyZnNfZmluZF9jaHVua19tYXBfbm9sb2NrKCkgYmVmb3JlIGFuZCBs
b2NrIA0KdGhlIHdob2xlIGxvb3AsIHdoaWNoIGNhdXNlIGRlYWRsb2Nrcy4uLg0KDQo+IFNvIHRo
ZSB3aG9sZSBwcm9ibGVtIGNvbWVzIGZyb20gdGhlIGZhY3QgdGhhdA0KPiBibG9ja19ncm91cC0+
cGh5c2ljYWxfbWFwIGlzIGEgY2xvbmUgb2YgdGhlIG9yaWdpbmFsIGNodW5rIG1hcCwgd2hpY2gN
Cj4gdGhlIGRldmljZSByZXBsYWNlIG9wZXJhdGlvbiBkaWRuJ3QgdXBkYXRlLg0KPiANCj4gRG9u
J3Qgd2UgbmVlZCB0byB1cGRhdGUgYmxvY2tfZ3JvdXAtPnBoeXNpY2FsX21hcD8NCj4gSSBkb24n
dCBzZWUgYW55d2hlcmUgZWxzZSB1cGRhdGluZyBpdCwgaXQncyBvbmx5IHNldCB3aGVuIGxvYWRp
bmcNCj4gYmxvY2sgZ3JvdXBzIGZyb20gZGlzayBhdCBtb3VudCB0aW1lIG9yIHdoZW4gY3JlYXRp
bmcgYSBuZXcgb25lLg0KPiBBZnRlciBhIGRldmljZSBpcyByZXBsYWNlZCBpdCdzIG5ldmVyIHVw
ZGF0ZWQuIFNvIGNhbid0IHRoaXMNCj4gdXNlLWFmdGVyLWZyZWUgaGFwcGVuIGluIG90aGVyIGNv
ZGUgcGF0aHMgdGhhdCB1c2UgdGhlIHN0YWxlIGNodW5rIG1hcA0KPiBhdCBibG9ja19ncm91cC0+
cGh5c2ljYWxfbWFwPw0KDQpZZXMgSSBjYW4gZ2l2ZSBpdCBhIHNob3QsIGJ1dCB0byBkbyB0aGlz
IGNvbnZlbmllbnRseSB3ZSdkIG5lZWQgdG8gYWRkIGEgDQpiYWNrLXBvaW50ZXIgZnJvbSB0aGUg
Y2h1bmsgbWFwIHRvIHRoZSBibG9jayBncm91cC4NCg0KTGV0IG1lIHNlZSBob3cgdGhhdCdsbCBs
b29rLg0KDQo=

