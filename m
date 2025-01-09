Return-Path: <linux-btrfs+bounces-10875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54BA07DF7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 17:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B4916863C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8F4143759;
	Thu,  9 Jan 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAsAaCy6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UkjnySzl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070413AD1C
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441148; cv=fail; b=EgpGCBbbDl8p7WE6tt9yF5GVACGrTMnRN9QXDKJv7wI8PbKyuCPyB4VBkHyRi6U32133hCRggxGvJcvk7DSyWo5MFsKbtbNXcjKiLQ5iijX1VFlifwxvRYUriFjk8edjhxOuWXvqzYqoHISY0bsFFA/S+w9lgTccQnSnKSIS6kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441148; c=relaxed/simple;
	bh=T4vbvH4bgtxM3/LkrE/vg08IDJDKnDyY6ruL0NhHSjk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXb4UmyJHMjDVaFpNnnGV7BfIGKl5YB85pRGaUfg2A+BMXtxFAxPgwYnyYQuTvKffY1JMSvBDVNOwjpEuwqCArjSGR7eCowxVV+tmlDphrjCeR2pYedA6NuCcFkiT5aVJYJF3d2+TSeYEJIn0T6ULrrAQMweuJM36JbUPsDZuT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HAsAaCy6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UkjnySzl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509GXpAB016264;
	Thu, 9 Jan 2025 16:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z+yUdmieGqlPJsH+WCEXYP9WOdosC8tkJpKMqkmV3p4=; b=
	HAsAaCy6TL94dval7X5eLCyUNyrwb/0o/uXtgZMJMP4BuYO285iYtMnuju5EG0Ia
	uArl8oMUI+Ac+sOuzMrv7tjyJIaeW7DJGD6kc9hNkA2a2kTIta1mGg5lbksXCUrg
	pmfYLB93Qeud/m6tai7NSary7N7BbJJj3agB2VgW3P0nSKF58sJQF15PVZ3QG7An
	eK+DaLKghi2JYHUoQ65tfLi1uTmd7XuZO9XYtqC6qIi1ep6+lZ+6NhZD3oa8/uaP
	DwdlVbXkWNKD/+kxfSZsMNQjyq7BLLMa3LvYKE8XPoM5VBgontPCe9JhVY5bI3d7
	zvk4Xawik5NqHjpnU9ug4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8ugu6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:45:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509GBn2g005424;
	Thu, 9 Jan 2025 16:45:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuebap5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXuSEbk3DPy1CU1Drjb78N+0FApjq+D/0Hm5IndCkdnqIEM9XrNkLokDhHOnLrtK9jw5BTA2FNn9ScgN7apF6TwaOe10UFjXoaXwnlO+tRyNXjg8/miWnoLbSBmEB7G0f6wh1PpgCADzuAwW6YBWV7X0j6sMbv/kn6IAojmgijO6MxveXgkjR7Ex0/cJHuW8+Ca4GQe6lw5HbUdUlaOxzvAogiCgdKl14bwU35AhobAQjHYDGG3fliAjxJeLenhA53YewKzDYzKLQGtHB65GisjWB8qccHQj2UTMfvZI4T/3j/woeBeeBOghBrM9s90Unq40vSVMEUAibYur3Lg23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+yUdmieGqlPJsH+WCEXYP9WOdosC8tkJpKMqkmV3p4=;
 b=dBXXXgfUr0lh341yBMUk1fH7SzYxgCbzW394rJrqKPEcddB8mrJgooWPtQXnUyO60+9P7wgQ/BCedPsk4HyheLSuAFntpkjsS8PHjWOaEPPTwzXdvqmJHjZYQBLaLQnPJpP9WB4PyEDtQMasTBvIAYgJ518YGvIPeYImVYKy5NoJB/tdSgDwNYyCoayuGG2LtwbnyEaY2+YnYCdZiTMdZOYUKdMFPxozwCzXUDo6KtJlDiiiqDuQ7hufuHcynZnSqv6G0yh9fv8WiCyGnTRJBVhwNh6apRg9Hx4gT35vaNbn6OPX/UuFoiT93gfLzf8tRAIkSAhr+ZqyaKx0S/bJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+yUdmieGqlPJsH+WCEXYP9WOdosC8tkJpKMqkmV3p4=;
 b=UkjnySzlCjTqtgNzGXpRuo/FOf43/JOAN1Tairoa/RNj3vUSjb1kRfOqQfmpokrTOQ8WD7CQMzzOKELcPF2eYuHf/qfbfIB4iF+QnVnwDff65G7racm0rEWyb+vVpRXe8CxLKP4feEuT3ySBHl90Auo9Ldh4Ql6JJPXlNteF/jI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6286.namprd10.prod.outlook.com (2603:10b6:806:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 16:45:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 16:45:41 +0000
Message-ID: <a1f9cbf6-8693-406f-a6f5-5f86a6e36426@oracle.com>
Date: Thu, 9 Jan 2025 22:15:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Random cleanups for 6.14
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1736418116.git.dsterba@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: c42f8fef-7b30-49fe-8408-08dd30cd0db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmxIaU93STltT3YyZ2psQ1hUOUZ3NHRGbXowbDVrbmFieUpJRXdBNk5JQURr?=
 =?utf-8?B?cmRSUTVKaG9BcmJXWlZtM1ppZW9LRENTcml5dFdqOW44M0QrbDNWc1kyWURj?=
 =?utf-8?B?T290c0RQYlEzM3dHN2NCTk9acUxZZUFWVEZqNzJLMEZ1ZlErRDdFR1ROa21P?=
 =?utf-8?B?c1M3MThkc29QaW82M2l2YktoVDIvdXRaUnlwa3hrRTgrUW9MTjNlOHhTcTRI?=
 =?utf-8?B?ZGJvZUZDaHU4allNemYyUDl5UFJCMENIVTkvd2E2NUpkUkRPVURIR2llenVr?=
 =?utf-8?B?bHQvb0NkUmpYRUplaDlGQk53bFVwcHZtNzJ5RTNmVmtMbGFhd3djY0RWZG81?=
 =?utf-8?B?ek9hZ3ZXWnY5eWk5U081NFRNeXhiVWJVcWQxREFEeTJZWWZFQU5WTEN5MHFt?=
 =?utf-8?B?cGZMcm11RzRhc1lzRWNaVFUxNUR6dUpPc1FFVURteDlQeWU2UktPRjA3K3ZF?=
 =?utf-8?B?VVdhSnB4MGlTTTJUdHFPNEhLSkNtdFYwZ3JJSDEyd2V1bFdJRjYrckZHeUU5?=
 =?utf-8?B?bEhDaUlWNUJYSUZsYjJ2OFlGS2Urei9SdzFQSUtiY2ZjeG1ReUZnMlIvbktq?=
 =?utf-8?B?ZjlEbm5KRmdvQmgwTkJ6NVVoejg4RzdLMXBxWHBDeU9MZEVZRzYrQUFNYkhM?=
 =?utf-8?B?a0xsL3ZtTzRNa0ZSU1VBREhHdXBibk11b3RUeUtqVnVUVGY0cVN3TzAzalpk?=
 =?utf-8?B?b2x0bHVxTlFNM3dTSkNlbVlDNHNxazNZTVNUQWhkM3FITHhHczFuUEhPT1hK?=
 =?utf-8?B?MFFUTUlUalcwdHNRSEExbEpPZUlyb3pwUDBpWHZUajNmd3d4VnNBc0FNSnNY?=
 =?utf-8?B?TmJMbnpyYldCSDdzMVg2a2pBRUJaUVZkR2tMQWNCY1gxTnA2Y3pOUzZnNWg1?=
 =?utf-8?B?UE80QVI0Q3pTUEFHeVNWVlBmTjdsazdJMU1xSjIvbWhvWHI2SVpNajBHRWRF?=
 =?utf-8?B?eTZOOGxtWmdDSUZxampkRmJ5SFF0VjllRXJGVzN3dVNzdDFyNGUvb3pyYmxW?=
 =?utf-8?B?L2poZFVUdFBEaHo3bkpCQ0FCMEU1dWltOE1PbzVkYzluR3MyUUVRbUFobzEw?=
 =?utf-8?B?TENxMGtpKzNXalZpWExueDNSc1d2NUxVQWZVKzB3ZFhuaEdCZzAvOElZQmtB?=
 =?utf-8?B?THg4UmpIZnloQm14UUpJRHpSTDYrcStGUE9TTnVYbG9tZTZOT0oyQmZ0YjZs?=
 =?utf-8?B?cmJHMFg2ZUFNTCs4MkpkSkFJSE03aXEzV0IzQXU3YStQcXRRVUhnR1ZtQVJq?=
 =?utf-8?B?dWpBZUg5bnpzaFpMR3pydldCTjZaRUIzbDZKaGowYlhqZTdUeXcyOWhuQXMz?=
 =?utf-8?B?dHpNV2o0ZmNRcHZwYkwwK01wME5VYUlYNG81OTloN2NQeGw0d2p2ODVMWE1Q?=
 =?utf-8?B?UFIvVTg1ZldLWGorREIvZmRCYjZRRU1MblI0ZSs0VlJSeEpWSmtnRlY0RDdQ?=
 =?utf-8?B?VmZpeFhSbmJ3M25LTyt5UlQ2VFAvMTJzWi9xc3ozR0kvTXAxZ3kwZUN5ZlI2?=
 =?utf-8?B?QU5NYldRZzJvSElLN2dDY1VoSE1sbDIvSmR2TnhuMCtaVFdCazZLZ0RTZkwy?=
 =?utf-8?B?b0dlR0xJYmc4ZkNlNGx1YzBWNlErRjVyNjlCQkpvUTYwOG1USjVIYVlvdGJp?=
 =?utf-8?B?UUNYeTNra09JOGhwa2s0aHBVWEdmRUN4ak56STVqQTFWYld6bm5oMmtKVE1n?=
 =?utf-8?B?ZlRVbENOM01BZ0p1TEhXcUliZXN3cFFZRms1c1RQcTRJV2hTZ3F1WWZoM281?=
 =?utf-8?B?UGZtV3lmR3F3b3A2K2RycmQwcXZETzdTVklLd3o0aW1hRFVPTXVFYS9kZXNq?=
 =?utf-8?B?dk4wc3J1K3k0ZDJBVnE3ODdnWjlGTEQ0d1M2eXQ3cXAwYjJiemlxZGgzYkNC?=
 =?utf-8?Q?z+e8CA5nGksDH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlNjYkdEV2FhSDc3THNVOW9KMG42UFZ0alBtZnQ4YmhpdUZsWEZsMTluWXNF?=
 =?utf-8?B?WXFseDlXRGpQTUlXSzkwd0NYQkJtV0lxQlpmQzc3Nk5kVHY5NzlxSThxS1J1?=
 =?utf-8?B?Wnp1RG4wRTlYd2dnaWdwY0NUTGgxME9SQUQ4OXI3TXd4NGxNYzI4cDd1dGV0?=
 =?utf-8?B?SXlyYWU1VDVpK01sZmlZY2RoN3V4TFE0bkpDbS8vbjY4K1pHNkh3K01hR255?=
 =?utf-8?B?NktwYXZTYklSSU15WkM1a20xbzJlNTliM2JQM2FLWkxFZVlwWldXUVVtMTRo?=
 =?utf-8?B?d3NEU3lTRmNMVng1SzFnV3ZzMitmZk1OTjBmK3FtenMwbzVWbVNVYU1hYzlI?=
 =?utf-8?B?WTZMa0hFNEY2Z3pYcFdMb1daRGxZZkFycDBSVEEyUms4dHZGVmJFSHlXb0sz?=
 =?utf-8?B?M3pUclkxRFV1MXNONWwxYzZRMmc0bmV1YklsbVJDYWVVamZoK0VxeUE3M0M3?=
 =?utf-8?B?M3lEZTkva1czZWttWmdDbzhQczRkUFNuVlBkdGlnVmJQdVhWYUlZQmRBT1Va?=
 =?utf-8?B?azBkWElyVTR0Ti9FVVQySVFmWVl2aHI1RWtYd3BLejFqNjVEVUloRWlrN2Rj?=
 =?utf-8?B?Sm1RNEZ3L3UzNC9BKzBIcUQxYy9DMnhwNXQ4WFk5QU0zTEEzRFpGTnZTQ0M2?=
 =?utf-8?B?Ylp5bG5TbXo5Y2FWODU3cDhvcmExN3lNUzVlMHZDRGxlcjhjVUNoQlVFRzVY?=
 =?utf-8?B?ejN3cXpWRGZTdkdOSmphb2wrMW5LaGQvS2FpOTNWSGxua003UDU2eVdwVXpB?=
 =?utf-8?B?S2Q5MjBzSFRRaUtJWnloL0U4dHF4RXUxR3NqR083S1dZdklYREo3bFpaSnVT?=
 =?utf-8?B?aGxWTE1SZjEwYTBkdnQ2b2VaSC9LQkQ1UE1idWdaUGhhUXpvRTdJZG0rTTFv?=
 =?utf-8?B?YmlTdkhmeU96aHRHQ214bHRUTUt4V3VEbXVOdW4vL0N0ZlAxTGhDdzlBOUh0?=
 =?utf-8?B?Z1Rvd3VYUGtzVXltV0xSdkZnYmlQN3R0ajI4Q3RlYmp0U3dNRHphaFh3WVJR?=
 =?utf-8?B?UGJqODRZM25ONnl0MkZGOXExNytnU0h6eUdJODM5bjNzMERrVjlONmNSYnlw?=
 =?utf-8?B?L3NOeTQ4cDQ0OGV3WlBRdjV1dFZJdllpd29mN0o3VXM4NVM4c0d2bVE0Vlhv?=
 =?utf-8?B?STZHTk00UGtTcVlQQnN3K3k0dGxJTSsrczdnTTNXTHpwd1kreHN2NzFwRG1V?=
 =?utf-8?B?aGR6Z0xGUUhHemR4V285d2dKZ0U1dGZkS3ZSVVVxWTlOVFNwU2orYlorVTNP?=
 =?utf-8?B?aXY2V1BJWDl4TE44ME05cHdCVXZXdWc5d2dxdXJlaTlTR0xuUW9DNzdjWlhL?=
 =?utf-8?B?aXA0Z1A2TVo0dFRkK21LOTdlZGZkakd3c0VnelJMeVRKVXJYNVJCQ0lWazRS?=
 =?utf-8?B?YncwcHNNZ09jdWFTL3kvOHVQajFVM0UyVVB5WXNBK3MwMXMwSXJtU0tNNXNG?=
 =?utf-8?B?T2tnSmlObndybUlDZ01DY0VVVSsxQ0R5a2xUdUZzV0JLaUQ1T2ZZb1AvL000?=
 =?utf-8?B?WUhiZy9QL2dzcFJ5WmQvNG01MkdkdWNiNDJBWmRHRUJHS0ExT1EwZmovcWNq?=
 =?utf-8?B?ZzM0bDQ1NnhEaHBtWVkzQXVwQjNMaW1rVkNVUUZ1QlVScXJaMDFoYTk5YzRJ?=
 =?utf-8?B?YTh0N002NHVPVTVGeFlOaUJnUldLemJaNTNic3UyTktseGZaTFhReVZQRS9P?=
 =?utf-8?B?MVl3YWxhVm9McjB4ZHJ4cElMY2lUL1drRm9YS3dMR3J6eG9LMDRxSDIzb0xR?=
 =?utf-8?B?dFF6bDVYcDdTY3F2WHQrTTlHK1BaMGpXdVFUTGJRTUltYjIxTTY3WGVQS0xn?=
 =?utf-8?B?MHhOaGFYWm5iRXdON3QwemlreTVzUENSd0JTOTJ2cFVZai81UU5UMFZ1NkY0?=
 =?utf-8?B?c3VqTEFPQkJxeDU3NlY3NExtaU9pRVFUcTNGVGFZNUh6KzFTaXhrT2tnTkx0?=
 =?utf-8?B?dXFLakZDend2TS9qZFhVZ0owQjA2b0VuazV2aFZNUHhvL0cvMVEyV25aQ1ZW?=
 =?utf-8?B?ZFBHVno0SzVDOVBLVWlmZEFobkU5UFYzeUFGSXFpYjZoeG12UXhhbmZidXBW?=
 =?utf-8?B?UG1qaHhIOE4rL0dxbUVLZGZTQnR5VmZjZjRCNWlXZm9ka1prMUNyVllFOFdF?=
 =?utf-8?B?VHZqaWxiKzBJaVVxb0FOU0Jha3V6QThEZiswVzlTTElka0xtQUw1WmJqdUtQ?=
 =?utf-8?Q?NCeyJsiz2WIJlchLsuV7anVAyGTPGmBUIcaxnsu7kphs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y7XajKq2rrtxhdl9l/82tZRT2sVHTjHy2mmbMjtrUL7wPmqmC5m1bIN6IDy1w/kMpRreN9hMWWwOy1I14mRBivhGc91ecn4/hPqEGFfJGBdo26zpbEwHF6WRMPQOoBlzTb7B8akV6rebu07QfIhZw1HUZQkIJT3WaReFqMwor/iViJLF4pCmXYpv3NnfFpFnI1KVwSlJ4/2fu1T633iitOk9ZnH0s0Bx9Lm+Mrlu5uF2YvLZH5mdMbnYjpupds8WYh+BwZYOL8UsXVzoPV2hDNL5UuETrfEW6uRBO153sCXkLxCymgzBCMjQE+ja96fRPQfFTN2KHqop+v5b391nEAdJ3h3vU3inkEnR/jkaHwCLs8yLVo3m8GMtea5HkNCiwQdIh5A/JquQCJOBG2XviWRxzGkI5epWE7YP0+I9CmyI+A5lHb9a0pOnRrr621414CqArTwZgQHJgF0E+t3ryHC1Sg3KlpYaCpqnukl6+TxKBfYr386KWsDCy9PMp9iZvLs9DMXmkpqluUSt70sCcab98PqflpZ6Yt/bs46jdBDJnj6IDivsfi2FXTx1k7ZnJaw4xmV0th1UWZ9WSlnXCxSHJGsWMuDrWLG73A92h9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42f8fef-7b30-49fe-8408-08dd30cd0db2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:45:41.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMhZK2dI3w1opjPLXFb4bjP1t4obUQomg4BCr40nCVHtFROFgD9CSQPkkJgu6Zz2gNQUEK4dUhz9MY2CG4cNmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_08,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090134
X-Proofpoint-ORIG-GUID: M_Dcp4TsrHOGB_aizEFReI-IjUw_n-n8
X-Proofpoint-GUID: M_Dcp4TsrHOGB_aizEFReI-IjUw_n-n8

On 9/1/25 15:53, David Sterba wrote:
> Unsorteed small cleanups and renames.
> 
> David Sterba (18):
>    btrfs: drop unused parameter fs_info to btrfs_delete_delayed_insertion_item()
>    btrfs: remove stray comment about SRCU
>    btrfs: use SECTOR_SIZE defines in btrfs_issue_discard()
>    btrfs: rename __unlock_for_delalloc() and drop underscores
>    btrfs: open code set_page_extent_mapped()
>    btrfs: rename __get_extent_map() and pass btrfs_inode
>    btrfs: use btrfs_inode in extent_writepage()
>    btrfs: make wait_on_extent_buffer_writeback() static inline
>    btrfs: drop one time used local variable in end_bbio_meta_write()
>    btrfs: open code __free_extent_buffer()
>    btrfs: rename btrfs_release_extent_buffer_pages() to mention folios
>    btrfs: switch grab_extent_buffer() to folios
>    btrfs: change return type to bool type of check_eb_alignment()
>    btrfs: unwrap folio locking helpers
>    btrfs: remove unused define WAIT_PAGE_LOCK for extent io
>    btrfs: split waiting from read_extent_buffer_pages(), drop parameter wait
>    btrfs: remove redundant variables from __process_folios_contig() and lock_delalloc_folios()
>    btrfs: async-thread: rename DFT_THRESHOLD to DEFAULT_THRESHOLD
> 

For the set.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.

>   fs/btrfs/async-thread.c     |   6 +-
>   fs/btrfs/delayed-inode.c    |   5 +-
>   fs/btrfs/disk-io.c          |   2 +-
>   fs/btrfs/disk-io.h          |   3 -
>   fs/btrfs/extent-tree.c      |   4 +-
>   fs/btrfs/extent_io.c        | 143 ++++++++++++++++--------------------
>   fs/btrfs/extent_io.h        |  16 ++--
>   fs/btrfs/free-space-cache.c |   2 +-
>   fs/btrfs/relocation.c       |   2 +-
>   9 files changed, 84 insertions(+), 99 deletions(-)
> 


