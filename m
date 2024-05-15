Return-Path: <linux-btrfs+bounces-5011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC628C6A88
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5103528744B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04111156657;
	Wed, 15 May 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rQmuQYaS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yUdOhvbl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E813EFE5
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790330; cv=fail; b=bo4Z/5+csxQsUOQzpDkpJ2s3F60WGnAuY+7o8mPWiiOr/xvNvfm21+uuJCNCuFKkvXXPlKhhxgEJvsE0digYMRmoxZRo+03awwImnv1QEKy9XKD56QeSPfnQBYEEGXE9or7s/pZySQ/1mvsVKRnBjFvjZ8pFiWpiDpUzyW3JpY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790330; c=relaxed/simple;
	bh=llE0OipyEcJAQ9SkUxGVBJlnKW0JIZRgbC5zkGF5x4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVv1zy483yUk+qRe1SL6xbMr90+ylX7RaSFrgEkJVoSnjrYI1bJL0nvxyIrdDuDX5Et5P5bgfkDWgdB1GJGqlSLtMoB1Giw1bcxisyPHkL39l8obRTYD3ioW0dSUKOwCI6MeZclbCxChG3hnKAg6Qoj53vSyUt7GqIolzpuJrtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rQmuQYaS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yUdOhvbl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715790328; x=1747326328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=llE0OipyEcJAQ9SkUxGVBJlnKW0JIZRgbC5zkGF5x4A=;
  b=rQmuQYaSj24O2uyVHWqtD2LYqOlRZa2MsZ+5hFHRiKTBmd2aFrNK9E+9
   B9q1FlUXpdsL4f4LmJ9w1w5mndmpwCtwGJsUvb8P3DpZ74wF7Pi9aTUUG
   Jj1AsGugPWsXsUUn8xeGWibB5oLbGXDU4XiQPA5wWCOvr82U0HevcJO9D
   J49jL5GOoZ6QhYUXYY899LOblE2ie9cQDIyppEfSfEqitAUyqyRJbZsIu
   C8z42urj6EAaTgFCvzm1c12p9AdBHvBlIWqiUncZgce6+H6DPYNVfdlWN
   8kUdWruCwqN4VR9u6OM4aDSK2xTWCZLO8xnMXxA9qlLBeCUhs+A4Y57On
   w==;
X-CSE-ConnectionGUID: ovs481dmQQihCyOggndwjA==
X-CSE-MsgGUID: AQRj+ZfJQL6ZJqwKths6Dg==
X-IronPort-AV: E=Sophos;i="6.08,162,1712592000"; 
   d="scan'208";a="17247673"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2024 00:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj9JPhe5QnQEk+OsCTKkefFOOUpW75zoxU0YjQqacxvYAiZM7oxZ/mT8/t6cAt389OrCtoEAfhk1+TU3pHlQYJYtssRmGkjakIuN4008UY/QhipvCN6aQv1LJbCzyxkQ3SKUk8ubKSlOuV7sE0HmFp/bWEjNOFcYlvKUAR27SRvv18r3pWE/ml+KZPtK0vFUXntnSmAaoBMTR5HmH+BBkk+si704qsA+qpKwi2zYT4RDb1LMlZnLwRT45VH1X8Kh0/a5KZ0OGeOuOt7Zxo+bfdVsX5+Jla+7kKzhDiJwzc72bnRc5nsLb01ggXh2kw1Uc3uaXAd3DDXXV5YK8rM7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llE0OipyEcJAQ9SkUxGVBJlnKW0JIZRgbC5zkGF5x4A=;
 b=IItNbkXU4MZNrydZkA3Ii8TQid3EaYrgib5Y6uQx3JbHmmtacvi3GgpCSzL6lAwbaETIukjpGsyksU93GbZoTFhsxAw+cHX7vC9o4OGwk8o1fFX3gEY+fk9DwKDhd0mFQBKMxPly3d9kUkzEkLH3WvnEsgHKztPjCYIWLoZyIyW5jfADa6Ayb/vwWuZ2Ivwm1073cBisI4jU1GjVuHJBculgFM39Q7AZN1siYItiF0g6RnBbs1V6s4Q+nn/ey5vktJld4n06X4ptC+cKkpLKDTvpZBLk9QfZftUo+WgPl2+bAcMTWh0Z1gQ100Z9yEXQD//7wRiWcxKJL6NDvUa5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llE0OipyEcJAQ9SkUxGVBJlnKW0JIZRgbC5zkGF5x4A=;
 b=yUdOhvbl7CEIWs3oxH+bknxbY7NqemKmqv3/CEsJsafJzh8KlkXLhUaA+1y3FF8Xh9ywS7BbVwNMLnNBL6/UgEhGVLn7RqrZcH7jod8BfrTDk7BGHNygY+UU7p77T6iiKYwE6wB7NcXx+p2dTYuz2fzIaQ+RMJtUuCchjSS1j/U=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY5PR04MB6627.namprd04.prod.outlook.com (2603:10b6:a03:22d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 16:25:25 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 16:25:24 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] btrfs-progs: mkfs: fix minimum size calculation
 for zoned mode
Thread-Topic: [PATCH v2 4/8] btrfs-progs: mkfs: fix minimum size calculation
 for zoned mode
Thread-Index: AQHapiwDBnfSyrdxzkqDWWPKb0Dg3rGXVxYAgAElcoA=
Date: Wed, 15 May 2024 16:25:24 +0000
Message-ID: <ji7guuchxiuit4u7b654f6jdrjwfvdazpozrlx2opxvmvbss3i@l6vmxacywa7a>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-5-naohiro.aota@wdc.com>
 <bc637e8e-de79-46d8-b13d-e80d49131b8f@gmx.com>
In-Reply-To: <bc637e8e-de79-46d8-b13d-e80d49131b8f@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY5PR04MB6627:EE_
x-ms-office365-filtering-correlation-id: c7da0a73-5d3f-4891-000b-08dc74fb9ff3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHh2VDRPRERkK0kxRWdVUDh4VzNFeGZCR1RBVjY1emF6ZTdKYzkxMmk0ZFJ1?=
 =?utf-8?B?UU4xVEg5aUNXNjBmcHltandXdU05OXZoQkM5Sm8zaHRmUDlyQVlrUlQ4VTMx?=
 =?utf-8?B?dDhTalAvS1Nta2FNL2Q2dEJ2SmY5cUlsaFFtZmZtRVdNbmtXekYvdjlWRkVP?=
 =?utf-8?B?Q2FBYm44NHBuTHc4QkxPemhaR0VRVjdjVTl0OHUyamxIZWFIcUhoTWsxREVD?=
 =?utf-8?B?VEJTU2lHT0Zia0pZZ3ArOG0zclJ2Y2dWaXMwaGdrR1NiR1BCdTdQdGFSNytF?=
 =?utf-8?B?SUcxVkk5ckNUYk1IN2ZZbzZLYzFxaVZ1bmpuaWY2YU9LdVlNZW1hdWdBWGx5?=
 =?utf-8?B?TnRhM25VcXNLbisrdndaZzVtYnhmb3RWQ3BZT0NTaTgvR3VTOVBQVzZqdCs5?=
 =?utf-8?B?Qjlod0N1UGgxSnBhcUhDNkhJSGU1cTZSZjBCL2VITmF6dzZuZk5HNWk5Vytj?=
 =?utf-8?B?VFBmU2dmYitjVlJvTGltWjN6QkVTZGpIRTBqaW13RXU0YVpqaWJ5Z0p2QWF4?=
 =?utf-8?B?MGRnbVYvbjF5bFFNWjhZYjl5dGlvUmU4SGNvWkN6KzE2RDlxTlRFQnh1Skxr?=
 =?utf-8?B?YXdQUlNHY1dpK1U3US8wYTB6MzlMSlgvZjVyZHVWdG5kN2tsRWpHVmxDQ2Vl?=
 =?utf-8?B?em5VNG5KMENRc0Q1N255SHd1NFBEOHd0cFMyZVUxc0tYRjFHOWlBbDJPSGJ5?=
 =?utf-8?B?VVhqdWtia09xZWM4ejN2VktsVUZCcjBXaVJZaVNKZFc2cGd3YW42QWdINlU0?=
 =?utf-8?B?MFZPWVM0SVkvZDBaWUJiUVpnK3hZaXd2MkllZzJCVmZWcjFyMGtuODZYeUVi?=
 =?utf-8?B?dk9LcHRnZXFpMEwxWC9zRzV1Ym5vdHdEc0owTTJOZ1psbHhiZDhZVDI3SlNN?=
 =?utf-8?B?L3NxVTFFTVNLQ1IyZWRBcjdCRnpuR2FvSm5lclc0N0d2R25IdzFBK1k4NFE4?=
 =?utf-8?B?THZ3VWo4ZFI0VzdtMHFsTkFVMVNkR2VKUEdCc0UrWGtoWTBZdHhYUUIyS0JL?=
 =?utf-8?B?ZFZ6VkdMMWtRZ3ZYQk4ydFVEK2I3TTljMVhNeC9UQTJNd09vb0tjRkRRRi9q?=
 =?utf-8?B?SVBMVFNOb2p5RnBHYVJQOGtLRS9XMUVWL0FIM1RmNGVIdmRSd1VyNzNCNVk5?=
 =?utf-8?B?WU5wb2xONlBTNWd6OTlSbnAzK1RPMGZiOHlsTC8xazVLTlFrcmp2ampsSXJX?=
 =?utf-8?B?UGhCTEFaY0RGL2xPSVY4VUlRUjYwd3VZeTRrM1BWWklEaHN0TngxN2lDKzNK?=
 =?utf-8?B?UDIwTWFQcFFjejIyTTF2MHpEc3VZWm5ZVFdzNGxxbXE2OU4xWTV5VTBjL1RX?=
 =?utf-8?B?ekl2R2ZOUG0vQi8rNjYydENLcXNJb0w2OEFGanFhaVVEZFJMQ3pUeWczNkNU?=
 =?utf-8?B?R3Z0SHliM3B0R3hGZFBpL2NiOFl0M2pYQkRsbThOYkx3YXRvdWVWVnYvQVB4?=
 =?utf-8?B?eU41a2dPUkJxUzJicGVuRk5GOUhlNC9pSVNOMVU1dVFDOExzZ1RiVFlIMUFU?=
 =?utf-8?B?a01kc2U3VnQ5NWt6SWdXT1BtLzFKWUlOUzhobUtHSFJlbitEdjM5VTE4dTZS?=
 =?utf-8?B?ZUFsUlhDMldibkdXSVgzMmFIT1NlY3ZaZjF2ZkhjcVA0dGI1WkU5OTJJKzNq?=
 =?utf-8?B?ZUNUR3ZIOUt5cG9kdnd2dUZXU01WQVI4Y1NVTHovdEVjR0pyU0w4M2YxMXNZ?=
 =?utf-8?B?clNpZjhNRDZicVBZZUR4NEtrL0lyUW81NHdkbCtyODRRYXk1dENFTmJoU01l?=
 =?utf-8?B?eHBzS1Nxc2p4Q1B0NlpRYlFtamlXeVVNR1R6cnRGWVpQby9JVElzcEJLSVda?=
 =?utf-8?B?czRyaE1yQ2kyY2RDSWVhUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHN3eHRuNkVsUy9aVmhkc2NIeXlFa3JRTWdLa0lwS1p1VlcyVDNsWVdid2hW?=
 =?utf-8?B?dC9mOU9mSCs1SGJNZFZyd0JFRXcyOXRDd1lPUWhxYnFNQStyL1U3U0tYVU1i?=
 =?utf-8?B?NmQ5UHUxSUhMeGo5T1dQNUMrV2xCQjZodlZXNnpwYTJNbTVBTXVTQUM3em5C?=
 =?utf-8?B?azFTVksrTGFIdU5Bak5lMEwyMDhMWGNxMjA4SDBWQXlFZHZiY2pZak9JMFgy?=
 =?utf-8?B?KzA5OEtITFVvOFhyOEQ4WkdkZEs2YytURmtlQUNSRXoyNkVLMmZncXBKRVMz?=
 =?utf-8?B?djQ5blpLN3RtOTJoTW5WakluVGhIUUVNZm0yMllNNlErU2R5OVhyWmdWRjFM?=
 =?utf-8?B?M3NvNzBDRW9QU1V6bGNTZ2hUbTZMOVBXQmtiR1R4QVR6YUZpWHdVN2g4Njc5?=
 =?utf-8?B?Z1ZORWpFcjhzblVVK1Z4TGNwQmF2ZXNFZ1d2YVVVUjRlcms1RVBQRisyMERh?=
 =?utf-8?B?NHM4Qmk2bXVQREJzcDB3c2tOL1ovaHY3NFpIeFNkdUFsdHRFTmNxNmpHWVlU?=
 =?utf-8?B?REpFcVRtKzN0R0xWNEhPQmlhVU5sREFQWEdIM2pZOE5xUG42Ymd2TmJ6aDZu?=
 =?utf-8?B?bmZFMzc1UjNBZU9iVlpSOUlnZWg0VVNrdFJQM2wzYjVlRmRrR05YZGtEdUJl?=
 =?utf-8?B?cUc3Z2pJSHhDVlQ0MWVyNjhqOTgxOXZleUpZZ2Y2WVpqajBOc3dXWjJhNDFL?=
 =?utf-8?B?bGxjWFV0VnpXL2lqcjI4bXdHeE02TGhEZXhFNEFBZzE1WHhWaHR0Q1pmZGV6?=
 =?utf-8?B?dUF5ZThSV2pRKzFxclVQd3BkajBsYzNZaTJNRkRxYXh5dWJCVEkvWVppV2RX?=
 =?utf-8?B?ZmZNWkRteWloMllkVFF4dG1oMDlZandncXdRTUFlb055UEJpWXMrR1J4cytF?=
 =?utf-8?B?N1EwNG5GdUk0UFhDNGFzUnNlZkcrSTdISHBEN2hFdTU0bzRVb1lCd1p1V0Y2?=
 =?utf-8?B?bmhrNkw5MXBpcnpPSkFqVFBSeGg3S2hYM3Rjc0ZhQnY4Ukgxb1JtME5yeTBj?=
 =?utf-8?B?Nkh5S2NEaTZBMmdnVjRrd0NDSEd2TTJxY2pZNmpvTTd0OVdIdnhBbTVlWVdR?=
 =?utf-8?B?RTRnK1RvVllDcXVtanJnc0drMFBBK2dXZ0N4NnBZdjduRXlXQ3lXWTh4L1Mx?=
 =?utf-8?B?R1BqTHJkK3hHSXFBam4vY1RWNlJYaEJSRDNjMk5TSCtPUFhsUkx4MWVvYUh1?=
 =?utf-8?B?VlFXdHZIVkFSaDBuQTNmTlR5TW1HZFJwLzE5aGM2dTVDSmZkaEFoYThYWFB1?=
 =?utf-8?B?YjFQcGp3eWdhVUkyQ2ttcjJiWDNtM2Q4OFgwaTlDZ2VMRlg4eWRUbXV0RWs3?=
 =?utf-8?B?S0xtSDJSSkVlN1ZuSUdUdzVhUllobmtxTVZYVW5ickZENEk5Zm5oY2E4VE9Z?=
 =?utf-8?B?VENpSnVMcksyTXprVFlXUlRrNnlOdUR6WG1kMExYK0FaT0dyMVZlYTB5V1l1?=
 =?utf-8?B?Umd0amtDcGZhTUI4NThBWVJyOVJXMURTSHlYdnQ1ZTVRQXNicHBtSXNubC96?=
 =?utf-8?B?Nkw2M2t3NHhCSEhjTlhhUEs4MzlpaFVjWEJaMGdDL3EraXFYcE9GUENyWkJQ?=
 =?utf-8?B?ay9sWjB3VjUxMEoxU0lSQ285WFJUUVphT3E3eExTMFZLWlI5NXhObC90WWhJ?=
 =?utf-8?B?OHpmRHFEdVNhaFVvVkkrY25BUEtYeFlOdzB4Zk9yVElKVkU5OFNYbzR5OTVw?=
 =?utf-8?B?TVBWL3Q0cm4zRWNYNk5sM2pvNjJ4Y1hDRUVwVWVxcEo4aHhFRVhLeDgrOUNE?=
 =?utf-8?B?WlV3dUhzMGhHOUV6LytBZXJFQlhkb1ZEYjVSdkd4TS8zVnd5TWdWVTZWQkhs?=
 =?utf-8?B?N3BhTGpVak5EMmlEaWFFQUtFSnlPYlAxaGRoQkFFNFcxZm4wUjJTQXlneG5M?=
 =?utf-8?B?bDQvbm9ZbnVOdHJEa0M1cHZYQzkyL0txTFdCM085K3M0NytzSUV2UWUrTWFS?=
 =?utf-8?B?dVE2WlBWWEthMjlTbm9kN21mQmVKN0I3bTZZUGxGSHhEUkQ3R3pBUVVrN0ZK?=
 =?utf-8?B?RmIzYi9KOG9hemZ3TnpKS1lqTThkM0htQnNpMEYzUlZ0dUYwelJnRllkNTNR?=
 =?utf-8?B?ZlR0NmJ3ZXdScGphRStwS2xGSi9HWW1mc1d5Yi9NaGkxQmV1ampPb3JOaFFK?=
 =?utf-8?Q?I83ioTv4GhdRppoAPwQGpRlHE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03AFA9C10ADEDA44BE1CF927EF0F783D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qi5n9cZt3kCbIElAV27yum0ghZZyEZ7zM2aLzumNJdMZkobGE5pDH0PDEjmT9zxgDjAS90U/aDDWSkWkZZUZluyuG9CUjF4YK7t1W3JlyFtqVKBaUy9fnP108OOvAkviQbcw/wPjah6BXs2siaqUeAlORlLqr/bDS8YUKzn+NaB6xi49ar5RS8OBldE8BL2OdpR9x2FN3sblf2ye2tAZLSOC1d5iolctdffOo4iHwF+nGN/di5z8T8P5rXp+A9CZyn0kpLAFx2pimnyJ5AX36YLMZSJUTUFgIM3u3AB9VwL3kA8kY8EfQRcjfNxLaQhTcv8wUUAS3WpuyTLyO7qiKzVYIzPNoEUH4M7HlL9qoIkmFeT1BN0JQJaGkd4I0AJCKmm9l35/7Kx4ji7ZRcGqUwZKpwntv8dezivobPY7jDfLhxP2bZEnSRqbRl4t5Ur1DDAucAEEk8+KIyxAI2wvc+J4yBbPC+uMVjF1sRuxR/vnqIDF6lqN0NUwVg4XZPvKGX/eodvFc4dOJS9Ktpy+YtlNOFWg/cUKxX46i50MDdV/5gPCLaPDNbE/qrsrWpOqWeF9yozFZCYiADPSABQb6T+ZpWd4j2c6qn17Fv5/mMZQV2UzbiqrMGkVMWf/aauj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7da0a73-5d3f-4891-000b-08dc74fb9ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 16:25:24.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jt73g/E9Zcumb74cxVI2al+LseKCQTAS3Ulc3FGN/5Xs1s/Bw8c/AwRV6xu+VoWPPZjKRIzXZE72G07DpWCSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6627

T24gV2VkLCBNYXkgMTUsIDIwMjQgYXQgMDg6MjQ6NDZBTSArMDkzMCwgUXUgV2VucnVvIHdyb3Rl
Og0KPiANCj4gDQo+IOWcqCAyMDI0LzUvMTUgMDM6NTIsIE5hb2hpcm8gQW90YSDlhpnpgZM6DQo+
ID4gQ3VycmVudGx5LCB3ZSBjaGVjayBpZiBhIGRldmljZSBpcyBsYXJnZXIgdGhhbiA1IHpvbmVz
IHRvIGRldGVybWluZSB3ZSBjYW4NCj4gPiBjcmVhdGUgYnRyZnMgb24gdGhlIGRldmljZSBvciBu
b3QuIEFjdHVhbGx5LCB3ZSBuZWVkIG1vcmUgem9uZXMgdG8gY3JlYXRlDQo+ID4gRFVQIGJsb2Nr
IGdyb3Vwcywgc28gaXQgZmFpbHMgd2l0aCAiRVJST1I6IG5vdCBlbm91Z2ggZnJlZSBzcGFjZSB0
bw0KPiA+IGFsbG9jYXRlIGNodW5rIi4gSW1wbGVtZW50IHByb3BlciBzdXBwb3J0IGZvciBub24t
U0lOR0xFIHByb2ZpbGUuDQo+ID4gDQo+ID4gQWxzbywgY3VycmVudCBjb2RlIGRvZXMgbm90IGVu
c3VyZSB3ZSBjYW4gY3JlYXRlIHRyZWUtbG9nIEJHIGFuZCBkYXRhDQo+ID4gcmVsb2NhdGlvbiBC
Rywgd2hpY2ggYXJlIGVzc2VudGlhbCBmb3IgdGhlIHJlYWwgdXNhZ2UuIENvdW50IHRoZW0gYXMN
Cj4gPiByZXF1aXJlbWVudCB0b28uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFvaGlybyBB
b3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgIG1rZnMvY29tbW9uLmMg
fCA1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0N
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9ta2ZzL2NvbW1vbi5jIGIvbWtmcy9jb21tb24uYw0KPiA+
IGluZGV4IGFmNTQwODk2NTRhMC4uYTUxMDBiMjk2ZjY1IDEwMDY0NA0KPiA+IC0tLSBhL21rZnMv
Y29tbW9uLmMNCj4gPiArKysgYi9ta2ZzL2NvbW1vbi5jDQo+ID4gQEAgLTgxOCwxNCArODE4LDUx
IEBAIHU2NCBidHJmc19taW5fZGV2X3NpemUodTMyIG5vZGVzaXplLCBib29sIG1peGVkLCB1NjQg
em9uZV9zaXplLCB1NjQgbWV0YV9wcm9maWxlDQo+ID4gICAJdTY0IG1ldGFfc2l6ZTsNCj4gPiAg
IAl1NjQgZGF0YV9zaXplOw0KPiA+IA0KPiA+IC0JLyoNCj4gPiAtCSAqIDIgem9uZXMgZm9yIHRo
ZSBwcmltYXJ5IHN1cGVyYmxvY2sNCj4gPiAtCSAqIDEgem9uZSBmb3IgdGhlIHN5c3RlbSBibG9j
ayBncm91cA0KPiA+IC0JICogMSB6b25lIGZvciBhIG1ldGFkYXRhIGJsb2NrIGdyb3VwDQo+ID4g
LQkgKiAxIHpvbmUgZm9yIGEgZGF0YSBibG9jayBncm91cA0KPiA+IC0JICovDQo+ID4gLQlpZiAo
em9uZV9zaXplKQ0KPiA+IC0JCXJldHVybiA1ICogem9uZV9zaXplOw0KPiA+ICsJaWYgKHpvbmVf
c2l6ZSkgew0KPiA+ICsJCS8qIDIgem9uZXMgZm9yIHRoZSBwcmltYXJ5IHN1cGVyYmxvY2suICov
DQo+ID4gKwkJcmVzZXJ2ZWQgKz0gMiAqIHpvbmVfc2l6ZTsNCj4gPiArDQo+ID4gKwkJLyoNCj4g
PiArCQkgKiAxIHpvbmUgZWFjaCBmb3IgdGhlIGluaXRpYWwgc3lzdGVtLCBtZXRhZGF0YSwgYW5k
IGRhdGEgYmxvY2sNCj4gPiArCQkgKiBncm91cA0KPiA+ICsJCSAqLw0KPiA+ICsJCXJlc2VydmVk
ICs9IDMgKiB6b25lX3NpemU7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogbm9uLVNJTkdM
RSBwcm9maWxlIG5lZWRzOg0KPiA+ICsJCSAqIDEgem9uZSBmb3Igc3lzdGVtIGJsb2NrIGdyb3Vw
DQo+ID4gKwkJICogMSB6b25lIGZvciBub3JtYWwgbWV0YWRhdGEgYmxvY2sgZ3JvdXANCj4gPiAr
CQkgKiAxIHpvbmUgZm9yIHRyZWUtbG9nIGJsb2NrIGdyb3VwDQo+ID4gKwkJICoNCj4gPiArCQkg
KiBTSU5HTEUgcHJvZmlsZSBvbmx5IG5lZWQgdG8gYWRkIHRyZWUtbG9nIGJsb2NrIGdyb3VwDQo+
IA0KPiBUaGlzIGNvbW1lbnRzIGxvb2tzIGEgbGl0dGxlIGNvbmZ1c2luZyB0byBtZS4NCj4gDQo+
IEFzIChmb3Igbm93KSB0aGUgbm9uLVNJTkdMRSBwcm9maWxlcyBmb3IgbWV0YWRhdGEgaXMgb25s
eSBEVVAsIHRodXMgdGhleQ0KPiBuZWVkcyBhdCBsZWFzdCAyIHpvbmVzIGZvciBlYWNoIGJnLg0K
DQpSQUlEIGlzIGFsc28gc3VwcG9ydGVkIGluIGFuIGV4cGVyaW1ldGFubCBidWlsZCA7LSkNCg0K
PiBJdCdzIG9ubHkgZXhwbGFpbmVkIGxhdGVyIGluIHRoZSAibWV0YV9zaXplICo9IDI7IiBsaW5l
Lg0KPiANCj4gV291bGQgdGhlIGZvbGxvd2luZyBvbmVzIGJlIGEgbGl0dGxlIGJldHRlcj8NCj4g
DQo+IC8qDQo+ICAqIG5vbi1TSU5HTEUgcHJvZmlsZSBuZWVkczoNCj4gICogMSBleHRyYSBzeXN0
ZW0gYmxvY2sgZ3JvdXANCj4gICogMSBleHRyYSBub3JtYWwgbWV0YWRhdGEgYmxvY2sgZ3JvdXAN
Cj4gICogMSBleHRyYSB0cmVlLWxvZyBibG9jayBncm91cA0KPiAgKg0KPiAgKiBTSU5HTEUgcHJv
ZmlsZXMgbmVlZHM6DQo+ICAqIDEgZXh0cmEgdHJlZS1sb2cgYmxvY2sgZ3JvdXANCj4gICovDQo+
ICBpZiAobWV0YV9wcm9maWxlcyAmIEJUUkZTX0JMT0NLX0dST1VQX0RVUCkNCj4gICAgICBmYWN0
b3IgPSAyOw0KPiAgaWYgKG1ldGFfcHJvZmlsZXMgJiBCVFJGU19CTE9DS19HUk9VUF9QUk9GSUxF
X01BU0spDQo+ICAgICAgbWV0YV9zaXplID0gMyAqIHpvbmVfc2l6ZSAqIGZhY3RvcjsNCj4gIGVs
c2UNCj4gICAgICBtZXRhX3NpemUgPSAxICogem9uZV9zaXplICogZmFjdG9yOw0KPiANCj4gT3Ro
ZXJ3aXNlIGxvb2tzIHJlYXNvbmFibGUgdG8gbWUuDQoNCkkgZm9sbG93ZWQgdGhlIHJlZ3VsYXIg
Y2FzZSBjb2RlLCBidXQgdGhpcyBsb29rcyBjbGVhbmVyIHRvIG1lLiBJJ2xsIGZvbGxvdw0KeW91
ciBzdWdnZXN0aW9uIGFuZCB0d2VhayB0aGUgY29tbWVudCBhcyB3ZWxsLg0KDQo+IFRoYW5rcywN
Cj4gUXUNCj4gPiArCQkgKi8NCj4gPiArCQlpZiAobWV0YV9wcm9maWxlICYgQlRSRlNfQkxPQ0tf
R1JPVVBfUFJPRklMRV9NQVNLKQ0KPiA+ICsJCQltZXRhX3NpemUgPSAzICogem9uZV9zaXplOw0K
PiA+ICsJCWVsc2UNCj4gPiArCQkJbWV0YV9zaXplID0gem9uZV9zaXplOw0KPiA+ICsJCS8qIERV
UCBwcm9maWxlIG5lZWRzIHR3byB6b25lcyBmb3IgZWFjaCBibG9jayBncm91cC4gKi8NCj4gPiAr
CQlpZiAobWV0YV9wcm9maWxlICYgQlRSRlNfQkxPQ0tfR1JPVVBfRFVQKQ0KPiA+ICsJCQltZXRh
X3NpemUgKj0gMjsNCj4gPiArCQlyZXNlcnZlZCArPSBtZXRhX3NpemU7DQo+ID4gKw0KPiA+ICsJ
CS8qDQo+ID4gKwkJICogbm9uLVNJTkdMRSBwcm9maWxlIG5lZWRzOg0KPiA+ICsJCSAqIDEgem9u
ZSBmb3IgZGF0YSBibG9jayBncm91cA0KPiA+ICsJCSAqIDEgem9uZSBmb3IgZGF0YSByZWxvY2F0
aW9uIGJsb2NrIGdyb3VwDQo+ID4gKwkJICoNCj4gPiArCQkgKiBTSU5HTEUgcHJvZmlsZSBvbmx5
IG5lZWQgdG8gYWRkIGRhdGEgcmVsb2NhdGlvbmJsb2NrIGdyb3VwDQo+ID4gKwkJICovDQo+ID4g
KwkJaWYgKGRhdGFfcHJvZmlsZSAmIEJUUkZTX0JMT0NLX0dST1VQX1BST0ZJTEVfTUFTSykNCj4g
PiArCQkJZGF0YV9zaXplID0gMiAqIHpvbmVfc2l6ZTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCWRh
dGFfc2l6ZSA9IHpvbmVfc2l6ZTsNCj4gPiArCQkvKiBEVVAgcHJvZmlsZSBuZWVkcyB0d28gem9u
ZXMgZm9yIGVhY2ggYmxvY2sgZ3JvdXAuICovDQo+ID4gKwkJaWYgKGRhdGFfcHJvZmlsZSAmIEJU
UkZTX0JMT0NLX0dST1VQX0RVUCkNCj4gPiArCQkJZGF0YV9zaXplICo9IDI7DQo+ID4gKwkJcmVz
ZXJ2ZWQgKz0gZGF0YV9zaXplOw0KPiA+ICsNCj4gPiArCQlyZXR1cm4gcmVzZXJ2ZWQ7DQo+ID4g
Kwl9DQo+ID4gDQo+ID4gICAJaWYgKG1peGVkKQ0KPiA+ICAgCQlyZXR1cm4gMiAqIChCVFJGU19N
S0ZTX1NZU1RFTV9HUk9VUF9TSVpFICs=

