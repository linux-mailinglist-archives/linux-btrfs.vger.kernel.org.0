Return-Path: <linux-btrfs+bounces-4598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FBC8B58AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7030F1F248F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDBEC2C6;
	Mon, 29 Apr 2024 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dAyUHWlL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sAGJbMfZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED2BE4E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394143; cv=fail; b=AtKAwBivTqDiZvyMtq1+qTYDxuEJKg4GZe9AQ6YYI1rW3cJwwcHjanVCQTDOLTfAuuavEStIwn+rmfqsnXPI6sJS2pdTnuXckvO0wEtH/JyFfleDqZdZiS2zYq/IZ9I9NITbfM+sjVNncZqTE0VLr2YCnODxk8K1AIs1yNXjYRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394143; c=relaxed/simple;
	bh=ixMo3g6vv4Gl3Ro0TeXs0MNxKJQdxlmKJHcu94+/cxI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=leiNKh/dixn3M669C2b8DmV1EX8YGTrwm27tKx/3tl4w6cCrW4S1mB8lnHSIBygjLJtXcbgikzEamwRJkbWfFbJdDBlI+YRJNdnf5Q6xjcIUh5h655PzP6ZjpVrto91HT/25wH47bJH3of6ajldQ+nq94hcryN6pWLKmf5tTA1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dAyUHWlL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sAGJbMfZ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714394141; x=1745930141;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ixMo3g6vv4Gl3Ro0TeXs0MNxKJQdxlmKJHcu94+/cxI=;
  b=dAyUHWlLACp500VR6Bx66wvRT84cf3WA12SOyLzcM8yi+eFCvFBiOi02
   d2yC+uhQvpVUqP3t0ABwh0KVTQIM1NE+foIpVxlAlZXiJ5/aUh60WlZd3
   flfdCg/BvZNpUjdGz73I4h50XJDZgz0U3NxuYx1iPJCqq5dfaVlOpjP5m
   1xvJPPVYKC4DB88xgzpUE5aVMi50YSp5JmEbFf+iCErgm3X2gpS5d5GJc
   qbCQqu9/dhe4bq6bM5t6DuEYbtMeaja0ZGrgf+Fa78zHQd3Pw72tLrF+T
   zJb1LHbhH2ytYHhyIUDtcQaawbnHFEhrXpSUZRphSjn/V8dXrZLTB43cZ
   Q==;
X-CSE-ConnectionGUID: rmFN1ClKSAOvtKBJaJJZxA==
X-CSE-MsgGUID: /u9wyQH3TualxMxvuqX3RQ==
X-IronPort-AV: E=Sophos;i="6.07,239,1708358400"; 
   d="scan'208";a="15091293"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2024 20:34:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krPqCx7/hEKSR/jX+re3nygCdXNu1jfJOdJ0ltGN5aG/mfpgtTvacFOO9sxM2u57mcMaBVhOEUb2L7xcL2XJWWe6rYM3i/Y/jycDHuRIAVjT08HXomCu/JQX5T7U5YnwOisIhGYfWjvk+Oy23t8XdC8HLCVGJEk/DqoJ0PpBxAXuIrePdPLHKObdqPav4nReasIH++c0r+Z5DsdYzR6B34J6oIrXXawBXIU8HnbJNOd5ozzCMPuyVMl9zuPT59fR+OemTx8cEAJLAznkRc2F+B2eRGrU+cSLdksTcrJNY11T21OhbHEV6RmwZS8VnpZtqODTyjOibaCMr1R7evtBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixMo3g6vv4Gl3Ro0TeXs0MNxKJQdxlmKJHcu94+/cxI=;
 b=ciIFL/ujX80tH3yROirhC4H33U1p9abayI7DoObXU8AhcWY+6TxmSAs1Xf3OwuHImD3F4NGh7BAMycHRuj+BxipXkEx0EQQv3WmcXMa538EoCAF1SpNcNrc0FQ2y1ney+Vk56FBtWc0087ZQrzaDtvF7y8qKXU+jXEdubMvEfOGmI6dGdOcaUg6i5BAQTj4D3STe/NXRnqcaUt7WiRqefqAkcal2y51PWFRlHHQ4bMS4lwy7h6CIhtOiblUk4VlFVP5g42CFzTYzighogMHlmMWCwwqo5RZjjAP9EbHlpsXozYbaRyp/dhKqcWOZEn/h7LddpRAXKZciJyDNtx2PIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixMo3g6vv4Gl3Ro0TeXs0MNxKJQdxlmKJHcu94+/cxI=;
 b=sAGJbMfZAmHtFKifL0fojzs5sy8yhNa42h1LBvEBeyKZ/K39Vi+S0/nxjMLtlIIFeKmzXpin94bleg00B56qkJF7O2OvXUVJZYTP3sQ3l9wOR3/tZyIdY91SJYDXEvtlroCZlj25FUsKrqFxpM1GdGgT3CPG3GTlzrLWguWdol0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7796.namprd04.prod.outlook.com (2603:10b6:303:13b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:34:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:34:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 2 PB filesystem ok?
Thread-Topic: 2 PB filesystem ok?
Thread-Index: AQHamcWLAwnuFUfkWUGJTQ2yD3KWcbF/L54A
Date: Mon, 29 Apr 2024 12:34:30 +0000
Message-ID: <6609017e-8931-4559-b613-4b3e28d9fb48@wdc.com>
References: <20240428233134.GA355040@tik.uni-stuttgart.de>
In-Reply-To: <20240428233134.GA355040@tik.uni-stuttgart.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7796:EE_
x-ms-office365-filtering-correlation-id: 68be9783-b5a2-42ac-9776-08dc6848b76c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmI1M25CeitNbks5d1E0cHFIOG4wcEtSeDlrdUJSWlp1TGJzb0d4bXZIZ1VD?=
 =?utf-8?B?MUJTNXA2dUVjVmdvTEhOWmRYSXVRaDN5bjhSTzMwR2hzSlRycHRmWmlyNnJI?=
 =?utf-8?B?TFRtTkxscTAyZ1RES3ZmVkhKYVRrMUlMVitHNldWaXNadnU4aGppdUxNdTBM?=
 =?utf-8?B?K0tHSzJqc3lXWXlvb2l6UitlN20zRVNjeXU3QlNsMnUyd3hEY0RhZk04MkRo?=
 =?utf-8?B?OHlqMGJnT0xqVHhaTW0rQ3RwaWw1VjY2RnR2TFBFajN2aHFtVEh5VmdxSDZt?=
 =?utf-8?B?YmpPZENxeTRtdjNsRWQrcUpqMUtCOHU2Ymg3M3Q3eTBGM1J4SHhaS0FwRS9u?=
 =?utf-8?B?VUl5WVBNMnVSNzN6K3JaY1VXQXc5QnpkOXJBRTR6aGxnbTF6WWxoNG0wZG1z?=
 =?utf-8?B?M1hybmlmM0t2Mnhxb3pubVFWaTBLZ1FWVmNJcUhmR3FsUHV5R2tCUGUwOE1J?=
 =?utf-8?B?UXEyd2RoKzJ5RkhvN3lGQmt0SlJlWXpEV2p1K3dweUVXVlZPUlFFRXFKci84?=
 =?utf-8?B?Nkd4QmxRL0NZcTAxVG5HWnJYcjYrMHZaWEhkS0o1ZVVKZmFWQWhqL3ZiR3k4?=
 =?utf-8?B?ZkUxTTI1T3N5M002Q3NoSnZjMnBXNFRxTmxFM3A5RWd3QUVoVFNQRkg2RWpQ?=
 =?utf-8?B?bDg3MS82VjdoSUpYVjU0U2VmTy9xQnlvR2hiQUFJeVlBL2Z3Q0l0aVFTL3M1?=
 =?utf-8?B?Y0ttRjhsWE9GL3loaWFFY3lYUk43Sk9CNWwveHZwenhYcmYvZ0hBQjJ4NEFo?=
 =?utf-8?B?L0tTM2NOM3VpQzBYNTFnV0IyS3Y5dmxub3ZEZnllZnp4Y2lMWGVGNlo1ZHcv?=
 =?utf-8?B?WHVEK1laWVppeHhHOHFoYmsyVjhxSm1Zd1NQWXJacWtJa245cHlBNFdSY0Zk?=
 =?utf-8?B?MkpJV1ZKeU0yWWlVbGhmdXFpODJ2VjBHcHdDMU5rVlJHYkpQMHNNNXYvSFBm?=
 =?utf-8?B?a1huQUFRTU42eGp1eDhUSWJ2cWgzZ1Y3cEhxczBhR3k3bjRWeGVhcVVNWk00?=
 =?utf-8?B?cXBra3pkc1pCZXR3c2V6RjJBNDlJM0pheU5qalJ5cjh4bzdkSlBZaW1vNlpv?=
 =?utf-8?B?UytTRVI2RHFzejRlN2tyYUVUR0l1d3FVNllyaTFqdzFBS2NYTDZDMHFNalFE?=
 =?utf-8?B?NjBoMmpWSDJYSjlZVUFRNUIxU0tWMUpqazYrK3BjbkVUMWNEZGtUVmw2eGtS?=
 =?utf-8?B?MzAxdTZ4SDdJLzdKTTN4MFRyTkd6VkNUWThUeUJFU3B3WWNNZTQyMDZQTTRp?=
 =?utf-8?B?QitRY2dTbXpBM2xsb3JqZHdGT3lvWjhOditDb3lWalE5TzIxa2h2bFJkNXMz?=
 =?utf-8?B?dUs0Ly9MaERNUk4zL3M4Mk9mVjdZTVZTMEtlZHVJWUJVd1FYampSU2x5NUZt?=
 =?utf-8?B?TVkrOXd3djJ5SHV1OXF3c3ZYKzFQc0tMaEV6bkQ1bnJKVFhoeXMyRXVpamd5?=
 =?utf-8?B?OTFMWmJ4QUN5OFNvRFBuKy9jdFBERFhVbDhrU0xEcWNvUm83cHpWaWlvRmpM?=
 =?utf-8?B?bU1kSVVCR0ErbmMvSUVHOEVESmVOZ2tzRmV5WS95Znk1MHVHVW5VU3AwZldL?=
 =?utf-8?B?alJLb0oyMHFwTFlQdlQvQnJXcjRUWlJyaVB0QzUzNkc3dTJPNmYvQ1lEVWQ1?=
 =?utf-8?B?b2ErSlZLVHYvdDN4dEtPc3hZSThUdFNaWlkxYm5NZEFVMG84RzBxNmNsUlpM?=
 =?utf-8?B?NWduZGEwVm5KNVJKR0lWeEFkMzNJZC80YXpZSHhmamJEZzAvWFF5QjQrNHpO?=
 =?utf-8?B?VzlxV0hNWVRYU2NhakVGRmxiRFpTWXg5ajhPY0Z1emk5TnBZdi9oSC9oUkdR?=
 =?utf-8?B?VUZBc0kwZ25JNjhyUXpqQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qmc2Qi9VSnBhSGhHa2pFanE1YjFPTmV6Ui9VaCtNS3lSSDNRUmh4QmxSUnE1?=
 =?utf-8?B?Z2hWZ1F1dXhVTVpjYlRnWHJSbG05MHhRNmZmVjVvZE5ISlNWUGhiekNwa1lj?=
 =?utf-8?B?bmFqVnBIa1Y4eENXMTVRaTM0R0ZXdzFoL0Y5OVlWZ0gxVG5WeFdLNUNacHBj?=
 =?utf-8?B?MEw2dmpzNHFYYzhqcFdGWkRhbXQydklkTVJyd2srbmFTZ0JtN1Q5YXdRcWRr?=
 =?utf-8?B?d3VyUzU0SDJmYVNnWjBWSXlkVENpMSt5WENQTk15ZEJUcEdxR0pBdlRpU2xk?=
 =?utf-8?B?SWtiOUo0QUdmOS9WMHRqZ2FlQ0pBN3MwRjc2emQvcklVazR1ZGVpa210NU5n?=
 =?utf-8?B?ZHVhcEJvVk1UQkF3Ukh4YnRPTTRsdWZhd3VsZG9HcENxdU8xQ3A5VWZwWW9q?=
 =?utf-8?B?aFFUbkROTjRGWDFvT2ZUc2F1SlJUblJRNVZrNDFqc2dyT3E4QmhpSTlXcWUy?=
 =?utf-8?B?YVRIT0wxN2RmalI2Wm81ZUxNSkZmb1doaytrRHVVNGhhZ3ZkQytoMHBxZUVr?=
 =?utf-8?B?ckdSUXNDbEdZczRnc0NyZEZ0Z0FSTVlTRHhtMlRQNVAzbXBFVEVZTXVhb1d3?=
 =?utf-8?B?N1hiY2RQYm9PWGpTL2lzTVlMUjNlVnpTNFFmeXROVkdHNkthQXg2ekc5TnJs?=
 =?utf-8?B?ZUNScGdTOXJnY3UyMmRFeURnbmY5SVd5SHF4eW5VcHZLdTJWWUk0NUZ2KzZ1?=
 =?utf-8?B?ai83ZXlBeW5pZ3BjUGE4MHNObWhRTzJvSEVNaE5nMkEwakF1TTlVa29rMkl3?=
 =?utf-8?B?MWVxTkw3VWRERHhldm53eXpLRk12NC9yanUzbDZ6Qmp2blFuVG01VmJWOEcy?=
 =?utf-8?B?SXZhcjdtc21GL3lVUTU4OUVYZEJKTmd1R08vdVBtOXc5YVJKWGxIdHlvdk1a?=
 =?utf-8?B?TnNlcVVOVDBtcEwzMFFEK3kxT2Z1R3ZsenM4VTFIbGoxT0hDODRJQTAzVzJY?=
 =?utf-8?B?Ri9Tci9kSlFBT2F1MVZ6MnNyWXhibW9qd3JjMm1oVGtyTFl1Q0VOc01RK1ZW?=
 =?utf-8?B?dmdocXJjSHJqZ2RDQzZCNzZMc2NwYzdLMHRMWXZQYm5QQ3p2Y28zNzBGSFlv?=
 =?utf-8?B?WURUSFpkdGZvUFE1QnpzRmczbzBFMkwwdGdxUy95UFF2ckJITUZPMUoxeTV5?=
 =?utf-8?B?bjBXUEtHT2Y3NzVydTFCQ01nQ0oyVTU1UW9wTmg0Z3NtTDRwOGJXOGdFdjBS?=
 =?utf-8?B?cmZVeTlDd1RIL1BXV2V3V3huMVd0eTJ2OUs2R1RlMGdCUnc1ZXZQN2F1UXRX?=
 =?utf-8?B?clg3RGJlb0JWRXV4N3pwOFFPQWdJR3pLQkZOVnBpMEZ1dkZoYjFPWlo0S05x?=
 =?utf-8?B?U0puai90MXpoRlQwU0xaYnQ3MlZMZE1Sczg0R3Rtd0dlUzduV01nV0phMHht?=
 =?utf-8?B?eld2aEtzVkZ6TFhpRU1hSm9IV1ZXekc4Rzc2WkJueFhtWkpIc2lvZVlhd3FF?=
 =?utf-8?B?WjhZSEU3SDBja2FuVTRsUDU1dXk4TVhHT3MyTzBZZGtYLzhJcURMM0ttSDNn?=
 =?utf-8?B?T1JLT1FZeHMzWFlBQ3ZFUDBNSmFwbVNXaUs4KzlhdTVPYkVZMHo0N2JuTWhD?=
 =?utf-8?B?cSsrV1ZJZEJ2aTRYczRsVUFHVzBQUlFQQzVqSnhpL05zd1VOQy9CZlZ5VFZP?=
 =?utf-8?B?K1FxNjYwbGllMiswSFhDT3M1WCtEQVZROHZXbjNxbXNHUmE2dXBkUzRxWmQ2?=
 =?utf-8?B?K2cwZTZyZXl3Q3pFRzZWMW54b01CR1hTa3o4Vm1HUUYxODhiOTdheFQrZWov?=
 =?utf-8?B?R0ZpUGhFZFBPaldEdUt0ditrYU0vL3ZXVjgxeDlIVUJwTHFQWTZRRmZKMWdn?=
 =?utf-8?B?ang0VThWVWdYSE9keDZ0ZHJvSUQrcnRoTExXbzI1WSt4b0lwWmVlLzU5VUcw?=
 =?utf-8?B?UFVEYkZMQXhtSEFyd0NxOXRPVVFVUExBTWhRMk5uOE44UWdGL0s1OWE3Tmln?=
 =?utf-8?B?aCtJclpJSmNJUUNEa2NyOEZpdk4zS29xeUoxd2M5L2lDMC9hdTNHUTNlZmlM?=
 =?utf-8?B?RmhjMWpGRjlpa05tN1NyZGp4djRraHk2Sk1IR2JDdnh0VURXWlJHLzV2bzlo?=
 =?utf-8?B?RTdEUnpGTS9MTzgrYTBERzFybnhHdkdtUFhNc3RxZjViZUxYZ20wSkc4WFAw?=
 =?utf-8?B?Z3ZQU0VBaWpiMG82eEh0cEVvZUJLSWRabHAwWUlEelhsdjMvUDVhenBENDhk?=
 =?utf-8?B?dENsRk42ZklJS01kZ1k5TzRCTHc2R0ZuRW8vWWgwdVE4bE00dGI3UEFrbmVy?=
 =?utf-8?B?UzRSUVcyVm9jWVVvYnhteEh5ZmZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DA6B3B02F653447855628F0D3DFF7D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jIrtdMk9nfjnBjLbCzrCP1LlV6MCRdtRMTOPPkt2YrulBXyV9SBvpM73LUC4RMb4UOljFtGjyK8mixT6DpRUygreo0Jo+UEH976dZHun37juXsaa8+axymDBZ35w6iKCyVsejytwp6vVg04C4ZZIOsQKcU4WuZzR7jD+oSgTQbiKXHoM64kyuIpNlZ0VJu3dPj+IWl7MNIjdRpbqjW6dJ7gTR9Bte5/saI5CqHQQGGi+pUJvunsFrm6k81V8QX81ViTGh455vwngwyRCjtWqYDmaXd6brEO70DNZRYiPA7LKSY/b8le8QqnQZ/LKLa7VRvByZt/gRtePnQtOvp6xVqicBpV4K6tHI0aqpRH3DfuvaFNfAry2lRdHRYgCPLz+zcfdYfi+8eFL1RTuvNQij0YXuwt9Fes5UQ+PefAGUkDOJe58Ph8PBzGGWhAZy5BFVQ6cbXTDzPr0WZ6N1Lr6oiFTFbUVGz7nHnjXTIlkZtYofjPQSZTAvE7sCScUnw9j5ZoEhfdgibUrPmYlpzdLHJ7b1608XBxSDqWdftHzT0lvoTr5kLi1oj9PrIBBRkaAu4K1Qu4AtGHvXs+yYh/2ILfIRKLEJdTjVISUV5/D5Y4Z3Rv046J34QYxw47o6xD2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68be9783-b5a2-42ac-9776-08dc6848b76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 12:34:30.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0XkyHXOkScqVnqwLob6eB9udC4XANRU09Hr4urU+hIlb1v96dWUNlADHwXlMmrpFt7FDJtplRHRX9QBbhAro7U9aIPSYuyZ2IKo/dZSq2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7796

T24gMjkuMDQuMjQgMDE6NDEsIFVsbGkgSG9ybGFjaGVyIHdyb3RlOg0KPiANCj4gV2UgYXJlIHBs
YW5pbmcgdG8gdXNlIGEgU2VhZ2F0ZSBFeG9zIENvcnZhdWx0IFN5c3RlbSB3aXRoIDIgUEIgYXMg
dGhlDQo+IHN0b3JhZ2UgYmFja2VuZCBmb3IgcmVzdGljIGJhY2t1cC4gSXQgaGFzIHNvbWUgaHVu
ZHJlZHMgaGFyZCBkaXNrcyBhbmQNCj4gZXhwb3J0cyB0aGVtIGFzIGEgc2luZ2xlIHZpcnR1YWwg
ZGlzayAodmlhIFNBUykuIExpbnV4IHNlZXMgb25seSBhIGJpZw0KPiBTQ1NJIGRpc2suIFRoaXMg
c3BlY2lhbCBSQUlEIGlzIGFsbCBpbiBoYXJkd2FyZSwgbm8gbmVlZCBmb3IgQlRSRlMNCj4gc29m
dHdhcmUgUkFJRC4NCj4gDQo+IFNvIGZhciBteSBiaWdnZXN0IGJ0cmZzIGZpbGVzeXN0ZW1zIGhh
dmUgb25seSBhYm91dCAxMDAgVEIuDQo+IA0KPiBJcyAyIFBCIG9rIGZvciBvbmUgYnRyZnMgZmls
ZXN5c3RlbT8NCj4gDQo+IA0KDQpJIGhhdmUgdXNlZCAyUEIgZmlsZXN5c3RlbXMgaW4gbXkgUkFJ
RCBTdHJpcGUgVHJlZSB0ZXN0IGVudmlyb25tZW50LCBidXQgDQpmb3IgcHJhY3RpY2FsIHVzZXMs
IEkgc3VnZ2VzdCB5b3UgdG8gZW5hYmxlIHRoZSBibG9jay1ncm91cCB0cmVlIGZlYXR1cmUgDQpk
dXJpbmcgbWtmcyB0aW1lLg0KDQpUaGlzIHN0b3JlcyBibG9jay1ncm91cCBpdGVtcyBpbiBhIHNl
cGFyYXRlIHRyZWUgaW5zdGVhZCBvZiB0aGUgZXh0ZW50IA0KdHJlZSwgZHJhc3RpY2FsbHkgaW1w
cm92aW5nIG1vdW50IHRpbWVzIG9uIGh1Z2UgRlNlcy4NCg==

