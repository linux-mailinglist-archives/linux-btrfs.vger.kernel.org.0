Return-Path: <linux-btrfs+bounces-2706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD369862499
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 12:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA40283AE6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C82D600;
	Sat, 24 Feb 2024 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G2EJJpv6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yUaJodDJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A03182DB;
	Sat, 24 Feb 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774941; cv=fail; b=e5JpNdP/GsI3ecTazx5ypE5nRlhgq69UIBr1o8ZrK9UGckgM1NQkqbNrg+/+MSiBTLptbDjgMC0bnYYwxWVyjoz4nQ2fw5yFCagstCPeT7lJoa76B9NBkcRCzbU3cE9JMGoLRx944Ejj2GbqHp92ckvnZJR2+kd1kyl1tAaigBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774941; c=relaxed/simple;
	bh=ZaFnk8UYfZD+FE1MyyTgqCjNb2EB+7Zd9A+ZLuyjVFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qrtU9bolKtGrG/JDmOMAwS2J2a36kNTEKEu2n83zDpHwfQ0uLcVkc6KHEZ2ici72XLJ6TLBOc2tqAsArO/DwyqpH0sljjHSBUarfhAi+dXBOSBVRKTFJotadt7cm4ZjxD8uA37Ir42c5ifRlQhAwQf/JOiiN4ASIKKuj3eisRD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G2EJJpv6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yUaJodDJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41O7mQ65000346;
	Sat, 24 Feb 2024 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VzLhesg0bpJlbPhOS0AQK0ngO1qPky5WmBXbyQlXvb8=;
 b=G2EJJpv64ZgxpEVhTARjQkGilrA1k0SdmQ3no9V9GB3RlCfKDTjC5GI7ZqNKaKhvqWjw
 d30Io33hSmQlyXOw3SI3L+BzC2tb/gkRGO73Rfl2kXY4IqH2gp30Xe7GzhbAKVMJnY/r
 oAQb5HZC5bNnMMe74MTAhFhggM5MU4I2S3KWTeO7MTrV0wqWFmNJlGAo+vylFg6fxSOJ
 wWuxQS9HD+hqUj0h6gzu9I6kR7EMEy4zsuIWipGRJ870s2H1nkeK7iyB63IHoe4EBTW0
 h7GVhTqPxZjfU+qMrOWYv6IkRo5kb9yhjmuwcWHTjJWsv6Qvicqr0rnKwXc/tk+HWyt/ AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u0v4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 11:42:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OB0eHU040680;
	Sat, 24 Feb 2024 11:42:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3n804-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 11:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3SUMTRRBJ2i7sAHecP91CXoGDew1jqK8VL6InHmK6vry5shs3jUWV5orSW92qTDUmqZuZZ9jF69rK+LAtsK3F3MHzN4xLoJ3boNUeUnIe0aqS6EeMW1hjR5dq3Y1dqb3Ts+IHJVBjDVoHBzy+edvnZ2Wr+TU9OEnxsdBzbilJaGWaOquw3q7iCu4EzxmHdQYO+x//MDKHiStOV6kKFcg2Zv7y+IAv9Wb/Gut/1xOiD2xMLzP7Z2+9resKhlJoo2tmxvWD5IRII5DS78hWWV8tEmuStV3tto1bwMGjUZ7QW33JUrP47QzrvjlKMv8U+VeL3npGIOFHFIyHjobxZsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzLhesg0bpJlbPhOS0AQK0ngO1qPky5WmBXbyQlXvb8=;
 b=S6EPF9MU3oi2KzgSM5TvBfuPNospFJ4W0fCcIeEXHUsN8yzgXJ6wWz3sl4WGBtopL+543lUbVVvjcp+RmdTM6GUL6cMxTy6VpUvw1/SbphAzhcLKu9iBIH9m46KgB1Ypin226nR83IiJOjgW0UQibYoWPAMuGpfXd1Pi+oBQid/xiPEKQOynGYMY3iJtK7ebMhYVtdGincuXQeS418ZD1/e8sJXOvlUYj5RHxpbJsLDRxoj4bSY4sErrZsScLBmmzCW89VqtQj/a/SFfRObs04+P8fnnsTKdCJsmrF1ZQPARaMcIWExLawP5imqjAgUBysRStx8uxwhxHuxC+2GyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzLhesg0bpJlbPhOS0AQK0ngO1qPky5WmBXbyQlXvb8=;
 b=yUaJodDJneevn27XajGwe1MhH2+xVfujj4Z1LRAhh5vRn13eeZXTeRn/CtMvgM28OLOcVryLyDm+AEY8EOS9kPPDvNTi5DwL/Y+B44DJ2nL5KmATt8uq8DSMBfOyzLpbNhXc4Hynegz5nnXH4NzV2rOMmhD0Aq88lvR0iS63pdU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 11:42:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 11:42:03 +0000
Message-ID: <7c51df13-796e-4d94-9d2b-dfadf7ffd7f6@oracle.com>
Date: Sat, 24 Feb 2024 17:11:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] btrfs: verify tempfsid clones using mkfs
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1708362842.git.anand.jain@oracle.com>
 <44ccd4eef48ef7a8fbe863bdd7b13b2ce8fa642e.1708362842.git.anand.jain@oracle.com>
 <CAL3q7H4Si2u730Lzk6gcX0WAvidNux9Zrtcvi9W4yKaPCj+93Q@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4Si2u730Lzk6gcX0WAvidNux9Zrtcvi9W4yKaPCj+93Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: 151018f4-4b99-499a-be8b-08dc352d9e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nmLLarrUCYn01PV2ihkCHoGRIFZsYGlzAx8otknmIqX76vRN01xnTncvHCjajTqVDOLZ+PDnMMvT6pWg2nl28L6Al2otY3utRna5xbxFcJ3pHkb5TKeuyi4hhdli7c7ouoZqeF6o+ssS9logZWy5ioy9XgJBG97EsmH9mJdR8P2mM3O7kX+jQbZLKiZmiPlJZgo/H1ntENYcp74bpvismZr1zwLyzX7mOboWmfEwWsLvjRstToraGAp+42DXL0K2p0t+Df7ZytGPubmr91ri26AtWe/iBfQkDnKGESznAXJb2kVUdyd6CMQX9PONFhGFDNG1w1DbRCbMojFu07muB1U2zs0xqeYxMuP1XjoDRGhviLcNbF1iu8yBNzwH1UhrB4HGONFjeX2eeYzNYFgF8FIVcFFZLBlwYzq2/sTbi2m3yRloyds+fM9bgfIT5OXAjqnjIWr2dGW29WzA1XpUEk7ZwnxvYQjSsnzGzAwbJ4JJiJCx5koftmEqJgha0yxeu1LsX0xl5yLdNOqn0T0HP/YAyUxFNH1738ILjlgtlgk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dHd0UHozNFd3OFkrajJNL2lDRktSSE9TOUw3SURtQm9EUmNhbDNJNWFIaTBw?=
 =?utf-8?B?a3ZtZlJ6NCtpQW9LVlhiWjh0YXY1UmY4THFrTmk0bmVWZXI4aVIvZ3REaUFN?=
 =?utf-8?B?WGJnWXlvMGxibkpYNG1UQTY2OXA4Ly9DMlkrcTlobnRhd2s0N2lqWjZyM3cv?=
 =?utf-8?B?UzhzMFhyNEJ2TU5LTVc2WXhPcnZLYzI1QnBmSVZOSGQzaSsybE13SzNwOFoz?=
 =?utf-8?B?eFp4ZUQ3bkdnZTdvWEV2Q0Z5bFNIUUlIbUNhcFREWWVPRkVXSTFaNFZxNUFa?=
 =?utf-8?B?cTNuV0NRL2VUeWtCN1d4T0crNVR2VnlsWVNyRmpjeTRjK0ZyUTFGMUpDMFRn?=
 =?utf-8?B?VzRERWloODM4b1hTVUNwa0lBanVoNEY5Y1hmTVZHYWtETEl0eWdSOU5nSWhC?=
 =?utf-8?B?RU5HWTZoNGVsSWp0K2htRVU3amFieE9rZkFEOVpFZW9LY2xydzNuRHJlTk1D?=
 =?utf-8?B?UW9sOTNxcXFKS1hrTVBpRmErUW1GWGZhTysxWDhZR2oxTmxPRHpWYXNxRHlU?=
 =?utf-8?B?UUIyN0NDOHFCeDZKL29XNFl6NXNSK0VVczBSUnNVMTRJR0c5TmgvWmVEdmZm?=
 =?utf-8?B?dVdZS2Q5UmVSeksvdXk2ZmF1eWZGNkJpb082dGNGcjFlRWtERkhsVUE0bnE1?=
 =?utf-8?B?MjVYSXNaenVNamlTS3hkVVlRZVEzc21NVjF4WFdSNTIxWG1heXZOTU11Rzc0?=
 =?utf-8?B?Nzk2eVRsSlZUNHQ2RE9INERPYmVCTHNScXNsa3U5Si8yV05lRGthdjBOUEUw?=
 =?utf-8?B?ZW1HRDZZTXYvd2FYb3NRblI3VEloS0NSaU8xc2d6UEs2d0F6U3AvUlJlUE0x?=
 =?utf-8?B?UExIV3MzZGREaHJtc1poRkcyekxodlQyb1VLa0w5TjRzeVNFaUxpSWswemRZ?=
 =?utf-8?B?R01ZcEkwNEpJOEhtZkROaVJyZVpWbmM5eXNxaXJaeTlnSWRTOXZxaEZIOHdL?=
 =?utf-8?B?a1YrcnJ3U1BVcXphWElDa3UraUhaTEk5dVQ0NzEwdmVTUFlkRVo0ckVORFNw?=
 =?utf-8?B?TTBtKzBtenNVNzJGbWg2Q2tWVHdPZGJRL0NNSWd3cVdrNG5xeDR3QVpyUER6?=
 =?utf-8?B?NnRML3hDMzNUTnVHVWJqVTRmZTBUMENJNVdHR3J0Nk5PR0NreTJIUC95aE5J?=
 =?utf-8?B?NXBISWhSbDdIMnVzYVhFQmlienpyQjYvaEdsM0lubllIVk50MTlpa2J2R2lK?=
 =?utf-8?B?M1B3MlUzUnJsY003VmkxUG1rMHcvYmNoYWhId2JFbFFoV0E5RVBESnk0Rm9n?=
 =?utf-8?B?OUtNZjdIOGdkVGhlWHRXZ0R1aDRZRlY3QjYyb3VpM0ExRGVMRjJmOFdzb3lR?=
 =?utf-8?B?RXI1MC9vbW9Ua1FvWXZqKzVPamUzbUhkRy9KTVgraWRYQWcvU2hoVnpNOHpL?=
 =?utf-8?B?Uk94S2tYT1BpR2dNNzMzZnhYUXdBamt0emg2czZlbXhKQnlDSlNEeUt1ZjFB?=
 =?utf-8?B?RWMrSmlZS0ljSUk2NHF1TUsyQ2xOUDVzT1JJdGJnZXhDUnFWNExKdEtsVmp5?=
 =?utf-8?B?ZlpSU2NVdS90WXFYeUxNakxkMWRrZUYra280ZjNCdjZhT09iRUo5eDZPUkt2?=
 =?utf-8?B?Rzd1QnU3eWVJUzNSdmZtVjJRd01UOWFMalFhOGtQc3VZOWZpUUpnTU8vM2JQ?=
 =?utf-8?B?MDB0b0k0eWl5bTkzenB0aU9kTWg5cEFxM2pVd01Ock56aHJKcTlQeTNQZmR3?=
 =?utf-8?B?OTZnYXdZU2VQODliZnRDZ2pFYXlqa202YjlkTTZQcXdBM1dRZlhJU1lSUm9Y?=
 =?utf-8?B?T292MUhUMEdEeStHUUZEd3FCa3ZIb0U0Y2hSZkFHaTBJcnlkQjkyRnQ0Ylc2?=
 =?utf-8?B?R3MxdWREYW1Cb2pwbENvWENTQ3RzTXhtRHlxUVZlai9WM0s4R1d1YnFmQU54?=
 =?utf-8?B?dVR3eC80RUx1V0xPZVN6dWNaNkVVaXdDVVJ0Ym44Qnlva1llWFlYaXlmNXVh?=
 =?utf-8?B?M2IzUDhtblArMGhVeDF5L0ordVg4K1pIYlluREhTNWQ3bERDZmxOMk5zMXdO?=
 =?utf-8?B?T0FzaEl2SnZLRmZSU1dGTTZQZnM5ODBSdmdsbFpPa2VzdGZHeXZweVdJODlx?=
 =?utf-8?B?bE5OME0rd0M1VVN0RmhqQ3dnYmkxdjVZUFpPUndoTGZRSElGQm53dHdVVlM0?=
 =?utf-8?Q?5zcmyyP4o0iu/8UeeQyqjEYg3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8kgnyeAb1Qj+B9J1TfE0htO6jSVk/8481gcqLCkIiTxjr7lXB7VwrAYVcJ2s1YKJgz9PR8k6pPChwrpIP4ORwVEDoLdstT9AIJ4sjy3qq9iC9Wit6Fy33jOJqIyTXPQQmW331ifhDd79Hn6SpnkQiurVWP/S8LuZsQB8D3S1hrSIhl8cY/1uYRI+e6AU+qbrwH2FkVqbi7AM4SmMoImrhRKli9kJyvmVZ3ismEjzYVZpgcu7BE50OSY/KzQ8ayGDpJRE/mQ83sInLGHK7caS13DmEFM4GM7gSQwQgB/xazmARKXi8ubtDVf8uLmm2p82AL/Cqz+1YrMaQgD99pEFPwc0mcJWZU1ploAR51xn01/vLGFOjXPer9QBmC6PkXaHEONDjx+QDCs07LE1KBZO36xqU3w+MLfzZJVE37S2j7nfE8fGofIRXjvvc29SGOnz355sBLmpA1N5iAv0RmOKlwN1N9HbRebYaRW8iIBteFLN7sHGjPxKfpXvTJbeMGOKTg41bqqPdjoRbLUrTE6BtD5izhfFq+2uNxsi0/ezxGPBiTDCs9PwO9DC+g2igHcBqj/W9JiC2liCN/am6kPbBAXgy5xLxJSIhDJeQXwOQ1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151018f4-4b99-499a-be8b-08dc352d9e8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 11:42:03.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvmXoSLA0LzIYdY3m7gywbO3fmz8KTHKIFaW72YE9DsnaG12dVzfFIeE2oNjDd5dF70OSD3YjVIB/e52JODpVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240097
X-Proofpoint-GUID: qWqqHDjZ-d6wrT0a-ULcjV3Eq_QPR0FO
X-Proofpoint-ORIG-GUID: qWqqHDjZ-d6wrT0a-ULcjV3Eq_QPR0FO

On 2/20/24 22:25, Filipe Manana wrote:
> On Mon, Feb 19, 2024 at 7:50 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Create appearing to be a clone using the mkfs.btrfs option and test if
>> the tempfsid is active.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>   Remove unnecessary function.
>>   Add clone group
>>   use $UMOUNT_PROG
>>   Let _cp_reflink fail on the stdout.
>>
>>   tests/btrfs/313     | 55 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/313.out | 16 +++++++++++++
>>   2 files changed, 71 insertions(+)
>>   create mode 100755 tests/btrfs/313
>>   create mode 100644 tests/btrfs/313.out
>>
>> diff --git a/tests/btrfs/313 b/tests/btrfs/313
>> new file mode 100755
>> index 000000000000..c495a770c212
>> --- /dev/null
>> +++ b/tests/btrfs/313
>> @@ -0,0 +1,55 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
>> +#
>> +# FS QA Test 313
>> +#
>> +# Functional test for the tempfsid, clone devices created using the mkfs option.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick clone tempfsid
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       $UMOUNT_PROG $mnt1 > /dev/null 2>&1
>> +       rm -r -f $tmp.*
>> +       rm -r -f $mnt1
>> +}
>> +
>> +. ./common/filter.btrfs
>> +. ./common/reflink
>> +
>> +_supported_fs btrfs
>> +_require_cp_reflink
>> +_require_btrfs_sysfs_fsid
>> +_require_scratch_dev_pool 2
>> +_require_btrfs_fs_feature temp_fsid
>> +_require_btrfs_command inspect-internal dump-super
>> +_require_btrfs_mkfs_uuid_option
> 
> So same as before, these last 2 _require_* are because of the
> check_fsid() function,

Yes, they have already been checked in mkfs_clone(),
so they have been removed here.

Thanks.

> defined at common/btrfs, so they should be in the function and not
> spread over every test case that calls it.
> 
> Thanks.
> 
>> +
>> +_scratch_dev_pool_get 2
>> +
>> +mnt1=$TEST_DIR/$seq/mnt1
>> +mkdir -p $mnt1
>> +
>> +echo ---- clone_uuids_verify_tempfsid ----
>> +mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
>> +
>> +echo Mounting original device
>> +_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>> +check_fsid ${SCRATCH_DEV_NAME[0]}
>> +
>> +echo Mounting cloned device
>> +_mount ${SCRATCH_DEV_NAME[1]} $mnt1
>> +check_fsid ${SCRATCH_DEV_NAME[1]}
>> +
>> +$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
>> +echo cp reflink must fail
>> +_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | _filter_testdir_and_scratch
>> +
>> +_scratch_dev_pool_put
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
>> new file mode 100644
>> index 000000000000..7a089d2c29c5
>> --- /dev/null
>> +++ b/tests/btrfs/313.out
>> @@ -0,0 +1,16 @@
>> +QA output created by 313
>> +---- clone_uuids_verify_tempfsid ----
>> +Mounting original device
>> +On disk fsid:          FSID
>> +Metadata uuid:         FSID
>> +Temp fsid:             FSID
>> +Tempfsid status:       0
>> +Mounting cloned device
>> +On disk fsid:          FSID
>> +Metadata uuid:         FSID
>> +Temp fsid:             TEMPFSID
>> +Tempfsid status:       1
>> +wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +cp reflink must fail
>> +cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
>> --
>> 2.39.3
>>


