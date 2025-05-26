Return-Path: <linux-btrfs+bounces-14229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43DAC37AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 03:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29273171453
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 01:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC07263B;
	Mon, 26 May 2025 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Si7tGpQC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ghJjq2hd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62470813
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748222285; cv=fail; b=UD3/Km+tAAuQvJVbiv75fZoFzN01xbKhd1RBLsnZ6u1xivzsf+qJh6OzP4pbuSWlnsoyMp98ERiKE0sqeN2N32I2Vp5GyWgtiOBUDTWlaO+ABz5VN+Od1iXOkhY95YwKL2e+K7D+5Pc2dyZrzV5r3CRkGIJ4i403azuOXND0VEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748222285; c=relaxed/simple;
	bh=mfX+VclIOXuwtKG7/nUJ6cg0ZJqM6qlmWaetHkL+ZHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tmlB+KJ/DO3ocgRjze6cE71zoqj3m08tDbcpe2doptgAWnXBiHfPGhQQtMR4TVzY2PUQxJED0vN0CUsweY67IMqCOxSnnOAtzdqDZksa7AtioYvMRZqCbIXPBHFeafHY0YpDdsfC3LskFWaWFLEtVVW5DfTFG+cqyrpfhE4n71A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Si7tGpQC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ghJjq2hd; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748222282; x=1779758282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mfX+VclIOXuwtKG7/nUJ6cg0ZJqM6qlmWaetHkL+ZHk=;
  b=Si7tGpQCY/8EoGwvZGNTKO36GB4MNWh5yjHN23+zrEWzkAVmbxL82If7
   JEpsUEP9wpYFKLe8ShlfgRR0JGbs9N1unKFrk83Nsb0YCOtTXEeh/ujrj
   LcbW5NnJ0/U7LuSBfwdpSDZEfuICiOYVuK/CtUR/z9rJ80ogQvFh//GsJ
   cZC4uiFfosNkhS0I2A6+Rcqt6nyYsHl7bdVQ6zeglX0+1lTf00hhq3K/B
   lJb10XbzV7Ya8CE84qpYFwhR7vJ2jRddWig07bjryXuZz4JMZwdU/h+K4
   vQhK4nrTAJlKywubWFeb9OEqy4cr5pLmhGcAGVst07lXrmsodyqFcsObK
   Q==;
X-CSE-ConnectionGUID: eO9qS3GYSPmmP1mD+vixwg==
X-CSE-MsgGUID: Kh2MqPIaTfCIdpLVKVnJ6Q==
X-IronPort-AV: E=Sophos;i="6.15,314,1739808000"; 
   d="scan'208";a="83779425"
Received: from mail-northcentralusazon11012027.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.27])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2025 09:17:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lE4wT0qDHiFH33A1Lh2bdl1L8l0H5b5sgU70RhQvjCsGGmOEBpPIUpfU2qzfS723L7KFeFGNbddumi/qheaGXZc26ZE9oHEpX3OqHxD2wJGEmLGJx6ehg3Q0rRcKaLULzqW6FC/wXt39DZn9LjWlklVJEv16oirBp1mgiMWKkzk08mCDpJhgLO4DW19xhFv6MJBf9rfBHCc7/vyJLFrJvStOJvsWOK6c/S/Xv8h8kkn2hxuTdQBktAkm0gxLOaCOKGaAxjql8Pn7F3kp1Hv2fcHZwcoD1N8Ah8un62NiRhblTunLiEG+9eTVf39ZsdMMEoOtFInQWZJq+irwMgjI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPGPyqTynb3gMz2FyGXm4yjroRaYRlgT4nU+X1PFa84=;
 b=dKpQ5rYG4NT7fpOESSmw/eN/KxO9w5TFA7rytKGsJCHYSZ6O+MO4fd+VNvjagFL3J/taAtqXxZJLvkP5IBkm9xjAqNy4JtdjEgnuJu/rHAZ6XxGihF5nZ4ZjpzPcCCdP0Wm8s6n5bX2YXITWu5vv19ZfWJB/6cPVDN29LpXMvNS5qcibA+hZ8o8oY/uIFWPXiTcMPbNwRacgRw2XchxOvKjO2IifPuxMq3m0OWVTZugAxotck9VpNo32Il0Y57uE5y5SoGBa8/BOZw8SdrHTjZqF62pPtI5uG3Pir/l9rz8gZGLRj04IHglUxYVxspF2xFq7twa0AOcnB+oxMmpKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPGPyqTynb3gMz2FyGXm4yjroRaYRlgT4nU+X1PFa84=;
 b=ghJjq2hd0Yu5QnC1o+w6BsoVoKO4vhgt9EpI2YBtdg4if8NzzxWCYzc2NW3R1p4gZY8uB0L21ByktWj7WJFV53KJ/bg65crzD2IGdsbVQcRIImsxVrwIOgy6gSjcDF+sYIu6NPPZTtW8GqTh+a6/pzi1Cy8HJKO2fxjGqiuawoA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CYYPR04MB8811.namprd04.prod.outlook.com (2603:10b6:930:cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 01:17:53 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 01:17:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v5 3/3] btrfs: use buffer xarray for extent buffer
 writeback operations
Thread-Topic: [PATCH v5 3/3] btrfs: use buffer xarray for extent buffer
 writeback operations
Thread-Index: AQHbzdwA5Q9JiujHbkuFJItv9Ly52g==
Date: Mon, 26 May 2025 01:17:53 +0000
Message-ID: <dkvtoqqdlx7op3ta57fefmcbcshxsgrlu64mdldlkptzsiuise@xa7ihulvyyrc>
References: <cover.1745851722.git.josef@toxicpanda.com>
 <182a186a376f40b01dea6f4cd3da9ec84b62a088.1745851722.git.josef@toxicpanda.com>
In-Reply-To:
 <182a186a376f40b01dea6f4cd3da9ec84b62a088.1745851722.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CYYPR04MB8811:EE_
x-ms-office365-filtering-correlation-id: 2812bd74-8e70-4920-ba14-08dd9bf32393
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6XPbYIXBfX/oWPw0J2cg19CZuxGADAA3FvUnbdX0WVaLqegih267ty50QfuO?=
 =?us-ascii?Q?HQKJorRrK1P/qeoYYVdlB31u2BxfqaK9RTPlyEcXbctkIHE/EBqUfpJH/sF9?=
 =?us-ascii?Q?XcodmudGYPU95UNyiGXbvVQ3rrLN7ohc2HjUtSvUtRMOOQ8VCP7/YEcKjebL?=
 =?us-ascii?Q?6ihyB5HbA4S3mLKYWRlCjgYLuYt7Ipkpneojy8DGy5yBz47ptzOC8/wPp/US?=
 =?us-ascii?Q?uwlhckOkZg9S5PUcFRD3wZhJ/qsuMxSrH+hA97vWpc1RAclBxBskXQ3WgsdO?=
 =?us-ascii?Q?4heN6mXWL1Lz6CMVWO7oHn8RFIB4VFVpLduTUbVwOmgmADOMlW0hyn/AdE/1?=
 =?us-ascii?Q?zgU92EXMr2AZBTRFU+ZIQKJSVo5J80D0DblenOJWJfFIwVSoJNbOumkFR20w?=
 =?us-ascii?Q?fihdLhZtkNj6jIZ78vmyAxdLeKG32sFnm0+WvlQNfaxBVaUhmC1MBiHYCUrw?=
 =?us-ascii?Q?gWAnsRfSpWQp467bV6t6WgkOSShGhOj6HK7nPnlp2PdsgnmWEA2YYyyrJcm+?=
 =?us-ascii?Q?T3S1eaMvgHN24KajuH0QPCSL7k3JIo0bj6nGfIz2THWoBsc3HMKXTSWeXYlT?=
 =?us-ascii?Q?3cWtKyLtD5O1CMnfCy253bXEVnHs7e4Hah7BhBuwMXO+1tCBeLVF1XGxxNZ5?=
 =?us-ascii?Q?HQnTuFW2ksipVrIG7IC20Ei2qBdgaSxmmCBjWtCfLsUXfC7KyFY7r6sm5st9?=
 =?us-ascii?Q?Y07Ri4VNBNxObsruVL11SIemRn78zyXp1EZZwpoErzWFh2w5cEG4bICzmWjL?=
 =?us-ascii?Q?HbN2Od+douSN1VDZzKTZMOQJi9vtaTCs0vw0x8ar9uN0t+w7AhPbIHbgsPSP?=
 =?us-ascii?Q?HLEJG4q52lmcJZ3JgH5tcmdoknW4TkrmamSY1gcUojhPrgPYzHK4XKXFA5Of?=
 =?us-ascii?Q?9Dv+zk71172t8A/FkPgkna9Gt8SHAT0uQKHSrpB1kWFSVOk79YLSVrsd5t8Q?=
 =?us-ascii?Q?U4doYRsOibzQNt4brCoP+UcR6hgq5NcURIW9b10hK4XATtBHmixKQwK/dXeq?=
 =?us-ascii?Q?XByy+1AuM8xOvjQwGG57P7vwggdKKbKHiG98jV2sK0xVy/ciCvdCCxdC2Kdf?=
 =?us-ascii?Q?mfNZNx56R6ifEw9ZpSjbmhKz4TtlDj3XF1Zb9rPyMnQq373LxgnwyaY7sfFH?=
 =?us-ascii?Q?9VrjmmMD74v7u7/XlbZr1k43+9M21ZVICqiRAnRo1L3qN6X1Cl2vQMMp3fEQ?=
 =?us-ascii?Q?OF2IFiiP34rb/H8uBj5K0UrScmuL9AB+CBUwCp+E5MHL31ylTObIMEAgPN0l?=
 =?us-ascii?Q?VZT2ffpBycHTJ3sWKRpXH2ALCAeHQQ3HqHz0mf0mgXDIz0bBIo5u6/QvJDqN?=
 =?us-ascii?Q?mZ+uXS7QOu8SNPTqMlNu0YRZABZDT4FK8aWlGgU8foLn6MEY9reANaEclB3N?=
 =?us-ascii?Q?GMCON5sfBj9+CYhnfEskmryj5senSOmjQnE2HAP3aif6DL97JJY7r9RA3DR8?=
 =?us-ascii?Q?v+R5WYNX/SkusVq/ubCx44wnfcB/X6JKhhUSRbVu/h0s0hH4htKAuw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dAI0YifeFNypQ1r2dLcv4NL6sJjsrmSd7EwxmVOYZczqZCMWFDXiizgPqOoe?=
 =?us-ascii?Q?N+hZ5ftdVKtY9EMhiht02OHrlGPysErRUSrN6+6//fU7D+f8bcgMWQqhUKju?=
 =?us-ascii?Q?ey2k8F4G2jsZEr+mTfadB7qXLnAtFdFA+CI2Mu8Pksh2mdO1FD9Uqvftr8rx?=
 =?us-ascii?Q?CsyrxoEyw0j2jA3xlbl+y2WfEjaD2qmxEAuruKTnyDgU+CjuruhtkYnLKdQP?=
 =?us-ascii?Q?2LLar2HOyBWJO9soqZBOUxVbhgd/rERi50O5JsdxcUZQQUYZfs+KBUsOTC7D?=
 =?us-ascii?Q?+Nwty3x3zFObuYjMA0Ca0/3OXY+Ek9B+y04jUjn+ols86UrKCOUNhF91UR1A?=
 =?us-ascii?Q?P3LyY1gBMFGAuNKMfw2IZ3g/2NqQQMaMzr4XaPhoXoUuJUapdtk69Uvfb7qq?=
 =?us-ascii?Q?s/6LUA2fvrJ1k0ou7aT1LPw/60fzqW1t5paAevDcgtVlVMS9+tkznYQ9vtP7?=
 =?us-ascii?Q?IWW3725d4KqgrDfODHld/yFTAWlHNYEsTpK9BlqNSlc899UER/Fy9Al2WHhk?=
 =?us-ascii?Q?7gwZB/WyNXlUh9EFJ9mGvD9xpNQoydNDbzSL9OLuO+YdDUf7uf4LYsaVEQZw?=
 =?us-ascii?Q?+MbHBVslJZtp1pJcFiaZbPSjv3sNty6pjTO0L5PS4gC5Nov+C36tRKM2Xx4x?=
 =?us-ascii?Q?G7BDim71dTkDx3961D+8xGpfHgW+Viwh96qyQ21O9LRApMiauvvyTmRUU/mI?=
 =?us-ascii?Q?DfU0kYSjPPWJUdQE32VYWKX/12yx0PgDbYufruu/YyKSIJJugpBZ3/XtWIpQ?=
 =?us-ascii?Q?1w7CqIeSf3Mfy4DeGMToAosD/+n4Zk+xiId5o6Z75IJd4LjRJcwCcjixl/PU?=
 =?us-ascii?Q?7RLSF28eM4txRnVnT+Imgp0mw9qPX8G8E2cRdxg1pFA9v+sPeZA4iHkKt0Q7?=
 =?us-ascii?Q?cWPr/01rQE9QuClcN+nVx97AInki+mCt4eRzrc9aqXOFK3jnD4Y4Vta8HWor?=
 =?us-ascii?Q?wzjBV89sRSquCY6Rk1/2jDUOU7NC0JXdlegwIG5GX5nzmM1oiyP1lFho3U08?=
 =?us-ascii?Q?wUNTnFojCXoRK/je57zziV1fOepYugX3V3Aht0IcPUOE77mTrg6bPG7tU/A9?=
 =?us-ascii?Q?QFWe+GWjyXf8HeSuXdYpJFznbyIzUbvai5KkBPk/khxHovBFQQPCYvQIv2D7?=
 =?us-ascii?Q?ZDCL4gpKcYo6O8QSeB8aRgDgamu6UsMXASi9dne/fO0gX9LsIVz+dbovBwFK?=
 =?us-ascii?Q?HR/jFKQ8kV93fIZPiJAn7ZWTVUh0Zl6h1UEDrsCjrBjeq3ZeDwAUxa6t8/M0?=
 =?us-ascii?Q?GQTuDoehQaIzdus9y2CPRiZmXsyIxyGlr6/bu3GqA6HPKeSDc/rdxaaARrNn?=
 =?us-ascii?Q?wLK9m7UgXo7gDtFCpP3MGGSOR8OcYOw3T4idgD/LgmtOQCtS0y9LKnw9ssqH?=
 =?us-ascii?Q?mo9KjryZi83Cf+571jhCLVPlUFd9qPAYeRFY7AYqIcfcdaMx/iFQy39R4V+k?=
 =?us-ascii?Q?Fu3nSoNX82T3GMPW1OCeL3i7M8pvXYHaV8LDw/fDDPT7rtL2vAW+EUMdOli8?=
 =?us-ascii?Q?yZSDA7o3uZgxrC4A8Mqmr3KMlEmSoakDvfXuSPMK/zdL6EzQyYF6luGYvqWg?=
 =?us-ascii?Q?I501x5l+GUwcAfs+RxtmewHchaPcmU6RTGjoPucKyPxH0R17EP/bByf+Pr/5?=
 =?us-ascii?Q?IoGBkcV+27t13PoYu0VerfI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <443188301936804AB769E77BC936D094@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0ClEMSct1kKgV1RiTLAqtF+58NLWyNIjqPm1X2xNn295DrFQV5km2P3TMaoOIGR8Gpg+1ad+Z4J9bGM+SqQl7F4/SH9bDbZmN65n787pt84SeCjWWwz9Zu/lqA9j957eo+2PJXTaeMpSyBQinNE0+dFGoRY9gNDr2NjUiGdPLa3TkYpr6Avk5G/K30NwScpfkIM6flvQ6dgM4+704dVZob0aA47p5kkv4J9aw6yTC0C8IX2/d+00xbbr7ol0ARIruX7yVFqvspxHB1XlvicTrbpTFsBd8vOvDWa+IJOOmq5+tumfEGHmXhQ9vJCmrttmODh3Qj0dPgytf09FfGqBZMJ3ijPaMOgEOOgRdDSbRc3K3jna1aEczBNEVzbFODWTWf0QbgHvop7TpSroO3I3lxSzMUfxNYeggfZHYhaZlbfLcyamBNig3sBKB1tkbb2rTz6FG8aHPWAOIxblU9uU0N1EI9ZTnZAyV2YySK7JpxDbh9Oe0jPh/1jpEUhUKQvk/DBe3ObbinbFyKa2zGDOYEFqmWoDf7jUbkmQB1r4YspLpQsD3rtj6YUfEjtymBM88WtI+u7MHsjXHss7ffVXV8fn04CjaKt7XGZcZso/nX/WoEMjj1IHZHxNiEgXVUS3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2812bd74-8e70-4920-ba14-08dd9bf32393
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 01:17:53.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5jK4nES0pYb2vIaAqw0keNMn41Rne4G/86Myru2ONVmBJAQ0zfuv4Nrr2K9qyhR8I9cQVcErhlbIUZAAYMeVE4lzVU+Yo2T7LJnr3NA1B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8811

On Apr 28, 2025 / 10:52, Josef Bacik wrote:
> Currently we have this ugly back and forth with the btree writeback
> where we find the folio, find the eb associated with that folio, and
> then attempt to writeback.  This results in two different paths for
> subpage eb's and >=3D pagesize eb's.
>=20
> Clean this up by adding our own infrastructure around looking up tag'ed
> eb's and writing the eb's out directly.  This allows us to unify the
> subpage and >=3D pagesize IO paths, resulting in a much cleaner writeback
> path for extent buffers.

[...]

When I ran blktests on the for-next kernel with the tag next-20250521, I
observed the test case zdd/009 failed with repeated WARNs at
release_extent_buffer() [1]. I bisected and found this patch as the commit
5e121ae687b8 is the trigger. When I revert the commit from the tag
next-20250521, the WARNs disappear and the test case passes.

The test case creates zoned btrfs on scsi_debug and runs fio. I guess this
problem might be unique to zoned btrfs. Actions for fix will be appreciated=
.

[1]

[ 2415.130602][T19872] run blktests zbd/009 at 2025-05-22 05:43:18
[ 2415.336100][T19925] sd 11:0:0:0: [sdg] Synchronizing SCSI cache
[ 2415.656624][T19927] scsi_debug:sdebug_driver_probe: scsi_debug: trim pol=
l_queues to 0. poll_q/nr_hw =3D (0/1)
[ 2415.666978][T19927] scsi host11: scsi_debug: version 0191 [20210520]
[ 2415.666978][T19927]   dev_size_mb=3D1024, opts=3D0x0, submit_queues=3D1,=
 statistics=3D0
[ 2415.688478][T19927] scsi 11:0:0:0: Direct-Access-ZBC Linux    scsi_debug=
       0191 PQ: 0 ANSI: 7
[ 2415.701080][    C3] scsi 11:0:0:0: Power-on or device reset occurred
[ 2415.711696][T19927] sd 11:0:0:0: Attached scsi generic sg7 type 20
[ 2415.711931][T14481] sd 11:0:0:0: [sdg] Host-managed zoned block device
[ 2415.729457][T14481] sd 11:0:0:0: [sdg] 262144 4096-byte logical blocks: =
(1.07 GB/1.00 GiB)
[ 2415.741314][T14481] sd 11:0:0:0: [sdg] Write Protect is off
[ 2415.749640][T14481] sd 11:0:0:0: [sdg] Write cache: enabled, read cache:=
 enabled, supports DPO and FUA
[ 2415.764470][T14481] sd 11:0:0:0: [sdg] permanent stream count =3D 5
[ 2415.772745][T14481] sd 11:0:0:0: [sdg] Preferred minimum I/O size 4096 b=
ytes
[ 2415.781284][T14481] sd 11:0:0:0: [sdg] Optimal transfer size 4194304 byt=
es
[ 2415.791238][T14481] sd 11:0:0:0: [sdg] 256 zones of 1024 logical blocks
[ 2415.844595][T14481] sd 11:0:0:0: [sdg] Attached SCSI disk
[ 2416.180138][T19955] BTRFS: device fsid c63c1228-a6d2-4e6e-8c38-81ccbc43d=
df9 devid 1 transid 8 /dev/sdg (8:96) scanned by mount (19955)
[ 2416.224609][T19955] BTRFS info (device sdg): first mount of filesystem c=
63c1228-a6d2-4e6e-8c38-81ccbc43ddf9
[ 2416.236163][T19955] BTRFS info (device sdg): using crc32c (crc32c-x86) c=
hecksum algorithm
[ 2416.246181][T19955] BTRFS info (device sdg): using free-space-tree
[ 2416.261378][T19955] BTRFS info (device sdg): host-managed zoned block de=
vice /dev/sdg, 256 zones of 4194304 bytes
[ 2416.273530][T19955] BTRFS info (device sdg): zoned mode enabled with zon=
e size 4194304
[ 2416.287809][T19955] BTRFS info (device sdg): checking UUID tree
[ 2427.128617][T20014] ------------[ cut here ]------------
[ 2427.134580][T20014] WARNING: CPU: 13 PID: 20014 at fs/btrfs/extent_io.c:=
3441 release_extent_buffer+0x22f/0x2a0 [btrfs]
[ 2427.146076][T20014] Modules linked in: scsi_debug btrfs xor raid6_pq xfs=
 target_core_user target_core_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nf=
t_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c=
hain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptabl=
e_nat nf_nat nf_conntrack rfkill nf_defrag_ipv6 nf_defrag_ipv4 iptable_mang=
le iptable_raw iptable_security ip_set nf_tables ip6table_filter ip6_tables=
 iptable_filter ip_tables qrtr irdma ice gnss ib_uverbs sunrpc intel_rapl_m=
sr intel_rapl_common intel_uncore_frequency ib_core intel_uncore_frequency_=
common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_p=
owerclamp coretemp kvm_intel kvm spi_nor i40e irqbypass mtd rapl iTCO_wdt i=
ntel_pmc_bxt intel_cstate iTCO_vendor_support vfat ses fat intel_uncore enc=
losure libie mei_me i2c_i801 spi_intel_pci ioatdma i2c_smbus lpc_ich spi_in=
tel mei intel_pch_thermal wmi dca joydev acpi_power_meter acpi_pad fuse loo=
p dm_multipath nfnetlink zram lz4hc_compress lz4_compress
[ 2427.146286][T20014]  zstd_compress ast drm_client_lib i2c_algo_bit drm_s=
hmem_helper drm_kms_helper drm nvme mpi3mr nvme_core polyval_clmulni ghash_=
clmulni_intel sha512_ssse3 nvme_keyring sha1_ssse3 scsi_transport_sas nvme_=
auth scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_parser [last unloaded:=
 scsi_debug]
[ 2427.271554][T20014] CPU: 13 UID: 0 PID: 20014 Comm: umount Tainted: G   =
 B               6.15.0-rc7-next-20250521-kts #1 PREEMPT(lazy)=20
[ 2427.285246][T20014] Tainted: [B]=3DBAD_PAGE
[ 2427.290012][T20014] Hardware name: Supermicro Super Server/X11SPi-TF, BI=
OS 3.5 05/18/2021
[ 2427.298958][T20014] RIP: 0010:release_extent_buffer+0x22f/0x2a0 [btrfs]
[ 2427.306531][T20014] Code: 08 5b 5d 41 5c 41 5d e9 8f 08 06 e6 49 8d 7c 2=
4 40 be ff ff ff ff e8 10 0e 03 e6 85 c0 0f 85 26 fe ff ff 0f 0b e9 1f fe f=
f ff <0f> 0b e9 61 fe ff ff 48 c7 c7 84 cb 48 ab e8 6e 99 cd e3 e9 f9 fd
[ 2427.327541][T20014] RSP: 0018:ffff888348297068 EFLAGS: 00010246
[ 2427.334290][T20014] RAX: 0000000000000000 RBX: ffff8882cd2d34e8 RCX: 000=
0000000000001
[ 2427.342954][T20014] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fff=
f8882cd2d34e8
[ 2427.351616][T20014] RBP: ffff8882cd2d34e8 R08: ffffffffc332b4e0 R09: fff=
fed1059a5a69d
[ 2427.360272][T20014] R10: ffffed1059a5a69e R11: 0000000000000000 R12: fff=
f8882cd2d3480
[ 2427.368916][T20014] R13: dffffc0000000000 R14: 000000000000001f R15: fff=
fed1059a5a692
[ 2427.377567][T20014] FS:  00007f2e60decb80(0000) GS:ffff889055845000(0000=
) knlGS:0000000000000000
[ 2427.387171][T20014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2427.394426][T20014] CR2: 00007ffcad825fe0 CR3: 00000001b3fa9003 CR4: 000=
00000007726f0
[ 2427.403076][T20014] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[ 2427.411723][T20014] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[ 2427.420367][T20014] PKRU: 55555554
[ 2427.424579][T20014] Call Trace:
[ 2427.428523][T20014]  <TASK>
[ 2427.432114][T20014]  free_extent_buffer+0x1e6/0x2b0 [btrfs]
[ 2427.438667][T20014]  ? __pfx_free_extent_buffer+0x10/0x10 [btrfs]
[ 2427.445722][T20014]  ? btrfs_check_meta_write_pointer+0x243/0x5a0 [btrfs=
]
[ 2427.453465][T20014]  btree_write_cache_pages+0x40f/0x950 [btrfs]
[ 2427.460435][T20014]  ? __pfx_btree_write_cache_pages+0x10/0x10 [btrfs]
[ 2427.467904][T20014]  ? unwind_get_return_address+0x6b/0xe0
[ 2427.474184][T20014]  ? kasan_save_stack+0x3f/0x50
[ 2427.479655][T20014]  ? kasan_save_stack+0x30/0x50
[ 2427.485121][T20014]  ? kasan_save_track+0x14/0x30
[ 2427.490572][T20014]  ? kasan_save_free_info+0x3b/0x70
[ 2427.496370][T20014]  ? __kasan_slab_free+0x52/0x70
[ 2427.501920][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2427.507452][T20014]  ? btrfs_convert_extent_bit+0x97e/0xfd0 [btrfs]
[ 2427.514600][T20014]  ? btrfs_write_marked_extents+0x17b/0x230 [btrfs]
[ 2427.521903][T20014]  ? btrfs_write_and_wait_transaction+0xdb/0x1d0 [btrf=
s]
[ 2427.529630][T20014]  ? btrfs_commit_transaction+0x163a/0x30b0 [btrfs]
[ 2427.536903][T20014]  do_writepages+0x21e/0x560
[ 2427.542029][T20014]  ? __pfx_do_writepages+0x10/0x10
[ 2427.547667][T20014]  ? _raw_spin_unlock+0x23/0x40
[ 2427.553017][T20014]  ? wbc_attach_and_unlock_inode.part.0+0x388/0x730
[ 2427.560110][T20014]  filemap_fdatawrite_wbc+0xd2/0x120
[ 2427.565892][T20014]  __filemap_fdatawrite_range+0xa7/0xe0
[ 2427.571900][T20014]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[ 2427.578604][T20014]  btrfs_write_marked_extents+0xf7/0x230 [btrfs]
[ 2427.585514][T20014]  ? __pfx_btrfs_write_marked_extents+0x10/0x10 [btrfs=
]
[ 2427.593011][T20014]  ? __pfx___mutex_lock+0x10/0x10
[ 2427.598452][T20014]  btrfs_write_and_wait_transaction+0xdb/0x1d0 [btrfs]
[ 2427.605839][T20014]  ? do_raw_spin_lock+0x128/0x270
[ 2427.611255][T20014]  ? __pfx_btrfs_write_and_wait_transaction+0x10/0x10 =
[btrfs]
[ 2427.619249][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2427.624658][T20014]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[ 2427.630852][T20014]  btrfs_commit_transaction+0x163a/0x30b0 [btrfs]
[ 2427.637777][T20014]  ? start_transaction+0x520/0x1520 [btrfs]
[ 2427.644167][T20014]  ? __pfx_btrfs_commit_transaction+0x10/0x10 [btrfs]
[ 2427.651428][T20014]  ? btrfs_attach_transaction_barrier+0x25/0xa0 [btrfs=
]
[ 2427.658843][T20014]  sync_filesystem+0x177/0x220
[ 2427.663954][T20014]  generic_shutdown_super+0x79/0x320
[ 2427.669583][T20014]  kill_anon_super+0x3a/0x60
[ 2427.674514][T20014]  btrfs_kill_super+0x3e/0x60 [btrfs]
[ 2427.680359][T20014]  deactivate_locked_super+0xa8/0x160
[ 2427.686052][T20014]  cleanup_mnt+0x1da/0x410
[ 2427.690792][T20014]  task_work_run+0x116/0x200
[ 2427.695694][T20014]  ? __pfx_task_work_run+0x10/0x10
[ 2427.701122][T20014]  ? __x64_sys_umount+0x10c/0x140
[ 2427.706461][T20014]  ? __pfx___x64_sys_umount+0x10/0x10
[ 2427.712141][T20014]  exit_to_user_mode_loop+0x135/0x160
[ 2427.717825][T20014]  do_syscall_64+0x223/0x380
[ 2427.722740][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2427.728083][T20014]  ? kasan_save_track+0x14/0x30
[ 2427.733247][T20014]  ? kasan_quarantine_put+0xf5/0x240
[ 2427.738835][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2427.744081][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2427.749321][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2427.754546][T20014]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2427.760637][T20014]  ? do_syscall_64+0x158/0x380
[ 2427.765699][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2427.771018][T20014]  ? kasan_save_track+0x14/0x30
[ 2427.776173][T20014]  ? kasan_quarantine_put+0xf5/0x240
[ 2427.781760][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2427.786995][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2427.792231][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2427.797465][T20014]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2427.803561][T20014]  ? do_syscall_64+0x158/0x380
[ 2427.808610][T20014]  ? clear_bhb_loop+0x30/0x80
[ 2427.813571][T20014]  ? clear_bhb_loop+0x30/0x80
[ 2427.818529][T20014]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2427.824705][T20014] RIP: 0033:0x7f2e60ee280b
[ 2427.829399][T20014] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f=
3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 c9 35 0f 00 f7 d8
[ 2427.849737][T20014] RSP: 002b:00007ffcad827e98 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000a6
[ 2427.858513][T20014] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
07f2e60ee280b
[ 2427.866805][T20014] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000015800980
[ 2427.875102][T20014] RBP: 00007f2e610bdfd4 R08: 0000000000000002 R09: 000=
0000000000000
[ 2427.883395][T20014] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000015800648
[ 2427.891679][T20014] R13: 0000000015800980 R14: 0000000015800540 R15: 000=
0000000000000
[ 2427.899968][T20014]  </TASK>
[ 2427.903304][T20014] irq event stamp: 0
[ 2427.907498][T20014] hardirqs last  enabled at (0): [<0000000000000000>] =
0x0
[ 2427.914911][T20014] hardirqs last disabled at (0): [<ffffffffa6557892>] =
copy_process+0x1862/0x5730
[ 2427.924331][T20014] softirqs last  enabled at (0): [<ffffffffa65578ea>] =
copy_process+0x18ba/0x5730
[ 2427.933742][T20014] softirqs last disabled at (0): [<0000000000000000>] =
0x0
[ 2427.941153][T20014] ---[ end trace 0000000000000000 ]---
[ 2427.947036][T20014] ------------[ cut here ]------------
[ 2427.953580][T20014] WARNING: CPU: 3 PID: 20014 at fs/btrfs/extent_io.c:3=
441 release_extent_buffer+0x22f/0x2a0 [btrfs]
[ 2427.965056][T20014] Modules linked in: scsi_debug btrfs xor raid6_pq xfs=
 target_core_user target_core_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nf=
t_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c=
hain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptabl=
e_nat nf_nat nf_conntrack rfkill nf_defrag_ipv6 nf_defrag_ipv4 iptable_mang=
le iptable_raw iptable_security ip_set nf_tables ip6table_filter ip6_tables=
 iptable_filter ip_tables qrtr irdma ice gnss ib_uverbs sunrpc intel_rapl_m=
sr intel_rapl_common intel_uncore_frequency ib_core intel_uncore_frequency_=
common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_p=
owerclamp coretemp kvm_intel kvm spi_nor i40e irqbypass mtd rapl iTCO_wdt i=
ntel_pmc_bxt intel_cstate iTCO_vendor_support vfat ses fat intel_uncore enc=
losure libie mei_me i2c_i801 spi_intel_pci ioatdma i2c_smbus lpc_ich spi_in=
tel mei intel_pch_thermal wmi dca joydev acpi_power_meter acpi_pad fuse loo=
p dm_multipath nfnetlink zram lz4hc_compress lz4_compress
[ 2427.965264][T20014]  zstd_compress ast drm_client_lib i2c_algo_bit drm_s=
hmem_helper drm_kms_helper drm nvme mpi3mr nvme_core polyval_clmulni ghash_=
clmulni_intel sha512_ssse3 nvme_keyring sha1_ssse3 scsi_transport_sas nvme_=
auth scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_parser [last unloaded:=
 scsi_debug]
[ 2428.088867][T20014] CPU: 3 UID: 0 PID: 20014 Comm: umount Tainted: G    =
B   W           6.15.0-rc7-next-20250521-kts #1 PREEMPT(lazy)=20
[ 2428.102283][T20014] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[ 2428.107834][T20014] Hardware name: Supermicro Super Server/X11SPi-TF, BI=
OS 3.5 05/18/2021
[ 2428.116715][T20014] RIP: 0010:release_extent_buffer+0x22f/0x2a0 [btrfs]
[ 2428.124193][T20014] Code: 08 5b 5d 41 5c 41 5d e9 8f 08 06 e6 49 8d 7c 2=
4 40 be ff ff ff ff e8 10 0e 03 e6 85 c0 0f 85 26 fe ff ff 0f 0b e9 1f fe f=
f ff <0f> 0b e9 61 fe ff ff 48 c7 c7 84 cb 48 ab e8 6e 99 cd e3 e9 f9 fd
[ 2428.145115][T20014] RSP: 0018:ffff888348297068 EFLAGS: 00010246
[ 2428.151793][T20014] RAX: 0000000000000000 RBX: ffff8881765d4ba8 RCX: 000=
0000000000001
[ 2428.160383][T20014] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fff=
f8881765d4ba8
[ 2428.168974][T20014] RBP: ffff8881765d4ba8 R08: ffffffffc332b4e0 R09: fff=
fed102ecba975
[ 2428.177572][T20014] R10: ffffed102ecba976 R11: 0000000000000000 R12: fff=
f8881765d4b40
[ 2428.186179][T20014] R13: dffffc0000000000 R14: 000000000000001f R15: fff=
fed102ecba96a
[ 2428.194782][T20014] FS:  00007f2e60decb80(0000) GS:ffff889055345000(0000=
) knlGS:0000000000000000
[ 2428.204347][T20014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2428.211586][T20014] CR2: 0000000031894360 CR3: 00000001b3fa9002 CR4: 000=
00000007726f0
[ 2428.220219][T20014] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[ 2428.228853][T20014] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[ 2428.237481][T20014] PKRU: 55555554
[ 2428.241671][T20014] Call Trace:
[ 2428.245578][T20014]  <TASK>
[ 2428.249132][T20014]  free_extent_buffer+0x1e6/0x2b0 [btrfs]
[ 2428.255616][T20014]  ? __pfx_free_extent_buffer+0x10/0x10 [btrfs]
[ 2428.262619][T20014]  ? btrfs_check_meta_write_pointer+0x243/0x5a0 [btrfs=
]
[ 2428.270315][T20014]  btree_write_cache_pages+0x40f/0x950 [btrfs]
[ 2428.277241][T20014]  ? __pfx_btree_write_cache_pages+0x10/0x10 [btrfs]
[ 2428.284682][T20014]  ? unwind_get_return_address+0x6b/0xe0
[ 2428.290928][T20014]  ? kasan_save_stack+0x3f/0x50
[ 2428.296394][T20014]  ? kasan_save_stack+0x30/0x50
[ 2428.301841][T20014]  ? kasan_save_track+0x14/0x30
[ 2428.307293][T20014]  ? kasan_save_free_info+0x3b/0x70
[ 2428.313092][T20014]  ? __kasan_slab_free+0x52/0x70
[ 2428.318622][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2428.324156][T20014]  ? btrfs_convert_extent_bit+0x97e/0xfd0 [btrfs]
[ 2428.331314][T20014]  ? btrfs_write_marked_extents+0x17b/0x230 [btrfs]
[ 2428.338626][T20014]  ? btrfs_write_and_wait_transaction+0xdb/0x1d0 [btrf=
s]
[ 2428.346364][T20014]  ? btrfs_commit_transaction+0x163a/0x30b0 [btrfs]
[ 2428.353658][T20014]  do_writepages+0x21e/0x560
[ 2428.358785][T20014]  ? __pfx_do_writepages+0x10/0x10
[ 2428.364431][T20014]  ? _raw_spin_unlock+0x23/0x40
[ 2428.369784][T20014]  ? wbc_attach_and_unlock_inode.part.0+0x388/0x730
[ 2428.376917][T20014]  filemap_fdatawrite_wbc+0xd2/0x120
[ 2428.382733][T20014]  __filemap_fdatawrite_range+0xa7/0xe0
[ 2428.388789][T20014]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[ 2428.395550][T20014]  btrfs_write_marked_extents+0xf7/0x230 [btrfs]
[ 2428.402529][T20014]  ? __pfx_btrfs_write_marked_extents+0x10/0x10 [btrfs=
]
[ 2428.410091][T20014]  ? __pfx___mutex_lock+0x10/0x10
[ 2428.415586][T20014]  btrfs_write_and_wait_transaction+0xdb/0x1d0 [btrfs]
[ 2428.423028][T20014]  ? do_raw_spin_lock+0x128/0x270
[ 2428.428491][T20014]  ? __pfx_btrfs_write_and_wait_transaction+0x10/0x10 =
[btrfs]
[ 2428.436543][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2428.442000][T20014]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[ 2428.448238][T20014]  btrfs_commit_transaction+0x163a/0x30b0 [btrfs]
[ 2428.455225][T20014]  ? start_transaction+0x520/0x1520 [btrfs]
[ 2428.461655][T20014]  ? __pfx_btrfs_commit_transaction+0x10/0x10 [btrfs]
[ 2428.468948][T20014]  ? btrfs_attach_transaction_barrier+0x25/0xa0 [btrfs=
]
[ 2428.476440][T20014]  sync_filesystem+0x177/0x220
[ 2428.481589][T20014]  generic_shutdown_super+0x79/0x320
[ 2428.487264][T20014]  kill_anon_super+0x3a/0x60
[ 2428.492238][T20014]  btrfs_kill_super+0x3e/0x60 [btrfs]
[ 2428.498133][T20014]  deactivate_locked_super+0xa8/0x160
[ 2428.503869][T20014]  cleanup_mnt+0x1da/0x410
[ 2428.508648][T20014]  task_work_run+0x116/0x200
[ 2428.513592][T20014]  ? __pfx_task_work_run+0x10/0x10
[ 2428.519052][T20014]  ? __x64_sys_umount+0x10c/0x140
[ 2428.524436][T20014]  ? __pfx___x64_sys_umount+0x10/0x10
[ 2428.530159][T20014]  exit_to_user_mode_loop+0x135/0x160
[ 2428.535880][T20014]  do_syscall_64+0x223/0x380
[ 2428.540827][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2428.546208][T20014]  ? kasan_save_track+0x14/0x30
[ 2428.551416][T20014]  ? kasan_quarantine_put+0xf5/0x240
[ 2428.557040][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2428.562323][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2428.567597][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2428.572859][T20014]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2428.578986][T20014]  ? do_syscall_64+0x158/0x380
[ 2428.584094][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2428.589468][T20014]  ? kasan_save_track+0x14/0x30
[ 2428.594652][T20014]  ? kasan_quarantine_put+0xf5/0x240
[ 2428.600282][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2428.605557][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2428.610827][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2428.616095][T20014]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2428.622232][T20014]  ? do_syscall_64+0x158/0x380
[ 2428.627328][T20014]  ? clear_bhb_loop+0x30/0x80
[ 2428.632328][T20014]  ? clear_bhb_loop+0x30/0x80
[ 2428.637329][T20014]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2428.643530][T20014] RIP: 0033:0x7f2e60ee280b
[ 2428.648266][T20014] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f=
3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 c9 35 0f 00 f7 d8
[ 2428.668680][T20014] RSP: 002b:00007ffcad827e98 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000a6
[ 2428.677460][T20014] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
07f2e60ee280b
[ 2428.685785][T20014] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000015800980
[ 2428.694123][T20014] RBP: 00007f2e610bdfd4 R08: 0000000000000002 R09: 000=
0000000000000
[ 2428.702459][T20014] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000015800648
[ 2428.710783][T20014] R13: 0000000015800980 R14: 0000000015800540 R15: 000=
0000000000000
[ 2428.719116][T20014]  </TASK>
[ 2428.722494][T20014] irq event stamp: 0
[ 2428.726720][T20014] hardirqs last  enabled at (0): [<0000000000000000>] =
0x0
[ 2428.734179][T20014] hardirqs last disabled at (0): [<ffffffffa6557892>] =
copy_process+0x1862/0x5730
[ 2428.743627][T20014] softirqs last  enabled at (0): [<ffffffffa65578ea>] =
copy_process+0x18ba/0x5730
[ 2428.753082][T20014] softirqs last disabled at (0): [<0000000000000000>] =
0x0
[ 2428.760539][T20014] ---[ end trace 0000000000000000 ]---
[ 2428.766495][T20014] ------------[ cut here ]------------
[ 2428.772550][T20014] WARNING: CPU: 0 PID: 20014 at fs/btrfs/extent_io.c:3=
441 release_extent_buffer+0x22f/0x2a0 [btrfs]
[ 2428.784046][T20014] Modules linked in: scsi_debug btrfs xor raid6_pq xfs=
 target_core_user target_core_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nf=
t_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c=
hain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptabl=
e_nat nf_nat nf_conntrack rfkill nf_defrag_ipv6 nf_defrag_ipv4 iptable_mang=
le iptable_raw iptable_security ip_set nf_tables ip6table_filter ip6_tables=
 iptable_filter ip_tables qrtr irdma ice gnss ib_uverbs sunrpc intel_rapl_m=
sr intel_rapl_common intel_uncore_frequency ib_core intel_uncore_frequency_=
common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_p=
owerclamp coretemp kvm_intel kvm spi_nor i40e irqbypass mtd rapl iTCO_wdt i=
ntel_pmc_bxt intel_cstate iTCO_vendor_support vfat ses fat intel_uncore enc=
losure libie mei_me i2c_i801 spi_intel_pci ioatdma i2c_smbus lpc_ich spi_in=
tel mei intel_pch_thermal wmi dca joydev acpi_power_meter acpi_pad fuse loo=
p dm_multipath nfnetlink zram lz4hc_compress lz4_compress
[ 2428.784308][T20014]  zstd_compress ast drm_client_lib i2c_algo_bit drm_s=
hmem_helper drm_kms_helper drm nvme mpi3mr nvme_core polyval_clmulni ghash_=
clmulni_intel sha512_ssse3 nvme_keyring sha1_ssse3 scsi_transport_sas nvme_=
auth scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_parser [last unloaded:=
 scsi_debug]
[ 2428.910058][T20014] CPU: 0 UID: 0 PID: 20014 Comm: umount Tainted: G    =
B   W           6.15.0-rc7-next-20250521-kts #1 PREEMPT(lazy)=20
[ 2428.923575][T20014] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[ 2428.929199][T20014] Hardware name: Supermicro Super Server/X11SPi-TF, BI=
OS 3.5 05/18/2021
[ 2428.938139][T20014] RIP: 0010:release_extent_buffer+0x22f/0x2a0 [btrfs]
[ 2428.945688][T20014] Code: 08 5b 5d 41 5c 41 5d e9 8f 08 06 e6 49 8d 7c 2=
4 40 be ff ff ff ff e8 10 0e 03 e6 85 c0 0f 85 26 fe ff ff 0f 0b e9 1f fe f=
f ff <0f> 0b e9 61 fe ff ff 48 c7 c7 84 cb 48 ab e8 6e 99 cd e3 e9 f9 fd
[ 2428.966691][T20014] RSP: 0018:ffff888348297068 EFLAGS: 00010246
[ 2428.973501][T20014] RAX: 0000000000000000 RBX: ffff8881765d47e8 RCX: 000=
0000000000001
[ 2428.982152][T20014] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fff=
f8881765d47e8
[ 2428.990816][T20014] RBP: ffff8881765d47e8 R08: ffffffffc332b4e0 R09: fff=
fed102ecba8fd
[ 2428.999472][T20014] R10: ffffed102ecba8fe R11: 0000000000000000 R12: fff=
f8881765d4780
[ 2429.008137][T20014] R13: dffffc0000000000 R14: 000000000000001f R15: fff=
fed102ecba8f2
[ 2429.016801][T20014] FS:  00007f2e60decb80(0000) GS:ffff8890551c5000(0000=
) knlGS:0000000000000000
[ 2429.026431][T20014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2429.033725][T20014] CR2: 0000000031d2e004 CR3: 00000001b3fa9005 CR4: 000=
00000007726f0
[ 2429.042418][T20014] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[ 2429.051112][T20014] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[ 2429.059798][T20014] PKRU: 55555554
[ 2429.064035][T20014] Call Trace:
[ 2429.067989][T20014]  <TASK>
[ 2429.071603][T20014]  free_extent_buffer+0x1e6/0x2b0 [btrfs]
[ 2429.078167][T20014]  ? __pfx_free_extent_buffer+0x10/0x10 [btrfs]
[ 2429.085241][T20014]  ? btrfs_check_meta_write_pointer+0x243/0x5a0 [btrfs=
]
[ 2429.092991][T20014]  btree_write_cache_pages+0x40f/0x950 [btrfs]
[ 2429.099983][T20014]  ? __pfx_btree_write_cache_pages+0x10/0x10 [btrfs]
[ 2429.107513][T20014]  ? unwind_get_return_address+0x6b/0xe0
[ 2429.113833][T20014]  ? kasan_save_stack+0x3f/0x50
[ 2429.119359][T20014]  ? kasan_save_stack+0x30/0x50
[ 2429.124860][T20014]  ? kasan_save_track+0x14/0x30
[ 2429.130368][T20014]  ? kasan_save_free_info+0x3b/0x70
[ 2429.136228][T20014]  ? __kasan_slab_free+0x52/0x70
[ 2429.141820][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2429.147405][T20014]  ? btrfs_convert_extent_bit+0x97e/0xfd0 [btrfs]
[ 2429.154630][T20014]  ? btrfs_write_marked_extents+0x17b/0x230 [btrfs]
[ 2429.161997][T20014]  ? btrfs_write_and_wait_transaction+0xdb/0x1d0 [btrf=
s]
[ 2429.169809][T20014]  ? btrfs_commit_transaction+0x163a/0x30b0 [btrfs]
[ 2429.177167][T20014]  do_writepages+0x21e/0x560
[ 2429.182366][T20014]  ? __pfx_do_writepages+0x10/0x10
[ 2429.188047][T20014]  ? _raw_spin_unlock+0x23/0x40
[ 2429.193468][T20014]  ? wbc_attach_and_unlock_inode.part.0+0x388/0x730
[ 2429.200618][T20014]  filemap_fdatawrite_wbc+0xd2/0x120
[ 2429.206451][T20014]  __filemap_fdatawrite_range+0xa7/0xe0
[ 2429.212519][T20014]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[ 2429.219276][T20014]  btrfs_write_marked_extents+0xf7/0x230 [btrfs]
[ 2429.226248][T20014]  ? __pfx_btrfs_write_marked_extents+0x10/0x10 [btrfs=
]
[ 2429.233805][T20014]  ? __pfx___mutex_lock+0x10/0x10
[ 2429.239296][T20014]  btrfs_write_and_wait_transaction+0xdb/0x1d0 [btrfs]
[ 2429.246736][T20014]  ? do_raw_spin_lock+0x128/0x270
[ 2429.252202][T20014]  ? __pfx_btrfs_write_and_wait_transaction+0x10/0x10 =
[btrfs]
[ 2429.260249][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2429.265705][T20014]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[ 2429.271931][T20014]  btrfs_commit_transaction+0x163a/0x30b0 [btrfs]
[ 2429.278924][T20014]  ? start_transaction+0x520/0x1520 [btrfs]
[ 2429.285377][T20014]  ? __pfx_btrfs_commit_transaction+0x10/0x10 [btrfs]
[ 2429.292675][T20014]  ? btrfs_attach_transaction_barrier+0x25/0xa0 [btrfs=
]
[ 2429.300156][T20014]  sync_filesystem+0x177/0x220
[ 2429.305312][T20014]  generic_shutdown_super+0x79/0x320
[ 2429.310974][T20014]  kill_anon_super+0x3a/0x60
[ 2429.315937][T20014]  btrfs_kill_super+0x3e/0x60 [btrfs]
[ 2429.321835][T20014]  deactivate_locked_super+0xa8/0x160
[ 2429.327575][T20014]  cleanup_mnt+0x1da/0x410
[ 2429.332368][T20014]  task_work_run+0x116/0x200
[ 2429.337317][T20014]  ? __pfx_task_work_run+0x10/0x10
[ 2429.342774][T20014]  ? __x64_sys_umount+0x10c/0x140
[ 2429.348165][T20014]  ? __pfx___x64_sys_umount+0x10/0x10
[ 2429.353881][T20014]  exit_to_user_mode_loop+0x135/0x160
[ 2429.359599][T20014]  do_syscall_64+0x223/0x380
[ 2429.364547][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2429.369920][T20014]  ? kasan_save_track+0x14/0x30
[ 2429.375545][T20014]  ? kasan_quarantine_put+0xf5/0x240
[ 2429.381614][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2429.386910][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2429.392206][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2429.397479][T20014]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2429.403609][T20014]  ? do_syscall_64+0x158/0x380
[ 2429.408709][T20014]  ? trace_hardirqs_on+0x18/0x150
[ 2429.414072][T20014]  ? kasan_save_track+0x14/0x30
[ 2429.419265][T20014]  ? kasan_quarantine_put+0xf5/0x240
[ 2429.424881][T20014]  ? kmem_cache_free+0x1a1/0x580
[ 2429.430168][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2429.435450][T20014]  ? __x64_sys_statx+0x141/0x1b0
[ 2429.440710][T20014]  ? trace_hardirqs_on_prepare+0x101/0x150
[ 2429.446839][T20014]  ? do_syscall_64+0x158/0x380
[ 2429.451922][T20014]  ? clear_bhb_loop+0x30/0x80
[ 2429.456919][T20014]  ? clear_bhb_loop+0x30/0x80
[ 2429.461908][T20014]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2429.468130][T20014] RIP: 0033:0x7f2e60ee280b
[ 2429.472858][T20014] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f=
3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 c9 35 0f 00 f7 d8
[ 2429.493303][T20014] RSP: 002b:00007ffcad827e98 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000a6
[ 2429.502091][T20014] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
07f2e60ee280b
[ 2429.510437][T20014] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000015800980
[ 2429.518761][T20014] RBP: 00007f2e610bdfd4 R08: 0000000000000002 R09: 000=
0000000000000
[ 2429.527098][T20014] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000015800648
[ 2429.535424][T20014] R13: 0000000015800980 R14: 0000000015800540 R15: 000=
0000000000000
[ 2429.543751][T20014]  </TASK>
[ 2429.547133][T20014] irq event stamp: 0
[ 2429.551395][T20014] hardirqs last  enabled at (0): [<0000000000000000>] =
0x0
[ 2429.558844][T20014] hardirqs last disabled at (0): [<ffffffffa6557892>] =
copy_process+0x1862/0x5730
[ 2429.568313][T20014] softirqs last  enabled at (0): [<ffffffffa65578ea>] =
copy_process+0x18ba/0x5730
[ 2429.577761][T20014] softirqs last disabled at (0): [<0000000000000000>] =
0x0
[ 2429.585219][T20014] ---[ end trace 0000000000000000 ]---
...=

