Return-Path: <linux-btrfs+bounces-4822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F628BF6C0
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 09:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EFA284D7E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF423772;
	Wed,  8 May 2024 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cBDXyPVA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ICTeZYL3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF1A168DC;
	Wed,  8 May 2024 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152094; cv=fail; b=hBf29VPNmc+7G2RM5ziA9IItDCRAQ4crOUf+pLjNDAGhfv7g/WOtuDT3UB3DbEfKQ/fj+bVN+ZjGJqY1moqMv5o+3RryWhes5ZZll5/Ye8hHTzwSsy0zG1BbkUUtxx2+p6SjiwTbt24Bvk+QTCxiuiSvLBsinI58nfhA4vb0aps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152094; c=relaxed/simple;
	bh=kmbbMQjMBrhOaOPLljRN1p/1zLVS4slUEpHzPdatbSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/JvyLr+jMPKZk+rkwv4JfOVlPrcY8HIMZ3HgBW4xXl8XXxTvuiuGuZNO0cwGN4Ljt/RwLLFhXhAdqDAJ5L8U4ivtj4BVreGH1eWS2YFzF4Rpea+91Vh7zwN7RbMzEIM9qSwBiD10TmbxYSg2D53kHC7zAGod+SSu7C2G/+wgdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cBDXyPVA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ICTeZYL3; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715152092; x=1746688092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kmbbMQjMBrhOaOPLljRN1p/1zLVS4slUEpHzPdatbSg=;
  b=cBDXyPVAcEwTM4KGUor+HcVRBiR+dFvqVoyEpb2pWGc3q981rYT58Lze
   fNZqEfZUDBK5Zt/P5P6PvhSq3VXwQV9z9+6zhZ06MoLx/geOuyVmpJ4Yv
   9KShsxs+Z5ybLeiPCXsL4KOc091S+ZrO0G/BVo9NJS04gxIbmIPMmaUFh
   +j6TDOdl9u6M7GvJPEhOSbqZUSeolAp994EExf6RWkQqH8u1YLIuglZEr
   wd31TVNHsd0v9kBK9mHdO5wcQ52fH60Vb2HMHTGpDRezAlTTreQ5bhqcY
   6MgCrfY9O3tqXwUn0CdXXgMq75JDQP4P6ErXFxTqFQeznYiccO0dZk+Uw
   A==;
X-CSE-ConnectionGUID: buHL/IqbT9Cp7R5UW+QQew==
X-CSE-MsgGUID: rdOL9wq9RuWm/Kc/KKWzvQ==
X-IronPort-AV: E=Sophos;i="6.08,144,1712592000"; 
   d="scan'208";a="15824747"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2024 15:08:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFoxJaP/DFXGZ9eT+JGRvT0MkGoYVwGD+o8TV4m/+Abe6bCHhbOLrEHQQPn7F399BRAOo5+es+HoADLQA49Le0FVfhcYVu3ItHqJhu6IloI9UwLmH4z427jiENNfhysLgncPKWaU+f1W0ijmcQc8W6TrZJ1zgU3PW8RSgqd6YpYxS2tFSjdjenQMxFfk/YXR61+k4XqHV9dUjUZO3H5dFWHwNpgD4ciqAV4LCGh/yJaxloB2fYzmQCin3gcYUyeajxcvqKGq3GJSy9iE958EUqLxI1m3rNt38JXnCYgiug9+6Tn09e6uUgh4G2v5wyeUZPT9kNchrGv1qVKiSEM8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmbbMQjMBrhOaOPLljRN1p/1zLVS4slUEpHzPdatbSg=;
 b=FvsytoO/af2mvxgCrvgHEo0mU43Dc/rG4TA3qhOUk8kEtxdNCpO+2DZLHfl0Y1p9otQplNu278mUGs416K8RN2l0uR31y5lT6mKBGJJeH/U4Sml+sMN2liTkdS2u6Gp/R2AT1M0l3DgsJCecTdiB88sH7HUTaSoeXIW+wvHdnfoedzaJmdVVOkkmZ0qC8wHB/YEqMOmbbhLI+CNCbRhdQN1XHjs/F0/v7PnJb0C/TXg9n4vB8alQWdeMKqSQUN7Ze/a/ZcYtI40f8T5GxPCuHI50gs5oe4bPSfqOABbqH7mbqBWAeDEWjsrZk89gn2xAUXYE0f3uNTNiJp/DWNlkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmbbMQjMBrhOaOPLljRN1p/1zLVS4slUEpHzPdatbSg=;
 b=ICTeZYL3YQhVGIKtliiRExRgvoU65ZLVkSNRZdD9tzv9h4mVt3OLlnFcC8BQRVYQ5359Y+FKSLTwQEv+p1tuFM4CtRgywz0hAneTGaGQXCG3/RFNMvslGD+4pL60bpzSFU4E5zM08gCEW/cI4TBdCXEwCeDay0m8QBF66SMmNTg=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by SJ0PR04MB7248.namprd04.prod.outlook.com (2603:10b6:a03:290::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 07:08:01 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%4]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 07:08:01 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Zorro Lang <zlang@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>, =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?=
	<Matias.Bjorling@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>, Jaegeuk Kim
	<jaegeuk@kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"daeho43@gmail.com" <daeho43@gmail.com>
Subject: Re: [PATCH] generic: add gc stress test
Thread-Topic: [PATCH] generic: add gc stress test
Thread-Index:
 AQHajydU0MgWW4psBkewF7CTRJyJLrFqnMWAgACj+4CAASqVgIAACriAgAAMnQCAAArsgIAggQiA
Date: Wed, 8 May 2024 07:08:01 +0000
Message-ID: <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
 <20240416185437.GC11935@frogsfrogsfrogs>
 <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>
 <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com>
In-Reply-To: <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|SJ0PR04MB7248:EE_
x-ms-office365-filtering-correlation-id: 7d8fb851-0db0-481a-9a6b-08dc6f2d995e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXlUTXBpQkdjc0hDUlh2RW15Tk5EMUdGTVAxazg1OHFLQ29PcTlFVjFxdEV5?=
 =?utf-8?B?ciswaURZZlVXT0orV2NZUzJiazBBcXlWanZtbElWcFczSm5IRE5SNUNSVzJu?=
 =?utf-8?B?enNvTXMvN1dzVXpUVUhuRUYwUHN3WXBhUXR2THJzaDZ3cFlWL3Yyb3hENVJE?=
 =?utf-8?B?VzdNVlFmeUtseXRpN1orSUg4QkZ5OUNaRHdab2JadUFsQ3h6MnowaWFCTEp3?=
 =?utf-8?B?TE1tdjM0dUg3Y0VaR3Nrbkd2dVJlVzRxOS90eFNSTUk3amIzVHp0OEF0SmNG?=
 =?utf-8?B?M214aDM4TlNkQXU4dkRJYTFGNEQvRzRXSGNSUVprOTNsWUlpOS8wZHhPU21G?=
 =?utf-8?B?alBCc3NzKzExUDBjOTcycGNiNU1CK1lmR3hqWDhTM2lRb2RUcmFkbW5NYkM1?=
 =?utf-8?B?ZVRxbE9WNHBKNVo0Vjk1NmdDVDlJbVN6aXg1SS9xMUdKbGlGaEtuT0xGTDlD?=
 =?utf-8?B?dEVhSXlWNi90RkJWTkY1aUROZHpldlFadVFNMFd1S2VBdGxFeXpUR0h6WHo4?=
 =?utf-8?B?dmlpbXl5dFZzZStvSnA2VlpxczhoQlkwa3RhWjFSZGJJWm1GRk54NXdaSzU1?=
 =?utf-8?B?WkI2K2VaL0RjbkN1dWFTOTBsQVlQUEVvZkZ1Y0JseHpuQjdjazBwQ016dFRE?=
 =?utf-8?B?bFJDUU9vbm9TMTFHUGg0MVE2bGlIdUlMamo2a3RVQndKNE85dG1hbUhQcGFQ?=
 =?utf-8?B?ekFkcDZHQi94cnJ1TDhsTGE2QjZiNFhTRDR2S1Z1UnFOdlc5ZHFDVnZJWFYv?=
 =?utf-8?B?V2NxV2NHSEdIbE4xRURNd1pYSElkeEY2K3RwcUQvL3hFeVdZbmFxS3V2WUdr?=
 =?utf-8?B?RHI0NFhMbHNpenZJNUk4cnA3UWJheWROM285cnh1eDhOS3NsQ082dTN1ZVlU?=
 =?utf-8?B?Z0U1N29TbUwxU0Q0d0pjVnIxS094OVN5Y0EwMWZtSEJHeEZIalNYSWt4NnJN?=
 =?utf-8?B?SFE2TXFyQkxpSWpmaHBYdXg2QVFSenhPYzJpR3lBbFlRRXNaTG9JaHJyd2x5?=
 =?utf-8?B?Q1BIUkthZzV4T3BXcnZMSVBvdDBtY0JMMFFFK3ZoeExXNElaVUtQbFZQVEdx?=
 =?utf-8?B?MlFhSVA3NFJtd0tUWmdpSENENnNEQzQzRmp4bGpvWCthVzJJdElESDE3emRI?=
 =?utf-8?B?WFZlWEQ0S1RJdHNHTjV0aU1TRTFjQmlOQnJDbjJhRTNIeE1uYlkrTzhuZ2xE?=
 =?utf-8?B?NUZGU1JBclpaNXpIVVFlditKOVJXNTBrNXoyRFBvenI2djJWNFcvT0FISFg4?=
 =?utf-8?B?Q01Cay9jbDJDL1FuQktXRk5ZQkI3eFBFeTlRNjM5SWZ1cnhFeUl5QUsyN2N5?=
 =?utf-8?B?aWkrUWxoN1pQVVAyVWxIOEJ5cVJ6VGkwUmpHUmJWVmtOTjJmNXBzSHpoYmpK?=
 =?utf-8?B?N0NVY2lMV1VIVkhvZmFZV3M4S3J2em9jTFdiL3h0ak5CLzhjL0RoSVcrMFEy?=
 =?utf-8?B?QU1XV0t3TkVCbTNqbEovMDg3aGRBNnRPaXpaNWF6RXhEdmQwMWVBSGI0cWt5?=
 =?utf-8?B?RmoxRmJ5SXBGOSs5ZmtWZm1XSlVwcDd1VXo4S204YXRyS01PSHJVajVEd21u?=
 =?utf-8?B?dmtqKzF3ZTlhbExIeFFzNm8xanBWS0pWRWdmMUpCOHN1dVhnb0NKaXFLeElp?=
 =?utf-8?B?a282S01US24ySFVYQVcrMUJhUGROb3RCK1RZS093am9ocnc5ZzI0NU1XRTRa?=
 =?utf-8?B?Rk9KYWpBR3EzZ3NtSlpRMGl3V3pJVUgxV2tXQ0pOM3hYbUpDMmpRSnQyVk1J?=
 =?utf-8?B?SGp3UjFWSFU3VGREeGR2RVZSUE5BSSs3cnlndGI0UktmUnNvVDJkMHpLSUhV?=
 =?utf-8?B?YmRCUkg3ZUFISThKMlFSdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGp6eUtaUlJjM0RyN0RhaS9oZWJwR0JkTDYvVEtId3hqL01QUFlFOUR4N0I1?=
 =?utf-8?B?ZklSeUlSS01oQ2dpcFJ5ZExObnozYVhwaTNKN0wwODFNRWRRQUZzcTcxZ0ZU?=
 =?utf-8?B?WjVydmE5SFg0dXgvd0owbnJVSlVuVlEvUWVPSDd3L2pIUUEzWElJWUpkNS9I?=
 =?utf-8?B?Wml1aUs4bnl4cVhvNGpLMzdiYVRIUXR6dG9ycys5WGlIYitqTWMzOEZIUWtr?=
 =?utf-8?B?V1VQK1JHejlhTHozLzQvUUpKWmxBYnhybTY1SHZzRjJCWjFGRWFzRUM4RGpP?=
 =?utf-8?B?d29XWEozMTYyQ0prdExUc0QvNjZJZHZ3bkkwU2VsU0EvRS9JbkZWRWJBMlJl?=
 =?utf-8?B?NnExSkZXVzkvWEpDaXBoRXcyVlBjaXNxRm1teS9STzRmR1VRWjRUdGxTL2xH?=
 =?utf-8?B?d0xSMk5rRlFWVG9GTkxJSlg2VTRRWWNlbUt6OE5CL2tLV0Z0RjJ4ZzA3QWNQ?=
 =?utf-8?B?dDVUTlhIazdWczJVRitQVHd4MzUzNDgwL3VyRERtYVpDaHlJT24yb3prc3hW?=
 =?utf-8?B?aVd1VEFXdFhGb1N3aUFac0ZrZUVHSUt6am56Ym1XOWRKMXpsTW1lSTRXRzJo?=
 =?utf-8?B?bEJVUW9YQkR1aG51WWM3NklRTkw5U1Vld24rSWVpMkRxc3JiMFhWY0IwSVBl?=
 =?utf-8?B?ZGFKREZBblBUQ2JQUFZ6bndhRmtBQXRSYmpIMnh0OE9ZY0hxTzFGYkhYQXBt?=
 =?utf-8?B?UjM0M2FUMlhSSHc4KzIxWm5XcE1JQjJOa2VtMWpBcmY5THJ5SXp5dStUc3da?=
 =?utf-8?B?ZmVaRlA5d000czNWck4veXZjd0w0L0RpQldnQ2pQSUxrSEZhcTZRNUxiNFhn?=
 =?utf-8?B?Tjl3bkxyUkovenA1RkQvb1JOSTRWcG53ME8yNkI3RkNvYnkwTXR2Y1dBS3R1?=
 =?utf-8?B?YkV4NTZtcU8wWUYwNjlmWFViRFpLMFNINldSZDNiZWVBd3p4aElzdTRpbmRk?=
 =?utf-8?B?c0x3QlJaa3hIcWp1aUo0QmlhMGsyciszVzJSdzJNdHVGaWIzbGN3WE11akts?=
 =?utf-8?B?OUliS3IzeCtvdDBweUNNM250aFY0YTJEYlZKejlMRDZtUnNEV0MyVlVhMHhM?=
 =?utf-8?B?bnFPZGFSVExQY0F2Wmx0cG9IUzZXeU0wWjFKZ1c1cjBZaGZ4Wmo2WVB5UkdC?=
 =?utf-8?B?YzNBM1lrczg2eitwMjhOQW5sZ0JWNFhsc2VockZwYlU4cDIvc28rdUdPZ2ZB?=
 =?utf-8?B?RGc2NjN4VGY0SjhOZzBkZFZGTEMxYTk1dW43dG9iVi9TcUJBYVhsa1U5NFhY?=
 =?utf-8?B?YVFVRUUweVdua0k3bGozUTUyeHJmYlUrS3UrRnBZcm5welQzcTBNclJCZ1Jj?=
 =?utf-8?B?NStsZmN5VzI2b2JRMFpqYk40dG83UWh2Slo4eTVYNUU2Q3RvRU9mUjNCVEZR?=
 =?utf-8?B?WVhkY2FudUlOM0p0cmxvenpqUExvY08rNjZubmNpU3FRMWthcHNyRjdXNm5I?=
 =?utf-8?B?MHQ5ZVY1VEVIRFpvMHBJTWlqK1pzY3Bod3gzWW9UbWtxdnM4azNKbjlNdEFZ?=
 =?utf-8?B?NFRmVUlYWWMxZ2t2VVZ1TjFIZEhaU251eEEzR2tvOHdScW5aWWtESG9rckZo?=
 =?utf-8?B?cHlGaTZhamh6cnlIVHdrN0NxR1VtdnNiUm1xVHNBN25wZDhtbUhnZXV0cldh?=
 =?utf-8?B?cUZKVFF4d2paU2FtVFNHalp0ejNVMjhsN2ZHazJXNUJlOE95QmhvSU9WcUg3?=
 =?utf-8?B?NDlUSWhFT1o4Tmhjbk1rM2gySklWbHJxVW5pNHFzbWM3WFgrT1VlVkh6SWpu?=
 =?utf-8?B?TFl2dVM3RDVyVmpOSlRLdUZ2YVFaTmV0MU9RckNFWERRcGJlaktpaWhLaTFa?=
 =?utf-8?B?eDRIeENYckVYeXQ3b3A1a3o5bDl0bVY1SUNtM1dTckpIcGkxakhsU3VRNVls?=
 =?utf-8?B?OExIV3VpaGpVeDI0bGNUME8wOGVHZUZmbFFrMXNWN1crNU9tNlc3NnhhZnFm?=
 =?utf-8?B?MHoyVmFXNlB0RGpJR2R1ZEZoRTExSW9OQVUydng4c0VWV3IxQm9Oc0MwbTZm?=
 =?utf-8?B?UTRYM2xwR3Z5U3lQME9VVzF0TDdIOEp3ekZlb2lucTduRmw1aDlJb21tWlhO?=
 =?utf-8?B?aDI0bGF5ZWR2MkFPcCszYk5KTlhwcTlaSmNiSVRSbjhmRnZ1WWt6UnE0VkNj?=
 =?utf-8?B?WG9xMEwwWitRSEY0blZLSWYvaSsxcitKbW56WXdoVlhsMVJ2dEFLRzZjM1Fh?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9479DD8F96EF645B32AA4CC079DB535@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QeUsyM/rw/FzXgWnpHLB8+H8pKpdAMzIZh0RIbYGd6emU9FCn+hy8mprFn0iuSdfsUmigIQ9wQDHapyZRGHIDJsysc1nk+iJ9Dsx7AmpqEf12iyAKJYBGdtnuhoRTOaoR2DDyELoPzWWiEZzubsGEISUrLfulHkyZThKIuqRAlSjsztCbx5K4aQ0WWkKk/X9mDx0npAY5E+HxbObNNTrNQodsBYZIpJkYfXiWi59KYj2SuXdLB76P/CDn27kw6XjmZWRzNVx36ZkuOvlC29tDOoi/ahS25VkY6AHw95fqLbfE9ZgG6HT48Qx3y8w3P4PClqLwjygVZt187aEEdGB9yOT0tu+LPsyvqgD2gKFlqN/poi9sOkSNtmaxMaACTBiyOHFOKFd4pdJmGZr/qC1t8E9bzlXC8H+ZjUCmwCnLANKZxtBXZzmX9AcZlXyIKXLhkgW+23NYXaRMZWO0R+xvglfxEjMk81G2/nT6FRS+BDfDtSbKF7Tp5mdlDxkR9czbF2PU0Y2dE0OW7Er3cIu9J9xhxcTNnRYiUeco3IeA0uZTlezuaMgSj+bQ5P/mR4li4Z0qI+QP8hHFMzAMAWGIBnVaj5SIwAlDa+cbazbybHsHNY3YNPth5y3bbMmYkDs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8fb851-0db0-481a-9a6b-08dc6f2d995e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 07:08:01.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxjvZJtqYleILnqiXmBiVwR7KVDMZi8ZiLzzULtuY00i+A9Yz1dE72Xj2lfaRE4EYLbPAg2aWtK7ucGtRe1DUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7248

T24gMjAyNC0wNC0xNyAxNjo1MCwgSGFucyBIb2xtYmVyZyB3cm90ZToNCj4gT24gMjAyNC0wNC0x
NyAxNjowNywgWm9ycm8gTGFuZyB3cm90ZToNCj4+IE9uIFdlZCwgQXByIDE3LCAyMDI0IGF0IDAx
OjIxOjM5UE0gKzAwMDAsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+Pj4gT24gMjAyNC0wNC0xNyAx
NDo0MywgWm9ycm8gTGFuZyB3cm90ZToNCj4+Pj4gT24gVHVlLCBBcHIgMTYsIDIwMjQgYXQgMTE6
NTQ6MzdBTSAtMDcwMCwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBBcHIg
MTYsIDIwMjQgYXQgMDk6MDc6NDNBTSArMDAwMCwgSGFucyBIb2xtYmVyZyB3cm90ZToNCj4+Pj4+
PiArWm9ycm8gKGRvaCEpDQo+Pj4+Pj4NCj4+Pj4+PiBPbiAyMDI0LTA0LTE1IDEzOjIzLCBIYW5z
IEhvbG1iZXJnIHdyb3RlOg0KPj4+Pj4+PiBUaGlzIHRlc3Qgc3RyZXNzZXMgZ2FyYmFnZSBjb2xs
ZWN0aW9uIGZvciBmaWxlIHN5c3RlbXMgYnkgZmlyc3QgZmlsbGluZw0KPj4+Pj4+PiB1cCBhIHNj
cmF0Y2ggbW91bnQgdG8gYSBzcGVjaWZpYyB1c2FnZSBwb2ludCB3aXRoIGZpbGVzIG9mIHJhbmRv
bSBzaXplLA0KPj4+Pj4+PiB0aGVuIGRvaW5nIG92ZXJ3cml0ZXMgaW4gcGFyYWxsZWwgd2l0aCBk
ZWxldGVzIHRvIGZyYWdtZW50IHRoZSBiYWNraW5nDQo+Pj4+Pj4+IHN0b3JhZ2UsIGZvcmNpbmcg
cmVjbGFpbS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSGFucyBIb2xtYmVyZyA8
aGFucy5ob2xtYmVyZ0B3ZGMuY29tPg0KPj4+Pj4+PiAtLS0NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGVz
dCByZXN1bHRzIGluIG15IHNldHVwIChrZXJuZWwgNi44LjAtcmM0KykNCj4+Pj4+Pj4gCWYyZnMg
b24gem9uZWQgbnVsbGJsazogcGFzcyAoNzdzKQ0KPj4+Pj4+PiAJZjJmcyBvbiBjb252ZW50aW9u
YWwgbnZtZSBzc2Q6IHBhc3MgKDEzcykNCj4+Pj4+Pj4gCWJ0cmZzIG9uIHpvbmVkIG51YmxrOiBm
YWlscyAoLUVOT1NQQykNCj4+Pj4+Pj4gCWJ0cmZzIG9uIGNvbnZlbnRpb25hbCBudm1lIHNzZDog
ZmFpbHMgKC1FTk9TUEMpDQo+Pj4+Pj4+IAl4ZnMgb24gY29udmVudGlvbmFsIG52bWUgc3NkOiBw
YXNzICg4cykNCj4+Pj4+Pj4NCj4+Pj4+Pj4gSm9oYW5uZXMoY2MpIGlzIHdvcmtpbmcgb24gdGhl
IGJ0cmZzIEVOT1NQQyBpc3N1ZS4NCj4+Pj4+Pj4gCQ0KPj4+Pj4+PiAgICAgIHRlc3RzL2dlbmVy
aWMvNzQ0ICAgICB8IDEyNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+Pj4+Pj4gICAgICB0ZXN0cy9nZW5lcmljLzc0NC5vdXQgfCAgIDYgKysNCj4+Pj4+Pj4g
ICAgICAyIGZpbGVzIGNoYW5nZWQsIDEzMCBpbnNlcnRpb25zKCspDQo+Pj4+Pj4+ICAgICAgY3Jl
YXRlIG1vZGUgMTAwNzU1IHRlc3RzL2dlbmVyaWMvNzQ0DQo+Pj4+Pj4+ICAgICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRlc3RzL2dlbmVyaWMvNzQ0Lm91dA0KPj4+Pj4+Pg0KPj4+Pj4+PiBkaWZmIC0t
Z2l0IGEvdGVzdHMvZ2VuZXJpYy83NDQgYi90ZXN0cy9nZW5lcmljLzc0NA0KPj4+Pj4+PiBuZXcg
ZmlsZSBtb2RlIDEwMDc1NQ0KPj4+Pj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjJjN2FiNzZiZjhi
MQ0KPj4+Pj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+Pj4+ICsrKyBiL3Rlc3RzL2dlbmVyaWMvNzQ0
DQo+Pj4+Pj4+IEBAIC0wLDAgKzEsMTI0IEBADQo+Pj4+Pj4+ICsjISAvYmluL2Jhc2gNCj4+Pj4+
Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+Pj4+Pj4gKyMgQ29weXJp
Z2h0IChjKSAyMDI0IFdlc3Rlcm4gRGlnaXRhbCBDb3Jwb3JhdGlvbi4gIEFsbCBSaWdodHMgUmVz
ZXJ2ZWQuDQo+Pj4+Pj4+ICsjDQo+Pj4+Pj4+ICsjIEZTIFFBIFRlc3QgTm8uIDc0NA0KPj4+Pj4+
PiArIw0KPj4+Pj4+PiArIyBJbnNwaXJlZCBieSBidHJmcy8yNzMgYW5kIGdlbmVyaWMvMDE1DQo+
Pj4+Pj4+ICsjDQo+Pj4+Pj4+ICsjIFRoaXMgdGVzdCBzdHJlc3NlcyBnYXJiYWdlIGNvbGxlY3Rp
b24gaW4gZmlsZSBzeXN0ZW1zDQo+Pj4+Pj4+ICsjIGJ5IGZpcnN0IGZpbGxpbmcgdXAgYSBzY3Jh
dGNoIG1vdW50IHRvIGEgc3BlY2lmaWMgdXNhZ2UgcG9pbnQgd2l0aA0KPj4+Pj4+PiArIyBmaWxl
cyBvZiByYW5kb20gc2l6ZSwgdGhlbiBkb2luZyBvdmVyd3JpdGVzIGluIHBhcmFsbGVsIHdpdGgN
Cj4+Pj4+Pj4gKyMgZGVsZXRlcyB0byBmcmFnbWVudCB0aGUgYmFja2luZyB6b25lcywgZm9yY2lu
ZyByZWNsYWltLg0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICsuIC4vY29tbW9uL3ByZWFtYmxlDQo+Pj4+
Pj4+ICtfYmVnaW5fZnN0ZXN0IGF1dG8NCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArIyByZWFsIFFBIHRl
c3Qgc3RhcnRzIGhlcmUNCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArX3JlcXVpcmVfc2NyYXRjaA0KPj4+
Pj4+PiArDQo+Pj4+Pj4+ICsjIFRoaXMgdGVzdCByZXF1aXJlcyBzcGVjaWZpYyBkYXRhIHNwYWNl
IHVzYWdlLCBza2lwIGlmIHdlIGhhdmUgY29tcHJlc3Npb24NCj4+Pj4+Pj4gKyMgZW5hYmxlZC4N
Cj4+Pj4+Pj4gK19yZXF1aXJlX25vX2NvbXByZXNzDQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gK009JCgo
MTAyNCAqIDEwMjQpKQ0KPj4+Pj4+PiArbWluX2Zzej0kKCgxICogJHtNfSkpDQo+Pj4+Pj4+ICtt
YXhfZnN6PSQoKDI1NiAqICR7TX0pKQ0KPj4+Pj4+PiArYnM9JHtNfQ0KPj4+Pj4+PiArZmlsbF9w
ZXJjZW50PTk1DQo+Pj4+Pj4+ICtvdmVyd3JpdGVfcGVyY2VudGFnZT0yMA0KPj4+Pj4+PiArc2Vx
PTANCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArX2NyZWF0ZV9maWxlKCkgew0KPj4+Pj4+PiArCWxvY2Fs
IGZpbGVfbmFtZT0ke1NDUkFUQ0hfTU5UfS9kYXRhXyQxDQo+Pj4+Pj4+ICsJbG9jYWwgZmlsZV9z
ej0kMg0KPj4+Pj4+PiArCWxvY2FsIGRkX2V4dHJhPSQzDQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gKwlQ
T1NJWExZX0NPUlJFQ1Q9eWVzIGRkIGlmPS9kZXYvemVybyBvZj0ke2ZpbGVfbmFtZX0gXA0KPj4+
Pj4+PiArCQlicz0ke2JzfSBjb3VudD0kKCggJGZpbGVfc3ogLyAke2JzfSApKSBcDQo+Pj4+Pj4+
ICsJCXN0YXR1cz1ub25lICRkZF9leHRyYSAgMj4mMQ0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICsJc3Rh
dHVzPSQ/DQo+Pj4+Pj4+ICsJaWYgWyAkc3RhdHVzIC1uZSAwIF07IHRoZW4NCj4+Pj4+Pj4gKwkJ
ZWNobyAiRmFpbGVkIHdyaXRpbmcgJGZpbGVfbmFtZSIgPj4kc2VxcmVzLmZ1bGwNCj4+Pj4+Pj4g
KwkJZXhpdA0KPj4+Pj4+PiArCWZpDQo+Pj4+Pj4+ICt9DQo+Pj4+Pg0KPj4+Pj4gSSB3b25kZXIs
IGlzIHRoZXJlIGEgcGFydGljdWxhciByZWFzb24gZm9yIGRvaW5nIGFsbCB0aGVzZSBmaWxlDQo+
Pj4+PiBvcGVyYXRpb25zIHdpdGggc2hlbGwgY29kZSBpbnN0ZWFkIG9mIHVzaW5nIGZzc3RyZXNz
IHRvIGNyZWF0ZSBhbmQNCj4+Pj4+IGRlbGV0ZSBmaWxlcyB0byBmaWxsIHRoZSBmcyBhbmQgc3Ry
ZXNzIGFsbCB0aGUgem9uZS1nYyBjb2RlPyAgVGhpcyB0ZXN0DQo+Pj4+PiByZW1pbmRzIG1lIGEg
bG90IG9mIGdlbmVyaWMvNDc2IGJ1dCB3aXRoIG1vcmUgZm9yaygpaW5nLg0KPj4+Pg0KPj4+PiAv
bWUgaGFzIHRoZSBzYW1lIGNvbmZ1c2lvbi4gQ2FuIHRoaXMgdGVzdCBjb3ZlciBtb3JlIHRoaW5n
cyB0aGFuIHVzaW5nDQo+Pj4+IGZzc3RyZXNzICh0byBkbyByZWNsYWltIHRlc3QpID8gT3IgZG9l
cyBpdCB1bmNvdmVyIHNvbWUga25vd24gYnVncyB3aGljaA0KPj4+PiBvdGhlciBjYXNlcyBjYW4n
dD8NCj4+Pg0KPj4+IGFoLCBhZGRpbmcgc29tZSBtb3JlIGJhY2tncm91bmQgaXMgcHJvYmFibHkg
dXNlZnVsOg0KPj4+DQo+Pj4gSSd2ZSBiZWVuIHVzaW5nIHRoaXMgdGVzdCB0byBzdHJlc3MgdGhl
IGNyYXAgb3V0IHRoZSB6b25lZCB4ZnMgZ2FyYmFnZQ0KPj4+IGNvbGxlY3Rpb24gLyB3cml0ZSB0
aHJvdHRsaW5nIGltcGxlbWVudGF0aW9uIGZvciB6b25lZCBydCBzdWJ2b2x1bWVzDQo+Pj4gc3Vw
cG9ydCBpbiB4ZnMgYW5kIGl0IGhhcyBmb3VuZCBhIG51bWJlciBvZiBpc3N1ZXMgZHVyaW5nIGlt
cGxlbWVudGF0aW9uDQo+Pj4gdGhhdCBpIGRpZCBub3QgcmVwcm9kdWNlIGJ5IG90aGVyIG1lYW5z
Lg0KPj4+DQo+Pj4gSSB0aGluayBpdCBhbHNvIGhhcyB3aWRlciBhcHBsaWNhYmlsaXR5IGFzIGl0
IHRyaWdnZXJzIGJ1Z3MgaW4gYnRyZnMuDQo+Pj4gZjJmcyBwYXNzZXMgd2l0aG91dCBpc3N1ZXMs
IGJ1dCBwcm9iYWJseSBiZW5lZml0cyBmcm9tIGEgcXVpY2sgc21va2UgZ2MNCj4+PiB0ZXN0IGFz
IHdlbGwuIERpc2N1c3NlZCB0aGlzIHdpdGggQmFydCBhbmQgRGFlaG8gKG5vdyBpbiBjYykgYmVm
b3JlDQo+Pj4gc3VibWl0dGluZy4NCj4+Pg0KPj4+IFVzaW5nIGZzc3RyZXNzIHdvdWxkIGJlIGNv
b2wsIGJ1dCBhcyBmYXIgYXMgSSBjYW4gdGVsbCBpdCBjYW5ub3QNCj4+PiBiZSB0b2xkIHRvIG9w
ZXJhdGUgYXQgYSBzcGVjaWZpYyBmaWxlIHN5c3RlbSB1c2FnZSBwb2ludCwgd2hpY2gNCj4+PiBp
cyBhIGtleSB0aGluZyBmb3IgdGhpcyB0ZXN0Lg0KPj4NCj4+IEFzIGEgcmFuZG9tIHRlc3QgY2Fz
ZSwgaWYgdGhpcyBjYXNlIGNhbiBiZSB0cmFuc2Zvcm1lZCB0byB1c2UgZnNzdHJlc3MgdG8gY292
ZXINCj4+IHNhbWUgaXNzdWVzLCB0aGF0IHdvdWxkIGJlIG5pY2UuDQo+Pg0KPj4gQnV0IGlmIGFz
IGEgcmVncmVzc2lvbiB0ZXN0IGNhc2UsIGl0IGhhcyBpdHMgcGFydGljdWxhciB0ZXN0IGNvdmVy
YWdlLCBhbmQgdGhlDQo+PiBpc3N1ZSBpdCBjb3ZlcmVkIGNhbid0IGJlIHJlcHJvZHVjZWQgYnkg
ZnNzdHJlc3Mgd2F5LCB0aGVuIGxldCdzIHdvcmsgb24gdGhpcw0KPj4gYmFzaCBzY3JpcHQgb25l
Lg0KPj4NCj4+IEFueSB0aG91Z2h0cz8NCj4gDQo+IFllYWgsIEkgdGhpbmsgYmFzaCBpcyBwcmVm
ZXJhYmxlIGZvciB0aGlzIHBhcnRpY3VsYXIgdGVzdCBjYXNlLg0KPiBCYXNoIGFsc28gbWFrZXMg
aXQgZWFzeSB0byBoYWNrIGZvciBwZW9wbGUncyBwcml2YXRlIHVzZXMuDQo+IA0KPiBJIHVzZSBs
b25nZXIgdmVyc2lvbnMgb2YgdGhpcyB0ZXN0IChpbmNyZWFzaW5nIG92ZXJ3cml0ZV9wZXJjZW50
YWdlKQ0KPiBmb3Igd2Vla2x5IHRlc3RpbmcuDQo+IA0KPiBJZiB3ZSBuZWVkIGZzc3RyZXNzIGZv
ciByZXByb2R1Y2luZyBhbnkgZnV0dXJlIGdjIGJ1ZyB3ZSBjYW4gYWRkDQo+IHdoYXRzIG1pc3Np
bmcgdG8gaXQgdGhlbi4NCj4gDQo+IERvZXMgdGhhdCBtYWtlIHNlbnNlPw0KPiANCg0KSGV5IFpv
cnJvLA0KDQpBbnkgcmVtYWluaW5nIGNvbmNlcm5zIGZvciBhZGRpbmcgdGhpcyB0ZXN0PyBJIGNv
dWxkIHJ1biBpdCBhY3Jvc3MNCm1vcmUgZmlsZSBzeXN0ZW1zKGJjYWNoZWZzIGNvdWxkIGJlIGlu
dGVyZXN0aW5nKSBhbmQgc2hhcmUgdGhlIHJlc3VsdHMgDQppZiBuZWVkZWQgYmUuDQoNClRoYW5r
cywNCkhhbnMNCg==

