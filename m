Return-Path: <linux-btrfs+bounces-4337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459E78A81BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E304A1F243B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3602D13C838;
	Wed, 17 Apr 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eEapzfYw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DKnbwfn4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B113BC1B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352288; cv=fail; b=mIPAVhschQNc2ZAOYrtqsr9rFvUe48tnuz58lcCm4Wr/bhldwQdYpPis2u4a9wV6o8pftqmDKgh+bBDpBa51QVHpdwRBEs5jMgk9kZX2AqSFQ3PnTpg05zGxqCvJZRdeddzvM+2KBYmS3J1mF+HbKrPtdECDNEwWUhJFOPlnMXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352288; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XdRMYFO+5xOaGbA345X5aC7BFrWodZpCdxbVEh3Tgq+BcNhtTYEflwA5AC4eFP6Rbd5pj4tHMW07tVx48GSkdKdakKjS6zN0U61WoS2jSkPKaJYOOsWzACjkh02FQVfFa3weOfWCFPgLyFABsDv/MDl99+0rllKo8qhkdv+szHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eEapzfYw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DKnbwfn4; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352286; x=1744888286;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=eEapzfYwipqMGlGj/Jh/5+oarOG4H31kmxg1EYRG3RZuhZjMk8MDWa2k
   rI0bAusNS5WJuh8JQQVfWjcM2HaG0PiEci/muNMWoWp3sAHkxKqf0W6Th
   uea/C31qzRZRIoA/UCeDaKMJ1vmbuoZN0NmADqiMD/u0e4lzwHzKjmOcv
   j2iPqvE0opLO9najYV2PFI8PhOt6KkjVPQCUk5ZJvIH2mt3iJPM4ZtwN9
   oqyPBTr902IDcuLl5ATh28f7TsP6o0he068wba/2nHT0NQRiMzXCImmQ/
   rEDWbr1fuFBxAn/ux2R+FGqn5WkvlKIo/VTwHGSyk4i48ZK5GoMkq+Fua
   g==;
X-CSE-ConnectionGUID: VCLXxxGgRRWyWUTirrM1Eg==
X-CSE-MsgGUID: oq9N4MXMTfamdvdiggVoQg==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14214576"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:11:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9raGxGwfV5jBDg3g8CDb9QDc6DeZK4fCcJVDUwFAOB/r8XQ6zn0TYL0c4a5nml4KEAh/GEzs2PTdIl8ZczzbigIykdrlwPk4xZwokw5TqU3KtBZuBKoqftIh3UKWd/daeae2h9ZJsmDpmYgajZ5pYCjD/xJighbKMc5iHijDr77XhYIq7BWSkqlLzRSluZa5FE/DiJn/WTzxzDkEAI+vCjQ45qOlhJfc4FKLl4wTIxqygzdfAR8ekj0wUQiSbIVZylo2nfVM6WnJkStyTr4w1TftpIus3ZXWwT7vODom8V6R6HbVKek9YvXmHLUR9fp87M75TwhvLWSSirt5vH4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=lBPIO5i7bECw9AhZs5qoFRjwiHx46kFBgoH4zKvm4A3qxzFN6Qjwh34UbRTvojEIbx5FADl9wsmPZ6Dj2MGGHpzjB8/E+bF34DVj1xUS/zwijl3Ir2RUmM9d/kKPr0+GkDF3bek6053dVQXf2cOOT0OfDqHrvyo8PcvsAiAmCg63VxlrJtzqGZjfbfjvn68AmFJJ1g5xAHeauDBGEm4yJkTNsRDlGFPicQQwf6RR5cvfHr2QNw0sT1bkJjZABxfGEKYsx8HzBm04A71CsHjxky3qSrRUP/wMw5Juvjgb8bAKwo/nqC9CN73A0TaBrwnmrudHosau27KwDujbbLhVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=DKnbwfn4PvG3XByvaNwhn7kOtS1JlWwZt3CliRbtrlEVyP+g0WM3oPplQpzahmtIKiq0MORmCwD8YlFSDmcZY8sPlohAwenU8Tgo2HjNghfFE53pKASPPKs+zK0GUsVIR2aR8Fkqt4u4lnZhViU8AvI4xwlikLqEpLGoGz+Ob5g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8453.namprd04.prod.outlook.com (2603:10b6:510:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:11:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:11:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] btrfs: pass the extent map tree's inode to
 replace_extent_mapping()
Thread-Topic: [PATCH v3 04/10] btrfs: pass the extent map tree's inode to
 replace_extent_mapping()
Thread-Index: AQHaj/87giXeIuCzKEaYaJjVzCAWRbFsT/iA
Date: Wed, 17 Apr 2024 11:11:23 +0000
Message-ID: <07f68454-a10b-42b0-b44b-d76269f707c4@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <a6bd0f93096d8decc2c7fc7e6514225df01e7619.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <a6bd0f93096d8decc2c7fc7e6514225df01e7619.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8453:EE_
x-ms-office365-filtering-correlation-id: 0273d042-f8e8-4c74-51d0-08dc5ecf1e52
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Oy7sQOKBdZuCsJNpyYnrMpNDFsMYkoZ4kis6rdtNftupnkSM21sbyW24W6kl4kHqozpQFV9QGB6VetvwoTCRv+2jQuquHPSAeP/q7s8v1rWN9QcovRt3HJkbW/Ftk14PQ2K2j2bo8CBWMySWxjq3vZxYkUXmuklxeXg4T8MQIuCXXrjh07lr1O21sL4koR4vyBC+VDH8iLkU1krwi6ZlchvAEAFckNEE/7x6hTwVUg61O5q9xR7LlALIP1gB1DXpSS27A1GfsSsCDs1mFmz2gF+KIRsOuCeBA/GEcAcHEgNXLbiCPMKIX5lZ3Wv4yZs4bDs7y+yw+LAqKW4YfPy+nsDdZs9/NmCpv1D7SC0JdXZjn2DCJFWDJgZKVvcqGoUspc67J8wm3QVUpG+TfRobKD+PTm3F/1yfMrAyDrXB2Kfb6FAPrhPQrQ+JoHkQS/0cDf6SkL2J0ba0wpRTFOCSAtjzzO+A7zdscWVJIlqd7gyLjcfLokmGAWHb8WmOGqw+t6Ah32T3UwdQDcPkiwXkwcjX7esmfWNatgjdJpnuMzIlQbjVlsDUk0BKgEPyK2olOnSRR3ZiLdV7BmyvERnTzR1wCifuecBWu9DhvPfp19Kgfm/1OxA17esC6UT9j/PRNlz++tEVkjbmT+1r+diUoRSAlOzBpLw8WdF/2GoZ1mJCEUDxC4Pu5zgW2i90pgOmaNuAGNGoBqqxa+jAGRgkNyKL6NefSOp4SoG5UOOUs1I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFJOZExtVEpoWE5kOG1ZTk9obXZ6KzFoZEMxd0ExK3RJVENDMmV6RUhTa3J4?=
 =?utf-8?B?aHAzdVl3OGZzRCtrdVhKVjFQc0NuMW5ZK0xJb25uZ3Nhb1lNcjE2RFo2bXhD?=
 =?utf-8?B?WEdFdnRrTkxEcGZVWW1xUGU4ZVZzL1FYVmkrOXdvc084MXRtVmNnbmhQQnFQ?=
 =?utf-8?B?L2YyVjhvcWZRZWNubUR1dUYvd01ZSm9OT3JLd21GQ0s5MHBjNnZvMEJhRWF4?=
 =?utf-8?B?M1BaWU56Q3lVVXF0eDFkSFM0T2dxT2ljQlhpMG1UMzBSOHVTSlh3YXBDVWVj?=
 =?utf-8?B?TzdtS3hhYUwyV2ZCN2g3RitlM3d6WjB3elBmQVY5aVR0M0o2QnNtNkpOQW1V?=
 =?utf-8?B?c3dPeGJTazd1STZCZHVtbjE1bmhGaytTTGEwYjlUbW8yTUxlR0VkMFdYQWh1?=
 =?utf-8?B?SXE2dHc5cncwZmJsOTFZRTc3RUpBbWxFcDFaSEhDYzJLYm1RUjROOGJBY1dV?=
 =?utf-8?B?Q1BjcmFhcDRadEJkaTY5T3c0V2FRaDJta0x5eHhDZE9JMVlNTGp2WXZYNCtx?=
 =?utf-8?B?RU4wdGYvcWxTUFVOSUFPdGFkMzdQK2M4b253bFZBT3VmbkljNkFLNXZMVmlC?=
 =?utf-8?B?aDNTazB2VHZqSytUOU5LN0RtVWFueHJWSVFXb0hNZDZ0NitlUUNPam92M0t4?=
 =?utf-8?B?ZVVyell5SUE3cjVzd3J4NFF1TmpxcitwNkwwdTZDSlpDdXQwYVNJRjJPSW1v?=
 =?utf-8?B?cFhZa2ZRZytFd21FSDVhNVMraW9IVDN2bkNWR3BzS082QkRyd2pYbSs4Qkp1?=
 =?utf-8?B?M3ZVcmRldkdGNVFMdWYzT3Vic0xRMk1TeEd0RDJ1dWtvNE1tZU4zNCt3Ukdh?=
 =?utf-8?B?ZnNvWGdKNEhBNjE5SVprOHk1UVkrbHg0aFRZVWhOWHlkMHRTRzZrdkdTRkJM?=
 =?utf-8?B?NFlXSkkvb09YbGF6SDE5NmtjTC9vTjRhWkVPaFJKUjYyd0laUDVtZ3J2YWJ6?=
 =?utf-8?B?TkU3aHFQREgveStXYWRMQjJYdFh5QTZNV2hYbmtiMTEvQU42eXBpU1dwWkpn?=
 =?utf-8?B?T1NHc2ZXTkNESXZYVjRZOEx5VnFub0hLUUtjL2h4eEhJTFE3MXJkRXpqMnBK?=
 =?utf-8?B?bHU0aS93QmxDMXdPNytCYUFyM3NZSWljTWFCR3craWFVTU95TkhCTzE4QlIv?=
 =?utf-8?B?cDhjTjZKbzltMnd5QXkvTE9EcFBKdjZmN2orUUFiV2VoWk5tNzhPVFpiTTl0?=
 =?utf-8?B?S0JPZExQdFRJUWNpbEwySnZybzdMQjJoYU94cllvZkI2dlJzZUZ4QUEwTGxh?=
 =?utf-8?B?aFpUUDlpSlVMbS9JakZlYjZINXloUStTMmcvQzc3ZDBvQkFkRnZYWVpyTi9R?=
 =?utf-8?B?MnhPUXN4TDZ2S2ZwUnVFWmxlc0VEeGxpVFFkR2FTc0NRczdTd2pzMmlleVla?=
 =?utf-8?B?cmVaNzBwbUNhaXJYTEV2b1BDRmRhaTJSZGxrY0I0S0FuYndZdVhERFcvS0ZJ?=
 =?utf-8?B?ZVY5VDZEK09PU1ZqVWZtWnU0WTh6bFk0b1RrYThCanAxSWVrbnNnL3hhUTFY?=
 =?utf-8?B?amJ3T3hnc2VldG9HbkhRbEhyK1JCUFdxazM5c0loQ3FGN0dkcHZseUZ5UWo4?=
 =?utf-8?B?WGxBbnFKY0V4WVVHYTlrYmh3QjVlY0JsWHBxaU1YRjF1bWQ2SFlCUHB5bUIz?=
 =?utf-8?B?RW5XbFlDNllxQWY1eURDZ3B6Tmc0VWZvTVJDTDN5Mk9UN3FLdEthZktZdk5z?=
 =?utf-8?B?K2tKWXhZTEpGS0xTaHhVQnlTZjlRYWdkM2dBVklFd2JhQ1diRmpFaTJHeUpM?=
 =?utf-8?B?STVPLzJlUy9YMWU0MU9kQUNIaDBzTTZYdjljY21KOUp6NzJRTFhVSHhsZGsv?=
 =?utf-8?B?dG01b3k0YW52ZldadHFRc3RTSGlyTGE3ZzBaOW5CWUIzVE5PTWgwa0ZHTi9L?=
 =?utf-8?B?MThwdmNNSE16MkcvUy9obEhmY0orSFdSZkhSNmpDdFZPOXdEdFdQN253MDU3?=
 =?utf-8?B?Ris5WlZFcEFvWWtTbEF6RkwrcTlZcUpOOG81c096TWRFRE1JM0pxeW9NbzRO?=
 =?utf-8?B?ODNjTm84V0NDOTVrMWJQZ053NUtwQXJHcWRYN3lYN2xmVk9mSDB6TTg3REZI?=
 =?utf-8?B?Q25vZEM1N0dLbm5SKzhWMThkQWx1Skg4RFBCd2RuVXZzMTZZZFFKNGdFUEQ2?=
 =?utf-8?B?UTNOSTdIMnc1RGhqcnlhREVzeVE0U2dUVkk3NnZPVm9ReE9vM2puR2pWZHBY?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA999F15FDD807478B3A26E23A646922@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gBFTEeKm0PQyQLAy75IN1FPANFpnu6bgyMMVqfzADxZvC+UkChEfMCzcfKeWas1TRiH/pSmG3m8gkjjanA73OLlHz+RFJ58+E7VGDv7q0V+Y3+fwGSI1x0qadVpbYlWk9UPt4fjihqxmv7uilYJKEc+7u/s/n+MYJvoW34Mk7B2e5liS1Rhch4ZbdG0/kB3nrcEr6IWelBbp9hkLjfN9bgF0cTYyhE8irHwk/d1jNpwwXo2is5FQ6ImZ6gipMSqQFeWzjop1WoVe2EPNn/cECm7zJgKa5AfzJ1vakWUM4GrU/MnzbufFqu7hvyPwPcHeEseXLUayVrYmfYAGLiJGDvJDYFbjDLOruQRxNK6FM9PFlwN2OO0JMjydaFlTiNGfmh7EzavJ7hw61D2fPJqGzihtXhw6jDBqPVW4Eddlx0BIIGhAAMwT0fdQpbFX5y+JwPzeKKZbNtMYeOxDJFDRNxkFjgvI3Y2zFeVxVsqAnu+eD9sElouHlbuWOVtrguU6bWq9W/kB+mhTX/iwzw0IYge9eXtR+j4+pDFeswYSZ2nsQS4WQyjAQjeD54ITHOrBWyTMyLysoVp9m7NPXcK4udz87MzPMsRoMbEnc53IGAr6VjyX3Y/eXiCFrLxRp9C2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0273d042-f8e8-4c74-51d0-08dc5ecf1e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:11:23.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n06TuV5qYoK9sLtSvN89b4X6A2vjRw1Ayd578e0bHg5kfr8ef57cB6yn6k8ZtRHxpggO7JlZErPxCb8oIJEDrs9X5TVT75G7vu52P5PM+M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8453

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

