Return-Path: <linux-btrfs+bounces-3056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CF874A16
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 09:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F221C22612
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774CD82D70;
	Thu,  7 Mar 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U0FsLD+f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JfQ71Fpm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7A63405
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801270; cv=fail; b=IzxQQkdodqIgm3xK5slMK3mpOXl+vDOYW1phzRvD8bdyTzyJbl5SaLSgnoxm6s9q3ucVzmIwbsxaCemtWDz1hdmOw/ajnSPiGI5Au9aVsv28ZIwsVMeTDG3NYfHkDCqkjlgLnHBifeOTk7jgOgNAufIQxCuKwKZaJqZFqZX1PjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801270; c=relaxed/simple;
	bh=feB5P/I8NkVRNAng24zEXc8BPClqumEOtNBH9HIm07A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gUDj0xi/gP5DL6HfxF/NE1Qt9Cq3m2Vv3uOKs2+qKYgCzVeSAl/u1ZoVcIi7xoLR3V8t4ue3tT9FJhwkQZlCBCwQ6IKtVCzNZKy3K6a6ChZnjcKjiWKTdDutRnuIykM9fFSKXC7hycdUtwV/w9luBKujKSIBF0xp2ispSkWJunE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U0FsLD+f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JfQ71Fpm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42783R3l008182;
	Thu, 7 Mar 2024 08:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Bvf8vMofWTKW0RLr4oRO+AfBZEO2XXo7qWGyt3HtkuM=;
 b=U0FsLD+fcjcYLSVl+UC2scfRHCfsjkSFNrmngrLxD2Eo+hCT4mOzwJgTZ63A3+1FGf3g
 gIqJzJIpk6v2tEspyNwmm6JZqn2XQXjPMVvkyd5D9h0lLfomBtylsRlgFn1PnBePETeX
 gBj03KG1dthJZ00UYOInHgkP4CPQ/5Th5VPd8tvpjfZ8lGbJdVRfGbtbZotF7rIUKiPT
 8DJuahki+Adcf/dwMgtJTD/c8KEqlT87QO0wGA4zw33M3lVSSmDEktp9TbBkt9WPV8Ex
 6Pe0nJDCatKnfwtddja+NzpEwiMNqQuqjbA1TGp3/jTzSAIXzjmWReAv9oESjiPWzgc1 Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnv3cjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 08:47:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4277caRG016033;
	Thu, 7 Mar 2024 08:47:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjax4qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 08:47:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb7cA+xNO5gGAyXGixYkfvwVUHweEDdeiyBM5bP7mFMMXsqujzc/SjII/2j8utV7V2ZlNbxKbUm25Sn+e49TkdX5nmSDtQcCRWsVlEAyMzknC1gtzuxHDkV0tfKMVBqwDCQIH4ZWK6gZXVmr/Hm4pEUEyB94OVr/DEsRKCS3ss/+Uo3hWvWHJZvfuXoCAC30apoL92Wezp2APamIz7wmXyg0NdM7Jy3neEK4U48hEwDeJFziKUkjel4XPsu23+CTz1Y5t7vTL78OYv1yGU31XA9OX2fS9ygvgLoBpTqBXDgOqJjYbnvDFPGNau5nRxxP1Z4AX3pNccyHnCLEzG1/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvf8vMofWTKW0RLr4oRO+AfBZEO2XXo7qWGyt3HtkuM=;
 b=MH4WifdyXFQVFdnSp64wEAvpRFQqWbKgYPgaDiR9nBW+ZJRXOKlmX9WypehxFizts15zsCJg7Jv4TT+FpDDCM4i6+S+XETELhX+a3uxGYOFz2XdIs9M5ybUmBqfTIGqHHd+BB0pIrqo+3VBQCumG9Z38kdcMmsfiSEi6m8aJ4cOWIf2xoSySgpCUKyB5hvbBUdibHIrl2JXG5h88tztONNAV1A7muGfxxQsaTYfj/zDxPVyvd0Avbp7QpYf8nyRs/Dc8+r3y0Qa7SToa5/Rkw9EvDw/zP53q8sVqKXHWKUcoTCMtHcNgxYojS3nYWsvk/5ZxVdOXMjp6BimtGv/Gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvf8vMofWTKW0RLr4oRO+AfBZEO2XXo7qWGyt3HtkuM=;
 b=JfQ71FpmcSchGWvWaBqg3mXChQVp0W2zsOeBAI/Rq9NRuEWQyXuxdxAawnPUFXVgRIpBZyZD55BYu+saqU0o4FlUiepF+i9nhCQ3R5TAXCkjPCOc03UYu61K5gW3NXFIARp9Bops77swkHQaz1WwgZegOZfzbG+9NO06ABM1sA8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6995.namprd10.prod.outlook.com (2603:10b6:8:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 08:47:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 08:47:38 +0000
Message-ID: <4118de16-dfb8-4ed4-852d-abbd4c7581ab@oracle.com>
Date: Thu, 7 Mar 2024 14:17:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RFC] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: Alex Romosan <aromosan@gmail.com>
Cc: linux-btrfs@vger.kernel.org, CHECK_1234543212345@protonmail.com,
        David Sterba <dsterba@suse.com>
References: <e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com>
 <CAKLYge+wer9ij5vfoJ5ct8Zy8OqHuh7vKDmn4S0vCVF05mzOxQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAKLYge+wer9ij5vfoJ5ct8Zy8OqHuh7vKDmn4S0vCVF05mzOxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f0716d-262f-4546-3acc-08dc3e833de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s22BMA+E8s3hbhmYAcfVpMUWxSyDeT9Us45RojUEYjbK1ce5aWj352mOVxpChB9I4KmhWra8ZL8jtLtpdgBdMkPq28FIzL7XyaAJNbTX/Rtk4aYonSiUDCAukjZg774IRoV/J5l+PIhM9gckJ9FM3jVuAk7naoqH0jw4xYyrCa1ohnH66n2eMf2+BzH1XkukdpTH6fVbv+7nqBbCrB3D8VeTY/rT1ZvQwCl422FLPYL9VqVUXJXfpYCO3+1ATEv+flPD4OR73TjoA0P9CEfE63p8UUOaCva0DuND15Kmdu+H8zfe+K5egMymWOl5hnjBJmXdQtci8ku4siZaQaWoP4l5y6z9hgyCxmUd2JffpHhiU/hBCQNgY75/gpsGf+Z2g+WbcpJojPapNYU20SGyL1eO/mO0D+OBuLo3N9FZieiW1QGLprkRGSYWbWhQyS7WyHZpIALl+ivG+mNG5zWMBeHe0Shq8jFq74RRiH3kKxeRJ3+xqcx3ihT9r7bAPM/4DeCRC2XET045GyDRljIA+XKdPMFOMbGQRw00HB6hjNbT07+LgUFfk0OPn2ckLo535qGZ21fED+JjjMKfxZMU0rVIwDySZxvjtQp6fEZrAqx9+sstQ5YXgJE7oa5Fhr8K
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nm9KSDZQUXEwSkxxYmVjVkZkNUJaNDVJRTVuamxpcXRLQzlSemtZVFRvNDY2?=
 =?utf-8?B?QUx1WFlXdE9xU0MwbjJ5MTh4UTl0SEsySGg0dkxwR3dsKzJWOUt6M2xGbnRN?=
 =?utf-8?B?Y0FzRExEQnl6S0FpY3l0bjJWUWxaREp3TVB1d1JTVFpWdytZekhTUnlkQ08w?=
 =?utf-8?B?MDJuQXcrQjF1VUNpSmU1WFlYNmpFSjJDRmRoUFMraTJGUTRGMGRuZmM3SUFM?=
 =?utf-8?B?emZUSmtmdUxQbUIwSjFPandXTEJZa3FPamJaN3E5bnhRVHh3VnhmWnhlRVZZ?=
 =?utf-8?B?djAvN0NQMUE3c2I1Y1Znam4wTFNNbUpjSmkxQkd0a2lKUWJaZmxtT0Z1bmVz?=
 =?utf-8?B?Ui9NWXRwQVlaK0ZXMkVhbmlmNURkNU9oNk9oVkkxb0ZBc1dkd3orbUxIRTlk?=
 =?utf-8?B?ODl3dDE3MEQ4K2g5dVVYUXN3WTZOZ1NobFZZUXhqZ2tXdFdqbnhWektVLyts?=
 =?utf-8?B?R2RqM3ZoT1dTdnBvRFZiVUJBcjZ5VzNNNjdmK3QyZWs3cE83Q3JTeXEraW9t?=
 =?utf-8?B?KzN3Zmcxb1d5dWY2dkpPUkp4dWg3a1BOaUs0V0ZLZnpMbURvSHBNOUxTRGp0?=
 =?utf-8?B?UmZhVldPWG16V1R3OE4ybmJaZW9qNFpXaDRTazdDSlVUZFZOdUtPcmFCcTNT?=
 =?utf-8?B?cSs2ekN3QmhocnNuZmdmeS9WcThqamQ0ZDVXVWVoVjV3WCtrR3FsNXRFemps?=
 =?utf-8?B?dzB2TjF4Q3poK2NYT094VE1MUG5ZZXo4QzAzYythRkJYSDFRM1MxaG9PQ2Na?=
 =?utf-8?B?ZmFvcWRGUlF1ZXpyaTMrUWtieUtqNUlHbFoxcEtKWFdHTkl4Zm52Q21wMjB5?=
 =?utf-8?B?VVdhNW9IRUtvZjEzU24rbG5ZYWxyZitEbzE5VmJ0dEN2RnBsREJGdnp6RVBo?=
 =?utf-8?B?cmJWL2FWU0c1ZW1VSVRwUjZ4TEU5WmFmZ29EOXlTN2UvUDQxLzFEWkhzZ3dy?=
 =?utf-8?B?Wk9UYlVQdzZCNEJ5ellhcWhCMXVCTnFXWWt4QVdTSHZ1SXVJdHgyNTQ4YjQ2?=
 =?utf-8?B?cnpYVWMwc2s4Zzc0VEg4K1RDMFlOTzNqeVlPMTVCU1pmN1IrS0tHbllZaDQv?=
 =?utf-8?B?czkxYnUvMGtIZ0hlbFpDL1V0YUhQLzUybTFBNDcwMmM0c09qbVJwOWRDa254?=
 =?utf-8?B?WTBiT3ZMTmVwMWJ1cWthSG5MMGx3Q3VpSEh1TzhZNFNTY0dhdXBYNkREL2pR?=
 =?utf-8?B?NE9xZHdrVkp0ZmdQVm9lMGtJbEJrYlNhd3Z0SExZT3dKdXRVL0hUU0UwY0hQ?=
 =?utf-8?B?SmhqMmNXQWU1amc2eDJJSnEvWmI5WXR4TDNIdHBlMkIyd3AzdUI4NWRWb2x0?=
 =?utf-8?B?VFlvbFBIczRMYituSmhwSy83aVpjYnJiZFpGQ0FQWTRYZTZoWm8rcVh4VlJW?=
 =?utf-8?B?TVFWSXJnZCtWM2IzMzMvMmgvRU5Ic1pmQTUrNjEvYWp5aWJKYk5paGprNFda?=
 =?utf-8?B?d1BwYmxIMGJmVEJqU0FjSSswQUN4NEFiWUtDb0QvZ1M3TFhBcVVvWk1vM0li?=
 =?utf-8?B?bUtDK05oeTZqV2hONlltU0NhRmptRFRvd3BFQVJlZ2FuK3lvSllpc1RMUEpN?=
 =?utf-8?B?M01EdS9iendWZlRRbmczeVkrUVo1cGt1Qy9xeUphUkNNUjlmOWVxcWdWcUJw?=
 =?utf-8?B?MnczcUswMzVNUml3cmJlQ3ZzVWVzbFcyY285bUpiWXNhUkZvZTJaSkZ5VnhB?=
 =?utf-8?B?bkxkelNROEI3UGdKZnZIeGlOaFY2UmhCa2tqdVlyeDExY2RWQ0FIODRYN20r?=
 =?utf-8?B?dE9VZUF0QXBxRGZwU2Y5a2prOGw1RXRBU2NjcHh1a2FDQ1EyYnJJOEgwV0FK?=
 =?utf-8?B?SlVyRFhwVWNrdVNHanBzdENYY3k4T1U4SEQvT0diVHNmVGFlVUVkNWNkNCtV?=
 =?utf-8?B?ZzlSM2lEV0h1SjUzdXZtM1JENzFJM1NXT3VsWWk2bHF1azEzdDV4ZEt5YTZD?=
 =?utf-8?B?RzAwQlRPKzdkS1UzL25ZbkxkVEtIcW9ILzcrQWF2c3lqeldmZ0NucGUvMTFl?=
 =?utf-8?B?RnE0dU50ajNCQ25oZVljQjhaTHdNZ3R0VUxqVzJpVzlpbHNxUEdpK091bklM?=
 =?utf-8?B?bTV4NThGVnhrN01GZ1BTT3BQSEphRENZNXlrMGUrQmRQQy9rZzk0REdHQ08y?=
 =?utf-8?B?U3JVVWhLN0ZZcnc1U3VJaDFubDFwSmk5eDd3Yk1ocmtqaFBRcHVaK1N6aUhu?=
 =?utf-8?Q?t5wx9hXGDKd5sPLpPythdACxDKe0ZS5A/9EmIx5JhmcN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jBIk0u3w8eF4U2WrlSpUtPm9JQd4ydOLMDkmXuFgi+KZ/2cGeiCDIrdU6uVcrcBIu9CZqL4cAG7ka1UFASt+zPpe6R2ZVijIm/bNXVbB6r1rH6hKZI9/fSU+59Hsug/HkyIyIi6WKiyRDQZFpEe7yB7ML1GFygkpSdrXdjC4Jb72nvq65wheGwuVg7zwNJjU76fCVrPiBOgSQyuWxU7rMEBTVf7boYz9aAcsKqRBvkJAcsOLyWdQek+G7K2KHb0n4v26636X227SG5A2HFrrEP0PyCGFaSHlmqbCTaxgZbFhFEeDu7MgYgco7GaVc9W94jS6V0B1qLMxRuOH3vXertaHYuqSYOj0iUdAOv1hwEob1AJq1uvA3S9gtlEpJTtzm3NxM8QZYcD+SFaQHNpYCcylFSpd8obdEq9A8pJZJLkdV9ed0Wv7ZztLo15gVxbxHrjgoFb7N+qnRFrlmOlJzFSM/asxbyGP7+Lgrhevi6Kn7PrprtpMcQwxTWiAbcUs2Mnv8gvU1D3RM1MXSbPbDUBkyvWYxOVJ995gRuVoZTobVK8zNvmRbsfluwXyIlVp2ScB820AJcWQ++1ZjTB2wrt31U6thzQALZ0w4KPMyAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f0716d-262f-4546-3acc-08dc3e833de6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:47:38.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gZw9vpaBrM3HDvqAgrLvtJNDVZ9RvJQp4PiWcq2yXWcR3TUy9Ht4gDanChLnR0HW9dzRA465OaMGBO3ySd6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070062
X-Proofpoint-ORIG-GUID: sYk2cZg7B4d9kdCfawMSr6Jei8Mtvt9j
X-Proofpoint-GUID: sYk2cZg7B4d9kdCfawMSr6Jei8Mtvt9j


Ah, it is based on the https://github.com/btrfs/linux.git for-next 
branch. I tried applying it again, and it works well.


On 3/7/24 14:06, Alex Romosan wrote:
> I tried to apply the patch against the latest linux git HEAD but it
> failed. Care to send an updated version? If not, I'll try to fix it
> myself. Thanks.
> 
> On Thu, Mar 7, 2024 at 5:14 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> There are reports that since version 6.7 update-grub fails to find the
>> device of the root on systems without initrd and on a single device.
>>
>> This looks like the device name changed in the output of
>> /proc/self/mountinfo:
>>
>> 6.5-rc5 working
>>
>>    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
>>
>> 6.7 not working:
>>
>>    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
>>
>> and "update-grub" shows this error:
>>
>>    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
>>
>> This looks like it's related to the device name, but grub-probe
>> recognizes the "/dev/root" path and tries to find the underlying device.
>> However there's a special case for some filesystems, for btrfs in
>> particular.
>>
>> The generic root device detection heuristic is not done and it all
>> relies on reading the device infos by a btrfs specific ioctl. This ioctl
>> returns the device name as it was saved at the time of device scan (in
>> this case it's /dev/root).
>>
>> The change in 6.7 for temp_fsid to allow several single device
>> filesystem to exist with the same fsid (and transparently generate a new
>> UUID at mount time) was to skip caching/registering such devices.
>>
>> This also skipped mounted device. One step of scanning is to check if
>> the device name hasn't changed, and if yes then update the cached value.
>>
>> This broke the grub-probe as it always read the device /dev/root and
>> couldn't find it in the system. A temporary workaround is to create a
>> symlink but this does not survive reboot.
>>
>> The right fix is to allow updating the device path of a mounted
>> filesystem even if this is a single device one.
>>
>> In the fix, check if the device's major:minor number matches with the
>> cached device. If they do, then we can allow the scan to happen so that
>> device_list_add() can take care of updating the device path. The file
>> descriptor remains unchanged.
>>
>> This does not affect the temp_fsid feature, the UUID of the mounted
>> filesystem remains the same and the matching is based on device major:minor
>> which is unique per mounted filesystem.
>>
>> This covers the path when the device (that exists for all mounted
>> devices) name changes, updating /dev/root to /dev/sdx. Any other single
>> device with filesystem and is not mounted is still skipped.
>>
>> Note that if a system is booted and initial mount is done on the
>> /dev/root device, this will be the cached name of the device. Only after
>> the command "btrfs device scan" it will change as it triggers the
>> rename.
>>
>> The fix was verified by users whose systems were affected.
>>
>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
>> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Tested-by: Alex Romosan <aromosan@gmail.com>
>> Tested-by: CHECK_1234543212345@protonmail.com
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> ---
>> v3:
>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
>> I need this patch verified by the bug filer.
>>
>> Changes in v3:
>> Verify if the device is opened/mounted to prevent skipping registration,
>> fixing the following fstests failures.
>>     ./check btrfs/14[6-9] btrfs/15[8-9]
>> Update comments.
>> Only reregister when devt matches but the path differs.
>>
>> v2:
>> https://lore.kernel.org/linux-btrfs/88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com/
>>
>>   fs/btrfs/volumes.c | 61 +++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 50 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e49935a54da0..ea71a2c14927 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1303,6 +1303,47 @@ int btrfs_forget_devices(dev_t devt)
>>          return ret;
>>   }
>>
>> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>> +                                   const char *path, dev_t devt,
>> +                                   bool mount_arg_dev)
>> +{
>> +       struct btrfs_fs_devices *fs_devices;
>> +
>> +       /*
>> +        * Do not skip device registration for mounted devices with matching
>> +        * maj:min but different paths. Booting without initrd relies on
>> +        * /dev/root initially, later replaced with the actual root device.
>> +        * A successful scan ensures update-grub selects the correct device.
>> +        */
>> +       list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> +               struct btrfs_device *device;
>> +
>> +               mutex_lock(&fs_devices->device_list_mutex);
>> +
>> +               if (!fs_devices->opened) {
>> +                       mutex_unlock(&fs_devices->device_list_mutex);
>> +                       continue;
>> +               }
>> +
>> +               list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +                       if ((device->devt == devt) &&
>> +                           strcmp(device->name->str, path)) {
>> +                               mutex_unlock(&fs_devices->device_list_mutex);
>> +
>> +                               /* Do not skip registration */
>> +                               return false;
>> +                       }
>> +               }
>> +               mutex_unlock(&fs_devices->device_list_mutex);
>> +       }
>> +
>> +       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>> +           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>   /*
>>    * Look for a btrfs signature on a device. This may be called out of the mount path
>>    * and we are not allowed to call set_blocksize during the scan. The superblock
>> @@ -1320,6 +1361,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>          struct btrfs_device *device = NULL;
>>          struct bdev_handle *bdev_handle;
>>          u64 bytenr, bytenr_orig;
>> +       dev_t devt = 0;
>>          int ret;
>>
>>          lockdep_assert_held(&uuid_mutex);
>> @@ -1359,19 +1401,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>                  goto error_bdev_put;
>>          }
>>
>> -       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>> -           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>> -               dev_t devt;
>> +       ret = lookup_bdev(path, &devt);
>> +       if (ret)
>> +               btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>> +                          path, ret);
>>
>> -               ret = lookup_bdev(path, &devt);
>> -               if (ret)
>> -                       btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>> -                                  path, ret);
>> -               else
>> +       if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev)) {
>> +               pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
>> +                         path, MAJOR(devt), MINOR(devt));
>> +               if (devt)
>>                          btrfs_free_stale_devices(devt, NULL);
>> -
>> -       pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
>> -                       path, MAJOR(devt), MINOR(devt));
>>                  device = NULL;
>>                  goto free_disk_super;
>>          }
>> --
>> 2.38.1
>>

