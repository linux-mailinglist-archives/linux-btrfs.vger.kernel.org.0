Return-Path: <linux-btrfs+bounces-3289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98E87BDE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 14:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7210C1C21F53
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4D5BAFC;
	Thu, 14 Mar 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f51JeU55";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QOUlo8YM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931E4691
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423587; cv=fail; b=iLh64XC+y271Jo0fTI5kNLVGdDlEDgqD3rXUeMJ+zRyepdTcO5HQTtFUL3uEaXN77RGY6Fb6haadqyAKK7BaEdrUChDh3IKp18OJQeLmrSKYjA8Xk53jyi13eVeps6HagA/ybonicSaUYrCtx0RSNr0NzWoafkQ16UxZdCHxm44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423587; c=relaxed/simple;
	bh=A15BO6auvx/xxAcKlAVuQyobJ1qc2NSocwnxqkzwuTM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMCoNpQZGmKlVN/TvMogwu7Bw3dJ1uP7qTJSQkcBdXnrpKRE0hBe5Sgg68UAUnU+MCHpz4lbszMiw+456Km5tCsP+Z+fpxsnj6fJAmxPAyaz/dLS7wz0M35uXxK50ZixUTzN7iCOV/35AtY8sRz2F330eyqWbKNVPaUl8gCev/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f51JeU55; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QOUlo8YM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECLaZG020271;
	Thu, 14 Mar 2024 13:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ki5w+oQSvfxOS0U3d9+I+wlJ0f6M0Q1QjGdHYb7noFM=;
 b=f51JeU55lCiQFYFyAmaOng4V/gHBsTTjPGvUxmgaPIyIZ/Q1/+3QWH8hiE17pPpKLWp8
 3MlTNDWY6rWp5CgPmO43CpoxkN3GpD09dfANI0ctuvXyjq/MkYgTW9q+JaGEl5n6X/0H
 7Z1ewgbzMLkHeflsjdPa1iHudYJC0RhqM/fIq7xnzytJiX0fAo35I81JVHqr9sNDV9h0
 77ACbeOeGzg5elBZTy8aAnAzj+iV6RQ34eBPO3mZRQivV99ilcMPTZ/okZzaR9jNgc0g
 KGOXClRTXabwqyZ17vgiFI/rDiFJSKF3naNwDFlUmoi3cjgsAhMD/rB+o3JtfyUK9kkr Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0abg8g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:39:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECXaV2033732;
	Thu, 14 Mar 2024 13:39:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7a4pkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkEyk2OCWT9ISaGxzj6y9VvuOfW06v+VLyzNnKAitsoN4JUVup8PihSALf4Dso7Sh7m6/orFDEE/RbwO5O1J1golWOLS5krMgxWGNMYxmGkW8NgVmRQHlNc2fxXtHNK8wQIvVxosyiXpk3I6bIcqc6p+PjW+jk5ZVMkpIdB7n3b9pfUkRaoE22zv/Uzi3SilwYgY0DjU7O0Kmfdekwzl2Ge6udCxSSUXJjWU5Yo5ovu2Jddraw7WytMgg8V7CHU6ipzKoKiiHi0Ci7kBL9Wt0rYKkg/dFH6D1XhUBgCghjTc4uFs6P0hql/lFTHqQaa+kobRG4WwI+Ovdde9VyQOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki5w+oQSvfxOS0U3d9+I+wlJ0f6M0Q1QjGdHYb7noFM=;
 b=XBBiVlI8c/Hiq3DoIegxPO660uGHu4fcYcrYx7BUyq3k/lcDVOCQZ8PEmB50SzXh12iR2Goi90TaoCxmHXQub7j4FO0kKb/ixJR58p3YsobmL1RDCvmvwL74FR+Si3i2d1B4VArv6Els7gJ+nuz09nMeozhrXy/U7Yhjf9pM36bdvrWpiYYwUXy7q1mcgr2zot36L0GuWE43P+rxdREE00bJ0euMgzakYmiE0yhDVjGAkCTPatgPbb/Ffam4N1OkfNCTsKWhDkuaihpsEpHahF47bxEfpfJpNC4HEvBJpMffP8gNkXBtP9OgbCdXioRnfedXXfNJ+RCjxqF79obicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki5w+oQSvfxOS0U3d9+I+wlJ0f6M0Q1QjGdHYb7noFM=;
 b=QOUlo8YMCNp66bjbiszDtA3eTsBBuW6TjvO7jT++OAwvSGIzdYTt4bk8nA6S4hT1IL1H13ACZ2rV4NJT9/AIDRWbNPNfgnPCJ66z/nAV9f+Z8UWIhrk8fFPS+CUQptGk5hXQHV4tYiLqUoNmVFvWhBrhMKGfQddBeRFB+keuIVs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6463.namprd10.prod.outlook.com (2603:10b6:303:220::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 13:39:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 13:39:26 +0000
Message-ID: <0108b2de-56f5-4a7c-94a1-db415be8653c@oracle.com>
Date: Thu, 14 Mar 2024 19:09:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: return accurate error code on open failure
Content-Language: en-US
To: linux-btrfs@vger.kernel.org, boris@bur.io
References: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 8223a37c-4c99-4dcf-488c-08dc442c2a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MZCNT5/ePYNEcdskefvXe3rlWdq0XMwehgjP6rwZddvoe3TCg1nCJFBzMGRQXwnReYpg3oQa1FfMbLBBCgCzY0kgRnyXASZIabhBRjKgfUzjxiZVN0O/4EKchvUU6FUEPcUnJ9gLtH4h0TRAgGztQaAMg+CZLIs4KR7fNh1tuZL+lp1ZWBtRsPLcVV1LmZZxVTsL9jXvAjpnsyweFFqTeER90l+INnFEXAnGhVK+CBgUBt2ENMmC9GVRtrLOwNr609fXzrI+RWSTxQ5YOIgA96jatwWS6eIaBOWdYn0b+OnxS2BGqVifIBLx8Bmz8Jf5UbLVsHA8mjNMS6ol+rpYDCUJFefpiuFOKHkNMZsJPKz26r6qmvhcpdccH40kXOoB6kwd9VwzkPYLiNHpAtcZ8bP+XzGPjt9gwOrD+PqJX5LU6n64cWFIllfWgww+nPIoq+ULvlQpG1uA/Vkxpu+9siz9FuznwcEzusM5+qXP631oF6Y/14kCCM0MN5smb0AVUALPPAbTsHHOA7npfYcnIMJW8mbEKUG7auyMWNH6ZuqkT8nJ7HidGUjTsrybBvsgv9UKMiyu0LGyLReXL9a2X2YVDXm6eZu/QNLEtYXtuJ1rtbHUGnVLs/87e8Ci5IDZoC8Kmrb1emIwOLbqD2JTBUUjLK57LBO25LaOweuXqMc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDd4TnRmTlhRNDZGMTE1Z2FsS3YrLzJTTlRSeGNNSkhVU2ZOeHBDNXRGeXNk?=
 =?utf-8?B?WGFpdmozUFJHMUZPNXBBcnFoVFRGTFhmMXNwY0JqWVZPTzljb2c1UThpRll2?=
 =?utf-8?B?SVFzZmhMNkVIQnpJRkNhcUl5WjZkNXZuNHY4TkNZQk1oWmxwcU5DWHEwSUVI?=
 =?utf-8?B?TWhUVVdBelNIT3c5U2FTS01JOHJLQ3A2N0diOExMZlo4QjNJdDNveENSNTFi?=
 =?utf-8?B?NVZCUjV6YklUUm96WHdza1VNbUxaZC8wSG1na3J3SFZ3RnBtakdYSENmMC9R?=
 =?utf-8?B?SjhqWC8rOXJlRU5RV2hKdXNobjFUUU5YMFRLR2ZSaGhZR2VPdzZBUW1RWnE3?=
 =?utf-8?B?anZzNUtNVW84bW5PZ0Y1VVRPYzl3NjNhdDYydVJxL3d0WFdOWnBBbFRiUzcz?=
 =?utf-8?B?a3pEaUFpc1E1WGY4NDNoNG05TlVaSit2MUdOWkt6aWp6T3JFbW9TNXBBTXcw?=
 =?utf-8?B?ZWZ6SUhvZXZiZXNYc2J0RGhOaURYTmVVM3VmdmNQVjQ5NllmMmY4cUh5T0E4?=
 =?utf-8?B?M0s1OTRsYUlLVHpiL2U0cytnQlllR2ZCVFp1MWZxdlExV2tyVHBRc3lLR0pD?=
 =?utf-8?B?SGczbGw4aU9JSzlyeWVDZ2RsTWt2WlhaNEtxUEo4ckVjRFQwNldUaGlWbDhU?=
 =?utf-8?B?ZTMwMUxZRTVaME05ZGNibmxVT0EveXpNVkoxc0l3eENqVnp3ZU5URXpQdkxv?=
 =?utf-8?B?amVvdHc0UWw1NWJMYXFDVklIUkg1b016cERiY2dTejBTRnBvdmQwWUlXNFJP?=
 =?utf-8?B?ZTh5M2FleUlZeXl5a2lOaXRMdjRTcyt1M0doL0VENEJVRDVsWEtBSVptR1pP?=
 =?utf-8?B?dlB6dTNiai9ZMUVCeGZNaS9nRW5NU3pUR25LWXdNckl1ZHpEbTlXdWNyL1dI?=
 =?utf-8?B?K0xoSWRVcWR2QzQxYlgreXVMejg5RGFXOEdOOUhmeS84NlNOSDdjeFMwTzhJ?=
 =?utf-8?B?MGxhSFRvS1h0ajRycTZOd3B0WkpQbHl6eHRVZmdUS3NlVmx6cDcxYjRFTk9V?=
 =?utf-8?B?eGFsUTRNd3VaU21LdDIvdlQ4UVM5QVFHam5PMzBCTGExY29ZM01reTJtbWhx?=
 =?utf-8?B?OFlBM2FDNS9uSDArSktrZDVkeWtmR3FDYTFqc2ZyU1ZOODJ1cG5XV1N3RmNZ?=
 =?utf-8?B?KzljcmI5dE1ESWZURHVpdkRod3dqQ3NKUk4rYVRPbUh6azl0U0NJZmQ3NEVh?=
 =?utf-8?B?dWsrY29KMjNBMklXRHRnN0k3emRWYWxoYzJ1RXlUZjhhQUVSZUtoYmxFeE1a?=
 =?utf-8?B?V0VJMG05VnBabCt3QUJIUGo0K2JsaXhoNURvQk42OXRVWHY0cFJWb3Vudnh4?=
 =?utf-8?B?SlhxUktNWjBaWXlBTGpEWVMrRlJRam1GYjVSNWdQNW5abU5aeFM2dFdGK1Ji?=
 =?utf-8?B?cDgyaUhSeTJ0ckNpL29hdm51Tk9BZk14SStGbTRnOFJHVU90UUhVR091eCs1?=
 =?utf-8?B?dGplNUEyWHV4VFQ4QUtjb214T0ZsbEFZMHZtTFN5T3YyT3NJSGx5VkEyYVlz?=
 =?utf-8?B?NXFBR1JHakkycUtpQ0wrWFdxMTBGZnlxWkliMnJ2VG1QMktFVnBxSUN0TUhO?=
 =?utf-8?B?U0RqUjJSTkhBT0NZUUhpREMwOS8vQTh4NGJjeWV1b2xXaEdoTEllOUVBV0c5?=
 =?utf-8?B?ZzU1T3lOTlNCTGpDZ0thQUdDbXNQWjROS1pPM01DNTRFUVd0M2p6ZUpuVm5S?=
 =?utf-8?B?ZlovWmcyU3dTcmE3TkJMWDNScUJ2YnhMVGpkaU11U2FEL2gvWGEyNXFDRzBh?=
 =?utf-8?B?NnBKdkNoSDdFRFNObk1PS3EwcHJubmJPKzl3L1g2N2x0QVJpUVJWeHcvVXZJ?=
 =?utf-8?B?SjJLN1pIbEh3UFpBUkFSODdEYUdkODVQK1d2T3o2ZWJZdHAxMS9SQnRPT1RV?=
 =?utf-8?B?UG1MdkNQN3dacTBGbjdXZFZpc3FQaHdhSGpibm9BbUpEUGdTWkdVQ2N1VFl5?=
 =?utf-8?B?TS83NWlrNkNMOHluTFpGdGpqR0hWV09TeVBhd3hmcGl0V1BOR0dERCtTcUhQ?=
 =?utf-8?B?YjN6R3VnV1JZdytJcGRpd0RaTlFoUHI1S2F3RGhuY3dhYkh5TEdIK0p6R09R?=
 =?utf-8?B?MHhodWFxQWFrWnE2U3hYYkc5VGNMUGcxWmRGa3Nkc0ZmUnJzU0tLQ0M4aWtD?=
 =?utf-8?Q?w/vyfMf+BqYFoLCd89NZGiAa6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	w/AVsEZOLEOzQel4ofAOBLxRHrad0/HvjWfTqQtaeIo6RV5X8tZRIy4V54Eq9efcctF+Lnysxs3aE4jJS1g5GWL7L5bIgYotdEycCsDXTyVOItt1TZrijK7t3xg3An+edU99+If3RZBDVGiK517HBdrakXuK3iigOHSkNCqQ164+iPsO+xxo2k0ROhpB/D0S6dqA29SewB4wyulD3lU81rtV08pnfEVhtq0UN1msKSTJo1mt/wrkIC8nkXZS99Vx3sGJZAHcFeLPM0dv/djAemyEzsxjADbZgEXOdN4cgrQblx/m1/3stNg2FYrUFm+zVsaukilSvl+/eMkSt+xy47FQo751/18GUUXssbnqXHElbG1BJ8d5RYrq99rBdsoy9ogu3/3wgbJTeYER5hlqp1H+BqGbrRvUrqab5KrwwrplWZnEOzdTCJKO6lpeyZkkilYZTltSCw5nsLqwDMJpjT9JJiooyui/W5N4XcrfW9P3133adJPFnnU+B1beAlzPziL2WEDIwgkNjIWBkhWrRPceaZJnydFS2YKM6fK6Qn3cxZYGvT4wV/MsAR3p5f82lAfyS+gETV0BKZI7qUgIrVJX7TjWozYo5beZ0PSZvSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8223a37c-4c99-4dcf-488c-08dc442c2a7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:39:26.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbDKQ6GCNH3oywFEr0XMGSK9PfsHgCRbc+P2VqH0FhASWJaUQzCq5AAz7+aKxRLccweyMsL300xoQE3Mw9fcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140100
X-Proofpoint-GUID: p-I_-7wCSYvw51vWRwoOiESFC5gLlvl2
X-Proofpoint-ORIG-GUID: p-I_-7wCSYvw51vWRwoOiESFC5gLlvl2


And this one as well, for the review. Thx.


On 3/9/24 19:16, Anand Jain wrote:
> When attempting to exclusive open a device which has no exclusive open
> permission, such as a physical device associated with the flakey dm
> device, the open operation will fail, resulting in a mount failure.
> 
> In this particular scenario, we erroneously return -EINVAL instead of the
> correct error code provided by the bdev_open_by_path() function, which is
> -EBUSY.
> 
> Fix this, by returning error code from the bdev_open_by_path() function.
> With this correction, the mount error message will align with that of
> ext4 and xfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/volumes.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb0857cfbef2..8a35605822bf 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1191,6 +1191,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>   	struct btrfs_device *device;
>   	struct btrfs_device *latest_dev = NULL;
>   	struct btrfs_device *tmp_device;
> +	int ret_err = 0;
>   
>   	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
>   				 dev_list) {
> @@ -1205,9 +1206,15 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>   			list_del(&device->dev_list);
>   			btrfs_free_device(device);
>   		}
> +		if (ret_err == 0 && ret != 0)
> +			ret_err = ret;
>   	}
> -	if (fs_devices->open_devices == 0)
> +
> +	if (fs_devices->open_devices == 0) {
> +		if (ret_err)
> +			return ret_err;
>   		return -EINVAL;
> +	}
>   
>   	fs_devices->opened = 1;
>   	fs_devices->latest_dev = latest_dev;


