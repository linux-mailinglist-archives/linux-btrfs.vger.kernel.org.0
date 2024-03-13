Return-Path: <linux-btrfs+bounces-3242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED58087A5CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 11:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42F0282A21
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15E14014;
	Wed, 13 Mar 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WzkjjM9+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gh0Z1ekN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E73D6D;
	Wed, 13 Mar 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325556; cv=fail; b=HSXYnSTw2l+eXbWCE57UUvS6Qt4r0OI3FqMRkPQ0ZRQruIq6TumGi5souBWxwkCzPASPYPfKliA7milGMFVDXlWya4s2OvMVFJHXXJjb6v0PuXmiIwOGGlk0bdNFgurfPbmBy3f/7z17V/EolKIQ5nnVKcH+vpo6uSHzwSybZRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325556; c=relaxed/simple;
	bh=VHIdp0rd9Ml8EXskZjVcZn0nFZ3hu1FwukTH9+yKm90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NLcZxdy+4UOpBoLeUgzKZU4Fm0s5McfxGPySoTqPBgGt10UkZ09bAkWg4Mwb/4yg9s4Cf7diSVmkzQs94Nm46R0eunwRtvg1zLY37mw4bsW5/H+/NyhpA7nyYWS174hCy/BqLxmgZUTIKjdUUCZdKWL03Ry2t6vBbQ1a2J75Pww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WzkjjM9+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gh0Z1ekN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42D8ht5o026141;
	Wed, 13 Mar 2024 10:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=60wCeFEFtOaZAecKvXzid7WgTTj8u1LPabdVQt5nFYE=;
 b=WzkjjM9+VM+5YhEBOLOIOueDIWVhiuaEktU17hg/XZtif8w/ui8epCkrQvU3BcRJgsaB
 G6fCUvaavDA7+WJzXQds/1X54oGC0FyHnHsDXcQJY+L4VMIgWMG9SQlEzQrKd7tOUxUj
 Xs+sonT3cLxhaXuvNgRVZ8LldX755P2tt0xyPgDZgaRndf+QnR0ZrwYsSdFV442XrCK/
 aU4WAGyYfZnDzaXgJFPw9vGaVSZdOPRmVvfx347a1utnjXrGYfSO4RAkMkbuh9GmZGit
 JUJjBKdrBam2MKR9d8DtZwfT/5rixVT4INs35u5uV0Ks4vhtRjSs4QrbCq8gUovyCo4P 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcugp5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 10:25:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42D8ofBa028649;
	Wed, 13 Mar 2024 10:25:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre78kdvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 10:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXK/aAQPHBvnpw3d/NxwqXRRCdR5FZS00zY1MGA7qVZVq/TEi7eZsPK7jbePeopBVGWgVLM4bcLT22+ZvjlEnuHOYSnaHNLvPHm5pyG2XuZ6BVYHurLu5OnFf4P7SXMGAMOuMxbBTotJ1hXCxkusiSbURG02GIrhnhgHKSIwXHjzipK1QbXdmp3FScS2/3+lrEYpQDcHBUqUzujhyBfqFEp0t7jpyoC2RMgJcQipMM6TthQYre7VCqs2bLax5sRTnSkkT1M6MayO3SS0+tp+oR7xEg3qWc5QqXC17abRAtAZrLZpkJjGP5h5XqwIUN9wtkHTMalXvhs6ZRoqDYWgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60wCeFEFtOaZAecKvXzid7WgTTj8u1LPabdVQt5nFYE=;
 b=Ay+Me3X25A3Atu8mtaqvR7NIa7E/daIbZp1UqiVA8iFMXDW9njy1SfGQZ4H4kSprA0smWfIQeZ8XVwSRMXYb7fzfI99dqcTNMzxYYl7E+ApL5Prs687x1JnYB7CdbHrL6KV8tqC/Y2ONEuVXuyfrpFUdwMb2hmPfhp55lS2i4Dpm70Gr6j65dZEINaWBUWw0G1yxfaQYlXwdQy1ZbX1nzxxFEYhEMLTOcrqwXk3E018zi4xwHCwZkMaOmlhZHrp9xn5lO9ZnpLpcpUQqvkpp+5tiO+3rZnBB3AsoMm151OsCux0pyVSt3PtkxlT3hkevAjzdHmsP+TulUsvmwXo0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60wCeFEFtOaZAecKvXzid7WgTTj8u1LPabdVQt5nFYE=;
 b=gh0Z1ekNskVIDTm+qORPCC65XPJo9VkdrzMYb69HfALrr1B0iENJMnndDb+emrvQEvqTEPnbSXDw7uGmOvZejrZISDYizHY7TeSXf8rSaw7gKjD0wDtLa+He6Ft7nWX/7VI0h0fAXipllDil8qfuwKFT+JcCUVdB7D544F8D8/4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 10:25:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 10:25:47 +0000
Message-ID: <aec71555-ce20-4aa0-924c-b3fdd5c60d68@oracle.com>
Date: Wed, 13 Mar 2024 15:55:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Content-Language: en-US
To: Boris Burkov <boris@bur.io>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <20240308174138.GB2469063@zen.localdomain>
 <20240312191732.GB2898816@zen.localdomain>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240312191732.GB2898816@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d158ac4-f7e9-426e-0a72-08dc4347f2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	W7LMBGkAlo7fGtgKJQ1iveKAF5oy2KztU5Pawy7mQGuvS8UAN7D6askBXXYOute6rqHMGK4ETYdAhlZyzhnFfg27a3OeCGPIxr8egqlmQ7ksXFeDjWNisO9xZ9Tl2cNfvZoUm+U7kC+OanWYqVX7ZhVT+rGqvwcMIwkKFLwJgCsTc2uC1jC5Jq3QQwrRjQ5f8TKvx044f4eyi997iPxDAfUypXaHrPsdayLT/k+98h5EenIGHZvP8j3KVkIazweLQHm57xoSBTiUf0OhIt837J5Rz4zHVlQF29eEtxAgWZfUG3U+SiGa1imlxhaXzk99ruhWLG7+RlRiS733OaMQzzKlxI4O4f0gNb9hI7mS6B0//y13vnW4HcT69QrZCJH53BuBDIvFczh5MK4azzySK7BInEEJapPQUonTxDWcUT+0/tgMYc0BzqIpQ8UXfw/8zngo5c2yxfQ8J2LgvkbKk01yzyWEPG5msocvwLd3c0QpWuS2ItKsOvQCIBt8wEGKK12IYWDPiY/WL/rBfrMhQgBhkA/8sN2ihGbXeG7mxuWdq7IMc8L+nE39qPbX1gNc1Gk4J3fTaiya4KMTLxcqpjhhHTaafekbKQp6eV6bNw4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlFLZ3NtR29kTk8wcnU5VmdXOUZ0Z1NVQ3drT0dMR3BNUDgxRVFUcVIvM1l6?=
 =?utf-8?B?Lzl3VS9tVndDTmJtL2ZPL0VYVzNMZlRSN2JHNlRYbXFIV0E3eEpJa3M3TzhD?=
 =?utf-8?B?UFBYQ25iMWxxMEFPOXlOSTFCc253bllmOEwzNWZHZ2FiMjNaaHdQQ0VqQzJF?=
 =?utf-8?B?cTVyczExaXdUZUFoM1RUU1hsa2UwaXZJakJqL1FnZXdoZGxybzNWTmE5Z2Ja?=
 =?utf-8?B?bHFTaUdjdlZ5blhVTk1XQ0NlQTBLZ3BIcHhMdDJNYjRWS1dvSEN0OW02WW1B?=
 =?utf-8?B?eHZQMkUxcGUvdk5YUjVFQWs4aTJJb0NiM2Z4R25DVnN0VG5acVh5eU56TjU1?=
 =?utf-8?B?VzV6TUkwb3JYQmlPYkh2YWdlSE1GaklVdmRSZUhaSXpSUGtmOTBMQlpOb3NL?=
 =?utf-8?B?VHI4azBjdTd4R3docVlxczB1YjQ1RjZkUlB0dzNMRTA0M0lLNzgvM1lkeHV0?=
 =?utf-8?B?MkJBaElVdDdvTGMwZkQ0dytMNTkwclFhczNjS21vU1d6cmlyZXUwVjB2a2Zm?=
 =?utf-8?B?R2I4ZlNUQmdDQ1FHRzZoelBRL3BST2NzeEFuZFQ3dCtzNmgza3pCRm05dkNj?=
 =?utf-8?B?RUlSR01KZ1Rka0h2djVPZHZOcEd1bDQzczA2WlA4b01sRVB2cW1LTjJjNHNl?=
 =?utf-8?B?ZXJGR0EyT3o3SGFxdDlTYUc3SWZlcW5XdWpFTHd2TEg2OFR6SE9DV29ianM3?=
 =?utf-8?B?ZXVEVEY0RUQwLzBrdGJtUE1ZWVh3dllNdkc3eTk4RTdDQ1ZGNGlmQWROSW5P?=
 =?utf-8?B?YkZnT2pIMW1Td05TbWpMOTROTEpLSXNKVXJwcEtnWGROOEtYMis3VkthUHp3?=
 =?utf-8?B?K1RsbjQ2WW9BV0hoTVFnb1pvT3NPL0xvZS9mTEZHUkgyUG91Y3hCaDFmdmhX?=
 =?utf-8?B?U1Rpa3E1amUrSndCWkpTeTEyWEdIUk5wSVVsZkNqQVlwODluQ3Rjek1OWFd5?=
 =?utf-8?B?YTFRRDRvNDljclhkYXlBSmdyK204VzhUNUVkYU0zMVJmRFp5Vmd0VTU5aEdG?=
 =?utf-8?B?SEN5cFdDMVB5NzlxdTRPNkx3SkY3dmdMZ0orY0luc1FIb0Q0Q1BUVlY4cWZN?=
 =?utf-8?B?S0J3cFF3SGlWNHJuZGwrVVFYL2o5bTJsUm85emJ3cmlKSXpCTUsvNUtSZVdS?=
 =?utf-8?B?QWtMVkQ3eTdYUFYyZUY2MHdaamhkQXVoVVlvODNaRXdQTEZYV1laellDL2ly?=
 =?utf-8?B?Rkp5aWw2SytLaDl0SjVlTzhSNTBqNkFWbkRsMDBRT1dnclFuc3RuOUpyaWJS?=
 =?utf-8?B?QTFxbVpZRkZPa21ZL0tKZ05hYWR3SHRpOG1BbjZFc05uK1dKcjE0RFVPTUxD?=
 =?utf-8?B?MHhqK2Q3YnRINUJubHNQamNjNEd5SU83QmxkUFYrclg0cXY4N29XbURtdGM4?=
 =?utf-8?B?Qmh3a3V5d0dhOVFSZkk4eU56U25ZUkFXVlBzS1lybVBFMlF6SStYKzAwSWtt?=
 =?utf-8?B?d2dvd2ZKNGZLZ0tXaUtxeFZKN3F4aFFScC9VVzVKdnc5dTVUaE80eThaYmRV?=
 =?utf-8?B?RnZOK3hidDZYY2xsdEt5RzZQMEZVZkhlc1RJZVd4dVR4bGY0WU9YaG8zQi9C?=
 =?utf-8?B?NDRUN2V1L0w5RHhEcFNxM04zZlZFSGhSOUpTdzZlT3dEL3d2MFZtaHY5NkdQ?=
 =?utf-8?B?NmRTZDNWU1lCR09ERHlMUGlKb1d1Ni9Fa1Z0NzRmZGZBbWYxQUJSbWpJWkk1?=
 =?utf-8?B?N3dvN2pNTktWMkE1ZlhkazI5OHBnVmtNVWJ3SVZwZjYxUEcwbnJtclBXOG9Y?=
 =?utf-8?B?MEVaN05qRk5PQldkUDZxb3V4OHdmaTdmUXJFdDFob1ZDbzEvZmhobEsweGFl?=
 =?utf-8?B?WHBJcWV5YyswSjMvdGlOY21YSUl3QnZDTkRVZWlIY2ZjdllSRTZHSWpNMVJB?=
 =?utf-8?B?Z2lJelFLRUdFTXhNRFpXNkFnYjJPSnpJUlhydWdwcm9VU29hSlVrWGs4dEdI?=
 =?utf-8?B?M1Y2MDRsdnJmNWtyVytHcHM3bHZTSjBnTEVWVlN3NXEzZ0NrcCtmYU9LQkNM?=
 =?utf-8?B?RFZYT1dJd1NWWkZ3eWVCQUZDT0ZPdWI3WC9SWjlBdkRiNEpmdnQrQW5JVU96?=
 =?utf-8?B?WnlZdmVBZmxUSTZwL09SWDc1SnZMbjUzZFBoa1czeVJXVEkvek9Xck9hMFFx?=
 =?utf-8?B?TTlpdlRpeSt4VkJiRWUzQ3Z3cXNQUGt5UXVkVUFEWEtoZGxCYWpYMW1rQkpM?=
 =?utf-8?Q?D8TWh8tryOp1GesZVfZMkah0FJE0k71jAiJb1ASCSqR/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/jZywvkJ4/hUSXE1euQ25Nvq8sf6cS09O+KxrhG1LLTBKrVidFJdb8UJV8V8Rw7La1X6S/yAtTQYDr/dG/kyV0+aZGHUt45RWCBwPyZ5SHGuoerXc21rnoQCb9PK8vKwO3L9qJXfcw8nW+xlk4dQbMAxQzDXyKxwXc+Ku6DqgtVO9I3IC5W40zGxPPngFIimViIG6tY5uV6GhqN6vormPW7HCVrWRdxy09Qgl3K2H668XCuoNkEjtz1gLc/PDKT2Pf7si4RhGNhhUTTlBRH+Fltdm0bsfLDwqJkCgS9ukrKTI2jruDjFwJAbRTgmJF9uTuwj8VIfAYXYfJv/0BerRjUfKxiJEtJZG7ZaHfuC3/iUyEf07DdpqSbNfQp3c81txXdWKrpyfaamQuSw9aIw5jl20i53X96YSsWCLf/Qlv4mK8DaYSLxncF7FpzR9wMoQS5ZzBkNOw49PSONJ1w1Rp0edF4e1KGMQMpmnYASklKjTFu580e6XEoMEewdg+D7wyt66DR79Okx2bgLZ9/pkWqqNLYqFHahf3DG8+mLutsyg7tw3tNQrEp7RBeoRDmSO+FAYkcrM6NdM6aP82GNTjfy9Re1XTqDNvIGMs/Pv4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d158ac4-f7e9-426e-0a72-08dc4347f2c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:25:47.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2R9rLXLiGck4dYZ435JmVeqCr4cCUTjJxUnjgBmw15HXZC2GISR1ZsJoAg4dI9FPuXLKZV9cfOeLj5FHjI9AMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130077
X-Proofpoint-ORIG-GUID: jo4g0Za0ghCObBzqcamh6LXCKw98gwGU
X-Proofpoint-GUID: jo4g0Za0ghCObBzqcamh6LXCKw98gwGU



On 3/13/24 00:47, Boris Burkov wrote:
> On Fri, Mar 08, 2024 at 09:41:38AM -0800, Boris Burkov wrote:
>> On Fri, Mar 08, 2024 at 08:15:07AM +0530, Anand Jain wrote:
>>> Boris managed to create a device capable of changing its maj:min without
>>> altering its device path.
>>>
>>> Only multi-devices can be scanned. A device that gets scanned and remains
>>> in the Btrfs kernel cache might end up with an incorrect maj:min.
>>>
>>> Despite the tempfsid feature patch did not introduce this bug, it could
>>> lead to issues if the above multi-device is converted to a single device
>>> with a stale maj:min. Subsequently, attempting to mount the same device
>>> with the correct maj:min might mistake it for another device with the same
>>> fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.
>>>
>>> To address this, this patch validates the device's maj:min at the time of
>>> device open and updates it if it has changed since the last scan.
>>
>> You and Dave have convinced me that it is important to fix this in the
>> kernel. I still have a hope of simplifying this further, while we are
>> here and have the code kicking around in our heads.
>>
> 
> I don't want to get stuck on this forever, so feel free to add
> Reviewed-by: Boris Burkov <boris@bur.io>
> 

  Thanks.
  ...

> However, I would still love to get rid of device->devt if possible. It
> seems like it might be needed for that other grub bug you fixed. Though
> perhaps not, since we do skip stale devices in much of the logic.

Removing btrfs_device::devt and then performing lookup_bdev() when 
needed or access it as bdev->bd_dev is possible. I wrote a patch for it 
but didn't send it. It contains too many lines changed, which is not a 
good idea for backporting. We have other critical issues such as the 
device disappearing and reappearing with a newer devt, while the device 
is still mounted. In this case, both devts will still be valid as per 
lookup_bdev().


> 
> Anyway, let's move forward with this! Thanks for hacking on it with me.
> 

Yep, this fix is fine. It resolves the reported problem.

>>>
>>> CC: stable@vger.kernel.org # 6.7+
>>> Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
>>> Reported-by: Boris Burkov <boris@bur.io>
>>> Co-developed-by: Boris Burkov <boris@bur.io>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v2:
>>> Drop using lookup_bdev() instead, get it from device->bdev->bd_dev.
>>>
>>> v1:
>>> https://lore.kernel.org/linux-btrfs/752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com/
>>>
>>>   fs/btrfs/volumes.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index e49935a54da0..c318640b4472 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -692,6 +692,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>>   	device->bdev = bdev_handle->bdev;
>>>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>>>   
>>> +	if (device->devt != device->bdev->bd_dev) {
>>> +		btrfs_warn(NULL,
>>> +			   "device %s maj:min changed from %d:%d to %d:%d",
>>> +			   device->name->str, MAJOR(device->devt),
>>> +			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
>>> +			   MINOR(device->bdev->bd_dev));
>>> +
>>> +		device->devt = device->bdev->bd_dev;
>>> +	}
>>> +
>>
>> If we are permanently maintaining an invariant that device->devt ==
>> device->bdev->bd_dev, do we even need device->devt? As far as I can
>> tell, all the logic that uses device->devt assumes that the device is
>> not stale, both in the temp_fsid found_by_devt lookup and in the "device
>> changed name" check. If so, we could just always use
>> device->bdev->bd_dev and eliminate this confusion/source of bugs
>> entirely.

  Yeah, it's possible to do cleanup, but there's something more urgent
  and critical to fix.

Thanks, Anand

>>
>>>   	fs_devices->open_devices++;
>>>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>>>   	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
>>> -- 
>>> 2.38.1
>>>

