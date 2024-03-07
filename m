Return-Path: <linux-btrfs+bounces-3054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9F874937
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 09:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A632857C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48A63134;
	Thu,  7 Mar 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XDhhxN09";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PTHrGY3E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37051CD16;
	Thu,  7 Mar 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798713; cv=fail; b=m/45aJsidDnYtkWHCQMFGmuudumr4adkTbtkPnu/5cRknLe5YlYcPBMDYSqPQJpL4YwyvhTpfh41QmLneo/i3qXayENlURsANCj2zJ8hBhtCYUC9GwPL1wh0ey+JeXLODLi83fqhy1qxUb526//dNY3awZqwy2RHvhyiunwYYQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798713; c=relaxed/simple;
	bh=kjqDB59ChfxmkbAisE3wGnSjSWx7Dq2Uj58X2HneQhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s64CX69hPP4licTfkX2qqAP5EbLrYdPyGxaGe8qe8f+LDvjZRkN2JAIOYeHmobN8aG8du87YNeJuRfM7SzfxlTobN+CCXZ8gyZmCKhOhq7Wj18dTdUlQP7ePsPYuWHQ/ft0HLWGEOAeycoqFN/qnEmGhd4pHBsKUZP5XKroiNmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XDhhxN09; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PTHrGY3E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4270i4Qc031618;
	Thu, 7 Mar 2024 08:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HUjuRw4sL5cEn8Ati2IMCedYzZtOeBd1YPJOmYX3rsM=;
 b=XDhhxN09A81m4dbpjQSyYLN/+8i5FwcYjUMVOizoevpxGsBCzLCdB+SYxgKHHe3Vc6RY
 JtqhhmTmHHoSM+z1TfrZYmM8TT+bPVFOkWdppvG5AFeSprl4EdNXIO8JyPECpLmhlZC0
 bCaxBAYU9Xs7LzJ1DHWWBjezM2i1H99NRAdd/iJjK5r/azBm+W/mbnCbJN1lceS82uC1
 cCe50zOXdY+Xgw5HqM6ewy64S7oBBF2KnHZwz0lIApDyaH5hyTpYsVDjpGSKdCCHW4DZ
 b0OOUl/FchTV3rcWeKMzTnUrrRtfHWmlriBc3ODVgu8g5+tLzme9aB4xsb7+hVDhD9i1 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1ck847-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 08:05:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4277bC1P013906;
	Thu, 7 Mar 2024 08:05:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjam55b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 08:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXHTdONnEcT9Lgus5hFPr1eHLKB2xO9yloQbwgWga3Usqyz9aoYyPnuBTL3DvHig/+7paEHd9YCXTpnR7/sYkwZo77WTvCB8wNvYdeeTDK/k/6IQN7Mc4HJ+n5L7NBMUsVRApliFqBaBDnj2H2jDgcCdgkkGON30Dn7WAO3C0xdhM5316Jzx5ngbcfOIyLur30Sd/IrpHAHlkUjPDuM7wU/WQIoGxS/6L3g06NG8HUdZyVBLupLh/xuLciIjks8uzuzet2GouX7rDRyo5OjpoVxkztw+ykqkpFyOMDA8+Cvcswu3EKe89g8VuP9etaExrGhfnh4v6iTMQTpPXaggxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUjuRw4sL5cEn8Ati2IMCedYzZtOeBd1YPJOmYX3rsM=;
 b=CQ1hVhgqlenKEA1DmMWLLS0xqilERuTjxOKEOxnTwFcj5ZkO1+K486rqQnlIzDeReKvlKczYhglWDvBViaEctLJ9KNQSpjyQSsLbfn/KOW9N+DIB7HTuF+5l6d71RS1RKEKp52JSzZWGi748ri4i8Nm7tocjhJ58qhOzQtgALGzeTJbuMsHCPfkSmeTc/cs8q7VDvZOxb/2oeqnVUXhnQNVMbZYpdKjELgak1lHIn7t05E5onnJ7WLdVoOpnM9wyRIx8icteSFi6RYUmjjC72syImONr9pkIccrXDWThN1Y+nhpJGw01Ur54lif7d4eBu3HqxIom+u9lTjpEWXSttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUjuRw4sL5cEn8Ati2IMCedYzZtOeBd1YPJOmYX3rsM=;
 b=PTHrGY3EYo5C2d+zVy1xvSgMYWOXn74gWLXzabmXjbvpwVORmqmqBypIQt6pUeZqWWkSBlPSfY02SZ8jBZffU2ZoVbK4zhfZ+vg+8FLhP+0KB0rGqKjTUEWpxNK8oKUAq3L/yy4KNIVcek2Jzux/Nwk0W7dv43lpZaD9LCNPGRo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7478.namprd10.prod.outlook.com (2603:10b6:8:166::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 08:05:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 08:05:01 +0000
Message-ID: <e31765bc-e151-4e0f-8d12-e5ccbc6d7d35@oracle.com>
Date: Thu, 7 Mar 2024 13:34:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] btrfs/012: adjust how we populate the fs to convert
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1709664047.git.dsterba@suse.com>
 <0b465808ecd272a04d5ea16383043b91afb6c2b0.1709664047.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0b465808ecd272a04d5ea16383043b91afb6c2b0.1709664047.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd890ca-8b8b-4fa1-f09c-08dc3e7d4980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RKG6dcBTUKhZsiUUCWV2jBXCTqpkExWxX00kmkgfjmq+JIKFWirk1D9Z8kElcYkc0A7JK99hoh14b+fobEEnHVC+eFDfMD9rPWmfuV6TFqi2HZQCAXJ+qDbz7o2nerb3WFdv5MhTpbjeAV89WoNereF2RgZzJ59zpj1CRJs0Tu6Id4rbsIRFHeLh/S0YMOAqHQY3/s+ITyJ9ZvGy1anzV5BjOm+Dj02hB2e3xfQFUvGVzK7emj0GNPBXUq7E/ziA6VHZBYQCfkAhJftrvpdTV9nRzqyPh56/r7S15hVBQNenUGoUVErceAB3CsMfBrvcwR88FB/TIPXwD0xaKRRpea3yHTnOlvJp9wpnHXdQXWqaVhcwSkoBGWSHgplhm48ybKBvsj1MW8TxbiX9W92kB7Lv+fhvsUdZKDGxAF4gHZeaQwZcr7m5RRJk4gk5g1N41OAtMYmfbDzX0LR6hj2qGpbJ5COEABdYFpdMM3xWdVtjXxuxfe5CjLVQmW6hTXcdYjkrr+3iRfUhUvevH8bS/WG6Ew56wRsZxi83TiW7ttzentaDtco53Mtu9jTfyqJwGQgOE1fYkRAJXQ7tIr0JKtqiQbegUjfWckZi9iBnrPbKzALaW6Uwit7WEZZ2IV1swPcHwc62EJ7yD4EyDLp8oQr4OdSdcTGm0LxYyzXAkTQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXlmNk5XdDNDZkxhOStUbjU0QnFBR2VjOTRQQ1BwK0FodVY3a0s0enh2eG5w?=
 =?utf-8?B?UzVaUkJSd2wrc0dWVkVYNlg1NU5Vb2MwZFcvSGwvcXZ5VTM1bytjWTRjaUs5?=
 =?utf-8?B?NVk5UzdqQmg2c0ZvQ01maHJQc3BZaThpdlhEazlXbVJtajNLbUhPbVo4UkJx?=
 =?utf-8?B?WlFTeDJoTHZQSk5neDNRVThGMC9aR3l1b25mQVFjdUpxaE5BWnJWeFU0Rmpr?=
 =?utf-8?B?eUQwTHdETzhzS3JsZEUyOW9mclVKelFOc0ptbWphSGQxSGF4UnJYL200NkN0?=
 =?utf-8?B?dXZmUERzaU1pRkZjK0dDTUc0a0s2NVNJNW5WM1hBYzNJMXJxN2MwTFE3Smtr?=
 =?utf-8?B?RW1WdzkzZGowOWg0UGpQbVJGOWNpU1pwZnlITGhicXlON1RZbGVvZGVhU3Fh?=
 =?utf-8?B?bTdEMkQxRWRkNjBjRzhIME1tVEVsV1lHT0JsM3kwY0luSjE4Qk0yTzBpTm9L?=
 =?utf-8?B?bGZteFl4TnFIaXRrVjQ0WFZjcUtodUptU0hXdDhCUlVZNDFWRTVrV3VQSDdl?=
 =?utf-8?B?VFR0YzJRcmxhV1ZyM3M1UHp4eWRUanYvNGVSM1E5cVgyY3BJTDZRZElBSFZ5?=
 =?utf-8?B?SnVzemRwTlBadzhEZ20xUHU0TzFRRzhKZ2hqYlJranIyeW40QXpwNkVEeDZM?=
 =?utf-8?B?MW5CTGhXMlhhcnB2QnBDM2N3N3phWjV6VGVPMWNGNERwVVR3Z0tISXZ0elcz?=
 =?utf-8?B?Ry94TlJWaWZxZzVGcFd0TXBGZUxwdkRmUStuSHJkMnB2ZkFBdGJJOVNyVXY2?=
 =?utf-8?B?YllmMkJGVTRmSWdXbEpDSlhIUG1ZUzlhUkNLd1lWZE5XU2Z3UURsZ3NWdFRy?=
 =?utf-8?B?c3UrbGpKTHFMZnFxc29JVnhiSjgrbFRZeHBJODFtYTJtcUtiRDVJVGpZUldx?=
 =?utf-8?B?WXUvWmNad0tKSXVsbTQ4dVdvL0t1Y2JmYkR4NlhmbWozTmREVzhFV3FicHR2?=
 =?utf-8?B?dnArY0ZMdlByZzdra0pZR2QyaklXcEZtN2RBWkVtaTh1MGpHSVk5aFZEMytv?=
 =?utf-8?B?Vm8wNERVbWhUbmt0Y01XSTBlUisvVXYyRmIvTVErU1NzTWxSQmRtMHVLL1Bk?=
 =?utf-8?B?UGFvZW9YWTJENDkwd1ZWZGROc2lZdWpKc3ZEQ2UvYXI1bHVzbE1ZQ1lPTHFw?=
 =?utf-8?B?MXNoMjFndmp3WlFKNU0vc2dvcWxGbUhMTXVKYlFKU1pNT0lwN0VnRFRSblBS?=
 =?utf-8?B?WUVGV1AwQWl4djRDSmJGaDQ2bkJjQzA1ZnZkaHF1clNYWFEvaGFXVythRUsz?=
 =?utf-8?B?ZWZWYk5UWitOVldtcGpYZEE3Z1c1c0xrNW9rVVVWZUJtaU5pMitIaEZVMWxU?=
 =?utf-8?B?TWg0RUFmTkd3VHIyREVOenJtaG9rcHBxK3pyN0xYUERMd0hiMFRBU2JxcGFT?=
 =?utf-8?B?T1VsL29NY1hDL3F1NzNFT1B3OGRKNEl1UGhTMkgyZzJXeFpnc2Q0SVplOHZH?=
 =?utf-8?B?aTRLTC9oSzdiVGcrUU4zM21DR2ZuekJhYXNDZ2FLcHBuaHgwOXRTdmhHa2xs?=
 =?utf-8?B?ZU9yOHhZUVNUM1FEaGtYc3dxNzBadWNLdlRBME9IemEwZldKY3d4djBraU80?=
 =?utf-8?B?WVAwSjdSVndBQm1CWCttcDZ1blV2OUljajh6NUpOUUNMNmphKytYZTlSOEQz?=
 =?utf-8?B?ME5ZSDZQaCtkUXBGdEFLaUl6RkgzdHU1V1BtaWxvekVRbkI0N1FIWW5uS0M0?=
 =?utf-8?B?NzdTWndTUlFoWlJpTGZPYVVaMFRoRnF6Vm1Ocm10VmNTbi9XeVBjS2UwbVA2?=
 =?utf-8?B?b3hCdk9LRkI2MUZWcUVYZnZmQk9iUE9HejI4TDJFQ2V3dlBmMHhyYUREUTUy?=
 =?utf-8?B?enJzN3ZwVlYyY2FZZWZPL0NSYjZEU3lvdnpTT1hDZWh5ZG50dy9WRjlqRUtZ?=
 =?utf-8?B?RWFzVHFnRDNoUmh1OUdNOVNhcDV3OXZ0ejJsOVVvZDZQZlZkdU03QjdrcHlm?=
 =?utf-8?B?MkkvNWNwRElQQ1F3Z3ZsOEthNmdldlJmclEyYzJoMGVNNlNuOU5jcm9tVFll?=
 =?utf-8?B?UmJXb0laMXNSdVdUM0REZDFzV0liR29xemN5a1V3aFFDaEh3aE55b2F1UEJm?=
 =?utf-8?B?dUxQd2JzeEtBNk5YLzU0S1ZxYXZUMmF5NjI5dUhSc0RNcTNvOXpyeDhMNThC?=
 =?utf-8?B?bnorMkIrOG9jaFFtNnAzdzNPTEZKZGFOY0FoT1dDRmpQNHRjRGxVblZ5ZURa?=
 =?utf-8?Q?dr2r7JWyqs0ecaF338K6Z+kItpIz4vqSuqoEkxfFgPKq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	78KtZxfKNWOJE0ESSPLswpLw+2f6NRVd8bPEy+a78B4Ukmf2FWTGdT71fHrNUQqdHsJn3EsCE9Awit6V7cp91Oqc/lK/0Rs5l3+U77LP6YXZIrYY3dOF2iwTl59Y4NdVjkff+WlYvc75pG8hzs1qx2Mycmxz+pW+VzKMc7awngk6pVk6ofQZCXpSpl0fxxv2jD/0puNTj1bUq5CWHkxIzytqKgyUir9bm3GdDPo6LgJI7Dc5HIFmqc+rd2MUZIduG3kQ0yteugcV7CqCjrn2sfu6GEL+QKHp24Ac5JUWoIwsj+7G1ghNTUjaBTNeUWKRzxyv1LZbi+Kz2jJaq4iiFJU7K8VwqvA43iqmGwdt1lihDU3CU0tK2M4bEEGFKgZ2HCizV9c5yxR05Gx0twR9qxKC5dU1kD5HbQDB7zsnwoPuSgXD0f6iIFaMLqHfnv9tOtZERjnXUHtETxrXtOErMSMgQtfA6NvqUt1kPbLnDuNBzeKzgKpnfq2uoBmzfvDQwt0lUSvNYGBFGWucqHcrWyllbR9PmzEIBLiizpM/SvqKCZxV6InoAd1yp40uKwaT2rZ1Yvay32wjPQUWLvlgf/USCLUwzzLmhQzcfpYWcDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd890ca-8b8b-4fa1-f09c-08dc3e7d4980
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:05:01.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCLAhpQOfEruiokzN3RBYqGs+boneUqFP9lyVyS1St7KR68bomFNpjEgud1qo6yzd0zwMHM5eFNhFWuSraYzjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070057
X-Proofpoint-ORIG-GUID: X-cn79r3IyudPXGgU13w2hrAeew0n6xj
X-Proofpoint-GUID: X-cn79r3IyudPXGgU13w2hrAeew0n6xj

On 3/6/24 00:22, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> /lib/modules/$(uname -r)/ can have symlinks to the source tree where the
> kernel was built from, which can have all sorts of stuff, which will
> make the runtime for this test exceedingly long.  We're just trying to
> copy some data into our tree to test with, we don't need the entire
> devel tree of whatever we're doing.  Additionally VM's that aren't built
> with modules will fail this test.
> 
> Update the test to use /etc, which will always exist.  Additionally use
> timeout just in case there's large files or some other shenanigans so
> the test doesn't run forever copying large amounts of files.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   tests/btrfs/012 | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index d9faf81ce1ad8e..7bc0c3ce59d28f 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -33,6 +33,8 @@ _require_non_zoned_device "${SCRATCH_DEV}"
>   _require_loop
>   _require_extra_fs ext4
>   
> +SOURCE_DIR=/etc
> +BASENAME=$(basename $SOURCE_DIR)
>   BLOCK_SIZE=`_get_block_size $TEST_DIR`
>   
>   # Create & populate an ext4 filesystem
> @@ -41,9 +43,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>   # Manual mount so we don't use -t btrfs or selinux context
>   mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>   
> -_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
> +_require_fs_space $SCRATCH_MNT $(du -s $SOURCE_DIR | ${AWK_PROG} '{print $1}')
>   
> -cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
> +timeout 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT

TIMEOUT_PROG

>   _scratch_unmount
>   
>   # Convert it to btrfs, mount it, verify the data
> @@ -51,7 +53,7 @@ $BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
>   	_fail "btrfs-convert failed"
>   _try_scratch_mount || _fail "Could not mount new btrfs fs"
>   # (Ignore the symlinks which may be broken/nonexistent)
> -diff -r /lib/modules/`uname -r`/ $SCRATCH_MNT/`uname -r`/ 2>&1 | grep -vw "source\|build"
> +diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
>   
>   # Old ext4 image file should exist & be consistent
>   $E2FSCK_PROG -fn $SCRATCH_MNT/ext2_saved/image >> $seqres.full 2>&1 || \
> @@ -62,12 +64,12 @@ mkdir -p $SCRATCH_MNT/mnt
>   mount -o loop $SCRATCH_MNT/ext2_saved/image $SCRATCH_MNT/mnt || \
>   	_fail "could not loop mount saved ext4 image"
>   # Ignore the symlinks which may be broken/nonexistent
> -diff -r /lib/modules/`uname -r`/ $SCRATCH_MNT/mnt/`uname -r`/ 2>&1 | grep -vw "source\|build"
> +diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/mnt/$BASENAME/ 2>&1
>   umount $SCRATCH_MNT/mnt
>   
>   # Now put some fresh data on the btrfs fs
>   mkdir -p $SCRATCH_MNT/new
> -cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
> +timeout 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT/new
>   

TIMEOUT_PROG

looks good.

Added for the pr.




>   _scratch_unmount
>   
> @@ -82,7 +84,7 @@ $E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || \
>   # Mount the un-converted ext4 device & check the contents
>   mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>   # (Ignore the symlinks which may be broken/nonexistent)
> -diff -r /lib/modules/`uname -r`/ $SCRATCH_MNT/`uname -r`/ 2>&1 | grep -vw "source\|build"
> +diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
>   
>   _scratch_unmount
>   


