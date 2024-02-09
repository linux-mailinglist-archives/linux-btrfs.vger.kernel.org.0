Return-Path: <linux-btrfs+bounces-2279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471484F759
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46451F226A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA169962;
	Fri,  9 Feb 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GfJzR9jf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jamnmmO3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035869959
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488996; cv=fail; b=pols7IOfD8KRa832Wj15Fiv1oV57jfNLk654bg9eQpbnil+L/L0JOO/iK8CrNi8VB+TvAPnBP4F1cvXbpkg0b6YngP2oDaZ57uVn/mD69V/S5k4wO2u04PBCDh/lDIm27tTqLiVFdUR8f2ypR3fn/y9wXXHABSj79tZ/M3RPOvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488996; c=relaxed/simple;
	bh=aCqyPz3qDjs/xtlURQfZn5y/bWB6DD01ADJhL2t5gLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTxHuYzA+CZWys/fF8rK4aesi6hP6BW9VV32uOmkTbHvXuOe0qS3/G+AaUnAStHISIzTQN0//o0FhzHzyl0b5aeOQmb70zU280dwLPztaIipuFZELFelo+4/vPs8wfPyyoRslowOt9Zf57qVxY+YCAqsvCO5TpCVY25O4Ns/Nkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GfJzR9jf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jamnmmO3; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707488993; x=1739024993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aCqyPz3qDjs/xtlURQfZn5y/bWB6DD01ADJhL2t5gLQ=;
  b=GfJzR9jf+HH+YfvRLG0EpaecOOFeKvO69jyhSQ/q/YL4A5jCJEYYYUM0
   ZDAYh5om+COfQGek4ftYcOrFXUl59xvu78292CVWX7hHKrSCcGg9jgtD6
   ISZ6/ZBQX5LyHCumQUY9R+tXUGsMlcKCWZeU0OHwYko1tMjrdMPfGVKlj
   RrwiPPZrwOQRHoDDqjLCFp7u6PqzgNwKcW1cKy/iLjXh9myarzsp31fds
   Cnmb5sNJKD0H8pMV4DHzN3DZe6rzlOftlkauU/ZmtsOROJu4F03G44CKi
   CbKYrc7tBxQpdNd1IiNSiqc0kcRTPyrNeZvSfkLXoMemuGPcjwarsW/Hg
   w==;
X-CSE-ConnectionGUID: gBA3VxnXT6evCqmQ63bAQQ==
X-CSE-MsgGUID: cGkA57WQTIetrdFl/Ovp2g==
X-IronPort-AV: E=Sophos;i="6.05,257,1701100800"; 
   d="scan'208";a="8951553"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2024 22:29:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0WMb7Jf+3EVM48DxXqVGZmznBL8QoFncFE5PYXTJ/Q18R6CxmjdlPhEIXa2r73sW3Du9wc/69/RfhsgV8v3y+HDUirGhOUhujrBc+VdbOeSOkdYAOOeA+8jbtiH9cO7ye2J4DT3CeQ1YJpMXwwvECSYPWAvlQFbV1DJxuRvfAz0b/M3RArq82VGVjBhzyDGu4GznkMuM1YuqiWSVQt5P7i6htVcu95FXAFHigDcT2NJ5xb/0cIo6HBUVGxyCyskqkPKDRomF3rMLQl2yo+8FXsVGR9gFusJy4YSiMIC34uhzxM2/GrqQlVQQDxmlH/WomC7e2O6mvPhSCIxFCkKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCqyPz3qDjs/xtlURQfZn5y/bWB6DD01ADJhL2t5gLQ=;
 b=nbpmbpO7p/1KxihgcrPoSkhvV2UYbbeYYoFYXI3U8ceG59UMrOsSR7eMCkclr0YrVnP5IW92g0hdKwNm3E9e4TZT3oa+JId/fFq3S1IMV6f6Ti+GBM6jaLvTrosd4Ng0EWExl9M2T03GW7nP5ae0ViQehCdM9NX+XzLBIA5RFlwzW+Yjcd7f/FYlM230aaRIaE7u0VDNkPKOggRDkX0xkBYV3kaHrlkK/M780g3mwMUfVXC/fqSxMYGO+0qoBLObn50lLeHIt60S59xc/46f2nlGGoBXkQ9eDp3hH+DVWV9pwV8gatzretFJ6M4vkqiN1C3q3hlbr1AQQf3D5NHpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCqyPz3qDjs/xtlURQfZn5y/bWB6DD01ADJhL2t5gLQ=;
 b=jamnmmO3aNsJiiGlwa3j2vUjl6g8b4Cb8Lx1HOtEIGSRXEJDXIrl/mEF4KIwN4tC98/5SUPRfWWwae/L8zb0PS9x26ETcmwj2qJ33zZc6IBsjXK0a+KC53LFP4aEWp/hZhpWSVoSVoNDDQRcHq0ej3G7DHsw3NiezJ+d5cPoLJQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH0PR04MB8148.namprd04.prod.outlook.com (2603:10b6:610:f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 14:29:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%7]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 14:29:49 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	=?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Thread-Topic: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Thread-Index: AQHaW0VFXJOYcsPdOUm45Xk+19IH/LECElMA
Date: Fri, 9 Feb 2024 14:29:49 +0000
Message-ID: <qrqgwshivydiujwwfvso2tq65d3m5vfeide2ethoxv4ptzxt5e@fxpaznl2p3w6>
References:
 <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
In-Reply-To:
 <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH0PR04MB8148:EE_
x-ms-office365-filtering-correlation-id: 89ea3946-8f85-49a4-63a5-08dc297b9287
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R572IS9hCq66oIFSE36WsXCeGmYLT1wDD2Iz5/9Q3Q90kmD+Pt6C+OB5LJxNu2jVd+clXbaAmTGP56eit50mitGqWZVt0WiSmtkBieiQ3w56HLohwKjBmEEhWkLZkhOrybvuSMEwNfAEKeyNjJDaoiyG5BSy4LhEyCQn0dY9Ym/s8nt0/A78qygnZojpWyYCmvju8lALanQYaX0Nup0VGHKqj47LXbM7fzV3UFEoVT/TxQ2V+axnUBMvWStkx/seq5R/CGmVRhVDdiX98HSaIzr3LwIeIRTHyhAooac3dRuN36ux8EF6pP4EkyLMz/cdYJjveOovpCq+JNsgNR0fuKtH6mC32En1FKsYY+hoZO8v1yxKPntMaP+JFbSpm5CNYpf/0kptFavEkLKZq0huo+/DgBaq+M12e3fmR2l8R92hWtrINkGsa+Bm/dgXIUdRWwy8yB728iww3i+NClXHYpumT7veS0NC3WYITlT/bnHEapwK29O4ZnYe4WWhYpVxD00O0ljwKIczVKqvb7bWZqfst2sE18oKEG5fdNf/G4lW0JvyhI7X8Bu6hVSSu6fZlJZgfDKFN4lrK2m3On0YhqDA4EmqCIKCXxO08liyl+E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(122000001)(66556008)(82960400001)(38100700002)(86362001)(6512007)(6636002)(54906003)(71200400001)(316002)(478600001)(9686003)(6486002)(2906002)(6506007)(5660300002)(66946007)(66446008)(64756008)(4326008)(66476007)(76116006)(6862004)(8676002)(26005)(8936002)(83380400001)(41300700001)(38070700009)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHliRVZTcGZ0WTlXR21OZ2F6MzZwY2dScUpscFdqV2dJeEVSWE5ETVFRYURI?=
 =?utf-8?B?ZEkva1B5RGt2SWM5Z1VUVE9lTUxEUC9JQjNFSFl4MUZsTjV2aGQ5aTRkWU9h?=
 =?utf-8?B?Wmh3eWxmMVc5Q0t5ODZQVjBBenJwK3h5VDNoOUtrTmJjT21FUzF5Z0gxRFpr?=
 =?utf-8?B?Z0xMcmlSNEZhTFBZRm9RUUJFMDJSMERzSElKTVVqd1NhSVpMUDd0bXJuZVRp?=
 =?utf-8?B?Z2JxM0tuZG5TOFNUeFdsZTByTkxCRVorenpZUnNCcjB6QjdRSDlmRU9FMWUw?=
 =?utf-8?B?V293NlpOeG9ZbEpFMzA1eWUrNFVNVlZyWGdzOTR2MDVhZERkOWJ1S3NYV1hE?=
 =?utf-8?B?NXdpZ08vOVZaaEFNbGI0Z3JrR3FnWXRzRk1YRUlUd3VmdFFISmNGS3lFZE91?=
 =?utf-8?B?SXp2Q1E2M2YvTmdhQzQrZDUzR2hFUXNaUFpUQWlGK3RETTNTY3hBNEdvaXdJ?=
 =?utf-8?B?NndOUFJUQnllZjV4QW5nKzREcnIyMWM1Vlh0U0RHRFVZbDdkbzNXUThVODl2?=
 =?utf-8?B?MkprVUNteUV6ZnZTdnk2ekNFOXBpbWhXaFA5TXBQWVNDT3FhWmlVL0xKUWVH?=
 =?utf-8?B?QVZwcWx3elRiczJCS21hS0JmVzZDbXpTRVdHMElPS3NKKytNYTlUQk8vOHpq?=
 =?utf-8?B?MUE3Mk14eTMrMGFncFVEaFlMbHFlcnc2bHNMTkVPVjhyWVpIamNqdWlSKzR2?=
 =?utf-8?B?UXNvc0xmc04wZThJWDhLWG1yZ0R4WlBFUjNrTndlaVhhMWRVaEZhZlhDdlNJ?=
 =?utf-8?B?cGdIWG5MRFBVcnVMNjdJZGpER2ZlQXZzaDV6VkxSbkdmcXVYeE5WUkNZYUZ4?=
 =?utf-8?B?R0tnS2IzRWcxZlhZR05IelFhanNYVUE0OGwyeUlMMlJpSjhXSWlWN0RRbXVH?=
 =?utf-8?B?MXYvSTFpenVxQWQvV0NsTWsrdy9EZUxicUZTd2NNS1NrS3ZodEltdm5Tb0s1?=
 =?utf-8?B?RExrYW5xS3F5M0oyZnJuMTRTb1RqNEdZZy85Q3huR3EyN3F4L3BSTnhRY1BN?=
 =?utf-8?B?ZDFkVEVpZlFQVUUxcXQ2ZlFtQXNCTWc3eXhUNlo3bjg1RDlmdEVVK3c1bXBk?=
 =?utf-8?B?ZlpBa05NNisySERTRVpnOE5yUmZLYnRHQzFiS29zNGZjVTdNS085c0sybVR1?=
 =?utf-8?B?UFR5anFPSTFUdkhtdEtkcnlRL1BUaDBUblJKTVZTdG4yOGREcThVQmV4UHZl?=
 =?utf-8?B?Unh3QjkrZ2FTN2Y4eEZRTXN4cjJyTG9iRXNSYlh0MlExbWpTbFpYRkV2Ymt4?=
 =?utf-8?B?V3hFVGZpOVVZUlJGWW5BNkc3T3FOZkdkNWlPaThndFE3Q0dCaFZaTWlycTVo?=
 =?utf-8?B?ZVNGNm1IZjhnaFdWMC9CQVluOThPcnpxV1ZleDFkQVRXNGNWSE5XTkZLdUw4?=
 =?utf-8?B?bTJybTgvTlZYQTcvbEdKUHpNT3ZhcjQ0UXRDNTF5K2JSUFN4K3R1S1JyVDFv?=
 =?utf-8?B?UFZmQ1kvU1hrZVE5U3pMSmVLc0lheGtNTzVTQ1dqTGVENFJoUDFnejFuNmc0?=
 =?utf-8?B?MGg4RDlnam9sUmtvV1ZpRjlFMnhhcEg5cy9WL3Z2aVZKQ3ZnZUVldHV2R3ZT?=
 =?utf-8?B?S21ka0pzUUtWU2w5eWp4N2pFbkdpOFNMUXM0MWh6cEJRTWFWRWxVY0tCWkR4?=
 =?utf-8?B?Mm9lQ1ZObm9Wc3htQkRHUEQ3elI2OU5Wa3V4WkplVGZ1ZndYUXhmMlE4WXln?=
 =?utf-8?B?dVRLR3RTS3JUTGpWWk1UVHZveWtlcnJucmRRL21IYUs3bTFVQ3BwbzRGS2xj?=
 =?utf-8?B?TWJYY3RMWXY4OHRaTUt1QUNZd2VNWkFPVDQxOTQ5WXpPNWx1T1VEUDd2VnM5?=
 =?utf-8?B?ajJiRU43aSt3N1ZqYXBhYTkrTzBtWjlsQjFBcXNsRFZYajFsZjR2czdDcU45?=
 =?utf-8?B?aHlxbjlVNlFEeUlpTUdwbDQ5TTVJRTU5ckdaNVljS1VoYms3NzZvZSs0bDVy?=
 =?utf-8?B?MDdzcG9LS3g5REpQd0xmMlRINlg4Q1RXNTA3WGVQZnBhYWU0YnZpSWd2a1Rq?=
 =?utf-8?B?RmEzVTB1d2ZnNFVTT3p4TzBNckNTZzlCaUJ1TVJCQklHdVJJanFnUEt1dlhr?=
 =?utf-8?B?M1NmeThsL0QxcG1kQVozVnRKa2ZQVUlTVGNhd2VtNHJiQlhhVGJpMmtkYU0x?=
 =?utf-8?B?cDluVFpaeWJWRVhJa0VhWHkvUnE5ZzVPWHIwNWVXM0VZdlBGbG5vODZtajEr?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D92990E01FCE04DACBDE6FED0BF5ABF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lrPZb7AVJ3T1moJjeC1DkFKDBAG78MGS6z4AWwZMfEd2M6WcmnH1K+lqFJOD4XFuOJOjxoebandGlI93obNHQwah4/gdHT2WlaBc0ROP50zXdydCAyqo+7ZkWB5LEAP3a9tRRpLxKmtBSX4wQq5TFeYRO3yFjQN8vQTTr2QsQxcZ4LKZe7qIn8W6f16hz8eN5Verk0tJoiQFFBsvMWLCU/Kz/WeDblVkHnsRnkS4GnWOaHbjq60WRNo3mVrzqQY497LYIfIn0guRLl1cWpU3+z6FO8Abe5UACCRiihnnnZoNrZMD4ExD2vWqSda70WzEaSwSQj/VpRslctDh+VCPD64PIqz2RAc/O690Jn4vzIhAfmbwVKui6dG4AvOovHpX1iHiyimXLvZmSZ8GjDqZPHei01Gt0EfC42sm86E2lQopQfaXNqSi1fi0WjZ3TCVoMfXMiUwce7DSUM6GQbtcJgxUa62ohsJtrPhh2ZGywOrV0iUactRNxh6uZGc6ne85+eqr6zmc57N1UOOV9aAsI8NO+UIclkT+6D15ZEXKOEVENzht4IhyLG3UGfEgCsenHsuwb4ao9zGK9fvnTvyPgM13fFVwuUeNAPW8vtfTLr54eo/M4Be3FLb9c+ZAp3md
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ea3946-8f85-49a4-63a5-08dc297b9287
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 14:29:49.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fq/+KlQ0MYBj1RM6F7yyxU/3jNECtM8P/+XV8dWWxYwA4EOUWY9XwfRivYHGya3vj3gcQXfTGsFZGmpYMICLwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8148

T24gRnJpLCBGZWIgMDksIDIwMjQgYXQgMDI6NDY6MjZBTSAtMDgwMCwgSm9oYW5uZXMgVGh1bXNo
aXJuIHdyb3RlOg0KPiBPbiBhIHpvbmVkIGZpbGVzeXN0ZW0gd2l0aCBjb252ZW50aW9uYWwgem9u
ZXMsIHdlJ3JlIHNraXBwaW5nIHRoZSBibG9jaw0KPiBncm91cCBwcm9maWxlIGNoZWNrcyBmb3Ig
dGhlIGNvbnZlbnRpb25hbCB6b25lcy4NCj4gDQo+IFRoaXMgYWxsb3dzIGNvbnZlcnRpbmcgYSB6
b25lZCBmaWxlc3lzdGVtJ3MgZGF0YSBibG9jayBncm91cHMgdG8gUkFJRCB3aGVuDQo+IGFsbCBv
ZiB0aGUgem9uZXMgYmFja2luZyB0aGUgY2h1bmsgYXJlIG9uIGNvbnZlbnRpb25hbCB6b25lcy4g
IEJ1dCB0aGlzDQo+IHdpbGwgbGVhZCB0byBwcm9ibGVtcywgb25jZSB3ZSdyZSB0cnlpbmcgdG8g
YWxsb2NhdGUgY2h1bmtzIGJhY2tlZCBieQ0KPiBzZXF1ZW50aWFsIHpvbmVzLg0KPiANCj4gU28g
YWxzbyBjaGVjayBmb3IgY29udmVudGlvbmFsIHpvbmVzIHdoZW4gbG9hZGluZyBhIGJsb2NrIGdy
b3VwJ3MgcHJvZmlsZQ0KPiBvbiB0aGVtLg0KPiANCj4gUmVwb3J0ZWQtYnk6IOmfqeS6juaDnyA8
aHJ4QGJ1cHQubW9lPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiAtLS0NCj4gIGZzL2J0cmZzL3pvbmVkLmMgfCAzMCAr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpUaGlzIHNlZW1zIGNvbXBsZXggdGhhbiBuZWNl
c3NhcnkuIEl0IGlzIGR1cGxpY2F0aW5nDQpjYWxjdWxhdGVfYWxsb2NfcG9pbnRlcigpIGNvZGUg
aW50byB0aGUgcGVyLXByb2ZpbGUgbG9hZGluZyBmdW5jdGlvbnMuIEhvdw0KYWJvdXQgYWRkaW5n
IGEgY2hlY2sgZXF1aXZhbGVudCBiZWxvdyBhZnRlciB0aGUgb3V0IGxhYmVsPw0KDQoJaWYgKCht
YXAtPnR5cGUgJiBCVFJGU19CTE9DS19HUk9VUF9EQVRBKSAmJiAhZnNfaW5mby0+c3RyaXBlX3Jv
b3QpIHsNCgkJYnRyZnNfZXJyKGZzX2luZm8sICJ6b25lZDogZGF0YSAlcyBuZWVkcyByYWlkLXN0
cmlwZS10cmVlIiwNCgkJCSAgYnRyZnNfYmdfdHlwZV90b19yYWlkX25hbWUobWFwLT50eXBlKSk7
DQoJCXJldHVybiAtRUlOVkFMOw0KCX0NCg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQu
YyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gaW5kZXggZDk3MTY0NTZiY2UwLi41YmViNmI5MzZlNjEg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3pvbmVkLmMNCj4gKysrIGIvZnMvYnRyZnMvem9uZWQu
Yw0KPiBAQCAtMTM2OSw4ICsxMzY5LDEwIEBAIHN0YXRpYyBpbnQgYnRyZnNfbG9hZF9ibG9ja19n
cm91cF9zaW5nbGUoc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpiZywNCj4gIAkJcmV0dXJuIC1F
SU87DQo+ICAJfQ0KPiAgDQo+IC0JYmctPmFsbG9jX29mZnNldCA9IGluZm8tPmFsbG9jX29mZnNl
dDsNCj4gLQliZy0+em9uZV9jYXBhY2l0eSA9IGluZm8tPmNhcGFjaXR5Ow0KPiArCWlmIChpbmZv
LT5hbGxvY19vZmZzZXQgIT0gV1BfQ09OVkVOVElPTkFMKSB7DQo+ICsJCWJnLT5hbGxvY19vZmZz
ZXQgPSBpbmZvLT5hbGxvY19vZmZzZXQ7DQo+ICsJCWJnLT56b25lX2NhcGFjaXR5ID0gaW5mby0+
Y2FwYWNpdHk7DQo+ICsJfQ0KPiAgCWlmICh0ZXN0X2JpdCgwLCBhY3RpdmUpKQ0KPiAgCQlzZXRf
Yml0KEJMT0NLX0dST1VQX0ZMQUdfWk9ORV9JU19BQ1RJVkUsICZiZy0+cnVudGltZV9mbGFncyk7
DQo+ICAJcmV0dXJuIDA7DQo+IEBAIC0xNDA2LDYgKzE0MDgsMTYgQEAgc3RhdGljIGludCBidHJm
c19sb2FkX2Jsb2NrX2dyb3VwX2R1cChzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnLA0KPiAg
CQlyZXR1cm4gLUVJTzsNCj4gIAl9DQo+ICANCj4gKwlpZiAoem9uZV9pbmZvWzBdLmFsbG9jX29m
ZnNldCA9PSBXUF9DT05WRU5USU9OQUwpIHsNCj4gKwkJem9uZV9pbmZvWzBdLmFsbG9jX29mZnNl
dCA9IGJnLT5hbGxvY19vZmZzZXQ7DQo+ICsJCXpvbmVfaW5mb1swXS5jYXBhY2l0eSA9IGJnLT5s
ZW5ndGg7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHpvbmVfaW5mb1sxXS5hbGxvY19vZmZzZXQgPT0g
V1BfQ09OVkVOVElPTkFMKSB7DQo+ICsJCXpvbmVfaW5mb1sxXS5hbGxvY19vZmZzZXQgPSBiZy0+
YWxsb2Nfb2Zmc2V0Ow0KPiArCQl6b25lX2luZm9bMV0uY2FwYWNpdHkgPSBiZy0+bGVuZ3RoOw0K
PiArCX0NCj4gKw0KPiAgCWlmICh0ZXN0X2JpdCgwLCBhY3RpdmUpICE9IHRlc3RfYml0KDEsIGFj
dGl2ZSkpIHsNCj4gIAkJaWYgKCFidHJmc196b25lX2FjdGl2YXRlKGJnKSkNCj4gIAkJCXJldHVy
biAtRUlPOw0KPiBAQCAtMTQ1OCw2ICsxNDcwLDkgQEAgc3RhdGljIGludCBidHJmc19sb2FkX2Js
b2NrX2dyb3VwX3JhaWQxKHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqYmcsDQo+ICAJCQkJCQkg
em9uZV9pbmZvWzFdLmNhcGFjaXR5KTsNCj4gIAl9DQo+ICANCj4gKwlpZiAoem9uZV9pbmZvWzBd
LmFsbG9jX29mZnNldCA9PSBXUF9DT05WRU5USU9OQUwpDQo+ICsJCXpvbmVfaW5mb1swXS5hbGxv
Y19vZmZzZXQgPSBiZy0+YWxsb2Nfb2Zmc2V0Ow0KPiArDQo+ICAJaWYgKHpvbmVfaW5mb1swXS5h
bGxvY19vZmZzZXQgIT0gV1BfTUlTU0lOR19ERVYpDQo+ICAJCWJnLT5hbGxvY19vZmZzZXQgPSB6
b25lX2luZm9bMF0uYWxsb2Nfb2Zmc2V0Ow0KPiAgCWVsc2UNCj4gQEAgLTE0NzksNiArMTQ5NCwx
MSBAQCBzdGF0aWMgaW50IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfcmFpZDAoc3RydWN0IGJ0cmZz
X2Jsb2NrX2dyb3VwICpiZywNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJfQ0KPiAgDQo+ICsJ
Zm9yIChpbnQgaSA9IDA7IGkgPCBtYXAtPm51bV9zdHJpcGVzOyBpKyspIHsNCj4gKwkJaWYgKHpv
bmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPiArCQkJem9uZV9p
bmZvW2ldLmFsbG9jX29mZnNldCA9IGJnLT5hbGxvY19vZmZzZXQ7DQo+ICsJfQ0KPiArDQo+ICAJ
Zm9yIChpbnQgaSA9IDA7IGkgPCBtYXAtPm51bV9zdHJpcGVzOyBpKyspIHsNCj4gIAkJaWYgKHpv
bmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfTUlTU0lOR19ERVYgfHwNCj4gIAkJICAgIHpv
bmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPiBAQCAtMTUxMSw2
ICsxNTMxLDExIEBAIHN0YXRpYyBpbnQgYnRyZnNfbG9hZF9ibG9ja19ncm91cF9yYWlkMTAoc3Ry
dWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpiZywNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJfQ0K
PiAgDQo+ICsJZm9yIChpbnQgaSA9IDA7IGkgPCBtYXAtPm51bV9zdHJpcGVzOyBpKyspIHsNCj4g
KwkJaWYgKHpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPiAr
CQkJem9uZV9pbmZvW2ldLmFsbG9jX29mZnNldCA9IGJnLT5hbGxvY19vZmZzZXQ7DQo+ICsJfQ0K
PiArDQo+ICAJZm9yIChpbnQgaSA9IDA7IGkgPCBtYXAtPm51bV9zdHJpcGVzOyBpKyspIHsNCj4g
IAkJaWYgKHpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfTUlTU0lOR19ERVYgfHwNCj4g
IAkJICAgIHpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPiBA
QCAtMTYwNSw3ICsxNjMwLDYgQEAgaW50IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9pbmZv
KHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqY2FjaGUsIGJvb2wgbmV3KQ0KPiAgCQl9IGVsc2Ug
aWYgKG1hcC0+bnVtX3N0cmlwZXMgPT0gbnVtX2NvbnZlbnRpb25hbCkgew0KPiAgCQkJY2FjaGUt
PmFsbG9jX29mZnNldCA9IGxhc3RfYWxsb2M7DQo+ICAJCQlzZXRfYml0KEJMT0NLX0dST1VQX0ZM
QUdfWk9ORV9JU19BQ1RJVkUsICZjYWNoZS0+cnVudGltZV9mbGFncyk7DQo+IC0JCQlnb3RvIG91
dDsNCj4gIAkJfQ0KPiAgCX0NCj4gIA0KPiAtLSANCj4gMi40My4wDQo+IA==

