Return-Path: <linux-btrfs+bounces-5017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B068C6BC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB8A2847C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35A158DB3;
	Wed, 15 May 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qHhBvrti";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gpBBqGho"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF836AF2;
	Wed, 15 May 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796073; cv=fail; b=fNzc/GfSEEeENR87u9UUHbbNsgo4oDbRRgKoWA6fz77QNH0AWFhMiOvmbThV+1xMgsrCp5b1pOk27JQ8AW5aQEruDOiK3086DNiJOJnY6XxX/eAkWjGN1tDmk4TcuAOwEC728ortkFn4t5Eir9/zdZMvZiw9ASmJmZfHwQ42qhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796073; c=relaxed/simple;
	bh=r7lnPAU8d3mJ0+SPPOyv3N+FSbAR9HGoRrf6oAPbIK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L8crB7uve4Hj1mLTRLhZb9VcZVyOvj4e6gDd+XhSXH/Ih4Jg4KeZZdYeMqNomGs9nbvwrQcBHEbd71rhN2DGeXKHLC8fBBq8ezGVFaii/jOrQTp+wUv+A/s+C0XdaBlKEngdX1vPQNVsN4nIxasbIEdWa9TfSPTNZtSrVuBscBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qHhBvrti; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gpBBqGho; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715796072; x=1747332072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r7lnPAU8d3mJ0+SPPOyv3N+FSbAR9HGoRrf6oAPbIK4=;
  b=qHhBvrtiq5QF/59DfMR5eqZ/x6uT1n0zMpul6q7t5Z48cjsGtyVOEzdh
   epfqhGFoPp582plfwluBfLScSv1AxTe7bct11dIPEVYCWTBk412qrLjIQ
   2p2WD5CczEXy6tljw0QGWjYKk1+pkYYy/tdq1uCS0ulN2PWZ+huvxUx7g
   t+XLtkcdMulSHLhG3notyZwYaga7XzL9NDwzl/sSw/ldF7YsrKKoYtmVw
   2c0hB6uSs2o5mlsSs510S3lRc+7NjNVThOxTiaDNupjb9g3DC/q1mcigs
   GLzXLknrlXPialsVPNYu1o0NPcsr/qeTaOPbxiMm/REaxZhkSaOR6CEcS
   g==;
X-CSE-ConnectionGUID: QWhhb6H1TTWuQyU6ZhOucw==
X-CSE-MsgGUID: Ls1+ycYdR9qkdsMqQMv/cg==
X-IronPort-AV: E=Sophos;i="6.08,162,1712592000"; 
   d="scan'208";a="15755670"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2024 02:01:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx7JuExvcQ7+VBBP6UnfZyWvl7JXK6XSjGpiIz4pzaOfKtmflO0OcEa2NJIF2jtBaXLRc6wJhDeyo0WMAu/zPfzaLeczTH8dd7KW7OKtyu9VZz7OlTqvNsr8KOmWG8ydoMSXlv4kzV1Q/Mo3O3IuISNrHnpKgkCLhQe3+YEyrchCLcc8hzasNgqmj9DZpYoTWNNaEr8OV3zjnKz8dRbM76lQOCbDWL9vRg71bCKMDtN9rMlpy1W1v1FsuypNGG9oVQYXLvu6jWfko+LKK+qRHxDKkydjfsQI5jWIv9cwR1jlCM5BHX2Nb7gjM6vhZkNOR3zIdQ4KPV9/glhExuLstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5+IY7flZvAB1cDzyADGcGvIilkQyl5pbj1VZ8amdj8=;
 b=gHTSL50t5DZo1OGyw6O4y1ZI6tBmUp1YRMBFOwF9uSPjabFwBmzQhvTxGuH9aei6briyp+/l2QScJhado3rD04bHKyaS3/Ss5MNkqnv6ZqmuyEHGJlaOmWCwi/AnTD0evHYSILR8AhFXW3liGOmvGzMhtHh+tYFuMjuJ5bFVyDpJW7lh5cXKN+YUIt4rRaVTB1BR4vRHqV3hf0tnISFr4XPQn7cXSCDtfNew5/sv9OfX60lWpPxaW0YMzoVuOeqCUUFX7bmpZuSvTyURV6LFabnNtb4MI3tHgf0pIKyEm/vyVDGvfXNufkku/u73czx31fOBJjuBnsyA7y9RC/8d/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5+IY7flZvAB1cDzyADGcGvIilkQyl5pbj1VZ8amdj8=;
 b=gpBBqGhobm9bKotWeRXIt152ZQeKd8fPG6mANmmCQ4ufrN2CK/Da/b5y1Kgsd0pZ4pbg/Ne+Ec6yk3m2CVEMJrfED41pWSW3UoMs8Im1bY/u2zoNzotkBGw1DJ2xA17Smse/iKJC3Lm5OpBAGZcWsXEASLuWw7lUSXhkEbfp3iI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW4PR04MB7236.namprd04.prod.outlook.com (2603:10b6:303:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 18:01:08 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 18:01:08 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] btrfs: reserve new relocation zone after successful
 relocation
Thread-Topic: [PATCH 2/2] btrfs: reserve new relocation zone after successful
 relocation
Thread-Index: AQHapkOklbppV3Xln0eYnqZCoPqOErGYlyoA
Date: Wed, 15 May 2024 18:01:08 +0000
Message-ID: <ntbfehck4zi2vns3773bo7f5mlxclka36fwfphkzdnbz3k37nc@ojamkclv2w4n>
References: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
 <20240514-zoned-gc-v1-2-109f1a6c7447@kernel.org>
In-Reply-To: <20240514-zoned-gc-v1-2-109f1a6c7447@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW4PR04MB7236:EE_
x-ms-office365-filtering-correlation-id: 8a7d17d7-0fa8-416c-dd92-08dc7508ff2a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F3+9TIyLiMJj9AZPdL0CyF1ikeEZ2kmgR1GMf31jZUStwOKO/3V9hQ7smsOv?=
 =?us-ascii?Q?DvUuTt3Mz59r/NAASUFmDK7yYpV6eY7Xxrs91QI7yktB9bdui/Ob1+j7FX7L?=
 =?us-ascii?Q?eINao62V7hFM6KuVthV5m/YACfCqU3MedCBJIAMrG9+5xhyEShF+Qpxg/AZ3?=
 =?us-ascii?Q?+knzmLLOPpQgtr6kGnFMnaM/fs6bkKEgIHBEgsEG4CxmMBTHfcofapDLCgF7?=
 =?us-ascii?Q?vHNzJvowsG6Y1k9jS9sAo20W8Qyssu4Se0Nc4PfkcY/rkbwwcTtTlRzHtm+i?=
 =?us-ascii?Q?34mMXXn70DpJusKxqveSrUXa1ecaWKl1q32Sor/pkdgTuOeCI2mL7yiY05vk?=
 =?us-ascii?Q?oKwzPmrjyAb9eMW/2DGK+v0KNp+rpT12QAFefKVGN/b3b+hAjAc8WFwkeq8h?=
 =?us-ascii?Q?t2ijfhrT59KI0kYi+2ZS8SYxbwfrqvm6GmwZSKU2xZ2OuX/S4cChh95cQN0+?=
 =?us-ascii?Q?E5q4d2mu1sMkejpNxfa51shxWWtXXyu1eZWAnfzk/leTJby90Hcde4QSd87W?=
 =?us-ascii?Q?dGQOYLAlORAJxtC3eKurE85QudVS5+lUY7iV8gnqaHJNfaM6Flou1ANs9m9D?=
 =?us-ascii?Q?9u1dMiOV7iK6wxDnGKJDqvpmxhRBmUGkN09qbce5IllFJ/VcDLBeyCgDcwxr?=
 =?us-ascii?Q?OjGI6J00TF3uhefiPifc9D8efSB6S/5XFErOLeBGO60szk6wELjYMst2qiQz?=
 =?us-ascii?Q?ND/qtd7EE1aZJvuj40I0oeGq/nHFKBrpMD7yKE4yv9nzK+R8ZSKf/IQEtoKe?=
 =?us-ascii?Q?ggOhU9vt2nV7flczyuBVY6OTgMXb/f+cerO90AtN2xMO0CdbXzQ0wp0EiYOA?=
 =?us-ascii?Q?3omEp0MmPQLfLxbvkMT0PzfnkDjQrVwMoGvckBth7ghIalDPibPFzNmL8A3J?=
 =?us-ascii?Q?U61BM597IqqA1uaFuT99bYkI6DMU3qJeKAmWwyrMKbdTDKwazgQCfFMMURbi?=
 =?us-ascii?Q?OWqwJX9QRryyFL+f1DzY4+ySQBVQPhLVzmIG7465P2GVk84ESffbo4hhuPU8?=
 =?us-ascii?Q?HU3cYv3sNqPZlLcnfEf1Nk1yZvFXJMy2ihfs5VPz4RDz6wWf6C9oeXSl/EHG?=
 =?us-ascii?Q?8MtKAg0WG4uBqBw8GZ2xTlWsBnn0OQL1Ax/d7S2BBFpfJThWM/LpdkcBHBeY?=
 =?us-ascii?Q?BzQZN09uFKXNni9JtGwPIXfIlYWlalVArImoLf875sLyBd7lOTmny5ycap9m?=
 =?us-ascii?Q?A0NpE7Xmnk1CwPlWnUUBZl2K4ImkQmnVJvieCc2Y4KFyZyUaVfCZCrLSUKWP?=
 =?us-ascii?Q?199q0sPx7KnPMeAMgm39Tqm6s8fGfoFKwU5nIONBxej1VvcvLaMVHE3qriiN?=
 =?us-ascii?Q?tsg2NYLxxOFaDo7o1CTMKZnFdAKv/TyJbiHZYJIKwQh6jw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GQSVO+BzhVcDbiU+r2qtVRiTp/bfBslFniMdem3DHEO/YDgkBDDX3OQRvDJI?=
 =?us-ascii?Q?p4xEcK+oYUSz/gr7Jhta25SpWTuLJx4wVT69p2mFwrDT2QAbvaD87DDQF+aF?=
 =?us-ascii?Q?xt0yWjRNoxIyT/cJpwwo3U8fo1a++e3RxDqBsRNQQBT1YhsBp+DpjhMpdd5D?=
 =?us-ascii?Q?EoYa4MMrFbW8nOP2h+iB8J2Rg4W6w/vbde29SpfsJ0hQKlexgo4vSXa02Lpl?=
 =?us-ascii?Q?UhZT/9btxD5ZoN+aoqkUG6v/+8Xi6yqNZpJXTyr5NId3fmW+D59gWrLAi85Y?=
 =?us-ascii?Q?PMFDImP8OmLl0c3LqSS7bd0r7xWS2bPU9j/kSitrXvkSDZlumjwb7LHEfV90?=
 =?us-ascii?Q?dmWCY7QHsOhH15klEq5AHweIvXBDoN0mzIU5nMLLWJfqGYKpKwoZ1bJ5Y/2t?=
 =?us-ascii?Q?aeB9gl9NC+n/DIQ8ViG4D5HhCY+dgTuzh6c4O4oUEA+BTqmz5jfBrd2qvzS8?=
 =?us-ascii?Q?y+RzfMlUM/GPHNzBXc1QoJe67EIaPnZzW3EBDU6W8Dff9SKkEnq1gbIHQf/T?=
 =?us-ascii?Q?zamZUp3Puxasx+1IQ2bIlWBZ7BpGB+Ckmux9qQG4mnDMrnm2jvtz7E4Sauvt?=
 =?us-ascii?Q?QwMcpDvbRrjk89S1Uvp+KlGE16O3CWOV7cN2kIWCbCtDnvvmWrlCWMJrGuoM?=
 =?us-ascii?Q?TRH375nmY1wAIX63AiaQZT76tQtb2Bm+c9kOwv9Qi1v1zmHojExQfVSIDMKc?=
 =?us-ascii?Q?od6XkeMkuYPHanD3VMNnXhRrFYUftYM5j4eH4CRXZj6W8bGdb9P4m9ZvTncx?=
 =?us-ascii?Q?q7XfhVEZBPYxg3AtwbABF9APuj1Tacx67t5rWTaueDI/SI6JcRlL4D86RA/E?=
 =?us-ascii?Q?DjnMEafv7hACZBJRqWcz4EwzAWCsL1Gv0qXiOE4lX+ZU2ibcgyBIMUE+wAbr?=
 =?us-ascii?Q?cyOtjLdNcCMRneQdZ3Z854tBKDBGuVjR7PF/uHhgsWilCcR9FlUBYzGdpn3U?=
 =?us-ascii?Q?NSgYwWjmR1MKU9i3wUrIwuv0iwUFM2jvljiryEPpYCsW5vFnfyv+Bct8GiKx?=
 =?us-ascii?Q?2SkJi+/3MUkEMbXQH5WuPE/ZGAD7ABXogLPo16Fa6s5hB9XbWrWrLN9rNrZG?=
 =?us-ascii?Q?E0dGpKFgVxFsnndbZ+bJ2+wDSuz5A3I3wp3waD1ofIi69A00i1z+rX7KETvJ?=
 =?us-ascii?Q?7DIEbddMiNnvwixx2uFqXyPFblFzq+G0lK6yXNlGZZCDF4PBRk/xV/2ypuGT?=
 =?us-ascii?Q?D4vH5dVUEhmUePuwUSBNOlDDlzI5Tom+7j7i85OVfC3SsvQrEqa5AqSRaaMr?=
 =?us-ascii?Q?+ldwL7bNwiPM1NLTKVBaV0vH0uoBV2RB278ep1/zrm76bFPvmyIq/iLb9Pai?=
 =?us-ascii?Q?HkoN58MGGCQnsX2JOvWcpZi8YkmH+a/GVPqiaWKSr3fAMamfUVy09zl0ZNlL?=
 =?us-ascii?Q?o2eW0HKkaDem5tZCHr2TG3BCw4wrwvnofiZl4BL6eFKdI9NZVpuH9kpNmYXd?=
 =?us-ascii?Q?/v6KJSj2V/CJMfW34MczcSMnWGWhNVNi791ba1dumRr4RTJJgviPy/9FdJRQ?=
 =?us-ascii?Q?gFhO8eys7vn82smwNiQYKQARGLGfRiuEotV+6v3/+JhKLB9JriFifBhp9E+q?=
 =?us-ascii?Q?dNTzrIDND2aLMqXP58rNVUGwkyeUhjpZKID8odx3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE5B11D77B92DF49BBD7A6439228A45C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	COBqJ+ALY8cgFskWdToj/3QsbFAjfVXXcPDZSG30qercYUQaTCNYtHRLHECbF0/dktcFiETfAu1D0qnSxv4R6yRW6CFcBAshOoqh4wxHTJd5qjiYxsFL1pPphRkaToJlVrpqPV5YbQ0WxW0tGJG/KdFhQrw5XgyCoM4PoiOmLNNySMG3w8ExE+ccx051FjZ8SwSq57ma5m0Hm+Tzt8a+H+DO6LWTHvkN8Gt8O9KF3XAL3ZHZGKsIoUZHo865NsAnjGQ3huO6GAxDdRF1C9Cg23hBAaB4S83xj7zDhP6HCAs4hEwIJ58mXfg8xYR5cnXfkoL0/Zutyy5V9UX+l/dFZclaz4csZ6C+EWcSIKM4xsjpK6MmiVKH6/8ZBhjiRBFglMgzma0wLqcmpi2sraPngz8oaNohkzsYr/NNxuwDlciNj1Xzn9ezB6iZu0kkDBJzNho+mw4LmfJENzrR8ltO9+yBLIuibBP3+NSRJ32szdj56qqwJqrr9zI1jUCvNGzVOhlu9Mn7J3kPSggM9+TaSEYmWhXy/HowPaofeTVRlnh1cE3oF0RZbjnlw3wBScutQBh5EgKuKTaiHfPTLGo67snjWGP3lwNcOs2Nsq7yynRTAVR1jKA0LlBccMRJ5P8U
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7d17d7-0fa8-416c-dd92-08dc7508ff2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 18:01:08.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LH8rxksl/JzIb14A7ZIHd6ggN5eCVIegiHoEllNNRNQMf8jCefhZ2zmmKnWT520OH3Yrbk/CiDqx3OL50GtCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7236

On Tue, May 14, 2024 at 11:13:22PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> After we've committed a relocation transaction, we know we have just free=
d
> up space. Set it as hint for the next relocation.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/relocation.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8b24bb5a0aa1..d943abf5cb33 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3808,9 +3808,13 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>  		err =3D PTR_ERR(trans);
>  		goto out_free;
>  	}
> +
>  	ret =3D btrfs_commit_transaction(trans);
>  	if (ret && !err)
>  		err =3D ret;
> +
> +	/* We know we have just freed space, set it as hint for the next reloca=
tion */
> +	btrfs_reserve_relocation_zone(fs_info);

With "if (!err)"? We definitely bail out fast in an error case.

>  out_free:
>  	ret =3D clean_dirty_subvols(rc);
>  	if (ret < 0 && !err)
>=20
> --=20
> 2.35.3
> =

