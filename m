Return-Path: <linux-btrfs+bounces-19827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC82CC73BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 12:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 940643016C6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626CB33BBAE;
	Wed, 17 Dec 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RMeXWwVD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k9L+Io2k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802531D372
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969629; cv=fail; b=mRqtJoq9GZrDy6Wa9VXzZzGMJ7IrbasSiyca1+s2aZjJgPfB0VTm77lvjvsI2YsTgoEYeoK+zg/DR0WuIuxCZ1veZKCwlYUa7M8qaRmR9NOcfupJw0AG+ZVt0HEOmVeDerqVBiwnq5ggnXJp8qTfOWQZhibpmlQ9rnhopl6P/Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969629; c=relaxed/simple;
	bh=gHtJI988ys2MurSyNyfweRrGTnVtb/wxjn6+aBJb/sQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L8rdaO2YEPwuog4VSn08oV37S7ywWKbXo9uCd33rz+YdV+mWRjJNq3utIqBcb3kQsso6Y+7mQ4vnZ82bfqP75lBTCDVwErlA0NmYw0sOownhG5MRR389Dx6T5t2WuIUvYbTCmdYWk3+r8KgUfDAzNl9V61fAWb50uOnex3rceEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RMeXWwVD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=k9L+Io2k; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765969627; x=1797505627;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=gHtJI988ys2MurSyNyfweRrGTnVtb/wxjn6+aBJb/sQ=;
  b=RMeXWwVD6DuWQa/ygwhkZspsfpnf4+B2wOnT3Em/K0eRKW008UNA5MU3
   I/hTNgmBqsWxMneAtyUV4ywWE0Lw9E1dJvpDI0uNKYP9J/L9WZMVxeCeg
   iEhw5sRhWUDmhy6ImZpnsY4ckqJDsQddx9bhKbFEFZNIAS3VL9Dgo6uGI
   QpijxAeMF4aFBX84gc8fVz61TcUmLlmMvhihzfE5afeXvLrmK5qESwigQ
   eWHT2waK7tQ3F1dqH9ekHPD3Iy7ZmpTp62Nav6gzlkKj3JrbmrAoIMHoO
   OWxmeZhH00nj0exyFsfOsW3ARP6G9Zk2LeuEwipzXTVSTAkX3njoIDUyq
   g==;
X-CSE-ConnectionGUID: YqoyMgRCQUO4OWfDt+6zsA==
X-CSE-MsgGUID: YbPMBK5MSg6w0G5pgD4myg==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="137118181"
Received: from mail-northcentralusazon11012022.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.22])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 19:07:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Np42p8+DxwiNb+zHrws6xSl2D+nVrjkM2AAZ4mfR9Jy//lJo3/clN8PkVbZOFo0jarJ1WCR17/TwII3/GZw+qJ/thu6LOwtK/f3qXsBWvhgfsF94QgS28Qi8M03GmWW8IdOecgc4+wcv8V0y3bNUc4uZoBfKBwp+Yd4XeHRq6xUz0zqam+Q7fqiA/+TTFKGF5bRlMVm8yaqvJLK5a5yfc4mA2Uc7juHJLyjtYMXmDP0e6Uc1Pa/u6xXZqCurt9NRFv89Pb4hFSxhufqNV9VKTAXkag99DpMs2gyeImBDtWOx65Xt+0FaRRKSf2Ft/q2f8sTSuk5ed8FduUuN1pPVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHtJI988ys2MurSyNyfweRrGTnVtb/wxjn6+aBJb/sQ=;
 b=KoSCXhnAQs7uSWy+T8mCqyd764nApod/hC/DnTwplOK4YUVTNx5apwdplByEBXcpmi0jqrnp83DC+h54VmC9gf/XqP9k/djh2ChZDPATrOfMFnG5y6FNdVq63EGCSLA9/gmvXbzTHtzIgTwz7SFbYtyrzh0qUK2D8bqpFor53C+O0Yk2LaobdP2xE+NH/KuW1umZW43TbSlO0osYII4oIkqOnRDHFzg1apaWZcg+G0PBH2TphsYQSF3d4QxRwafxMFRiNBheUWYfs9YWcIIvLYA7NoypPWUpBeNFaZRLDSdGrEwxr6bWHvvEUtvkuxm0OGtf0q7wXUss2WhanLj3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHtJI988ys2MurSyNyfweRrGTnVtb/wxjn6+aBJb/sQ=;
 b=k9L+Io2k52NufWHj1oELhnsNS6sc5JznO7fAVdPZ+NsDrXH4LqwDfWwciIcRKq3QfJBw93T67XdIxUTbEpTkodVrjJGh6ENJSd7+PIqAGU1F5hzg9xVXwRrLkgsKS41Dc0QSxYgg8LS+zSeBNfeJYHVMFDNWzvbpolvzjF6ShmA=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by CH4PR04MB9482.namprd04.prod.outlook.com (2603:10b6:610:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 11:07:04 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 11:07:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fixup last alloc pointer after extent
 removal for RAID1
Thread-Topic: [PATCH] btrfs: zoned: fixup last alloc pointer after extent
 removal for RAID1
Thread-Index: AQHcb0DQDoEOiT9y80WqrtHThe+qJLUlrAqA
Date: Wed, 17 Dec 2025 11:07:03 +0000
Message-ID: <DF0FZH14M9OU.2HERAS6FMC51C@wdc.com>
References: <20251217103451.646206-1-naohiro.aota@wdc.com>
In-Reply-To: <20251217103451.646206-1-naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|CH4PR04MB9482:EE_
x-ms-office365-filtering-correlation-id: 256ea1ba-c206-472f-0934-08de3d5c68e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?amVnWHIzNFIxVkU0d1M2bEJmeGlhR1lBVDVhTHBWZFkyVzkreC8rdzJNK20y?=
 =?utf-8?B?bVh2a3N3ckpqUmtlSHZUVkVVakFmcXN3bzNKUmJHeGZ5eCtNMitoMTRqTlBk?=
 =?utf-8?B?QnEwWHhnOXpYYlJIVDYzMWhqUGRsQlBySUVnUUpmUC8wWjNWRml0MnR2M0Jh?=
 =?utf-8?B?UUw3WVA4bEpWMzdQajkwbUpKWFRoU2xvZzUwRnhCK3dXa05jWk9iRkdiRDNR?=
 =?utf-8?B?bmVXRDZ1N0pmMVZsRjBqWkRLci9xdHlWcFhsYnR3ai9vMmprdk5Gb3ZJQTg2?=
 =?utf-8?B?NVEzWkxaRW9BanJWOFhPRjVSSTkxT0plM3BFNWNnVlpVb1E2bjdlSHNUd1NS?=
 =?utf-8?B?TTdScHJnbnhpT3NZMzR0b1o1Y3VUWHdEOXBwMVBiTnNhU04yNEVXWWRycGxv?=
 =?utf-8?B?eGoxWmJEcnJCR2czamhiL3JVT1BuZ3FBYk5VaVVkNnJZS2ttR2t2NmVpaFdQ?=
 =?utf-8?B?TGU1OWFVcUdLVS9Za1hhN3pja0RIMEtSTnZ4d1ptNndVbWpYVFY2Y2JSZlB0?=
 =?utf-8?B?b1lJcjFsZndBcldtTXZuSEs5MTNjWnErSVFmajVmQk13NU1YMHUrVC9xL0U5?=
 =?utf-8?B?am0wSkU3REdrckZIdXZsTk5oN2RWbE05OHBicmF2SUZxRHRuQjRwUElzcXVS?=
 =?utf-8?B?dTNmSWg2VTNicERvVXRkb1czV2lwbTM2WDFPVG9Bczc3TGhBQzh1c3o0emJr?=
 =?utf-8?B?R0syNlNWaHA1dnROcWszZFpkcjhBaEV1L2ZMN0FSaWZuN1V0VHg5VDY4Nmcr?=
 =?utf-8?B?b1dNbVRpWFFPMlRXUU5qd0RYMnkvVkdZUjF2Vk03SkVUbDMvR3lDRGVPdkhq?=
 =?utf-8?B?ZWRUMzdlalNOV00yTHRzWmlqam5rUU13Unk1WlV0MjF5MXlWSTFWYWRwaXFr?=
 =?utf-8?B?ZjlvSXV5eDd5ejhkUjBkQmxEUmtPUlIwdjdWMWxnRVRaZVBmTUpXYXgrNVhj?=
 =?utf-8?B?cnJSV2ptK01HS2Z2Q096UlRRZk50KzRiZXFWMWtFOGVXLytXOE4ySkRhL3Yw?=
 =?utf-8?B?OGU0UzhOQVFzajdEeGtiZnlPZElpM2o5bWtHZUFnNjNtaVd1a1I3NFNHUXJH?=
 =?utf-8?B?U0FoVnBjdHRGd2VCUkZzaWs1aFp0Mlo4Z0RZSnBqUmIwNjYrK2h5dzcwbG1I?=
 =?utf-8?B?TGF0OUNLTTd4akpTT0NVMEZCS0ZqMDlhM1Z1WU9vRVhrMzJzR2hscWFUWmVX?=
 =?utf-8?B?QnUzeVFudlFJUlRSSlA1VEJlNUNJTk5wZUs0djE0RU9JWHpPdldxalJUTU14?=
 =?utf-8?B?MjdtNTBmc0c0K2VpUzNDK1pGek1RNy90S1hQYzRBdmZ4aUJFWDgrcCtSaVE4?=
 =?utf-8?B?QWhoak1hd1JLVTJMcUg1T0xkMXd6RkpGZ2pFK3FyN2lFTHhZRkhSTzdqZUow?=
 =?utf-8?B?bUFGYnU5cFVnUnM3RU4yUHBtWUl3MERSZjBwR0hXSHlObEVQRldHTWUyTUc2?=
 =?utf-8?B?R0lXanhwTFpwcGNqMFZBeFFlbjNramVhNDVSTHdyS2o4aDExZUV1M2JGWnhH?=
 =?utf-8?B?eDhZdVlocDBTUjMwa0VFYi9naVpWd1hZSkJ1VTJZV3RYaHAvTUpybkZUTzd0?=
 =?utf-8?B?cGNYb0lwOGhJN2NnekpYVjNhMEg0SHNudUNxcm50bW5veFRUSnN1Z2ErbnIx?=
 =?utf-8?B?WXg4VGR3cHAxNDJ5STU0TFQxZVlDRStQTGY5Y2ltdEFFUjI1SWlORnlVcFBq?=
 =?utf-8?B?cHExUEh5VXBLak5objFyVjFVd1FZQ3RXUXdDbDJEYXk2QlFOOHp5MDEyTFd3?=
 =?utf-8?B?RFJNcXZkYkNjOTF5TmMxN2JLZG5xcnQ1bmRON2dmOHhPUEwrTC9uTFB2Q29p?=
 =?utf-8?B?OWlKZFdRTW44UXdGbENGRnlqcVJDQ3M2MStsZkJYa3ZtQmhRM3B4WDVVV0xQ?=
 =?utf-8?B?TnlKdGVYWUdOVzZnVGNFU1dUeEVGcGJ0MG5lei84M0UrdkJVMnQrbTdJUzBE?=
 =?utf-8?B?Q3FXbVBJUGxJOG5YTXlpSVJOL0hGa1l2Wk1kSFdRb0hjMGg2WDVrM3NEVXV3?=
 =?utf-8?B?eXI5K2xBdndDSFFFUWlnanF4anYwNGNNZUF6Mko0K0diRmJqdWRDSXM2RmEz?=
 =?utf-8?Q?3kpdO1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nkh4Y3M4a0d6Q1RBODZLendVdUk1N1ZQdDVWM3hQTUFXTUdvMVlpTll2Wm0y?=
 =?utf-8?B?Y1N2OWl4b01lUFNXU0NKYmowckZlTU1lNXpmSnRFSzVFWklUNlhRajB4dTRt?=
 =?utf-8?B?ZnZUMXBubUQwU2hCSjB3OUY5ckE0R2ZtOUhRMzdYMTYwK3NzMDhDSEhqOXVx?=
 =?utf-8?B?MmFvY2tnWldBTit6Qi96T0VSU2U0WWRTT0cvQjVpWXdyeUVKNk90MFZlbHZh?=
 =?utf-8?B?V1N5SDAyV0ExNzJnWVJTRFZnVXhFYTN6dVJEZE9VblZRZTVwTHk1dHlFaUZ4?=
 =?utf-8?B?U2toMXlhSUhhcGZrMnQwdnozc3dSdWp3OWlNV1hheTlhTmM5R3ZKZG9zLzgz?=
 =?utf-8?B?QnovUDFLUE0rY05xVHFVNTBlR3lnL1RPY3E2UW1UVjVrRm1KK0svQUR1dUhw?=
 =?utf-8?B?L2V3VkdrbURxZWc2c0t2RzhORzM1QUJja044dmUzUE5HOWVqanFNdGVuUlM3?=
 =?utf-8?B?Vmtsck1rSWhFR0Y5WDNYMUt0V09OYTIvaFViVXVYWXNKeFRZVGx0R2tUeWlK?=
 =?utf-8?B?bU0yU2RsTnVrTFM5ejQyMFNKM29CaTRrVXFCK3Vtb2tMT0tjbktoRWhJZzNS?=
 =?utf-8?B?dlZWNkJJMTM4ZFBhcmZWTlV1RlJpVDV4V0hJVmRFS2RpZHJrdER1M09HTHBr?=
 =?utf-8?B?U21tb3JqWmkwNnNpM0pmYmdsUGJYOUJoeEZiWGttUnpSRFRnYTZoaStjdHNM?=
 =?utf-8?B?cnFCMUJBT3pmakpMWkFOM1hteGpWbTZrNkxHTGR0WWtKaWxuVFVuQjd4aDkv?=
 =?utf-8?B?NCthYkJESEszdmlwNDlMT0lWZDdxcmkvL0pWa3NaUlBzc2hOWUJSbjhkRXcv?=
 =?utf-8?B?Z05hU1VoL2lWUnl5WkFYSjV1THF4Z2VmVll2N3oralBXVWNlV25XamFQTWw2?=
 =?utf-8?B?UTZNazdmNHJmRHBaUkhUb25VbTZsS1piT0xUQU03UGF2bGlVb1k0MUVMZVpn?=
 =?utf-8?B?NjJ4Y1J1VnNVNU9hSzB1ZGZRNEoyZi9LZ1RTdWt4R1E2YkNYVjRoRFFqUHV4?=
 =?utf-8?B?SFVvTmgydkxQa21LTVRTNE44eklJSmhBYU4yblhEUjRsTjhubU9WZXV3NHdI?=
 =?utf-8?B?SFVaM2NRTWZwbTlTS1kzZ3plQm5GWWNGbVVYRS9CanV3azkwT0pvUDBnU0NC?=
 =?utf-8?B?OVBGQjV3cTFWSk9sck0xUCtEbjVvbFF5WXZUMnF3cFV4U3JrY1Q1enEwMXU5?=
 =?utf-8?B?d0lBUUdsMitmL2xibTF4Vyt4R3RJNFhKbnFGUUlwRE5iandSU05NTlNJQzFX?=
 =?utf-8?B?K3JZMFRkZ1J2cm81bkJKa0dyUFBFZmxQNnQzYW9GeHlqZFc2dVhuREhPVW5i?=
 =?utf-8?B?TUp4c3pzNmZPdjRoWGNZazhIWmJKTWNtZ2t2R3F5bmVyWWU2clNPVDhjV2E0?=
 =?utf-8?B?RWRvWDRTQXhWL2V0Y3ArbVNoS2Z0Si9Bdkx3a2VrZVFRbnlDRHhnUWlObGJm?=
 =?utf-8?B?RDJaYkhtbWt2TkFVZEdxaWx3aFBmSVFnWWZOMG1rVm1uSU1PNk8vWmFsekR0?=
 =?utf-8?B?RFpYc2xTeExpVXRqZTY1b3NxNHQxMitmU3ZXVmcvL2dxdmR6T2VYRXdWTkRk?=
 =?utf-8?B?MWpWeTFNMUxYdVVFN1Y1aldTK1BzR0VNSTkrcDkwY0lPdlJtRW92NWx4MHJP?=
 =?utf-8?B?VnJwQ2d1bmh1WGdtSlA5Yy9SRGgrYkJHU1lzcTcyR0oyVHM0OWh6Q241cE9D?=
 =?utf-8?B?OHFaTWI2QngyQkRPdUJOZUh4WWYweHlkR0hUSzZoVkRSSlJhTUw0OFEvcGRm?=
 =?utf-8?B?S3diZjY0SVpJaEFoWFQwM2I5eEl2V28yV2pUNXFicTlrQTFUWEpTb2N2dEox?=
 =?utf-8?B?Ulh4RXVuVmVhUTlVRDJBRG12Ui9xQWVUQzZGaTN5T3NIVEVkQjhyb0xIRjZn?=
 =?utf-8?B?WWticTNiTDliTnM0Z1Z4RXRJSmtGUWdxQXhjenhWbUx2QWNVem54NzJJK01M?=
 =?utf-8?B?YndyOWZnOXFic0NkdmJmWTY1TkFEN1JqUEpwUkUxU2JMZnBFYWNPOGo4MVZw?=
 =?utf-8?B?SFFtNFBBVVB2ODNxM2luekxiUzhoSlJaSDY3YStaWTBnNkxxM2pVMjI0cStT?=
 =?utf-8?B?dmpJWmFEUUZwVDhpQTc5amd0S3ZoNDROTXpMM25PNU9qMjNWUXBHaGZISUFh?=
 =?utf-8?B?TExFTGFET1FNZndpYkZMSUxrRGR4d2dOYllzU0pDQzJleXRmdGhrZ25OVjkv?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCAF579B4B04B5478601370328600C8C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aC9ZbInsQbM5c66A2KEehMqPFpItoJvYS70EPmmrfnwAbq4pIgE08nLzMdhtcoGc6K9+tp84A9vkANqcbCDdIF6waVn4GPxLfbaHHg650C8kH6LQXhoXSlhfY/AO4G+6v5AkO+PusBN5bn3nTSqFCnsbWwmcLFbfz8BpGCAMcurfsfACFxqPA79KcXXzM+wF1aYaeL+2+oTdxfWCXX4emw88o94gWvnht8ZjRazdKQ2VKR/kOM5CfaQx5x1zYp/HO+OgRXMGRx3EBCs3oWh3IzRYSerUMke8Vuh7GiQ/TfLIuzA3hxPCX5wAPGONeg14GWghuAsmKxbH2/j9pfpFbzyTiMqZcGDm4ezy1i1ThuZnKsdg14q71HmBiT/XgCpOj9qIlfpqvJzrYS9yBQ4jlwv/IkueF/4Otakfq8GB/aFHz2J8i5DEk3Bzxy1170qcD1cTfyttbgYTWE7/RQmt+69//DlYJnY6BPObgUCEpn8amGi8ymYHsSp+6HXcAVCG3ManOe0OCo90F3oQsEYvSxgkgsvYwjdVERv1mue3rU85EHj42xU9PXJ07A3mE6IiBdwuIs6zQsu5QzOJChwnvKpvJHBJJ45xGHmIuEZ9t4ysphb9Rl3P3QmGWR/mve84
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ea1ba-c206-472f-0934-08de3d5c68e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 11:07:03.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUb0ubiSSMwOhLe3ODZR0nalbPi4wrHZ29UrSapaxK82tk8RSxdiA4RoaopKP2Bit9oPrR9fFYVcEamxngzigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9482

T24gV2VkIERlYyAxNywgMjAyNSBhdCA3OjM0IFBNIEpTVCwgTmFvaGlybyBBb3RhIHdyb3RlOg0K
PiBXaGVuIGEgYmxvY2sgZ3JvdXAgaXMgY29tcG9zZWQgb2YgYSBzZXF1ZW50aWFsIHdyaXRlIHpv
bmUgYW5kIGEgY29udmVudGlvbmFsDQo+IHpvbmUsIHdlIHJlY292ZXIgdGhlIChwc2V1ZG8pIHdy
aXRlIHBvaW50ZXIgb2YgdGhlIGNvbnZlbnRpb25hbCB6b25lIHVzaW5nIHRoZQ0KPiBlbmQgb2Yg
dGhlIGxhc3QgYWxsb2NhdGVkIHBvc2l0aW9uLg0KPg0KPiBIb3dldmVyLCBpZiB0aGUgbGFzdCBl
eHRlbnQgaW4gYSBibG9jayBncm91cCBpcyByZW1vdmVkLCB0aGUgbGFzdCBleHRlbnQNCj4gcG9z
aXRpb24gd2lsbCBiZSBzbWFsbGVyIHRoYW4gdGhlIG90aGVyIHJlYWwgd3JpdGUgcG9pbnRlciBw
b3NpdGlvbi4gVGhlbiwgdGhhdA0KPiB3aWxsIGNhdXNlIGFuIGVycm9yIGR1ZSB0byBtaXNtYXRj
aCBvZiB0aGUgd3JpdGUgcG9pbnRlcnMuDQo+DQo+IFdlIGNhbiBmaXh1cCB0aGlzIGNhc2UgYnkg
bW92aW5nIHRoZSBhbGxvY19vZmZzZXQgdG8gdGhlIGNvcnJlc3BvbmRpbmcgd3JpdGUNCj4gcG9p
bnRlciBwb3NpdGlvbi4NCj4NCj4gRml4ZXM6IDU2ODIyMGZhOTY1NyAoImJ0cmZzOiB6b25lZDog
c3VwcG9ydCBSQUlEMC8xLzEwIG9uIHRvcCBvZiByYWlkIHN0cmlwZSB0cmVlIikNCj4gQ0M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjEyKw0KPiBTaWduZWQtb2ZmLWJ5OiBOYW9oaXJvIEFv
dGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPiAtLS0NCj4gIGZzL2J0cmZzL3pvbmVkLmMgfCAx
NyArKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykN
Cj4NCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3pvbmVkLmMgYi9mcy9idHJmcy96b25lZC5jDQo+
IGluZGV4IDM1OWE5OGU2ZGU4NS4uMTdkZGU5NWViM2U3IDEwMDY0NA0KPiAtLS0gYS9mcy9idHJm
cy96b25lZC5jDQo+ICsrKyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gQEAgLTE0OTAsNiArMTQ5MCwy
MyBAQCBzdGF0aWMgaW50IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfcmFpZDEoc3RydWN0IGJ0cmZz
X2Jsb2NrX2dyb3VwICpiZywNCj4gIAkvKiBJbiBjYXNlIGEgZGV2aWNlIGlzIG1pc3Npbmcgd2Ug
aGF2ZSBhIGNhcCBvZiAwLCBzbyBkb24ndCB1c2UgaXQuICovDQo+ICAJYmctPnpvbmVfY2FwYWNp
dHkgPSBtaW5fbm90X3plcm8oem9uZV9pbmZvWzBdLmNhcGFjaXR5LCB6b25lX2luZm9bMV0uY2Fw
YWNpdHkpOw0KPiAgDQo+ICsJaWYgKGxhc3RfYWxsb2MpIHsNCg0KT29wcywgd2UgZG9uJ3QgbmVl
ZCB0aGlzICJpZiIgYmVjYXVzZSB3ZSBuZWVkIHRvIHJ1biB0aGlzIGV2ZW4gaWYgd2UNCmhhdmUg
bm8gZXh0ZW50cyAoYWxsb2Nfb2Zmc2V0ID09IDApIGFuZCB0aGUgd3JpdGUgcG9pbnRlciA+IDAu
DQoNCj4gKwkJLyoNCj4gKwkJICogV2hlbiB0aGUgbGFzdCBleHRlbnQgaXMgcmVtb3ZlZCwgbGFz
dF9hbGxvYyBjYW4gYmUgc21hbGxlcg0KPiArCQkgKiB0aGFuIHRoZSBvdGhlciB3cml0ZSBwb2lu
dGVyLiBJbiB0aGF0IGNhc2UsIGxhc3RfYWxsb2Mgc2hvdWxkDQo+ICsJCSAqIGJlIG1vdmVkIHRv
IHRoZSBjb3JyZXNwb25kaW5nIHdyaXRlIHBvaW50ZXIgcG9zaXRpb24uDQo+ICsJCSAqLw0KPiAr
CQlmb3IgKGkgPSAwOyBpIDwgbWFwLT5udW1fc3RyaXBlczsgaSsrKSB7DQo+ICsJCQlpZiAoem9u
ZV9pbmZvW2ldLmFsbG9jX29mZnNldCA9PSBXUF9NSVNTSU5HX0RFViB8fA0KPiArCQkJICAgIHpv
bmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPiArCQkJCWNvbnRp
bnVlOw0KPiArCQkJaWYgKGxhc3RfYWxsb2MgPD0gem9uZV9pbmZvW2ldLmFsbG9jX29mZnNldCkg
ew0KPiArCQkJCWxhc3RfYWxsb2MgPSB6b25lX2luZm9baV0uYWxsb2Nfb2Zmc2V0Ow0KPiArCQkJ
CWJyZWFrOw0KPiArCQkJfQ0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICAJZm9yIChpID0gMDsgaSA8
IG1hcC0+bnVtX3N0cmlwZXM7IGkrKykgew0KPiAgCQlpZiAoem9uZV9pbmZvW2ldLmFsbG9jX29m
ZnNldCA9PSBXUF9NSVNTSU5HX0RFVikNCj4gIAkJCWNvbnRpbnVlOw0K

