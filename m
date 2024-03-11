Return-Path: <linux-btrfs+bounces-3190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC78785A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252F2B2095C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643F481C7;
	Mon, 11 Mar 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZR3hg5bZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SDU4BunR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D21405F9;
	Mon, 11 Mar 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175519; cv=fail; b=Mb8bNMXUyRuYLYMuKo/aG9DQ+eE4mQqjp6dDJiY5PZoZ9OTWmuocxEximBXz+4RdKkTIXyDaBcs6J7NlKzmH9POUBNEd1V6TUq8Kr30JNVjpzxsjFc9OmzKNFk2srf4eDAUqzq5FF0djrWRilBXx9JszYyG6i7WJNpwRsQ7/99I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175519; c=relaxed/simple;
	bh=CLoqtk1PDS+lcXLauwmVPrrenc1wpNwHsKnrV0yOB3s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lsNprVPwZEPc3Y5um+Vetl6ByoCMaXZhvjkzEDJqOAHZNu7RS4tMO/jJlMEtGf3Gbur73YB0MfBikQbIlWt45BL53mkadqAholezDC4KlYLyBQLfuqLLpSsbl6N9LPs5Qhm7K6Reg/MMVA6P03DUCxnkmuyT/3wVcPaKvAowQV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZR3hg5bZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SDU4BunR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG4qXo031669;
	Mon, 11 Mar 2024 16:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aK1NfjJVRR9nEKV6zRSOyD10CvwY+FhXiCvAT706Mes=;
 b=ZR3hg5bZyvYNF9e0canYvEHhzTmjIjRy2WOcAXvsfs0C7lvKvgADhIwgqURVYi84lG+J
 deyeufLSl08DqMQ3sZjxxEzJMpEUoByIoO3m/4JMPhwJv51jChFNKb5RjQiULy7aGIYn
 cdfK/UvF1Q4iCU3/Hampk6WWkcL0VqS68SWBKvkR3EyXyh5jFktM/cnMRGTcU+GHhCwd
 +xFTR7rnx+J8Qcq2c70CqZprsKWIyig+QTwJynAqVzsZE+3vWcl2/zeqnHFAwKO+p8zL
 RWc0/bdK2Hl3xhSRQkKcnMVqQoHEyVZC7gofUYPilcYqrCevrwCeftmBlabBx5+IdTjN WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec2bv7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:44:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BFnULb038287;
	Mon, 11 Mar 2024 16:44:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre760csu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGnvITvQg8GrvoXKO6WTcKmgcBom4e16rDbjy/RJLqxuSy1YHXQf1J77mMEk8d4fYzM2fPu2k9dpcS5GK/RdLCpYKZplPnEW1Z4EexRBJgyewYi2mThdJ5y+xBACttpLpwOedsAwasmuJDYpNeheCscAIZQZ9vH7RgJyLPH+VDox5M3idVT9By6U91CVn2sqvTabDf4jo5+esUPzt7b/u1ZFTgMsLD/jG/Q7r7BoBNq1sCMG7hUSkI/B15feCA2vUAecajuzQDaqKwDXL0nnn0eash53wygDkbOUa/gICblWN4I/KXQTEhZCbm8ZIASDRyYAzTW7DrAlYNkeZNPc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK1NfjJVRR9nEKV6zRSOyD10CvwY+FhXiCvAT706Mes=;
 b=A03RYFMHJnnWBf+eNPW3OzotgBxWIKB0bGSGxoaa/eliSCdb3mV6erXrKekDUbkcx1ty4O2Bo8/dOOXAus25h9SQVToVrBaxT9nVgj9Zj0nQ2Bl5/CdLyHBQDyCqbliMyw3o7m7H4V04+KX2Z7XkRKdyiGwrpZC7MCCB5xXFvFZPDwvqS14dnixiTc7X5EkAyTy1rLY82ewRG5e8pbNFeDxQ1xRSPN2fCWzyRSYJn9sGAnLUSfee4RuzfKaLhVl3YzBretuekoa1k+4bnIbZ2qyPmwrZB2uqcUzPZ1qoKIwdqlEG3kPrvT6WALishYi+U7pioH24Cte4cDlH3EhlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK1NfjJVRR9nEKV6zRSOyD10CvwY+FhXiCvAT706Mes=;
 b=SDU4BunR7RtpTmtkYPLWiOyUM1/KDDanGhV8J1JYWq4f8fk4YhLgXZ/8jqCHN+BJGfcBG70g19bEuwKm0Olu0jLQrUj14zXSuY7cWQ+OJTWtSII2nsjKJq8Trnxu702/uy9aWv4nyqQzZnORJQNeUNdfwPOTp2rFbEyYP5Rfu6o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 16:44:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:44:23 +0000
Message-ID: <5997ae6b-1214-4476-a75a-183e485b50b7@oracle.com>
Date: Mon, 11 Mar 2024 22:14:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: new test for devt change between mounts
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <9dde3b18f00a30cae78197c9069db503f720fe71.1709844612.git.boris@bur.io>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9dde3b18f00a30cae78197c9069db503f720fe71.1709844612.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf3ac87-d4dd-4d51-c2dd-08dc41ea815d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8u9gh+7k1+ZZkHXXnfFYQNmGB6+fRS/etVaEqNPz6E0Vh1SveC+IqvtGnVDrlIMpnnHXhfo6ns71VXALOj5aCFgATKjadQe3Ybx/3RzGQ6NoOj+ooFw7zrqKiBuL/5ZHPKXh5FOunmxGx+l0HM5Il/28N8s83xyhEoRD50PO9nx55eQ9nLWhVaWXfXsB2Ozwxa1UB7IuSOeCMtRKRRLCHduIkn2VigQYgIQwk4XQUuTXI+z0a3M2u2ftgtPmxDVth31V2eQcZ2UOSatJTvN9Vu7VBpXA1bAX7Kb8MP61QztCKFLWuisKeKFq1UajjM19rrDh0B3VR+HhuN5Ke+EksTH2JOlzgrCUpcAwYznW7hPDQ2XFf/12+E08Sl4lNLvCt3pxrOcXYtIjGTWJCd7rJjLwdEJWrE6/HyRC5MZiyTyh7UdPhcmIvRg0GrJ5UTU7GqoUmxhQ7MJpMrgDrgksoPwI9h9mY3Zni8FL1tRK/xwpEQQDhVvYEJxpuPflJLmFb4F2l1UPnWmhmLtTraUQ+24oxQO2zoio5j8Oemib0Pmlji97zExzdsfwbRoO+K8mzy6+TrkHOqoVlIHXEKDOTb6I1AcZmW4K/Lh1zOxIz4fadhaVjfpHkFoFBhVWXhGYui7sA/zp25GXivZhttQNaQqDJhpWPWkXxIrJQLT4REc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXd5a3A4cVp3ajRnbGZhT1dQbWxpNkp4ZjRUOXNLbVVIdm9oTXBrdzB0bmRJ?=
 =?utf-8?B?cGhLaEdCTnZsMXB5L3JEeEsyOTk4UTFDTC80aEFuZTRXa3hRY3NZRUc0aHVr?=
 =?utf-8?B?RHlNYkt0NVJRVld2V0pHUEROWURHcHRsMDBYU2U5MElEM2Y0eGIvelZxM1Ni?=
 =?utf-8?B?R3hGSXJ0amRaMVRLVm8vWFNSNEZRUFlkWTRRNFJIZmJvb3UxK01EeVBVYTFT?=
 =?utf-8?B?Ry9IZXNyMytBVDlseVB4NmJ5elliUXplOEUvV2tSNkU3aUFibFJWczVhME1U?=
 =?utf-8?B?M2UyT011dVpLTUg3UHlBMWRGcVUyNnhxc3A5OVQ3S0laOFc3OGdYVk5EMnp2?=
 =?utf-8?B?UktxYUpPRFAwaU1BNFZOeDJlRTlhSUpSWjJVRUNQVXJIcUJGRDQrU3BpdnhS?=
 =?utf-8?B?S1U5bmpvaHY5UDdDSzMzUjF1TU9HTEdMQ09zNEJUS3lmcGZyUG5rZlVyNmFi?=
 =?utf-8?B?UnovN1VTK3I5bHBWT1NoZjlEeXVHQzRqTk0yRVp6UGF3LytNaFRSWmJzeXJl?=
 =?utf-8?B?c3pXL09tR1F5K0dXVUY1aS9QVXc1cW5zZ0FIU0xlTXR3TUVrTS9TVXozYlFw?=
 =?utf-8?B?RnFyYmlKa001a2V3RVFoMGcvWFNiR2M1YUV6cFQ4MmF6Y2Yrc1pIM1lKRGdp?=
 =?utf-8?B?bnF1SVdmcDhYLzFkVlRYbzAxSlNMY0NNQlUzRWU2c0ZDWndSakVWYU81WDdY?=
 =?utf-8?B?RjZUU3NUTHVvM1BsUEY5eXh5L0VKcmEydzBicFM2bmVrYlZNb0VnZTZDV1dR?=
 =?utf-8?B?UFdobEFTYk9qOW9iUGljaWw2cFNZV01NZU5zZEJiSks0cXYvT1VlRUtTL09s?=
 =?utf-8?B?d0ZWOVltRDl2STBnYUZUQUxjenJ6Y1JVNFJZbStxdVJyeURPdDhrY1JKQXp5?=
 =?utf-8?B?MmtxMDZNcDBZK1JsR0FNQWJ6VlgxenE0bzlSd3BSOWNmYVo5Ykpvc0V4MDBD?=
 =?utf-8?B?OWdLMmZBa2RQZ3NMTVRWLzZnVm1JTEV3YUc2ZlNsSHBTa0djd2tweExXajRF?=
 =?utf-8?B?OTVTVm1kak82UGhURzhEWThuVENzaG9Cbzd0VzYrd3R0TGFJSjhYUHM3N0Za?=
 =?utf-8?B?VElyMlh5d3FqNjJhTVBvNGRzVDE1b2t0MCs0SmdKTFlYdmYvWkQrR0pyaEt2?=
 =?utf-8?B?dmgrbmVwNCtuM0pDdEFwUFlyaHFGNmIxSi9BWGRVOWx2VkROWDZ4Vm5IbVdY?=
 =?utf-8?B?alVYUTNLbXh0aFdIMlFMek03UERJZDF3Y3N4bk5odS9CenI2dkd0S0lkemVm?=
 =?utf-8?B?U1BVSFgvNWVXeElraWQzNDBnamF2aFRIc0tIbm82dkFNTkphY3ZsVk1RU2FG?=
 =?utf-8?B?Y2Jqb09wRTlIbXBxZzFERnRlT1pZNGJWZFFSbEVXd1RSUVUrMnBQcFR1TTc2?=
 =?utf-8?B?UXgxNTdyN0VPdE1VblR5S2NQKzFnSFBGUGlGczVMQVZ2TGsraldBNldJaS9X?=
 =?utf-8?B?K05MTGJROXF2Q0VpY3dTN3drKzhJK1V4SE9lZFhEOUFDYWlOUFRWRTl5KzJ6?=
 =?utf-8?B?M2FKb0Z1NFdlRnpYNE1NQk1Da1FOZUw0M3UyemgyT2R3bFphU0wycU5sc1NZ?=
 =?utf-8?B?OW5MT0QwN3B1MEM4SjdnTXJEQmc5S1NPWFRleE5vcXJTRnR3bDhWNTBjMkN6?=
 =?utf-8?B?N0lZVFM2dE9KR04vYzlwOFBJdm96TkJKTVdKNUw4YU1KaTNweWs2TW50VnR5?=
 =?utf-8?B?OFU2WU1ydnNGT1QxbUc1ZjN2d3dGaEVzeXJjS1JDZU5VMTZXU1dLNVJZYks5?=
 =?utf-8?B?UUlhSjRrZG9ORUM0SVhndks3bGhPalluYjZtb1ZFL0dITmQwVFZEMmhKRERH?=
 =?utf-8?B?Q3JFYVFJTThpSWlEM2NpNExWQXlzTXVJa2lUU1MzRWxYMmN1ZDZac0lHdVR0?=
 =?utf-8?B?c2dMOWVxdWI1TGhaTU1MbHlNckwxSUNQd1NaNjF3bXV3eUQ4dDhDdFJRRmRJ?=
 =?utf-8?B?TWZXZXBMeFVUSGRZQ3NWV2Y3dmo5eStEeFp5M0tFWWJoYlJPa2JidVlIZ253?=
 =?utf-8?B?Ny9mNWViOGtVK0VKdG9EdERVR0d0NndGekJIWEVLL25nNG8rbUZ2aDVMVWlm?=
 =?utf-8?B?VFMyTDE3WFVBN1BpK3pKMjd2aG04MEV0T3hrYUNaWFJhVytObHRpVEU4dXRx?=
 =?utf-8?B?d3pFNzhwY292TkQzVU0xeXlXdWlBelJ6QlRXaVEyeWJBUmRsS0JlTjhQR2hX?=
 =?utf-8?Q?Zik2qUwl7tlua2FRSO5vG1R+XuzUXC3sdXKN2YB5qOwQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6c1LDy5bP4iBzV5WbVoOxa6yzpmzrYWOEXDYioJ0KhOQwbu7ccyLzI61nU8g8Ag0bGV/Cx2RiKiCsnWH+ItMeteyXmNL+7KUnjHeTltjMv4aMAGyrTlmz1hsmLrsaMDqHxkrCmw0Q51sGdZWXUxYLhk8bYb1XXfj5x8nLE+bYHuxB+CbmxiepIdFuhIZOH0UeuEyYEK7ceLsMhY2MJagkAq1G6fHJGYQz0Y6Iyyg8c+bdFL/w5y1kx53BTmVWR+RhBE+L916j7FsPhTEMK+zTgzoWgSOfNE8vpEQXmvBDwL24TEW7a8kgI3lcVAXU/YYehM8fsxHLqII2VeVuPnPlYZogULse99gb2lZba1BbTb2qAojn94dWDhN6EJzbHFwmWVx1lZAcgGPfD6xcjD5v3dSaH3tfNnvtsaBcMD8xO+QMkMMsVzoGizldG7mqdf10Nxk+qJwWII7mh0fJb1w1Qvt99mlEuxrwcaMX93TyrTf+kDqssJBzHhFsCCg+xf6euctzqwr5NA29J5DWqQkb6dSmpto7sz2C4zr5CydcekxOMcCYt4OBKrMrx4BqnimTWl1w82oaWpoUTw1wDLn0o+bAVp5agbHk9BG8Vgluv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf3ac87-d4dd-4d51-c2dd-08dc41ea815d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:44:23.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zKYzU/zRMsLgixxSJH3dLgMl8/D+UCvVU7J5LEpo8V60vrgfAR0w6UMIV9Olpx/OfeZRZl1NKmd0of+jfqJYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110127
X-Proofpoint-ORIG-GUID: JBHv4vHIDdl-DsAuZ0K4-Vub837p1duP
X-Proofpoint-GUID: JBHv4vHIDdl-DsAuZ0K4-Vub837p1duP

On 3/8/24 23:13, Boris Burkov wrote:
> It is possible to confuse the btrfs device cache (fs_devices) by
> starting with a multi-device filesystem, then removing and re-adding a
> device in a way which changes its dev_t while the filesystem is
> unmounted. After this procedure, if we remount, then we are in a funny
> state where struct btrfs_device's "devt" field does not match the bd_dev
> of the "bdev" field. I would say this is bad enough, as we have violated
> a pretty clear invariant.
> 
> But for style points, we can then remove the extra device from the fs,
> making it a single device fs, which enables the "temp_fsid" feature,
> which permits multiple separate mounts of different devices with the
> same fsid. Since btrfs is confused and *thinks* there are different
> devices (based on device->devt), it allows a second redundant mount of
> the same device (not a bind mount!). This then allows us to corrupt the
> original mount by doing stuff to the one that should be a bind mount.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v3:
> - fstests convention improvements (helpers, output, comments, etc...)
> v2:
> - fix numerous fundamental issues, v1 wasn't really ready
> 
>   common/config       |   1 +
>   tests/btrfs/311     | 105 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/311.out |   2 +
>   3 files changed, 108 insertions(+)
>   create mode 100755 tests/btrfs/311
>   create mode 100644 tests/btrfs/311.out
> 
> diff --git a/common/config b/common/config
> index a3b15b96f..43b517fda 100644
> --- a/common/config
> +++ b/common/config
> @@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
>   export GZIP_PROG="$(type -P gzip)"
>   export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
>   export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> +export PARTED_PROG="$(type -P parted)"
>   
>   # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>   # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> new file mode 100755
> index 000000000..a7fa541c4
> --- /dev/null
> +++ b/tests/btrfs/311
> @@ -0,0 +1,105 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
> +#
> +# FS QA Test 311
> +#
> +# Test an edge case of multi device volume management in btrfs.
> +# If a device changes devt between mounts of a multi device fs, we can trick
> +# btrfs into mounting the same device twice fully (not as a bind mount). From
> +# there, it is trivial to induce corruption.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume scrub

Please add tmpfsid as well, because this test is about when not to 
activate the tmpfsid.

> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_command "$PARTED_PROG" parted
> +_require_batched_discard "$TEST_DIR"
> +

_fixed_by_kernel_commit XXXXXXXXXXXX \
		btrfs: validate device maj:min during open

> +_cleanup() {
> +	cd /
> +	$UMOUNT_PROG $MNT
> +	$UMOUNT_PROG $BIND
> +	losetup -d $DEV0
> +	losetup -d $DEV1
> +	losetup -d $DEV2
> +	rm $IMG0
> +	rm $IMG1
> +	rm $IMG2
> +}
> +
> +IMG0=$TEST_DIR/$$.img0
> +IMG1=$TEST_DIR/$$.img1
> +IMG2=$TEST_DIR/$$.img2
> +truncate -s 1G $IMG0
> +truncate -s 1G $IMG1
> +truncate -s 1G $IMG2
> +DEV0=$(losetup -f $IMG0 --show)
> +DEV1=$(losetup -f $IMG1 --show)
> +DEV2=$(losetup -f $IMG2 --show)
> +D0P1=$DEV0"p1"
> +D1P1=$DEV1"p1"
> +MNT=$TEST_DIR/mnt
> +BIND=$TEST_DIR/bind
> +
> +# Setup partition table with one partition on each device.
> +$PARTED_PROG $DEV0 'mktable gpt' --script
> +$PARTED_PROG $DEV1 'mktable gpt' --script
> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> +
> +# mkfs with two devices to avoid clearing devices on close
> +# single raid to allow removing DEV2.
> +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 >>$seqres.full 2>&1 || _fail "failed to mkfs.btrfs"

Error out is already sufficient here.

> +
> +# Cycle mount the two device fs to populate both devices into the
> +# stale device cache.
> +mkdir -p $MNT
> +_mount $D0P1 $MNT
> +$UMOUNT_PROG $MNT
> +
> +# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
> +$PARTED_PROG $DEV0 'rm 1' --script
> +$PARTED_PROG $DEV1 'rm 1' --script
> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> +
> +# Mount with mismatched dev_t!
> +_mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dangerous stuff on raw mount point"
> +

On a system where the kernel bug is fixed, the mount is expected to pass.

On a system without the kernel bug fix, the mount is still expected to pass.

However, the failure message indicates that it is advisable to fail the 
mount in this scenario.

I believe this will be the case once the btrfs-progs patch below is 
integrated:

[PATCH 0/2] btrfs-progs: forget removed devices

So, we need to update the test case logic based on whether the above 
btrfs-progs patch is integrated.


> +# Remove the extra device to bring temp-fsid back in the fray.
> +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> +
> +# Create the would be bind mount.
> +mkdir -p $BIND
> +_mount $D0P1 $BIND
> +mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
> +bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
> +# If they're different, we are in trouble.
> +[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
> +


> +# Now really prove it by corrupting the first mount with the second.
> +for i in $(seq 20); do
> +	$XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >>$seqres.full 2>&1
> +done
> +for i in $(seq 20); do
> +	$XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >>$seqres.full 2>&1
> +done
> +

> +# sync so that we really write the large file data out to the shared device
> +sync
> +
> +# now delete from one view of the shared device
> +find $BIND -type f -delete
> +# sync so that fstrim definitely has deleted data to trim
> +sync
> +# This should blow up both mounts, if the writes somehow didn't overlap at all.
> +$FSTRIM_PROG $BIND
> +# drop caches to improve the odds we read from the corrupted device while scrubbing.
> +echo 3 > /proc/sys/vm/drop_caches
> +$BTRFS_UTIL_PROG scrub start -B $MNT | grep "Error summary:"
> +


The rest appears to be fine.

Question: Why didn't you choose a cp --reflink=always across $MNT and 
$BIND to prove how kernel think about $MNT and $BIND.

Thanks, Anand

> +status=0
> +exit
> diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
> new file mode 100644
> index 000000000..70a6db809
> --- /dev/null
> +++ b/tests/btrfs/311.out
> @@ -0,0 +1,2 @@
> +QA output created by 311
> +Error summary:    no errors found


