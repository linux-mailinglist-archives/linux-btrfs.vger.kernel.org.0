Return-Path: <linux-btrfs+bounces-2798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC528675A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3131F25B17
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48780024;
	Mon, 26 Feb 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DsWtwFyp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WFTkBu/R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A27F7F4;
	Mon, 26 Feb 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951990; cv=fail; b=hFXHW65K7eCk2Vv/lSNZK80uxpJeU3OcW6hYnnBiqLRdO2hHszZ56GXCEwa+CG/IdI/Ov+IaL6yBytTpxBlelfZwOh3YoZZbi5uUaCNA6GuYbV6lOgZM/mwVs2hF2G8Y6MAjwPFbC+Ne42fr8LV8CnwgBadqW+V3zlQoxSJEwpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951990; c=relaxed/simple;
	bh=exO9b/hAyBEoLZQ//cbHrekWPCHf3KIfkb8TA8mW5rw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jrY5APrS7vTq/8N72OP/+8TrSZmwHOcAHcdnLlrcTfAcMOVviHJJHmklrr7dzKXTKeoeLpNipFn3mnyfGlVDvmFdY8A3LXvTWf+yuIRMgstPIZEgN0N5nBHy4wqZQuw1ORv092MmjPZCAxemRUP/vr5QmUnk6PgVLccCtYw7iwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DsWtwFyp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WFTkBu/R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QA3vDD028628;
	Mon, 26 Feb 2024 12:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iHnm+xsXuPTUJTykQBkG4nYxUXxbB22R1FEGJYYadmc=;
 b=DsWtwFypFT/pYYk36fIYJU55NQlwcXMm10MTlh1mdZDICpv/1F6LztA79+PCkrvi4l1K
 EG7zxmpl3SC5Duq9un2kejcLXovQ0l5D+HHuKmI6sXzoJEeopEDEMcvqAr+JKRbta8ai
 fDBuXw2yyr5n0wbFixq+MjYhtSLwenU/mwL/xvrv0tCKkZJnxAEnXj95RTn/K2+7/BPG
 yZDsx/ibTiZ3GUN59E4lLkUXzOOKwBGXVfCxrCnMPJ9n5uyhN4ZD4CNGSIx/RMAMEMUy
 kUi4fjQXrUzQ6egoPwE25EZ55ADgiIzt7phKS8q4P0cL+OSiQY9GtukWCwg6bHs5PYP8 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdcm2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 12:53:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QCaDmd009784;
	Mon, 26 Feb 2024 12:53:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w5g4m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 12:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLgFnH/OY0ohNNKsR8M8KPTcizUSTxketdSv7Xbx7/dYfgh8Y5EKEfvgT/Xz9pcCYqvAbWpBNG1wNJVmo/EV/0Z4pTi8s0QcwsLny0pP00dpkuSirE/Nv1IwVrqXJ2gp2wpOjxYl/cfSbo2ZL2TZDaStj9eeNTnugHF7hITgm5jO21KXyUKMNgp4WOJPDxS1RBSHkS+PWeK2xp7+t785mokuvElA8vJgTQ2zSJiysF9Z7S3Wdhw2XNrH3uyVa8xKgp9hD/yN+PSsyoZYs5dgfb//GALcOFjFMODi2PDfjnozXwJCmQ12Q+X+ntFtXk/EVRpVJOhTFQPL5dZ8HJAQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHnm+xsXuPTUJTykQBkG4nYxUXxbB22R1FEGJYYadmc=;
 b=Dwo+8VU7XYq0rkpCMx89+N3Zc8ojWXvRl9wLaFyYPU8ao5N3Yq0xH/5bIz+Y6UzlA4goIlsGgyCuwkzXnWhGDJ10D8jXBmBldBJv94n2J62C775h9poohjhphw8Vt3MzUKnJRoCpANZgGj+Jp3fs/OV0/l/jAUbfHGh9Ply7ghdNWPfJpIQp06X2fAD3BhaAaVqD8uH4bvELtKK+X82d5cih4oOIqKhHkaLsfuvcuSnC8qvk4CooEv0VfhHyBx2omb2kgaOcZj0dEyDE6S/ZfWL2bj3wY6lD0FpgbhOxq1mABO78aWT4FZr2CAiVWwA7UdnHq/r/QjubXawIMcNbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHnm+xsXuPTUJTykQBkG4nYxUXxbB22R1FEGJYYadmc=;
 b=WFTkBu/RmC3VDixBqcq3fqVKp66xfpyS5v0LKDSqyO3GKqHHQq58rGx5OsajDpwLd9FkWke/VUf2uFfonjfEP4tAj6C6pgzb/Drsv2JVL1KUY1g/N6ccWi90UwppmZYj6cDqnE+56W028iDtDIkWS7LS5xPBhNfP5cV17t8+zB8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5061.namprd10.prod.outlook.com (2603:10b6:408:12b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 12:53:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 12:53:02 +0000
Message-ID: <ceaf0428-8e3e-4659-ad71-15cbf503adc7@oracle.com>
Date: Mon, 26 Feb 2024 18:22:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] fstests: btrfs: add test for zoned balance profile
 conversion bug
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "fdmanana@suse.com" <fdmanana@suse.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
 <ef6dec9a-0f63-4411-a061-66876f5c4886@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ef6dec9a-0f63-4411-a061-66876f5c4886@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 618c9dce-09e3-40fe-650d-08dc36c9ddd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rju/d9Ebwxdn1rZO5iFEHHnZNuDaw1iAtsVlF0/m8pDTojssdPnfcPNxuUg3Wv0RcAmrVui2jmtjip6qiU/gBnM83f89PRHbCzN8WMdGCe1iuWvKy2mmGaKQXh5eESqYwhyhzICqc377ADCZaS63xsu9KQo+QxOfFmT99xEdJeAcGAHwhSPYrKywFaTHhZ9p3+u8XrS20EygOvDBjpjg2la/s+hV4TD7QrX56zTuHmHsHlVPbsPIewxYzIRtDdHoSURt7hsHas84ie7OS4RysLIL4xcROokfF5b2JStOkWKHVHESNE+7DaZsJ98FCYkxgfvr2RuIcqXtjAqSt6w5cukyWT35iIfIWrz5wm4PGZCvXlw7zyxUK+RI4M6eNdBvjRXzjT/zPjOoGgMnYajaUt2Qh3wadX5Zu9UHtxUigr3+pVFDKl9dO/e4X6z0+i7ZsYC5faSDlDlzF9fVm15V4l5yiS8mxLP2KCEvxxf0Rn5h+Kc2JcapegzH0wa8o9jWfq6zpN5H7LgltzgdXfW5XVhRBb+7v7X0CIkakeUINZ5ysdaA8BFbrW3zylcWrU/S4apAa9g8Vz82MgbdQZnXT4nf+YKcFF6agiBmclQwrE0qhcZ4qAtw2h/Nqm4gQ+5ZafHN5JX0Coldw0IqFihRfA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTRuUUxESFFPU0pBekVJbk5vS2ZyTFp0MXg1dzBhbTB0WU1PU3VuNGZhc3pr?=
 =?utf-8?B?TlEwaUpYeldzNjEzOXkvcmdmakZMZmpHRk5CdnY4OW9vNzdBR1duc1NmSENl?=
 =?utf-8?B?ME1nNnI1TDVzeGpEaXRZZk84bVBiaGthaTFCWld0RkxNbjhzZVNtMlBxM0pM?=
 =?utf-8?B?Nm1NUy96STA3V05Jb053VzNZV0s5MkhsaWFrRnNlSEJWWWdZWFNtNjYvSHZJ?=
 =?utf-8?B?ZGovdk8yK2pUQTgvMDlqMUt3WkdhWkdEYkxKb0ZPVWxZSEZLbVAwaHNhRnB2?=
 =?utf-8?B?M2wzaE1aYjZsMUdzazEwd1Vkd3FkcDF0N0trekVWZGJ2aWxzQnBXWUVKUnVh?=
 =?utf-8?B?RkgvWkErVHFsajZoZlJDbjI4cG45L2pFMnoybGlyZHp6QnorcVRKUkNrL2Fr?=
 =?utf-8?B?NjB0emx6Q01aMnIyNG02bDNDbWxjZzRVWXNTTWNtRU15UEtNbm9mVzM2TUNm?=
 =?utf-8?B?Wit1TVFicGZBdExhZTNna3dFd2pEMnBRVm9GWVZCdXlFNWczTjNaUmJrS2Vj?=
 =?utf-8?B?cEFWQ3NYOG9SSHQyak9pZzZ3V2RJWjJMNm5sRDJzRVVYUlV4SGFCdjNSZzVk?=
 =?utf-8?B?Y1VzUGNvZU9LS0RpQWN3VlM5TTlJWlgwK05DQWsrRXpnS0VuYlNiK1J3cEFC?=
 =?utf-8?B?V3YrZk1razF3SnFBU2tFTTZIcmwrME9UejVXcVRMbTNYelEwUmxGemJFY1pi?=
 =?utf-8?B?bVZodnVOUy9XUFZPd1U0d3g5Rm1zcGdpS2xLS0IrQUI1azdWOFhNMFpjWTNq?=
 =?utf-8?B?MU85ZlQ1c1JMYW8zZUFWQlI3TUFIalhBNGNQaGJ2OEF1T09wRVBrcU90U1Z2?=
 =?utf-8?B?d3p6bmovRWNQMUxqNjF4QmRXaXpvZkVBZmhrcVRsblRmeEVFRWpYR2lhWjlG?=
 =?utf-8?B?VyszMjBWMERWTzNPSFZzWTFDVi9QY2diN1pielh0M0cyWmtPOVdVdnEvTU9l?=
 =?utf-8?B?VkdDU0VaQURUQ1h0YWR2Ry92Z3RuVURWeTFjaGJwZ0VzTnY4Ui9JR3pDbHFq?=
 =?utf-8?B?bkxrUnpwQmNaMU53N0d6RzY3SGlLQlRvRXpOdEVJOE1LUUJ4NlYrM1NTQk1s?=
 =?utf-8?B?dmllbzVuUnlEZWZuZldBQ1BDQU1mRU5sd25zYUIwK1kwNUJYbVc1NnRGSU9q?=
 =?utf-8?B?MHhFRWFNWUNoS1RacFlyaThLYng2ZVVJbkNNcy9NMEFSMmdUbE9ORUZ5WURp?=
 =?utf-8?B?M3NOUXNWaW1TcjNMNzVCNVRtbmtVZ0g2NlhCNnpqYkxlMGNCcWxUZGxyOUUr?=
 =?utf-8?B?ekcxMkZKL2UyOG12SGgvZDZPRzV5S2tobFJmaXRVYytROG5GZk4vRlNNS1hU?=
 =?utf-8?B?SUVCZ3Y2NjcxYm43emdOSk5XclFlT1dFOG9keUtoM0E0R2ZQNktLT0pteEFw?=
 =?utf-8?B?Y3MwMXFxVzBrWmVXU3NVUzNpT254aDE2VFJpVFNYTThid3IrS1k5VkNnTWgy?=
 =?utf-8?B?dXI2S3RCVTNnN0RuTk5aNEFhR3JqNjgwamVFQS9PQ0FldXkzdzR0R0ZmWlA2?=
 =?utf-8?B?THZDOVpvOTNQRUxsOG1MdkdWOTlRcWsraXYyR21KL2d6K2dBRm1XRTRaVVQ4?=
 =?utf-8?B?SEVmdURveTBBMEFVYTY3cytkeUJxSHM0WWJKdTVWcXBpRWwxSzkzcGt5bVJG?=
 =?utf-8?B?amFBZDlldC9JMEh6RWpUTmgvRVNFSGpGM1E0N3JjWFZzZnZkS0pnc3NuR3Bq?=
 =?utf-8?B?VGxQTjAxSEd3T0VuN2hHY01Fa2kvdWZMOUhTRk1MOGJpbUJycEc0bEg0K0Q3?=
 =?utf-8?B?bFI2ODdVVk1jSTdrSzdyZmNDM0tSOWFxVVhra0gwenphMHY0VlZnaGxjeC95?=
 =?utf-8?B?bE1oRmJ4ZmlFdjIraFZjQVZSUFNISlF6NUxRd0M5MUUvcnREaHFSMUI4cUdo?=
 =?utf-8?B?a002dTdET2hXZHdDaDR3enhhVkJNYnlMSE9YRDgyUUJ3djJFb1hrcEh6TG5K?=
 =?utf-8?B?eUY1OWVwdnpPTXRLR0V1VlAvVnRGTEFvaklSWkh6ejdCN1RLUDhwcXBEbStx?=
 =?utf-8?B?WW85UUo1UG5JZnJZdExKK3kwb0lDTkpDZnZNTkhNL1JoRTE5RG1jMm9ycTdw?=
 =?utf-8?B?bFkxblR5c0R6QmowZEJSWlcyTWJwczNuMGZEcWNQWjkwNXBHQWZYc2JJMW82?=
 =?utf-8?Q?kG/TsvV0ZfDMk2Y2R3ZpuREJo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Md3oVrsb+aiMgOCh1lPFs48x2KB+EPzdgd4CZh8Pk0MrGuDxNrsB7RFj/jz2t98juCC0PMcv+6+KF4CAf1hIxvZtQ02keiNmQ1gL3FAvccZiGgERSi/fa+r6FMmjjg7wQGCSWNaA957Qvvii22l25gbyYinr3FoaS5MRMUh8Ys1AUTl4Lr2hhIHpZwxfWsUFS8bRONjuF7Fzmx9IC5rA9xZd22knR+5eouw3G4R+so63TpNL1QetmWGvuECgnhNFwx6yK09S1yAGf2lq/IleqTP4lw6izEE0mvpV/iJ6CCw9VLof7DelXaxbbL25Tfs0hV6Me4d1/5kLMVh6TRYvxNV+ewFbez6rdPaOeB7uXP6/E6dBhkDNxY7cUvIVgobyvGSnGqGYvSZjEE+rrZ1XlnEYL2LcWFJMl1J3DQj/SWT7ZFnumztj4xSeVz8UGLNn80CQ2bBXHUqCL4XN5NAZ8abWICfzHCMRSyjTSAYbNx62pJH0W4JDNhl0MElB/XsqYzZ1fNg6OTfWtdu6Lhy4dEYJU849FsnOmZW1ypa4efFqz6L+NjGY/HiyjS3lsz3rW5/s1/cSOS5QdCXGgWhMoqB6oE0UFwwCMkSCUc4MMUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618c9dce-09e3-40fe-650d-08dc36c9ddd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 12:53:02.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIlK8QYjF5QsFkCnpcLC+KwheM4xQL5ThsWd+1Demoxl2W831crxWVBQLqaVvizpqORVJd3BcaXIQiIVfUphgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_09,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260097
X-Proofpoint-ORIG-GUID: eryu8k3XaPCXnPgJr-hPUS4c7VxqEqQO
X-Proofpoint-GUID: eryu8k3XaPCXnPgJr-hPUS4c7VxqEqQO



On 2/26/24 17:23, Johannes Thumshirn wrote:
> On 15.02.24 12:47, Johannes Thumshirn wrote:
>> Recently we had a report, that a zoned filesystem can be converted to a
>> RAID although the RAID stripe tree feature was not enabled.
>>
>> Add a regression test for the fix commit.
>>
>> ---
>> Johannes Thumshirn (3):
>>         filter.brtfs: add filter for conversion
>>         filter.btrfs: add filter for btrfs device add
>>         fstests: btrfs: check conversion of zoned fileystems
>>
>>    common/filter.btrfs | 15 ++++++++++++
>>    tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>    tests/btrfs/310.out | 12 ++++++++++
>>    3 files changed, 94 insertions(+)
>> ---
>> base-commit: 5d761594fc5832d6d940f113b811157e332e14af
>> change-id: 20240215-balance-fix-6bd7998efad0
>>
>> Best regards,
> 
> Anand, Zoro, Ping?

Yes, I'm looking into it. I'll update you soon. Thanks.

