Return-Path: <linux-btrfs+bounces-7061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B994CA75
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 08:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A590AB21E09
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 06:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98B816D33C;
	Fri,  9 Aug 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b="AqmwyYTw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021133.outbound.protection.outlook.com [40.107.160.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED516D312
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184820; cv=fail; b=s4PrtI/3aWJQdeVijX+FeuKf72Wr3TNEi3tKCydhEf8/Oc6HHQv0No3ZHzV0Yyj0cq5I6gHqyYxFQfIzLzqdstBUo0fwNEUrn+bL/u10hV+I14zCST3gtTVnu38VpWb8WeDvQuxlQEQUl9zGlhQTpKb66dN5mzSTNBt3kciZ3Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184820; c=relaxed/simple;
	bh=f1xoYJDQGAo8qcks41cjxwY5bpCHq2WxnoApuiQns2Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WTg2UC2NrUhAcvPCa+uW7gKSFAn28Bh8l/0lcbObnT7st70vYdrnZceX9hnn5eMN744DAIkYL4HwdgiJCvydo12D4vwniPDEKIbbh1PjBEvAUtRnGEgYcx6QELs35Vz/LrTucR12Qtme2irLXTV1u8IPA01actmKi3aJdM6TPqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr; spf=pass smtp.mailfrom=ensta-paris.fr; dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b=AqmwyYTw; arc=fail smtp.client-ip=40.107.160.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ensta-paris.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vL1qs+3xhjbAMI7TRMYFjhOiNmjV0Gjmbyvj5rhgXdL1XsRnrklopncXG2AX9xivMtqnN+HXhQt4lkGJFuSLWkNS237lp4TRAW1TPkLIE5umsijg+Ql0fNl7P5S32isHg9axBXQ4J3D+4pHIPu477heW7ZHC6OPIikkr2ZBrTP1/MDxVP7+HhnbmZXTZE18lhwYQj9kaX6PgE96qbTjLfbc43rVRolv6T+5cjA8v+X7naYa/GxG4j0AaYSBSnBeniclv1VK+k+6y2f49HOQGS9PwP5MeX/MwMNEcdW2V/cDsYd7fnukRsgjoocOuuLJpM+cBm+IOYPkqjJ7YTuciBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nypw/nHUGUIMPHucQU/xChUfH7MwmwHwMYVqNpofiqk=;
 b=dID+7R/p2aUz/iXdeDAVAprojNNKwuC2Wp/ugNw+vOjGV+heJ9YhOld3jwr5hdIK/YW+va6dSZPOsPCrqMauFRp5oLatwk7TO3iEreOv/ayxc8kVB65Ga9eQtHTea5pPNnH3IYnAi+Sx/CuQSOjQiEBkzU5KNaPKODNNanV0O6/6o4aLB3RiQqAGwAtrViApjtHc/oEKP16jw+Hpp6a0FvbQZpxvx+jkgtQj5W5c2Me4BbRKb+XSvQomklaKhNORF7cWAtH8rOd9RpflXj0S29bL4G+B/hxbR306IlpvIZjOMMkInx1Z8usbi1dQ6X8PyM7eDEomOiLHxVmqDnHr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ensta-paris.fr; dmarc=pass action=none
 header.from=ensta-paris.fr; dkim=pass header.d=ensta-paris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enstafr.onmicrosoft.com; s=selector1-enstafr-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nypw/nHUGUIMPHucQU/xChUfH7MwmwHwMYVqNpofiqk=;
 b=AqmwyYTwnyFjuXWqTpkdqwBiFBvTSabQXpQhJf4+GhiCfOZH341O2aEyymtQvPgsU8ghMYyO17h/uD6cXdjmECPWCYAJdVw8U6Xwd7rJsgbarAALTwzSn3QlM28gYW6AKzoynLPJP4+hrBykzj3o/GFeJX+cjs4U1q+IAqRaI7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ensta-paris.fr;
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::10)
 by MRZP264MB2633.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 06:26:54 +0000
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8]) by PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 06:26:54 +0000
Message-ID: <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
Date: Fri, 9 Aug 2024 08:26:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
Content-Language: en-US
From: Andre KALOUGUINE <andre.kalouguine@ensta-paris.fr>
In-Reply-To: <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0235.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238::16) To PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1b1::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR1P264MB2232:EE_|MRZP264MB2633:EE_
X-MS-Office365-Filtering-Correlation-Id: 302a8a8b-f44b-4d30-9235-08dcb83c42e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|41320700013|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWtsamVOcXRHVUYrS2Y3SE1UaHVBTy9QbTIvSm1iWmpTWjc4OVhYdXJ0VkRF?=
 =?utf-8?B?c1JQai8vV1ZaUXJEeUV1LzltMlBTYTNqZGZxeENqTkMvRWRVVlF3U2c4WHow?=
 =?utf-8?B?RDlaVzNHSm5qKzZ6ZVB1c3NPWnpLWmpOQmM4ZitOdEFlTkI4RjFaTU9YdlZE?=
 =?utf-8?B?Mm4xRWhyWGc4bUJmTTQwbHl1WjFaQm5oSWJ2RlFHaFI4aTYrd2JhQjc2cnQ1?=
 =?utf-8?B?ZjJpUis5c3Yyc0ptbWpnZExreGhxSENCY1NSVTUyUkZoZjNwS2VYdDFxa29C?=
 =?utf-8?B?SDd5L1kySzhDa2pVT3VjSUtEVkhCdXJVYjZTQ1hGVjlpM3N1S1FxK3ozM29Z?=
 =?utf-8?B?bkFsaFladk8xTHdJMzQ1SlA0enF5eXE1QUpVMjluSHFzdFJ4VDB6VjdyZmtY?=
 =?utf-8?B?SEc1K2tIZC9iMmdVTm9EUEhIZThFUjR0REZ4bEtGNXZ1Z3hRaFJVVkRXR1BE?=
 =?utf-8?B?Y2xVWVJLZVlEU0JmeUI2bFpBV211UCtXRjR3ODlvVFNxMmQ2dW53Nnp3Kzds?=
 =?utf-8?B?a2RmTDdxZ0RFN2Fja2pTaS9LUVlBcmovTWNrbnkrWUNVZWtaUE4vN01oVzd6?=
 =?utf-8?B?dzNMOVhjdmNJN1Rsc2IwQjUvdmZJZS8zMXljUXNWcmxCMlpUNXVRWldxSHZn?=
 =?utf-8?B?UmFMWUhXY0JFTklCbDFIbUJ0NzRpTStVck1ZbmkvLy9RS2F6NTBDZVA1NmFj?=
 =?utf-8?B?RVV3VUJoMm9rK0kzQW9qVHU2d0RaUmU2b1dJdEQ5RmlDeWRCTjhreEErSHFI?=
 =?utf-8?B?UTUvanFNdFd6VGE4aXFFRjg0SWhvcXpzNzJPSjRiY0JlN05NYWdycFVMNzdh?=
 =?utf-8?B?dTdBdE9SVWE4RG1HTWphVEx3RUtBcnBJMDBmK2JqSWVJS2drUUV2VnY2dUNz?=
 =?utf-8?B?MUZTVDBnSTErQ1FXbEZYcW5nQ1hRcUdhZCs0S0pkQTlGRVBhaFlhcXVPdDlJ?=
 =?utf-8?B?OGJGVFFRaW5iL1IvcGJpQW5yckJPR3ZuZUhWTUdTTllOTXBRT0VrZUJ5ajFx?=
 =?utf-8?B?SlBNWlBTZk1xZzdLREZETU56NERYUGxKZmFlcHpXanVyMUZrVk0wREpUN1dw?=
 =?utf-8?B?dGdoOU4zbnR6ZUplMjZINjZwS2tqMStpdTY1cG9ISnBXUC90Z3l4S2h6SkhK?=
 =?utf-8?B?YUlvVVFDSTg0UHVRcUN1dDdJaURWdEJ2UmFLQVpVRHJESTByUXVWRnY0dGdZ?=
 =?utf-8?B?Y2NtUnpnRnpjMktiR0lmS3RqL0ZGR21MZjVvWVRpZ3NQZ3Bob1BNUk00bTYz?=
 =?utf-8?B?RnBqMW1BYjl6M0FFKzg0ZFNiNWhWSG9rY0ZTbkRRczJSbW1SRlp3YXpUeHhC?=
 =?utf-8?B?K0hXajNUNnprUTkxbzRFemhKYkx2M0I5UHhzQlR0L2F3aDhNWXZCRFRPZ2l3?=
 =?utf-8?B?ZzMveUJsRlJoS3l5SU9pc2ZNV1BNZ0RLd1djY0NzaVh0UVFyR1ltZmduNXBI?=
 =?utf-8?B?MWRLK3BxN2xPUjZ0Z0pQbk4wcFJUYnVNOHZNNGE3RllGY1phb2xXUTJRWXpi?=
 =?utf-8?B?N2Y3STA2cEc0ZnlXTkxrNDFDSDZoWDNDL1ZKYkQyYnlOM01ZdG1vT2xkcy82?=
 =?utf-8?B?K3FDQTJwQmZ0Q1gvQUw3cjNSNWNTMWYzYlpoTWxFZXhnZmZNSGVhSDBZNWFB?=
 =?utf-8?B?d0lkOTZnN3R4THJnbmFFQjBsYUZwakZYR0ZOTjVCKzRobjBOM212REdLemZV?=
 =?utf-8?B?ZXhxaENoZkhQTVRhOXVlMGM5YzVwOGhxUWFWUndRYS9YaElLTlhWd1ZSQ3ZL?=
 =?utf-8?B?QnIvZkVLb1ZoeEZXZVhwclpRVnQ1RmljTitFNy9GV05jaVdzV0VvSkxiWFY3?=
 =?utf-8?B?SkZ5YnA1aTJ2TVVxbFlMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(41320700013)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WElRK3h0YWpBOGg0NjV1NlYzb0U0NlJPSHNodzB0UWhOeFRrektmZWNkem9a?=
 =?utf-8?B?dWI4YjA1VjgydTN0VXBYeTZmdW16bGNoT3pVTSsweUxNOGk4S2tJWjdZd2hW?=
 =?utf-8?B?c2k2amovRDF2REI2TlFHdTA1ZmpqV1NJK2R4WlkrMitubTZRMjVOWGJhT1Vm?=
 =?utf-8?B?NmRPN21wSE13TkFIMDBtV2FlU3pxY0FnRXppd0ZDZzNDVWJ5WEtudUxoTExV?=
 =?utf-8?B?UmxMQUVDWlNObmtDaFl1UXk5TFZTa3NHVmdUT1pZQ2htNWN5aGozT1lXeU50?=
 =?utf-8?B?VG1DeGhTN2pWYVBPVmtUckNjbUk5WUdaa0R2K0tJT0V3YVhBUTRITnFxNmxR?=
 =?utf-8?B?ZGdyUHlxVHJpVUVwb0EyZlFlOThxdW91d0JrQlJUK0d2eUxXR1hSZUJOREcv?=
 =?utf-8?B?L1pCZmVaYjd4OC94elRzS1lMRXlCWnNhV3A0TDhYTTF1ZnFmSzFsR3cvT2JY?=
 =?utf-8?B?Q0VQRkN4STEvZmJKVHRlMFlDaWg0RzFNVWlnbCtQV25BRDBFSXBqZEoxVGMw?=
 =?utf-8?B?aGVnSWFFRmNCelBFa2ptci81L3BTR3BlSlVRWlVxemRJMjBUZFBmcnMzc1A0?=
 =?utf-8?B?cXJNamFBaTZBd0FtYkZzT0djemlHYm90b1NHOVZESTNPTDZ6RmVpRDRPRUNK?=
 =?utf-8?B?MjM4WldZaXVOOE15eUF0VWpzc3ZWTlN0L1h4eHhYM0ZBRlpzOGgycXBYNXY0?=
 =?utf-8?B?WW02dFlOc1czOTA1OGNtNldMOExoNFNNQ2psb2hxYjU2ZDNKVmJhTk9RUnl1?=
 =?utf-8?B?c2lLcURUaVhERWZHczdEUXZ1am11VGltZkxIVmQvNUo0ZGFkZ3M5dFJjTjdM?=
 =?utf-8?B?MTU2MFZKS0JZNWRFdkJnNHh1M1pqbGFXeERFYm9EdDc5c1htYlZvRnYwdXNu?=
 =?utf-8?B?NGJ5S0VrQTZNY3phSzk2ZmJKdXlsb1hlT2NlREhsL0tQMzVNSWF2ZDVMRHRC?=
 =?utf-8?B?VktwSm1NTkxIZnVub0FSdGp3WnlsSTRuWUplR3NXc1RDeGg3WEpXcXRSNUJJ?=
 =?utf-8?B?azFLQ2hNWkRGQXdxcXVIVzhaYmlaODN3dW9SWmt0QkRBWU4yMVpvNlhVSGM0?=
 =?utf-8?B?cEVGaVY2Vk5ZUTk3UUtCVGdZVVQ4akcrMzk4MUROSkovVWFoNEJDZlQwNm9B?=
 =?utf-8?B?MnNQS1E3ZkFJdUpuU0gzcGlsbVhJTDF6RXdVdEQ3SjBYNmxaVmRBTXdpdU1N?=
 =?utf-8?B?eVV2Q0RJanZuNVNKSDhtNjhnZlhkWHhMMVo2THAyT0grRVZ0eGYxZ0xqWlFG?=
 =?utf-8?B?dDk0WmhGSFIyb0dvVG5IcUIwQmtJWVFDNmxrditoVzhNSitMU1kzMmFCNURO?=
 =?utf-8?B?MUNkakl4bE4ydjRqSlpRTnFtb2pjcEdFWVRoRTNYcW45dDJhU09VVkpqM1Ax?=
 =?utf-8?B?QVRoUkdvKzVLSWJBTHdWaDkyQWRrOWJZSitHSjFBUHI2c3RmVEFDSTExWTg3?=
 =?utf-8?B?NG9Ra3J4MlpUTVpwK00vME1rVXdRUVRPT2dZRWgyVys1bnYyME4ySEg1V2s2?=
 =?utf-8?B?WTRIWlpnVkVnV21GdWNVYkhzK2xtOFlWa05lWFNsdG11d2VSQ0l4WEJpVHRH?=
 =?utf-8?B?dHpoRHVaZmNDcWJ5MTNCeTZNcXIzNm1Fa2RZSmxUM0tMVWxOU0V3MEVTM05M?=
 =?utf-8?B?Y0pENUp4Qi9HSUpMSVRpeUZvbkl2cWNDQmdmdmJoSnlZcXd3YXI1aWlYNy8y?=
 =?utf-8?B?NjJIeXIybVVGL2U2TU1NemVQMmNSc0RNOTErUGs3aHkwSkZMSzVmeWY3YUlK?=
 =?utf-8?B?OGlMZXpJeVBIcjluUlR3K3Ntdzg0RlBjeE1ia1c3S2UzTTVQNDJHbG5jYWZN?=
 =?utf-8?B?V1BHL3ByMXU1c3ZqVGwwTVpMVFBrQVVIUkswUWtsLzkxbXowRTMza21qWXRI?=
 =?utf-8?B?SXhkM3BBamZPclhNVWkyTTc5UFk3NUxnYXhRQUZld2picTFVQ0RwRHBRV09q?=
 =?utf-8?B?cXZVNE4zUTA3bFdpZlJqbHlvYm1pWjZHeDNKWHovZHNQUlF3bmgyc2NuWVU3?=
 =?utf-8?B?Rm83OEVndWhoZTVnb2N4Q0xuUDZ5M1cyUEFvZDlIRGpyOFp3ektJdUJRLzhi?=
 =?utf-8?B?dWd5Q0hTTGtmdlkvcGFnaDVaalZhUkhROUpsbVZvdVZYRmpSaVlyZG5vRzFS?=
 =?utf-8?B?MWhWYkhNZEtnSHlTNzlzZUZjTk9mYjluNjhJQmpIVnduU2hQelUyK1lXTUdS?=
 =?utf-8?B?VU1QdWtIZWxJRUNuV2VTTHdKN3hEdVZBN08xZG1FNHVsZmFqcjlGOTY0eWNw?=
 =?utf-8?Q?2z3cFUWWAGSW1qrLjzMsSW5XU1QGiVfRxFeufFohvM=3D?=
X-OriginatorOrg: ensta-paris.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 302a8a8b-f44b-4d30-9235-08dcb83c42e4
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:26:54.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f6c3f3f-c20f-4ade-b8c1-3e0fba16ec71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ByXrVZMYhcB1W9H3a6E5ifAHlmmQg/FO78S+COGzr60aVMKRFJ2VwfgsWxcMg4lioygRYYtpgqaec0n9ndUAOHHllPJDbY2yoaCJy9oB70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2633

On 8/9/24 1:23 AM, Qu Wenruo wrote:
> Then I guess you may want to disable discard, and move to fstrim 
> routine, just to be extra safe.
You mean to avoid such an issue in the future?
> So it's the corruption of a critical subvolume tree.
> I guess it's fs tree.
>
> Then it's pretty hard to salvage.
> "btrfs-restore" is your last chance.

I attempted that with the dry-run clause and it gave essentially the 
same error repeated 3 times (iirc it tried three supers). Does it make 
sense to attempt it for real (and is there a risk)? I located a suitable 
HDD on which I can start to dd the data later today so I'll be able to 
do it anyways, just wondering if there is chance it will work seeing as 
the dry run didn't.

Is there any sort of worst-case scenario data recovery tools (maybe 3rd 
party?) that does pattern-matching of the raw data or something? It's 
not like I need to recover videos or something, it's only a few text 
files with known names, locations and partially known content.

Thanks

Best regards,

Andre



