Return-Path: <linux-btrfs+bounces-2622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A586D85EF45
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 03:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DBC1F2324D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 02:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552910A19;
	Thu, 22 Feb 2024 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J3cN7lsP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XWuZ1a1H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1612E4A;
	Thu, 22 Feb 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569973; cv=fail; b=gp0rhod+mbpFCgp9j5tZmo097jFrguGN44uMLttNAkH6rVduAU3Mrv2RKQ5I5aTgbR46XjKZFXN+t/8BCupvCLPJUVfafzpElYTDhOexBSX7qfjhvuYXyUSawi7TxxJwlKPcpu2zcqzr6wQ8EurdD8bSHpcE107gYahaWCJ01T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569973; c=relaxed/simple;
	bh=/48j4SKG6/pDYRWBLSDenNoGrLZMrfypF0SVl2TntOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gASKn1lC2RUT87t/3MNO9d7RPzwjx7HIJ/QYz1D8uA+bcitERo6a5UrAER5ah5PNVwSUi9kgAQJLyGylgQJNWahSApmir1nkivTl7L4rwKqGwvXld7kOb9cuuaSIM5lIr8Qb4RoB47N7msbhuzSLRFQd2cxOc7Qq0KiLCJjC+gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J3cN7lsP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XWuZ1a1H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJWWAu012063;
	Thu, 22 Feb 2024 02:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=497jD1NOCsBIQv4a084xlyFpXRsG0ziUbVb+W380rHg=;
 b=J3cN7lsPs8UgfFV2qzdeCwNvBKiSilyXmscTWkJaGRv01F3QKfLBuMs2GD8VT4AKYrlE
 zg903pL61RCbce62C8KL925fHuAeRYKo5uNBjGEIAd7U+rqOot27UTJPN1Sw0Dz70+0q
 XlevTHaoiM++Puwiu6jWpz90BIoZQNggkJDRtp/s4kpdOwMM8s3oc3HAKYSi8bYpYycL
 6fYWXc2lGtoaeotHJO5dy550nBYYZ/wr4paJA4EY7NdVZmvcqqlja30mQFz/SkA9+KGf
 dpLFEXacnOzRT6z0zgyBJG7EgtLtdQHaY9XmZJieTJJ0HWx02DjlSYML3bKM8JU2JJG0 RA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu3c96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 02:45:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M2KQXu038067;
	Thu, 22 Feb 2024 02:45:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89ws05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 02:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmy1bMICCb8XAGl4fQblwndtOBb5pxIgDLHCR8jVI4lldZGDyamfR7/c82ROThYbqM3GODImNXFi4i8EElplLmmGEM5KNUPm2SaRSqaFwt7dVUX7rvgz0Al4ETg5k8DvRTlcmi+DG9legP9acs92oyAvxXfishERHEcCT1+pT6LB93VdhpnL+M7V0Wo8bGjL/yL8zolMEm6x2hxg7m5ck0g1HI/RX5cReTxWizrONBpP3Z4Z6ArKe5CZzCgFfloNhBY5hVAHr85iT2bBDsOrC+CP2MU1wiDXqSzkpdrRh9IWWom/AQeCg94JuEhpYD3bqV7nkU69cS6Hv1XGE4rLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=497jD1NOCsBIQv4a084xlyFpXRsG0ziUbVb+W380rHg=;
 b=XrWWYDYyW3JbpTfGpop7j2xu74LD6izYcnF2RKjJEzzdMt4KAhzMGm71nMdKcRjIOjTj3DPArD8kxNef04jrIGaAkoWstDLY34qLlWqskXB6zvMGqX0OSiYj1auPAl+I8lfY0ZTCdb6JDS5LEUdOtdwHqSU+01UQ33ZHSVq85YUje6L+pRmXvbL/5lDR1ElD99+YAEMxMwmRyygQ7XFEkLHvs7uQAn0RsgLBGPrvcSHmLYZYWVzndUgTFWp/I5cfYtotF73MVpkYJTLFxIs2KSbMPOrSSPEbIR0YZ8Awe8JqqE5vJKd11UP7VsfgUNvqH2NW+HQcUmKQ4Nfea+u28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=497jD1NOCsBIQv4a084xlyFpXRsG0ziUbVb+W380rHg=;
 b=XWuZ1a1Hy0ZgiEOey5JqXkiUdAL/XpG5XZus9orIRyeMrEbK/SOb+TsdPz6RVg3EIREOMs1A/2HidxBAQF+h+MbyvIvnTdMKyN7Ug3pM9RRFZLfOKlkmtCBfYjx4UPCmecyWocMmd8uMm4icvtf0YTLRPNjg2i6tiGptYweVGzc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6795.namprd10.prod.outlook.com (2603:10b6:208:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 02:45:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Thu, 22 Feb 2024
 02:45:53 +0000
Message-ID: <e86a3121-e54c-4975-bcea-507fec8642a8@oracle.com>
Date: Thu, 22 Feb 2024 08:15:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: dsterba@suse.cz
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, aromosan@gmail.com, bernd.feige@gmx.net,
        CHECK_1234543212345@protonmail.com, stable@vger.kernel.org
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
 <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
 <20240220181236.GF355@suse.cz>
 <bdaa5790-56d8-4490-9eab-9a47e4926661@oracle.com>
 <20240221214949.GL355@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240221214949.GL355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f19f30-8eb8-4374-5f15-08dc335062ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mrqQuo7994Htgi6Wpc5pSRkwwSxuU0QjCfd7dMe+2co+MH/KPSBzgR6XqQfYgKLmZpmr/oquBlCOtfp0mnoxQ7xi4Wv8TShNcEZCxkTZvwBUVPCFKIppa8Im/Ijpwnj5jfPKnIvkPBe4SV6Oofnt+8o9zcExhkmC9PwPG8n4wg5PnRr3RQA1E1I/4YC3ifQ63VrsSGoKq/V/EEvOTTkQNQQ0ELXiy+p0wiScoAQHo2eZ2l5ph7O2qZjAOJHG8IgMpQ4r/hWfM7TevlX8g6rmnU2emrZKnYc/0dDDYD+FYHG23XNoJfJi0G9eXfcSAVpvRRdr7+5M+eT5YUi4X5K7I47p7/Wa0Oi8fRET7EjTPmMY/g9DX5cCo8y8f+2YJySx6KhTRBFCiw0Ei6qU7jI4hYKSouOa5wBPNwQkBTSlx0uuMvi1u7iGirEHpsKsfx+INcJL+j4HxQ0s02X3SmObHvHK5iHhoxgU2NEqiC04neRaXdj4mFUM5YhrnV2UdcNk+tF4pAF1BW20uSCGT+YGsg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmVRckUrYnJmRHQzb1kxRzNSUTF1cERVakZQeUlPOGI4dDJUTi8wRkpYTGVy?=
 =?utf-8?B?c0kyS3NHWVdLT3BPYVZtTDZlWHVHVGl1R3FnUUdxajFSQWJPYndGc0QxckFC?=
 =?utf-8?B?b1c4SGM3MndLRWNieEoydnA3eXBOYlEwU2JQNm1hVnZta0ViZTIwQ3I2a2lO?=
 =?utf-8?B?d3dJTTJXVmlLR2JrdHR5MWhQYVlaYW12SkdPRWxvOWdORU9DMjdPWERZWlM0?=
 =?utf-8?B?VE0zWXNRQ2szWE9HUDVuT2ZndXgvRFdTNnBHYzNXVmFDRStNZVBHTEF0ang0?=
 =?utf-8?B?WFBEelhyZ05rcjNSRHZzek1jNEJISEM1cGhyRnV1bWU3czBFUWU1OVBkOUFq?=
 =?utf-8?B?d2dyU1JheElSdkhBZms0K3gvTXFIcXR3UXFQakFmbmdtaSsrUWlrdllNcWdQ?=
 =?utf-8?B?NEcvTEJyNXJ2aWQySFFPVG1sTkxtZ2twQ0VjdVM0ak12V2JCWWQrRVJFbDZR?=
 =?utf-8?B?eHF5Vzdreko4L2JIYkgvbjg2NGt1dzkrTHZFekJlM1k2T3lveGdGN1Z0d1dG?=
 =?utf-8?B?R3JtbVBUNGVtVU94ZU8vMGZJNnA1R3dEV3R4TldmOTZDZ0hWeHJMeHFtME1u?=
 =?utf-8?B?MzhXY3F3RzBqZCtGQUpGMDNCZU9pOU1za29QMEozdEZNMjhBRmRubUc0VUwx?=
 =?utf-8?B?OEpLM2ZvSDUwZm9KKzJEb2oyNVFMZ2NlS01FMWdOZWVaQTBxQnFtYW85VDJN?=
 =?utf-8?B?MDVJL3RERGdmZ09DaWw3aHZ5c2dFTC85SjV3QlFpRGdqaGxGdVNzaFd0S1k1?=
 =?utf-8?B?L0ZENkp6R2VxWDhhWlhEbHNzbXNGUUVmVHFDZjE2M0hINElzclJkWXV2QmN6?=
 =?utf-8?B?SG5aOEIrS0VENkJaSUdubGJXNVlsYmdxL0kyV05uWHprRHhkTFdQSU5EWmg1?=
 =?utf-8?B?bVIxZzNobXdsQi9sbGJ2YXprMEtzYXI5UVVhZ3l4dEdyd2V0NjcwUFV4UExP?=
 =?utf-8?B?SFFvTVBFSVExYXRXV0FVaXAvSnpLaEZBK29URlowMjE1dnlONTMvVFhjVmJs?=
 =?utf-8?B?SmVFVlo2TW80N1ZZKzlsQUV4MjdDQmhZcS9nVzh5czllSGxzc1g5QnNmcmRs?=
 =?utf-8?B?WFp5MHVqbVVtc0J1dUNCOFpLaldRaUl3Q3RYdEx3ZVVhUVRxWnBvT0pYb1gv?=
 =?utf-8?B?eXREbDlEd1JOWXpVOUorUXh6U0tDdXVzZjBLd1R0TC9iSHdrSGxhT3pZNjdM?=
 =?utf-8?B?STRyaEZ3UnZHZjRvdXJIc3VUVXZyUDFEWVlKKzYxb25HV2xRYkM5bE5MNG5k?=
 =?utf-8?B?K2FGZy9HVEEwQ3pMSjZMZHNGUGtaN2xBOUVhblJnRkNneldGYmN2MzZTbjlO?=
 =?utf-8?B?WHZLWHNGb0JOeDQ3QmJvN240dGxoRHlESWpVT0hvTHZZRXpHdElRWlVUbzZW?=
 =?utf-8?B?eE5qcTEzM1ljOXRaRVN5Wm1sUmZFWG16cGsxd2FQQWllclRFckx1SmMrNmt1?=
 =?utf-8?B?S2dBa2tKb3BnMUE0Y3lmNWc1YktVT3lWRmIrVElEQWlRUk9FWWpBL1IxaCth?=
 =?utf-8?B?VEsyV2cycHRKMlNKQ3RmWkZTU3RJR3NyV3A3UkJyNlNPQ3hUTTdGanRaZG84?=
 =?utf-8?B?bGh2bGYwTFR4ZStyNW0zd1hkWCs0Nlc3NVk3WllsM08xODA4RXNORW9EMjdn?=
 =?utf-8?B?dm9udmNaVGlKWGdkMnNxbTZ6YkRCNlg1bU41NUVpOWpncHFHRmMrTVkzcURm?=
 =?utf-8?B?aSt0Ynd5Wm5iRTVZMjdLUG1mQWRYd0JGOU56cDRKRkVoQnltcVVEcFBMR0Vn?=
 =?utf-8?B?SWk3Z2t4VUZCZTJXTkV3OHJTaFYxL2xiUGNKcWJJZXZDaTVKYml6QzUzclZk?=
 =?utf-8?B?NW1pb2lGZXk4Sk4rc3VXaVRSWDJWVC9yUXd3eXRYTVc2ZFN3OUMyRkIwWWl2?=
 =?utf-8?B?SHR2VzJJTmZ6KzhTTGg0dmM2VzJGMEgvcnR4R1ZwSFJzMERJcEd0V1lUR29L?=
 =?utf-8?B?MG1WZm9LVGZMT2ZkNTIreXdGb3FieU43K1NmNGlxTXBJRGdVWi9MaDFidmlo?=
 =?utf-8?B?YTFIbU1FS1FiU2xROCtoc1NCNnZPbEY0K3VlMTl5dGN2eGpTNVVkMUdFT3Qw?=
 =?utf-8?B?Yy9Kc1dGeTFMMU1JVUFKSm42NmlXR29DZU5MTDNBbG96aEFDTEczNVNSblhQ?=
 =?utf-8?B?TUhpV0N1WjNsd2hxWjNkc1BiZjNML3dYN01qNTh3ZkhaTSs1N1NLd1ZSeDRX?=
 =?utf-8?Q?XE195FUwamxwON5j23HKNJ/ZbCY/TUc8hnmhnjb/jhsK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KwWoJcCYsbJ1MYH/12IBXUiklrIM8FZF8t+cCckp+Xsm3Pn3xmmLh+JSL5ck5jjLDr8GKbD735bG4ARe9g9R3gzrb3R5iXUNj0o28rqXDZe9H6doeRHQeFxuvtKWVPgPUN/71M92lWAF4qRR63A7lRhbXnM5kVllbRzKa8y0YdlRx1n74HdT0vc8l+7/fCc9j6EwktC4Ep8yKe3H4wYz3ad3PQ/sqjP1dWSXwRj70y6asqp/J41pJsyBBnEOFqEtZ1XUzU9EHGP8RyQviT8K3+uXmwN0ziN+iNbxcLoVym6Lfx6CtNEVUm5dIKcifoz0Zh9CAOmE4fY4F5eyN8vfBtGvriqs73LZTGPGL9G4xQBxpOhn+u4g64iytEwAPI7xcxxp2/6DckgMgpah4QyfHrLVnd2OLaEkjD9mvIC4h1SQhoLa+IgnWsXTKJ+5AAVdG3G1Lntt+9EyPmm6UHIR13E3qhivAR4ULpz9N94iMr09T1cbkt4HPvaIdr8ggHxyUPHIQZei2M8GbeH8dtHhVwLpUEleYcETu0feKUi3tUo5C2ujgjcs1eCIU+eqDFlUJo45RJp9wBs46Vyj9wQvlyP53kHUcznO1CLTINeqljw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f19f30-8eb8-4374-5f15-08dc335062ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 02:45:53.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRkjIHp9jw1qe+ZWj5zHlYSff2TYuXmN32c2JCbmORsTPJpGNPjyy6sfMxbJ3jS4snB3e33s+kE60lf9sxyF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220020
X-Proofpoint-GUID: nhKijAu1Fzz0GJDDARsoajvgC_SOxrL4
X-Proofpoint-ORIG-GUID: nhKijAu1Fzz0GJDDARsoajvgC_SOxrL4



On 2/22/24 03:19, David Sterba wrote:
> On Wed, Feb 21, 2024 at 10:09:59PM +0530, Anand Jain wrote:
>> On 2/20/24 23:42, David Sterba wrote:
>>> On Tue, Feb 20, 2024 at 02:08:00PM +0000, Filipe Manana wrote:
>>>> On Wed, Feb 14, 2024 at 7:17 AM David Sterba <dsterba@suse.cz> wrote:
>>>>> On Tue, Feb 13, 2024 at 09:13:56AM +0800, Anand Jain wrote:
>>>>> https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering
>>>>
>>>> So this introduces a regression.
>>>>
>>>> $ ./check btrfs/14[6-9] btrfs/15[8-9]
>>>
>>> Thanks, with this I can reproduce it and have some ideas what could go
>>> wrong.
>>
>> Thanks indeed.
> 
> I tested the following, it fixes the fsid problems and has passed full
> fstests run. The temp-fsid test coverage needs to be done still.
> 
> @@ -1388,6 +1388,10 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>          if (ret)
>                  btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>                             path, ret);
> +       if (devt) {
> +               printk(KERN_ERR "free stale devt (for path %s)\n", path);
> +               btrfs_free_stale_devices(devt, NULL);
> +       }

Right. I had this in mind to check for the stale devices. I'll do.

Anand

