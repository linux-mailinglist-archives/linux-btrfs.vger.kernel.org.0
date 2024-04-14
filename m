Return-Path: <linux-btrfs+bounces-4240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ABA8A424A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E91B21463
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04501E4AE;
	Sun, 14 Apr 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OFXbpZX9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aPv/43U9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D342903;
	Sun, 14 Apr 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713097939; cv=fail; b=fGG/R4j89XoMALDKyiVZYCKYNk+E6Rht0nd6drdX2J4JX8Su6gqgXCJUoITyXAYdUYeKxvyWKGctJ8LEgNfBSWgsFhVfoqTxWmbwBmyq7rrcOz560numjCvOFzsrXcYeVH/rqQlzwLAWuce5Tz1RcndUsLenI5aBswbhzvktwEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713097939; c=relaxed/simple;
	bh=MwcWaK/0i+mJ3SegMWm+ZFbeEe0wFlLb2Itxq49NzEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PJmpYAe7h2kobs5H9sTOUaLxZrIiQKv7bqxTHs3E19YGo7DB7WPGVwlD/fRzrFR75+0ZzIPOB9BjD2f4UfPy3NT/rppWgQ4MLDXS4ImkDWKdmxsbNw+v7kFdwAPtTmglDJWOQfoQUeg/7uA+s/ut6Nj1sRjQV1o72I9uJIBYeZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OFXbpZX9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aPv/43U9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43EBlOle016427;
	Sun, 14 Apr 2024 12:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kf5oqmgq8jtMacLqHbsl72N+3gAqVY32wDqvJGw1eio=;
 b=OFXbpZX9pp8rwtntQLI8sMsA9bDOhCi7kxlg48A7Tavh9sXBYE0mT1a86YGM56N5PWXu
 N3Sr5OgxuLZDkr3l2+XopsljTs8MFcf0imi6vebVrtRMMmityMKPIM0K9g+PxU6NFEUq
 I6YvdOlv+CFXZDQ3b8mwIPtDGJW36A216ldtj+xjRuUKq3p8ZPiPZ2LyyLHMcMEPCZKa
 uDh1qA4pMgjfzMIVmOXsQYEzJJWubxgIGZyxZ90G93QoZBrT2nIcVb6AEAdDJ1k3Dj12
 KnMX81vil1TOrYXEToWRoqBfbwRh4fWm6hZzDHUlfBjnxKY7SYysUPhqk9oxCY06jAfG 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e1beh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2024 12:32:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43E913ph029283;
	Sun, 14 Apr 2024 12:32:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg4sf44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2024 12:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+oZSiNwSlC7VqbzRAm5NImu6vXv+hoSEEiWOy/0UJF/86YlfMX5qZH+LZI0vxkDq5QTNgQ/sHJ7c9C5S2LM+EWrWJBIVBWvdzBE6InNzwRX/y5oHBu3uq1Z8t8HohqVHEnQOodQmQmcmFkYIEgHIaCN+pzm/i7/MSvTpcfwidybbHSCisAwHGVHK1hNXVHtNG79nCqxzNTApOehSESKZWCXWNGbe85FvcxHCbO7qOmUa2H+hWWyDwp5NGBnJdRLbq3ygWT45+ajxC7+sZymRircpdQWukyjUSIoUu8BY2RsZKXNvz6TZHt2OsWyKqKkcRydC/zo8Q+552verH0FAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf5oqmgq8jtMacLqHbsl72N+3gAqVY32wDqvJGw1eio=;
 b=bf4hHDqibKY2YGV9HwsE9RlMsQ3PuYJxM0hZePSHXHDL+sTqBnDZh0RlCRuKyZh35KW0EMMvYTfKwcis6M+tKvB7jqQkKu7ROPZPanvYHRktEDHAT557lx7hGhyLDnBkjNhVA6/qDHCdqwsOkh4dvP3gcsYGn2MeiyBpwFi4sTfM+DHmOtKDCQxsQSYbJvE1RT21KHS1c6M7fyywe3l5/nvakQTr6IT3F5C+003cI7/IFuL1ZxH4PuuGgeKQRNTdk5o2aGYQwCxZHPYQBcK/0Wi6f9g/l4oZbnk/0+VCRNu+8lJWZt8rj9pM0itfLCJ/d9qLRWZKFPdLI80BqBeMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf5oqmgq8jtMacLqHbsl72N+3gAqVY32wDqvJGw1eio=;
 b=aPv/43U9mYCQGF1AXCsGxQK1AtoSZRZQBTGGHoQfrudyw6YAr1sBrqu5NXCxYSA4XszRC1QpgUQubYPyysGADKZApIi1bZCubmdVuG1amRBOD5vB/YMVm7pWkzuC4TPJIR5N+MkqgyRJGJWCnvFbNX+KzqNsED+FWsft5k8xDtU=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by BY5PR10MB4258.namprd10.prod.outlook.com (2603:10b6:a03:208::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Sun, 14 Apr
 2024 12:32:05 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1050:a638:7147:a0d9]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1050:a638:7147:a0d9%4]) with mapi id 15.20.7452.049; Sun, 14 Apr 2024
 12:32:04 +0000
Message-ID: <be6e14ca-fbb6-46fe-81e4-dcbe23fa18a4@oracle.com>
Date: Sun, 14 Apr 2024 20:31:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes staged-20240414
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240414011212.1297-1-anand.jain@oracle.com>
 <20240414070848.cpr4micelcs24qsw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240414070848.cpr4micelcs24qsw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|BY5PR10MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec61240-0dc5-44ab-cb2b-08dc5c7ee411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4km65gYg3w0FE3mbDhKF6+bZuKsqhePqI7Z4+kNnlt0/bH2BwuvxzGFHlOzqU/1ip9yTVHodxAhxLZUy1K0wjEbWmBLP9hyhc/scCfa+o2kcA9rpt200jqzQK3LZRwJGhci7fnWG7pPPQqQGN2oNwT2Nl2RfTWnJ4tM1qlDk8zWjXD1PwDOa3gqqxgZr3wI/IoYYhQUI0PmOZHb4TN0NOwqgYsyGVHbp33TFrDKJJ9u1M+XdPxbWdgtVXVrQcNxcUF+dNIDMDgNNEG+QjnLYB9CGF+7UQiWDvCUgdWr2z1PZWQutf+av2RZ4Eah/weW8SJ1pTq6bJF8mPjfMnZTtXhXg7x3DG8W3sTUijKwPvY1zwB5kOQ+U1hOymPxUmpC8CwL9zgAjpJ4VJBEKerXw+1GR4vbCHkVOvITbIJL/kJLox+MOlEXQlP7DiGkil4m/JKJnoYBUO43Nnzk9CXsfT7C+m5s9XV/Th4FOEwyPqd/KzolYvZ3wiNMn2qXS7Z1EQb2apNW9274lpm/spSmXzFGGFkYQQUzWswo+cLjXxtwhAOvrEfxC78ATbd9ZEUNMQr6KddXOMeClGbul6WCk2r9iFGnwGHlKoDDj6w1rzSQspvWBZscUGx6SipG+e/02EhtFpYdVDXHBjYd104URDAdNP2cixQfjuZR2rVGAggc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1NMci9zSmgrdHZQNHZmdHk0bElTNTQ3ZTVCTHBXMHJnTmFxZmdoS2wxam9p?=
 =?utf-8?B?S252ZStxRkFWWEErNlhMMnlPdDRlbnJweDBIUEYrVUUrUjhSaUNoWFpIMmpZ?=
 =?utf-8?B?TGkyaytqeHpNRTZOL1NPZWxUamhrZDhIcUFmckc2bjN6K3I5b0k3QW9CTjhq?=
 =?utf-8?B?VmpKNG1pRFMvajNrU25VL0lFNG12R3VaRldCdTRRT3BTcDlWVkw1VitUSHZv?=
 =?utf-8?B?elZXQzZzc2hoK3RmVjgwejVTZzIzS1hydUxDRldWRVYycEEyQVMyZGo1S3oy?=
 =?utf-8?B?UEsyNk50cVpVUkFEaGdHYUZzcEJudXN6L3lacHMvRTBLczFwczJkWktOTnZ0?=
 =?utf-8?B?dUNCL2xRYkhiMTNuSlJxdEpRaVRubGlJc0FDVERwNWJIZ3lxUFZFU2xJL1JK?=
 =?utf-8?B?UkE2cXg0SUhHMFgyV2thdzcwMUhyVE9zR295aGNNMVBzc3JrV0RGTlQrc1Fk?=
 =?utf-8?B?dWtocHdNanh2OUtacXlxRHRxVTRaelRVZS9XcURvTExhTityWmVsMVF2b2VY?=
 =?utf-8?B?Z1pSd0J2NDIvRjladzNpcmI4djFwZ0szYTF1YW9oNVJlZTUyQVFVSkxPNklY?=
 =?utf-8?B?WlhvYnlLL3Y1RzAyZlRyVmlrUHYzQ2NkdUt5YnhzL1lWUHNVa2R3aTBodFo5?=
 =?utf-8?B?dmRkaGN5OHBSR21PYzJIYUZxZlNQMkJVclFkRVlTK0xHalRBQk5ROFN5cTNq?=
 =?utf-8?B?dG5lM2xNM1lPWVd0SkY3bHRSbmZ6Z1VLMFBUTDcybEF1R1hFQmpheE1Yenhn?=
 =?utf-8?B?ZktVZk90SGxQME1YcVh0NlhqTFl5TzhsWFlvREJTc0xVa3hvQnhZRTR0Wkx3?=
 =?utf-8?B?MHFLV2NNOGM3SFNXN01FbDAycXJ1VDBXZjN6UEk0cWRManV5R0QvMUxtSnIz?=
 =?utf-8?B?Y1lNOTRsZEhTN3k4VTZoOEJjelhCWVZCWEo4M3NBblpTVHpoTlQ5cElnVmZJ?=
 =?utf-8?B?NjNCbDF5bXNZMFI2WUt0Q0cyNWVUdHQ0Zjk4TDNoRHY0RHZtL3JwdGp2MGZV?=
 =?utf-8?B?eDNGNEVoRS9zL2Y4WngzbHd0K1JoUmN0NkpKRkhhbFdXbElqUmNIZVd3dk1v?=
 =?utf-8?B?QXRwOWZkbWxiVFdIRXZkQ1E1WVFXTWdoVmZsWUUvcDJrUTNxUEdnbGJIQW04?=
 =?utf-8?B?VE5kbDdyajUzUEU0V2w1RjhUK2JQMnVoankvZk1wa1BueXVlZDlkRWdWVitR?=
 =?utf-8?B?cVpERmt2RXVMQWRobk5YaVN2MkMzMGNoM1VHai9MbUxUUWdlMmhWYzk0NGlt?=
 =?utf-8?B?Rk9sWWZsSUVQbG8xdnYyZWNCT2pOdEtaWWJ0N1Y5RTduVjRtaFVKcDZ0Wmdw?=
 =?utf-8?B?NDBYMXlKejVXWWZOeXFBTTZqV3drZVZCT1BZNm9BMzFyR01kYWVnQzhYVjZt?=
 =?utf-8?B?VW1vSERrM0xoZm1JSFgwYmV1dUd2TmM2MjA4RzVVanpRU3Y5SXFDZUIxZDAx?=
 =?utf-8?B?MXpsZTduc09GK1VkUmEyYnJXR1RYcHVFNW1HWWZZUWVKNTlsYm1PRjhGb0Nr?=
 =?utf-8?B?VFRyV2RUU294aFZWaGxTc2hzbXBHTXREMithM05Hb2Y5Y3Yrblc0UzV5d2xL?=
 =?utf-8?B?RmtNUjV2Zmg1bEorM2pyOUJNQTRqb1huRkJ1MXFEUThGcWROYlhEUEU0Y0t0?=
 =?utf-8?B?STZxZ09wTXdRWEM4aHRiYzVwYjdKdTZPT203TGJ0U3pwZGJqaG9uMHJEMVV5?=
 =?utf-8?B?YmZMVVpNTVpPaGMyYkdTUHRKdDloWGNJWE03eUJOamd0bkpDbCtqOXR1YzNY?=
 =?utf-8?B?UjEvbkpiL0J1SU1vaHpvc1FZY2U3L3lWZlF6TS9xNEpjOSszaDBqdFZ3Q2ZF?=
 =?utf-8?B?N3BUVkkzMEVEOFlMcU1Cd2N0R0xObWRvUlpiTFZzWUlMaWV4MC9KbnJMZ1dF?=
 =?utf-8?B?NVQ2dVMzZ0NEYnhRcTlNdjJVdjV3ejdpWHB3TnhDVHovTnphWVZNUXFTRTgy?=
 =?utf-8?B?UXllenlPNkhMclZ3SWNxOHc4TEJKTXhUSkhmY0ZPcGpvVysrZTdYamxnS0Yx?=
 =?utf-8?B?aS9YbU5SUlFXMjl6MGluN1JlSTB4NFlCdFBWRm1CQW1XekpVbFZwcnh3YTdD?=
 =?utf-8?B?dk9ic2o4ZlVWYVFjcmw3TDA5NEo1NEhHSU8zRHgyNFVhREV6TWJGbVY5VmRx?=
 =?utf-8?B?TDlJMnM5V2ZvMEFENlYwUUg0N3VDajFtN3FudkxXRW80bk5XT1o5MjMvb3Rm?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vCB7QvgCCYJ8IeL7aeLgE802SdoHOr4JwPrYV+Dwrl2MZ3JPGa7/MIeUuxJPmr6fzqZo9kOD5Q04C4kB0M3aa8TcnH5U5Jfqx5ASugwhIQhPyMjoEr1LslXdK6x1EzrSzqTgTpYxctLh1HcVa/izqJmvMT99EuwLGA/PAP6xs7ibJN5/T+QGalD+EopOJyp/2+gZCJKIAEuSd6Vb8QYSu7O9WpwxUftr/URSZohMFRWvssASfJCyKoNWiatp5A5xFNGv8Y4K3z64HqWFJVx/9R/LCMrcwynKSlYmgsyWHubYsKyXlonr/mehUF6kFGnoa9jeQNfUwgsLga3xBR8NPFmETsCRLIrqMSuHkgHkW0MwSnDoMEcX9a0uBZvr2w0Dz+M5CVrswbi/2g0iMXWDvuktS0p/3gD5QPN5Q6IEZ/oGemItOmwhidKlsZZjiYxvnNvfayKnJrrL/Zz4n8mxE29R45a7wcDFdT0QA7GjprejBw9G01hsLX2YmeJHvCrrWTA5Pk2SNHurQkK2zdAsyFKh4T4eS0YJIhbs9wghAkvDqiNxZtSAK5I+M+IZrh+AkHEbYmpClVxeiberV0BIO7xp/TxiImUp6Kacqqjb16I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec61240-0dc5-44ab-cb2b-08dc5c7ee411
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 12:32:04.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQXhNA+R0JcYGBCa1eYe2/8Rpi3LDJ8iljlW/uccHayLey0NB6jCIJv4cdsuulxosLsOVgjx5Oficmgp0UqFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404140090
X-Proofpoint-GUID: 5JZW0ySKmHwhafayYfdiggB7QENHsQ5Z
X-Proofpoint-ORIG-GUID: 5JZW0ySKmHwhafayYfdiggB7QENHsQ5Z

On 4/14/24 15:08, Zorro Lang wrote:
> On Sun, Apr 14, 2024 at 09:12:02AM +0800, Anand Jain wrote:
>> Please pull this branch containing changes as below.
>> These patches are on top of my last PR branch staged-20240403.
>>
>> Thank you.
>>
>> The following changes since commit 8aab1f1663031cccb326ffbcb087b81bfb629df8:
>>
>>    common/btrfs: lookup running processes using pgrep (2024-04-03 15:09:01 +0800)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/asj/fstests.git staged-20240414
> 
> Hi Anand,
> 
> I've nearly done the upcoming fstests release of this weekend, I generally start
> my testing jobs on Friday night, and done on Sunday. So, sorry, this PR missed
> this merge window, I'll push them in next release if you don't mind. Or if some
> patches are hurry to be merged, I can increase an extra release in the middle of
> next week.

Yeah, this set, and another one in the ML, are larger changes which
almost touch most of the files. It will be better if we could get
both of these sets out as early as possible so that the next patch
being submitted, if any, will have fewer conflicts to fix. Plus, the
CI test cycles will be clearer. I'll submit another PR by midweek.

Thanks, Anand

