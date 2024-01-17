Return-Path: <linux-btrfs+bounces-1505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C4E82FF8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 05:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C71C23C2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 04:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75915CBC;
	Wed, 17 Jan 2024 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D7lrFoGF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LV7vCDoG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3D6AB8;
	Wed, 17 Jan 2024 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465388; cv=fail; b=lykczm5rW64s61dmz0m2VUUtlTPbE5kxyix7052uk9O9zAvl2Z/5AapZwQzCXu4BwZh8OQ2bMdToRkU74o7ChqRXAEjEeWbmkDIAUc8V18oWfvoF8czCDRsja86TXJUQePvYZCaVcc8tFwdqqdlq0EhBT3YyaDp4FFnYUdG3wKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465388; c=relaxed/simple;
	bh=SimHHyf2sznc4C/LqoMScUIBdzY3Yc0vV9QmXpzPgvQ=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=YCIXDI0AGMJ/hNk7Ua9EXh01EBpkIkGTJjIrXyyCsyMuQn5O4tdCnL+7hRMCBdLBi/DkoLBvHKCpJgN/zoIPT//Tjt/Bk0+flcCiBRwVApNjPk4KFVtY4IHmcaP+6rC3RdAOWKlSPM0NK0gVxxYaIBoT5t8Ym42+lpBH1PcpffI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D7lrFoGF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LV7vCDoG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40H1O2IY029811;
	Wed, 17 Jan 2024 04:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sRjN30fiiwmlQ/SJgNyiYMYuKYv0mATv1mdhXKD4fr0=;
 b=D7lrFoGFhndRE4y+ky4zDnppfZQfITTPRaSnl90UdgJqkmUHO/Bo1enyCRB0lhMsrpD+
 aduumD8IEumPZAZQAVqZmyrroUIPzQSWtCaD0OthkqwpEU9P9o18PYgzx5vCD3jr0mn3
 P1oMQT1zntFtn5hb0z0gL4hg0Uyak3nzxkXGydh9ESmodiY3fu07XT4tWEXDoriu+c//
 uWp0Ud+RBobTRFRiYr8as3/R4FgHcmCXSPYoQo3edp0jiL0lwssHfUtPkprB5abbaLXS
 eMxoSjDLAMXKAUzVgWdrq5PVLAKe653VTAlJIg1gPpM9H4e0LWfj7Ko8O0jkIxsoSfCb gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqcdxek5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 04:23:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40H29eNT025000;
	Wed, 17 Jan 2024 04:22:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy9mq0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 04:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlpDNjnQ7fPpfpNo2V0FTXS5AH6PafrbLVWfBMezUMkpwUyplYdB0hEM2NVZ0r0Pupv/EFCE9dqva6ApsdO3SNe5nBvo1SDUGq8Dwmz68o4bHIx8CPZ8mOxkDz/VXCYba7HAKxYCIplDqRFY4exGQYf5HYjXRB7XbZWfVJyP2fBu+CmMfSXLUNwgjgdRMUvfmsEPCPSG1j6QsL1RkvZReLVKH9G8hjH3fEQj4x3QfgAwc+LilFmXKcNxLGLoa5EqfL+bkuIz6eDPdcllq0ifH91KLlvW4qhlpQsOsFC1VTbcVkZwRJmJyld7Wstz4g5i8gu842DFsp5bnh7xvkMfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRjN30fiiwmlQ/SJgNyiYMYuKYv0mATv1mdhXKD4fr0=;
 b=n3++JG4yulhx66NQSLH8wwFTlnRoVoRuRfg6SVcALOMTUiVlTbU5nuhob6OiadcL1RuNmpaGivl+4nIGphrWM25FPbW/jgS9sJcnvFvKRHo/9vQ3z6ge6d65znvbp2AEHzXK/Ewyvu6GomQCtVn2+zr5TUf9xJcx28RsnCoHHnRA7K6j8ExIqTRKrO5R1wstoeCSotDmjtH1/iR2154r2CqmguLEScEaPsOyn1TqVPAi/PHti4qJp+vep4NNaGTR5zaMFT+fXZpykkdcVn0oPuEVtbrpLlxUxMxB5WRmmn8tDpj23ozNQUufMjhrQ9WEhULkFfDmlwRMBokQmugXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRjN30fiiwmlQ/SJgNyiYMYuKYv0mATv1mdhXKD4fr0=;
 b=LV7vCDoGJGNKyRvJbP2kRClbztHX6m2kZGKUx/jlhIQx6LPRqXhV3r6VNQA7nZK/cUKcFAmC9LsckigX+7nVQmbwH4dFSdqC8iGsFmjuop8FEXQlTBDEeZSen7lL+d7kES0xPxrW1pfrxIaBkmLIF6cQOtXYawYQtK8JFaRMPEw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6483.namprd10.prod.outlook.com (2603:10b6:510:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 17 Jan
 2024 04:22:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 04:22:56 +0000
Message-ID: <0b1c471f-6c9b-466b-b4f6-874a41a93545@oracle.com>
Date: Wed, 17 Jan 2024 12:22:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't warn if discard range is not aligned to
 sector
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
        syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
References: <20240115193859.1521-1-dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240115193859.1521-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 818c81d1-f961-406a-c3ad-08dc1713fac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7Eu2knIXeX30qHvJvIQo/iG8aximoKDgmdNbY6jTliCon3e3wbeVqMBANvGGZhXSQrulqtvVLk2TEtdE8gbWnEc6rkddtC0OELLd3UvVwnh1xqgcwYvYTh6/8BwcjZulrW2ppSWfM2OQMKkN/N7S7xiwnMgfY0VEZBymxEhOy6Rr/HCqUcqejyyN1OsQIb5wMNn6bK/1C+XtIwJTH2VFB82iXa9IaKPzJFrV3ugG/SO0wPY/K61fsBHCE6WfLn91ECKaJl2T/6VVzaqF7eCdIY2b4XkDxYKTyyXWFm2j7f2CP9EdGhv73Bv56qngutCoQOkSRNPwU8SzpJRfE26xizR5iUDGgQnmousekp1vXWOfpWrT5DQIyRGVOiWp/YhWXbE4PilojMMcH9/U+hynAsXGi8C7O36eUUvn2XDM5dqCb0tO3UFQhD+g4LHGCJbZmh5TyTFj2eqmn7pERwYznpdaCf/2ABUMAL5rkGqnFkKSGiHJwQ/DZ0Xla1yoFXuqkmGDWu6yCErPs+7GXepGMuJ3ZsocbZ7dgEePci9THwexygmeDguFZtn6zoC8Nxj4JPBMOtxX3TUfCdhJUGM4XvsE7S+lG0PaT58tZeaB2q7WjamvM1TYpb2ZOgEbF9WvV4qnrK6uo5rGnWTe8k0s7Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(6486002)(5660300002)(66946007)(6506007)(4326008)(2616005)(6512007)(66476007)(38100700002)(478600001)(8936002)(44832011)(8676002)(6666004)(2906002)(31696002)(316002)(66556008)(41300700001)(86362001)(36756003)(558084003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MTZYV2NsZUlGeitCNFM1Uk4wODlyL1NKZXRYYzY0REhQaWNGRVAvSkxLd2pl?=
 =?utf-8?B?ZzVkb1laVEhlYmhub25iZjBqNkkwb1hxTGs1RFN0NkNrNzV4bm5KUzd6dmp6?=
 =?utf-8?B?SEg2dkJkaEZhOG5Kc0Q1ZUQxZXV1T05xbVNrMFY4aFVPUHdTUVg5aU9KQ0tx?=
 =?utf-8?B?WHVqMlRseWpvRS9CRWI0bEZJU2lxR0UxYTAvNUdmelBwdGo0Q3QxaWhTOGs1?=
 =?utf-8?B?bXd6dWQ5UTNJTGRsQzUvYjZlN0FXWWRRdEN4dzBCUXE5OG5YRFRiZE04WnhT?=
 =?utf-8?B?MGJVOWY0YnM1RXE4ZFo1T2NGN1pkOHl2SFU3L0JRN1RXbXhKakJtVksxTllz?=
 =?utf-8?B?RWdyWWllSmxGTmM2UU84dVZTeTUrbWdmS1JIcExOSWtmd0pxZzVnR0FFWHJh?=
 =?utf-8?B?dTZUMFNYVzJNZjZ0OERqYUpNelcxTVZrUlZ0ZzVNbDdYZ1hBWWYrdldmdUl0?=
 =?utf-8?B?RDM0aWN2UWZJNUtHVDN5MTk2RHZLd3pEbWhBNTlPZjdPNU5odll5eHB3emRD?=
 =?utf-8?B?QlhVUHVoeXVCN2c1N1J4cjF6dkRQcm9jZ3M0UzZBcDV6QmQybklBSDhMQmpk?=
 =?utf-8?B?TWppODlmOCsrVFNCMmpQNFgxU2NhSVNGMGdCTjdRVnB4UWhiWTA0SUNqVVpT?=
 =?utf-8?B?R2VhbmtyZkpRL3NFNnpoVWpTaVczalhpR2hqVW93R2Rxbld6VHFCTDN1QzNh?=
 =?utf-8?B?ekx4YkF3RXlYMGpHTE1XcFMrVVVHSURQbmdHczJ2VVlNMTZPdC90QmxvSktx?=
 =?utf-8?B?eTl2OGVIVzI1TEtaTVJkTTFzejVFak9aZUdQZWg0bytFUkE2RGpXS3pYc2hH?=
 =?utf-8?B?VzFwWnRuSkI2akJYdkhYVDdNbFR6TG1vc1piT2g5ZjhMZC9adklldnJJWCtG?=
 =?utf-8?B?QXFYaThjaitkcDdNUWJFUXNackJ0dHBqN3Y3WnVRcmtkWDNiUGV1Z2kwYkNH?=
 =?utf-8?B?MitFY25qOFRYUGNESDVBTmpDSktLZndYUngyeDZWUG1zZGEwU3AzcG9aUHF6?=
 =?utf-8?B?ODFvSTM2Y1hDV2RZYTRyZGtuL2hpSnBMSXBlL3FraGtrWXVQSTI3UzBDbjFu?=
 =?utf-8?B?cU1pRzBpSVJzZzFIVWM3TndFVzdVSWNreWVHOXEraVZyYW56U0wvaGo3bHAy?=
 =?utf-8?B?UGlQOVRORHJUZlpUSUx0R2NUMVVJS3NDOXdJUUNhQkFFdHpTSEk2S1dhdHBk?=
 =?utf-8?B?K2l2NkgvQWNUUExGUGplOTBGOWVZd1kyb0Zuc2RocXV5Y3d5Mkw4bmNuMWV2?=
 =?utf-8?B?Q2xWem1GMHRQeWxXdm4yVTB2SlFpRXEwT3NReGREV0RhOGUyMnVqVlpOYkI1?=
 =?utf-8?B?NVNsd3dHUS8vOE5yRFpSaVlKVVVIaHYzQkdJUTEzbFc4N2dtSDdCbVBZSWtz?=
 =?utf-8?B?S0ozazJIY21ndENqWFdraE9kR1BZWVVoSnpaTm91bmR6cjcyZnliU254ZERw?=
 =?utf-8?B?c1k3TFh5MFVtU3lZbmdBZTMvTTV5VmR2QWsvVnFCY2Q5dWhYaUhVY0l6QVh5?=
 =?utf-8?B?b3QyT0UvZk1sNTdaSUxLU2Qxd3ROc3c1bkZyc3BPdWR3Z3Y5OWs2c1k3MUVh?=
 =?utf-8?B?RW1sMStwWHVRMElkUDhmR0diLzAvZUZUSmI4eldyNEtsT3dIOUE2RG04d0VU?=
 =?utf-8?B?K1p3N0xTcnFFbmFkbVFxMEM4bzBoYytHaThtQUFnVTM0aks1L0dlWW1FZ0Ri?=
 =?utf-8?B?TzI1OWZTOEtibHBhTlZ3TzJNNmU5QVdLdy9qZ0V4WlorOW5BSTYwS3V0TU1N?=
 =?utf-8?B?eDZxa0FwUCtjSFJhNFlSUm5BVk9MekRCRG15V1pUVXBPc1BrdG9kSmJ1QW9N?=
 =?utf-8?B?SzJYWmdrLzN5VUYzcCsyQ0QvbVM1Y3NmTXdqcVBiUEM3NHJ5SFNpMUJ5NHIw?=
 =?utf-8?B?a3RrUitMYnBtN2JFdVpsV2JNd083ZXpOcFZZNWg4WE5adHZJaEhESzExaFU4?=
 =?utf-8?B?R2FaOG1jUFdObEZWcjM4R0tTZStrNlBiSytURHRMelN3Nkp1YVg5bVpzRENB?=
 =?utf-8?B?N2lCcEhUZzIwWVJpbWtKdkNvVjNjbkNmd1owREpEOFhJNWJ4aGhFQVVSOGdF?=
 =?utf-8?B?cEhzWWhQTFM5QzArZkxBLzVkNUF4V0xhTGRtSFI2Y2t3UVgyM2dPZU42MFFJ?=
 =?utf-8?Q?zJqbiglBJr5zzWtFd36YD2SFP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rsOPKTWr26X3YuS9X4R/p6JzoNFHU8dWeQuD95hfxColJNAYUwhuWF3tAWs27c6lTTDxc0L/be7gz0Ym61YNCwyN0xHGJWhdUuWSGaJrW8ts0IOh8FfAJn9m+tfCQv7b8TuvitFl5Nu0t4WugNjQV73hzwIBejI2lKPsRiWN8glNryOtY0Xu0+pBzJwPKOZ9SCIjdZc6h0y842NargokSFF7FdBZlp/d+naykkHVkU4djXm2LrQRTLCc9fetrY6VAa8X9t9pg8oUQLFoBFWkImqU5VsQpFPwoA0MKTRE0Mdyf1ymO/uLDsxmUYmhPnpQAs3oGoCCbmLHqzT8hm1fQLHy/YH8FutpnGSU8hld031LYB3EaNK7zhga4mKSoGfo6K+5FPlzf7H1i+oJQBmi1Knx4DoGt3wQA/pSqfgNggAd4AyS4ug/hOrjgHiunXvu0duTIpH3iMEDtxgrtkBYOB92xr4fBIxlOwxpH4PDx7stoj73k27SrjZIgCJMLOdN6IuS8MfX+HSTgUW8nhGzw4uI8qqq0CV4hI7th5+LybiLBNiGKmlQdtPgOHVh5XOsjbhQiUtXKjFPbrFGhTfnUYeNvrO6tVKgbZeqYCrq8EE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818c81d1-f961-406a-c3ad-08dc1713fac9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:22:56.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOKKLfYeqdOd4W6uB9fub6zlZa4M7B9pIQo65PcfhnyYHk4Uu1gvAxOqj6tyYNlG75i1tqcXH+k99ylUv+O3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_01,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170028
X-Proofpoint-GUID: U_0N8Gtb3Pw_wyjutEMQ9RpXOfDIgiox
X-Proofpoint-ORIG-GUID: U_0N8Gtb3Pw_wyjutEMQ9RpXOfDIgiox


> -	if (WARN_ON(start != aligned_start)) {
> +	/* Adjust the range to be aligned to 512B sectors if necessary. */
> +	if (start != aligned_start) {

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


