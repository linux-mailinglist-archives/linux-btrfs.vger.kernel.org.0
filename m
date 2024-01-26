Return-Path: <linux-btrfs+bounces-1820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E283D9ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 13:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B132833FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13F18626;
	Fri, 26 Jan 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ba5X5e4f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qeen30u3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12BB175AE
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270779; cv=fail; b=e7LVHkZoCwV6qMiE6+HTg2FvuMH39JfoV9MnkGm3DQ58h19NfW7pmnQbomAWwrrnorHu6PgJMxZrc174agNVU6lcI4Y4FBQRVl0OLBkEMTu7kHKhQTdkQRaNySKfAXs73UT1VGILz+S993kOeCmk0+gbR0next6Zd/sfF9Ycc3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270779; c=relaxed/simple;
	bh=fQFQuFK6xHYGcoUhHoLa3ZA7lkH4X2T9FYfw4SR4fQk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mp0SMtprzVQxXi62OHzjBOBurtAEpVtMJe9Xt1NkVMju37wOhPANjF++u16UfVySpjZAjcA/cTp6gsP77BnFQTlkQ6ICvy4g/WTmcJ1+rq7mGY81BfL8dNE7tVyyguzJ0vqRyk26pISiY2MmIqxUkEIZqsKAGNLYV6REkWWHy3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ba5X5e4f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qeen30u3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PN3N1D013701;
	Fri, 26 Jan 2024 12:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BF5fUhS+/5QUD2QWfrTsP3l2+8FmTM4iA2luwGeoZdQ=;
 b=ba5X5e4fXoMjEWkys5Iz45YwMWKhX4C63v9t7X9pbdmYR7ZWABd6j++pgtZGlWM6BLkh
 TW4pF7NiLufCJBzZL8uE+dJbt4sqduPfRyvmUzlTQxtTElbE6UbcaOj+telNL5Ltxs79
 UF95OTtN8fqh4Cg42rpOsYd4rbRUUaezSrR3lo9LFPlH6r6i8w0STpPsbRQaDAljcPuA
 /GOofRMIDUp/NJ4JtEiNYZzhKQTZyO61L8zL/TMq/0J5IfVSQAqqh6m+FCjoKa00Pfdw
 zp4Du5HW8Rdm8Fes7IOYr5y4J9Z7uMqIK1cy0rppn9uB9tGJXd2DqGcJSNYHczihyBsx ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7aca61q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 12:06:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QAlVIC026037;
	Fri, 26 Jan 2024 12:06:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs31a9jae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 12:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbPjq0bOVO1NAIGSfhszTuWOGYq/hHFm/9WW1Ib3HBvK9E/3a+RUhN2sgniyrLBS3qmMNlW/UkgoqEJwei5YAcpjW6dOkqYvG+FS2ZclRXxbsb+ZGqKrvZT0/oQY+Uh5KxEPZY94yzgmToRe8Trps0g79FGqSLk1GeStYaInC40GnoXH9SM6lLPacq62/Wj5O3Nfa0rPDNCX139Ukeny5G1MXHJB6b3ZwhZOEUtYlUYMfeeWwabbTzU+ZioqSVPdAiQQow2Ib9wiuYaGn8259uyQMihRGdroAbp5AporgN+8ZROQghalPKIWIRsrwSuOpiMrpw4u/LQ1Wi36aJ0TGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF5fUhS+/5QUD2QWfrTsP3l2+8FmTM4iA2luwGeoZdQ=;
 b=k+dOESRkLWhpIVwVN1EjbGew/vluYk62JH0gQCdJroLra4cy8s3srGkCdJ+LrOLhEQZAxWMQTW5OZWx9ZVmF0AFcETYk4M6to5cCu8LX6av2pfxtw0GXbLa6pTZFZUkaNtL8Xb5qyARjlsgvXL3qTYbo/EwqKjBP+/RbCWgbNGjSq24fMC+sr2ZSEW+JReG2ySxHijqv331DEmzCIHf41A+CZIjnznzyF8t2Xh35LP1mnESfdzmvYGJXf6ZUpaJcCO5C0cZeZcaJle7TFfhCqiC2PC3Suq0OJfDCXjNeCqxh+lVOy3iVY3ZgONlyJyIrJOKUId1qOfp3O8sq4V7VoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF5fUhS+/5QUD2QWfrTsP3l2+8FmTM4iA2luwGeoZdQ=;
 b=Qeen30u3DrVwyQVynpXqP5NKCLHUaj61Fc+zBSIwl4D0Zx7i0omhkuyHhuix1I/sp0F8WPhzLFID7Btz7v3cHQP+e8gC+kRJRJ4cgjQO6Seg5EdlMOyp33hc0CKCJMUmRCBwTkREBLCcLWNMiQjl8YDXAbXyIcxkjp3iucN55jc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA3PR10MB7043.namprd10.prod.outlook.com (2603:10b6:806:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 12:06:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 12:06:12 +0000
Message-ID: <9ee6b3bd-a409-4eda-bcd9-b0527b1b1b33@oracle.com>
Date: Fri, 26 Jan 2024 20:06:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] btrfs: handle invalid root reference found in
 btrfs_find_root()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA3PR10MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: dd071210-0c00-4e10-c885-08dc1e673038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kndgLrVfWPUcTBuEk8dc59v5toH/J+m6WC11UEkc9cfhwmjpI56DezkR8qRIKEK9D+V0rzKGspns1Pb3tHuPrK3qig7kO0Ovw2dAkcMx/l45OfAtDzJB9acHQVvK3Syik6EJmB/V1Y2zive8eS/0aXS1DOt3rp2nT4WCea7bZMCXt+KJmnuk6DWdvKdECaARUIkkpu2QFEVgQqtMSfI7V01NAA0irTkao5ZtV254ijEZbuYJQ+CvXxCZu9It2OTp2xIbiWf4eKHe7TjnfNYqQewezESgoIBhSIWYLqvG36IagFbxCqj/M6nmPZPIo31Ytm1Zc0mOVWukVx8IGPfgOJcayUezjxBhhygbe0+WB7qR4o5p6fNzPynrOyMPaQm5asEA21wfx6z68N2f/YwbDhrY70zccTxAjZsEE+NzwVlK/zDzy8LP9aeTCJrpe4snD0vWgdlv8bQpOAl+PJpjfJDlpf7ig0XUAnN6wxX8LpZ4eP2rNl9os683DNjl21TUnBYDx6XQshHF2XjNs8TyRdu5DNI22WRLRgDWFTSIzgxKhNhLsvrM0KMaNTBvqxIwK29u4vZIFl6lycKD8V5jw4/4saTWi7Mh3lHOWv2uub0cnPhx25/lS9KRetweqITUfU0ADaOepI1twEm5iI7g+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(86362001)(36756003)(31696002)(6506007)(38100700002)(41300700001)(2616005)(26005)(6512007)(66946007)(2906002)(66556008)(6486002)(66476007)(53546011)(8676002)(316002)(44832011)(6666004)(478600001)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3Q2SkdpVXp6Qnl4YnRudG5kRVhaTkp1VERaWGw4N2VOc05FcTRwR3VBWTBL?=
 =?utf-8?B?akdPd0dTcmdxeUtnZWFudUQ5MEJUVUkvOFJHTXAwYllkLzZMQ1VsdzhoK1FO?=
 =?utf-8?B?a1FNRjljRjJNSlJTb0tFM0hjK2VlblBZb1BtVEsyb0E1TUFmTWMyU3BIeGVa?=
 =?utf-8?B?TzV4MnlZdHh5MTIvN1d2d0I1UnVnWk5tRkk3YWVhcE9hVnZJRVdZL3pYc2FK?=
 =?utf-8?B?VStQUTM4RytoVU55UDVjL1JDWlNUZHpRc2gxL2g0WWNabVVzdnFtZ1BaWjdy?=
 =?utf-8?B?ckRvcmNIWVZVR085VmpmOCtSaTRJcVEzMUZ0M0p2ZlpkTldhMFBXcXkzVk5k?=
 =?utf-8?B?WTJKYnhkNytyM2tWN1kzWGpQdThKc2JrZ0RNdnZKRTQzNzV1Vnh3SE1hbVhm?=
 =?utf-8?B?SDhFTVUva3QxRUt5UVdkTm1Lc2VpQjFPM1JVZkd5OHhsNTFxM1VzRTcxYXpJ?=
 =?utf-8?B?eU5hTiswQ3ROS2Q1RWFXMnVTQ2t6V3lhVUpTQmVEUkdHTWpPbkR3eGV2RmIy?=
 =?utf-8?B?Nkd3aWJxNEpVL085Q25IeWVhTzVEVUQrcGtNc0NOREZkKy9nTlRJRS9LRklz?=
 =?utf-8?B?Y21kTHM2NnVEMHFpK2dScVRoYW1pQzhCVkFUMk9SMzN2QjhZNGRUckdkV2RD?=
 =?utf-8?B?cC9IVDdURzRGeDd3a1BIWTAvK0xZK2hQVG5BVVlWeGI0MDZUZTl3bkZDM3pZ?=
 =?utf-8?B?UEV2Z2ZKZm11ZDBxTk9hMEFWSGdmV1ZMcktjMHE0OGtKOWsrM29RMHpQWnhW?=
 =?utf-8?B?QnY3eWdXZ2dNZDV1UWQvZ0NnbExOVG9NTFhzUXIrK203Ym1tOEc1LzdxcHhL?=
 =?utf-8?B?M1VBdEpaYmhSR2t5RnZnTk45Umh4WDVBN25MdVY5bmpjSllDcU01N1pKMWRz?=
 =?utf-8?B?WXpHMENQbjl0VU5CMmxYczFTSktPMnZjcVpVdTkvSXNDMU1aczJrNk1iUjNy?=
 =?utf-8?B?YSs3NlFTMjNPZzQ0ZHduQnlEQ1lDQ2cxaDcyQStCR0JPU0lOK3orUStEbHA0?=
 =?utf-8?B?cTFYZk5wN05JdDdKclhoVXQxckhFK1dmUVRjM2lWU1JEOGc1a0kvS2w3a244?=
 =?utf-8?B?ZER2M1U4N1cxZWd6VUlMbWYxdi9Xb3R3ZWxwOGdXWmNydDZIVytITVdrNWZR?=
 =?utf-8?B?OVA4K2tkL3BySm04Tmp5VjVYdGtSa29wbXRHRXJ6VkRtSGJqMVp5RnFBbXhQ?=
 =?utf-8?B?Y2dsdnA3aUNkK2xVUkwrZThjK2xub1dlQk10bWtzeWg0V3llVmRQZWVlUjNU?=
 =?utf-8?B?cCtGbnhvMjgwZm9ueTAwWWxvV2ZrcmtsMmIvUHIwRFlzZ1Y3YjhXRnJWQzEy?=
 =?utf-8?B?RU12dFFFbVBPTWJkNEZNR2ZIZm12VTBvNjJlK0dZaVpNVmtDaTZMblZwREpK?=
 =?utf-8?B?LzBJUituVW14a0RCNk9jSGpldk5TNStodDNqbEdrS2JmZEhpK2g1dU5kR0xQ?=
 =?utf-8?B?RUpWQ3NwY1NZMlJYR3hTdTVGRmdyUjZEV25wZlhBd0FRcmtzN01YNzJ1OStM?=
 =?utf-8?B?aE4wVkJPSU1ubHN6L0dRUE9sb2VON0dwVm96RWkxMWhYTXcxaUhTV0FkL1BI?=
 =?utf-8?B?SGtnT216Q2lFZUdWRWNFdUNGUlZ3UTd4Qm1yenBqV3E1Zll4OU52bDJjK1hm?=
 =?utf-8?B?emdPcVd0cWZNeTBnTWpoK21pT2puRWdneVZWSisyQ1kyNWZBNnBrSVcrT0Yw?=
 =?utf-8?B?M0tuQ0VrNW9DWFY2Z1M2WGVDVWgxTzlhQXBOOGxTaExFVFBBckI0eXlEWUNw?=
 =?utf-8?B?Wk0rNW5FbTZaeVp0ckt2blNiSGRXUm1DalVKOGpXdXhKOXJPRmJJOXlob20y?=
 =?utf-8?B?ZGdLa2VQRWlOajBNdjd4c0NaeWxRYi9WRE1iYlU4TkhNRCtqOVlTTWRrc0t5?=
 =?utf-8?B?bWJ6U0ltdUpzUzRGTjEwNkRWUFpOREFkV1lQYlhJVU5lWlp2Y3lnR251aVQy?=
 =?utf-8?B?OURpZjF2YS9lUTAyUkQ0RFBqZ3hLMDFoam5uUnV6QXZaMmNVa09udWhWUjZT?=
 =?utf-8?B?cjRwMTdUcUh3dWVqYVZ1V29BUVk5Mm9pMS9XNUZIZDI5NU9jNXJaRHhnenhj?=
 =?utf-8?B?WjN4cUViQ2dSNGpSbFlCc1NBR1dxd3lUQzAxZFFzVk5PU2VpS0s3eFppdld1?=
 =?utf-8?Q?yrQ3WW4jnCVrTqQV6ycskYZuA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CSovwtVjmkM6RuBY0BUub8KxwxnqHJG+NWxuABcNIxTjO3Lugu3PUOB/WIPqkXCmLXb+1e91PSSXyG54r7BbFoUVdpuiq9ED3HwUlUSvKdSUW8FAFDNE6Qkt8ZKBsgQx4QTGAc/vFkKuJ9E1y0pjPzCMpJPXsYnwT2c2EkK10psUUgm67RHPLvEz7zr7eS9AQbUThXHBBw7RCiMAvK1JR8oj62Nnc6aRNlNp92GqoYwfxLRKXi0pjGZuyJE+cpb4UL4TGhXTr0kQRyIOS/ACqHC6O9ILNQME76Eyj+rDL/G5qk8CLQDdn7NAkpJUoW+DJmELVndMaGhdhBpIs/RZHQBdbwB2m8g5gzxNQfVh1Mns3h3Nz336Rfpsu7+OrtbgezN3KtwM5kTqmA/3O3x79LABMCwGByFwTilZyia77dQxibnM+VfCic+Vx9s32fmEV3F1Xm1aYbHl3o2qbGYMuHAHD/+6XPFaM2yKvEC7qfUAvGn/Lt2RS1h4DABq3PVpZPzPYisxdYmzRw03ztryJbP9wnyl8axx/Uy8AjDspbZMRhtskZc5aaFcaQmtjmfUVGyR3QT/vhDT4+tcpbPLoOUY0i8dQPtG08M1qvVk5EY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd071210-0c00-4e10-c885-08dc1e673038
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 12:06:12.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTAWFtkOcCdoi86FOCacXZF6RfhwxvXIaqIeQm4ZBSTjRVGq0wvSMiQUO/TwEe9MEh3McYbkc/jsEnc/Rb18iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=915 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260088
X-Proofpoint-GUID: Aw8YC-3HakLWonYe0B-2rL66J-YOPd5I
X-Proofpoint-ORIG-GUID: Aw8YC-3HakLWonYe0B-2rL66J-YOPd5I

On 1/25/24 05:18, David Sterba wrote:
> The btrfs_find_root() looks up a root by a key, allowing to do an
> inexact search when key->offset is -1.  It's never expected to find such
> item, as it would break allowed the range of a root id.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/root-tree.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index ba7e2181ff4e..326cd0d03287 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
>   		if (ret > 0)
>   			goto out;
>   	} else {
> -		BUG_ON(ret == 0);		/* Logical error */
> +		/*
> +		 * Key with offset -1 found, there would have to exist a root
> +		 * with such id, but this is out of the valid range.
> +		 */
> +		if (ret == 0) {
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
>   		if (path->slots[0] == 0)
>   			goto out;
>   		path->slots[0]--;


While here, why not also add an error message, especially for calls
from btrfs_read_roots() when the IGNOREBADROOTS is set, we ignore
the error and continue without the abort(). Including an error
message will provide more information about the bad root.

btrfs_read_roots()
::
  btrfs_read_tree_root() | btrfs_get_fs_root_commit_root() | 
load_global_roots_objectid()
  read_tree_root_path()
   btrfs_find_root()


Thanks, Anand

