Return-Path: <linux-btrfs+bounces-5143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F137D8CA8DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 09:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B000028212A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB74E1CB;
	Tue, 21 May 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y9V/d2e0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iOs3sePd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B665029D
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276233; cv=fail; b=awjnTALdq2NN4cbcRgLQwhGrApFpPqJjftsfKRp/rkmLVBcGT1pTIKvvnGRLzOIK+YlDdMy9M8ydArrbdpbMI0QTuiBco/17FGQ6p2KHGqQSCxKyWPp7nDtFER7vaOBuYy50cDokw1e8+9GO/alvOTZ5w4/X9PmUFimUkWCnwhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276233; c=relaxed/simple;
	bh=4vvrTF4PxVTY3ZHp/13O2B3/2hP/EqS0M01iRInjE1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZehsqzmuDEgK/8g97yXxIfun/jwPb10D3xkQozix49TGnIpOFsyIYMd9oEEubWBdgdgIcWs9XGF5+cL7X9py8Lcnch5ccsTqXskCxFLgKi4YT7WgCIrLqqe9gE54Srtr3rZVxtLbqW5ghksF+JZuKCrO4k5TiuIiLMjOJ+ERwtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y9V/d2e0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iOs3sePd; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716276232; x=1747812232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4vvrTF4PxVTY3ZHp/13O2B3/2hP/EqS0M01iRInjE1k=;
  b=Y9V/d2e08tqQBlTrNA3+x5DIEPL7O24WyPxv6v2ojahbtwYnwh0wVtRG
   al1PencQK0wAQInabz/M+6XwDITFrbSaNL5zOOIF4CBIIwR/vnLWvH6gG
   XpxHg9CQ3jzBKoRG8t1kXe9FKoZ/7Ira+xwJGA1FhvgpVoKDQTBcu1kwr
   /uDNi6zIDGb+MPHl7EjqM7uA+69Cqvo0NWCEjwVs7Hmy02RQEEBnetMms
   w1ZVQTQ5k8rACXCQAc3rPljViYsytrprIsgndgygBM7pCKtfJ32QHMeTQ
   ZUZgKX77VUXqK/xku1VuGBu68I5lcEQea8Rzv8zX+yfzRnC184yEUPe0P
   w==;
X-CSE-ConnectionGUID: BOWbxYuUTEua9gqpOuIFWQ==
X-CSE-MsgGUID: vsXZ/g92TZOWFbHr+0gIzg==
X-IronPort-AV: E=Sophos;i="6.08,177,1712592000"; 
   d="scan'208";a="16565348"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 15:23:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwOhuJgAZWrRLNXHF3EakPZzlsKai9XnMdmmdGB1edi3bnWeBGBlsBzfRWPOXXj9WZnUnDNohTCjdDMSqz0EZ8PqF87RJ2JqYsfX692Tr0AUAM8gOr5wtBtG0naQJP3sHz1/3J3a07U/5dzQGM5atTTZ2JQk9+H7fD/sXDYzUxcZ11MQzmj+WodbfqFIsqCOUW+lHBrVOWQVKka6X3shOKwxo2qjku7epU7lcD4pq68Mh0E0ub1hBBJ3eoxpUXbwvas8TIYbxwj9YllDhJGAQwzGigxuuj0MDLF+wECCE1nRUL9sYvEiMO2RDnYn7SmjTwSAqj4kzmtugPvldV4iCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YTwVeZ4w1ytWSlDtBg6P4bl5rRHnWqph+l3UUXlvaM=;
 b=hXmS6AarKZQmsu/rwOg/9LwiuPGNYfBD04+gh86MZcN6K/mwFI8mFUUjNQgyptLOL3++gmTytoM58O7zRNEfT3VBQkMdhXnrKgG4zp32GW1NOGWJnd+awVhbtnJ7d55KP+XNVEe1cMx+4T5hvlJm11sxXi6hzkXfVMg0mSBt8Ccq21Vsj4lkCEgLYrvKkLBjczL2FRMiNQSEeW3h6c5hnekJ6GvSxj0kdrsVYLhjQcvdwaUsmTpXRMqXuMmzHF7DVhxmQ5VP0+QftmKwtTo8EjWRfffBHgpgx0zHYSqH9SY5q/Ggp38OpWU4CQSDJLb0E/8xDCtIXLpf8QgvJYppPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YTwVeZ4w1ytWSlDtBg6P4bl5rRHnWqph+l3UUXlvaM=;
 b=iOs3sePdADtWNW6nkIItqOhYwYHH5LRBz8HgJxarpNmeWZVhlDwJLw5zcvG93Us81f31v1jw7LhZpCYApKLb/WQ0V8yEaoPCGqUvrKB9YMd54yeP7LV+oYnx84VpyTFfIrwsC6lOIyBvPxAfWPzZlJ1Jg+FRe1Xi6CdiBJqdRmg=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 BY5PR04MB6438.namprd04.prod.outlook.com (2603:10b6:a03:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 07:23:48 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::8bb1:648b:dc0a:8540%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:23:48 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>
Subject: Re: [PATCH v5 1/5] btrfs: make __extent_writepage_io() to write
 specified range only
Thread-Topic: [PATCH v5 1/5] btrfs: make __extent_writepage_io() to write
 specified range only
Thread-Index: AQHaqOFn97WHXhMkSUS1U4wfkz0rS7GhTeEA
Date: Tue, 21 May 2024 07:23:48 +0000
Message-ID: <s6f4rs7boxkfnqpf3wggzchktcizhcwjedwtuw4rkup7qdz7rm@3rbp4l3eok2h>
References: <cover.1716008374.git.wqu@suse.com>
 <3505552899f398a1d8959baa8245efac7a2070b6.1716008374.git.wqu@suse.com>
In-Reply-To:
 <3505552899f398a1d8959baa8245efac7a2070b6.1716008374.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB7765:EE_|BY5PR04MB6438:EE_
x-ms-office365-filtering-correlation-id: 1402b954-c466-4213-6f3b-08dc7966f533
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2q0t0XNCV27m5xf/HNFdjeV64HZu9tDW/ob53ZFLiln3XPVLB+3KL0/pMWV0?=
 =?us-ascii?Q?Ev6lXbG4w+eYAX5IKv/K3mBv2i5NKPtHOmIL23FF9T+IFuEcvjuDNZ2C5FvQ?=
 =?us-ascii?Q?P7gKKiHlVWPJdpRt5sskAPvvsYXcQ76hMAiq+RvPFMaOP8t/5Chw0N5mzU/W?=
 =?us-ascii?Q?sRA5Dac0KlFuOmlaiEj3bAaNw5P+MHf7oNT6gUjShCPv+gM5Tszr/BLUHmjD?=
 =?us-ascii?Q?mRYxZwgr+HwaUh3tDx5yQgY8QkejQnDmVTrrWEgVA1E+klnwrfvCrqLcPu94?=
 =?us-ascii?Q?/JJz7S5N2n4BsIL5Ctyu+odQIU87X2wQZ3Lcqp1VjZGiH1BD8sHqo9vi6Kfe?=
 =?us-ascii?Q?HRWlYx3indBUhvbzSCwPfO/rr7Mx/2QfMBjq0yJVgaxuaw5gPaz4dOUa5iVy?=
 =?us-ascii?Q?cv8smdN1HrNqpD7AMQLu4sOSuNvx+1empPSaiB4nKd2hNR4pfUp45OFHFC/a?=
 =?us-ascii?Q?gSQW0xhtgMYz63lz4cK1Bn5OCuw9kh1E4lePCRnRwejaPmYO/zLzjV4/0lme?=
 =?us-ascii?Q?zIpMRImx48RBp73xUaSfrRe8u3l55G1T8vemAWY9mTwXK9uuGFHpN/b4PPS7?=
 =?us-ascii?Q?RSvgv6tYPOhvgjRe4TpK6G1vBzmRa97ZRrzulvMO8faHpirarappYbebpMhm?=
 =?us-ascii?Q?D8Uygln7S0Sj6qJ8kManhuykB44QGeMmgJLBgg2JjMUq3S7jPIevSXHmYABX?=
 =?us-ascii?Q?rQnw2PPRfX0uNUiNWB2UkLYcaK7dZrTM+s9A3cdm9pVU2+njpmk4Kmk5juUV?=
 =?us-ascii?Q?9ttba2Z7B8mB2NuW8aaFtv6Yl8d6TplBRHzL7AR+ffpri8aujdQ7SDMYdQM6?=
 =?us-ascii?Q?1c9VGRBTcsJT4QqPIF440wTy21svSn24XheRm7cKev1jH6TTsNyqIN6F6l2i?=
 =?us-ascii?Q?Lz9T5c06E66nLQZ5iw3elaKjXGQFHJp7Um1aOESDajJqzeoj2iD1vKkNtOxd?=
 =?us-ascii?Q?FmrXCMtX4bzmBqvFnKUSnSSPpXSX6nBDnJB/TpUGnQBsNC/tpLdeknRi59D4?=
 =?us-ascii?Q?2CC64gPOmWlNOhBkz1fAM2IO3ZRGe8SIGCos45WFIwWUKHZAIgoNDOx9cMEa?=
 =?us-ascii?Q?M2bbA2M1UemKoKujMBV9pwZzsGHO5Il+LWVEmlKb8D8nBT/jSRjJSqyihsAn?=
 =?us-ascii?Q?TRk621gBbahMHkHZJEVhHQPam6xr7jV8Mn2ZS2y1cHyq84XHOAKGzBGMLA8b?=
 =?us-ascii?Q?fnMkPAuUeCzBPk2qJZMxZEJ2PSLhhE73BeYeqJLPpIYcLs6Aki8pqPYw0Xx0?=
 =?us-ascii?Q?DRrOZfJEwndolduXuhrdprxj3qptYgYzd1te34wZvAIlGNiYtTMrD/RIZDXq?=
 =?us-ascii?Q?+SDC9xanXNzLaZ0705sWegCFncbxOzWn4KKaGgM8VPv2Cw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BCt1GDppkfDX0RXdTv2j+Y9vjVDTTla0svTXOo66jvhddFqEaeQTNdQ3Tbhl?=
 =?us-ascii?Q?B3x/WO/wkzIWjEDwPg00uvFreTX5rLsHeWx1OuYV2NBCLhyMHqsttvsv1+w0?=
 =?us-ascii?Q?CuLGGc6HgEodo2Qrh8ERMon2/B7FfWlZqlDZLn2pzzZqu4xAtq6BYSAtfkul?=
 =?us-ascii?Q?1UKEa7gpPdsDeeGq1+hwjwiGCTtDDk9TCV+7xtPw6SY+Q50YxNHjvoUoIKdE?=
 =?us-ascii?Q?SofbwozxGfEVBDT4c82HbWvv7jMHYB3I5AnwNUdWUJ3RRXimKzqz0B4CBsJ6?=
 =?us-ascii?Q?UldoDoYmWi6rUAp80A0ZHEMV/Y3dNnb9VxsJ9+cSS/oXACB8lBPpdksqLJye?=
 =?us-ascii?Q?3U72RP3nWgWg4HqEyHPB0VCKNaD/rsT/sZIYL6B4ijPzZxv6N3pGFEl7wymI?=
 =?us-ascii?Q?i0Q6Bmg0Dy0/N3k4mrOEZ5ZIUnG2K9iGH29JbHDe8fSS/bMCBvnfP2Q+SoUt?=
 =?us-ascii?Q?pR4PYwjPjNMx7tftp0RCQCtvAs0/CI5MrqANxWVHUdk1c1fLwAKK0ODGxqI1?=
 =?us-ascii?Q?jbYvDLsrm67E/yMdF3Ys2G8JET1bbx6RGTBSCm4goDMznvgDW3wFPSuuWdCd?=
 =?us-ascii?Q?2VQy3XqYwhj7k+4GpJtuTnZOwAwfz3xVwGB56b1LlnufFamEwJnp84YjArPj?=
 =?us-ascii?Q?qySzND2txRc+npHTfkrELqK0GtnSg0cCyChRVnn2FYiH/pi2s5VE+AqspWAS?=
 =?us-ascii?Q?yLib63APLzYBJhUNVSVtIDH6Q5A7mIFVfd8Q99fZoo3kKrlgcsdyw4dNnrEq?=
 =?us-ascii?Q?IpYCm7iixPQOnVj1ydhDGKkyfa+vRQU6JdQvo7pd1klQ8mlfLV5uWqtidcZ/?=
 =?us-ascii?Q?lzsFklsHin08ysLvgAvIJHKZdM3zlqtUAZaRyCHLCpnGrwUdQiFF3lTlEoGy?=
 =?us-ascii?Q?QdZxUlAel7TQCAk061v2cZwD6KYEJTEyO70HfgmnpFlqSCqtXAPkBeivuzyB?=
 =?us-ascii?Q?BzgK+wcsaGbVztdd/0bVQRqwpXNmyPFpfrYc5t8+jxWEHSP7zqNJQvw9WkXz?=
 =?us-ascii?Q?8lJ9VSZU/tRwZVly+lITeptNJLjfiNLX7tWdoKsqgQsFVl8hwHeXRt+8KaXl?=
 =?us-ascii?Q?RxQj957pAAqwrjkVtp1JHYnuhXOAU8sANbGMUnyweoUVhR3GNJgjpDaGuuZy?=
 =?us-ascii?Q?sfVlOLXmm/1lZABvPdmPcewhn0Q0AeJttac67MojZEP2CSssMs5aqep+Ml9g?=
 =?us-ascii?Q?PCau2UvUudSO+9PCxsq2+YyJk/aGqbdYFf4G4fqNqRLkPSXHLFMd+Mamr5sl?=
 =?us-ascii?Q?kcMMF9iL68zyaoKzg2OgBthAoUQ2XYUr4i0WUrFbcKIXoEf4U5HePBHME7Oj?=
 =?us-ascii?Q?MFkmQsTdXlyx71Up04cW6oBq1JL/L+msIaUrTqbCh6rvfP4YVWb9amj6+rFJ?=
 =?us-ascii?Q?cCl3jACCV9jLXZjoFZJelEzlZBhO79HFcp5VEjeSd6QEcFNEKr8BOtqn43nu?=
 =?us-ascii?Q?rq05XIqzMxXrTqdk2IRcO/uxGYCrYoSXRD1m2n1KlD1NcrhIaPHtn4dK/kYX?=
 =?us-ascii?Q?+cp/JsoitaVbwAe16zn6iQ3J9hS/bc9wz4QwqQ88CP4A04SFuV02/jRu4qZr?=
 =?us-ascii?Q?3OvFGSbDaeHQ+e+Z6YbAP7y+tMa8Fj2+3isySsRTReTelkz7eLNgcaoVmhok?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3E6CA1EF8532848AF5EC31DE34CA0AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eicql3OMiNz046HifPMGB0PwN1qXz9X1x+KX7XWL5Hw9Lj1OzcaRgpadXP4Fjqv01P+OLMzmWFUsBOj9YnwgEYaA7laIjBmfJcO/jO3/AWlGOhP0tpztru7jS9K7vRjbLM8C8Xmupib6YGjjZrVs/p8BYLQXLNv/T9rldvUAX32R0iZtwjY1/BnKHEkkTKb9KPqLlayy8sIgRvpcBDEpyYUqY/ckZsawqq504/EgqBfpuGg1phS0j0Go25XSEdKlSutjPIdyzsW4kW6UX0nzXDz2oY12QRs8zzC1Ta8ZdtrLOL5rGM1jF0JQEnwAMGPRii+trTfxudEvkrOkzMZIOV+lkc5hRK01j7JlOI1otBwivTl0WHaXJxTtHlTxnHwhS78OtXgWOdn3XzLCorrUneAhx+KY2f8EGxuQuu2JtrEcswWyD+TBne1NkFbQGr2J+WJo5V86FJYGrs39phi9ICPjxQDsvaGOYJEVdAFLCtk+BDwBonPz4/3Y+lK3fLuTTsUMPSYl9mbjOD7UXsMvOaqEbwv6QWNZnFOsD/Uk6PvVGc2HyUBpDKa0Gjx0aLN/rQLlHiWfUBoQVxeB1OjeQS4qmR6853wyMJa6YaehDcTU7rvbRecgB3+TIDCcouA7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1402b954-c466-4213-6f3b-08dc7966f533
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:23:48.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57lsDAIUHDldV6vk2WeCcITu4bSYXsyIjSkHg3ETqQUN9Pp1mBD3HFLW+DvCTEJ31QaAR4tkWw5G4UY2FAKjeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6438

On Sat, May 18, 2024 at 02:37:39PM GMT, Qu Wenruo wrote:
> Function __extent_writepage_io() is designed to find all dirty range of
> a page, and add that dirty range into the bio_ctrl for submission.
> It requires all the dirtied range to be covered by an ordered extent.
>=20
> It get called in two locations, but one call site is not subpage aware:
>=20
> - __extent_writepage()
>   It get called when writepage_delalloc() returned 0, which means
>   writepage_delalloc() has handled dellalloc for all subpage sectors
>   inside the page.
>=20
>   So this call site is OK.
>=20
> - extent_write_locked_range()
>   This call site is utilized by zoned support, and in this case, we may
>   only run delalloc range for a subset of the page, like this: (64K page
>   size)
>=20
>   0     16K     32K     48K     64K
>   |/////|       |///////|       |
>=20
>   In above case, if extent_write_locked_range() is only triggered for
>   range [0, 16K), __extent_writepage_io() would still try to submit
>   the dirty range of [32K, 48K), then it would not find any ordered
>   extent for it and trigger various ASSERT()s.
>=20
> Fix this problem by:
>=20
> - Introducing @start and @len parameters to specify the range
>=20
>   For the first call site, we just pass the whole page, and the behavior
>   is not touched, since run_delalloc_range() for the page should have
>   created all ordered extents for the page.
>=20
>   For the second call site, we would avoid touching anything beyond the
>   range, thus avoid the dirty range which is not yet covered by any
>   delalloc range.
>=20
> - Making btrfs_folio_assert_not_dirty() subpage aware
>   The only caller is inside __extent_writepage_io(), and since that
>   caller now accepts a subpage range, we should also check the subpage
>   range other than the whole page.
>=20
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 18 +++++++++++-------
>  fs/btrfs/subpage.c   | 22 ++++++++++++++++------
>  fs/btrfs/subpage.h   |  3 ++-
>  3 files changed, 29 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 597387e9f040..8a4a7d00795f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1339,20 +1339,23 @@ static void find_next_dirty_byte(struct btrfs_fs_=
info *fs_info,
>   * < 0 if there were errors (page still locked)
>   */
>  static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *=
inode,
> -				 struct page *page,
> +				 struct page *page, u64 start, u32 len,
>  				 struct btrfs_bio_ctrl *bio_ctrl,
>  				 loff_t i_size,
>  				 int *nr_ret)
>  {
>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	u64 cur =3D page_offset(page);
> -	u64 end =3D cur + PAGE_SIZE - 1;
> +	u64 cur =3D start;
> +	u64 end =3D start + len - 1;
>  	u64 extent_offset;
>  	u64 block_start;
>  	struct extent_map *em;
>  	int ret =3D 0;
>  	int nr =3D 0;
> =20
> +	ASSERT(start >=3D page_offset(page) &&
> +	       start + len <=3D page_offset(page) + PAGE_SIZE);
> +
>  	ret =3D btrfs_writepage_cow_fixup(page);
>  	if (ret) {
>  		/* Fixup worker will requeue */
> @@ -1441,7 +1444,7 @@ static noinline_for_stack int __extent_writepage_io=
(struct btrfs_inode *inode,
>  		nr++;
>  	}
> =20
> -	btrfs_folio_assert_not_dirty(fs_info, page_folio(page));
> +	btrfs_folio_assert_not_dirty(fs_info, page_folio(page), start, len);
>  	*nr_ret =3D nr;
>  	return 0;
> =20
> @@ -1499,7 +1502,8 @@ static int __extent_writepage(struct page *page, st=
ruct btrfs_bio_ctrl *bio_ctrl
>  	if (ret)
>  		goto done;
> =20
> -	ret =3D __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size, &=
nr);
> +	ret =3D __extent_writepage_io(BTRFS_I(inode), page, page_offset(page),
> +				    PAGE_SIZE, bio_ctrl, i_size, &nr);
>  	if (ret =3D=3D 1)
>  		return 0;
> =20
> @@ -2251,8 +2255,8 @@ void extent_write_locked_range(struct inode *inode,=
 struct page *locked_page,
>  			clear_page_dirty_for_io(page);
>  		}
> =20
> -		ret =3D __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
> -					    i_size, &nr);
> +		ret =3D __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
> +					    &bio_ctrl, i_size, &nr);
>  		if (ret =3D=3D 1)
>  			goto next_page;
> =20
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 54736f6238e6..183b32f51f51 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -703,19 +703,29 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked=
, folio_clear_checked,
>   * Make sure not only the page dirty bit is cleared, but also subpage di=
rty bit
>   * is cleared.
>   */
> -void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info, s=
truct folio *folio)
> +void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
> +				  struct folio *folio, u64 start, u32 len)
>  {
> -	struct btrfs_subpage *subpage =3D folio_get_private(folio);
> +	struct btrfs_subpage *subpage;
> +	int start_bit;
> +	int nbits;

Can we have these as "unsigned int" to be consistent with the function
interface? But, it's not a big deal so

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> +	unsigned long flags;
> =20
>  	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
>  		return;
> =20
> -	ASSERT(!folio_test_dirty(folio));
> -	if (!btrfs_is_subpage(fs_info, folio->mapping))
> +	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
> +		ASSERT(!folio_test_dirty(folio));
>  		return;
> +	}
> =20
> -	ASSERT(folio_test_private(folio) && folio_get_private(folio));
> -	ASSERT(subpage_test_bitmap_all_zero(fs_info, subpage, dirty));
> +	start_bit =3D subpage_calc_start_bit(fs_info, folio, dirty, start, len)=
;
> +	nbits =3D len >> fs_info->sectorsize_bits;
> +	subpage =3D folio_get_private(folio);
> +	ASSERT(subpage);
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
> +	spin_unlock_irqrestore(&subpage->lock, flags);
>  }
> =20
>  /*
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index b6dc013b0fdc..4b363d9453af 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -156,7 +156,8 @@ DECLARE_BTRFS_SUBPAGE_OPS(checked);
>  bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_i=
nfo,
>  					struct folio *folio, u64 start, u32 len);
> =20
> -void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info, s=
truct folio *folio);
> +void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
> +				  struct folio *folio, u64 start, u32 len);
>  void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
>  			       struct folio *folio, u64 start, u32 len);
>  void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_inf=
o,
> --=20
> 2.45.0
> =

