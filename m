Return-Path: <linux-btrfs+bounces-16542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C268B3D26F
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Aug 2025 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0949F7AD1E9
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Aug 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38425783F;
	Sun, 31 Aug 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PX1m6Waj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PHarD0cQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67725487A;
	Sun, 31 Aug 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756638696; cv=fail; b=VtO05d52LEeKzcDY/jrvg5PQosGWotz9KJH/Bfg6V8J57qiERFKd+pBGA1rAQIza7kFf/gMqQzPchLAoJe2saHNdF2cG/KksAmmpJz53wwmEutctT6sulgVCC3TxTvJ0Lh6VSmC/D1PpZuT+2vsnV+R/R9X0/EZbtq5fnRfWIKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756638696; c=relaxed/simple;
	bh=Mni3tb0YZ/FDOLUNvPA5U2AoZBvxnFjqanr1wJWGFus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N0Wp3EVVS26nidCmNJrMXv1x40Rj/mXQv67ezTES9ENfeosMPt6AJaBdM7e8KqpazeGMLXOejA0o3DvHtOiA70QZh68l9ff+6UAFQowTiVB4QfiGbsy0/FDhg2X6oSPbtvl3r2mlk7tvGT46urhjQAST2mdVVYFZY/VG/af6V2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PX1m6Waj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PHarD0cQ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756638694; x=1788174694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mni3tb0YZ/FDOLUNvPA5U2AoZBvxnFjqanr1wJWGFus=;
  b=PX1m6WajW1qKBNwdyfZBz0TB+kdZVvNvBDaTdAsJAv+nZIzdGdojlMEo
   /BEK/fSnae7ZIyfeCezzKSEM4pzM091+y+smtterd0j+VdzpqoDzxTCee
   KB21DyRZBzdQLHmIKF9Wosi9xFMjeHSpVI4EmrYREtuSg0bOnRgSyvxSZ
   uf3C4heccDmoOeMuaC8RleC2llJk1zZ8+ZaXRCnCbTjVdsTsORGeOSYux
   gQdEv1OeNJENzfqtF82wg8F7zRQ7y66PhSfMert/Lsi38u/B6cQSJkZy3
   jdiMtomG7hh5tBsenDZZbh84cfKIueoF5EwDMsgeDMvaKV5V49/5R/zBk
   g==;
X-CSE-ConnectionGUID: B2NXj0jzTIaPn+7JBxICVg==
X-CSE-MsgGUID: UWebU94aQDCvjyF9P8WIVA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="106905442"
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.67])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2025 19:11:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELGXRFau9uvI4PDPVs/ebRTj3vwPe2A9ziYzEr15LEap1nAM8u0e0ZwqCGgzJlQ5HIJLIgeboKt3oTgopLaxhjACGli8qx2F4Y/3y/DqFb+8MpGmzmQC+vR8TpC03petRZ1Im/yMcNq4aLe4eFIjBV/Kf0m1/iB6ZO7aLFZOUPhDqAXTk7AvagZDzxF45ot37F5NveIicTaGrHLu3xWFzN/j41L0fWCRZqGrwJXazn6BczNmTMCD4Opx3hIbMun0J+5N1XcDnp+LmJdXtYhOXlLDNWNwCyVGbKq/ohJ1BBrkxLVjsX6t1TcwhpfaTiLxcap7KUdLC4BGXagnKnaGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mni3tb0YZ/FDOLUNvPA5U2AoZBvxnFjqanr1wJWGFus=;
 b=YfkBpmdKbbnLfPBluy3HtTetgn9W3lFrsOBw6gp0YLGxZGZXXULaJ1pEp/j3W55AcRXSVgMLvi6u9EN88otmFF9WG5gHKRXC/NLIP53CTAsmOc76Q1zOu9oeOfH1f/5EZsW0otw0o+0f6ZtPTkwVLGjPImH8g/6rIUp6325mOoan0/ielgsUCPgNF04nBRaqxLsrexjtslRVanNpO5yUM4znd20abinnoD6gsyhz2uCV7PNgEBGThh0CKrjtAfaYY3pUTBJHvsLNfnLl2eXfn3Y6+CIv8y71E3qR0X0PpIRfv08bMp3N2sTnXizDUnOq5HBQBuSZGIQ8uLVioMTQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mni3tb0YZ/FDOLUNvPA5U2AoZBvxnFjqanr1wJWGFus=;
 b=PHarD0cQCIOQ5K/wOr4ZO5TD5a17VKGRP9L33pqACEJ/OC1lwu7RSbc2rAF+CS4sMemDjZ9lH3BDzsiqJKht2jYw6JXKYGKSEutYxrVX1JNZ0SHVxGfmjpf9L7f8yQJBXaBD91LL8BFBAQh/im6YqpOAfodw3itvIKoy+Hq7m8U=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO1PR04MB8235.namprd04.prod.outlook.com (2603:10b6:303:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 11:11:26 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 11:11:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Bart Van
 Assche <bvanassche@acm.org>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH blktests] zbd/009: increase max open zones limit to 16
Thread-Topic: [PATCH blktests] zbd/009: increase max open zones limit to 16
Thread-Index: AQHcFiA1fQQkRDBVQEK2gPNMTMOXYbR8o7kA
Date: Sun, 31 Aug 2025 11:11:24 +0000
Message-ID: <xzi4fo5uh6bcohtrhcudb44bklhuaf7v2vqw3nclyp3nya3xie@uq56vfv72wve>
References: <20250826002720.12222-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250826002720.12222-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO1PR04MB8235:EE_
x-ms-office365-filtering-correlation-id: 6adc71bc-629a-4ada-572d-08dde87f201d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eP/Alv5fc6eq71iVXjL94aqMejHfTsWYJwAno7zTqiNPcW1PmssSZdlddLYX?=
 =?us-ascii?Q?VXVje/k/KS98C3GoAU8Etzix8AHoxKnyZRiv0/BS5bcgty5pgTfTh+cgkAyU?=
 =?us-ascii?Q?+rQqrHWvbZuu7doxkxquQYYZGQM1Q9VpT7vR3xotXZ2YLaR1pz1P747fcptw?=
 =?us-ascii?Q?dwYLfoH0aNIIhOagO+7LDizHXGZnYEpENidNpEVCKWFYu5cjzmh7b4nHf7el?=
 =?us-ascii?Q?FQDLpdMQNWDiHbC6idy9wo1LJGMnPkT8S5YLBPq9WJwycyfZDeTFOv1MJ0+b?=
 =?us-ascii?Q?vFdse9KBgDdVLZu+dktxIEgrOxP6729DHNXQIogvTt3Rsrk+d44e76crHlxx?=
 =?us-ascii?Q?KBbkYelWBClVP8vP9wbBhzs8wlpLY94UX5onHkDNXHHQ3mdGdf7TpvdAvm0J?=
 =?us-ascii?Q?2m6XvJp9yCnyrmczl8F0Nqz8hYNUrNeDJtJ7PSHa7FOTRcQEIsoviJg7j5ww?=
 =?us-ascii?Q?BuY5y9rOyp17Ld2hY3HS7GTF0XXiys/hLz1Z2fSQ3u7yhhNXBlso/cdEfZyw?=
 =?us-ascii?Q?moSQYCPKuNYukpvPYWQUFbyJJgmwfWDKqtC69WhA8HvuawMvkP/bC2DDn1h7?=
 =?us-ascii?Q?RLFusA8NOf3FBbM+bpNGuIbO/Xz3fwXOjjphpolF6UzvsMsAT1mZRlJIwRDH?=
 =?us-ascii?Q?riKNYxrYWZZeUkcrj+4BiW8XMtYHyevbHi/YxwcaZjrMN8uGtCcdNc9YXJFu?=
 =?us-ascii?Q?y11SF+Pz65kOOJzes4hNjDvQa/7ZjiUZ2k2hmzf5v686LrgQX5TC2LASJoeh?=
 =?us-ascii?Q?JFlGq/ZU7jX2bVTaMlDgFJp64W6ZgdabL81vkBcFK+2csHd69RMVbRrlP+iJ?=
 =?us-ascii?Q?6sclWoZFSVJ5S25uw2p5IDcNLYd+0udL/zmu5Un8lOqqUF0kTBkXnC/u3fxf?=
 =?us-ascii?Q?SvHJ2CaHo5/bwrWZ0Jv46cJqWEsS8bRiTyPjyRDt3pcklP3FO4kvPeOc1foO?=
 =?us-ascii?Q?b86DLW4u3UEjr1LAw7QRIk5TNljtGR5y33YFHn/R8c3Pk3n0onbw/0HtNrmf?=
 =?us-ascii?Q?1XJYpFPMhw+LXvozy4eUCEhKDffi72l/XbVa3Y+oAi4axcJR2upx9z+31Xfb?=
 =?us-ascii?Q?nk/QZLXcbmD9jWcPC0gb6IB45hxpItP9lQQyCoWnu2aLBgzrzrGUfTY1JMsz?=
 =?us-ascii?Q?2BDkC65QFFy3305/5xb7y4OlgJTmpBy0uMVP0+qL19BuKUPKSvhJIqPUSY4i?=
 =?us-ascii?Q?4ycGYfIHTCEyLB8l0jJLgIk/gM40oWPFPFyCyy+QIV4IMEB15301s1oWriT6?=
 =?us-ascii?Q?RDEUiHusMDec53qrBD6RLG1fVQiwAXycWYdelkmwRNaoTHrmJu3/iBgmp35p?=
 =?us-ascii?Q?9lb0CEWihmQrlj8LZ6FtNrEBQ/iedtWChgGHMlc9NOwIFlYy4d2IwZhciHIl?=
 =?us-ascii?Q?pcQJNAvDPyhTu4oa9AJbgpCG2DqjREgdym3dX2Ck+t7Tmh6l8lSFFvz3XO81?=
 =?us-ascii?Q?vJBwLdWne2AUbbbWhYu8xT0X0sZyazIgyyIvDeJ+FEtEzkxdQ5yiKNG4U+WA?=
 =?us-ascii?Q?s1uuWf5VolwBmQU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i/r3eqcmhAEVFfCST/R0CPtCQ0Yccn7Dvthc8JvkACHfFTRHvnb61cBXHIWb?=
 =?us-ascii?Q?4ilLNir5vauKDfb8AnijtAhiIdgSm1XC4p0/a5AoHxx13qijk16mYy+dpbB0?=
 =?us-ascii?Q?ElZOPpJhBqEmO0xoueeWyZ0MGWjM0GzZbNKphF5CGiVW//ePFLfxNzQ7ogbq?=
 =?us-ascii?Q?LF5PT6wRB6q7CE5PompM19wLspVFOWjI5jeaxLT/5KkOL/BJMTZQAR+KEwfW?=
 =?us-ascii?Q?8UZVpFB04wHIq3CTGdGJKrakclfHL+5we8SGuwnfgAIlexRX4uzyVDAOXuQ3?=
 =?us-ascii?Q?4gp3jsuZaP5/7bfDthvo/VBZlapMbw2Q+NaQuvIW1eNRxWlhQbaYD1/dqfi3?=
 =?us-ascii?Q?AWmKPyiC5CXYmYG2sRxbzmvIuc3gh97a5BXIX+4J7l4vYSrwhP5AE3FngQFj?=
 =?us-ascii?Q?xIkg+ux3We3e16XOtKCBVRHrzNYHT8KSiglsI12gWr72zFTJDb1fOjQbMv1p?=
 =?us-ascii?Q?e9A0bx5it2/QVLvdPTqDwR4DvOb4PnykKQNA9KHAaVXb1p1YUBxyRlogddB/?=
 =?us-ascii?Q?RPViHGlTzQgqGiQwY/OH22fioU6hQaKwsNoUdupr+tJy6i5/KbXQCAW9QEcJ?=
 =?us-ascii?Q?WKhl3BhCR80tElGGzg7dSbPkxqohkpVMTMjjl2fxToZbiBp/Ev8WKeBw7vh6?=
 =?us-ascii?Q?mzwoVeofNbTBK8TtZo6Z4n8fSEug3WeKchkeSAcZLHq/R5Bry7ljHGd1T01n?=
 =?us-ascii?Q?FbCLjKsIOO+AjhtLbfVrXO72HrYj6X5U0PVk1YNSiooF56esQbCNHbHPCuGO?=
 =?us-ascii?Q?EIebJr/CgaU5jp9d8Np5KOyN21i61W/lQVUagQjnrzBl8WbI5Tlt9+1iJe9n?=
 =?us-ascii?Q?sfxYyJT8UH2HYGH/Okz4kHNA1/xvIjctFczS6VyLiYOhKv+DYLFpFoqEtcJV?=
 =?us-ascii?Q?NrF0JBUA2jFi8rUnBDmaYHAP3IMseTN1fis7kY/xZ0ncjJ7g7VNY8SlqEWjA?=
 =?us-ascii?Q?c3p8z74Kh71jtHREGiwjq28pkGs7sE77R+8K7+shnFXRJaXa/aK2r7y6ZMlI?=
 =?us-ascii?Q?JJKAV9koPdS3Q0GbI8IrxPN4qwdB7SudN5Mw1eMjrm5JwFrqtMg66jTUhmTi?=
 =?us-ascii?Q?9BpCHxmc8yLZ8DIZbx+yu41xM/QVNquinu3g0Kv/UWd/KE3mpHgsNv47USNx?=
 =?us-ascii?Q?5o9MZVpFGISIeYWJwZ4LoEAgHnerdH8R4YK1V5IkCS87diq1MQ3oZLZGdA3V?=
 =?us-ascii?Q?eeGoUiyPsz7ljbv2DsXYL1zJ4mC7Y6WStKwB30cP7CvIEXAmQnfRX1w8K7+F?=
 =?us-ascii?Q?kZfQGTRAnAd00YbuIa2cbpXZCC5y4Ku/kpJmqguiFfk8XKp2J0MJnyr8n+nK?=
 =?us-ascii?Q?6Z45MOHdz2OsH6AiJPmAYSQRKaUc561bCP+xoqJNAClK0mhXcST1MTQlyhTe?=
 =?us-ascii?Q?7WO0gMbuzptz/q+1zMzwQHgPfM3zLeb/tCRIASU/zyvcyjBIdE3AaCPsHXaN?=
 =?us-ascii?Q?GPbkihyZYi/KCrL0Gt8VOfm26E8bB+HHNjMRRrmJbko015Xnjq2hBVvMGCf8?=
 =?us-ascii?Q?tt2/6XlnASHee3qKYIhyL7FnrEUtE58Gmg+A9bLWM0yxFYBqmiyoGpzswb5j?=
 =?us-ascii?Q?eNDebPaq8zwAgHqucPdgmql5V2esITOM4+iG+hH5W2VmfKlmK7gftj17GlGC?=
 =?us-ascii?Q?/uRqCCEefqfylAZkgaRBc1E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19BD3C730ADA224AABED1C0AFFE8CE93@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ETNC885LcIEGrvit2/a6yDhli1iYkn3DDG9G4zDpuVLJYMlA2LzjoKk9Fk9D5783a1IU4+qq6g7vnpDiRABa6PFSaBU/PwGv6CTls4/kR75yqqqK0Puwog0bJhJ3nsT6oeeHLfZscdWxdHfN1TxzLg8pZLaAsA5qq9d4+dFfC4dZMc6P3tgHYycM3CzN2m9BTj+JdE8aEFT4Rfc8coj61c9Rv/jHVkBsysOEW/y9ViaJ23IKqFv6uBoAzEs9o7QQaXIGpYBOnVIcljG8+4QJE+5fJOQun92eIQ2cnLAz2Y2um41F3NCWhmYU12gy0jJAwo+z0IS4zb2LK+xvZK5TJSB+UmP6h+jBiPoek24XZfekq+wpG/Z9/LKqvQGdlTprEaRAkYXp8KSf4+IISZ8D/IE+WUbY641QsJydrKKAcop/NYW90ylUhpa3oolYrJyekaS9wfidwrzyK3kGCobQRAsFpPDSWH7ggEWZTsYygTmpthoMsug5Lyd8P7VLMpyTLK8h6Fnpy3Iv4e0u25uLFYhqYJtLU2t5iL3j6ZdyKr2L1x+Ndn5Tm171UOnL7LM7X6zoyDVU9+wZUv8E0/Acdce3nWWQxkZxLXJeIhGrd2W6eoYWPlUTIeDQGmE0+G09
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adc71bc-629a-4ada-572d-08dde87f201d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2025 11:11:25.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwCpfvQ2kU5xPvNQJNvkOwPPAAIed6dSpY38+Fpl955nZkCLrfwwWVb3ZGqs0INMI6d+3isxG+Y+ebuTIQaOAY/cPXlo4Zo/WfXOVfwZ7FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8235

On Aug 26, 2025 / 09:27, Shin'ichiro Kawasaki wrote:
> The kernel commit 04147d8394e8 ("btrfs: zoned: limit active zones to
> max_open_zones") introduced in kernel version v6.17-rc3 caused the
> zbd/009 test case to hang during execution. The hang happens because
> zoned btrfs requires the maximum active zones limit of zoned block
> devices to be at least 11 or greater. The kernel commit applies this
> same requirement to the maximum open zones limit also.
>=20
> However, by default, the maximum open zones limit for zoned scsi_debug
> devices is 8. The test case zbd/009 creates a scsi_debug device with
> this limit and set up zoned btrfs. Thereby it violates the 11-zones
> requirement, which resulted in the hang.
>=20
> To avoid the hang, increase the max open zones limit of the scsi_debug
> device from the default value 8 to 16.
>=20
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=

