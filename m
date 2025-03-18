Return-Path: <linux-btrfs+bounces-12367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC4A66E7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA601883005
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF12063EA;
	Tue, 18 Mar 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c3bkCp9K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ca0UAkse"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C61F875C;
	Tue, 18 Mar 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287070; cv=fail; b=RJPZ2CqC8e8bq9uFD9omJkIGEmTtr2/8FGRR+Jj3zhmCq3LCw0HqQq/hnOs5cvToG0g2H6hUYfYbnLL4KVW2kDhZn2DnaIH9wpASNVWkCCIg5k2osY5y1DHwcPIiUtTqjURFHPFFqYS1IIkqAWdN1KMymYV1cK20aLGbyeOmKLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287070; c=relaxed/simple;
	bh=mJuzp/nQthiAQ5r7Vi4yp4k27rMkI6EsBObyRQKKuZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ECLmR2FN0TEzlMx0QZGDWYMqt4grvaFPaxEmlEFDYNlFSjyg49UcjnJ7oHHVeICe9y/4RdN1hm2L3SE6w0Xn5C8xjz91W7ECaPuY9dvn58znlo2wHc35p4s6PP72YZNdIjNC6lFyl3fis5JRns9CBSM9S5Qk3fM5iNSWSsdGv40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c3bkCp9K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ca0UAkse; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742287068; x=1773823068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mJuzp/nQthiAQ5r7Vi4yp4k27rMkI6EsBObyRQKKuZ8=;
  b=c3bkCp9KjvXNAxqXdcLyzl985Fd20jmUDrgWm9szJBLjMWXUECR3NuHy
   3J0Im6whAP3QSQYMsRjN1IT/IeCNYB/TtWwf9xopnT0SP+MMoUU8o3FZ3
   4G70ztMILLHDhFeP40KJ7GZC5KM795ZjJUUAJheqNhMsLKuvde2KvxoDb
   IiYP4VO9l7KhzeX0OZc7isi2gJAJlv6OnLpuU8IImm8N8/t2GOCGp/Y3e
   5KhqDIQPUCCWdCl0PwppMPkQpDyyEIS1OpjZNdzeXX6Ts14tMZkzOUtkw
   BIZl37G6aBMDA6JADa2kmg+G71mysKhBMI4f8KJ/L4t6Y6tS0S4tNUtAa
   A==;
X-CSE-ConnectionGUID: dY3+YliCTK2Ps4/yW46meA==
X-CSE-MsgGUID: ZuXamdUQSYGGc9tTNDabZg==
X-IronPort-AV: E=Sophos;i="6.14,256,1736784000"; 
   d="scan'208";a="52962905"
Received: from mail-northcentralusazlp17013062.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.62])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 16:37:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPmEBCeTQYwgz9HCN8/58J3r6mb6CXLsUrIVR0nPvXytQSP3hMCU+BtmHFFthM+WERy1onPmfjnc4W84GiKDEEUGZkdXXuNP8WTNT+txJHNXsVcpvukc84+Hblpw4ZQzTbMabjUndrnTbbyRecdR1Uc/7SJUajaoSiK0KAFGJvwsj0aYmCuUJeV1kkQBsYEV4Iz0gYpWl+MJlZEeft++aYf4MJW/k2WgexiKz2m2C+y6WG+DX/yHAnuW/zGVZlW03f95PJds28TMELA3M7r0azDJHGsx+8TKy8qTUVetGuVnJIhkpQlwYfxewldzPZiKXK9r+geT5Tirfywek4aSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJuzp/nQthiAQ5r7Vi4yp4k27rMkI6EsBObyRQKKuZ8=;
 b=ug30TVPR2vJeRkalegqiFFuJOBRBHQnJbIbGOqSbu2rG4iyqejCN3BMIpEXX2tE6LUssbF5nQpRKlRJ2Iw77ekitMR+GPfk2zlGAWVJ29JrVCH4sRVZ2/kO23X0W/G32NJzVgpBVwZv3Hrtpvk4voJkS/+NxmcCUVWq7I3VIc0yF59xlnvOpHpk2xjz6aGDBO4qUDOsaFURiXVPIr5VY6HH0a2yIcmwW2GFHqCEQYxAaNP5kFaj78apEBRag4cEfvTo5GbjaAjD5i0NfoE7MPr9gIUaeLSBKnqgKlBmVOJXM6PfsShJx9CNrtuiiCPd2EXrAQsY7nsI0BCNgCkQgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJuzp/nQthiAQ5r7Vi4yp4k27rMkI6EsBObyRQKKuZ8=;
 b=ca0UAkseGwzL1j9EVuzqcqE3TJ0VId19da8Omim7TfIsl/F1Jt1Y+jelGVXqBVCAEzMcBLEBHR5O45xpADkZGnnIfycBc76bZuENW+x274OhGfIlItJ6SJqGTpDodGhUwkH6dRICDBfXW4sXcc6YQA5WkMnCYXShRs24GJUd2tI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8931.namprd04.prod.outlook.com (2603:10b6:806:381::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:37:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 08:37:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Johannes Thumshirn <jth@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Zorro Lang
	<zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
Thread-Topic: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
Thread-Index: AQHbl04BYPWchuIgeEmgsVMc9mwiQbN4kpqAgAAA0oA=
Date: Tue, 18 Mar 2025 08:37:44 +0000
Message-ID: <27697fa2-8a44-47d6-835e-eafa4bd8242f@wdc.com>
References:
 <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
 <a50388a1-3d10-484d-a5bf-762423d13ee4@oracle.com>
In-Reply-To: <a50388a1-3d10-484d-a5bf-762423d13ee4@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8931:EE_
x-ms-office365-filtering-correlation-id: bf028687-0fd4-4f75-dae9-08dd65f82785
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3Jvd0NJUlZLZG5FV2d0N2RoTFdmcjNRM1Jrd1A4aUlXMnc4N0Q0Yjd5OFEx?=
 =?utf-8?B?V2ZJR1JXMlQrODJtbENUbFRHeks3WXArMURUZWNXUEdjY2Z1dm9Ocy9yTXlv?=
 =?utf-8?B?TU1SR2laTGxJOTlKZm8vam1LQUF5bklXZWRsUVZtaTVETkNtTXZ5Y0pVTnZr?=
 =?utf-8?B?YjRieWZoTldHNmRIV3YrV3c2cGtoQXZyUFBlRmxZU3JMVlg5ZW84ZzBkNWY5?=
 =?utf-8?B?OWQ0Vm1lTDdqVmE3blRvaWVnYW1seEoyWWZ1REZYM1JtemNaaU9JVGM5WlMy?=
 =?utf-8?B?RmkrVjhoK1A1Zk1jajJHTHZrSFl5K1pCWENVZjg1ZnJ3Z1QwaU5DNU1vVzBo?=
 =?utf-8?B?WmtTcnhHMmhCbTNJeldWeW8vSmg3RmlxNm80ZUNRbk02dXFqb0xrQUU4YU1y?=
 =?utf-8?B?NXVLWW1vWnBVSVdUWTZUYzY2UW5Id2FmQXFMZVFLVjJKOGdZM3J2VDZiSDNR?=
 =?utf-8?B?MEFSaFZsVml5TWVnZStRR3lSRFNweVBFaDRKVmN4RkdGS0d2WkZ0eFk4K2tK?=
 =?utf-8?B?eGpQSEFnNlZUbDZidkZnMDJLNVVRRVR2L0Myd3psanVHTWtuNzF2V2h6MzRh?=
 =?utf-8?B?QVdMZzQ4UnZJdDRycEZ1NURhNEFSL1hzeEFDSUFjdVl4cHY2bW03VkhselNM?=
 =?utf-8?B?N1dYYVA0djNNeFZUMVQ3anA0cVptUjA5c2hKcUFEZXkvYTROZmJ3UkxzMk5F?=
 =?utf-8?B?Z3dyaTRuWHk5MWJUTk12MCttOGpnWjJMODh4OHZDZEp6SzN5SEZHd3Fya3ha?=
 =?utf-8?B?NjNkeU5ZcllLbWZaWUt5bGMrVEZTdURoL1cyQ1hVbzlwUHFhSmRmdmdrZDg3?=
 =?utf-8?B?NWkwemFiZGpzaWdDSHNBNG4xTmxxemZJQXd3WXgwdXArMDkzNTRlZU5uanQ5?=
 =?utf-8?B?RHBJU010L2wrQ3F2T1NzeVpNS21sRVZWUFNwM0VqTXlRT3ZUNHl2aFh5d1py?=
 =?utf-8?B?MnREYnFLTGRrcEZiTHg5aEMxSkJyd0IraXE2cm0wV01rUHI4aDhsNUFhVVhQ?=
 =?utf-8?B?S2QrYmNWc21iZ0xmVmRROTlTV1lXVHg4YmN6eTBRRVJlK3RTM3ZkckV6MDdI?=
 =?utf-8?B?dEFIMmRQR2ZDQWE1SERaWldpZDQvdGR0WXBkZDZjS0lZRnBVMENLbFp5MG1l?=
 =?utf-8?B?SHdoOEVwNnoyMTVjSXhNUW1DTitSWlA5VmZOUGs2U1pmU0FiL3RtekQzUHho?=
 =?utf-8?B?VzJvT2ZYL0hrQ2hPWks4Qng4NStVa3dWU09rcjk2Vmd3Ri9WY1FMK3hWL21P?=
 =?utf-8?B?K3B2enU5Z2RacThGZ3UrM2dZcWpBUGRaUHJPemJZL3FVU1RtcE5TdW04T1dz?=
 =?utf-8?B?dXgyaFpBaThLb3htcWIvYTIvYm00Y2w5Ujl0dDN0WURxTFpNWTBqK1J1cGpI?=
 =?utf-8?B?eVF6cTdNYmdwZXVsSVR5MDUrNFd2OXh1Umhxd3I5MXlJVVpYMzFiczZ5QkR4?=
 =?utf-8?B?UEpUelRyMjdzUUdldXRwbHpVWFkrV2FvcExlNmhzVUZRcnBjaU1uSUVvZFpk?=
 =?utf-8?B?bnU0bHZKeVdFNEN6TGtCam9wSGorTkxmV2pYMENvK3JFS2lRbXBUS0VkN1Js?=
 =?utf-8?B?cVF5VGNQaUthUUVRYTdNVnVsVHd2Nk4zd3dMQTdGSkVnS0Z5d1IxSDlCMjBI?=
 =?utf-8?B?bXEySkcwRGJlV08xNnJpUTQrZUw5MHNXNDhsQ3YvQktlblI1ZytZYnA2MzVs?=
 =?utf-8?B?MFVzUFBlSXdMYlBTUVhYMjlJcm5ZckVUYkJZSDlTREkwR2dxdUFSL1htR2d1?=
 =?utf-8?B?blNXUXdtYlU1S2dCb2NhMFU2RkF2TWhtWWFMUU9HRkRSdjdDRVIrU3ZzV042?=
 =?utf-8?B?R3o5Z3hxcFo3b1FnQnN5bzQxYTREWGFSdmpRZ2VtTUVSNlNmMUQvODJ1QTZ2?=
 =?utf-8?B?RmVnSnNNT1l4dTBFN24xRk5Ra09nS1lqL1YrVTBNV0VTb3k4RWF1SExIbnlE?=
 =?utf-8?Q?aUQYbQt+UBpejcLgz2MTm9usaJns3LDI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjVBOVpjbThUZzQ0UkNjYzh3bzVlM1lYV0lLUDlnTlFtdWdNcEJBRjBvWkdF?=
 =?utf-8?B?aitRdFNMYjVFQXQzREZYV3JEMHBCSk1ZakRrWk5oRzEyMmE4QldsdENXSndw?=
 =?utf-8?B?V2dYTXVTbzRmcVNMeTdXUlVaTEZYdi9ZZVgrOG9TWGxEWTVNemFFd3F0SE4r?=
 =?utf-8?B?ZHJ5cVJJYjVBbytIOVdjbDI1Nk1NZE1HMDFGeVVmRzhjSlFSb005K3o2YVBL?=
 =?utf-8?B?WFlseUR1VDV6RnlZWHo5WVYwMFlkbzZtdWk3UzlFRndHbW1sUEU3Qlcza2dx?=
 =?utf-8?B?R294UnQ2MThweXd5d3ZvcXVRSTJTcW1LZWo3RWNHVDhkM1pWam1rVjBHUnow?=
 =?utf-8?B?akpOOVYvdlJVVlV4eHM0Y3VTa2JBMEVEQkxzbS8ySWx1ZXEvMHJFc3VCRWU2?=
 =?utf-8?B?TTRWM2l6MVVJeVRZbTd6U05tZTB4ZXNrdzhvQ1V3ei9kZDdWN2psd0ZDNDB6?=
 =?utf-8?B?bXh2bVpvMytIQThnN0tzaVhsVElQT0toWDRwbEpvMm9MS2NGcFpzRVpibmtD?=
 =?utf-8?B?OHlzSzNNdEdQVE9tQ1k3MHZ4L1M0aEkwMnUvaXl6b3JHSTNNRGNMZk9EL0Z1?=
 =?utf-8?B?Yk1UQnBhNkltVHhWeCtSZ3Ixc0dTS2tlOFpnS3FBTTJtRXYyTVdJMXRYaVBs?=
 =?utf-8?B?eUlTR1pIanBkZ1pNWlIvaS90QWd1N1ZCZnQzWjZHeTk2eWtYVUlIMFVTRTlE?=
 =?utf-8?B?RXYzaXBGQTkyZW4vQWR2SmdOeXNPK2NhZ3MvK1lUMm1aMmlXc3JRRzNLVS9Z?=
 =?utf-8?B?TUM3Nm9OOTFFYUd6Z1JudmhhV1IvNm1yTFRpSGY0QlJFeXlSK0kwUWJpM05s?=
 =?utf-8?B?QWpoVWtVVHp1bXFuL2Fzd3B2WVNPWEludkhyZmJTN0dtS3lhSmpEZDVRYmJw?=
 =?utf-8?B?dmpoc3l6MnkwNWk5SmV6VDZDZmJDVWVhTURBRFc2Wk1DVXpaSXBMa3pCcjJ6?=
 =?utf-8?B?R0NtUEtLcU1oejRVUDRCRlZsTHVpMFdkUGhCNi9uYVQ2anJDQjVRNWZqQlNN?=
 =?utf-8?B?Wks5eXpBZnVNaW9XSVlyQ1ZxVThQajNNd2JCbVVsa3RGUGh2OW93aWZKQ2Jk?=
 =?utf-8?B?RUVVR1JBT2wyK2ZUY0hrZUZQanFMVDB5dDdsdjd5bzhjby9xa1dLc3FaN01E?=
 =?utf-8?B?MTgxMGRVRVRjcDVNdTRNTUx0SVd5WVlnY2Q3WDFrbkRXekxnWDB1eTRrd29D?=
 =?utf-8?B?MmZJemZOcDRYdFFnZFJWdEF3WmZQQTV6RWVBdmlJMkI3amlMbzVLSTFvQWVM?=
 =?utf-8?B?Y0tMVWVDR3lram03K0tTdGxUUTRvTVZMTHNSeTJFYldERWVxV2IyaExTTmtI?=
 =?utf-8?B?NVFlQ3NkQ2ZWYjVPajJyaFpOR2p3UDJtbSt4NjRrSzBsZDRnRUNlYlNMQzdy?=
 =?utf-8?B?blBiVXBsYVVvUGdXbzYyT1dpbXlNVEVKZTVLelJFMTFBMVJwWXorRVNzcHJo?=
 =?utf-8?B?bGVqckI2VzdielVkbXdWd0lnTUkxQlB3dmordmZyUU5ZY3dPZ3YvVnhsWVhT?=
 =?utf-8?B?anZlS0xWVWF1NFliV3c3Um5hQ3BnbUxPK2ZFV3ZMUlFDeEtGVFhZTXM1TFYz?=
 =?utf-8?B?SkdhR242cDNyUmExNkJ6YmZQMXhFcER0dnlvTldVOVJIOWdPdXArTkJXNDVm?=
 =?utf-8?B?ZXY4VVBSbE9vWENkVXE1WEMxTG9Lakl3Q3BxN1lkZGtWQ0FDajBQWkhCc09u?=
 =?utf-8?B?MGFhT0dGWDkvVGxsaUNJM2NsL3U5SnVIQWxJc0UwMUZuQ0pMMTQzM2UvTytK?=
 =?utf-8?B?SUJoa0dFUTVUV0pmcHVPZDUyVGFweEd0TTBWNzBaOCszNDBpdjdvZGJ5NHZG?=
 =?utf-8?B?bzRHYkJBMCs4L0MxR3ZzbkJpQ3VFUUhiUTZwL0lHYWFERXF6OHU2cGg5eE9v?=
 =?utf-8?B?SkFWOEo3cmlGUVo1TmMydXZRMlhnc0thSTU3ZjBNbVQ2L2lSYjRsZk9RM0tv?=
 =?utf-8?B?S09EMVFYcmNrcmZteEVZOE16aDdQZVVxNHdNbCtPem9BdzRwb3IrS0UvUFpJ?=
 =?utf-8?B?b3Q1NmJTVEZZa1ZmV3VSSC91cGRFL2cwenhlMmlOMDZvMXd0VGdMeVhCd2tZ?=
 =?utf-8?B?VTczUURVUUhBclgyU2kxVFdPOXRhdy9nMko2UjgzeWZuZEdkTTFIb09ZYTRt?=
 =?utf-8?B?M0RVaXFzaWtqVjZMcFkzQkZGSHpuNFhIeVZxR0Yzc2cyZU0yMmZEcTg2VWdG?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70E0562063E4BE4099BAF205F36F3315@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vxNHM1hFF7OT8WQuoGwVvqLOSVC77rDXbb76OKvqXBfXdPXw5tHXyKdccKqPIPdnqDuXfThALbcTiM2JYiPqhSM8LvCNUg8Qnw+f2mlZf1yhy2ka3ybZCUqhvaqG6RftSQSh518mOi2vitCeyoaHuF5HQesVh05HM1z55p96k0ZdOd6QUSBxn7E7VK7PkLrca7JV9RYC6bNGxNOIDSBSo2M071Imi58TLP2RyUcF3jcOYsluBtM8icJv0JX/zvu77uIfr2SGV8QXA0+/OZmFRTdwt9GlhY8RBOPpk58xCMCZJvnEjB675Dwkgs8cfBmLiIsnv+zObizAg8yDcwPkiwSOQKluFw7Z2ja9i3k2Kj/WRHcNFaj2bgHMfUnO+hM/RQe9X8Uyn8XY81nJSkoMba2lSxWYaa3EFIdXaUmgqGBzqsfKdScxrSDX6GNCuQALEG4PM3DizQFHQpNbeNjLkcOR99RJlPw5juO95z2pHWGMNS9jwh+s8epocFEYtqIb4m7fsU9KrO6mvm4vIyn8Domd/BpHxFUhm5bXIb2f8nRBNMd4CbAY1a9J8+CmEvdUVxqYXH5KxHrsuR/LbZmQ9AkAdHp75eWWUc8/RohOnPuP6ZhnJkemhjBuXAu7s2Zf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf028687-0fd4-4f75-dae9-08dd65f82785
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 08:37:44.5279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6l2Z/OowPHwXvcETUjAQTRYLI2H4fWH5lMNYxI5+NBIeZFaFcjN8bxE8IJeNbXkMWskezslpi/GZm6jFDiVZ2/5NWvwWXnnhPGa7FJDZ5oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8931

T24gMTguMDMuMjUgMDk6MzUsIEFuYW5kIEphaW4gd3JvdGU6DQo+IE9uIDE3LzMvMjUgMjM6MDQs
IEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEZyb206IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pg0KPj4gUmVjZW50bHkgd2UgaGFkIGEgYnVn
IHJlcG9ydCBhYm91dCBhIGtlcm5lbCBjcmFzaCB0aGF0IGhhcHBlbmVkIHdoZW4gdGhlDQo+PiB1
c2VyIHdhcyBjb252ZXJ0aW5nIGEgZmlsZXN5c3RlbSB0byB1c2UgUkFJRDEgZm9yIG1ldGFkYXRh
LCBidXQgZm9yIHNvbWUNCj4+IHJlYXNvbiB0aGUgZGV2aWNlJ3Mgd3JpdGUgcG9pbnRlcnMgZ290
IG91dCBvZiBzeW5jLg0KPj4NCj4+IFRlc3QgdGhpcyBzY2VuYXJpbyBieSBtYW51YWxseSBpbmpl
Y3RpbmcgZGUtc3luY2hyb25pemVkIHdyaXRlIHBvaW50ZXINCj4+IHBvc2l0aW9ucyBhbmQgdGhl
biBydW5uaW5nIGNvbnZlcnNpb24gdG8gYSBtZXRhZGF0YSBSQUlEMSBmaWxlc3lzdGVtLg0KPj4N
Cj4+IEluIHRoZSB0ZXN0Y2FzZSBhbHNvIHJlcGFpciB0aGUgYnJva2VuIGZpbGVzeXN0ZW0gYW5k
IGNoZWNrIGlmIGJvdGggc3lzdGVtDQo+PiBhbmQgbWV0YWRhdGEgYmxvY2sgZ3JvdXBzIGFyZSBi
YWNrIHRvIHRoZSBkZWZhdWx0ICdEVVAnIHByb2ZpbGUNCj4+IGFmdGVyd2FyZHMuDQo+Pg0KPj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYnRyZnMvQ0FCX2I0c0JoRGUzdHNj
ej1kdVZ5aGM5aE5FK2d1PUI4Q3JnTE8xNTJ1TXlhblI4QkVBQG1haWwuZ21haWwuY29tLw0KPj4g
U2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2Rj
LmNvbT4NCj4gDQo+IA0KPiBsb29rcyBnb29kLg0KPiANCj4gICAgICBSZXZpZXdlZC1ieTogQW5h
bmQgSmFpbiA8YW5hbmQuamFpbkBvcmFjbGUuY29tPg0KPiANCj4gYWRkZWQgdG8gZm9yLW5leHQu
DQoNClRoYW5rcywgYnV0IHRoZSBrZXJuZWwgZml4IGZvciB0aGlzIGlzbid0IG1lcmdlZCB5ZXQu
IFNvIHJ1bm5pbmcgdGhpcyANCnRlc3RjYXNlIHdpbGwgY3Jhc2gga2VybmVsJ3Mgd2l0aCB6b25l
ZCBidHJmcy4NCg==

