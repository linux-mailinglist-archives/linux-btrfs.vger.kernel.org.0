Return-Path: <linux-btrfs+bounces-4844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAF8C00FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 17:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10860B26A6B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED821272A3;
	Wed,  8 May 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V/eHdOH7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="StDUR5Ep"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB87641B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182192; cv=fail; b=lpULzK1wmyczmTTg86n0j+agrnManGqVQUp5MU9SI+FHpGlmj2GgLsGghVZZca5Gfhf/Xe454jT4yakJacxGInAEAWQgi42OOijvZOMDf6/UT73dSGmcHmeCGb58iXWB2sK0Srazuvepoj+j8p5xmjrVM346hN8EEOg5IlJ6Jlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182192; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k9hAFMADRziKORZs6powit8h50kht82WoQzcwJ0lcB0KVH8Q0xfDoR1a0eAw9iy/EfSj6Zs1AIylJ3elntFIsmadgQn06um2xMDaHGZ7ROqWdIR4ue7jUGKvKW2NyxQq2ZCHsNvVq3WLC/id5pXzz4p+hE+npzcnMPFbvKLw5qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V/eHdOH7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=StDUR5Ep; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715182187; x=1746718187;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=V/eHdOH7gz47h8vHunOcIAd/xquZzwTfFCucdU/GRbj3uSlA8BYiI/mk
   Sl5tcxskeh4e7E69sIoBNQaNKryKgs07LsCo4i9QQGifR9OndDL3J6p6s
   Tg3JhDwXU9qHJ/nx4daZNyDyij2w+rHVLcUdrZUIkmpZy2vHz2LgEaDWI
   LZxtsw4GExv8zaafhTU0VrvWDJkCvD42zZSGuoCfF8BFXgvPvTPhxXZl+
   0xcwJxSBzP59SMwsmt3fzTTimSLYm1xVF+5nqdTE2EEprUw3Ws3x80yAg
   XoqEzFtsdirIIzEQ4pBOry++yOZoolCzztELIUtGy/SeY4T4hX8F///Rz
   Q==;
X-CSE-ConnectionGUID: 9E982/knT1+Kov7PKtZOkg==
X-CSE-MsgGUID: pkK7WHZNT8KRb+y6ROPzYQ==
X-IronPort-AV: E=Sophos;i="6.08,145,1712592000"; 
   d="scan'208";a="15630225"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2024 23:29:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBsG0HdZyXa+t0pqXDbr4cCQJEu/EXxOFoY1lDANamh87VbpVUVKN447KvjQGDM8mbsUfpuJ7py++GJ1fgb3QQA23Dy5wtDJq+nJjY9JM8o7lesEcymXrTZ4/8ThRcl46F+rUDhlGV3s5DG2mYLgN9eY8n1CooeWUCex2sbnI8azcsgsvX9hwOKNarD640yx0iaHwOiGa8TaG50fHHXnNEtDJlQSq5Uf4yGc8mfsfwClF5Z1xk+CHiLtWVV2l/scJLpe2Hy/XaJFDlFgdeHx8KyfTiwszLuE9B8qxEKHP1ptgAnp/BXGN1/zee8NEbQoL7V3LRLmwMJeDMyOqLPOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WZdsjt8bEW7qSLMUEo9Yvt4nnNvcF8hnSgpHbvmgVpdopOtVJE7dSQkkgsLBu9GokezVjgTyoDvfQdOxOXnwsunTWP3k8L1OXj68zLpjTcFT2cJFoHm/FK610xNWmo26saL+iiPacnstI5D2aUSk/hUFz6a4HjTfm8/X3a2xbPPGmg+IMdrpDncg/UlqFiBPJcq4zYbjxOTpCiTuByOEg5eMOkLuFdDX71u3MSvui1M2pVKr4hsKnTbrdcQ1miESemQUf3wUuj9lbwGJRjdVelXxvxpSAcCyuTGPYiABf9kozJaDSHrGjlgnu6FN/4vBvxjL8nHkLSsLX8mPFpFf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=StDUR5Epl6KXPBZXTyLRiv76sKHy7olcPV/dTbojGKy1vYeLowuED13m95wFbtpyv1qecMmGAsHTlNzFVq0NpzV91TVbO742aaXB65IEF8KVcDAkaVEXcMgxIachsFlf45D4OZSRj3Ya4ZOFukiL6F/7cpFnAfemZsqfZ8jEWMg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6713.namprd04.prod.outlook.com (2603:10b6:5:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 15:29:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:29:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix use-after-free due to race with dev
 replace
Thread-Topic: [PATCH] btrfs: zoned: fix use-after-free due to race with dev
 replace
Thread-Index: AQHaoTnmYL38AwZjHU28bn0piz6s/bGNdqOA
Date: Wed, 8 May 2024 15:29:42 +0000
Message-ID: <c2f78c8c-20f6-4194-8dba-0854f1b2ab8a@wdc.com>
References:
 <ccab86c78fc2a1fd6dd320efa289863df7158ca9.1715167144.git.fdmanana@suse.com>
In-Reply-To:
 <ccab86c78fc2a1fd6dd320efa289863df7158ca9.1715167144.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6713:EE_
x-ms-office365-filtering-correlation-id: f66147f1-bd25-4086-0e54-08dc6f73aeab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk81OTVVbk1ja21nVzFnZ0FqbU1FTXBkU3NsTGg1UGFVQTRVZFQybnFTTG1F?=
 =?utf-8?B?V2gxcVB0NVNvWXpva1FOa1hjYXR2bFU5Y1hGREdwUHpLZWZseTNCdC9PQjRo?=
 =?utf-8?B?MWd4MzdsdVptTnZ2c3ZDejJoQmRkUWlGSGJ1NE9VRllNdzJTZE1VakhMZnNm?=
 =?utf-8?B?ZUFLd2FpN1pETlhDaEs3NWhmdnJ3UUJQdndKdUVCN0tjZlprV2c1bFFIYktn?=
 =?utf-8?B?OWF0c3l4MTV2VTlRMVEweUg4cEcrRVZxcmV3Vys5N2t2cWc0bnVubGIveWFo?=
 =?utf-8?B?K0M0eDNhZDlHaHBXYU9ZbEloTzdKT3dsN2lBUUFtb1MzMHVkQ2JFbWRZamxD?=
 =?utf-8?B?dDlFUVRreXZYZzZYZERUREt5SU9jN2E5NlVnUEZMSjdFYXZyYlA2WlYzbmw5?=
 =?utf-8?B?aFRSV1JDVXlzcW1qSG1STVpscVhwM2w3YjVBeklaSEE1WnAvSUVUNTJIVnR5?=
 =?utf-8?B?ZWVwZzVtaUNyYzlKb0tqLzZTMGhUSHRZNmFEZUhPMXpKb1ZZWFZmOVlLWE1T?=
 =?utf-8?B?S002YSt5aCt4TmZweERFaG80QTFqZHZGaEd0Z3BNVWxWbHcrTnZJUUxzWFZZ?=
 =?utf-8?B?eHA2eUtxeFE5Mk1ibG9ueWJBMFpNWjVDWFlDOUpmQTlZN0lvRnN4YnM1MXFy?=
 =?utf-8?B?ajYyNCt1NE82SE94VmxqK2kxaHB5YTBXL3lxQWZKRlFmRDlvTUpOZVQyVVho?=
 =?utf-8?B?b0hhZTQ0cHZ4enNWckJsU2xheUlRbWtwd3hha29YWFlyd256SnBYYTZTWkd5?=
 =?utf-8?B?WWZLYnZWT2ZGbmltMjNOL2hJT0t0VHk0b0IwbEpNbHYxU2pMWDZXS3NOaEhM?=
 =?utf-8?B?VkVGT0VJb3RDUGhaSWlWL01IZ0JHcG1mNWpVKzMzU0dVMUtoV05nYmFzY0M1?=
 =?utf-8?B?UXVvb3czQXM1ZTZkT1Fjd0kvcXZyRXNkOU5Da0p4MEg1RkNaTnZZblFvT015?=
 =?utf-8?B?WVVRalhBbWsxYXIvNTVmZzJ0MlhrRit5cE95WUk1a1dWb2lHZW5rejQ3YkFm?=
 =?utf-8?B?dW5qcm1kRG1EU2JZODVuZ1hTa0RJUWN4TzgzS0s4VUdJWEhZMzBPTDdaV2RH?=
 =?utf-8?B?d2QxMlRhSkZwVzVzV09tM3AyWjFVUTRSa1dObFptMWh2c2p5RlY1UFNhWjF1?=
 =?utf-8?B?NXBrTzN2VUhiWm1qTS9qZU1NbGZPajhzbVBBa095aUJzM0hrdERDWEZhdmJD?=
 =?utf-8?B?T2FQREJ2Z2YvZWx4TFRtUjhUYXlaUDdhaHlMRjhmUUJQaSsvcVhpYklKR05m?=
 =?utf-8?B?aXNMVVhXYVFXemROSFdDOVJEa3Yxa2lyOFU0SUEvdFAyMHhEQk53ZHpQbnFn?=
 =?utf-8?B?MisxaVVxTWJ5UmREaWNHTS9pODY5U3NzYXhaa2IxRXlYVFVNN1Jidjk4OFBE?=
 =?utf-8?B?Y3d4bDhpd1dUL2tCaGw1MGw0ZXNwclJyUjdRNkQ5KzdoUXNtY1U1RVJ4Zkgz?=
 =?utf-8?B?c2x5TkJjM0tIZjlkY3pBeXFZOVhPZ29qTE5Hdk9RUndkZStpMHU0VFZuRXRT?=
 =?utf-8?B?Zm5QMmp3THZVajZITVNSZmZ5djNOYTBZS3dqcmtZVGgzTmlGamxkekJqSmli?=
 =?utf-8?B?dGloWDY5ZDZNNktRNXovRGF0ckptRmxSWlNxSHFEblpnaUNWYUtUNk1SYW80?=
 =?utf-8?B?TDFZUkNSZFlhL2hPQlllbldwNmdQc2VNSmduWHVsN25FV3VkUTZVZW5NS2ZM?=
 =?utf-8?B?TGlyK3ptTHVycm14SnJmYmFqMFdzaGFheWhOVkE5aTB2NXVOZmh6UE1EZWI5?=
 =?utf-8?B?VXdBQXZrM2l2SllwWGJHQWhvRHpaeHJHa2diS1BBRFRGbkpUakZLNVA2T1FB?=
 =?utf-8?B?ZHhPaW9HOUYzV09hbDlTUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDdOT1JNR3BVbHdZTUdGQndHUlZ0YzJCa0grWWFMVlNOOGRnV1F4WWVSTzV5?=
 =?utf-8?B?NjZpbndWUHlJM25HcmlYWXBUVWpXcURobjBDcCtidHZibDk4c2pOWTl5b0JB?=
 =?utf-8?B?bVhoZ0duSzVlTVQvRnRhNlFuVjNiZmQrNHM2VFBzZC90andwamtoSjFMcTZE?=
 =?utf-8?B?RHdoZXh5K0dPdTVMblBJQjd6NG4rM1dTclRKdkROVCtselFhVlFhUEFQMlgx?=
 =?utf-8?B?czZBVDcxUEc0aVMveHA5dlFzeHl5bVpXTGdhWHMzU3NNYnphUFBRVXIxTTFR?=
 =?utf-8?B?cWFvSElIT2NCTXZhUUFCVmFjQWlpOSsrV0F1V0xVWi8vMG1BNFk1dEFiU0dk?=
 =?utf-8?B?Z1RsVmZlUVh0SHFkeisyTVJ4TGthWkZDcXJlYlJwVWhpS1M3QlM3eWkyeTdn?=
 =?utf-8?B?NWJaTjRkVmNJSzBSbFU3WE82ditRamllajVnWjhjSTZ0QWNWSHd5Qi9VYjZt?=
 =?utf-8?B?ZGtBK21BQ1RIUDB1Qjg2clZBZDQ1aVJEM3NJTFd4TkNtcFcvWVFTellCL05L?=
 =?utf-8?B?VW15eU9HUGtSQitxSlBFejhtbVZFb29FV3F0N0FoQkZ6cmd1OGVKSjZRcDRW?=
 =?utf-8?B?b0RkZE5zbkNXVE56bEs3cy9NaUYrZktIckkyb2JETHV3eFlIbFRvMXVEVE00?=
 =?utf-8?B?OFFiUm5WYXhNSC81Yld1RytpT21mSlU1UUxHWklCdlpNZ1doQlcxMHhkdEtF?=
 =?utf-8?B?YzVtVm5STUZva3dPR3Z1UnJWVjRkUnd6ZVlTK0xVdGhybUYxZTNjelBMU3dZ?=
 =?utf-8?B?TG9Ga3kzUUswTkd2SHRoUDVhS1c4YmFMV1ExQnlzcWVoN1pCSWl1UnZKUk93?=
 =?utf-8?B?clpxSEVHYWxaMWppWEFpM05kZUx6ZjBvcXE3bUllTmVjeXR3WDh2ZWVVdG1r?=
 =?utf-8?B?SU14NXRjK1IrYVRBdENIOTAvV0Y4TUNFQ3ZESi95bzJ2R251c3M0MjdINkYz?=
 =?utf-8?B?ZmV4Si8ycmZ1TTIxa2doUlRNaHE5anVmWjRMbUluaVd4SzNMcHJ1TFdHNGNN?=
 =?utf-8?B?RWFhdlJleGJIcWtlYjRLcW43c2YvQVlWVGRlNitmYlFWalgrZGVmV00rdGdu?=
 =?utf-8?B?eHlXOFZzR0pIRnl2TXFuNUpCcHNVa1kvWlRwVmMvb1QrRVhiK1pUeU9QMktr?=
 =?utf-8?B?cDBVbW51YWM0SXF4eFBBaTZkOWpyR1p2TVdEVWZTS001aVlqTUZFcGVpN3k1?=
 =?utf-8?B?R29lczE4RndISHFvaWdBL0VSS2FFdUZQblVEODVIWnRWbkdBZlRCRTltNUdo?=
 =?utf-8?B?WDcyWVBIWGJzRzlFelBvdkxHb00rdVhCLzdTREdUQ0NacmlVWml0YU5PSU9a?=
 =?utf-8?B?TStwZnlzT0RnVmttVkF1ckZWWFp3M2xxaSsxWlIzWXZTaitaL0RPVHNRejRU?=
 =?utf-8?B?TFVSdGRma3Zod2ptU3FyQTluQ2hjeXdUQ0tyNytYWmM2ZUx0eGdXMHdURnhY?=
 =?utf-8?B?UUc4d0JldUtvSGRRYmVjT1M2RllTNUFTUGNlYkxsc1V6SDZ1d3pORmhXS01S?=
 =?utf-8?B?cUFKRVRBUEk3YXVGVlVNZUtjeFB3Mi8vS0lLZkNnWjUwY3dkZmhUNFhMS01V?=
 =?utf-8?B?a2pFWERRYzVYWVg3d0VOa1NQUW0vSXpCVkptRllnazFjL29XbjdWYXNPQjRO?=
 =?utf-8?B?enc3R2svTWIzT3ZMTHJGSFBUYmdQSGNOZHhaaldNT0c3UnNLQmpqUDYxdU9E?=
 =?utf-8?B?TytDNXI2bUEzTGpiMm5OQVpoZHJMcGVmYnlYK0VBMUYzYk1lRnFXQW5iU29n?=
 =?utf-8?B?a0xVam5BKzhPTVVhSWFjWWJoamgxU1g0WCsxeXNhT09pMVlFcGN3RWRhdkNE?=
 =?utf-8?B?WmhQSW9QZktxaVpOZXViTnA1cVNyZFc4Y3dlS0ZMLytlUjhCSWNyRFBSaEdS?=
 =?utf-8?B?dWJ0VUNNTjNsM0QyeXdJZW1aaFhYWDk2U0VBdGY2akFVZjFFcGNUcXAvelE4?=
 =?utf-8?B?cUhsT2QwRnBkak9RTjZTd2NQZXhqNk8wd0lpNHdMWGpjMktVZFBuMFNQdEdJ?=
 =?utf-8?B?WVJ2UE9wMXh1dEFXNFY3R09lUUZVajdobEZDRUVkUGdhbCtVUC9Kbzd1UFlI?=
 =?utf-8?B?b2Q5OWVqYkhzb1R2a3NIYVFsaUxnRzRGMHBONkgxdTUzZUl5dERQTGwyYUgv?=
 =?utf-8?B?Z1paZDVoRGhJNStBMXR5emxHbUdTWDhnUDNnSGdtaHpZMHpkZFN5U3VQSk9p?=
 =?utf-8?B?VUdPTWFHV0llVEF0YmRMSUFJRFcwZklLMUJVOHlyQUpQSHFQNlAzbGFKbHc0?=
 =?utf-8?B?YTdiTWFpZ2VJSzd3RllLR2c3RzBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF8D83F3A710524288D96D0D056F322E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h97/dOJ+bO6J/5XB3aTrmoXk3YgT8L/ykYLmiibwV9BLHk4G7rc8h5vj0Q1ZSuPwG3QRPH5yUFu9RQXfH2ybe/g4A8yMNEn3rWPmFvZYuhIQGqZu9Gxr6ON7qraOdKJHtGT6SIlXwbMz8UbOIM5/GUcpx8R7m0B7ztsSe9NPg/fHCda67PAeJnFiyE9b0m9a3L6iekBvIrkHspbk8tFijPHBG1Vyv5c9rY5qjK877afN3iM/owp8UKm4iJEr9lBFEKbhdwtm2tjTRxjwlF6k1tKMmW6CM2I+b2MMt0ZANL6yYeerc1jwZE3DVPi0VkL2XmfEXl+7X4SFEpZNvgbFivu7BcFAL+sJjuzFxNJwykDRScy6PttUA2Gl/WPugKKpRyzoTeSwyfZ/pvnV5pPRVEzWQoLFh71W0vJvtPhmI2OJuRjTn55+HnCIz+3Egr19dVGp9TGwPt43oPVhlYthmLr/CkFAbfNsahTXrA5a7udcYXpUs2+TdR6nAYvUu0wYGGVYMCws2jjhjeXEwsCSBxHLPSw+5LJg8ONWitQshnaNXqNCLH5g4WwUMfODv4W9cOAgEj6TVvVuBw5WOBTYjEvJ5tcbuM/S9ibOH5WQUIKH2NMfXkhPx3rBU6J6VlK5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66147f1-bd25-4086-0e54-08dc6f73aeab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 15:29:42.1667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFW3lzcsGTYnT6IoV/uH4vtXCBYihO2Yo7wxyHyzUzYvd3acirmobdEB6IsXPLsZ2f5G3u25dwkfOyxW+Bw25Peh3htMj44eGRc8ETwsQlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6713

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

