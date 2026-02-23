Return-Path: <linux-btrfs+bounces-21843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPkhMClwnGmcGAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21843-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:20:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50458178A51
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6774530FC166
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6A1FC7FB;
	Mon, 23 Feb 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gEygbyXt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ID7Vj5hd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FCD26ACC
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859736; cv=fail; b=LsCtsMJ22eBIUaZn5QY1UTUYiDAGD1+mk6u9+kr6KSb/ZwBxsBwTa/WPVJgxlAc15KN0qr3tRnubNnDa6G9o/R7yXlsmVF0ssoFbveJB1+Ip+x+tiTQtld8zm2BgZqqG3NFwM7fDweLSp77z+/VD1D1M++kQsxNGlXkqAbtufpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859736; c=relaxed/simple;
	bh=L1O5ZWtdMvVRBU/LL6hRt3zh6DRTX5RhO6v4iyP0tXE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZ0p2S9hjahgXZWMdeMLNeFjVsnNE1Q6DuNzhy5x3FD623SG1vAlT8tGEGfKmlFZaQHELnaRLdo9V7FZ6tz9s+fkMe/do+7DDJukzV0NygmzKDbOkNMK9jh6fKhRjoEgqI46eMf9Hs9NFyngs70a22krMVwow+XMY07HbOXCNdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gEygbyXt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ID7Vj5hd; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771859734; x=1803395734;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=L1O5ZWtdMvVRBU/LL6hRt3zh6DRTX5RhO6v4iyP0tXE=;
  b=gEygbyXthWB5GVGuxnVuEGlsiZFmBiNRMcB9rxwZP6rppq5AFgHD78uX
   r6O0o6AIlif2T8Tk5KvUKvHzmKtx++/73/C+nSPFgdDVjF/naWpXWRg2o
   CTMNeFyVxLFN0kQ40pzh+WheIktwp/jNFjKRUk7urPPwyqFjWAdrQJlTZ
   yVn2xrkHDb4imS8Lqvj/AjE6RhFSaGq57ySYuWBKX3aEWiB+4MVKIsA1R
   Y+uDYT84iwVE5Ly1I8vNE0/rZulPfmk8G588p6smu1eBcRK2rR+bRJ5Ba
   oydfJMca06TPCyTShbbwwH8w0SG9dDLL0ZfEVsoX3Nfu00tS4LZpQl7zX
   g==;
X-CSE-ConnectionGUID: dbk66mv7QIOFGeNmY5mG2A==
X-CSE-MsgGUID: 3HBui9QgRFG3mNIstdpcRg==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="141236167"
Received: from mail-eastus2azon11010041.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.41])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2026 23:15:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwQayZHOc3YMCnflBozNxjUZa9ecBH0p8MLAy6NeN57UgPwyxcoriZ4/qVYpo/XUESk8GWt4h/i2RRIrlPv6SIbuZo1Hj1IJpTCONYarRLO0v1hui6f/ZC2TH9aAT7YRk0n1JiVG8MTGRqgq+s9XsS0824H18t9+h5J0ETMSX8qLkHi3grhTJbz3KTuI5eoiGcrC4KPdOBr+vSCLWAqCbCBY2B67m36DeLwVqrseLgQ1Cl/rDTuFaSGvTJiwmDyAHmgVxa8NGgH2segASxpyn7viYw1oJVAe5KKOEdHpFX6avQTplU8QDSOFZf9pBvHKAytSXzfVPpbTVkNmW9ImCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1O5ZWtdMvVRBU/LL6hRt3zh6DRTX5RhO6v4iyP0tXE=;
 b=zMEyzQcLyrnA+9UlJ1lvypw7kR4filTyQzBKJn9GyQ9vbbnL2V12jyjM+Ee5Oud/plTqj0UIcsPYLjNy2Uatn0ILhuCHi4tH+fHWCPH9k2WeKbNiPdc83NBISwlmh7ZFlIB33hyxovP42j36rJshL6cmjJtr3+iyQNkHa5sUT7guHShVIL4E2fK5NMmRKIm0RtrJWTHzbRfJm476h8xBBjglOfNXu+RF/yyPYlFVCyRTftZbEj1LPY2x0GlhuSGU267Vg4Xe2G1pzaif14mHVwp2UxEMGEFtz7jwN5mSf+q55BDE7Y/zIpIYrEruO4jItm0nRQPeGzzjhWn5HSAm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1O5ZWtdMvVRBU/LL6hRt3zh6DRTX5RhO6v4iyP0tXE=;
 b=ID7Vj5hdSEkM7WkEzGrpHLZoKMiM22BZKmsrc1j+x1g5rPqgztykVLMpNO3XDllrKflQCTja/vTN62Y4Ggf2lIxpEyRUKscfwhhgfvo0VDi0J7+oUjHhi3iJDNnDFTBsLxVOYQcTCyK4oL7Fu1RcfdFqN+8sVp85uUFC0b4hsmo=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM8PR04MB8181.namprd04.prod.outlook.com (2603:10b6:8:c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.10; Mon, 23 Feb 2026 15:15:29 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 15:15:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jorge Bastos <jorge.mrbastos@gmail.com>, Btrfs BTRFS
	<linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs with zoned devices
Thread-Topic: Btrfs with zoned devices
Thread-Index: AQHcpNT69ySDE1ydxEuNv3EvK2dfMLWQZNOA
Date: Mon, 23 Feb 2026 15:15:29 +0000
Message-ID: <6e46e258-4589-4cb8-8548-036ad36884b5@wdc.com>
References:
 <CAHzMYBSfK7Ms9W9rc1mzsyP0aRkXg=3G6VXuur15jm7OE2JoCA@mail.gmail.com>
In-Reply-To:
 <CAHzMYBSfK7Ms9W9rc1mzsyP0aRkXg=3G6VXuur15jm7OE2JoCA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM8PR04MB8181:EE_
x-ms-office365-filtering-correlation-id: b4c3acf5-1142-42fd-a504-08de72ee6164
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NElNNmRUREZqY0VPMklWNjFsY2d1cGh1OTluaHJNNkZWdmsrOHM0dGtoWVFl?=
 =?utf-8?B?RzZZbVN2em10QjFvU09YaHRma1IwR1Z6OG9LbEF6Yjh5NUZPWGZHb2pqSlFw?=
 =?utf-8?B?NUlzNHBMYm96MXlEUnVJSG1PNkdtcnZtQkpWaGxsTlRHY2VYT2tOZHhlZVMr?=
 =?utf-8?B?RDNTRFVoM1lDMm41YXpleEx1eDc3SkpDcitGNkw4cUJpbml6cnlYRy85VTRE?=
 =?utf-8?B?RU9WbVloaStueU9DNnhtbGo2WGt2UExSUUJqelVGOGVuclNGUWpHcU9xdWdD?=
 =?utf-8?B?cXFPbU01RjV5aGtzV2I1WkhNYXVnY2hweWJWZUlQaUhWeWx0VFRBVGZNZCtq?=
 =?utf-8?B?dU9Sd0pwWWtoM25JcjVKMUxVQStzbDlKL1IyaUtLb1hCV1FTdjJhZ1pNUnZV?=
 =?utf-8?B?dzV3bVBTMGcvVkZvWGl0elZZNUJra21veDVSVndPeFdTekpwTzVNY1BiZHNJ?=
 =?utf-8?B?clJGYkZBbThsVTJuMS9PdGxsUlR3emc1MmdYUVhZQUxpck9MY1JMbDlVNnJK?=
 =?utf-8?B?ZVVVY0J2QU0rU1RFLy9NK1hncWZxdHJEUWJBZ2VrUk9FSjJPd29wRkNWanV6?=
 =?utf-8?B?ZnlldWRQQVJXNDMvazFac2I2cWRKcmNHeWw2TTBvMmo0bmhsSVZrTEFjaS9K?=
 =?utf-8?B?THRldy84eUkrOW5vbktDV0s0MEtXU0RLQW1DRlMvMlV2dG1KZWh5NGswazZH?=
 =?utf-8?B?bGFqU0RTUUpHKzM2bElCUUt5Z2Q1VlhuT1pKbHFPR1FGa3VpOTdVNVJ0SUZp?=
 =?utf-8?B?aG5tMTYrc3R3aEl4N0NrRjNyZDYvVjR5VVBVMGh3RDR1am1UNEl4anZTN3lN?=
 =?utf-8?B?WnBuQ0o2WUpibFFWc252UnJyOVRlbFdqbzBPQmU5VFpmblNYUlJTY2JkRDNo?=
 =?utf-8?B?NkliYjBXQ21uVUpHTlo1RDBuNklhc1FuZ0dITHZHSnkzeG1TcEl6ck9yaFZN?=
 =?utf-8?B?U1hjMEorcVdtdVdNU0ZwUldhbFozQ28xZ0UyMUljRVlkRXNRd05rNVNaUVVz?=
 =?utf-8?B?NVhPajZqN08wQWlnMW5WSG9Cc1RZQ0lYeEdvQ2Nub0FITkhNNTg3REkvS1NJ?=
 =?utf-8?B?dGpUWnk3V0poNkhxWTVzbE1CbWZVMU9rQSswQW82b2JBSWV5NzUrbFhNbE1o?=
 =?utf-8?B?NG9NQzBuRFNIUkh2MFNYeHJRdktmU3I3SmtTV0t4Qjl4S0o2REhDcmtpRGdu?=
 =?utf-8?B?M2VkK1A3d25CREVVNjVXVzRsbmdPVUlneXdPSTVjTi9TREFZRHNrSmt6ZG9l?=
 =?utf-8?B?MUorU0ZJWlA4bWxNa1UxdmpDakZpaHY4QnlpTlp6VkxwQjlPY0ZoUjVMVzRu?=
 =?utf-8?B?QkYzNThHRXhBRFJ0cm5IL0xPYVFRNUc5LzlDaVh1SGJGYWhMN2hTVUpkUFNq?=
 =?utf-8?B?QkIxdGFrVVU2bmg1SW85NVlNL29YRytXTm5CVEtQdTRCemFDT0wzczlYcHJs?=
 =?utf-8?B?MHA3eERGSTc4YTFNRFMwY08wb09XdkpnSE56NUYxRG9kbFJKQjdEbmVCMGwr?=
 =?utf-8?B?WVYveWh3M3J2eGJJQldoaVlnNXQvYnlOWktSNC9pZ2diSGZPMHhyK3htUFh6?=
 =?utf-8?B?MXYyYytGUzZuREtTUituSWM3SkNnV3cxZUpkUUNHTFlTZ0VJbjZ6UUczR1RE?=
 =?utf-8?B?b2ZYS2o2Y2ZSUS9ha21aMmxvbEN2QjdYRnAxenZyd1Y2aHNOL0J1R3FqUnhN?=
 =?utf-8?B?a2RDMkduTGJmek4wN0o3ZVplU0hheHNRRjJIRWFRMkd1SDNKMWhyQ2lGRmIv?=
 =?utf-8?B?bkNuaFZpcEl3blU0NWd2bGFjb0h3Zk5ZMnlRSUZsZU9mRE0yb052Sm1abmY3?=
 =?utf-8?B?Q3RPSUFiMGoyVzJVM1U0Wmlnd0VEL1BJbCsvTG4yZlNzT0ZGQUxvdDgreXBt?=
 =?utf-8?B?ZitldDFhTVJpVmVENklpLzE4d2pyK3lJQ2QyVk9QQXFmdDE5UWZkZTVmSHds?=
 =?utf-8?B?ZGxZb0g2UTJubWNPenJKZnMwU0NRWVlYWmJrNUdYSnBtZ3N6SU5mTEk5dXB6?=
 =?utf-8?B?RUVJd2JoTVhTejNxbU9BMFFmcWhhRUZlWHRuSDZ1UHIzblRyWkpadUd1VTd5?=
 =?utf-8?B?QTNNMmN5K1pUcWRlaHhKZXNJWW5WdUtzTnlNZzNMZmdPdlVyQzdBNGNBeXh0?=
 =?utf-8?B?dkF3OVNaeFJnVHhiQitTS3dvS3h2TzNOWGdaeEgxSGRxR0oxbkZrZ2cydFB5?=
 =?utf-8?Q?+WHqPTJr9TQmknIUqTNsjfI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mjd0NXZkd0JoT3lxcFlWTks1SkthQ0dPdUkvaUcydHdxUUZJUjZDZlNjb0VO?=
 =?utf-8?B?V1hlbi8xdUpLQkR5ZXllYWE1OFF0bCs1VE9zNU9KWnN2R05LS0hyM1J4Q09E?=
 =?utf-8?B?NjhmR3pxTGZyVzA4ZmF1UDV3Q0xGcGszNkwrUTUvWldTTDFkYi80ZWIxYVlX?=
 =?utf-8?B?Qjl5c05IU1RZMUhUY2t2TndYK1RiTkcwWVVnSVhDOWZ6L0NFa1dQeFlpcWpx?=
 =?utf-8?B?WHQ3MS9HVGlBc0xDVHdFMFJDUTNEenppbHRIZ3FRdTVzLzlkYVIrTTdrWWhY?=
 =?utf-8?B?eUp3U05hTXhNcVBFKzNrTVg3SndSOGpyQUFxdTRHR25pd2RoVnY5SlI1aDFE?=
 =?utf-8?B?Rk9Oa0ladDVySWQ0U3hhVU9URUVhV2tsOVJiK3NCaWdEcDZPaFdTb2JHY05Q?=
 =?utf-8?B?endRRkVhUmRhVHUvd3JlalVmUGNPL0kwTHpRRXc3RmhTOFBiaEZJalc2TWdS?=
 =?utf-8?B?U2NOYVNwWkQ0aGxHRW5taEJHeXlNVHlYZ2hhSWxodUNlNEZDdnZNY0tWdmpB?=
 =?utf-8?B?cmpiNk9Ma3hnZU95RWtnckxZTTI2cjArRGJ6WkRQRk5EMlNsM2FWWVliTVFN?=
 =?utf-8?B?K0ZWL1hZWmx2dmpucXFqSkpxdTZYOGJOcHNPUmw0VFUrc1ltanhMTTlabHlw?=
 =?utf-8?B?SUxzY1JpZ0hqcEZlOVlkYnBveVoxQ0p3YUQ2dFNJbmpKTWFBek1IM05Dam5s?=
 =?utf-8?B?Vnd1WWJGaEtUbHpwcDRrZ24rdXJhSXRpdkRmM2Y3R01COU9ndUxIVWhWaTBH?=
 =?utf-8?B?UU1VdXRJK2ZvcXBEOGQvcjRteGlYdEZ2bU9uQ0lzR3o3ZVBFL1JRRHhlN2ZS?=
 =?utf-8?B?NWt4dkdvT3RFNUZPSFRWdjZHNDhtUWtvbURLd2tXZzZXdmd1NG5uM2VxSWlz?=
 =?utf-8?B?Q0Uzdm9wMXh1WnI5MGhjQkFuK1Y0WUlya0JiSHQvQUVxN01tWkJKQVA3L083?=
 =?utf-8?B?cUlHY2c4WTRHR3dzMzdBWGlCanllczRZbzNQQjJwbGVZTSs3S1ZKL0thbHhP?=
 =?utf-8?B?VlU3SjJTWTR4U1IrU3dsUWpJY1FpU0lHTGxDTXBCZVVJSUlaZWpRY2ErK3lE?=
 =?utf-8?B?YS9ibFR1ZzVKK1NEWWxMMmRvMGd4aGVYMlQyUSsvRWZqL21NUSs0dWIrN2dE?=
 =?utf-8?B?d3l3UUNlQ3UxeTlaWE1FcG55dlhDOHB0b3UzWUlFc2s3S0RxcHRRMTA1aVhn?=
 =?utf-8?B?Q3M3Tnp1L1JMc1ovZEZJaExrL1hYQVhvUTR6cEV1QmV5Z3M4YW5ra1JjSEM5?=
 =?utf-8?B?VDRtS1FZTm1RN3JMOHpSWWt4SWVvc1ZycU1DUzZSL0k1M1J4QWtKMHFjcTBO?=
 =?utf-8?B?NTd6SmhXL2FuZDRldFp3UFEwcU00V21meEZyZ0dLbGZWQlFKU05jSVU0YkNH?=
 =?utf-8?B?RDJEQTFwbmZTdFFwNVJTdUc2UFV1aTlEeWN3dURlcUtKUFFmN0hPUFhXLzk0?=
 =?utf-8?B?YWVRZEgrekhETjVxZFh1Z0JQVGxWS1hUR2pndEJQaW1hNjJKaWpPc3hSZ2ZE?=
 =?utf-8?B?RWttVURjdnVXbnQ1Vi9PN0FyMWFpdWcxYmQyOUh1Ymw0V3BHTEI5VTVodGdm?=
 =?utf-8?B?RS94UkFNTDQ3eHlOVzVuZmJjVHlrU2J0RTBrc3dETkNhVjNXYmVraTQ3anhp?=
 =?utf-8?B?SXZZeEFEbldrREpma2FDNUtvWHFmelgrd1dNWVcrTHdmV0poNm5rU2RuelRP?=
 =?utf-8?B?T1QxcUpVNkZMR1BQN2s3UXJCT0F0NTVuNEphUHlBNFJhZWFXVWFLOENRNEcz?=
 =?utf-8?B?TVBaZ3Z4MmZlOE1SdEFZM2w2Ti9aZGFvUGdSdGtCSm5nNDFVTUUyZ0VpR2hN?=
 =?utf-8?B?ZTdWNjdQaHFXaDdFRk9QdW1Kc3dDZkJGTm1heldiMWYxSHBJdFoyb3BYMmJ4?=
 =?utf-8?B?eHJDUm9PVUlpd3Uzb1pCRWZhWW9idUtzQW1BTmxTczUxR010TEVQM2dpQ0do?=
 =?utf-8?B?aUZSUUVkRXNNajROMHZITHRYZEx6NGZkMUJlYm5VU3dWZC94Z0M4dVYvQ3Iz?=
 =?utf-8?B?M05zS2hvaTM3ZHlQZGpZS09KTHI1U25HaWNnditwR24wemFvZjZqTWU2RUov?=
 =?utf-8?B?V01mMUd0S0QyRXd5cHp0V1pNeldaU0ZWdUZ6Ulh6L0N0Ry9EQ0NUZnpyckt4?=
 =?utf-8?B?b1lZTVUxVE5kSWdFb3FTUVpibFY1OXFPb1I4S3hjemhvem03SXg1ajVtT3JB?=
 =?utf-8?B?Nm91Y0h2MGxya2diZGlKc1lzRU4wNHgzSXJTY2szVjR1OHQ0cS8yekUxRWVy?=
 =?utf-8?B?c1hXeGFRdTBaV1haS1VNcmdQUkRxSWZhdGs0WTAyYmkwVHovYzlENFJPd09z?=
 =?utf-8?B?MzR2cEJNRlZkR3VPU0lmQUV4N29OQUNQZFordkp4Zmdmc2FnM2djcEVxekxq?=
 =?utf-8?Q?EQPkRYxUyU4qRCdTwsVj6oVemLDldKxsby/tsVqqnWu2c?=
x-ms-exchange-antispam-messagedata-1: mlpc2QlEMWb3YNtEc3ykzcdpWbkMS/hKdaY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1501436D885AB44791E1BCF286BF770B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dvcF7Du+j6dVimEqQxb17ZxgXjHRnDjF64SE1Brnbza6ZZUPJEytjNzdbUErmPWa7nsab3k0FShrsYoULy/Fkm9sVVTNemSPpD4pEMZ9YD0SQXqhURpSr3NzXEd18tCQ+68/uk2lqa2RxN8V2n6GnHHkiLi2NG2DNCAxghfQBl85OnLfMr8XHFFhweC1rG/bQK044ZlHUjXOimZ5d7Z9uewuz3jSiyOAWmiucM+i0c4DiE7TTXljrm+2hHGdTBAnZW1WmsZZycOl59iJ/7m7BFswNkJLLxRq+Ttc8WxczPQsgKETz0TmboWcivkg9GkPwqPahqAaR4Y4XP42Nkr0PZftojdQSCX2qYTOtmtfvyFAd+XQbL6ZgwCJH3rYptZof8X3iFpOarcngbXQ0uN54gjDwrl0nG1ZfPk+bB/4RJwf5cMMu5a5etOPhJ7BNQ2zBLw3Su8K5IiHkNkrBpkVBTyqjR76ORcEKiFTbbiJuIGPCi5Fds+1lPWZHp5LGWhxY3ONKBQ5Kofx9LLr0pOTMw1h7fBBt7/UxpEDny8inbwmEzc6A2HkjYgiTImIjvbUC7ORgFfVFAyRHYpoSJl7QC9qieR/lthSh5kuTNgVZ57FoImdKXALgyCO1TMkJPdE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c3acf5-1142-42fd-a504-08de72ee6164
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 15:15:29.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deGNmlzQOGQvCQQY0UPaiS5g8JtBthJ8R3Ca0agrfX3nCQPpKq1nD3SBsIl91KCWwsy99/Ob4z5XIqRbFT5KvyCVQW31nEKfaMOuuu/lxMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21843-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid]
X-Rspamd-Queue-Id: 50458178A51
X-Rspamd-Action: no action

T24gMi8yMy8yNiAzOjU5IFBNLCBKb3JnZSBCYXN0b3Mgd3JvdGU6DQo+IEhpLA0KPg0KPiBJJ20g
dXNpbmcgYSB6b25lZCBkZXZpY2UgZm9yIHRoZSBmaXJzdCB0aW1lOyBpdCdzIGEgMjdUQiBXRCBV
bHRyYXN0YXINCj4gSEM2ODAsIGZvcm1hdHRlZCB3aXRoIHNpbmdsZSBkYXRhIGFuZCBEVVAgbWV0
YWRhdGEuDQo+DQo+IFRoaXMgd2lsbCBiZSB1c2VkIGZvciBub24tY3JpdGljYWwgV09STSBtZWRp
YSBkYXRhLCBidXQgZHVyaW5nIHRoZQ0KPiBpbml0aWFsIGRhdGEgbG9hZCwgdXNpbmcgYSBzaW5n
bGUgcnN5bmMgdGhyZWFkLCB0aGUgZmlsZXN5c3RlbSBjcmFzaGVkDQo+IHR3aWNlLCAxc3QgdGlt
ZSBhZnRlciBjb3B5aW5nIGFyb3VuZCAxLjI1VCwgMm5kIHRpbWUgYXJvdW5kIDIuNVQNCj4gdG90
YWwuDQo+DQo+IEknbSBub3cgdXNpbmcgc29tZSBtb3VudCBvcHRpb25zIHN1Z2dlc3RlZCBieSBM
TE1zLCBhbmQgaXQgaGFzbid0DQo+IGNyYXNoZWQgc28gZmFyLCBidXQgaXQncyBub3QgYmVlbiBs
b25nOyBjdXJyZW50bHkgYXQgMy41OFQgdXNlZC4NCj4NCj4gbW91bnQgLW8gcncsbm9hdGltZSxj
b21taXQ9NjAsZmx1c2hvbmNvbW1pdCxkaXNjYXJkPWFzeW5jDQoNCmRpc2NhcmQ9YXN5bmMgZG9l
c24ndCBtYWtlIGEgbG90IG9mIHNlbnNlIG9uIHpvbmVkIGFuZCBpdCB3aWxsIGJlIGlnbm9yZWQu
DQoNCg0KPiBNeSBxdWVzdGlvbiBpcywgYXJlIHRoZXNlIG1vdW50IG9wdGlvbnMgZ29vZCBmb3Ig
SE0tU01SIG9yIGRvIHlvdQ0KPiByZWNvbW1lbmQgZGlmZmVyZW50IG9uZXMsIGFuZCBjb3VsZCB0
aGV5IGhlbHAgd2l0aCB0aGUgY3Jhc2hpbmc/DQo+DQo+DQo+IFRoZXNlIHdlcmUgdGhlIGNyYXNo
ZXMgSSBzYXcsIHRoZXkgbG9vayBzaW1pbGFyIHRvIG1lLCBhbmQgYWZ0ZXINCj4gdW5tb3VudGlu
ZyBhbmQgcmVtb3VudGluZywgaXQgd29ya2VkIGFnYWluOg0KDQoNClllcyB0aGVzZSBlcnJvcnMg
YXJlIHRyYW5zaWVudCAobHVja2lseSkuDQoNCg0KPiBLZXJuZWwgNi4xOC45DQo+IGJ0cmZzLXBy
b2dzIHY2LjE3LjENCj4NCj4gMXN0IG9uZToNCj4NCj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBr
ZXJuZWw6IEJUUkZTOiBlcnJvciAoZGV2aWNlIHNkYikgaW4NCj4gYnRyZnNfY29tbWl0X3RyYW5z
YWN0aW9uOjI1MzY6IGVycm5vPS0xMSB1bmtub3duIChFcnJvciB3aGlsZSB3cml0aW5nDQo+IG91
dCB0cmFuc2FjdGlvbikNCj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IEJUUkZTIGlu
Zm8gKGRldmljZSBzZGIgc3RhdGUgRSk6IGZvcmNlZCByZWFkb25seQ0KPiBGZWIgMjIgMjE6MzU6
NTYgVG93ZXI3IGtlcm5lbDogQlRSRlMgd2FybmluZyAoZGV2aWNlIHNkYiBzdGF0ZSBFKToNCj4g
U2tpcHBpbmcgY29tbWl0IG9mIGFib3J0ZWQgdHJhbnNhY3Rpb24uDQo+IEZlYiAyMiAyMTozNTo1
NiBUb3dlcjcga2VybmVsOiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4g
RmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IEJUUkZTOiBUcmFuc2FjdGlvbiBhYm9ydGVk
IChlcnJvciAtMTEpDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBXQVJOSU5HOiBD
UFU6IDggUElEOiAxMDk5NDYgYXQNCj4gZnMvYnRyZnMvdHJhbnNhY3Rpb24uYzoyMDIxIGJ0cmZz
X2NvbW1pdF90cmFuc2FjdGlvbisweDk5NC8weGIyMA0KPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3
IGtlcm5lbDogTW9kdWxlcyBsaW5rZWQgaW46IG1kX21vZCBicl9uZXRmaWx0ZXINCj4gbmZ0X2Nv
bXBhdCBhZl9wYWNrZXQgdmV0aCBuZl9jb25udHJhY2tfbmV0bGluayB4dF9uYXQgaXB0YWJsZV9y
YXcNCj4geHRfY29ubnRyYWNrIGJyaWRnZSBzdHAgbGxjIHhmcm1fdXNlciB4ZnJtX2FsZ28geHRf
c2V0IGlwX3NldA0KPiB4dF9hZGRydHlwZSB4dF9NQVNRVUVSQURFIHh0X3RjcHVkcCB4dF9tYXJr
IHR1biBuZl90YWJsZXMgbmZuZXRsaW5rDQo+IGlwNnRhYmxlX25hdCBpcHRhYmxlX25hdCBuZl9u
YXQgbmZfY29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2DQo+IG5mX2RlZnJhZ19pcHY0IGlwbWlfZGV2
aW50ZiBpcDZ0YWJsZV9maWx0ZXIgaXA2X3RhYmxlcyBpcHRhYmxlX2ZpbHRlcg0KPiBpcF90YWJs
ZXMgeF90YWJsZXMgbWFjdnRhcCBtYWN2bGFuIHRhcCBtbHg1X2NvcmUgbWx4ZncgdGxzIGlnYg0K
PiBpbnRlbF9yYXBsX21zciBhbWQ2NF9lZGFjIGVkYWNfbWNlX2FtZCBlZGFjX2NvcmUgaW50ZWxf
cmFwbF9jb21tb24NCj4ga3ZtX2FtZCBhc3Qga3ZtIGRybV9zaG1lbV9oZWxwZXIgZHJtX2NsaWVu
dF9saWIgZHJtX2ttc19oZWxwZXINCj4gaXBtaV9zc2lmIGdoYXNoX2NsbXVsbmlfaW50ZWwgYWVz
bmlfaW50ZWwgZHJtIHJhcGwgYWNwaV9jcHVmcmVxDQo+IGJhY2tsaWdodCBpMmNfYWxnb19iaXQg
aW5wdXRfbGVkcyBqb3lkZXYgbGVkX2NsYXNzIGNjcCBpMmNfcGlpeDQNCj4gaTJjX3NtYnVzIGFj
cGlfaXBtaSBzZXMgZW5jbG9zdXJlIGkyY19jb3JlIGsxMHRlbXAgaXBtaV9zaSBidXR0b24NCj4g
emZzKFBPKSBzcGwoTykgW2xhc3QgdW5sb2FkZWQ6IG1kX21vZF0NCj4gRmViIDIyIDIxOjM1OjU2
IFRvd2VyNyBrZXJuZWw6IENQVTogOCBVSUQ6IDAgUElEOiAxMDk5NDYgQ29tbToNCj4gYnRyZnMt
dHJhbnNhY3RpIFRhaW50ZWQ6IFAgICAgICAgIFcgIE8gICAgICAgIDYuMTguOS1VbnJhaWQgIzQN
Cj4gUFJFRU1QVCh2b2x1bnRhcnkpDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBU
YWludGVkOiBbUF09UFJPUFJJRVRBUllfTU9EVUxFLA0KPiBbV109V0FSTiwgW09dPU9PVF9NT0RV
TEUNCj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6IFN1cGVy
bWljcm8gU3VwZXINCj4gU2VydmVyL0gxMVNTTC1pLCBCSU9TIDIuNCAxMi8yNy8yMDIxDQo+IEZl
YiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBSSVA6IDAwMTA6YnRyZnNfY29tbWl0X3RyYW5z
YWN0aW9uKzB4OTk0LzB4YjIwDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBDb2Rl
OiBiYSBmZiA0OSA4YiA3YyAyNCA2MCA4OSBkYSA0OCBjNw0KPiBjNiAyYSA4MSA1NyA4MiBlOCA4
MSAxNCBhOSBmZiBlOCAyYyBlZiBiYSBmZiBlYiAxMCA4OSBkZSA0OCBjNyBjNyA0Yg0KPiA4MSA1
NyA4MiBlOCA2YyBkNSBiMSBmZiA8MGY+IDBiIDQxIGIwIDAxIDQxIDgzIGUwIDAxIDg5IGQ5IGJh
IGU1IDA3IDAwDQo+IDAwIDRjIDg5IGU3IDQ4IGM3IGM2DQo+IEZlYiAyMiAyMTozNTo1NiBUb3dl
cjcga2VybmVsOiBSU1A6IDAwMTg6ZmZmZmM5MDAzY2FjN2RlMCBFRkxBR1M6IDAwMDEwMjgyDQo+
IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJY
Og0KPiAwMDAwMDAwMGZmZmZmZmY1IFJDWDogMDAwMDAwMDAwMDAwMDAwMg0KPiBGZWIgMjIgMjE6
MzU6NTYgVG93ZXI3IGtlcm5lbDogUkRYOiAwMDAwMDAwMDAwMDAwMDI3IFJTSToNCj4gZmZmZmZm
ZmY4MjVmOWU3MCBSREk6IDAwMDAwMDAwZmZmZmZmZmYNCj4gRmViIDIyIDIxOjM1OjU2IFRvd2Vy
NyBrZXJuZWw6IFJCUDogZmZmZjg4ODI2YTI3ZDAwMCBSMDg6DQo+IDAwMDAwMDAwMDAwMDAwMDAg
UjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBS
MTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOg0KPiAwMDAwMDAwMDMxMmQyMDcyIFIxMjogZmZmZjg4
ODI5MGExYjdlMA0KPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogUjEzOiBmZmZmODg4
MjQ5MzA0YzAwIFIxNDoNCj4gZmZmZjg4ODI2YTI3ZDAwMCBSMTU6IGZmZmY4ODgxMDBlYzYzMDAN
Cj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgw
MDAwKQ0KPiBHUzpmZmZmODhhMDQ5OTdjMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAN
Cj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IENTOiAgMDAxMCBEUzogMDAwMCBFUzog
MDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJu
ZWw6IENSMjogMDAwMDdmZmNhZDYyMGFmOCBDUjM6DQo+IDAwMDAwMDAxZjU5MTUwMDAgQ1I0OiAw
MDAwMDAwMDAwMzUwZWYwDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBDYWxsIFRy
YWNlOg0KPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogPFRBU0s+DQo+IEZlYiAyMiAy
MTozNTo1NiBUb3dlcjcga2VybmVsOiA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmDQo+IEZl
YiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiA/IHN0YXJ0X3RyYW5zYWN0aW9uKzB4NDZlLzB4
NWUwDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiA/IGhydGltZXJfbmFub3NsZWVw
X3Jlc3RhcnQrMHg1MC8weDYwDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiB0cmFu
c2FjdGlvbl9rdGhyZWFkKzB4ZjAvMHgxNzANCj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJu
ZWw6ID8gX19wZnhfdHJhbnNhY3Rpb25fa3RocmVhZCsweDEwLzB4MTANCj4gRmViIDIyIDIxOjM1
OjU2IFRvd2VyNyBrZXJuZWw6IGt0aHJlYWQrMHgxY2UvMHgxZTANCj4gRmViIDIyIDIxOjM1OjU2
IFRvd2VyNyBrZXJuZWw6ID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYNCj4gRmViIDIyIDIx
OjM1OjU2IFRvd2VyNyBrZXJuZWw6ID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYNCj4gRmVi
IDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6ID8gZmluaXNoX3Rhc2tfc3dpdGNoLmlzcmEuMCsw
eDEzOS8weDIxMA0KPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogPyBfX3BmeF9rdGhy
ZWFkKzB4MTAvMHgxMA0KPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogPyBfX3BmeF9r
dGhyZWFkKzB4MTAvMHgxMA0KPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5lbDogcmV0X2Zy
b21fZm9yaysweDI0LzB4MTMwDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiA/IF9f
cGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+IEZlYiAyMiAyMTozNTo1NiBUb3dlcjcga2VybmVsOiBy
ZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJu
ZWw6IDwvVEFTSz4NCj4gRmViIDIyIDIxOjM1OjU2IFRvd2VyNyBrZXJuZWw6IC0tLVsgZW5kIHRy
YWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBGZWIgMjIgMjE6MzU6NTYgVG93ZXI3IGtlcm5l
bDogQlRSRlM6IGVycm9yIChkZXZpY2Ugc2RiIHN0YXRlIEVBKSBpbg0KPiBjbGVhbnVwX3RyYW5z
YWN0aW9uOjIwMjE6IGVycm5vPS0xMSB1bmtub3duDQoNClRoZSBGUyBpcyB0cnlpbmcgdG8gY29t
bWl0IGEgdHJhbnNhY3Rpb24gYW5kIHNvbWV0aGluZyBkb3duIHRoZSBwYXRoIGlzIA0KcmV0dXJu
aW5nIEVBR0FJTi4gV291bGQgYmUgaW50ZXJlc3Rpbmcgd2hvIGRpZCBpdC4NCg0KRG8geW91IGhh
dmUgdGhlIGRlYnVnIGluZm8gZm9yIHRoaXMga2VybmVsLCBzbyB3ZSBjYW4gZmluZCBvdXQgd2hl
cmUgaXQgDQpicmVha3M/DQoNCg==

