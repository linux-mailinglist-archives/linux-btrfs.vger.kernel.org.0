Return-Path: <linux-btrfs+bounces-11518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C4A38E50
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 22:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86099165410
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2DE1A5BAB;
	Mon, 17 Feb 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c9mijBoM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ysdCFsjV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBB1A2398
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829177; cv=fail; b=jXg7TUIHwvNIAW1GLXgSCAIDf/+SgueA7ManTiMVdXtGDABpbvCg+SWFxZOzWktLKPs8DNe93ZAZRiSXWmO1+gd+b4ByVvT7sGy1YeXr6itwcQgNVPfycVDRdbXpyL/HeU4iEuJmRn9Jw6Gsw4y/9KJjhxVSebd0G+CjTgTj5to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829177; c=relaxed/simple;
	bh=JgunTMB11A4mldmjkXY4k5dK88hS9V/Wm419VB+oGkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=umwiyqcu4kkEtX3z6h/BBtPwFbs82UdWfvtyWxZCIgfa5jU6bnv/9fxj/Uv9iaRLRzeEUnuG4iYMK7UGEDYqP3QvRtCJRrKRP1pZyBSxr7UaA67x1KvS58XvOD0lZReS9ftzuNw2tjiluUNRz+jp+twr0HZ6bvxtQxyStLfuQgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c9mijBoM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ysdCFsjV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HJtqx9032254;
	Mon, 17 Feb 2025 21:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8AUwxbCjVlrImogORl62eaSgQMC6M/kgDGkF5FCIk1E=; b=
	c9mijBoME1JtaBbUek96Y7E+Xu4nSR4EnfiOixRCqKcSBRljiXoWrZZHY1mBBfY4
	Up9w5vH27HDd+CXv5Gm3KRCBRojZOLhRHihVZYisk7YZjBMhp1A+mSMw1vAMbr80
	QMeSpUXEHR30DNTdl8klMbjx3jj3XRfA8SxzX2bsbyS8EOhsJq2hamJHeMtz5Tfq
	uJ7bcvjLLmgB+7ylOUXPsgJza/E7Tazgl/i1SYmx+fM+9lsctmAiiWy7YfF8QPlU
	oUv2cx67npHk8t/qNYqpRowFFnIyL8a/p6HB1+s/Jk0uWivsTzzi33aRnE10vgrE
	z3bB4JIRxdF2U6vQl5rzKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thq2n7rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 21:52:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51HJnxcA002146;
	Mon, 17 Feb 2025 21:52:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcekbud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 21:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeJKIv6vM1uhW7kgdkTo9hZMZEnsOHeLq9mEq3sm1rgnJ0f9eBj6tLhZpghPiQE4jVhwTPRWKTzgtNziHy6c0WNv/tGGVLDYROumuqV5IXd9PwRUKPP5vfY4tLSd9QzF+pvTaxng5Dp/mkNeFCTqLv9Uy/1950WzNCG6LAZILbpiZ/kYYabMKCglFevAcMBIDyE/zn38CzRrloSj1jNI4i3jbNDW5iyJLeTVVnZ+VVoYpdvJSyf1gR8Lj8XfmWqBioNv/46FnEzPLljx+yCxH9tzNGHE39nuotE4Wxj6RpnSPmuam4FX+EFRPBUswVLVyQHb42wpHZ/QLVr+H06J2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AUwxbCjVlrImogORl62eaSgQMC6M/kgDGkF5FCIk1E=;
 b=YpU9vShMUbhvMCJjMmGXFr0xUlFP7kSStSsbUohFbGLwOaNRgOR26jq/JeLl41YB2XHRxYZinP4cO9pS0d38QvQ5mjhFOLnUzRlCsY5NLKgUBC0UTZMLAVQE3URG9jGmQQQS5L5N4/pd8RjAo9i+JQ/C6JluLtelsbJi0mkRKzaYjFOEqUD+7wye7jMwlYioKVeovy6N9oU+KGrYvbcMXMQ93UJ63q/3Dfmg8GTBD3Dp4TFP4A/jPf3PQCpuRr3QcBOIMRF748PMdg7ErcrzzNnxl05lvpovE8GyRgf1hH34yS0zdSDX9SjqqgyMkyj6eNHYMc9rKdcxrA0UOfUd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AUwxbCjVlrImogORl62eaSgQMC6M/kgDGkF5FCIk1E=;
 b=ysdCFsjVFY+bwUJq/zk+NpxLIQIrzLlzAAsWASRJBAjETOL6KAJiGvNmihdRQSwXBL4DQGe6ZrzlbOfpgmKeQ5ZWY9IBgYgYJOZtdUezC6Jc2fv7t7A/MZ4yA4Ayvkkzeciv5z+oLHeySVpky3glPuUZVu3S+rS6dlpersCckug=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 21:52:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 21:52:48 +0000
Message-ID: <5546324b-1a10-483d-a12b-1baeec712658@oracle.com>
Date: Tue, 18 Feb 2025 05:52:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: output an error message if btrfs failed to find
 the seed fsid
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <c34c50a035111a83b3cb5c735f9a86a7d47a66c7.1739785941.git.wqu@suse.com>
 <CAL3q7H5EtidnOJen9d+tWu5Cu03U5SGhnB=Divp7DeTc=XbiyA@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5EtidnOJen9d+tWu5Cu03U5SGhnB=Divp7DeTc=XbiyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: edd07057-35a7-4b40-713e-08dd4f9d6afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTdxQ1lhQWk2TEsrNExucFJJSFZwNDRybjZ0TDdOVFZhZ1g0TjBZcmJDMDBr?=
 =?utf-8?B?OUpGdmZDSXBlbXpzV3A4d1VZeTA4NXp2NTJSMlBtd2lTelBPQWpOL3NpVm5o?=
 =?utf-8?B?MElzd2lYK0ZkdXFBcTZIR25kRlJiT3BEK0V2TWppenpmTjlPWkVlSzFKWCtz?=
 =?utf-8?B?RmljY2pvY3FaSzZodi9LMnlyTDR1L1ExQ2x3R0Mwek9CVG9BbHRsUDhmTEo3?=
 =?utf-8?B?Q1NXcUNicHpZYWhnU0ZNRzFucExodXVrcDFRM0poRXluNzdsaWMwR2ZLSFJ2?=
 =?utf-8?B?djI3cGxTWjZXbVZqZ1B2bmNnZEhIZnBEN3JkaEw1ekcrRDFsL0dveVh0U0RX?=
 =?utf-8?B?bW51dVFRcDBoVXdMNFRYNnMvNDVzNzRGdDdpZ01JUHp2YWlwSndWYjZINkh1?=
 =?utf-8?B?Z3ZPblRHM2tpdFRpK3BkNFAyMjBJUlk3S3FUbXQ3b2pOMjYrWER1NW15WVNq?=
 =?utf-8?B?M0k1c2dZdHRTS3gyQklSZ1JBZGx3eHRYR0NkSmF3ZTBYUHczRFhoeEtDQTcw?=
 =?utf-8?B?d3ZGcGNxM0RVS3A0emk1MVR6SkF0NnE0aDBPVkc5c1lldGNPdGV4TXBpNmtj?=
 =?utf-8?B?Y0xLUW52dy9sMWppbUNEKzZyR09UQzduc2l3eldaWlMxcG9rZzNwZE9DeUtj?=
 =?utf-8?B?TlYyckM2SC9iM3pPZmdHVWJ5Qm9aazI2WGhQWDllNlJLWXIwMUh5QnNlZkxO?=
 =?utf-8?B?RTdKcTZCeUo4RlVjaHNxS3ZNMTFrY0lpQ3lzcWo4VjIwQ3FuVlB4MzM5UkJx?=
 =?utf-8?B?K09vcE96cUNiTkJmQmtGUmdERGFtOTR3VVJVL09TVENyN3FVWFV4T2RtOHBS?=
 =?utf-8?B?bzZ0VUVtQkt6MjVpa05hSU5RV1RCdU9ZUlRtUi9JNlJsNTY5d0FIWHNKV1Bj?=
 =?utf-8?B?dVBycFdraE40NFVtY0cwbzgvQVdQc2dLTmdBMFh0N1AxQytXTXhyclRCa1dK?=
 =?utf-8?B?VG9zWEo3VWFoTlZDd0dmYWorczJMMnN3Qzl4ZmdmV25CQlVodjdGYldXUFZL?=
 =?utf-8?B?T3dlNzNvMUJlbjdwemtVOXU4akNYWHdjb1NORDFpL2dMa01vQ0UwUkhyRlQr?=
 =?utf-8?B?QmE5Ump5akZUU0Izb0Z0VCsveS9lTW5oSTh1RnVzUUtSM2VEMzg5RFR3UXhJ?=
 =?utf-8?B?WG1YR05ja3dlZklBQ25TMklIMGFSNysvSldMZ1QrNjlsVnA2SGhLaVQ1QjNz?=
 =?utf-8?B?TUc2N2RnM2FkMi80bkVUdXN2RGI1NFNyMklnOWE3NjZkc2xCQmtXMkFvYVcv?=
 =?utf-8?B?V0lYS2dXdTJuclZjNlN3WnE0YVFhZlpVbUo0NFVqN0hneitKNVlrZ1NxdDh2?=
 =?utf-8?B?UTJ5ZjMyVFN0aE55bDJJYnBTb3ZqV1U2V05TdWpkSUxROEFoU2xYRktLQTBI?=
 =?utf-8?B?SDdQUGcrK1dsM0JiVzdNc2ZRSFZaVTVoeld2alc0dHliV2Evb2xiL2t1UDZ6?=
 =?utf-8?B?SlVKZGlMUVBjWE1yWDRJWDFRUG05amIydE9iMUdhZnRDVUNvdnpHVVNUeGxY?=
 =?utf-8?B?M01XcnlIUjBpL0w2ckVZVFQ1T3RWekIrV2JIdHdxZm0wOUdxUzByb1VKTm9F?=
 =?utf-8?B?QlZ2ZlhXUnY5SDRMdytKdTY5YU9zU3NiS2E5U1ltcnVnNEQ5d05QVE5CemlB?=
 =?utf-8?B?RW04dnByaGJWMmkwT21SWmdtcHp3Wml0NnkrK3pZV1ZGeHVTVmhVdVBHRUd2?=
 =?utf-8?B?eFovZXF3WWRqa2pmNGl6eW5DVnRWaDArcnlYVXl6Vzd0VWh0V2NYUUhRT0hV?=
 =?utf-8?B?clVJR21OQkY2WHoweVlCZG10RGQ0c1JjR1F4eTJSMEU0RFFmVjNlc3ArVXNq?=
 =?utf-8?B?WFhqbTQ4d2JpQUc5RVNUZG1CZm5zT3VxUEdhYTNyWmxHUmswMm5LWlZzRUps?=
 =?utf-8?Q?z4XF2udCcU7yN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWxEbnhpNVRzNmsvVi80MHFmdUNWQlZ4WlIwOFRrTk1IRjBjSlRQV1JRMC90?=
 =?utf-8?B?Tkw2QVZ4WFpvR2N0bytFOGUrWG1vbUdnbG1idFBMTjZHQ0MrOXJsZVVzZ0lY?=
 =?utf-8?B?UmVZTFhjNnp0Wm5KaENxbXJBQ0lSRzh3SytYMmhDbVNmL1RrNVN3c3c2NThP?=
 =?utf-8?B?UUtNc083cndxOXFubzZhenFTblZsRzVPNGQ4VmxNdi9OUlZtUFJSYlljNTdQ?=
 =?utf-8?B?TWFmdjZ1NjEyNGJnTFJlajJtUHFiZ0dPZ2RzbDBOajZmekFiQXRqNmM1dFJY?=
 =?utf-8?B?SFZDSFZ1SDU0bndTWVI4ZFpHSVQ2MGU0RnEzMEpEUXllNGRDMzBoNWRUSjJ4?=
 =?utf-8?B?M2czeFc4QzJQV2N6SnRxV3BiQkpoRWVETEFsbHNDTHl1VW9ueFpLQzM5ZmFj?=
 =?utf-8?B?TzZZRUpNT1FTNXNJRUZ1emdiYTkyOUFlUDRkdU53dXQzQ0tJb1hGbmNjcnBS?=
 =?utf-8?B?akNVUENkZXhVa2VmWEMrdkYvYjlhakhCSU8wNFdsS3NpSlRVNHFCQjZZai9L?=
 =?utf-8?B?YXJMSm1ZbGxQZXh1amdDNE5od0RLUURaOHVkeFVqZlp3bnZua3VkYzZIakNV?=
 =?utf-8?B?ZGoxWXJhNDdwV3J2RzR0RlRwVloyRTU2NmVpTFg3T2lJZ254WVoxcHZwTm01?=
 =?utf-8?B?aTZ2RkJMUE9aWC9lMy9OdkJyK052RU40SmJJQjRiNGl5TSttZVJUR3NMRUxI?=
 =?utf-8?B?TjNRazhLdnczTHF5Y0MxZXBRTmJ5ZTFPV1ZDNDV0MU5BQUkxZHpVMkpwTjFJ?=
 =?utf-8?B?T1did1JINnNyZWllanozaGVRUnR1MElqYlBNRThLZ1lCMFkrNnRyRHduMEFl?=
 =?utf-8?B?TXM5emtCZUtGenc1SFhKYU50ZXZOajNNbHJDNnN6V2tuMFhPMC9BZnRVbmtR?=
 =?utf-8?B?VTdKRzZOZXkzeVdmVUtzVmlVUkJWSGFrMk96clYrdGNpQXQ4L2NLU3dkTDNs?=
 =?utf-8?B?dHVjY2M3TkhVVTdGdC9jWEJGb1FzdEdRL0Uwbmg5WUZ3SzMvRitDQnl4TGdR?=
 =?utf-8?B?VHl4U3c0RnVzQlhTVGxyMEgzYnlQMzFydzRXV0ZScnN3MDEvSVBORC84TmRa?=
 =?utf-8?B?RlhoSEtPSHJqVVdVRmdNS09CS2tJK0VqZ2w4eVV1eGdONkZMb3phNWpPWHRw?=
 =?utf-8?B?SlNrRXk1V3ZLKzQyQVlvRDZjZDZmMjN6YWo1Z1NPRVJ3Q2tHU2UwUCtoTmU1?=
 =?utf-8?B?MTBNYlZ0bzlFYnRBL1Y1ZGxzQXdZWGE5Y0lGd0ZQMEdXREJKa0FveXlQN0ZF?=
 =?utf-8?B?cVMxVmNHWXloRWtqTU53ZW9qNUZoa3RYUTZRNUNKSXBRYWhvd1p6TmVaTk9Z?=
 =?utf-8?B?cDZpZmhQMFoycFlxRkQzcVYweCt0bzBPaTFOcG1CY1c3bWJvbDlQWFlsZWsz?=
 =?utf-8?B?eG9wNXZzY1piejNMeXhHMFcvTFZhM0RCZXZwUWgvM09xSWNraDhrSGpoQUto?=
 =?utf-8?B?aWxoc1RibkUxMUgwNkpBcVlDYk9scEFoMnpHTGEweS9mNEErWkRRR1NGNXlZ?=
 =?utf-8?B?Sk5pRmsyKzU0bERSMHJFemJKYzluMlRyNkFSVUNYaXMwVGg5MGUrb3orblhq?=
 =?utf-8?B?N2pzWG9iZW14aXBic281bWUxSHYweVJnS0htZkZNMnprTEhLRzdOamM3d3VM?=
 =?utf-8?B?YmVhOU0wNkVIblU1OWorK2xIUjQweUszejl0elAxcTFMbEErYmY3ZWtIKzJL?=
 =?utf-8?B?L0lXMlJmRDRQRysxaTIrK0hEYXkvdGhXamNkTjhnRzFJd3JZenFYRjhHK3lY?=
 =?utf-8?B?VjArTk9QR3Nvb21RUm9LZVF2NGROWGVqOThXczVuTXFycEI2bGJVZVR4QlZa?=
 =?utf-8?B?ZWdxVTZMcjh1a2ZvOHRIOENVTHZOTUZGSHhKVm5UYnVFbm81aVpXR21ZQmdt?=
 =?utf-8?B?THZnd0NyK3RBbkRrM3I2ZjZTZ2ZMY0d2R2NlWGlSTloyT05GVDV5V0Z0TENC?=
 =?utf-8?B?cS9FTDQ5MUZjZSs1RmVrZkVDV21UMExBK2h5am1uWWpBdFlyRFNFRURRNDlk?=
 =?utf-8?B?bTJlcHVBVkN6S09LNmJRM0pTZFV1YUwzRU1LSDJ1SFljUHNXMGxrUHBhdUJi?=
 =?utf-8?B?NHVMM20wZ0NleXdHN01lNHlDcjV3NVBRbU5sRlRlM3V4dmZPWHMxc05taE5D?=
 =?utf-8?Q?IW423fd/RXWjARn2ob9MJ7t9y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dCcjwnluv6qZ8E+5cgXA4L40ops5whBm5u1f/B5sTNI+eAXGCpjGXliL+TvRlGzHg8t0J3jYJw9ZqKO9mWg/Yu6hWsyJ/bNiglZXpfLP8VSW+oN1Irm4GqoHCPbfeot/4kV4O5y5jdyWky2F9vB9+rzVzBVCHMlGskkHXnc/uYQAtnGZYXWWW5olCGjiWiXkk2p7RvBKD2lPYIUIoy5WVDHI/hBqe/0nrLKyqtOKHsoNMza0rCn/pXG+ntay4wgKM/5J7MjrCIQZbdDVr/sIA5eHdeOzVx66mNxQUWrnu+ZXA3uySnXoqptciBio2Zgv5sTc+GVbzxro3hGME+90+wGULEJ6BqF/UG9jRVoRvtzKV5M+JH4RtrmQCMKOgnHvXWz0hPnVNAeLNnmQ3jbvlD4H89aNeXyqf/mMnnqRa1t2k7ojOwgTxCcJ14gkHTyeUFLvbwSXtr1ls2An6lY9qYTmyBNVx5xbEXfOEIVSb2G/DofZLjY8ekYOsqpAx6/wAqqGEQ/GGpEYtG4vcPYiL0H/fBh2u/gPl4EyyABWyVIBtTnr85hIaVMIQUpN3iM6q29NLkzjREw4Y4eH97heZt8SVu3YSxSekDJZJ791r2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd07057-35a7-4b40-713e-08dd4f9d6afe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 21:52:48.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrCaz1wtZkXWCJ8uuemBxn2M4BiGMw9LTRaifypVmmYucvMUOPwDbUyUyV5DjeXJoF2PHymXIJ+3nkN7OoMrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502170170
X-Proofpoint-ORIG-GUID: pN-2okTHJ1Jy01jo5c17so4wkj10Z6QX
X-Proofpoint-GUID: pN-2okTHJ1Jy01jo5c17so4wkj10Z6QX

On 18/2/25 01:00, Filipe Manana wrote:
> On Mon, Feb 17, 2025 at 9:52 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> If btrfs failed to locate the seed device for whatever reason, mounting
>> the sprouted device will fail without any meaning error message:
>>
>>   # mkfs.btrfs -f /dev/test/scratch1
>>   # btrfstune -S1 /dev/test/scratch1
>>   # mount /dev/test/scratch1 /mnt/btrfs
>>   # btrfs dev add -f /dev/test/scratch2 /mnt/btrfs
>>   # umount /mnt/btrfs
>>   # btrfs dev scan -u
>>   # btrfs mount /dev/test/scratch2 /mnt/btrfs
>>   mount: /mnt/btrfs: fsconfig system call failed: No such file or directory.
>>         dmesg(1) may have more information after failed mount system call.
>>   # dmesg | tail -n6
>>   [ 1626.369520] BTRFS info (device dm-5): first mount of filesystem 64252ded-5953-4868-b962-cea48f7ac4ea
>>   [ 1626.370348] BTRFS info (device dm-5): using crc32c (crc32c-generic) checksum algorithm
>>   [ 1626.371099] BTRFS info (device dm-5): using free-space-tree
>>   [ 1626.373051] BTRFS error (device dm-5): failed to read chunk tree: -2
>>   [ 1626.373929] BTRFS error (device dm-5): open_ctree failed: -2
>>
>> [CAUSE]
>> The failure to mount is pretty straight forward, just unable to find the
>> seed device and its fsid, caused by `btrfs dev scan -u`.
>>
>> But the lack of any useful info is a problem.
>>
>> [FIX]
>> Just add an extra error message in open_seed_devices() to indicate the
>> error.
>>
>> Now the error message would look like this:
>>
>>   [ 1926.837729] BTRFS info (device dm-5): first mount of filesystem 64252ded-5953-4868-b962-cea48f7ac4ea
>>   [ 1926.838829] BTRFS info (device dm-5): using crc32c (crc32c-generic) checksum algorithm
>>   [ 1926.839563] BTRFS info (device dm-5): using free-space-tree
>>   [ 1926.840797] BTRFS error (device dm-5): failed to find fsid 1980efd3-616e-4815-bd5e-aa0d7c3586e3
>>   [ 1926.841632] BTRFS error (device dm-5): failed to read chunk tree: -2
>>   [ 1926.842563] BTRFS error (device dm-5): open_ctree failed: -2
>>
>> Link: https://github.com/kdave/btrfs-progs/issues/959
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 0a0776489055..7642fce50c12 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7200,8 +7200,10 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>>
>>          fs_devices = find_fsid(fsid, NULL);
>>          if (!fs_devices) {
>> -               if (!btrfs_test_opt(fs_info, DEGRADED))
>> +               if (!btrfs_test_opt(fs_info, DEGRADED)) {
>> +                       btrfs_err(fs_info, "failed to find fsid %pU", fsid);
> 
> Perhaps add here extra information to have more context like for example:
> 
> "failed to find fsid %pU when attempting to open seed devices"
> 
> So that it's more clear where the failure is happening.
> 

Agree. With that changed.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.


> Thanks.
> 
>>                          return ERR_PTR(-ENOENT);
>> +               }
>>
>>                  fs_devices = alloc_fs_devices(fsid);
>>                  if (IS_ERR(fs_devices))
>> --
>> 2.48.1
>>
>>


