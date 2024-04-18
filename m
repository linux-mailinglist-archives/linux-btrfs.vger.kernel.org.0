Return-Path: <linux-btrfs+bounces-4412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E9D8A99E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E001C215ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA92770C;
	Thu, 18 Apr 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VkUUjAUL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mslOHKEb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEE1BF53;
	Thu, 18 Apr 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443436; cv=fail; b=S8Nt0t7HP0iJjrlTlnx3TZo38ef8N7xcR8JAfe7zQScJaPeWHRZYw+G5vR1e6FcQ74OePvFYFlRZIRTvPRpp7LGGgjSFJaRigqeFegG7yDasONRJW592+5a3nY2vE6Lep6WojZN0WGLoD05HjBnXJilSwUeFd1V78gD1ukHU+bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443436; c=relaxed/simple;
	bh=hr7Di5mPcbXT+jKLD6CYfQiXMliJay2e9UazDWWSzbc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NC1Rk9RyqVSGa9WMvk11mJKgNVDOF1ncCxCjsMZJF3RVyZ0RNWejhmAFAsP8GquRudT3N0IBjtGGOdHJSG1zqPqmJ3UPgZxgUu1PK221ZMGXrf0rke9UWlCJsRx+bV9s6XsSOU2zDZiLq4l2fdo5HWB7QwOJ04GUPe9ZtXTjtC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VkUUjAUL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mslOHKEb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ICJrFa027818;
	Thu, 18 Apr 2024 12:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FsL2UcifXGt6boSUKp67HGd8PTwg+R1UYu1WKixYyP8=;
 b=VkUUjAUL4p9tDedU5Lvh1CpDFHt5bvD1AGUeQWaC0ZIIBg5VJY+7QBhPqbHsP2e+ru1D
 iaMQZzj7n+/X40+fyp5WOrBeO+BqdB/qfzRMddM+mz/Qh65Kxh9OajUjDWDgRDUIIfp1
 iCw+Q+JYTgj8mrp3Js0GI8U4lNc1AWRjg0GfH+yKtw6Riu9eSsVfS6AyLWUHKsthIMIz
 xq+VmSYGu98dYsZcRKifLvF1IqUC++v4pRKtA6BrgfnvUER9d2qCqRGHTNDZ1r/yf7mI
 WujCIawPZC67LEBx+jVcuXZcEhESTbGUN0j46lrguMO0e+4RKne456YA/PxAuI4nRNrR yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkva7n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 12:30:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ICQMVt004284;
	Thu, 18 Apr 2024 12:30:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgggkch5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 12:30:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxZGhjRCCtGa4zlPfFI3T//4KQdnYQGJ8OB+Hs1YK2n+Dv7rorLa7fVVI+uawLdqd5zvMTea1uxxU/+RYMmSk/UGiYd0Ok0CmCDliuBZ+THA9iiZ+BsUJ/VH6CIRJ7xVACyj4bmAJyUPSw7pwL1CB3J1Q05PbpmCw8y8I+bJ/aDAZEpnkBMDeoivBky3cT7vTDtC3/gw95NJ96zw3Ya2/fmOZvpOk0RsoKjbr+Jj8u2Tmk7b8CznQ1ytu53XfMjfR97I8xdqcU7RdqttBlWsnAf5v1CpCsWSNf5S+CaTk4DqjiPr1NqEKn7kG0XPihxiZRhkDWtX2L3YA7LNuPB/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsL2UcifXGt6boSUKp67HGd8PTwg+R1UYu1WKixYyP8=;
 b=leNT68WaJlUKB2Je7Sy6H/06PIvL9zxsE5ia6xrLllPZ6LWblMAo1DkTLE6uhd/A5FyRjHxamTGEg96k130H8x7I9gMq4nS0JoegmuGsj871luioEi5QuSF0X6y3rAG4fvSVxniwb3RudSfA9geiJYO/i+Qpjl8ywJZMa2BNrh7YnoGAa4ShrMPoL5zZR81ZZ5iMV4WAq4GKaVR+Wh0g9VFOwVaEakQbdW8kvLvOYfRMF5x0yz6M+ORT1XMafX5RnHmyroXSJDWJYhJA4rTc3A6v+9ykFefvNedMQ4fAYmCLX2QMlMdUVP+C1DFnO13a4Ok68oZ8ti/Xd9no4t4ASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsL2UcifXGt6boSUKp67HGd8PTwg+R1UYu1WKixYyP8=;
 b=mslOHKEb7E3wCWHz09/NsbDslj9kQPQwsC9Q3opIfC0NLXJ3aisYJuA7L1586q2G5zPOkavMm0Q/Orry4gscFzLX4t1uUYRj8AHOPSeB7FWhPZebWWaDz0U/MDHqzfWiHaEi7mYEjEDLw+/bxRRsahjHaKvjap9lhkvwWX7rIhE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 12:30:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.042; Thu, 18 Apr 2024
 12:30:29 +0000
Message-ID: <852c470f-a478-495a-a90c-1d3cc1d0c68e@oracle.com>
Date: Thu, 18 Apr 2024 20:30:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fstests: btrfs: migrate to use `_btrfs` for
 snapshotting
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <cover.1712896667.git.wqu@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <cover.1712896667.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ccc623-c9f3-4216-47f5-08dc5fa35515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V63XAARDMupFk+ibSmac0RsvqTVBqCC/SeSFlruLHSkBroXRcjosxxSGCVSrCZQTADYVBgRugaf1Rku/SPi5ASrspVksKcIJyuEAm07e2PwcOXjF/OzgsXOL1hzdsPQH9RGRJrKV+sZc+aG7zsw6PuSO7jR6RatAGuL6m/wfAREdace5iOaS2JsTouf2Nl6jiHgeEkqwvamL3trhnWYQLPm204ElW8u+u1Q0ffRskX7/Fojfood2sy0QYbkvRFKKzNkIySFKq9tFDosnHBPZFvHmTMca/TTZI2LfZmby3zFh4PlGPD/xidYhKhyDfuX9WhCgirnDafWgPp+bDnTR0QqRP3JPwpMUN8t9V03h15tV9ND/9TaamK+DKAE8QJLVcGSkV2QBRT/X/ZTxq54tGXM04AhmuaWsl391QXd3sUAQ3jzUSjOh7kOMExNMcdxtobt4VhHfnZgWd3M/36Yq6GjJLVs1DGygIUwFqdlLOewGbSBv4IVzZDPqKpWw/1d4jQriN4A8lLsTUyVG9Ok8LmX+GnZvZhF5ipLxRIhOYscRLoZQXd4mDXwIVnuydV4FeL9uDZZTpLwKcXIm/+t96g91N0dCuYtJL4RjGtN3jRhXIn1tWhEPn0FQlyPJSF9l1EyftrynjpLW2ZO4Xen6WyrP+tBfwK+F95oUTQ7wrfY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnE5UnZiS2ZDVUppMlRsblo2MEZ2Slgwc2tUNjY2YVRLQzBPZHNwWlIzS3BG?=
 =?utf-8?B?REM3R1NvUzJvdDVOTWRRRS9saFRSbHZFTkV0SnQzelJVT1pFN2xoNFJ3ejY3?=
 =?utf-8?B?QnltQU5HWmVqV1hkazJHT1QxSm85UnkyMThHdHAxYkkxNEhQbGhqUnZmQm9w?=
 =?utf-8?B?M0RlcXM5ZVM3U3NhL3lTSE9QekwrV3dtNUpPbWs3VzBJNktvajdDWStScHNi?=
 =?utf-8?B?azVxTGJpM3NOdVBWNjRhK3RMZmkzZTNmdFRvbmlJZTJqb2wzaHVtRE5wYlBI?=
 =?utf-8?B?YzlOL3ZDU3J4Ni9PUkRPM0dyRExyVGxCaUpJK0xwTjNQK1hUTjdBaENzWW9n?=
 =?utf-8?B?eDdYeVdlS05wbVdHVjFGV0EvQ3F6V2w1MGxYUXdjWW5hbURZeWpmOVRCUzVr?=
 =?utf-8?B?VmxpdUpQazJhMzlPTUNXaUtGZGJ2UEJINENhRmxhTUpaSE1FN1Bqb09zWnFM?=
 =?utf-8?B?R0hoTTIvaG1GQk5EY01YTFJUN1pXU1pPZE85dUZUS2VCcUIrYWJ3L3FxWjhq?=
 =?utf-8?B?WElYMyttYWk3ZFhiS1EzUVRYODFuWWl0dEp6RytodDBVdUxBTWtXVGVKSmM2?=
 =?utf-8?B?UEJYb1lVQ0lsaUYyV20xaXJ5Q3FBVXZtd2xJTTRUeExtMDhzZ2kyL2hoaE1k?=
 =?utf-8?B?YVIwelF0L2FXSmduT1RMYzhsbXE2bVp0WDBYMTZyajRjRmVOU2NacHMyZlNu?=
 =?utf-8?B?TjZsZ3RjdGJXS25GUE9lOU9NU1d5ZTBTNUd2Z1pLc2lmZFRvamQwNmJjWkp3?=
 =?utf-8?B?OCtzWSsrN3ZBeTRCdVF0OE93eDJ5SENRVnhxM1F6Z2g5dkpWMVV0MWhPakpQ?=
 =?utf-8?B?QlpSMmtHTU16WEV6RHFKWVNGcXVqRXNDRzBaSktyRWFFWG1wUUhaZ3doaXAr?=
 =?utf-8?B?Y3lzaXBPNUV3bVNhSk1aZWRmMEZQMElIQmxvdHdBQTZZUnJrQ2hONmYyUzlI?=
 =?utf-8?B?MkJGK3J4dEN2aUdvQkZHendqVUdDaGRFSVRzeVQ5UWVhUGZUM2oxdU44c2t6?=
 =?utf-8?B?R1RCUzM0WmJtOW9XM1JOejFkZ2VYK0E1bjIyL1RUcUY4VFZQTmRPa1VpUzRT?=
 =?utf-8?B?TE5NTGdLcXZtcWdOZ2hnSzlVUWg2ZC9yWTlsT3lEd1JZSjBGaXU4MGxQT1pS?=
 =?utf-8?B?dUlBUWZaeWJyR09PTXN6SCt2empDV0ZqdjNoM05pZHBjNHFIeVpkU3NsNmRU?=
 =?utf-8?B?aVJHK1lRd21UM2VGQi8yR0pCYlBhellRUVlqYWw3aGJQR3hTK3UyRGl2QVYr?=
 =?utf-8?B?WTdPQnJBZzlSdTh4cTBTNE85T09WbjEreWR4eEFRQjdReHpmYnk1SGdKS2FJ?=
 =?utf-8?B?T1lQaWZXZmxTbm40anFUVm45enVHSnBUVndRYjhpOS9wNWdrb05tTHorYSts?=
 =?utf-8?B?UHNoaDM0Q1JIZTZWZ2tweXhqU3dwRHMyNERZNlNTU2FYdElzeHRla0dlcFRT?=
 =?utf-8?B?NTYxU3JuTDNGTy9nd3o4T1k1VlVoUE1Ma0lGYUg4aFYzclBHaDdrYmF1RHBT?=
 =?utf-8?B?NjkxSWx5MnR2VFJ5cHBQWEdSTkNWZ2JmNlJGbDMvRFZvc2ovRlFCYnk5MHpI?=
 =?utf-8?B?Z05sWCtVUlFJeXhVdUtWRkR5VThKN1NWK2l0TlFrbWFmOUgrWDRTT1pQamJG?=
 =?utf-8?B?NFlIQU90QXFHSG9rQmpuZWlkd2NLUkZ5TzdEVjdmeG1MbWZFcFZLNHdYSjFO?=
 =?utf-8?B?QURkVzlUaFFGZzJaUm9ITWtQZGZsREFodTJMOWVTbXVHZ3pSTnBYdGVaeG56?=
 =?utf-8?B?R3U4WllKNmJmRkVjanpjOFhnOW12Y0c4MlZoblJQTWsxbE9qSnN2ZTNka2U2?=
 =?utf-8?B?MG5Hb1drTnJMTFE3UmdCV2MreG9rSU5tanJOMXZXd1ltUnZkamdoYU1BeWl2?=
 =?utf-8?B?QjdmOVB3ZzdibjRYSzd3ZFM0bTZ4b3VCekdodzNRRkNXT0pYRzZuL3lYMmht?=
 =?utf-8?B?KzFVdDBKSEdUbnlhUExkUVJCRko1T0psM0p2V3N3WEF0MU0rd0treWpaQzZ2?=
 =?utf-8?B?dTdUZ3FQL3pZdGZKelI1OFRxTTcxTnhObjl4QXZETlNwRVNqZm54UU9PTFN3?=
 =?utf-8?B?cDBHMWVzK29KbGtuUDNvcU14eVl3NTVobzByb0Z4aGV3RHp1UjhtanZBKzJq?=
 =?utf-8?B?YmM4R0NlRW01Vk1ReHBndE9sQTgvSkFYaDNuTy9hc1FPOTZzMXNSdnFtWlBS?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	icVvhywIuosr+9iKwpYZNrx3W05OWTBrBKHQOX7a0H4Ol53IN9y/ExHECzYpnE36ysaTg6JjyhQWQ3p2xlnOSOBBuWvhK2NLCT1LzZv3+qLcldR5rCj5xYCBokZj6NmgFkf038+6l23/pg2HzyyTWTtQVk5ONLCtdGrhC4hxXGcJ/ooioueLoslN4sR+xQDMpxbJspDC/An0mM8D3y4e/TLfoWP6Je0MGNF2Jie6aExMIe4gq5Q/rS4/SVez8QecGCT2YjBtuEz75h4B+7dVZrwZ/LDZL1vTLnUCXzHmaTh49VsJ4vgEUpcVm4lJu/6Sklzg0Kjxk3r3Gze1/wLUc1egA6oZE4j1yn8i6M/d2CdSmWDUxxFzqa6Gk6/VUd2JmX3oqfy2LwcylMIdg1fwEgt0zy4zvOZek61P4K9DVHnSmDoZDh0abORB0nQyR3+Vnzw1g7FdKXFMzBcjZ9mhUCLcYVoeYhwEtEbQ0qauEnctxcD1f8wsRBCXbdFd5VqdO0jeo++PrMg3yJAtAP+51aMhVxq+5nrC69gjCchDQFrRfdqNGJWVnpNu06RxP4csvjr/ZTbC8dnXVzofg+9VkPj0dBg3YywS5cXcxpJgPeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ccc623-c9f3-4216-47f5-08dc5fa35515
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 12:30:29.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAzQ3g9SKzphkQKqmPLre4VGqdSpT5ZbSfVvSFXQ2yP4GyQp6opHk1oVS6jxhA7APlRzc3/QHYDgF4nkWZ5/rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_10,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180089
X-Proofpoint-ORIG-GUID: pvPv03D0kpub76eVAmdsSkGj4aNhs_Fh
X-Proofpoint-GUID: pvPv03D0kpub76eVAmdsSkGj4aNhs_Fh


Applied locally.

Thanks, Anand

On 4/12/24 12:41, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Rename `_run_btrfs_util_prog` to `_btrfs` and use it as our
>    recommended way for simple btrfs command
> 
> - Use the new `_btrfs` for snapshotting to fix the golden output
>    mismatch
> 
> After more dicussion, it turns out that we'd better go the old
> `_run_btrfs_util_prog` for most simple btrfs commands.
> 
> And to make it more closer to the regular "btrfs" command, just rename
> it to `_btrfs`, and put it at the beginning of `common/btrfs` file, and
> recommending it to be utilized.
> 
> Then fix the golden output by utilizing that new helper.
> Now there is no "Create a " line in btrfs golden output anymore.
> 
> In the future, we will migrate to use `_btrfs` for subvolume creation
> and deletion too.
> 
> Qu Wenruo (2):
>    fstests: btrfs: rename _run_btrfs_util_prog to _btrfs
>    fstests: btrfs: use _btrfs for 'subvolume snapshot' command
> 
>   common/btrfs        | 15 ++++++++-------
>   tests/btrfs/001     |  2 +-
>   tests/btrfs/001.out |  1 -
>   tests/btrfs/004     |  2 +-
>   tests/btrfs/007     |  6 +++---
>   tests/btrfs/011     | 10 +++++-----
>   tests/btrfs/017     |  6 +++---
>   tests/btrfs/022     |  6 +++---
>   tests/btrfs/025     | 20 ++++++++++----------
>   tests/btrfs/028     |  4 ++--
>   tests/btrfs/030     | 12 ++++++------
>   tests/btrfs/034     | 12 ++++++------
>   tests/btrfs/038     | 20 ++++++++++----------
>   tests/btrfs/039     | 12 ++++++------
>   tests/btrfs/040     | 12 ++++++------
>   tests/btrfs/041     |  2 +-
>   tests/btrfs/042     | 10 +++++-----
>   tests/btrfs/043     | 12 ++++++------
>   tests/btrfs/044     | 12 ++++++------
>   tests/btrfs/045     | 12 ++++++------
>   tests/btrfs/046     | 14 +++++++-------
>   tests/btrfs/048     | 16 ++++++++--------
>   tests/btrfs/050     |  6 +++---
>   tests/btrfs/051     |  6 +++---
>   tests/btrfs/052     |  2 +-
>   tests/btrfs/053     | 12 ++++++------
>   tests/btrfs/054     | 18 +++++++++---------
>   tests/btrfs/057     |  6 +++---
>   tests/btrfs/058     |  4 ++--
>   tests/btrfs/077     | 12 ++++++------
>   tests/btrfs/080     |  2 +-
>   tests/btrfs/083     | 12 ++++++------
>   tests/btrfs/084     | 12 ++++++------
>   tests/btrfs/085     |  4 ++--
>   tests/btrfs/087     | 12 ++++++------
>   tests/btrfs/090     |  2 +-
>   tests/btrfs/091     |  8 ++++----
>   tests/btrfs/092     | 12 ++++++------
>   tests/btrfs/094     | 12 ++++++------
>   tests/btrfs/097     | 12 ++++++------
>   tests/btrfs/099     |  4 ++--
>   tests/btrfs/100     |  6 +++---
>   tests/btrfs/101     |  6 +++---
>   tests/btrfs/104     | 10 +++++-----
>   tests/btrfs/105     | 14 +++++++-------
>   tests/btrfs/108     |  6 +++---
>   tests/btrfs/109     |  6 +++---
>   tests/btrfs/110     | 16 ++++++++--------
>   tests/btrfs/111     | 20 ++++++++++----------
>   tests/btrfs/117     | 18 +++++++++---------
>   tests/btrfs/118     |  8 ++++----
>   tests/btrfs/119     |  6 +++---
>   tests/btrfs/120     |  4 ++--
>   tests/btrfs/121     |  2 +-
>   tests/btrfs/122     | 10 +++++-----
>   tests/btrfs/123     |  2 +-
>   tests/btrfs/124     | 10 +++++-----
>   tests/btrfs/125     | 18 +++++++++---------
>   tests/btrfs/126     |  4 ++--
>   tests/btrfs/127     | 12 ++++++------
>   tests/btrfs/128     | 12 ++++++------
>   tests/btrfs/129     | 12 ++++++------
>   tests/btrfs/130     |  2 +-
>   tests/btrfs/139     |  6 +++---
>   tests/btrfs/152     | 14 ++++++--------
>   tests/btrfs/152.out |  2 --
>   tests/btrfs/153     |  4 ++--
>   tests/btrfs/161     |  4 ++--
>   tests/btrfs/162     |  6 +++---
>   tests/btrfs/163     | 12 ++++++------
>   tests/btrfs/164     | 12 ++++++------
>   tests/btrfs/166     |  2 +-
>   tests/btrfs/167     |  2 +-
>   tests/btrfs/168     |  6 ++----
>   tests/btrfs/168.out |  2 --
>   tests/btrfs/169     |  6 ++----
>   tests/btrfs/169.out |  2 --
>   tests/btrfs/170     |  3 +--
>   tests/btrfs/170.out |  1 -
>   tests/btrfs/187     |  6 ++----
>   tests/btrfs/187.out |  2 --
>   tests/btrfs/188     |  6 ++----
>   tests/btrfs/188.out |  2 --
>   tests/btrfs/189     |  6 ++----
>   tests/btrfs/189.out |  2 --
>   tests/btrfs/191     |  6 ++----
>   tests/btrfs/191.out |  2 --
>   tests/btrfs/200     |  6 ++----
>   tests/btrfs/200.out |  2 --
>   tests/btrfs/202     |  3 +--
>   tests/btrfs/202.out |  1 -
>   tests/btrfs/203     |  6 ++----
>   tests/btrfs/203.out |  2 --
>   tests/btrfs/218     |  2 +-
>   tests/btrfs/226     |  3 +--
>   tests/btrfs/226.out |  1 -
>   tests/btrfs/272     | 14 +++++++-------
>   tests/btrfs/273     |  6 +++---
>   tests/btrfs/276     |  2 +-
>   tests/btrfs/276.out |  1 -
>   tests/btrfs/278     | 14 +++++++-------
>   tests/btrfs/280     |  2 +-
>   tests/btrfs/280.out |  1 -
>   tests/btrfs/281     |  3 +--
>   tests/btrfs/281.out |  1 -
>   tests/btrfs/283     |  3 +--
>   tests/btrfs/283.out |  1 -
>   tests/btrfs/287     |  6 ++----
>   tests/btrfs/287.out |  2 --
>   tests/btrfs/293     |  4 ++--
>   tests/btrfs/293.out |  2 --
>   tests/btrfs/300     |  2 +-
>   tests/btrfs/300.out |  1 -
>   tests/btrfs/302     |  3 +--
>   tests/btrfs/302.out |  1 -
>   tests/btrfs/314     |  3 +--
>   tests/btrfs/314.out |  2 --
>   tests/btrfs/320     | 16 ++++++++--------
>   118 files changed, 376 insertions(+), 436 deletions(-)
> 


